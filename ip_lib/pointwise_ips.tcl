##################################################################
# week6/pointwise_conv 의 IP 4개를 다른 프로젝트에서 다시 만드는 스크립트
#   - blk_mem_gen_0      : weight ROM   (1024b x 384,  COE init)
#   - blk_mem_gen_input  : input  SDP RAM (1024b x 196, COE init)
#   - blk_mem_gen_output : output SDP RAM (16b x 75264, init 없음)
#   - mult_gen_0         : 16x16 signed 곱셈기 (1 pipeline stage)
#
# 사용법 (Vivado Tcl console, 프로젝트를 열어 둔 상태에서):
#   set COE_DIR C:/Users/user/Documents/JH/week6/pointwise_conv/coe
#   source C:/Users/user/Documents/JH/ip_lib/pointwise_ips.tcl
#
# Vivado 2020.2 / xczu3eg-sbva484-1-e (Ultra96v2) 기준.
##################################################################

# COE 파일이 있는 디렉터리. 미리 set 해 두지 않으면 아래 기본값을 쓴다.
if { ![info exists COE_DIR] } {
  set COE_DIR [file normalize [file dirname [info script]]/../week6/pointwise_conv/coe]
}
puts "INFO: COE_DIR = $COE_DIR"

##################################################################
# 1) weight ROM : Single Port ROM, 1024bit x 384
#    한 주소 = output channel 1개의 weight 64개 (64 x 16bit)
##################################################################
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 \
          -module_name blk_mem_gen_0
set_property -dict [list \
  CONFIG.Memory_Type                            {Single_Port_ROM} \
  CONFIG.Write_Width_A                          {1024} \
  CONFIG.Write_Depth_A                          {384} \
  CONFIG.Read_Width_A                           {1024} \
  CONFIG.Write_Width_B                          {1024} \
  CONFIG.Read_Width_B                           {1024} \
  CONFIG.Enable_A                               {Use_ENA_Pin} \
  CONFIG.Operating_Mode_A                       {WRITE_FIRST} \
  CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
  CONFIG.Use_RSTA_Pin                           {false} \
  CONFIG.Use_REGCEA_Pin                         {false} \
  CONFIG.Algorithm                              {Minimum_Area} \
  CONFIG.Primitive                              {8kx2} \
  CONFIG.PRIM_type_to_Implement                 {BRAM} \
  CONFIG.Load_Init_File                         {true} \
  CONFIG.Coe_File                               "$COE_DIR/weight_layer08.coe" \
  CONFIG.Fill_Remaining_Memory_Locations        {false} \
  CONFIG.Port_A_Clock                           {100} \
  CONFIG.Port_A_Write_Rate                      {0} \
  CONFIG.Port_A_Enable_Rate                     {100} \
] [get_ips blk_mem_gen_0]

##################################################################
# 2) input BRAM : Simple Dual Port RAM, 1024bit x 196
#    포트 A = write (pixel 1개당 64ch x 16bit), 포트 B = read
##################################################################
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 \
          -module_name blk_mem_gen_input
set_property -dict [list \
  CONFIG.Memory_Type                            {Simple_Dual_Port_RAM} \
  CONFIG.Assume_Synchronous_Clk                 {true} \
  CONFIG.Write_Width_A                          {1024} \
  CONFIG.Write_Depth_A                          {196} \
  CONFIG.Read_Width_A                           {1024} \
  CONFIG.Write_Width_B                          {1024} \
  CONFIG.Read_Width_B                           {1024} \
  CONFIG.Enable_A                               {Use_ENA_Pin} \
  CONFIG.Enable_B                               {Use_ENB_Pin} \
  CONFIG.Operating_Mode_A                       {NO_CHANGE} \
  CONFIG.Operating_Mode_B                       {READ_FIRST} \
  CONFIG.Use_Byte_Write_Enable                  {false} \
  CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
  CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
  CONFIG.Use_RSTA_Pin                           {false} \
  CONFIG.Use_RSTB_Pin                           {false} \
  CONFIG.Algorithm                              {Minimum_Area} \
  CONFIG.Primitive                              {8kx2} \
  CONFIG.PRIM_type_to_Implement                 {BRAM} \
  CONFIG.Load_Init_File                         {true} \
  CONFIG.Coe_File                               "$COE_DIR/input_layer08.coe" \
  CONFIG.Fill_Remaining_Memory_Locations        {false} \
  CONFIG.Port_A_Clock                           {100} \
  CONFIG.Port_A_Write_Rate                      {50} \
  CONFIG.Port_A_Enable_Rate                     {100} \
  CONFIG.Port_B_Clock                           {100} \
  CONFIG.Port_B_Enable_Rate                     {100} \
] [get_ips blk_mem_gen_input]

##################################################################
# 3) output BRAM : Simple Dual Port RAM, 16bit x 75264
#    75264 = WEIGHT_WIDTH(384) x CHANNEL_WIDTH(196), 초기화 파일 없음
##################################################################
create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 \
          -module_name blk_mem_gen_output
set_property -dict [list \
  CONFIG.Memory_Type                            {Simple_Dual_Port_RAM} \
  CONFIG.Assume_Synchronous_Clk                 {true} \
  CONFIG.Write_Width_A                          {16} \
  CONFIG.Write_Depth_A                          {75264} \
  CONFIG.Read_Width_A                           {16} \
  CONFIG.Write_Width_B                          {16} \
  CONFIG.Read_Width_B                           {16} \
  CONFIG.Enable_A                               {Use_ENA_Pin} \
  CONFIG.Enable_B                               {Use_ENB_Pin} \
  CONFIG.Operating_Mode_A                       {NO_CHANGE} \
  CONFIG.Operating_Mode_B                       {READ_FIRST} \
  CONFIG.Use_Byte_Write_Enable                  {false} \
  CONFIG.Register_PortA_Output_of_Memory_Primitives {false} \
  CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
  CONFIG.Use_RSTA_Pin                           {false} \
  CONFIG.Use_RSTB_Pin                           {false} \
  CONFIG.Algorithm                              {Minimum_Area} \
  CONFIG.Primitive                              {8kx2} \
  CONFIG.PRIM_type_to_Implement                 {BRAM} \
  CONFIG.Load_Init_File                         {false} \
  CONFIG.Port_A_Clock                           {100} \
  CONFIG.Port_A_Write_Rate                      {50} \
  CONFIG.Port_A_Enable_Rate                     {100} \
  CONFIG.Port_B_Clock                           {100} \
  CONFIG.Port_B_Enable_Rate                     {100} \
] [get_ips blk_mem_gen_output]

##################################################################
# 4) mult_gen_0 : 16bit signed x 16bit signed -> 32bit, DSP 1개, 1 stage
##################################################################
create_ip -name mult_gen -vendor xilinx.com -library ip -version 12.0 \
          -module_name mult_gen_0
set_property -dict [list \
  CONFIG.MultType                {Parallel_Multiplier} \
  CONFIG.Multiplier_Construction {Use_Mults} \
  CONFIG.OptGoal                 {Speed} \
  CONFIG.PortAType               {Signed} \
  CONFIG.PortAWidth              {16} \
  CONFIG.PortBType               {Signed} \
  CONFIG.PortBWidth              {16} \
  CONFIG.Use_Custom_Output_Width {false} \
  CONFIG.OutputWidthHigh         {31} \
  CONFIG.OutputWidthLow          {0} \
  CONFIG.PipeStages              {1} \
  CONFIG.ClockEnable             {false} \
  CONFIG.SyncClear               {false} \
] [get_ips mult_gen_0]

##################################################################
# 합성용 출력 생성 (필요할 때만)
##################################################################
foreach ip {blk_mem_gen_0 blk_mem_gen_input blk_mem_gen_output mult_gen_0} {
  generate_target {instantiation_template synthesis simulation} [get_ips $ip]
}
puts "INFO: pointwise IP 4개 생성 완료"
