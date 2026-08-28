connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name == "PSU"}
set values [mrd -force -value 0xFFFC36C8 2]
puts "VERIFICATION_STATE=$values"
disconnect
