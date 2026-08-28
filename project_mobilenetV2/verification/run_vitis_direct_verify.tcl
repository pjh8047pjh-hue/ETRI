set repo_dir [file normalize [file join [file dirname [info script]] ..]]
set bit_file [file join $repo_dir mobilenetV2_test _ide bitstream mobilenetV2_hw.bit]
set psu_file [file join $repo_dir mobilenetV2_platform hw psu_init.tcl]
set elf_file [file join $repo_dir mobilenetV2_test Debug mobilenetV2_test.elf]

foreach {label path} [list BIT $bit_file PSU_INIT $psu_file ELF $elf_file] {
  if {![file exists $path]} {
    error "$label file does not exist: $path"
  }
  puts "$label=$path"
}

connect -url tcp:127.0.0.1:3121
source $psu_file

puts "STEP=SYSTEM_RESET"
targets -set -nocase -filter {name =~ "APU*"}
rst -system
after 3000

puts "STEP=UNLOCK_PSU"
targets -set -nocase -filter {name == "PSU"}
mwr 0xffca0038 0x1ff
after 500

puts "STEP=PROGRAM_PL"
targets -set -nocase -filter {name == "PL"}
fpga -file $bit_file

# Initialize the PS directly instead of waiting for the FSBL exit breakpoint.
# The application and its large output buffer live in OCM, so DDR calibration
# is intentionally omitted, matching the project's established OCM flow.
puts "STEP=PS_CLOCKS_AND_PERIPHERALS"
targets -set -nocase -filter {name =~ "APU*"}
configparams force-mem-accesses 1
init_ps [subst {$psu_mio_init_data $psu_peripherals_pre_init_data $psu_pll_init_data $psu_clock_init_data}]
init_ps [subst {$psu_peripherals_init_data $psu_resetin_init_data}]

# Do not wait for unused SerDes blocks while releasing PS resets.
set resetout_no_serdes [string map [list \
  "mask_poll 0XFD4063E4 0x00000010" "" \
  "mask_poll 0XFD40A3E4 0x00000010" "" \
  "mask_poll 0XFD40E3E4 0x00000010" ""] \
  $psu_resetout_init_data]
init_ps [subst {$resetout_no_serdes}]
catch {init_peripheral}
init_ps [subst {$psu_afi_config}]
configparams force-mem-accesses 0
psu_ps_pl_isolation_removal
after 1000
psu_ps_pl_reset_config

puts "STEP=DOWNLOAD_APP"
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow $elf_file

puts "STEP=RUN_APP"
con
after 3000

puts "STEP=READBACK"
if {[catch {stop} stop_error]} {
  puts "READBACK_STOP_ERROR=$stop_error"
} else {
  puts "PC=[rrd pc]"
  configparams force-mem-access 1
  foreach {label addr} {
    PL0_REF_CTRL 0xFF5E00C0
    GPIO_CH1     0xA0000000
    GPIO_CH2     0xA0000008
  } {
    if {[catch {mrd $addr} value]} {
      puts "$label=ERROR:$value"
    } else {
      puts "$label=$value"
    }
  }
  configparams force-mem-access 0
  con
}

puts "DIRECT_VERIFY_COMPLETE"
disconnect
