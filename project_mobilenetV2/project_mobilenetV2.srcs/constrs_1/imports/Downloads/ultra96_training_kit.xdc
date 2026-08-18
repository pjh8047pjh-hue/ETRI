# ----------------------------------------------------------------------------
#
#  Inipro Inc.          www.inipro.net
#
# ----------------------------------------------------------------------------
#
#     IO standard for Bank 26 Vcco supply is fixed at 1.8V
#     IO standard for Bank 65 Vcco supply is fixed at 1.2V
#
# ----------------------------------------------------------------------------


# ----------------------------------------------------------------------------
# High-speed expansion connector
# ----------------------------------------------------------------------------
# Bank 65
#set_property PACKAGE_PIN F1   [get_ports {pmod_c[1]               }];  # "F1.DSI_D0_N"
#set_property PACKAGE_PIN G1   [get_ports {pmod_c[0]               }];  # "G1.DSI_D0_P"
#set_property PACKAGE_PIN E3   [get_ports {pmod_c[3]               }];  # "E3.DSI_D1_N"
#set_property PACKAGE_PIN E4   [get_ports {pmod_c[2]               }];  # "E4.DSI_D1_P"
#set_property PACKAGE_PIN D1   [get_ports {pmod_c[5]               }];  # "D1.DSI_D2_N"
#set_property PACKAGE_PIN E1   [get_ports {pmod_c[4]               }];  # "E1.DSI_D2_P"
#set_property PACKAGE_PIN C3   [get_ports {pmod_c[7]               }];  # "C3.DSI_D3_N"
#set_property PACKAGE_PIN D3   [get_ports {pmod_c[6]               }];  # "D3.DSI_D3_P"

set_property PACKAGE_PIN L2 [get_ports clk_in]


# ----------------------------------------------------------------------------
# Low-speed expansion connector
# --------------------------------------------- -------------------------------
# Bank 26
set_property PACKAGE_PIN D7 [get_ports rst]
set_property PACKAGE_PIN F8 [get_ports start]
#set_property PACKAGE_PIN F7   [get_ports {ssd2[4]               }];  # "F7.HD_GPIO_2"
#set_property PACKAGE_PIN G7   [get_ports {ssd2[3]               }];  # "G7.HD_GPIO_3"
#set_property PACKAGE_PIN F6   [get_ports {ssd2[2]               }];  # "F6.HD_GPIO_4"
#set_property PACKAGE_PIN G5   [get_ports {ssd2[1]               }];  # "G5.HD_GPIO_5"
#set_property PACKAGE_PIN A6   [get_ports {ssd2[0]               }];  # "A6.HD_GPIO_6"
#set_property PACKAGE_PIN A7   [get_ports {cat_2                 }];  # "A7.HD_GPIO_7"

#set_property PACKAGE_PIN G6   [get_ports {ssd1[6]               }];  # "G6.HD_GPIO_8"
#set_property PACKAGE_PIN E6   [get_ports {ssd1[5]               }];  # "E6.HD_GPIO_9"
#set_property PACKAGE_PIN E5   [get_ports {ssd1[4]               }];  # "E5.HD_GPIO_10"
#set_property PACKAGE_PIN D6   [get_ports {ssd1[3]               }];  # "D6.HD_GPIO_11"
#set_property PACKAGE_PIN D5   [get_ports {ssd1[2]               }];  # "D5.HD_GPIO_12"
#set_property PACKAGE_PIN C7   [get_ports {ssd1[1]               }];  # "C7.HD_GPIO_13"
#set_property PACKAGE_PIN B6   [get_ports {ssd1[0]               }];  # "B6.HD_GPIO_14"
#set_property PACKAGE_PIN C5   [get_ports {cat_1                 }];  # "C5.HD_GPIO_15"

##BT_HCI_RTS on FPGA /  emio_uart0_ctsn connect to
#set_property PACKAGE_PIN B7 [get_ports BT_ctsn]
##BT_HCI_CTS on FPGA / emio_uart0_rtsn
#set_property PACKAGE_PIN B5 [get_ports BT_rtsn]

# ----------------------------------------------------------------------------
#
# IOSTANDARD Constraints
#
# ----------------------------------------------------------------------------

# Set the bank voltage for IO Bank 26 to 1.8V
set_property IOSTANDARD LVCMOS18 [get_ports -of_objects [get_iobanks 26]]

# Set the bank voltage for IO Bank 65 to 1.2V
set_property IOSTANDARD LVCMOS12 [get_ports -of_objects [get_iobanks 65]]

# Set the voltage for BT* to 1.8V
#set_property IOSTANDARD LVCMOS18 [get_ports BT*]


# ---------------------------------------------------------------------------
# ILA debug core disabled 2026-08-18.
# Vivado 자동 생성 블록에서 probe0/1/2 의 port_width 와 connect_debug_port 가
# 모두 빠져 있어 probe0(16bit) 이 전부 미연결 -> [Chipscope 16-213] 에러.
# probe2 의 connect 는 create_debug_core 보다 앞에 있어 무효.
# 다시 쓰려면 이 블록을 지우고 합성 후 Set Up Debug 로 새로 생성할 것.
# ---------------------------------------------------------------------------
# connect_debug_port u_ila_0/probe2 [get_nets [list pointwise_after_depth_valid]]
# 
# create_debug_core u_ila_0 ila
# set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
# set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
# set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
# set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
# set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
# set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
# set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
# set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
# set_property port_width 1 [get_debug_ports u_ila_0/clk]
# connect_debug_port u_ila_0/clk [get_nets [list clk_gen/inst/clk_out1]]
# set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
# create_debug_port u_ila_0 probe
# set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
# create_debug_port u_ila_0 probe
# set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
# set_property MARK_DEBUG false [get_nets start_IBUF]
# set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
# set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
# set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
# connect_debug_port dbg_hub/clk [get_nets clk]
