set DIR_WORKSPACE {C:/Users/user/Documents/JH/week 3/07_08/ex_mem_apb_zedboard/sw.arm/workspace.abs_probe}
set PATH_XSA {C:/Users/user/Documents/JH/week 3/07_08/ex_mem_apb_zedboard/hw/impl.zed/xsa/design_zed_wrapper.xsa}
setws ${DIR_WORKSPACE}
puts "WS=${DIR_WORKSPACE}"
app create -name app_probe_1336 \
           -hw ${PATH_XSA} \
           -proc ps7_cortexa9_0 \
           -os standalone \
           -lang c \
           -template {Hello World}
puts "APPS=[app list]"
app build -name app_probe_1336
exit
