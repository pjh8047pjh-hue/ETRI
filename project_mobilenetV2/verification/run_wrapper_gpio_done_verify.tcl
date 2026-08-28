# Run the full PS VIP -> AXI GPIO -> accelerator -> GPIO2 done test in an
# isolated simulation fileset.  The project is not intentionally saved.
set repo_dir [file normalize [file join [file dirname [info script]] ..]]
open_project [file join $repo_dir project_mobilenetV2.xpr]
set quick_diag [expr {[llength $argv] > 0 && [lindex $argv 0] eq "quick"}]

if {[llength [get_filesets -quiet sim_wrapper_gpio_done]] == 0} {
  create_fileset -simset sim_wrapper_gpio_done
  foreach source_file [get_files -of_objects [get_filesets sim_1]] {
    add_files -fileset sim_wrapper_gpio_done $source_file
  }
}

set done_tb [file join $repo_dir verification tb_design_1_wrapper_gpio_done.sv]
if {[llength [get_files -quiet $done_tb]] == 0} {
  add_files -fileset sim_wrapper_gpio_done $done_tb
}

set_property top tb_design_1_wrapper_gpio_done [get_filesets sim_wrapper_gpio_done]
set_property xsim.elaborate.mt_level 4 [get_filesets sim_wrapper_gpio_done]
if {$quick_diag} {
  set_property verilog_define {GPIO_DIAG} [get_filesets sim_wrapper_gpio_done]
} elseif {[llength $argv] > 0 && [lindex $argv 0] eq "stage"} {
  set_property verilog_define {GPIO_DIAG GPIO_DIAG_250US} [get_filesets sim_wrapper_gpio_done]
} else {
  set_property verilog_define {} [get_filesets sim_wrapper_gpio_done]
}
launch_simulation -simset sim_wrapper_gpio_done
run all
close_sim
close_project
