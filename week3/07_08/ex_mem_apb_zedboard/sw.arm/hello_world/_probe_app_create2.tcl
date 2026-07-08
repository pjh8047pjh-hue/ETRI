setws ../workspace.test2
app create -name hello_world_probe \
           -hw ../../hw/impl.zed/xsa/design_zed_wrapper.xsa \
           -proc ps7_cortexa9_0 \
           -os standalone \
           -lang c \
           -template {Hello World}
puts "APPS=[app list]"
exit
