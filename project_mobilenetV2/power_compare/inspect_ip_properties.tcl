set here [file dirname [info script]]
set root [file dirname $here]
set srcroot [file join $root project_mobilenetV2.srcs sources_1]
create_project -in_memory ip_probe -part xczu3eg-sbva484-1-e
read_ip [file join $srcroot ip dsp48_first_point dsp48_first_point.xci]
puts "=== IP PROPERTIES ==="
report_property -all [get_ips dsp48_first_point]
puts "=== FILE PROPERTIES ==="
report_property -all [get_files *dsp48_first_point.xci]
