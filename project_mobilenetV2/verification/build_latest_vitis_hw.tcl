# Rebuild the hardware from the current RTL and export a bitstream-bearing XSA
# at the path already referenced by the Vitis launch configuration.
set repo_dir [file normalize [file join [file dirname [info script]] ..]]
set xpr_file [file join $repo_dir project_mobilenetV2.xpr]
set xsa_files [list \
  [file join $repo_dir mobilenetV2_platform hw mobilenetV2_hw.xsa] \
  [file join $repo_dir mobilenetV2_platform export mobilenetV2_platform hw mobilenetV2_hw.xsa]]
set implementation_bit [file join $repo_dir project_mobilenetV2.runs impl_1 design_1_wrapper.bit]
set vitis_launch_bit [file join $repo_dir mobilenetV2_test _ide bitstream mobilenetV2_hw.bit]
set rtl_source [file join $repo_dir project_mobilenetV2.srcs sources_1 new mobilenetV2.sv]
set ip_shared_sources [list \
  [file join $repo_dir project_mobilenetV2.gen sources_1 bd design_1 ipshared 222e project_mobilenetV2.srcs sources_1 new mobilenetV2.sv] \
  [file join $repo_dir project_mobilenetV2.ip_user_files bd design_1 ipshared 222e project_mobilenetV2.srcs sources_1 new mobilenetV2.sv]]

# The block design synthesizes this packaged custom IP from its generated
# ipshared copy, not directly from project_mobilenetV2.srcs.  Keep both shared
# copies synchronized before invalidating the OOC checkpoint.
foreach ip_shared_source $ip_shared_sources {
  file mkdir [file dirname $ip_shared_source]
  file copy -force $rtl_source $ip_shared_source
}

open_project $xpr_file
update_compile_order -fileset sources_1

# This custom IP's cache key does not change when the copied HDL changes.
# Disable cache reads so the OOC DCP is built from the synchronized source.
config_ip_cache -disable_cache

# A completed custom-IP OOC run can otherwise survive a top-level reset and
# silently place stale RTL in a newly timestamped bitstream.
set core_run design_1_mobilenetV2_0_0_synth_1
reset_run $core_run
reset_run synth_1
launch_runs $core_run -jobs 4
wait_on_run $core_run

if {![string match "*Complete*" [get_property STATUS [get_runs $core_run]]]} {
  error "$core_run did not complete: [get_property STATUS [get_runs $core_run]]"
}

launch_runs impl_1 -to_step write_bitstream -jobs 4
wait_on_run impl_1

if {[get_property STATUS [get_runs impl_1]] ne "write_bitstream Complete!"} {
  error "impl_1 did not complete: [get_property STATUS [get_runs impl_1]]"
}

# Vitis 2020.2's saved launch configuration programs this private copy.
# Update it explicitly so Launch on Hardware cannot load an older core.
file mkdir [file dirname $vitis_launch_bit]
file copy -force $implementation_bit $vitis_launch_bit

foreach xsa_file $xsa_files {
  file mkdir [file dirname $xsa_file]
  write_hw_platform -fixed -include_bit -force -file $xsa_file
  puts "VITIS_XSA_READY: $xsa_file"
}
close_project
