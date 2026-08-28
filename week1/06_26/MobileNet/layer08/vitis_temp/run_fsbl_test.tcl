set root [file normalize [file dirname [info script]]]
set bit  "$root/boot/mobilenetV2_hw.bit"
set xsa  "$root/boot/mobilenetV2_hw.xsa"
set fsbl "$root/boot/fsbl.elf"
set elf  "$root/boot/mobilenetV2_test.elf"

proc step {message} {
    puts "### $message ###"
    flush stdout
}

proc read_diag_page {label gpio_value} {
    mwr 0xA0000000 $gpio_value
    after 10
    set value [mrd -value 0xA0000008]
    puts [format "%s=0x%08x" $label $value]
}

connect -url tcp:127.0.0.1:3121
source C:/Xilinx/Vitis/2020.2/scripts/vitis/util/zynqmp_utils.tcl

step "reset system"
targets -set -nocase -filter {name =~ "APU*"}
rst -system
after 3000

step "program FPGA"
targets -set -nocase -filter {name =~ "*PL*"}
fpga -file $bit

step "load hardware description"
targets -set -nocase -filter {name =~ "APU*"}
loadhw -hw $xsa -mem-ranges [list \
    {0x80000000 0xbfffffff} \
    {0x400000000 0x5ffffffff} \
    {0x1000000000 0x7fffffffff}] -regs
configparams force-mem-access 1

step "run FSBL for 5 seconds"
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow $fsbl
con
after 5000
catch {stop}

step "download Layer08 verification ELF"
targets -set -nocase -filter {name =~ "*A53*#0"}
rst -processor
dow $elf
configparams force-mem-access 0
con

step "verification is running; read Tera Term"
after 5000
catch {puts "PC = [lindex [rrd pc] 1]"}
catch {puts "backtrace:\n[bt]"}
step "done"
