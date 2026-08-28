set here    [file dirname [info script]]
set root    [file dirname $here]
set srcroot [file join $root project_mobilenetV2.srcs sources_1]
set ipwork  [file join $here generated_ip]

file mkdir $ipwork
create_project -in_memory cascade_ip_prepare -part xczu3eg-sbva484-1-e

foreach ip {dsp48_first_point dsp48_middle_point dsp48_last_point} {
    set dst [file join $ipwork $ip]
    file mkdir $dst
    file copy -force [file join $srcroot ip $ip ${ip}.xci] \
                     [file join $dst ${ip}.xci]
    read_ip [file join $dst ${ip}.xci]
}

generate_target synthesis [get_ips]
