# Runs the wrapper-level PS VIP / AXI GPIO smoke test without saving changes
# to the .xpr.  Invoke from Vivado Tcl shell or with:
#   vivado -mode batch -source verification/run_wrapper_gpio_verify.tcl

set repo_dir [file normalize [file join [file dirname [info script]] ..]]
open_project [file join $repo_dir project_mobilenetV2.xpr]

# Use an independent output directory so an open Vivado GUI using sim_1 is
# never disturbed.  The project is intentionally not saved by this script.
if {[llength [get_filesets -quiet sim_wrapper_gpio]] == 0} {
  create_fileset -simset sim_wrapper_gpio
  foreach source_file [get_files -of_objects [get_filesets sim_1]] {
    add_files -fileset sim_wrapper_gpio $source_file
  }
  add_files -fileset sim_wrapper_gpio [file join $repo_dir verification tb_design_1_wrapper_gpio.sv]
}
set_property top tb_design_1_wrapper_gpio [get_filesets sim_wrapper_gpio]
set_property xsim.elaborate.mt_level 4 [get_filesets sim_wrapper_gpio]
launch_simulation -simset sim_wrapper_gpio
run all
close_sim
close_project
