# Captures the accelerator progress if PS GPIO2 polling does not see done.
run 250 us
puts "--- wrapper done-path debug at [current_time] ---"
foreach sig {
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0_done
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0/inst/results_ready
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0/inst/start_core
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0/inst/pointwise_before_depth_done
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0/inst/write_done
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0/inst/result_write_valid
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0/inst/result_wr_addr
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0/inst/u_pointwise_before_depth/busy
  /tb_design_1_wrapper_gpio_done/dut/design_1_i/mobilenetV2_0/inst/u_pointwise_before_depth/run
} {
  puts "$sig = [get_value $sig]"
}
quit
