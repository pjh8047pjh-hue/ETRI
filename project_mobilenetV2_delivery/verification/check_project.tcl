set script_dir [file dirname [info script]]
set project_file [file join [file dirname $script_dir] project_mobilenetV2.xpr]

if {![file exists $project_file]} {
    puts stderr "DELIVERY_CHECK_FAILED: project file not found: $project_file"
    exit 1
}

if {[catch {
    open_project $project_file -read_only
} error_message]} {
    puts stderr "DELIVERY_CHECK_FAILED: $error_message"
    catch {close_project}
    exit 1
}

puts "DELIVERY_CHECK_PASSED: project opened successfully."
close_project
exit 0
