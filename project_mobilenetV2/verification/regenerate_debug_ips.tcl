open_project C:/Users/user/Documents/JH/project_mobilenetV2/project_mobilenetV2.xpr

set_property CONFIG.Coe_File {../../../../coe/weight_after_depth_onehot.coe} \
    [get_ips pointwise_after_depth_weight]

set debug_ips [get_ips {
    pointwise_weight
    blk_mem_gen_0
    depth_bias
    pointwise_after_depth_weight
    pointwise_after_depth_bias
}]
generate_target simulation $debug_ips -force
export_ip_user_files -of_objects $debug_ips -no_script -sync -force -quiet

close_project
