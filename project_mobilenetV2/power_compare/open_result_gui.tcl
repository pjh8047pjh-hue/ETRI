# Open one routed pointwise comparison result directly in the Vivado GUI.
# This does not open or modify project_mobilenetV2.xpr and does not rerun
# synthesis or implementation.

if {$argc != 1} {
    puts "ERROR: use mac_accum or cascade"
    return -code error
}

set variant [lindex $argv 0]
# Keep the spelling of the source path. On this Windows setup, normalizing the
# Documents junction can resolve to a different path than the actual workspace.
set here    [file dirname [info script]]

if {$variant eq "mac_accum"} {
    set dcp [file join $here results mac_accum mac_accum_routed.dcp]
} elseif {$variant eq "cascade"} {
    set dcp [file join $here results cascade cascade_routed.dcp]
} else {
    puts "ERROR: unknown variant '$variant'"
    return -code error
}

if {![file exists $dcp]} {
    puts "ERROR: routed checkpoint not found: $dcp"
    return -code error
}

# A routed OOC checkpoint has no package-pin connectivity. Vivado otherwise
# repeats this irrelevant port-connectivity warning for the wide data buses.
set_msg_config -id {Power 33-294} -suppress

open_checkpoint $dcp

# Named reports appear in the Vivado Results/Reports area.
report_utilization -name ${variant}_utilization
report_timing_summary -delay_type min_max -max_paths 10 \
    -name ${variant}_timing
report_power -hier all -name ${variant}_power
report_drc -name ${variant}_drc

puts "REVIEW_READY: $variant"
puts "Open the Power, Timing, Utilization, and DRC report tabs in Vivado."
