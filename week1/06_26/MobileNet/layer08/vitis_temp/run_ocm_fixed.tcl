if {[info script] ne ""} {
    # Do not call file normalize here. Vitis 2020.2 can drop the localized
    # Windows Documents path component while normalizing this project path.
    set proj [file dirname [info script]]
} else {
    set proj [pwd]
}

set bit "$proj/boot/design_1_wrapper.bit"
set psu "$proj/boot/psu_init.tcl"
set elf "$proj/boot/mobilenetV2_test.elf"

proc log {message} {
    puts $message
    flush stdout
}

proc run_step {name body} {
    log "### $name ###"
    if {[catch {uplevel 1 $body} error_message]} {
        log "FATAL: $error_message"
        return -code error $error_message
    }
}

foreach {label path} [list bitstream $bit psu_init $psu elf $elf] {
    if {![file exists $path]} {
        error "$label not found: $path"
    }
    log "$label = $path"
}

# Vitis 2020.2's dow/fpga commands can internally normalize the localized
# Windows Documents directory to an invalid path. Stage the three inputs in a
# short ASCII-only directory before connecting to hardware.
set launch_dir "C:/tmp/layer08_board_run"
file mkdir $launch_dir
file copy -force $bit "$launch_dir/design_1_wrapper.bit"
file copy -force $psu "$launch_dir/psu_init.tcl"
file copy -force $elf "$launch_dir/mobilenetV2_test.elf"
set bit "$launch_dir/design_1_wrapper.bit"
set psu "$launch_dir/psu_init.tcl"
set elf "$launch_dir/mobilenetV2_test.elf"
log "staged files = $launch_dir"

connect -url tcp:127.0.0.1:3121
source $psu

run_step "reset system" {
    targets -set -nocase -filter {name =~ "APU*"}
    rst -system
    after 3000
}
run_step "unlock PS gates" {
    targets -set -filter {name =~ "PSU"}
    mwr 0xffca0038 0x1ff
    after 500
}
run_step "program PL" {
    targets -set -nocase -filter {name =~ "*PL*"}
    fpga -file $bit
}
run_step "initialize MIO PLL and clocks" {
    targets -set -nocase -filter {name =~ "APU*"}
    configparams force-mem-accesses 1
    init_ps [subst {$psu_mio_init_data $psu_peripherals_pre_init_data $psu_pll_init_data $psu_clock_init_data}]
}
run_step "initialize peripherals and resets" {
    init_ps [subst {$psu_peripherals_init_data $psu_resetin_init_data}]
    set resetout_no_serdes [string map [list \
        "mask_poll 0XFD4063E4 0x00000010" "" \
        "mask_poll 0XFD40A3E4 0x00000010" "" \
        "mask_poll 0XFD40E3E4 0x00000010" ""] \
        $psu_resetout_init_data]
    init_ps [subst {$resetout_no_serdes}]
}
run_step "initialize AFI and remove PS-PL isolation" {
    catch {init_peripheral}
    init_ps [subst {$psu_afi_config}]
    configparams force-mem-accesses 0
    psu_ps_pl_isolation_removal
    after 1000
    psu_ps_pl_reset_config
}
run_step "download and run A53 ELF" {
    targets -set -nocase -filter {name =~ "*A53*#0"}
    rst -processor
    dow $elf
    con
}

log "### verification running; read Tera Term ###"
after 15000
catch {stop}
catch {log "PC = [lindex [rrd pc] 1]"}
catch {log "backtrace:\n[bt]"}
catch {con}
log "### done ###"
