connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~ "*A53*#0"}
puts "PC=[lindex [rrd pc] 1]"
puts [rrd]
disconnect
