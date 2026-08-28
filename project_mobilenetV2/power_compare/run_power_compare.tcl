# Standalone OOC implementation for a fair pointwise datapath comparison.
# This script does not open or modify project_mobilenetV2.xpr.

if {$argc != 1} {
    puts "ERROR: use: vivado -mode batch -source run_power_compare.tcl -tclargs mac_accum|cascade"
    exit 2
}

set variant [lindex $argv 0]
set here    [file dirname [info script]]
set root    [file dirname $here]
set srcroot [file join $root project_mobilenetV2.srcs sources_1]
set outdir  [file join $here results $variant]
set part    xczu3eg-sbva484-1-e
set period  2.500

file mkdir $outdir
create_project -in_memory pw_power_${variant} -part $part

# Vivado 2020.2 can race while deleting its realtime synthesis temporary
# directory on Windows.  A single worker avoids that tool-only failure and
# makes the two runs deterministic.
set_param general.maxThreads 1

if {$variant eq "mac_accum"} {
    read_verilog -sv [file join $here pw_mac_accum_core.sv]
    set top pw_mac_accum_core
} elseif {$variant eq "cascade"} {
    foreach ip {dsp48_first_point dsp48_middle_point dsp48_last_point} {
        read_ip [file join $here generated_ip $ip ${ip}.xci]
    }
    read_verilog -sv [file join $srcroot new pointwise_after_depth.sv]
    set top pointwise_after_depth
} else {
    puts "ERROR: unknown variant '$variant'"
    exit 2
}

synth_design -top $top -part $part -mode out_of_context -flatten_hierarchy rebuilt
create_clock -name clk -period $period [get_ports clk]

# Apply identical vectorless input activity to both designs.  12.5 means
# 12.5% toggles per clock cycle; internal activity is propagated by Vivado.
set data_ports [get_ports -regexp {^(input_data|weight_data)\[[0-9]+\]$}]
set_switching_activity -static_probability 0.5 -toggle_rate 12.5 $data_ports
set_switching_activity -static_probability 0.5 -toggle_rate 12.5 [get_ports bias_data*]
set_switching_activity -static_probability 0.5 -toggle_rate 25.0 \
    [get_ports {first last last_all}]
set_switching_activity -static_probability 0.0 -toggle_rate 0.0 [get_ports rst]

opt_design
place_design
phys_opt_design
route_design

write_checkpoint -force [file join $outdir ${variant}_routed.dcp]
report_utilization -hierarchical -file [file join $outdir utilization.rpt]
report_timing_summary -delay_type min_max -max_paths 10 \
    -file [file join $outdir timing_summary.rpt]
report_power -hier all -file [file join $outdir power.rpt]
report_drc -file [file join $outdir drc.rpt]

puts "POWER_COMPARE_DONE variant=$variant outdir=$outdir"
