`timescale 1ns/1ps

// Board-wrapper smoke test.
//
// This test drives AXI GPIO through the Zynq UltraScale+ PS VIP instead of
// directly driving mobilenetV2's rst/start ports.  It verifies the path used
// on the board: PS M_AXI_HPM0_FPD -> AXI GPIO -> slices -> mobilenetV2 CDC.
//
// AXI GPIO register map (base 0xA000_0000):
//   GPIO_DATA [0]    : start
//   GPIO_DATA [1]    : active-high accelerator reset
//   GPIO_DATA [15:2] : result address
//   GPIO2_DATA [16]  : done, GPIO2_DATA [15:0] : result
module tb_design_1_wrapper_gpio;

  // 40-bit PS address: 0x00_A000_0000 (the AXI GPIO is at 0xA000_0000).
  localparam logic [39:0] AXI_GPIO_BASE = 40'h00_A000_0000;
  localparam logic [39:0] AXI_GPIO2_DATA = AXI_GPIO_BASE + 40'h8;
  localparam logic [31:0] GPIO_RESET    = 32'h0000_0002;
  localparam logic [13:0] CHECK_ADDR    = 14'd37;

  logic [1023:0] axi_read_data;
  logic [1:0]    axi_resp;

  design_1_wrapper dut ();

  task automatic gpio_write(input logic [31:0] value);
    logic [1023:0] write_data;
    begin
      write_data = '0;
      write_data[31:0] = value;
      dut.design_1_i.zynq_ultra_ps_e_0.inst.write_data(
        AXI_GPIO_BASE, 4, write_data, axi_resp
      );
      if (axi_resp != 2'b00)
        $fatal(1, "AXI GPIO write failed: response=%b value=0x%08h", axi_resp, value);

      // The ZynqMP VIP's 128-bit-to-AXI-Lite conversion needs two 100 MHz
      // cycles to retire a completed write before accepting the next one.
      repeat (2) @(posedge dut.design_1_i.zynq_ultra_ps_e_0_pl_clk0);
    end
  endtask

  task automatic gpio_read(output logic [31:0] value);
    begin
      axi_read_data = '0;
      dut.design_1_i.zynq_ultra_ps_e_0.inst.read_data(
        AXI_GPIO2_DATA, 4, axi_read_data, axi_resp
      );
      if (axi_resp != 2'b00)
        $fatal(1, "AXI GPIO read failed: response=%b", axi_resp);
      value = axi_read_data[31:0];
    end
  endtask

  task automatic gpio_read_control(output logic [31:0] value);
    begin
      axi_read_data = '0;
      dut.design_1_i.zynq_ultra_ps_e_0.inst.read_data(
        AXI_GPIO_BASE, 4, axi_read_data, axi_resp
      );
      if (axi_resp != 2'b00)
        $fatal(1, "AXI GPIO control read failed: response=%b", axi_resp);
      value = axi_read_data[31:0];
    end
  endtask

  logic [31:0] gpio_in;
  logic [31:0] gpio_control;
  logic [31:0] control_word;
  logic        start_seen;

  initial begin
    // Reset the PS VIP and its PL-facing reset controller first.  This is the
    // order used by hardware: clock/reset infrastructure is live before the
    // accelerator's GPIO reset is released.
    dut.design_1_i.zynq_ultra_ps_e_0.inst.por_srstb_reset(1'b0);
    dut.design_1_i.zynq_ultra_ps_e_0.inst.fpga_soft_reset(4'hf);
    #200;
    dut.design_1_i.zynq_ultra_ps_e_0.inst.por_srstb_reset(1'b1);
    #200;
    dut.design_1_i.zynq_ultra_ps_e_0.inst.fpga_soft_reset(4'h0);

    // Do not release accelerator reset until clk_wiz has locked.
    wait (dut.design_1_i.mobilenetV2_0.inst.clk_locked === 1'b1);
    wait (dut.design_1_i.rst_ps8_0_99M_peripheral_aresetn === 1'b1);
    repeat (4) @(posedge dut.design_1_i.zynq_ultra_ps_e_0_pl_clk0);

    // Assert GPIO reset, then program result address while reset is asserted.
    gpio_write(GPIO_RESET);
    gpio_read_control(gpio_control);
    if (gpio_control[15:0] !== GPIO_RESET[15:0])
      $fatal(1, "AXI GPIO control register mismatch: expected 0x%04h got 0x%04h",
             GPIO_RESET[15:0], gpio_control[15:0]);
    repeat (2) @(posedge dut.design_1_i.zynq_ultra_ps_e_0_pl_clk0);
    if (dut.design_1_i.xlslice_1_Dout !== 1'b1)
      $fatal(1, "GPIO reset did not reach the wrapper slice (gpio=0x%04h slice=%b)",
             gpio_control[15:0], dut.design_1_i.xlslice_1_Dout);

    control_word = {16'd0, CHECK_ADDR, 2'b10};
    gpio_write(control_word);
    #100;
    if (dut.design_1_i.xlslice_2_Dout !== CHECK_ADDR)
      $fatal(1, "result_addr mismatch: expected %0d got %0d",
             CHECK_ADDR, dut.design_1_i.xlslice_2_Dout);
    if (dut.design_1_i.mobilenetV2_0.inst.rst_core !== 1'b1)
      $fatal(1, "core reset was not synchronized after GPIO write");

    // Release reset and pulse start entirely via the AXI GPIO data register.
    gpio_write({16'd0, CHECK_ADDR, 2'b00});
    repeat (5) @(posedge dut.design_1_i.mobilenetV2_0.inst.clk);
    if (dut.design_1_i.mobilenetV2_0.inst.rst_core !== 1'b0)
      $fatal(1, "core reset did not deassert after CDC synchronization");
    if (dut.design_1_i.mobilenetV2_0.inst.result_addr_core !== CHECK_ADDR)
      $fatal(1, "result address did not cross the CDC boundary");

    start_seen = 1'b0;
    fork
      begin
        @(posedge dut.design_1_i.mobilenetV2_0.inst.start_core);
        start_seen = 1'b1;
      end
    join_none
    gpio_write({16'd0, CHECK_ADDR, 2'b01});
    repeat (5) @(posedge dut.design_1_i.mobilenetV2_0.inst.clk);
    if (!start_seen)
      $fatal(1, "core start pulse did not arrive after GPIO CDC synchronization");
    disable fork;

    gpio_write({16'd0, CHECK_ADDR, 2'b00});
    repeat (5) @(posedge dut.design_1_i.mobilenetV2_0.inst.clk);
    if (dut.design_1_i.mobilenetV2_0.inst.start_core !== 1'b0)
      $fatal(1, "core start did not deassert after GPIO CDC synchronization");

    // GPIO2 is an input channel.  A read proves the PS can observe the
    // board-visible {done,result} return path without peeking into the core.
    gpio_read(gpio_in);
    if (gpio_in[16] !== dut.design_1_i.mobilenetV2_0_done)
      $fatal(1, "GPIO2 done bit does not match accelerator done");
    if (gpio_in[15:0] !== dut.design_1_i.mobilenetV2_0_result)
      $fatal(1, "GPIO2 result bits do not match accelerator result");

    $display("PASS: PS VIP -> AXI GPIO -> wrapper slices -> CDC -> core verified");
    $finish;
  end

  initial begin
    #100_000;
    $fatal(1, "Timeout: wrapper GPIO smoke test did not complete");
  end

endmodule
