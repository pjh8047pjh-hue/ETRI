# Debug helper for a stalled PS VIP AXI GPIO transaction.
run 3 us
puts "--- wrapper GPIO AXI debug at [current_time] ---"
foreach sig {
  /tb_design_1_wrapper_gpio/dut/design_1_i/rst_ps8_0_99M_peripheral_aresetn
  /tb_design_1_wrapper_gpio/dut/design_1_i/zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWVALID
  /tb_design_1_wrapper_gpio/dut/design_1_i/zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_AWREADY
  /tb_design_1_wrapper_gpio/dut/design_1_i/zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WVALID
  /tb_design_1_wrapper_gpio/dut/design_1_i/zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_WREADY
  /tb_design_1_wrapper_gpio/dut/design_1_i/zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BVALID
  /tb_design_1_wrapper_gpio/dut/design_1_i/zynq_ultra_ps_e_0_M_AXI_HPM0_LPD_BREADY
  /tb_design_1_wrapper_gpio/dut/design_1_i/xlslice_1_Dout
} {
  puts "$sig = [get_value $sig]"
}
quit
