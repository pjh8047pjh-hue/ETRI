`timescale 1ns/1ps

// End-to-end board-wrapper test.
// Verifies that a PS AXI-GPIO start command reaches the core and that the
// completed core later returns done=1 and a result through GPIO2 to the PS.
module tb_design_1_wrapper_gpio_done;

  localparam logic [39:0] AXI_GPIO_BASE  = 40'h00_A000_0000;
  localparam logic [39:0] AXI_GPIO2_DATA = AXI_GPIO_BASE + 40'h8;
  localparam logic [13:0] CHECK_ADDR     = 14'd37;

  // Zynq PS VIP read_data() returns storage for up to 128 bytes.
  logic [1023:0] axi_read_data;
  logic [1:0]    axi_resp;
  logic [31:0]   gpio_in;
  integer        poll_count;

`ifdef GPIO_DIAG
  logic start_core_seen;

  always @(posedge dut.design_1_i.mobilenetV2_0.inst.clk) begin
    if (dut.design_1_i.mobilenetV2_0.inst.start_core)
      start_core_seen <= 1'b1;
  end

  // Uses the identical PS VIP GPIO transactions as the full test, then stops
  // before the neural-network pipeline completes to localize a missing done.
  initial begin
    start_core_seen = 1'b0;
`ifdef GPIO_DIAG_250US
    #250_000;
`else
    #10_000;
`endif
`ifdef GPIO_DIAG_250US
    // Capture the actual 128-bit PS VIP read return while the core done flag
    // is known high, so the GPIO2 lane mapping is checked without polling.
    gpio2_read(gpio_in);
    $display("GPIO2_RAW: core_port_done=%b concat=%05h gpio_input=%05h data=%032h selected=%08h",
      dut.design_1_i.mobilenetV2_0_done,
      dut.design_1_i.xlconcat_0_dout,
      dut.design_1_i.axi_gpio_0.gpio2_io_i,
      axi_read_data[127:0], gpio_in);
`endif
    $display("GPIO_DIAG: rst_core=%b start_core_seen=%b pw1_busy=%b pw1_run=%b slot=%0d pair=%0d pw1_done=%b depth_valid=%b bram_write_done=%b result_valid=%b result_addr=%0d results_ready=%b",
      dut.design_1_i.mobilenetV2_0.inst.rst_core,
      start_core_seen,
      dut.design_1_i.mobilenetV2_0.inst.u_pointwise_before_depth.busy,
      dut.design_1_i.mobilenetV2_0.inst.u_pointwise_before_depth.run,
      dut.design_1_i.mobilenetV2_0.inst.u_pointwise_before_depth.slot_cnt,
      dut.design_1_i.mobilenetV2_0.inst.u_pointwise_before_depth.channel_pair_cnt,
      dut.design_1_i.mobilenetV2_0.inst.pointwise_before_depth_done,
      dut.design_1_i.mobilenetV2_0.inst.depthwise_output_valid,
      dut.design_1_i.mobilenetV2_0.inst.write_done,
      dut.design_1_i.mobilenetV2_0.inst.result_write_valid,
      dut.design_1_i.mobilenetV2_0.inst.result_wr_addr,
      dut.design_1_i.mobilenetV2_0.inst.results_ready);
    $finish;
  end
`endif

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
      // Retire the 128-bit-to-AXI-Lite conversion before the next access.
      repeat (2) @(posedge dut.design_1_i.zynq_ultra_ps_e_0_pl_clk0);
    end
  endtask

  task automatic gpio2_read(output logic [31:0] value);
    begin
      axi_read_data = '0;
      // Vivado 2020.2 PS VIP mishandles a read starting at byte offset 8 of
      // its 128-bit HPM beat.  Read one aligned beat, then select DATA2.
      dut.design_1_i.zynq_ultra_ps_e_0.inst.read_data(
        AXI_GPIO_BASE, 16, axi_read_data, axi_resp
      );
      if (axi_resp != 2'b00)
        $fatal(1, "AXI GPIO2 read failed: response=%b", axi_resp);
      // GPIO2_DATA is at base + 8, i.e. lane 2 of the aligned beat.
      value = axi_read_data[95:64];
      repeat (2) @(posedge dut.design_1_i.zynq_ultra_ps_e_0_pl_clk0);
    end
  endtask

  initial begin
    // Bring up the PS VIP, PL clock/reset controller, and accelerator clock.
    // Suppress per-poll VIP diagnostics; pass/fail messages remain visible.
    dut.design_1_i.zynq_ultra_ps_e_0.inst.set_debug_level_info(1'b0);
    dut.design_1_i.zynq_ultra_ps_e_0.inst.por_srstb_reset(1'b0);
    dut.design_1_i.zynq_ultra_ps_e_0.inst.fpga_soft_reset(4'hf);
    #200;
    dut.design_1_i.zynq_ultra_ps_e_0.inst.por_srstb_reset(1'b1);
    #200;
    dut.design_1_i.zynq_ultra_ps_e_0.inst.fpga_soft_reset(4'h0);
    wait (dut.design_1_i.mobilenetV2_0.inst.clk_locked === 1'b1);
    wait (dut.design_1_i.rst_ps8_0_99M_peripheral_aresetn === 1'b1);
    repeat (4) @(posedge dut.design_1_i.zynq_ultra_ps_e_0_pl_clk0);

    // GPIO[1]=reset, GPIO[0]=start, GPIO[15:2]=result address.
    gpio_write({16'd0, CHECK_ADDR, 2'b10});
    gpio_write({16'd0, CHECK_ADDR, 2'b00});
    repeat (5) @(posedge dut.design_1_i.mobilenetV2_0.inst.clk);

    // Start via PS AXI GPIO, then return GPIO[0] low as software does.
    gpio_write({16'd0, CHECK_ADDR, 2'b01});
    repeat (5) @(posedge dut.design_1_i.mobilenetV2_0.inst.clk);
    gpio_write({16'd0, CHECK_ADDR, 2'b00});

`ifdef GPIO_DIAG
    // The diagnostic process emits the state and calls $finish; do not add
    // AXI polling traffic while taking that checkpoint.
    wait (1'b0);
`else
    // GPIO2_DATA[16] is done; GPIO2_DATA[15:0] is the selected result.
    poll_count = 0;
    gpio_in = '0;
    while (gpio_in[16] !== 1'b1) begin
      gpio2_read(gpio_in);
      poll_count = poll_count + 1;
      // The accelerator takes about 193 us in the direct-core test.  There is
      // no value in issuing thousands of AXI-Lite reads while it runs; sample
      // GPIO2 periodically and keep the PS-to-GPIO verification realistic.
      if (gpio_in[16] !== 1'b1)
        #10_000;
    end

    if (dut.design_1_i.mobilenetV2_0_done !== 1'b1)
      $fatal(1, "GPIO2 done=1 but the core done output is not asserted");
    if (gpio_in[15:0] !== dut.design_1_i.mobilenetV2_0_result)
      $fatal(1, "GPIO2 result does not match the core result");

    $display("PASS: GPIO2 done=1 after %0d polls, result_addr=%0d, result=0x%04h",
             poll_count, CHECK_ADDR, gpio_in[15:0]);
    $finish;
`endif
  end

  // Direct-core verification previously completes near 193 us.  Allow margin
  // for PS VIP and AXI-GPIO polling while flagging a missing done signal.
`ifndef GPIO_DIAG
  initial begin
    #400_000;
    $fatal(1, "Timeout: GPIO2 done never asserted within 400 us");
  end
`endif

endmodule
