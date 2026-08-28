connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name == "PSU"}

proc read_diag_page {label gpio_value} {
    mwr -force 0xA0000000 $gpio_value
    after 10
    set value [mrd -force -value 0xA0000008]
    puts [format "%s=0x%08x" $label $value]
}

read_diag_page SIGNATURE 0x0000FFF0
read_diag_page COUNTER_A 0x0000FFF4
after 10
read_diag_page COUNTER_B 0x0000FFF4
read_diag_page WRITE_ADDR 0x0000FFF8
read_diag_page STATUS 0x0000FFFC

disconnect
