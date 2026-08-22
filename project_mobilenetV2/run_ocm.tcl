# 경로는 이 스크립트 위치를 기준으로 잡는다. 다른 PC에 clone해도 그대로 동작한다.
if {[info script] ne ""} {
    set proj [file normalize [file dirname [info script]]]
} else {
    set proj [file normalize [pwd]]
}

# 보드에 올리는 데 필요한 3개 파일은 boot/에 커밋되어 있다.
# Vivado/Vitis를 새로 돌린 뒤 갱신하려면 boot/로 복사해 넣으면 된다.
set bit "$proj/boot/design_1_wrapper.bit"
set psu "$proj/boot/psu_init.tcl"
set elf "$proj/boot/mobilenetV2_test.elf"

proc p {m} { puts $m; flush stdout }

p "### 사용할 파일 ###"
foreach {label f} [list bitstream $bit psu_init $psu elf $elf] {
    if {![file exists $f]} {
        p "  FATAL: $label 없음 -> $f"
        exit 1
    }
    p "  $label = $f"
}
proc s {name body} {
    p "### $name ###"
    if {[catch {uplevel 1 $body} e]} {
        p "  FATAL: $e"
        return -code error $e
    }
    p "  ok"
}

connect -url tcp:127.0.0.1:3121
source $psu
s "1 rst -system" { targets -set -nocase -filter {name =~ "APU*"}; rst -system; after 3000 }
s "2 unlock gates" { targets -set -filter {name =~ "PSU"}; mwr 0xffca0038 0x1ff; after 500 }
s "3 program PL"  { targets -set -nocase -filter {name =~ "*PL*"}; fpga -file $bit }
s "4 select APU" { targets -set -nocase -filter {name =~ "APU*"} }
s "5 MIO+PLL+CLK (DDR 제외)" {
    configparams force-mem-accesses 1
    init_ps [subst {$psu_mio_init_data $psu_peripherals_pre_init_data $psu_pll_init_data $psu_clock_init_data}]
}
s "6 peripherals+resets" {
    init_ps [subst {$psu_peripherals_init_data $psu_resetin_init_data}]
    set resetout_no_serdes [string map [list \
        "mask_poll 0XFD4063E4 0x00000010" "" \
        "mask_poll 0XFD40A3E4 0x00000010" "" \
        "mask_poll 0XFD40E3E4 0x00000010" ""] \
        $psu_resetout_init_data]
    init_ps [subst {$resetout_no_serdes}]
}
s "7 afi/smmu" { catch { init_peripheral }; init_ps [subst {$psu_afi_config}]; configparams force-mem-accesses 0 }
s "8 PS-PL isolation" { psu_ps_pl_isolation_removal; after 1000; psu_ps_pl_reset_config }
s "9 download OCM elf" { targets -set -nocase -filter {name =~ "*A53*#0"}; rst -processor; dow $elf }
s "10 run" { con }
p "### 11 wait 15s ###"
after 15000
catch { stop }
catch { p "PC = [lindex [rrd pc] 1]" }
catch { p "bt:\n[bt]" }
catch { p "output_data\[0..7\]:\n[mrd 0xFFFCB0C0 4]" }
catch { con }
p "### DONE ###"
