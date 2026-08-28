set here [file dirname [info script]]
set root [file dirname $here]
set out  [file join $here ip_netlists]
file mkdir $out

foreach ip {dsp48_first_point dsp48_middle_point dsp48_last_point} {
    set dcp [file join $root project_mobilenetV2.runs ${ip}_synth_1 ${ip}.dcp]
    open_checkpoint $dcp
    write_edif -force [file join $out ${ip}.edf]
    write_verilog -force -mode funcsim [file join $out ${ip}_funcsim.v]
    close_design
}
