# Run one PARALLEL_CH point through Vivado without modifying pointwise_conv.xpr.
#
# argv:
#   0: PARALLEL_CH
#   1: output directory
#   2: target clock period in ns
#   3: stage (synth or impl)
#   4: keep routed DCP (0 or 1)
#   5: maximum Vivado threads

proc write_status {path entries} {
    set fd [open $path w]
    foreach {key value} $entries {
        regsub -all {[\r\n=]} $value {_} clean_value
        puts $fd "$key=$clean_value"
    }
    close $fd
}

proc require_file {path} {
    if {![file isfile $path]} {
        error "required file does not exist: $path"
    }
}

proc run_point {parallel out_dir period_ns stage keep_dcp threads} {
    if {![string is integer -strict $parallel] || $parallel < 1 || $parallel > 64} {
        error "PARALLEL_CH must be an integer in the range 1..64"
    }
    if {[expr {64 % $parallel}] != 0} {
        error "current RTL requires PARALLEL_CH to divide IN_CH=64"
    }
    if {![string is double -strict $period_ns] || $period_ns <= 0} {
        error "clock period must be a positive number"
    }
    if {$stage ni {synth impl}} {
        error "stage must be synth or impl"
    }
    if {![string is integer -strict $threads] || $threads < 1} {
        error "threads must be a positive integer"
    }

    set script_dir [file dirname [file normalize [info script]]]
    set design_dir [file dirname $script_dir]
    set src_dir [file join $design_dir pointwise_conv.srcs sources_1 new]
    set ip_src_dir [file join $design_dir pointwise_conv.srcs sources_1 ip]
    set out_dir [file normalize $out_dir]
    set generated_dir [file join $out_dir generated]
    file mkdir $out_dir
    file mkdir $generated_dir

    set status_file [file join $out_dir status.env]
    write_status $status_file [list \
        status RUNNING \
        parallel_ch $parallel \
        period_ns $period_ns \
        stage $stage]

    set_param general.maxThreads $threads

    # Generate a private package for this point.  The source package and XPR are
    # intentionally left untouched, which also makes independent sweep points
    # safe to run concurrently.
    set pkg_source [file join $src_dir pointwise_pkg.sv]
    require_file $pkg_source
    set fd [open $pkg_source r]
    set pkg_text [read $fd]
    close $fd
    set replacement "parameter PARALLEL_CH = $parallel;"
    set replacement_count [regsub -all \
        {parameter[ \t]+PARALLEL_CH[ \t]*=[ \t]*[0-9]+[ \t]*;} \
        $pkg_text $replacement generated_pkg]
    if {$replacement_count != 1} {
        error "expected exactly one PARALLEL_CH declaration in $pkg_source"
    }
    set generated_pkg_path [file join $generated_dir pointwise_pkg.sv]
    set fd [open $generated_pkg_path w]
    puts -nonewline $fd $generated_pkg
    close $fd

    set part xczu3eg-sbva484-1-e
    set rtl_files [list \
        [file join $src_dir FSM_pointwise.sv] \
        [file join $src_dir mem_layer08_in.sv] \
        [file join $src_dir mem_layer08_input_bram.sv] \
        [file join $src_dir mem_layer08_out.sv] \
        [file join $src_dir pointwise_mac.sv] \
        [file join $src_dir pointwise.sv]]
    set ip_files [list \
        [file join $ip_src_dir blk_mem_gen_0 blk_mem_gen_0.xci] \
        [file join $ip_src_dir blk_mem_gen_input blk_mem_gen_input.xci] \
        [file join $ip_src_dir blk_mem_gen_output blk_mem_gen_output.xci] \
        [file join $ip_src_dir mult_gen_0 mult_gen_0.xci]]
    foreach path [concat $rtl_files $ip_files] {
        require_file $path
    }

    # Match Vivado's generated top-level synthesis flow: load XCI files into an
    # in-memory project so synthesis emits hierarchical IP black boxes.
    create_project -in_memory -part $part
    set_property target_language Verilog [current_project]
    set_property default_lib xil_defaultlib [current_project]
    set_property XPM_LIBRARIES XPM_MEMORY [current_project]
    read_verilog -sv $generated_pkg_path
    foreach path $rtl_files {
        read_verilog -sv $path
    }
    foreach path $ip_files {
        read_ip -quiet $path
    }

    synth_design \
        -top pointwise \
        -part $part \
        -mode out_of_context \
        -flatten_hierarchy rebuilt

    set top_checkpoint [file join $generated_dir pointwise_synth.dcp]
    write_checkpoint -force -noxdef $top_checkpoint
    close_project

    # Match Vivado's generated implementation init_design flow.  link_design
    # stitches each XCI's OOC checkpoint into the synthesized top checkpoint.
    create_project -in_memory -part $part
    set_property design_mode GateLvl [current_fileset]
    set_property target_language Verilog [current_project]
    set_property XPM_LIBRARIES XPM_MEMORY [current_project]
    add_files -quiet $top_checkpoint
    foreach path $ip_files {
        read_ip -quiet $path
    }
    link_design -top pointwise -part $part

    set unresolved [get_cells -quiet -hier -filter {IS_BLACKBOX == 1}]
    if {[llength $unresolved] != 0} {
        error "unresolved black boxes after link_design: $unresolved"
    }

    create_clock -name clk -period $period_ns [get_ports clk]
    # Give OOC timing a concrete clock-root location.  The wide top boundary is
    # excluded because this sweep measures the internal accelerator Fmax; parent
    # interface timing must be checked after integration into the full system.
    set_property HD.CLK_SRC BUFGCE_X0Y0 [get_ports clk]
    set non_clock_inputs [get_ports {rst start input_start_w input_data[*]}]
    set_false_path -from $non_clock_inputs
    set_false_path -to [get_ports -filter {DIRECTION == OUT}]
    report_utilization -file [file join $out_dir utilization_synth.rpt]

    if {$stage eq "impl"} {
        opt_design
        place_design
        phys_opt_design
        route_design

        report_utilization \
            -file [file join $out_dir utilization.rpt]
        report_utilization \
            -hierarchical \
            -file [file join $out_dir utilization_hierarchical.rpt]
        report_timing_summary \
            -delay_type max \
            -max_paths 20 \
            -report_unconstrained \
            -check_timing_verbose \
            -file [file join $out_dir timing_summary.rpt]
        report_clock_utilization \
            -file [file join $out_dir clock_utilization.rpt]
        report_power \
            -file [file join $out_dir power.rpt]
        report_drc \
            -file [file join $out_dir drc.rpt]
        report_methodology \
            -file [file join $out_dir methodology.rpt]

        if {$keep_dcp} {
            write_checkpoint -force [file join $out_dir pointwise_routed.dcp]
        }

        set timing_paths [get_timing_paths -delay_type max -max_paths 1 -nworst 1]
        if {[llength $timing_paths] > 0} {
            set wns_ns [get_property SLACK [lindex $timing_paths 0]]
            set fmax_denominator [expr {$period_ns - $wns_ns}]
            if {$fmax_denominator > 0} {
                set fmax_mhz [expr {1000.0 / $fmax_denominator}]
            } else {
                set fmax_mhz ""
            }
        } else {
            set wns_ns ""
            set fmax_mhz ""
        }
    } else {
        set wns_ns ""
        set fmax_mhz ""
    }

    write_status $status_file [list \
        status SUCCESS \
        parallel_ch $parallel \
        period_ns $period_ns \
        stage $stage \
        part $part \
        wns_ns $wns_ns \
        estimated_fmax_mhz $fmax_mhz \
        vivado_version [version -short]]
}

if {[llength $argv] != 6} {
    puts stderr "usage: ppa_sweep_point.tcl PARALLEL_CH OUT_DIR PERIOD_NS STAGE KEEP_DCP THREADS"
    exit 2
}

lassign $argv parallel out_dir period_ns stage keep_dcp threads
set status_path [file join [file normalize $out_dir] status.env]
if {[catch {
    run_point $parallel $out_dir $period_ns $stage $keep_dcp $threads
} message options]} {
    file mkdir [file dirname $status_path]
    write_status $status_path [list \
        status FAILED \
        parallel_ch $parallel \
        period_ns $period_ns \
        stage $stage \
        error $message]
    puts stderr "PPA sweep point P=$parallel failed: $message"
    if {[dict exists $options -errorinfo]} {
        puts stderr [dict get $options -errorinfo]
    }
    exit 1
}

exit 0
