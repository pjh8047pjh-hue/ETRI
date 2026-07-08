-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Wed Jul  8 12:07:54 2026
-- Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim {c:/Users/user/Documents/JH/week
--               3/07_08/ex_mem_apb_zedboard/hw/impl.zed/project_zed/project_zed.gen/sources_1/bd/design_zed/ip/design_zed_axi4_to_apb4_s3_0_0/design_zed_axi4_to_apb4_s3_0_0_sim_netlist.vhdl}
-- Design      : design_zed_axi4_to_apb4_s3_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_zed_axi4_to_apb4_s3_0_0_axi_to_apb_bridge is
  port (
    s_axi_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M0_APB_PADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \M_PADDR_reg[13]_0\ : out STD_LOGIC;
    \M_PADDR_reg[12]_0\ : out STD_LOGIC;
    M0_APB_PSEL : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    M2_APB_PWRITE : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    M2_APB_PENABLE : out STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    PCLK : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    axi_aclk : in STD_LOGIC;
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PREADY : in STD_LOGIC;
    M0_APB_PREADY : in STD_LOGIC;
    M1_APB_PREADY : in STD_LOGIC;
    M0_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M1_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_bready : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_aresetn : in STD_LOGIC;
    PRESETn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_zed_axi4_to_apb4_s3_0_0_axi_to_apb_bridge : entity is "axi_to_apb_bridge";
end design_zed_axi4_to_apb4_s3_0_0_axi_to_apb_bridge;

architecture STRUCTURE of design_zed_axi4_to_apb4_s3_0_0_axi_to_apb_bridge is
  signal ACK_i_1_n_0 : STD_LOGIC;
  signal ACK_reg_n_0 : STD_LOGIC;
  signal ADDR : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \ARBURST_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \ARBURST_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal ARLEN_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \ARLEN_reg[7]_i_1_n_0\ : STD_LOGIC;
  signal ARREADY_i_1_n_0 : STD_LOGIC;
  signal ARREADY_i_2_n_0 : STD_LOGIC;
  signal ARSIZE_reg : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal ARSTRB_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal ARSTRB_reg1 : STD_LOGIC;
  signal ARSTRB_reg1_carry_i_1_n_0 : STD_LOGIC;
  signal ARSTRB_reg1_carry_i_2_n_0 : STD_LOGIC;
  signal ARSTRB_reg1_carry_i_3_n_0 : STD_LOGIC;
  signal ARSTRB_reg1_carry_i_4_n_0 : STD_LOGIC;
  signal ARSTRB_reg1_carry_i_5_n_0 : STD_LOGIC;
  signal ARSTRB_reg1_carry_i_6_n_0 : STD_LOGIC;
  signal ARSTRB_reg1_carry_i_7_n_0 : STD_LOGIC;
  signal ARSTRB_reg1_carry_i_8_n_0 : STD_LOGIC;
  signal ARSTRB_reg1_carry_n_1 : STD_LOGIC;
  signal ARSTRB_reg1_carry_n_2 : STD_LOGIC;
  signal ARSTRB_reg1_carry_n_3 : STD_LOGIC;
  signal \ARSTRB_reg[0]_i_1_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[1]_i_1_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[1]_i_2_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[1]_i_3_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[2]_i_1_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[2]_i_2_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[3]_i_1_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[3]_i_2_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[3]_i_3_n_0\ : STD_LOGIC;
  signal \ARSTRB_reg[3]_i_4_n_0\ : STD_LOGIC;
  signal AWADDR_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal AWBURST_reg : STD_LOGIC;
  signal \AWBURST_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \AWBURST_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal AWID_reg : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal AWLEN_reg : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal AWREADY_i_1_n_0 : STD_LOGIC;
  signal AWREADY_i_2_n_0 : STD_LOGIC;
  signal AWSIZE_reg : STD_LOGIC_VECTOR ( 2 downto 0 );
  signal BID0_carry_i_1_n_0 : STD_LOGIC;
  signal BID0_carry_i_2_n_0 : STD_LOGIC;
  signal BID0_carry_i_3_n_0 : STD_LOGIC;
  signal BID0_carry_i_4_n_0 : STD_LOGIC;
  signal BID0_carry_i_5_n_0 : STD_LOGIC;
  signal BID0_carry_i_6_n_0 : STD_LOGIC;
  signal BID0_carry_i_7_n_0 : STD_LOGIC;
  signal BID0_carry_i_8_n_0 : STD_LOGIC;
  signal BID0_carry_n_0 : STD_LOGIC;
  signal BID0_carry_n_1 : STD_LOGIC;
  signal BID0_carry_n_2 : STD_LOGIC;
  signal BID0_carry_n_3 : STD_LOGIC;
  signal \BID[3]_i_1_n_0\ : STD_LOGIC;
  signal \BID[3]_i_2_n_0\ : STD_LOGIC;
  signal \BRESP[1]_i_1_n_0\ : STD_LOGIC;
  signal \BRESP[1]_i_2_n_0\ : STD_LOGIC;
  signal \BRESP[1]_i_3_n_0\ : STD_LOGIC;
  signal BVALID_i_1_n_0 : STD_LOGIC;
  signal DATAR : STD_LOGIC;
  signal \DATAR[31]_i_10_n_0\ : STD_LOGIC;
  signal \DATAR[31]_i_11_n_0\ : STD_LOGIC;
  signal \DATAR[31]_i_3_n_0\ : STD_LOGIC;
  signal \DATAR[31]_i_4_n_0\ : STD_LOGIC;
  signal \DATAR[31]_i_5_n_0\ : STD_LOGIC;
  signal \DATAR[31]_i_6_n_0\ : STD_LOGIC;
  signal \DATAR[31]_i_7_n_0\ : STD_LOGIC;
  signal \DATAR[31]_i_8_n_0\ : STD_LOGIC;
  signal \DATAR[31]_i_9_n_0\ : STD_LOGIC;
  signal \DATAR__0\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal DATAW : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \FSM_sequential_state[0]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[0]_i_2_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_1_n_0\ : STD_LOGIC;
  signal \FSM_sequential_state[1]_i_2_n_0\ : STD_LOGIC;
  signal \^m0_apb_paddr\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal M0_APB_PSEL_INST_0_i_1_n_0 : STD_LOGIC;
  signal M0_APB_PSEL_INST_0_i_2_n_0 : STD_LOGIC;
  signal M0_APB_PSEL_INST_0_i_3_n_0 : STD_LOGIC;
  signal M0_APB_PSEL_INST_0_i_4_n_0 : STD_LOGIC;
  signal M0_APB_PSEL_INST_0_i_5_n_0 : STD_LOGIC;
  signal M0_APB_PSEL_INST_0_i_6_n_0 : STD_LOGIC;
  signal M1_APB_PSEL_INST_0_i_1_n_0 : STD_LOGIC;
  signal M1_APB_PSEL_INST_0_i_2_n_0 : STD_LOGIC;
  signal M1_APB_PSEL_INST_0_i_3_n_0 : STD_LOGIC;
  signal M1_APB_PSEL_INST_0_i_4_n_0 : STD_LOGIC;
  signal \^m2_apb_penable\ : STD_LOGIC;
  signal M2_APB_PSEL_INST_0_i_1_n_0 : STD_LOGIC;
  signal M2_APB_PSEL_INST_0_i_2_n_0 : STD_LOGIC;
  signal M2_APB_PSEL_INST_0_i_3_n_0 : STD_LOGIC;
  signal \M_PADDR[31]_i_1_n_0\ : STD_LOGIC;
  signal \M_PADDR[31]_i_3_n_0\ : STD_LOGIC;
  signal \^m_paddr_reg[12]_0\ : STD_LOGIC;
  signal \^m_paddr_reg[13]_0\ : STD_LOGIC;
  signal M_PENABLE_i_1_n_0 : STD_LOGIC;
  signal M_PSEL_i_1_n_0 : STD_LOGIC;
  signal \M_PSTRB[0]_i_1_n_0\ : STD_LOGIC;
  signal \M_PSTRB[1]_i_1_n_0\ : STD_LOGIC;
  signal \M_PSTRB[2]_i_1_n_0\ : STD_LOGIC;
  signal \M_PSTRB[3]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[0]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[10]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[11]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[12]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[13]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[14]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[15]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[16]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[17]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[18]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[19]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[1]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[20]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[21]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[22]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[23]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[24]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[25]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[26]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[27]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[28]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[29]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[2]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[30]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[31]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[31]_i_2_n_0\ : STD_LOGIC;
  signal \RDATA[3]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[4]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[5]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[6]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[7]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[8]_i_1_n_0\ : STD_LOGIC;
  signal \RDATA[9]_i_1_n_0\ : STD_LOGIC;
  signal \RID[3]_i_1_n_0\ : STD_LOGIC;
  signal RLAST_i_1_n_0 : STD_LOGIC;
  signal RLAST_i_2_n_0 : STD_LOGIC;
  signal \RRESP[0]_i_1_n_0\ : STD_LOGIC;
  signal \RRESP[1]_i_1_n_0\ : STD_LOGIC;
  signal RVALID_i_1_n_0 : STD_LOGIC;
  signal Traddr : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \Traddr[31]_i_2_n_0\ : STD_LOGIC;
  signal Tren_i_1_n_0 : STD_LOGIC;
  signal Tren_i_2_n_0 : STD_LOGIC;
  signal Tren_i_3_n_0 : STD_LOGIC;
  signal Tren_reg_n_0 : STD_LOGIC;
  signal Trstrb : STD_LOGIC;
  signal Twaddr : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \Twaddr[31]_i_1_n_0\ : STD_LOGIC;
  signal Twdata : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \Twdata[0]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[10]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[11]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[12]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[13]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[14]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[15]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[16]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[17]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[18]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[19]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[1]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[20]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[21]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[22]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[23]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[24]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[25]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[26]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[27]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[28]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[29]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[2]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[30]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[31]_i_2_n_0\ : STD_LOGIC;
  signal \Twdata[3]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[4]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[5]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[6]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[7]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[8]_i_1_n_0\ : STD_LOGIC;
  signal \Twdata[9]_i_1_n_0\ : STD_LOGIC;
  signal Twen : STD_LOGIC;
  signal Twen_i_1_n_0 : STD_LOGIC;
  signal Twen_i_2_n_0 : STD_LOGIC;
  signal Twstrb : STD_LOGIC;
  signal \Twstrb[0]_i_1_n_0\ : STD_LOGIC;
  signal \Twstrb[1]_i_1_n_0\ : STD_LOGIC;
  signal \Twstrb[2]_i_1_n_0\ : STD_LOGIC;
  signal \Twstrb[3]_i_1_n_0\ : STD_LOGIC;
  signal \Twstrb_reg_n_0_[0]\ : STD_LOGIC;
  signal \Twstrb_reg_n_0_[1]\ : STD_LOGIC;
  signal \Twstrb_reg_n_0_[2]\ : STD_LOGIC;
  signal \Twstrb_reg_n_0_[3]\ : STD_LOGIC;
  signal WDATA_reg : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal WR : STD_LOGIC;
  signal WREADY_i_1_n_0 : STD_LOGIC;
  signal WSTRB_reg : STD_LOGIC;
  signal \WSTRB_reg_reg_n_0_[0]\ : STD_LOGIC;
  signal \WSTRB_reg_reg_n_0_[1]\ : STD_LOGIC;
  signal \WSTRB_reg_reg_n_0_[2]\ : STD_LOGIC;
  signal \WSTRB_reg_reg_n_0_[3]\ : STD_LOGIC;
  signal X_PRDATA : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal X_PSEL : STD_LOGIC;
  signal \^addr\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal addrRT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal addrRT0 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal \addrRT0_carry__0_n_0\ : STD_LOGIC;
  signal \addrRT0_carry__0_n_1\ : STD_LOGIC;
  signal \addrRT0_carry__0_n_2\ : STD_LOGIC;
  signal \addrRT0_carry__0_n_3\ : STD_LOGIC;
  signal \addrRT0_carry__1_n_0\ : STD_LOGIC;
  signal \addrRT0_carry__1_n_1\ : STD_LOGIC;
  signal \addrRT0_carry__1_n_2\ : STD_LOGIC;
  signal \addrRT0_carry__1_n_3\ : STD_LOGIC;
  signal \addrRT0_carry__2_n_0\ : STD_LOGIC;
  signal \addrRT0_carry__2_n_1\ : STD_LOGIC;
  signal \addrRT0_carry__2_n_2\ : STD_LOGIC;
  signal \addrRT0_carry__2_n_3\ : STD_LOGIC;
  signal \addrRT0_carry__3_n_0\ : STD_LOGIC;
  signal \addrRT0_carry__3_n_1\ : STD_LOGIC;
  signal \addrRT0_carry__3_n_2\ : STD_LOGIC;
  signal \addrRT0_carry__3_n_3\ : STD_LOGIC;
  signal \addrRT0_carry__4_n_0\ : STD_LOGIC;
  signal \addrRT0_carry__4_n_1\ : STD_LOGIC;
  signal \addrRT0_carry__4_n_2\ : STD_LOGIC;
  signal \addrRT0_carry__4_n_3\ : STD_LOGIC;
  signal \addrRT0_carry__5_n_0\ : STD_LOGIC;
  signal \addrRT0_carry__5_n_1\ : STD_LOGIC;
  signal \addrRT0_carry__5_n_2\ : STD_LOGIC;
  signal \addrRT0_carry__5_n_3\ : STD_LOGIC;
  signal \addrRT0_carry__6_n_2\ : STD_LOGIC;
  signal \addrRT0_carry__6_n_3\ : STD_LOGIC;
  signal addrRT0_carry_i_1_n_0 : STD_LOGIC;
  signal addrRT0_carry_n_0 : STD_LOGIC;
  signal addrRT0_carry_n_1 : STD_LOGIC;
  signal addrRT0_carry_n_2 : STD_LOGIC;
  signal addrRT0_carry_n_3 : STD_LOGIC;
  signal \addrRT[0]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[10]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[11]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[12]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[13]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[14]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[15]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[16]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[17]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[18]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[19]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[1]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[20]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[21]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[22]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[23]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[24]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[25]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[26]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[27]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[28]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[29]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[2]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[30]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[31]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[31]_i_2_n_0\ : STD_LOGIC;
  signal \addrRT[3]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[4]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[5]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[6]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[7]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[8]_i_1_n_0\ : STD_LOGIC;
  signal \addrRT[9]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[0]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[0]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[0]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[10]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[10]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[10]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[11]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[11]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[11]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[12]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[12]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[12]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[13]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[13]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[13]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[14]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[14]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[14]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[15]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[15]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[15]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[15]_i_5_n_0\ : STD_LOGIC;
  signal \addrR[16]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[16]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[16]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[17]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[17]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[17]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[18]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[18]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[18]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[19]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[19]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[19]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[1]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[1]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[1]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[20]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[20]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[20]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[21]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[21]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[21]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[22]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[22]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[22]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[23]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[23]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[23]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[24]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[24]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[24]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[25]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[25]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[25]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[26]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[26]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[26]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[27]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[27]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[27]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[28]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[28]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[28]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[29]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[29]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[29]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[2]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[2]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[2]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[2]_i_5_n_0\ : STD_LOGIC;
  signal \addrR[2]_i_6_n_0\ : STD_LOGIC;
  signal \addrR[2]_i_7_n_0\ : STD_LOGIC;
  signal \addrR[2]_i_8_n_0\ : STD_LOGIC;
  signal \addrR[30]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[30]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[30]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[31]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[31]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[31]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[31]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[31]_i_6_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_10_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_11_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_12_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_13_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_5_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_6_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_7_n_0\ : STD_LOGIC;
  signal \addrR[3]_i_9_n_0\ : STD_LOGIC;
  signal \addrR[4]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[4]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[4]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[4]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[5]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[5]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[5]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[5]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[6]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[6]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[6]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[6]_i_4_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_10_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_11_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_12_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_13_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_15_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_16_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_17_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_18_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_5_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_6_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_8_n_0\ : STD_LOGIC;
  signal \addrR[7]_i_9_n_0\ : STD_LOGIC;
  signal \addrR[8]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[8]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[8]_i_3_n_0\ : STD_LOGIC;
  signal \addrR[9]_i_1_n_0\ : STD_LOGIC;
  signal \addrR[9]_i_2_n_0\ : STD_LOGIC;
  signal \addrR[9]_i_3_n_0\ : STD_LOGIC;
  signal \addrR_reg[11]_i_3_n_0\ : STD_LOGIC;
  signal \addrR_reg[11]_i_3_n_1\ : STD_LOGIC;
  signal \addrR_reg[11]_i_3_n_2\ : STD_LOGIC;
  signal \addrR_reg[11]_i_3_n_3\ : STD_LOGIC;
  signal \addrR_reg[11]_i_9_n_0\ : STD_LOGIC;
  signal \addrR_reg[11]_i_9_n_1\ : STD_LOGIC;
  signal \addrR_reg[11]_i_9_n_2\ : STD_LOGIC;
  signal \addrR_reg[11]_i_9_n_3\ : STD_LOGIC;
  signal \addrR_reg[15]_i_10_n_0\ : STD_LOGIC;
  signal \addrR_reg[15]_i_10_n_1\ : STD_LOGIC;
  signal \addrR_reg[15]_i_10_n_2\ : STD_LOGIC;
  signal \addrR_reg[15]_i_10_n_3\ : STD_LOGIC;
  signal \addrR_reg[15]_i_3_n_0\ : STD_LOGIC;
  signal \addrR_reg[15]_i_3_n_1\ : STD_LOGIC;
  signal \addrR_reg[15]_i_3_n_2\ : STD_LOGIC;
  signal \addrR_reg[15]_i_3_n_3\ : STD_LOGIC;
  signal \addrR_reg[19]_i_3_n_0\ : STD_LOGIC;
  signal \addrR_reg[19]_i_3_n_1\ : STD_LOGIC;
  signal \addrR_reg[19]_i_3_n_2\ : STD_LOGIC;
  signal \addrR_reg[19]_i_3_n_3\ : STD_LOGIC;
  signal \addrR_reg[19]_i_9_n_0\ : STD_LOGIC;
  signal \addrR_reg[19]_i_9_n_1\ : STD_LOGIC;
  signal \addrR_reg[19]_i_9_n_2\ : STD_LOGIC;
  signal \addrR_reg[19]_i_9_n_3\ : STD_LOGIC;
  signal \addrR_reg[23]_i_3_n_0\ : STD_LOGIC;
  signal \addrR_reg[23]_i_3_n_1\ : STD_LOGIC;
  signal \addrR_reg[23]_i_3_n_2\ : STD_LOGIC;
  signal \addrR_reg[23]_i_3_n_3\ : STD_LOGIC;
  signal \addrR_reg[23]_i_9_n_0\ : STD_LOGIC;
  signal \addrR_reg[23]_i_9_n_1\ : STD_LOGIC;
  signal \addrR_reg[23]_i_9_n_2\ : STD_LOGIC;
  signal \addrR_reg[23]_i_9_n_3\ : STD_LOGIC;
  signal \addrR_reg[27]_i_3_n_0\ : STD_LOGIC;
  signal \addrR_reg[27]_i_3_n_1\ : STD_LOGIC;
  signal \addrR_reg[27]_i_3_n_2\ : STD_LOGIC;
  signal \addrR_reg[27]_i_3_n_3\ : STD_LOGIC;
  signal \addrR_reg[27]_i_9_n_0\ : STD_LOGIC;
  signal \addrR_reg[27]_i_9_n_1\ : STD_LOGIC;
  signal \addrR_reg[27]_i_9_n_2\ : STD_LOGIC;
  signal \addrR_reg[27]_i_9_n_3\ : STD_LOGIC;
  signal \addrR_reg[2]_i_4_n_0\ : STD_LOGIC;
  signal \addrR_reg[2]_i_4_n_1\ : STD_LOGIC;
  signal \addrR_reg[2]_i_4_n_2\ : STD_LOGIC;
  signal \addrR_reg[2]_i_4_n_3\ : STD_LOGIC;
  signal \addrR_reg[31]_i_11_n_1\ : STD_LOGIC;
  signal \addrR_reg[31]_i_11_n_2\ : STD_LOGIC;
  signal \addrR_reg[31]_i_11_n_3\ : STD_LOGIC;
  signal \addrR_reg[31]_i_5_n_1\ : STD_LOGIC;
  signal \addrR_reg[31]_i_5_n_2\ : STD_LOGIC;
  signal \addrR_reg[31]_i_5_n_3\ : STD_LOGIC;
  signal \addrR_reg[3]_i_4_n_0\ : STD_LOGIC;
  signal \addrR_reg[3]_i_4_n_1\ : STD_LOGIC;
  signal \addrR_reg[3]_i_4_n_2\ : STD_LOGIC;
  signal \addrR_reg[3]_i_4_n_3\ : STD_LOGIC;
  signal \addrR_reg[7]_i_14_n_0\ : STD_LOGIC;
  signal \addrR_reg[7]_i_14_n_1\ : STD_LOGIC;
  signal \addrR_reg[7]_i_14_n_2\ : STD_LOGIC;
  signal \addrR_reg[7]_i_14_n_3\ : STD_LOGIC;
  signal \addrR_reg[7]_i_4_n_0\ : STD_LOGIC;
  signal \addrR_reg[7]_i_4_n_1\ : STD_LOGIC;
  signal \addrR_reg[7]_i_4_n_2\ : STD_LOGIC;
  signal \addrR_reg[7]_i_4_n_3\ : STD_LOGIC;
  signal \addrR_reg_n_0_[0]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[10]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[11]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[12]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[13]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[14]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[15]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[16]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[17]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[18]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[19]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[1]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[20]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[21]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[22]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[23]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[24]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[25]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[26]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[27]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[28]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[29]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[2]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[30]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[31]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[3]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[4]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[5]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[6]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[7]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[8]\ : STD_LOGIC;
  signal \addrR_reg_n_0_[9]\ : STD_LOGIC;
  signal addrWT : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal addrWT0 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal \addrWT0_carry__0_n_0\ : STD_LOGIC;
  signal \addrWT0_carry__0_n_1\ : STD_LOGIC;
  signal \addrWT0_carry__0_n_2\ : STD_LOGIC;
  signal \addrWT0_carry__0_n_3\ : STD_LOGIC;
  signal \addrWT0_carry__1_n_0\ : STD_LOGIC;
  signal \addrWT0_carry__1_n_1\ : STD_LOGIC;
  signal \addrWT0_carry__1_n_2\ : STD_LOGIC;
  signal \addrWT0_carry__1_n_3\ : STD_LOGIC;
  signal \addrWT0_carry__2_n_0\ : STD_LOGIC;
  signal \addrWT0_carry__2_n_1\ : STD_LOGIC;
  signal \addrWT0_carry__2_n_2\ : STD_LOGIC;
  signal \addrWT0_carry__2_n_3\ : STD_LOGIC;
  signal \addrWT0_carry__3_n_0\ : STD_LOGIC;
  signal \addrWT0_carry__3_n_1\ : STD_LOGIC;
  signal \addrWT0_carry__3_n_2\ : STD_LOGIC;
  signal \addrWT0_carry__3_n_3\ : STD_LOGIC;
  signal \addrWT0_carry__4_n_0\ : STD_LOGIC;
  signal \addrWT0_carry__4_n_1\ : STD_LOGIC;
  signal \addrWT0_carry__4_n_2\ : STD_LOGIC;
  signal \addrWT0_carry__4_n_3\ : STD_LOGIC;
  signal \addrWT0_carry__5_n_0\ : STD_LOGIC;
  signal \addrWT0_carry__5_n_1\ : STD_LOGIC;
  signal \addrWT0_carry__5_n_2\ : STD_LOGIC;
  signal \addrWT0_carry__5_n_3\ : STD_LOGIC;
  signal \addrWT0_carry__6_n_2\ : STD_LOGIC;
  signal \addrWT0_carry__6_n_3\ : STD_LOGIC;
  signal addrWT0_carry_i_1_n_0 : STD_LOGIC;
  signal addrWT0_carry_n_0 : STD_LOGIC;
  signal addrWT0_carry_n_1 : STD_LOGIC;
  signal addrWT0_carry_n_2 : STD_LOGIC;
  signal addrWT0_carry_n_3 : STD_LOGIC;
  signal \addrWT[0]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[10]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[11]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[12]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[13]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[14]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[15]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[16]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[17]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[18]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[19]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[1]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[20]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[21]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[22]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[23]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[24]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[25]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[26]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[27]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[28]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[29]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[2]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[30]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[31]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[31]_i_2_n_0\ : STD_LOGIC;
  signal \addrWT[3]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[4]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[5]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[6]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[7]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[8]_i_1_n_0\ : STD_LOGIC;
  signal \addrWT[9]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[0]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[0]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[0]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[10]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[10]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[10]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[11]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[11]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[11]_i_4_n_0\ : STD_LOGIC;
  signal \addrW[12]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[12]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[12]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[13]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[13]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[13]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[14]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[14]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[14]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[15]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[15]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[15]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[15]_i_5_n_0\ : STD_LOGIC;
  signal \addrW[15]_i_6_n_0\ : STD_LOGIC;
  signal \addrW[16]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[16]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[16]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[17]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[17]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[17]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[18]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[18]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[18]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[19]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[19]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[19]_i_4_n_0\ : STD_LOGIC;
  signal \addrW[1]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[1]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[1]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[20]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[20]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[20]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[21]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[21]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[21]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[22]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[22]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[22]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[23]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[23]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[23]_i_4_n_0\ : STD_LOGIC;
  signal \addrW[24]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[24]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[24]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[25]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[25]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[25]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[26]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[26]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[26]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[27]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[27]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[27]_i_4_n_0\ : STD_LOGIC;
  signal \addrW[28]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[28]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[28]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[29]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[29]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[29]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[2]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[2]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[2]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[2]_i_5_n_0\ : STD_LOGIC;
  signal \addrW[2]_i_6_n_0\ : STD_LOGIC;
  signal \addrW[2]_i_7_n_0\ : STD_LOGIC;
  signal \addrW[2]_i_8_n_0\ : STD_LOGIC;
  signal \addrW[2]_i_9_n_0\ : STD_LOGIC;
  signal \addrW[30]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[30]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[30]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[31]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[31]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[31]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[31]_i_5_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_10_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_11_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_12_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_13_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_5_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_6_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_7_n_0\ : STD_LOGIC;
  signal \addrW[3]_i_9_n_0\ : STD_LOGIC;
  signal \addrW[4]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[4]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[4]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[4]_i_4_n_0\ : STD_LOGIC;
  signal \addrW[5]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[5]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[5]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[5]_i_4_n_0\ : STD_LOGIC;
  signal \addrW[6]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[6]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[6]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[6]_i_4_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_10_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_11_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_12_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_13_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_15_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_16_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_17_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_18_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_5_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_6_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_8_n_0\ : STD_LOGIC;
  signal \addrW[7]_i_9_n_0\ : STD_LOGIC;
  signal \addrW[8]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[8]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[8]_i_3_n_0\ : STD_LOGIC;
  signal \addrW[9]_i_1_n_0\ : STD_LOGIC;
  signal \addrW[9]_i_2_n_0\ : STD_LOGIC;
  signal \addrW[9]_i_3_n_0\ : STD_LOGIC;
  signal \addrW_reg[11]_i_3_n_0\ : STD_LOGIC;
  signal \addrW_reg[11]_i_3_n_1\ : STD_LOGIC;
  signal \addrW_reg[11]_i_3_n_2\ : STD_LOGIC;
  signal \addrW_reg[11]_i_3_n_3\ : STD_LOGIC;
  signal \addrW_reg[11]_i_9_n_0\ : STD_LOGIC;
  signal \addrW_reg[11]_i_9_n_1\ : STD_LOGIC;
  signal \addrW_reg[11]_i_9_n_2\ : STD_LOGIC;
  signal \addrW_reg[11]_i_9_n_3\ : STD_LOGIC;
  signal \addrW_reg[15]_i_11_n_0\ : STD_LOGIC;
  signal \addrW_reg[15]_i_11_n_1\ : STD_LOGIC;
  signal \addrW_reg[15]_i_11_n_2\ : STD_LOGIC;
  signal \addrW_reg[15]_i_11_n_3\ : STD_LOGIC;
  signal \addrW_reg[15]_i_4_n_0\ : STD_LOGIC;
  signal \addrW_reg[15]_i_4_n_1\ : STD_LOGIC;
  signal \addrW_reg[15]_i_4_n_2\ : STD_LOGIC;
  signal \addrW_reg[15]_i_4_n_3\ : STD_LOGIC;
  signal \addrW_reg[19]_i_3_n_0\ : STD_LOGIC;
  signal \addrW_reg[19]_i_3_n_1\ : STD_LOGIC;
  signal \addrW_reg[19]_i_3_n_2\ : STD_LOGIC;
  signal \addrW_reg[19]_i_3_n_3\ : STD_LOGIC;
  signal \addrW_reg[19]_i_9_n_0\ : STD_LOGIC;
  signal \addrW_reg[19]_i_9_n_1\ : STD_LOGIC;
  signal \addrW_reg[19]_i_9_n_2\ : STD_LOGIC;
  signal \addrW_reg[19]_i_9_n_3\ : STD_LOGIC;
  signal \addrW_reg[23]_i_3_n_0\ : STD_LOGIC;
  signal \addrW_reg[23]_i_3_n_1\ : STD_LOGIC;
  signal \addrW_reg[23]_i_3_n_2\ : STD_LOGIC;
  signal \addrW_reg[23]_i_3_n_3\ : STD_LOGIC;
  signal \addrW_reg[23]_i_9_n_0\ : STD_LOGIC;
  signal \addrW_reg[23]_i_9_n_1\ : STD_LOGIC;
  signal \addrW_reg[23]_i_9_n_2\ : STD_LOGIC;
  signal \addrW_reg[23]_i_9_n_3\ : STD_LOGIC;
  signal \addrW_reg[27]_i_3_n_0\ : STD_LOGIC;
  signal \addrW_reg[27]_i_3_n_1\ : STD_LOGIC;
  signal \addrW_reg[27]_i_3_n_2\ : STD_LOGIC;
  signal \addrW_reg[27]_i_3_n_3\ : STD_LOGIC;
  signal \addrW_reg[27]_i_9_n_0\ : STD_LOGIC;
  signal \addrW_reg[27]_i_9_n_1\ : STD_LOGIC;
  signal \addrW_reg[27]_i_9_n_2\ : STD_LOGIC;
  signal \addrW_reg[27]_i_9_n_3\ : STD_LOGIC;
  signal \addrW_reg[2]_i_4_n_0\ : STD_LOGIC;
  signal \addrW_reg[2]_i_4_n_1\ : STD_LOGIC;
  signal \addrW_reg[2]_i_4_n_2\ : STD_LOGIC;
  signal \addrW_reg[2]_i_4_n_3\ : STD_LOGIC;
  signal \addrW_reg[31]_i_10_n_1\ : STD_LOGIC;
  signal \addrW_reg[31]_i_10_n_2\ : STD_LOGIC;
  signal \addrW_reg[31]_i_10_n_3\ : STD_LOGIC;
  signal \addrW_reg[31]_i_4_n_1\ : STD_LOGIC;
  signal \addrW_reg[31]_i_4_n_2\ : STD_LOGIC;
  signal \addrW_reg[31]_i_4_n_3\ : STD_LOGIC;
  signal \addrW_reg[3]_i_4_n_0\ : STD_LOGIC;
  signal \addrW_reg[3]_i_4_n_1\ : STD_LOGIC;
  signal \addrW_reg[3]_i_4_n_2\ : STD_LOGIC;
  signal \addrW_reg[3]_i_4_n_3\ : STD_LOGIC;
  signal \addrW_reg[7]_i_14_n_0\ : STD_LOGIC;
  signal \addrW_reg[7]_i_14_n_1\ : STD_LOGIC;
  signal \addrW_reg[7]_i_14_n_2\ : STD_LOGIC;
  signal \addrW_reg[7]_i_14_n_3\ : STD_LOGIC;
  signal \addrW_reg[7]_i_4_n_0\ : STD_LOGIC;
  signal \addrW_reg[7]_i_4_n_1\ : STD_LOGIC;
  signal \addrW_reg[7]_i_4_n_2\ : STD_LOGIC;
  signal \addrW_reg[7]_i_4_n_3\ : STD_LOGIC;
  signal beatR : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \beatR[1]_i_1_n_0\ : STD_LOGIC;
  signal \beatR[5]_i_2_n_0\ : STD_LOGIC;
  signal \beatR[6]_i_1_n_0\ : STD_LOGIC;
  signal \beatR[7]_i_1_n_0\ : STD_LOGIC;
  signal \beatR[7]_i_3_n_0\ : STD_LOGIC;
  signal beatW : STD_LOGIC;
  signal \beatW[0]_i_1_n_0\ : STD_LOGIC;
  signal \beatW[1]_i_1_n_0\ : STD_LOGIC;
  signal \beatW[2]_i_1_n_0\ : STD_LOGIC;
  signal \beatW[3]_i_1_n_0\ : STD_LOGIC;
  signal \beatW[4]_i_1_n_0\ : STD_LOGIC;
  signal \beatW[4]_i_2_n_0\ : STD_LOGIC;
  signal \beatW[5]_i_1_n_0\ : STD_LOGIC;
  signal \beatW[5]_i_2_n_0\ : STD_LOGIC;
  signal \beatW[6]_i_1_n_0\ : STD_LOGIC;
  signal \beatW[7]_i_2_n_0\ : STD_LOGIC;
  signal \beatW[7]_i_3_n_0\ : STD_LOGIC;
  signal \beatW_reg_n_0_[0]\ : STD_LOGIC;
  signal \beatW_reg_n_0_[1]\ : STD_LOGIC;
  signal \beatW_reg_n_0_[2]\ : STD_LOGIC;
  signal \beatW_reg_n_0_[3]\ : STD_LOGIC;
  signal \beatW_reg_n_0_[4]\ : STD_LOGIC;
  signal \beatW_reg_n_0_[5]\ : STD_LOGIC;
  signal \beatW_reg_n_0_[6]\ : STD_LOGIC;
  signal \beatW_reg_n_0_[7]\ : STD_LOGIC;
  signal get_next_addr_rd0 : STD_LOGIC_VECTOR ( 29 downto 1 );
  signal get_next_addr_rd00_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \get_next_addr_rd0_carry__0_n_0\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__0_n_1\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__0_n_2\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__0_n_3\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__1_n_0\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__1_n_1\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__1_n_2\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__1_n_3\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__2_n_0\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__2_n_1\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__2_n_2\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__2_n_3\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__3_n_0\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__3_n_1\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__3_n_2\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__3_n_3\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__4_n_0\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__4_n_1\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__4_n_2\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__4_n_3\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__5_n_0\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__5_n_1\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__5_n_2\ : STD_LOGIC;
  signal \get_next_addr_rd0_carry__5_n_3\ : STD_LOGIC;
  signal get_next_addr_rd0_carry_n_0 : STD_LOGIC;
  signal get_next_addr_rd0_carry_n_1 : STD_LOGIC;
  signal get_next_addr_rd0_carry_n_2 : STD_LOGIC;
  signal get_next_addr_rd0_carry_n_3 : STD_LOGIC;
  signal get_next_addr_rd2 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal get_next_addr_rd3 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal get_next_addr_wr0 : STD_LOGIC_VECTOR ( 29 downto 1 );
  signal get_next_addr_wr00_in : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \get_next_addr_wr0_carry__0_n_0\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__0_n_1\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__0_n_2\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__0_n_3\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__1_n_0\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__1_n_1\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__1_n_2\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__1_n_3\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__2_n_0\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__2_n_1\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__2_n_2\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__2_n_3\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__3_n_0\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__3_n_1\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__3_n_2\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__3_n_3\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__4_n_0\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__4_n_1\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__4_n_2\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__4_n_3\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__5_n_0\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__5_n_1\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__5_n_2\ : STD_LOGIC;
  signal \get_next_addr_wr0_carry__5_n_3\ : STD_LOGIC;
  signal get_next_addr_wr0_carry_n_0 : STD_LOGIC;
  signal get_next_addr_wr0_carry_n_1 : STD_LOGIC;
  signal get_next_addr_wr0_carry_n_2 : STD_LOGIC;
  signal get_next_addr_wr0_carry_n_3 : STD_LOGIC;
  signal get_next_addr_wr2 : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal get_next_addr_wr3 : STD_LOGIC_VECTOR ( 31 downto 1 );
  signal grant_read_i_1_n_0 : STD_LOGIC;
  signal grant_read_i_2_n_0 : STD_LOGIC;
  signal grant_read_i_3_n_0 : STD_LOGIC;
  signal grant_write_i_1_n_0 : STD_LOGIC;
  signal grant_write_i_2_n_0 : STD_LOGIC;
  signal \i__carry__0_i_10_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_11_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_12_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_13_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_14_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_15_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_16_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_17_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_18_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_19_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_20_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_5_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_6_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_7_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_8_n_0\ : STD_LOGIC;
  signal \i__carry__0_i_9_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_10_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_11_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_12_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_13_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_14_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_15_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_16_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_4_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_5_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_6_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_7_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_8_n_0\ : STD_LOGIC;
  signal \i__carry__1_i_9_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_1_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_2_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_3_n_0\ : STD_LOGIC;
  signal \i__carry__2_i_4_n_0\ : STD_LOGIC;
  signal \i__carry_i_10_n_0\ : STD_LOGIC;
  signal \i__carry_i_11_n_0\ : STD_LOGIC;
  signal \i__carry_i_12_n_0\ : STD_LOGIC;
  signal \i__carry_i_13_n_0\ : STD_LOGIC;
  signal \i__carry_i_1_n_0\ : STD_LOGIC;
  signal \i__carry_i_2_n_0\ : STD_LOGIC;
  signal \i__carry_i_3_n_0\ : STD_LOGIC;
  signal \i__carry_i_4_n_0\ : STD_LOGIC;
  signal \i__carry_i_5_n_0\ : STD_LOGIC;
  signal \i__carry_i_6_n_0\ : STD_LOGIC;
  signal \i__carry_i_7_n_0\ : STD_LOGIC;
  signal \i__carry_i_8_n_0\ : STD_LOGIC;
  signal \i__carry_i_9_n_0\ : STD_LOGIC;
  signal p_0_in : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal p_0_out : STD_LOGIC_VECTOR ( 14 downto 2 );
  signal p_1_in : STD_LOGIC_VECTOR ( 7 downto 0 );
  signal \p_1_out_carry__0_i_10_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_11_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_12_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_13_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_14_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_15_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_16_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_17_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_18_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_19_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_20_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_21_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_5_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_6_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_7_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_8_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_i_9_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__0_n_1\ : STD_LOGIC;
  signal \p_1_out_carry__0_n_2\ : STD_LOGIC;
  signal \p_1_out_carry__0_n_3\ : STD_LOGIC;
  signal \p_1_out_carry__0_n_4\ : STD_LOGIC;
  signal \p_1_out_carry__0_n_5\ : STD_LOGIC;
  signal \p_1_out_carry__0_n_6\ : STD_LOGIC;
  signal \p_1_out_carry__0_n_7\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_10_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_11_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_12_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_13_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_14_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_15_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_16_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_5_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_6_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_7_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_8_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_i_9_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__1_n_1\ : STD_LOGIC;
  signal \p_1_out_carry__1_n_2\ : STD_LOGIC;
  signal \p_1_out_carry__1_n_3\ : STD_LOGIC;
  signal \p_1_out_carry__1_n_4\ : STD_LOGIC;
  signal \p_1_out_carry__1_n_5\ : STD_LOGIC;
  signal \p_1_out_carry__1_n_6\ : STD_LOGIC;
  signal \p_1_out_carry__1_n_7\ : STD_LOGIC;
  signal \p_1_out_carry__2_i_1_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__2_i_3_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__2_i_4_n_0\ : STD_LOGIC;
  signal \p_1_out_carry__2_n_1\ : STD_LOGIC;
  signal \p_1_out_carry__2_n_3\ : STD_LOGIC;
  signal \p_1_out_carry__2_n_6\ : STD_LOGIC;
  signal \p_1_out_carry__2_n_7\ : STD_LOGIC;
  signal p_1_out_carry_i_10_n_0 : STD_LOGIC;
  signal p_1_out_carry_i_11_n_0 : STD_LOGIC;
  signal p_1_out_carry_i_12_n_0 : STD_LOGIC;
  signal p_1_out_carry_i_13_n_0 : STD_LOGIC;
  signal p_1_out_carry_i_1_n_0 : STD_LOGIC;
  signal p_1_out_carry_i_6_n_0 : STD_LOGIC;
  signal p_1_out_carry_i_7_n_0 : STD_LOGIC;
  signal p_1_out_carry_i_8_n_0 : STD_LOGIC;
  signal p_1_out_carry_i_9_n_0 : STD_LOGIC;
  signal p_1_out_carry_n_0 : STD_LOGIC;
  signal p_1_out_carry_n_1 : STD_LOGIC;
  signal p_1_out_carry_n_2 : STD_LOGIC;
  signal p_1_out_carry_n_3 : STD_LOGIC;
  signal p_1_out_carry_n_4 : STD_LOGIC;
  signal p_1_out_carry_n_5 : STD_LOGIC;
  signal p_1_out_carry_n_6 : STD_LOGIC;
  signal p_1_out_carry_n_7 : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__0_n_0\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__0_n_1\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__0_n_2\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__0_n_3\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__0_n_4\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__0_n_5\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__0_n_6\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__0_n_7\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__1_n_0\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__1_n_1\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__1_n_2\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__1_n_3\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__1_n_4\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__1_n_5\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__1_n_6\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__1_n_7\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__2_n_1\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__2_n_3\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__2_n_6\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry__2_n_7\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry_n_0\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry_n_1\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry_n_2\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry_n_3\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry_n_4\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry_n_5\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry_n_6\ : STD_LOGIC;
  signal \p_1_out_inferred__0/i__carry_n_7\ : STD_LOGIC;
  signal \^s_axi_arready\ : STD_LOGIC;
  signal \^s_axi_awready\ : STD_LOGIC;
  signal \^s_axi_bresp\ : STD_LOGIC_VECTOR ( 0 to 0 );
  signal \^s_axi_bvalid\ : STD_LOGIC;
  signal \^s_axi_rlast\ : STD_LOGIC;
  signal \^s_axi_rresp\ : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal \^s_axi_rvalid\ : STD_LOGIC;
  signal \^s_axi_wready\ : STD_LOGIC;
  signal state : STD_LOGIC_VECTOR ( 1 downto 0 );
  signal stateR : STD_LOGIC;
  signal \stateR[0]_i_1_n_0\ : STD_LOGIC;
  signal \stateR[0]_i_2_n_0\ : STD_LOGIC;
  signal \stateR[1]_i_1_n_0\ : STD_LOGIC;
  signal \stateR[2]_i_1_n_0\ : STD_LOGIC;
  signal \stateR_reg_n_0_[0]\ : STD_LOGIC;
  signal \stateR_reg_n_0_[1]\ : STD_LOGIC;
  signal \stateR_reg_n_0_[2]\ : STD_LOGIC;
  signal stateW : STD_LOGIC;
  signal \stateW[0]_i_1_n_0\ : STD_LOGIC;
  signal \stateW[0]_i_2_n_0\ : STD_LOGIC;
  signal \stateW[0]_i_3_n_0\ : STD_LOGIC;
  signal \stateW[1]_i_1_n_0\ : STD_LOGIC;
  signal \stateW[1]_i_2_n_0\ : STD_LOGIC;
  signal \stateW[2]_i_1_n_0\ : STD_LOGIC;
  signal \stateW[2]_i_2_n_0\ : STD_LOGIC;
  signal \stateW[2]_i_4_n_0\ : STD_LOGIC;
  signal \stateW[2]_i_5_n_0\ : STD_LOGIC;
  signal \stateW[2]_i_6_n_0\ : STD_LOGIC;
  signal \stateW_reg_n_0_[0]\ : STD_LOGIC;
  signal \stateW_reg_n_0_[1]\ : STD_LOGIC;
  signal \stateW_reg_n_0_[2]\ : STD_LOGIC;
  signal tickR : STD_LOGIC;
  signal \tickR[0]_i_1_n_0\ : STD_LOGIC;
  signal \tickR[1]_i_1_n_0\ : STD_LOGIC;
  signal \tickR[2]_i_1_n_0\ : STD_LOGIC;
  signal \tickR[3]_i_2_n_0\ : STD_LOGIC;
  signal \tickR[3]_i_3_n_0\ : STD_LOGIC;
  signal \tickR_reg_n_0_[0]\ : STD_LOGIC;
  signal \tickR_reg_n_0_[1]\ : STD_LOGIC;
  signal \tickR_reg_n_0_[2]\ : STD_LOGIC;
  signal \tickR_reg_n_0_[3]\ : STD_LOGIC;
  signal tickW : STD_LOGIC;
  signal \tickW[0]_i_1_n_0\ : STD_LOGIC;
  signal \tickW[1]_i_1_n_0\ : STD_LOGIC;
  signal \tickW[2]_i_1_n_0\ : STD_LOGIC;
  signal \tickW[3]_i_2_n_0\ : STD_LOGIC;
  signal \tickW[3]_i_3_n_0\ : STD_LOGIC;
  signal \tickW_reg_n_0_[0]\ : STD_LOGIC;
  signal \tickW_reg_n_0_[1]\ : STD_LOGIC;
  signal \tickW_reg_n_0_[2]\ : STD_LOGIC;
  signal \tickW_reg_n_0_[3]\ : STD_LOGIC;
  signal NLW_ARSTRB_reg1_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal NLW_BID0_carry_O_UNCONNECTED : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_addrRT0_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_addrRT0_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_addrR_reg[31]_i_11_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_addrR_reg[31]_i_5_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_addrWT0_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_addrWT0_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_addrW_reg[31]_i_10_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_addrW_reg[31]_i_4_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 to 3 );
  signal \NLW_get_next_addr_rd0_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_get_next_addr_rd0_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_get_next_addr_wr0_carry__6_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \NLW_get_next_addr_wr0_carry__6_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_p_1_out_carry__2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_p_1_out_carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  signal \NLW_p_1_out_inferred__0/i__carry__2_CO_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 1 );
  signal \NLW_p_1_out_inferred__0/i__carry__2_O_UNCONNECTED\ : STD_LOGIC_VECTOR ( 3 downto 2 );
  attribute SOFT_HLUTNM : string;
  attribute SOFT_HLUTNM of ACK_i_1 : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of ARREADY_i_2 : label is "soft_lutpair13";
  attribute COMPARATOR_THRESHOLD : integer;
  attribute COMPARATOR_THRESHOLD of ARSTRB_reg1_carry : label is 11;
  attribute SOFT_HLUTNM of \ARSTRB_reg[1]_i_3\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \ARSTRB_reg[3]_i_4\ : label is "soft_lutpair17";
  attribute COMPARATOR_THRESHOLD of BID0_carry : label is 11;
  attribute METHODOLOGY_DRC_VIOS : string;
  attribute METHODOLOGY_DRC_VIOS of BID0_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \DATAR[31]_i_10\ : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of \DATAR[31]_i_11\ : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \DATAR[31]_i_6\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \DATAR[31]_i_8\ : label is "soft_lutpair8";
  attribute SOFT_HLUTNM of \FSM_sequential_state[0]_i_1\ : label is "soft_lutpair26";
  attribute SOFT_HLUTNM of \FSM_sequential_state[1]_i_1\ : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \FSM_sequential_state[1]_i_2\ : label is "soft_lutpair29";
  attribute FSM_ENCODED_STATES : string;
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[0]\ : label is "ST_ADDR:01,ST_WAIT:10,ST_IDLE:00,ST_END:11";
  attribute FSM_ENCODED_STATES of \FSM_sequential_state_reg[1]\ : label is "ST_ADDR:01,ST_WAIT:10,ST_IDLE:00,ST_END:11";
  attribute SOFT_HLUTNM of M0_APB_PSEL_INST_0_i_2 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of M0_APB_PSEL_INST_0_i_4 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of M0_APB_PSEL_INST_0_i_5 : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of M1_APB_PSEL_INST_0_i_2 : label is "soft_lutpair10";
  attribute SOFT_HLUTNM of M1_APB_PSEL_INST_0_i_3 : label is "soft_lutpair11";
  attribute SOFT_HLUTNM of M1_APB_PSEL_INST_0_i_4 : label is "soft_lutpair75";
  attribute SOFT_HLUTNM of M2_APB_PSEL_INST_0_i_2 : label is "soft_lutpair9";
  attribute SOFT_HLUTNM of M2_APB_PSEL_INST_0_i_3 : label is "soft_lutpair74";
  attribute SOFT_HLUTNM of \M_PADDR[0]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \M_PADDR[10]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \M_PADDR[11]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \M_PADDR[12]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \M_PADDR[13]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \M_PADDR[14]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \M_PADDR[15]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \M_PADDR[16]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \M_PADDR[17]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \M_PADDR[18]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \M_PADDR[19]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \M_PADDR[1]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \M_PADDR[20]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \M_PADDR[21]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \M_PADDR[22]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \M_PADDR[23]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \M_PADDR[24]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \M_PADDR[25]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \M_PADDR[26]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \M_PADDR[27]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \M_PADDR[28]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \M_PADDR[29]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \M_PADDR[2]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \M_PADDR[30]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \M_PADDR[31]_i_2\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \M_PADDR[3]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \M_PADDR[4]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \M_PADDR[5]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \M_PADDR[6]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of \M_PADDR[7]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \M_PADDR[8]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \M_PADDR[9]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of M_PSEL_i_1 : label is "soft_lutpair27";
  attribute SOFT_HLUTNM of \M_PSTRB[0]_i_1\ : label is "soft_lutpair41";
  attribute SOFT_HLUTNM of \M_PSTRB[1]_i_1\ : label is "soft_lutpair40";
  attribute SOFT_HLUTNM of \M_PSTRB[2]_i_1\ : label is "soft_lutpair39";
  attribute SOFT_HLUTNM of \M_PSTRB[3]_i_1\ : label is "soft_lutpair29";
  attribute SOFT_HLUTNM of \M_PWDATA[0]_i_1\ : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \M_PWDATA[10]_i_1\ : label is "soft_lutpair63";
  attribute SOFT_HLUTNM of \M_PWDATA[11]_i_1\ : label is "soft_lutpair62";
  attribute SOFT_HLUTNM of \M_PWDATA[12]_i_1\ : label is "soft_lutpair61";
  attribute SOFT_HLUTNM of \M_PWDATA[13]_i_1\ : label is "soft_lutpair60";
  attribute SOFT_HLUTNM of \M_PWDATA[14]_i_1\ : label is "soft_lutpair59";
  attribute SOFT_HLUTNM of \M_PWDATA[15]_i_1\ : label is "soft_lutpair58";
  attribute SOFT_HLUTNM of \M_PWDATA[16]_i_1\ : label is "soft_lutpair57";
  attribute SOFT_HLUTNM of \M_PWDATA[17]_i_1\ : label is "soft_lutpair56";
  attribute SOFT_HLUTNM of \M_PWDATA[18]_i_1\ : label is "soft_lutpair55";
  attribute SOFT_HLUTNM of \M_PWDATA[19]_i_1\ : label is "soft_lutpair54";
  attribute SOFT_HLUTNM of \M_PWDATA[1]_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \M_PWDATA[20]_i_1\ : label is "soft_lutpair53";
  attribute SOFT_HLUTNM of \M_PWDATA[21]_i_1\ : label is "soft_lutpair52";
  attribute SOFT_HLUTNM of \M_PWDATA[22]_i_1\ : label is "soft_lutpair51";
  attribute SOFT_HLUTNM of \M_PWDATA[23]_i_1\ : label is "soft_lutpair50";
  attribute SOFT_HLUTNM of \M_PWDATA[24]_i_1\ : label is "soft_lutpair49";
  attribute SOFT_HLUTNM of \M_PWDATA[25]_i_1\ : label is "soft_lutpair48";
  attribute SOFT_HLUTNM of \M_PWDATA[26]_i_1\ : label is "soft_lutpair47";
  attribute SOFT_HLUTNM of \M_PWDATA[27]_i_1\ : label is "soft_lutpair46";
  attribute SOFT_HLUTNM of \M_PWDATA[28]_i_1\ : label is "soft_lutpair45";
  attribute SOFT_HLUTNM of \M_PWDATA[29]_i_1\ : label is "soft_lutpair44";
  attribute SOFT_HLUTNM of \M_PWDATA[2]_i_1\ : label is "soft_lutpair108";
  attribute SOFT_HLUTNM of \M_PWDATA[30]_i_1\ : label is "soft_lutpair43";
  attribute SOFT_HLUTNM of \M_PWDATA[31]_i_1\ : label is "soft_lutpair42";
  attribute SOFT_HLUTNM of \M_PWDATA[3]_i_1\ : label is "soft_lutpair70";
  attribute SOFT_HLUTNM of \M_PWDATA[4]_i_1\ : label is "soft_lutpair69";
  attribute SOFT_HLUTNM of \M_PWDATA[5]_i_1\ : label is "soft_lutpair68";
  attribute SOFT_HLUTNM of \M_PWDATA[6]_i_1\ : label is "soft_lutpair67";
  attribute SOFT_HLUTNM of \M_PWDATA[7]_i_1\ : label is "soft_lutpair66";
  attribute SOFT_HLUTNM of \M_PWDATA[8]_i_1\ : label is "soft_lutpair65";
  attribute SOFT_HLUTNM of \M_PWDATA[9]_i_1\ : label is "soft_lutpair64";
  attribute SOFT_HLUTNM of M_PWRITE_i_1 : label is "soft_lutpair109";
  attribute SOFT_HLUTNM of \RDATA[0]_i_1\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \RDATA[10]_i_1\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \RDATA[11]_i_1\ : label is "soft_lutpair97";
  attribute SOFT_HLUTNM of \RDATA[12]_i_1\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \RDATA[13]_i_1\ : label is "soft_lutpair98";
  attribute SOFT_HLUTNM of \RDATA[14]_i_1\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \RDATA[15]_i_1\ : label is "soft_lutpair99";
  attribute SOFT_HLUTNM of \RDATA[16]_i_1\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \RDATA[17]_i_1\ : label is "soft_lutpair100";
  attribute SOFT_HLUTNM of \RDATA[18]_i_1\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \RDATA[19]_i_1\ : label is "soft_lutpair101";
  attribute SOFT_HLUTNM of \RDATA[1]_i_1\ : label is "soft_lutpair92";
  attribute SOFT_HLUTNM of \RDATA[20]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \RDATA[21]_i_1\ : label is "soft_lutpair102";
  attribute SOFT_HLUTNM of \RDATA[22]_i_1\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \RDATA[23]_i_1\ : label is "soft_lutpair103";
  attribute SOFT_HLUTNM of \RDATA[24]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \RDATA[25]_i_1\ : label is "soft_lutpair104";
  attribute SOFT_HLUTNM of \RDATA[26]_i_1\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \RDATA[27]_i_1\ : label is "soft_lutpair105";
  attribute SOFT_HLUTNM of \RDATA[28]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \RDATA[29]_i_1\ : label is "soft_lutpair106";
  attribute SOFT_HLUTNM of \RDATA[2]_i_1\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \RDATA[30]_i_1\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \RDATA[31]_i_2\ : label is "soft_lutpair107";
  attribute SOFT_HLUTNM of \RDATA[3]_i_1\ : label is "soft_lutpair93";
  attribute SOFT_HLUTNM of \RDATA[4]_i_1\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \RDATA[5]_i_1\ : label is "soft_lutpair94";
  attribute SOFT_HLUTNM of \RDATA[6]_i_1\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \RDATA[7]_i_1\ : label is "soft_lutpair95";
  attribute SOFT_HLUTNM of \RDATA[8]_i_1\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of \RDATA[9]_i_1\ : label is "soft_lutpair96";
  attribute SOFT_HLUTNM of RLAST_i_2 : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \RRESP[1]_i_1\ : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of Twen_i_2 : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \Twstrb[0]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \Twstrb[1]_i_1\ : label is "soft_lutpair111";
  attribute SOFT_HLUTNM of \Twstrb[2]_i_1\ : label is "soft_lutpair110";
  attribute SOFT_HLUTNM of \Twstrb[3]_i_1\ : label is "soft_lutpair110";
  attribute ADDER_THRESHOLD : integer;
  attribute ADDER_THRESHOLD of addrRT0_carry : label is 35;
  attribute METHODOLOGY_DRC_VIOS of addrRT0_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrRT0_carry__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrRT0_carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrRT0_carry__1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrRT0_carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrRT0_carry__2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrRT0_carry__2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrRT0_carry__3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrRT0_carry__3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrRT0_carry__4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrRT0_carry__4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrRT0_carry__5\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrRT0_carry__5\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrRT0_carry__6\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrRT0_carry__6\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \addrR[0]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \addrR[10]_i_1\ : label is "soft_lutpair80";
  attribute SOFT_HLUTNM of \addrR[11]_i_1\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \addrR[12]_i_1\ : label is "soft_lutpair81";
  attribute SOFT_HLUTNM of \addrR[13]_i_1\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \addrR[14]_i_1\ : label is "soft_lutpair82";
  attribute SOFT_HLUTNM of \addrR[15]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \addrR[16]_i_1\ : label is "soft_lutpair83";
  attribute SOFT_HLUTNM of \addrR[17]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \addrR[18]_i_1\ : label is "soft_lutpair84";
  attribute SOFT_HLUTNM of \addrR[19]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \addrR[1]_i_1\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \addrR[20]_i_1\ : label is "soft_lutpair85";
  attribute SOFT_HLUTNM of \addrR[21]_i_1\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \addrR[22]_i_1\ : label is "soft_lutpair86";
  attribute SOFT_HLUTNM of \addrR[23]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \addrR[24]_i_1\ : label is "soft_lutpair87";
  attribute SOFT_HLUTNM of \addrR[25]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \addrR[26]_i_1\ : label is "soft_lutpair88";
  attribute SOFT_HLUTNM of \addrR[27]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \addrR[28]_i_1\ : label is "soft_lutpair89";
  attribute SOFT_HLUTNM of \addrR[29]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \addrR[2]_i_1\ : label is "soft_lutpair76";
  attribute SOFT_HLUTNM of \addrR[30]_i_1\ : label is "soft_lutpair90";
  attribute SOFT_HLUTNM of \addrR[31]_i_2\ : label is "soft_lutpair91";
  attribute SOFT_HLUTNM of \addrR[3]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \addrR[3]_i_3\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \addrR[4]_i_1\ : label is "soft_lutpair77";
  attribute SOFT_HLUTNM of \addrR[4]_i_3\ : label is "soft_lutpair16";
  attribute SOFT_HLUTNM of \addrR[5]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \addrR[5]_i_3\ : label is "soft_lutpair17";
  attribute SOFT_HLUTNM of \addrR[6]_i_1\ : label is "soft_lutpair78";
  attribute SOFT_HLUTNM of \addrR[7]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \addrR[8]_i_1\ : label is "soft_lutpair79";
  attribute SOFT_HLUTNM of \addrR[9]_i_1\ : label is "soft_lutpair80";
  attribute ADDER_THRESHOLD of \addrR_reg[11]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrR_reg[11]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrR_reg[11]_i_9\ : label is 35;
  attribute ADDER_THRESHOLD of \addrR_reg[15]_i_10\ : label is 35;
  attribute ADDER_THRESHOLD of \addrR_reg[15]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrR_reg[15]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrR_reg[19]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrR_reg[19]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrR_reg[19]_i_9\ : label is 35;
  attribute ADDER_THRESHOLD of \addrR_reg[23]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrR_reg[23]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrR_reg[23]_i_9\ : label is 35;
  attribute ADDER_THRESHOLD of \addrR_reg[27]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrR_reg[27]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrR_reg[27]_i_9\ : label is 35;
  attribute ADDER_THRESHOLD of \addrR_reg[2]_i_4\ : label is 35;
  attribute ADDER_THRESHOLD of \addrR_reg[31]_i_11\ : label is 35;
  attribute ADDER_THRESHOLD of \addrR_reg[31]_i_5\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrR_reg[31]_i_5\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrR_reg[3]_i_4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrR_reg[3]_i_4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrR_reg[7]_i_14\ : label is 35;
  attribute ADDER_THRESHOLD of \addrR_reg[7]_i_4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrR_reg[7]_i_4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of addrWT0_carry : label is 35;
  attribute METHODOLOGY_DRC_VIOS of addrWT0_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrWT0_carry__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrWT0_carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrWT0_carry__1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrWT0_carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrWT0_carry__2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrWT0_carry__2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrWT0_carry__3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrWT0_carry__3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrWT0_carry__4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrWT0_carry__4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrWT0_carry__5\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrWT0_carry__5\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrWT0_carry__6\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrWT0_carry__6\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \addrW[0]_i_1\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \addrW[15]_i_3\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \addrW[2]_i_5\ : label is "soft_lutpair21";
  attribute SOFT_HLUTNM of \addrW[3]_i_3\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \addrW[4]_i_3\ : label is "soft_lutpair20";
  attribute SOFT_HLUTNM of \addrW[5]_i_3\ : label is "soft_lutpair21";
  attribute ADDER_THRESHOLD of \addrW_reg[11]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[11]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[11]_i_9\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[11]_i_9\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[15]_i_11\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[15]_i_11\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[15]_i_4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[15]_i_4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[19]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[19]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[19]_i_9\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[19]_i_9\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[23]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[23]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[23]_i_9\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[23]_i_9\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[27]_i_3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[27]_i_3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[27]_i_9\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[27]_i_9\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[2]_i_4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[2]_i_4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[31]_i_10\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[31]_i_10\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[31]_i_4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[31]_i_4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[3]_i_4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[3]_i_4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[7]_i_14\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[7]_i_14\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \addrW_reg[7]_i_4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \addrW_reg[7]_i_4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \beatR[0]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \beatR[1]_i_1\ : label is "soft_lutpair72";
  attribute SOFT_HLUTNM of \beatR[2]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \beatR[3]_i_1\ : label is "soft_lutpair25";
  attribute SOFT_HLUTNM of \beatR[6]_i_1\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \beatR[7]_i_2\ : label is "soft_lutpair38";
  attribute SOFT_HLUTNM of \beatW[0]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \beatW[1]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \beatW[2]_i_1\ : label is "soft_lutpair3";
  attribute SOFT_HLUTNM of \beatW[4]_i_2\ : label is "soft_lutpair36";
  attribute SOFT_HLUTNM of \beatW[5]_i_1\ : label is "soft_lutpair28";
  attribute SOFT_HLUTNM of \beatW[6]_i_1\ : label is "soft_lutpair2";
  attribute SOFT_HLUTNM of \beatW[7]_i_2\ : label is "soft_lutpair2";
  attribute ADDER_THRESHOLD of get_next_addr_rd0_carry : label is 35;
  attribute ADDER_THRESHOLD of \get_next_addr_rd0_carry__0\ : label is 35;
  attribute ADDER_THRESHOLD of \get_next_addr_rd0_carry__1\ : label is 35;
  attribute ADDER_THRESHOLD of \get_next_addr_rd0_carry__2\ : label is 35;
  attribute ADDER_THRESHOLD of \get_next_addr_rd0_carry__3\ : label is 35;
  attribute ADDER_THRESHOLD of \get_next_addr_rd0_carry__4\ : label is 35;
  attribute ADDER_THRESHOLD of \get_next_addr_rd0_carry__5\ : label is 35;
  attribute ADDER_THRESHOLD of \get_next_addr_rd0_carry__6\ : label is 35;
  attribute ADDER_THRESHOLD of get_next_addr_wr0_carry : label is 35;
  attribute METHODOLOGY_DRC_VIOS of get_next_addr_wr0_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \get_next_addr_wr0_carry__0\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \get_next_addr_wr0_carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \get_next_addr_wr0_carry__1\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \get_next_addr_wr0_carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \get_next_addr_wr0_carry__2\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \get_next_addr_wr0_carry__2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \get_next_addr_wr0_carry__3\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \get_next_addr_wr0_carry__3\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \get_next_addr_wr0_carry__4\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \get_next_addr_wr0_carry__4\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \get_next_addr_wr0_carry__5\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \get_next_addr_wr0_carry__5\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute ADDER_THRESHOLD of \get_next_addr_wr0_carry__6\ : label is 35;
  attribute METHODOLOGY_DRC_VIOS of \get_next_addr_wr0_carry__6\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of grant_read_i_2 : label is "soft_lutpair13";
  attribute SOFT_HLUTNM of grant_read_i_3 : label is "soft_lutpair7";
  attribute SOFT_HLUTNM of \i__carry__0_i_12\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \i__carry__0_i_14\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \i__carry__0_i_15\ : label is "soft_lutpair19";
  attribute SOFT_HLUTNM of \i__carry__0_i_17\ : label is "soft_lutpair5";
  attribute SOFT_HLUTNM of \i__carry__0_i_19\ : label is "soft_lutpair18";
  attribute SOFT_HLUTNM of \i__carry__0_i_20\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \i__carry__0_i_9\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \i__carry__1_i_10\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \i__carry__1_i_11\ : label is "soft_lutpair33";
  attribute SOFT_HLUTNM of \i__carry__1_i_12\ : label is "soft_lutpair34";
  attribute SOFT_HLUTNM of \i__carry__1_i_16\ : label is "soft_lutpair1";
  attribute SOFT_HLUTNM of \i__carry_i_10\ : label is "soft_lutpair35";
  attribute SOFT_HLUTNM of \i__carry_i_11\ : label is "soft_lutpair18";
  attribute METHODOLOGY_DRC_VIOS of p_1_out_carry : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \p_1_out_carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_10\ : label is "soft_lutpair71";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_12\ : label is "soft_lutpair15";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_13\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_14\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_15\ : label is "soft_lutpair4";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_16\ : label is "soft_lutpair0";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_20\ : label is "soft_lutpair14";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_21\ : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of \p_1_out_carry__0_i_9\ : label is "soft_lutpair30";
  attribute METHODOLOGY_DRC_VIOS of \p_1_out_carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \p_1_out_carry__1_i_10\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \p_1_out_carry__1_i_11\ : label is "soft_lutpair30";
  attribute SOFT_HLUTNM of \p_1_out_carry__1_i_12\ : label is "soft_lutpair31";
  attribute SOFT_HLUTNM of \p_1_out_carry__1_i_14\ : label is "soft_lutpair71";
  attribute METHODOLOGY_DRC_VIOS of \p_1_out_carry__2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of p_1_out_carry_i_10 : label is "soft_lutpair32";
  attribute SOFT_HLUTNM of p_1_out_carry_i_11 : label is "soft_lutpair14";
  attribute METHODOLOGY_DRC_VIOS of \p_1_out_inferred__0/i__carry\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \p_1_out_inferred__0/i__carry__0\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \p_1_out_inferred__0/i__carry__1\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute METHODOLOGY_DRC_VIOS of \p_1_out_inferred__0/i__carry__2\ : label is "{SYNTH-8 {cell *THIS*}}";
  attribute SOFT_HLUTNM of \stateR[1]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \stateR[2]_i_1\ : label is "soft_lutpair6";
  attribute SOFT_HLUTNM of \stateW[0]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \stateW[1]_i_1\ : label is "soft_lutpair73";
  attribute SOFT_HLUTNM of \stateW[2]_i_5\ : label is "soft_lutpair23";
  attribute SOFT_HLUTNM of \stateW[2]_i_6\ : label is "soft_lutpair12";
  attribute SOFT_HLUTNM of \tickR[0]_i_1\ : label is "soft_lutpair37";
  attribute SOFT_HLUTNM of \tickR[1]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \tickR[2]_i_1\ : label is "soft_lutpair22";
  attribute SOFT_HLUTNM of \tickW[0]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \tickW[1]_i_1\ : label is "soft_lutpair24";
  attribute SOFT_HLUTNM of \tickW[3]_i_3\ : label is "soft_lutpair12";
begin
  M0_APB_PADDR(31 downto 0) <= \^m0_apb_paddr\(31 downto 0);
  M2_APB_PENABLE <= \^m2_apb_penable\;
  \M_PADDR_reg[12]_0\ <= \^m_paddr_reg[12]_0\;
  \M_PADDR_reg[13]_0\ <= \^m_paddr_reg[13]_0\;
  s_axi_arready <= \^s_axi_arready\;
  s_axi_awready <= \^s_axi_awready\;
  s_axi_bresp(0) <= \^s_axi_bresp\(0);
  s_axi_bvalid <= \^s_axi_bvalid\;
  s_axi_rlast <= \^s_axi_rlast\;
  s_axi_rresp(1 downto 0) <= \^s_axi_rresp\(1 downto 0);
  s_axi_rvalid <= \^s_axi_rvalid\;
  s_axi_wready <= \^s_axi_wready\;
ACK_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"F3FF0044"
    )
        port map (
      I0 => \FSM_sequential_state[0]_i_2_n_0\,
      I1 => state(1),
      I2 => \FSM_sequential_state[1]_i_2_n_0\,
      I3 => state(0),
      I4 => ACK_reg_n_0,
      O => ACK_i_1_n_0
    );
ACK_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => '1',
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ACK_i_1_n_0,
      Q => ACK_reg_n_0
    );
\ARBURST_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arburst(0),
      Q => \ARBURST_reg_reg_n_0_[0]\
    );
\ARBURST_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arburst(1),
      Q => \ARBURST_reg_reg_n_0_[1]\
    );
\ARLEN_reg[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000010000"
    )
        port map (
      I0 => \stateR_reg_n_0_[0]\,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      I3 => s_axi_awvalid,
      I4 => s_axi_arvalid,
      I5 => p_0_in(1),
      O => \ARLEN_reg[7]_i_1_n_0\
    );
\ARLEN_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arlen(0),
      Q => ARLEN_reg(0)
    );
\ARLEN_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arlen(1),
      Q => ARLEN_reg(1)
    );
\ARLEN_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arlen(2),
      Q => ARLEN_reg(2)
    );
\ARLEN_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arlen(3),
      Q => ARLEN_reg(3)
    );
\ARLEN_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arlen(4),
      Q => ARLEN_reg(4)
    );
\ARLEN_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arlen(5),
      Q => ARLEN_reg(5)
    );
\ARLEN_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arlen(6),
      Q => ARLEN_reg(6)
    );
\ARLEN_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arlen(7),
      Q => ARLEN_reg(7)
    );
ARREADY_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FDFD0100"
    )
        port map (
      I0 => \stateR_reg_n_0_[0]\,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      I3 => ARREADY_i_2_n_0,
      I4 => \^s_axi_arready\,
      O => ARREADY_i_1_n_0
    );
ARREADY_i_2: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => s_axi_arvalid,
      I2 => p_0_in(1),
      O => ARREADY_i_2_n_0
    );
ARREADY_reg: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => ARREADY_i_1_n_0,
      Q => \^s_axi_arready\
    );
\ARSIZE_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arsize(0),
      Q => ARSIZE_reg(0)
    );
\ARSIZE_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arsize(1),
      Q => ARSIZE_reg(1)
    );
\ARSIZE_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARLEN_reg[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arsize(2),
      Q => ARSIZE_reg(2)
    );
ARSTRB_reg1_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => ARSTRB_reg1,
      CO(2) => ARSTRB_reg1_carry_n_1,
      CO(1) => ARSTRB_reg1_carry_n_2,
      CO(0) => ARSTRB_reg1_carry_n_3,
      CYINIT => '1',
      DI(3) => ARSTRB_reg1_carry_i_1_n_0,
      DI(2) => ARSTRB_reg1_carry_i_2_n_0,
      DI(1) => ARSTRB_reg1_carry_i_3_n_0,
      DI(0) => ARSTRB_reg1_carry_i_4_n_0,
      O(3 downto 0) => NLW_ARSTRB_reg1_carry_O_UNCONNECTED(3 downto 0),
      S(3) => ARSTRB_reg1_carry_i_5_n_0,
      S(2) => ARSTRB_reg1_carry_i_6_n_0,
      S(1) => ARSTRB_reg1_carry_i_7_n_0,
      S(0) => ARSTRB_reg1_carry_i_8_n_0
    );
ARSTRB_reg1_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => beatR(7),
      I1 => ARLEN_reg(7),
      I2 => beatR(6),
      I3 => ARLEN_reg(6),
      O => ARSTRB_reg1_carry_i_1_n_0
    );
ARSTRB_reg1_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => beatR(5),
      I1 => ARLEN_reg(5),
      I2 => beatR(4),
      I3 => ARLEN_reg(4),
      O => ARSTRB_reg1_carry_i_2_n_0
    );
ARSTRB_reg1_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => beatR(3),
      I1 => ARLEN_reg(3),
      I2 => beatR(2),
      I3 => ARLEN_reg(2),
      O => ARSTRB_reg1_carry_i_3_n_0
    );
ARSTRB_reg1_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => beatR(1),
      I1 => ARLEN_reg(1),
      I2 => beatR(0),
      I3 => ARLEN_reg(0),
      O => ARSTRB_reg1_carry_i_4_n_0
    );
ARSTRB_reg1_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => ARLEN_reg(7),
      I1 => beatR(7),
      I2 => ARLEN_reg(6),
      I3 => beatR(6),
      O => ARSTRB_reg1_carry_i_5_n_0
    );
ARSTRB_reg1_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => ARLEN_reg(5),
      I1 => beatR(5),
      I2 => ARLEN_reg(4),
      I3 => beatR(4),
      O => ARSTRB_reg1_carry_i_6_n_0
    );
ARSTRB_reg1_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => ARLEN_reg(3),
      I1 => beatR(3),
      I2 => ARLEN_reg(2),
      I3 => beatR(2),
      O => ARSTRB_reg1_carry_i_7_n_0
    );
ARSTRB_reg1_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => ARLEN_reg(1),
      I1 => beatR(1),
      I2 => ARLEN_reg(0),
      I3 => beatR(0),
      O => ARSTRB_reg1_carry_i_8_n_0
    );
\ARSTRB_reg[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1010101F"
    )
        port map (
      I0 => \addrR_reg_n_0_[1]\,
      I1 => \addrR_reg_n_0_[0]\,
      I2 => \stateR_reg_n_0_[0]\,
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      O => \ARSTRB_reg[0]_i_1_n_0\
    );
\ARSTRB_reg[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1F1111111F111F11"
    )
        port map (
      I0 => \ARSTRB_reg[1]_i_2_n_0\,
      I1 => s_axi_araddr(1),
      I2 => \addrR_reg_n_0_[1]\,
      I3 => \stateR_reg_n_0_[0]\,
      I4 => \addrR_reg_n_0_[0]\,
      I5 => \ARSTRB_reg[1]_i_3_n_0\,
      O => \ARSTRB_reg[1]_i_1_n_0\
    );
\ARSTRB_reg[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAAAAB"
    )
        port map (
      I0 => \stateR_reg_n_0_[0]\,
      I1 => s_axi_araddr(0),
      I2 => s_axi_arsize(0),
      I3 => s_axi_arsize(2),
      I4 => s_axi_arsize(1),
      O => \ARSTRB_reg[1]_i_2_n_0\
    );
\ARSTRB_reg[1]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      O => \ARSTRB_reg[1]_i_3_n_0\
    );
\ARSTRB_reg[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF70607040"
    )
        port map (
      I0 => \addrR_reg_n_0_[0]\,
      I1 => \addrR_reg_n_0_[1]\,
      I2 => \stateR_reg_n_0_[0]\,
      I3 => \ARSTRB_reg[3]_i_4_n_0\,
      I4 => ARSIZE_reg(0),
      I5 => \ARSTRB_reg[2]_i_2_n_0\,
      O => \ARSTRB_reg[2]_i_1_n_0\
    );
\ARSTRB_reg[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000000FEFFFC"
    )
        port map (
      I0 => s_axi_arsize(0),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      I3 => s_axi_araddr(1),
      I4 => s_axi_araddr(0),
      I5 => \stateR_reg_n_0_[0]\,
      O => \ARSTRB_reg[2]_i_2_n_0\
    );
\ARSTRB_reg[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAAAABAAAAAA"
    )
        port map (
      I0 => \ARLEN_reg[7]_i_1_n_0\,
      I1 => ARSTRB_reg1,
      I2 => ACK_reg_n_0,
      I3 => \stateR_reg_n_0_[0]\,
      I4 => \stateR_reg_n_0_[2]\,
      I5 => \stateR_reg_n_0_[1]\,
      O => \ARSTRB_reg[3]_i_1_n_0\
    );
\ARSTRB_reg[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEAAFEAAFEAAEEAA"
    )
        port map (
      I0 => \ARSTRB_reg[3]_i_3_n_0\,
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => \addrR_reg_n_0_[1]\,
      I3 => \stateR_reg_n_0_[0]\,
      I4 => \addrR_reg_n_0_[0]\,
      I5 => ARSIZE_reg(0),
      O => \ARSTRB_reg[3]_i_2_n_0\
    );
\ARSTRB_reg[3]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FEFEFEFC"
    )
        port map (
      I0 => s_axi_araddr(1),
      I1 => s_axi_arsize(1),
      I2 => s_axi_arsize(2),
      I3 => s_axi_arsize(0),
      I4 => s_axi_araddr(0),
      I5 => \stateR_reg_n_0_[0]\,
      O => \ARSTRB_reg[3]_i_3_n_0\
    );
\ARSTRB_reg[3]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => ARSIZE_reg(1),
      I1 => ARSIZE_reg(2),
      O => \ARSTRB_reg[3]_i_4_n_0\
    );
\ARSTRB_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARSTRB_reg[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \ARSTRB_reg[0]_i_1_n_0\,
      Q => ARSTRB_reg(0)
    );
\ARSTRB_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARSTRB_reg[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \ARSTRB_reg[1]_i_1_n_0\,
      Q => ARSTRB_reg(1)
    );
\ARSTRB_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARSTRB_reg[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \ARSTRB_reg[2]_i_1_n_0\,
      Q => ARSTRB_reg(2)
    );
\ARSTRB_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \ARSTRB_reg[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \ARSTRB_reg[3]_i_2_n_0\,
      Q => ARSTRB_reg(3)
    );
\AWADDR_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(0),
      Q => AWADDR_reg(0)
    );
\AWADDR_reg_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(10),
      Q => AWADDR_reg(10)
    );
\AWADDR_reg_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(11),
      Q => AWADDR_reg(11)
    );
\AWADDR_reg_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(12),
      Q => AWADDR_reg(12)
    );
\AWADDR_reg_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(13),
      Q => AWADDR_reg(13)
    );
\AWADDR_reg_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(14),
      Q => AWADDR_reg(14)
    );
\AWADDR_reg_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(15),
      Q => AWADDR_reg(15)
    );
\AWADDR_reg_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(16),
      Q => AWADDR_reg(16)
    );
\AWADDR_reg_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(17),
      Q => AWADDR_reg(17)
    );
\AWADDR_reg_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(18),
      Q => AWADDR_reg(18)
    );
\AWADDR_reg_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(19),
      Q => AWADDR_reg(19)
    );
\AWADDR_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(1),
      Q => AWADDR_reg(1)
    );
\AWADDR_reg_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(20),
      Q => AWADDR_reg(20)
    );
\AWADDR_reg_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(21),
      Q => AWADDR_reg(21)
    );
\AWADDR_reg_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(22),
      Q => AWADDR_reg(22)
    );
\AWADDR_reg_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(23),
      Q => AWADDR_reg(23)
    );
\AWADDR_reg_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(24),
      Q => AWADDR_reg(24)
    );
\AWADDR_reg_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(25),
      Q => AWADDR_reg(25)
    );
\AWADDR_reg_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(26),
      Q => AWADDR_reg(26)
    );
\AWADDR_reg_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(27),
      Q => AWADDR_reg(27)
    );
\AWADDR_reg_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(28),
      Q => AWADDR_reg(28)
    );
\AWADDR_reg_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(29),
      Q => AWADDR_reg(29)
    );
\AWADDR_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(2),
      Q => AWADDR_reg(2)
    );
\AWADDR_reg_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(30),
      Q => AWADDR_reg(30)
    );
\AWADDR_reg_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(31),
      Q => AWADDR_reg(31)
    );
\AWADDR_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(3),
      Q => AWADDR_reg(3)
    );
\AWADDR_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(4),
      Q => AWADDR_reg(4)
    );
\AWADDR_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(5),
      Q => AWADDR_reg(5)
    );
\AWADDR_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(6),
      Q => AWADDR_reg(6)
    );
\AWADDR_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(7),
      Q => AWADDR_reg(7)
    );
\AWADDR_reg_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(8),
      Q => AWADDR_reg(8)
    );
\AWADDR_reg_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awaddr(9),
      Q => AWADDR_reg(9)
    );
\AWBURST_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awburst(0),
      Q => \AWBURST_reg_reg_n_0_[0]\
    );
\AWBURST_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awburst(1),
      Q => \AWBURST_reg_reg_n_0_[1]\
    );
\AWID_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awid(0),
      Q => AWID_reg(0)
    );
\AWID_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awid(1),
      Q => AWID_reg(1)
    );
\AWID_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awid(2),
      Q => AWID_reg(2)
    );
\AWID_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awid(3),
      Q => AWID_reg(3)
    );
\AWLEN_reg[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000010"
    )
        port map (
      I0 => \stateW_reg_n_0_[2]\,
      I1 => \stateW_reg_n_0_[1]\,
      I2 => s_axi_awvalid,
      I3 => p_0_in(0),
      I4 => \stateW_reg_n_0_[0]\,
      O => AWBURST_reg
    );
\AWLEN_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awlen(0),
      Q => AWLEN_reg(0)
    );
\AWLEN_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awlen(1),
      Q => AWLEN_reg(1)
    );
\AWLEN_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awlen(2),
      Q => AWLEN_reg(2)
    );
\AWLEN_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awlen(3),
      Q => AWLEN_reg(3)
    );
\AWLEN_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awlen(4),
      Q => AWLEN_reg(4)
    );
\AWLEN_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awlen(5),
      Q => AWLEN_reg(5)
    );
\AWLEN_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awlen(6),
      Q => AWLEN_reg(6)
    );
\AWLEN_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awlen(7),
      Q => AWLEN_reg(7)
    );
AWREADY_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF0FF00000002"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => p_0_in(0),
      I2 => \stateW_reg_n_0_[2]\,
      I3 => \stateW_reg_n_0_[0]\,
      I4 => \stateW_reg_n_0_[1]\,
      I5 => \^s_axi_awready\,
      O => AWREADY_i_1_n_0
    );
AWREADY_i_2: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => axi_aresetn,
      O => AWREADY_i_2_n_0
    );
AWREADY_reg: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => AWREADY_i_1_n_0,
      Q => \^s_axi_awready\
    );
\AWSIZE_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awsize(0),
      Q => AWSIZE_reg(0)
    );
\AWSIZE_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awsize(1),
      Q => AWSIZE_reg(1)
    );
\AWSIZE_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => AWBURST_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_awsize(2),
      Q => AWSIZE_reg(2)
    );
BID0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => BID0_carry_n_0,
      CO(2) => BID0_carry_n_1,
      CO(1) => BID0_carry_n_2,
      CO(0) => BID0_carry_n_3,
      CYINIT => '1',
      DI(3) => BID0_carry_i_1_n_0,
      DI(2) => BID0_carry_i_2_n_0,
      DI(1) => BID0_carry_i_3_n_0,
      DI(0) => BID0_carry_i_4_n_0,
      O(3 downto 0) => NLW_BID0_carry_O_UNCONNECTED(3 downto 0),
      S(3) => BID0_carry_i_5_n_0,
      S(2) => BID0_carry_i_6_n_0,
      S(1) => BID0_carry_i_7_n_0,
      S(0) => BID0_carry_i_8_n_0
    );
BID0_carry_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => \beatW_reg_n_0_[7]\,
      I1 => AWLEN_reg(7),
      I2 => \beatW_reg_n_0_[6]\,
      I3 => AWLEN_reg(6),
      O => BID0_carry_i_1_n_0
    );
BID0_carry_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => \beatW_reg_n_0_[5]\,
      I1 => AWLEN_reg(5),
      I2 => \beatW_reg_n_0_[4]\,
      I3 => AWLEN_reg(4),
      O => BID0_carry_i_2_n_0
    );
BID0_carry_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => \beatW_reg_n_0_[3]\,
      I1 => AWLEN_reg(3),
      I2 => \beatW_reg_n_0_[2]\,
      I3 => AWLEN_reg(2),
      O => BID0_carry_i_3_n_0
    );
BID0_carry_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"22B2"
    )
        port map (
      I0 => \beatW_reg_n_0_[1]\,
      I1 => AWLEN_reg(1),
      I2 => \beatW_reg_n_0_[0]\,
      I3 => AWLEN_reg(0),
      O => BID0_carry_i_4_n_0
    );
BID0_carry_i_5: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => AWLEN_reg(7),
      I1 => \beatW_reg_n_0_[7]\,
      I2 => AWLEN_reg(6),
      I3 => \beatW_reg_n_0_[6]\,
      O => BID0_carry_i_5_n_0
    );
BID0_carry_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => AWLEN_reg(5),
      I1 => \beatW_reg_n_0_[5]\,
      I2 => AWLEN_reg(4),
      I3 => \beatW_reg_n_0_[4]\,
      O => BID0_carry_i_6_n_0
    );
BID0_carry_i_7: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => AWLEN_reg(3),
      I1 => \beatW_reg_n_0_[3]\,
      I2 => AWLEN_reg(2),
      I3 => \beatW_reg_n_0_[2]\,
      O => BID0_carry_i_7_n_0
    );
BID0_carry_i_8: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9009"
    )
        port map (
      I0 => AWLEN_reg(1),
      I1 => \beatW_reg_n_0_[1]\,
      I2 => AWLEN_reg(0),
      I3 => \beatW_reg_n_0_[0]\,
      O => BID0_carry_i_8_n_0
    );
\BID[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000080003000000"
    )
        port map (
      I0 => ACK_reg_n_0,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => \BID[3]_i_2_n_0\,
      I3 => BID0_carry_n_0,
      I4 => \stateW_reg_n_0_[2]\,
      I5 => \stateW_reg_n_0_[1]\,
      O => \BID[3]_i_1_n_0\
    );
\BID[3]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \tickW_reg_n_0_[1]\,
      I1 => \tickW_reg_n_0_[0]\,
      I2 => \tickW_reg_n_0_[2]\,
      I3 => \tickW_reg_n_0_[3]\,
      O => \BID[3]_i_2_n_0\
    );
\BID_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \BID[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => AWID_reg(0),
      Q => s_axi_bid(0)
    );
\BID_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \BID[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => AWID_reg(1),
      Q => s_axi_bid(1)
    );
\BID_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \BID[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => AWID_reg(2),
      Q => s_axi_bid(2)
    );
\BID_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \BID[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => AWID_reg(3),
      Q => s_axi_bid(3)
    );
\BRESP[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFF0F00000200"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => \BRESP[1]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => \stateW_reg_n_0_[2]\,
      I5 => \^s_axi_bresp\(0),
      O => \BRESP[1]_i_1_n_0\
    );
\BRESP[1]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0D00000D"
    )
        port map (
      I0 => BID0_carry_n_0,
      I1 => s_axi_wlast,
      I2 => \BRESP[1]_i_3_n_0\,
      I3 => s_axi_wid(3),
      I4 => AWID_reg(3),
      O => \BRESP[1]_i_2_n_0\
    );
\BRESP[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6FF6FFFFFFFF6FF6"
    )
        port map (
      I0 => AWID_reg(0),
      I1 => s_axi_wid(0),
      I2 => s_axi_wid(2),
      I3 => AWID_reg(2),
      I4 => s_axi_wid(1),
      I5 => AWID_reg(1),
      O => \BRESP[1]_i_3_n_0\
    );
\BRESP_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => axi_aclk,
      CE => '1',
      D => \BRESP[1]_i_1_n_0\,
      PRE => AWREADY_i_2_n_0,
      Q => \^s_axi_bresp\(0)
    );
BVALID_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"DFFFFFFF30000000"
    )
        port map (
      I0 => s_axi_bready,
      I1 => ACK_reg_n_0,
      I2 => \stateW_reg_n_0_[2]\,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => \stateW_reg_n_0_[0]\,
      I5 => \^s_axi_bvalid\,
      O => BVALID_i_1_n_0
    );
BVALID_reg: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => BVALID_i_1_n_0,
      Q => \^s_axi_bvalid\
    );
\DATAR[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(0),
      I2 => M1_APB_PRDATA(0),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(0),
      O => X_PRDATA(0)
    );
\DATAR[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(10),
      I2 => M1_APB_PRDATA(10),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(10),
      O => X_PRDATA(10)
    );
\DATAR[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(11),
      I2 => M1_APB_PRDATA(11),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(11),
      O => X_PRDATA(11)
    );
\DATAR[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(12),
      I2 => M1_APB_PRDATA(12),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(12),
      O => X_PRDATA(12)
    );
\DATAR[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(13),
      I2 => M1_APB_PRDATA(13),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(13),
      O => X_PRDATA(13)
    );
\DATAR[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(14),
      I2 => M1_APB_PRDATA(14),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(14),
      O => X_PRDATA(14)
    );
\DATAR[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(15),
      I2 => M1_APB_PRDATA(15),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(15),
      O => X_PRDATA(15)
    );
\DATAR[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(16),
      I2 => M1_APB_PRDATA(16),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(16),
      O => X_PRDATA(16)
    );
\DATAR[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(17),
      I2 => M1_APB_PRDATA(17),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(17),
      O => X_PRDATA(17)
    );
\DATAR[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(18),
      I2 => M1_APB_PRDATA(18),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(18),
      O => X_PRDATA(18)
    );
\DATAR[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(19),
      I2 => M1_APB_PRDATA(19),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(19),
      O => X_PRDATA(19)
    );
\DATAR[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(1),
      I2 => M1_APB_PRDATA(1),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(1),
      O => X_PRDATA(1)
    );
\DATAR[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(20),
      I2 => M1_APB_PRDATA(20),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(20),
      O => X_PRDATA(20)
    );
\DATAR[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(21),
      I2 => M1_APB_PRDATA(21),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(21),
      O => X_PRDATA(21)
    );
\DATAR[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(22),
      I2 => M1_APB_PRDATA(22),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(22),
      O => X_PRDATA(22)
    );
\DATAR[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(23),
      I2 => M1_APB_PRDATA(23),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(23),
      O => X_PRDATA(23)
    );
\DATAR[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(24),
      I2 => M1_APB_PRDATA(24),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(24),
      O => X_PRDATA(24)
    );
\DATAR[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(25),
      I2 => M1_APB_PRDATA(25),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(25),
      O => X_PRDATA(25)
    );
\DATAR[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(26),
      I2 => M1_APB_PRDATA(26),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(26),
      O => X_PRDATA(26)
    );
\DATAR[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(27),
      I2 => M1_APB_PRDATA(27),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(27),
      O => X_PRDATA(27)
    );
\DATAR[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(28),
      I2 => M1_APB_PRDATA(28),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(28),
      O => X_PRDATA(28)
    );
\DATAR[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(29),
      I2 => M1_APB_PRDATA(29),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(29),
      O => X_PRDATA(29)
    );
\DATAR[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(2),
      I2 => M1_APB_PRDATA(2),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(2),
      O => X_PRDATA(2)
    );
\DATAR[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(30),
      I2 => M1_APB_PRDATA(30),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(30),
      O => X_PRDATA(30)
    );
\DATAR[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000AAAAAA08"
    )
        port map (
      I0 => state(1),
      I1 => M0_APB_PSEL_INST_0_i_1_n_0,
      I2 => \DATAR[31]_i_3_n_0\,
      I3 => \DATAR[31]_i_4_n_0\,
      I4 => \DATAR[31]_i_5_n_0\,
      I5 => state(0),
      O => DATAR
    );
\DATAR[31]_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^m0_apb_paddr\(26),
      I1 => \^m0_apb_paddr\(27),
      I2 => \^m0_apb_paddr\(13),
      I3 => \^m0_apb_paddr\(28),
      O => \DATAR[31]_i_10_n_0\
    );
\DATAR[31]_i_11\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \^m0_apb_paddr\(10),
      I1 => \^m0_apb_paddr\(11),
      O => \DATAR[31]_i_11_n_0\
    );
\DATAR[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(31),
      I2 => M1_APB_PRDATA(31),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(31),
      O => X_PRDATA(31)
    );
\DATAR[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"05CF000005050000"
    )
        port map (
      I0 => \DATAR[31]_i_6_n_0\,
      I1 => \DATAR[31]_i_7_n_0\,
      I2 => M1_APB_PSEL_INST_0_i_2_n_0,
      I3 => \DATAR[31]_i_8_n_0\,
      I4 => M2_APB_PSEL_INST_0_i_1_n_0,
      I5 => M0_APB_PSEL_INST_0_i_2_n_0,
      O => \DATAR[31]_i_3_n_0\
    );
\DATAR[31]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0200FFFF02000200"
    )
        port map (
      I0 => M2_APB_PSEL_INST_0_i_1_n_0,
      I1 => \DATAR[31]_i_6_n_0\,
      I2 => M1_APB_PSEL_INST_0_i_2_n_0,
      I3 => M2_APB_PREADY,
      I4 => M0_APB_PSEL_INST_0_i_1_n_0,
      I5 => M0_APB_PREADY,
      O => \DATAR[31]_i_4_n_0\
    );
\DATAR[31]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"4040404000000040"
    )
        port map (
      I0 => \DATAR[31]_i_9_n_0\,
      I1 => M0_APB_PSEL_INST_0_i_2_n_0,
      I2 => M2_APB_PSEL_INST_0_i_1_n_0,
      I3 => \DATAR[31]_i_6_n_0\,
      I4 => M1_APB_PSEL_INST_0_i_2_n_0,
      I5 => M1_APB_PREADY,
      O => \DATAR[31]_i_5_n_0\
    );
\DATAR[31]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFEAAAA"
    )
        port map (
      I0 => M2_APB_PSEL_INST_0_i_2_n_0,
      I1 => \^m0_apb_paddr\(11),
      I2 => \^m0_apb_paddr\(10),
      I3 => \^m0_apb_paddr\(12),
      I4 => \^m0_apb_paddr\(13),
      O => \DATAR[31]_i_6_n_0\
    );
\DATAR[31]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFFFFE"
    )
        port map (
      I0 => \^m0_apb_paddr\(12),
      I1 => M0_APB_PSEL_INST_0_i_3_n_0,
      I2 => \^m0_apb_paddr\(16),
      I3 => \^m0_apb_paddr\(20),
      I4 => \^m0_apb_paddr\(19),
      I5 => \^m0_apb_paddr\(14),
      O => \DATAR[31]_i_7_n_0\
    );
\DATAR[31]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"A8"
    )
        port map (
      I0 => \^m0_apb_paddr\(12),
      I1 => \^m0_apb_paddr\(11),
      I2 => \^m0_apb_paddr\(10),
      O => \DATAR[31]_i_8_n_0\
    );
\DATAR[31]_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FFFF00100010"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_3_n_0,
      I1 => M0_APB_PSEL_INST_0_i_4_n_0,
      I2 => M0_APB_PSEL_INST_0_i_6_n_0,
      I3 => \DATAR[31]_i_10_n_0\,
      I4 => \DATAR[31]_i_11_n_0\,
      I5 => \^m0_apb_paddr\(12),
      O => \DATAR[31]_i_9_n_0\
    );
\DATAR[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(3),
      I2 => M1_APB_PRDATA(3),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(3),
      O => X_PRDATA(3)
    );
\DATAR[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(4),
      I2 => M1_APB_PRDATA(4),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(4),
      O => X_PRDATA(4)
    );
\DATAR[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(5),
      I2 => M1_APB_PRDATA(5),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(5),
      O => X_PRDATA(5)
    );
\DATAR[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(6),
      I2 => M1_APB_PRDATA(6),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(6),
      O => X_PRDATA(6)
    );
\DATAR[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(7),
      I2 => M1_APB_PRDATA(7),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(7),
      O => X_PRDATA(7)
    );
\DATAR[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(8),
      I2 => M1_APB_PRDATA(8),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(8),
      O => X_PRDATA(8)
    );
\DATAR[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"44F4FF4444F44444"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      I1 => M0_APB_PRDATA(9),
      I2 => M1_APB_PRDATA(9),
      I3 => \^m_paddr_reg[13]_0\,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M2_APB_PRDATA(9),
      O => X_PRDATA(9)
    );
\DATAR_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(0),
      Q => \DATAR__0\(0)
    );
\DATAR_reg[10]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(10),
      Q => \DATAR__0\(10)
    );
\DATAR_reg[11]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(11),
      Q => \DATAR__0\(11)
    );
\DATAR_reg[12]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(12),
      Q => \DATAR__0\(12)
    );
\DATAR_reg[13]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(13),
      Q => \DATAR__0\(13)
    );
\DATAR_reg[14]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(14),
      Q => \DATAR__0\(14)
    );
\DATAR_reg[15]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(15),
      Q => \DATAR__0\(15)
    );
\DATAR_reg[16]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(16),
      Q => \DATAR__0\(16)
    );
\DATAR_reg[17]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(17),
      Q => \DATAR__0\(17)
    );
\DATAR_reg[18]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(18),
      Q => \DATAR__0\(18)
    );
\DATAR_reg[19]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(19),
      Q => \DATAR__0\(19)
    );
\DATAR_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(1),
      Q => \DATAR__0\(1)
    );
\DATAR_reg[20]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(20),
      Q => \DATAR__0\(20)
    );
\DATAR_reg[21]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(21),
      Q => \DATAR__0\(21)
    );
\DATAR_reg[22]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(22),
      Q => \DATAR__0\(22)
    );
\DATAR_reg[23]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(23),
      Q => \DATAR__0\(23)
    );
\DATAR_reg[24]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(24),
      Q => \DATAR__0\(24)
    );
\DATAR_reg[25]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(25),
      Q => \DATAR__0\(25)
    );
\DATAR_reg[26]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(26),
      Q => \DATAR__0\(26)
    );
\DATAR_reg[27]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(27),
      Q => \DATAR__0\(27)
    );
\DATAR_reg[28]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(28),
      Q => \DATAR__0\(28)
    );
\DATAR_reg[29]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(29),
      Q => \DATAR__0\(29)
    );
\DATAR_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(2),
      Q => \DATAR__0\(2)
    );
\DATAR_reg[30]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(30),
      Q => \DATAR__0\(30)
    );
\DATAR_reg[31]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(31),
      Q => \DATAR__0\(31)
    );
\DATAR_reg[3]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(3),
      Q => \DATAR__0\(3)
    );
\DATAR_reg[4]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(4),
      Q => \DATAR__0\(4)
    );
\DATAR_reg[5]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(5),
      Q => \DATAR__0\(5)
    );
\DATAR_reg[6]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(6),
      Q => \DATAR__0\(6)
    );
\DATAR_reg[7]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(7),
      Q => \DATAR__0\(7)
    );
\DATAR_reg[8]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(8),
      Q => \DATAR__0\(8)
    );
\DATAR_reg[9]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => DATAR,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => X_PRDATA(9),
      Q => \DATAR__0\(9)
    );
\FSM_sequential_state[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C05C"
    )
        port map (
      I0 => \FSM_sequential_state[0]_i_2_n_0\,
      I1 => \FSM_sequential_state[1]_i_2_n_0\,
      I2 => state(1),
      I3 => state(0),
      O => \FSM_sequential_state[0]_i_1_n_0\
    );
\FSM_sequential_state[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000202750552027"
    )
        port map (
      I0 => \^m_paddr_reg[13]_0\,
      I1 => M2_APB_PREADY,
      I2 => M0_APB_PSEL_INST_0_i_1_n_0,
      I3 => M0_APB_PREADY,
      I4 => \^m_paddr_reg[12]_0\,
      I5 => M1_APB_PREADY,
      O => \FSM_sequential_state[0]_i_2_n_0\
    );
\FSM_sequential_state[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"EFFA"
    )
        port map (
      I0 => DATAR,
      I1 => \FSM_sequential_state[1]_i_2_n_0\,
      I2 => state(1),
      I3 => state(0),
      O => \FSM_sequential_state[1]_i_1_n_0\
    );
\FSM_sequential_state[1]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3088"
    )
        port map (
      I0 => Tren_reg_n_0,
      I1 => p_0_in(0),
      I2 => Twen,
      I3 => p_0_in(1),
      O => \FSM_sequential_state[1]_i_2_n_0\
    );
\FSM_sequential_state_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => '1',
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => \FSM_sequential_state[0]_i_1_n_0\,
      Q => state(0)
    );
\FSM_sequential_state_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => PCLK,
      CE => '1',
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => \FSM_sequential_state[1]_i_1_n_0\,
      Q => state(1)
    );
M0_APB_PSEL_INST_0: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_1_n_0,
      O => M0_APB_PSEL
    );
M0_APB_PSEL_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FDFFFFFFFFFFFFFF"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_2_n_0,
      I1 => M0_APB_PSEL_INST_0_i_3_n_0,
      I2 => M0_APB_PSEL_INST_0_i_4_n_0,
      I3 => M0_APB_PSEL_INST_0_i_5_n_0,
      I4 => M0_APB_PSEL_INST_0_i_6_n_0,
      I5 => M2_APB_PSEL_INST_0_i_3_n_0,
      O => M0_APB_PSEL_INST_0_i_1_n_0
    );
M0_APB_PSEL_INST_0_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"10000000"
    )
        port map (
      I0 => \^m0_apb_paddr\(13),
      I1 => \^m0_apb_paddr\(31),
      I2 => \^m0_apb_paddr\(30),
      I3 => X_PSEL,
      I4 => \^m0_apb_paddr\(29),
      O => M0_APB_PSEL_INST_0_i_2_n_0
    );
M0_APB_PSEL_INST_0_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^m0_apb_paddr\(15),
      I1 => \^m0_apb_paddr\(21),
      I2 => \^m0_apb_paddr\(17),
      I3 => \^m0_apb_paddr\(18),
      O => M0_APB_PSEL_INST_0_i_3_n_0
    );
M0_APB_PSEL_INST_0_i_4: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FFFE"
    )
        port map (
      I0 => \^m0_apb_paddr\(16),
      I1 => \^m0_apb_paddr\(20),
      I2 => \^m0_apb_paddr\(19),
      I3 => \^m0_apb_paddr\(14),
      O => M0_APB_PSEL_INST_0_i_4_n_0
    );
M0_APB_PSEL_INST_0_i_5: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \^m0_apb_paddr\(28),
      I1 => \^m0_apb_paddr\(26),
      I2 => \^m0_apb_paddr\(27),
      O => M0_APB_PSEL_INST_0_i_5_n_0
    );
M0_APB_PSEL_INST_0_i_6: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \^m0_apb_paddr\(24),
      I1 => \^m0_apb_paddr\(25),
      I2 => \^m0_apb_paddr\(22),
      I3 => \^m0_apb_paddr\(23),
      O => M0_APB_PSEL_INST_0_i_6_n_0
    );
M1_APB_PSEL_INST_0: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1115111500041115"
    )
        port map (
      I0 => M1_APB_PSEL_INST_0_i_1_n_0,
      I1 => \^m0_apb_paddr\(12),
      I2 => \^m0_apb_paddr\(11),
      I3 => \^m0_apb_paddr\(10),
      I4 => M1_APB_PSEL_INST_0_i_2_n_0,
      I5 => M1_APB_PSEL_INST_0_i_3_n_0,
      O => \^m_paddr_reg[12]_0\
    );
M1_APB_PSEL_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFDFFFFFFFF"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_6_n_0,
      I1 => M1_APB_PSEL_INST_0_i_4_n_0,
      I2 => \^m0_apb_paddr\(28),
      I3 => M0_APB_PSEL_INST_0_i_4_n_0,
      I4 => M0_APB_PSEL_INST_0_i_3_n_0,
      I5 => M0_APB_PSEL_INST_0_i_2_n_0,
      O => M1_APB_PSEL_INST_0_i_1_n_0
    );
M1_APB_PSEL_INST_0_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000002"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_6_n_0,
      I1 => \^m0_apb_paddr\(28),
      I2 => \^m0_apb_paddr\(13),
      I3 => \^m0_apb_paddr\(27),
      I4 => \^m0_apb_paddr\(26),
      O => M1_APB_PSEL_INST_0_i_2_n_0
    );
M1_APB_PSEL_INST_0_i_3: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFFFFFFE"
    )
        port map (
      I0 => \^m0_apb_paddr\(14),
      I1 => \^m0_apb_paddr\(19),
      I2 => \^m0_apb_paddr\(20),
      I3 => \^m0_apb_paddr\(16),
      I4 => M0_APB_PSEL_INST_0_i_3_n_0,
      O => M1_APB_PSEL_INST_0_i_3_n_0
    );
M1_APB_PSEL_INST_0_i_4: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => \^m0_apb_paddr\(27),
      I1 => \^m0_apb_paddr\(26),
      O => M1_APB_PSEL_INST_0_i_4_n_0
    );
M2_APB_PSEL_INST_0: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00002022"
    )
        port map (
      I0 => M2_APB_PSEL_INST_0_i_1_n_0,
      I1 => M2_APB_PSEL_INST_0_i_2_n_0,
      I2 => M2_APB_PSEL_INST_0_i_3_n_0,
      I3 => \^m0_apb_paddr\(13),
      I4 => M1_APB_PSEL_INST_0_i_2_n_0,
      O => \^m_paddr_reg[13]_0\
    );
M2_APB_PSEL_INST_0_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000100000000"
    )
        port map (
      I0 => M0_APB_PSEL_INST_0_i_3_n_0,
      I1 => M0_APB_PSEL_INST_0_i_4_n_0,
      I2 => \^m0_apb_paddr\(28),
      I3 => \^m0_apb_paddr\(26),
      I4 => \^m0_apb_paddr\(27),
      I5 => M0_APB_PSEL_INST_0_i_6_n_0,
      O => M2_APB_PSEL_INST_0_i_1_n_0
    );
M2_APB_PSEL_INST_0_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FF7F"
    )
        port map (
      I0 => \^m0_apb_paddr\(29),
      I1 => X_PSEL,
      I2 => \^m0_apb_paddr\(30),
      I3 => \^m0_apb_paddr\(31),
      O => M2_APB_PSEL_INST_0_i_2_n_0
    );
M2_APB_PSEL_INST_0_i_3: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => \^m0_apb_paddr\(11),
      I1 => \^m0_apb_paddr\(10),
      I2 => \^m0_apb_paddr\(12),
      O => M2_APB_PSEL_INST_0_i_3_n_0
    );
\M_PADDR[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(0),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(0),
      O => ADDR(0)
    );
\M_PADDR[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(10),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(10),
      O => ADDR(10)
    );
\M_PADDR[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(11),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(11),
      O => ADDR(11)
    );
\M_PADDR[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(12),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(12),
      O => ADDR(12)
    );
\M_PADDR[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(13),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(13),
      O => ADDR(13)
    );
\M_PADDR[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(14),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(14),
      O => ADDR(14)
    );
\M_PADDR[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(15),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(15),
      O => ADDR(15)
    );
\M_PADDR[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(16),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(16),
      O => ADDR(16)
    );
\M_PADDR[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(17),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(17),
      O => ADDR(17)
    );
\M_PADDR[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(18),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(18),
      O => ADDR(18)
    );
\M_PADDR[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(19),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(19),
      O => ADDR(19)
    );
\M_PADDR[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(1),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(1),
      O => ADDR(1)
    );
\M_PADDR[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(20),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(20),
      O => ADDR(20)
    );
\M_PADDR[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(21),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(21),
      O => ADDR(21)
    );
\M_PADDR[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(22),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(22),
      O => ADDR(22)
    );
\M_PADDR[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(23),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(23),
      O => ADDR(23)
    );
\M_PADDR[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(24),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(24),
      O => ADDR(24)
    );
\M_PADDR[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(25),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(25),
      O => ADDR(25)
    );
\M_PADDR[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(26),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(26),
      O => ADDR(26)
    );
\M_PADDR[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(27),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(27),
      O => ADDR(27)
    );
\M_PADDR[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(28),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(28),
      O => ADDR(28)
    );
\M_PADDR[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(29),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(29),
      O => ADDR(29)
    );
\M_PADDR[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(2),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(2),
      O => ADDR(2)
    );
\M_PADDR[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(30),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(30),
      O => ADDR(30)
    );
\M_PADDR[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000000005004040"
    )
        port map (
      I0 => state(1),
      I1 => Tren_reg_n_0,
      I2 => p_0_in(0),
      I3 => Twen,
      I4 => p_0_in(1),
      I5 => state(0),
      O => \M_PADDR[31]_i_1_n_0\
    );
\M_PADDR[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(31),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(31),
      O => ADDR(31)
    );
\M_PADDR[31]_i_3\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => PRESETn,
      O => \M_PADDR[31]_i_3_n_0\
    );
\M_PADDR[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(3),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(3),
      O => ADDR(3)
    );
\M_PADDR[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(4),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(4),
      O => ADDR(4)
    );
\M_PADDR[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(5),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(5),
      O => ADDR(5)
    );
\M_PADDR[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(6),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(6),
      O => ADDR(6)
    );
\M_PADDR[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(7),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(7),
      O => ADDR(7)
    );
\M_PADDR[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(8),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(8),
      O => ADDR(8)
    );
\M_PADDR[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3808"
    )
        port map (
      I0 => Traddr(9),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      I3 => Twaddr(9),
      O => ADDR(9)
    );
\M_PADDR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(0),
      Q => \^m0_apb_paddr\(0)
    );
\M_PADDR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(10),
      Q => \^m0_apb_paddr\(10)
    );
\M_PADDR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(11),
      Q => \^m0_apb_paddr\(11)
    );
\M_PADDR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(12),
      Q => \^m0_apb_paddr\(12)
    );
\M_PADDR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(13),
      Q => \^m0_apb_paddr\(13)
    );
\M_PADDR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(14),
      Q => \^m0_apb_paddr\(14)
    );
\M_PADDR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(15),
      Q => \^m0_apb_paddr\(15)
    );
\M_PADDR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(16),
      Q => \^m0_apb_paddr\(16)
    );
\M_PADDR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(17),
      Q => \^m0_apb_paddr\(17)
    );
\M_PADDR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(18),
      Q => \^m0_apb_paddr\(18)
    );
\M_PADDR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(19),
      Q => \^m0_apb_paddr\(19)
    );
\M_PADDR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(1),
      Q => \^m0_apb_paddr\(1)
    );
\M_PADDR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(20),
      Q => \^m0_apb_paddr\(20)
    );
\M_PADDR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(21),
      Q => \^m0_apb_paddr\(21)
    );
\M_PADDR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(22),
      Q => \^m0_apb_paddr\(22)
    );
\M_PADDR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(23),
      Q => \^m0_apb_paddr\(23)
    );
\M_PADDR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(24),
      Q => \^m0_apb_paddr\(24)
    );
\M_PADDR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(25),
      Q => \^m0_apb_paddr\(25)
    );
\M_PADDR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(26),
      Q => \^m0_apb_paddr\(26)
    );
\M_PADDR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(27),
      Q => \^m0_apb_paddr\(27)
    );
\M_PADDR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(28),
      Q => \^m0_apb_paddr\(28)
    );
\M_PADDR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(29),
      Q => \^m0_apb_paddr\(29)
    );
\M_PADDR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(2),
      Q => \^m0_apb_paddr\(2)
    );
\M_PADDR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(30),
      Q => \^m0_apb_paddr\(30)
    );
\M_PADDR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(31),
      Q => \^m0_apb_paddr\(31)
    );
\M_PADDR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(3),
      Q => \^m0_apb_paddr\(3)
    );
\M_PADDR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(4),
      Q => \^m0_apb_paddr\(4)
    );
\M_PADDR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(5),
      Q => \^m0_apb_paddr\(5)
    );
\M_PADDR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(6),
      Q => \^m0_apb_paddr\(6)
    );
\M_PADDR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(7),
      Q => \^m0_apb_paddr\(7)
    );
\M_PADDR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(8),
      Q => \^m0_apb_paddr\(8)
    );
\M_PADDR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => ADDR(9),
      Q => \^m0_apb_paddr\(9)
    );
M_PENABLE_i_1: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7732"
    )
        port map (
      I0 => DATAR,
      I1 => state(1),
      I2 => state(0),
      I3 => \^m2_apb_penable\,
      O => M_PENABLE_i_1_n_0
    );
M_PENABLE_reg: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => '1',
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => M_PENABLE_i_1_n_0,
      Q => \^m2_apb_penable\
    );
M_PSEL_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0CFF0C04"
    )
        port map (
      I0 => state(0),
      I1 => \FSM_sequential_state[1]_i_2_n_0\,
      I2 => state(1),
      I3 => DATAR,
      I4 => X_PSEL,
      O => M_PSEL_i_1_n_0
    );
M_PSEL_reg: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => '1',
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => M_PSEL_i_1_n_0,
      Q => X_PSEL
    );
\M_PSTRB[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
        port map (
      I0 => \Twstrb_reg_n_0_[0]\,
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => \M_PSTRB[0]_i_1_n_0\
    );
\M_PSTRB[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
        port map (
      I0 => \Twstrb_reg_n_0_[1]\,
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => \M_PSTRB[1]_i_1_n_0\
    );
\M_PSTRB[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
        port map (
      I0 => \Twstrb_reg_n_0_[2]\,
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => \M_PSTRB[2]_i_1_n_0\
    );
\M_PSTRB[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"EF"
    )
        port map (
      I0 => \Twstrb_reg_n_0_[3]\,
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => \M_PSTRB[3]_i_1_n_0\
    );
\M_PSTRB_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => \M_PSTRB[0]_i_1_n_0\,
      Q => M2_APB_PSTRB(0)
    );
\M_PSTRB_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => \M_PSTRB[1]_i_1_n_0\,
      Q => M2_APB_PSTRB(1)
    );
\M_PSTRB_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => \M_PSTRB[2]_i_1_n_0\,
      Q => M2_APB_PSTRB(2)
    );
\M_PSTRB_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => \M_PSTRB[3]_i_1_n_0\,
      Q => M2_APB_PSTRB(3)
    );
\M_PWDATA[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(0),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(0)
    );
\M_PWDATA[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(10),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(10)
    );
\M_PWDATA[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(11),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(11)
    );
\M_PWDATA[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(12),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(12)
    );
\M_PWDATA[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(13),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(13)
    );
\M_PWDATA[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(14),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(14)
    );
\M_PWDATA[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(15),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(15)
    );
\M_PWDATA[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(16),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(16)
    );
\M_PWDATA[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(17),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(17)
    );
\M_PWDATA[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(18),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(18)
    );
\M_PWDATA[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(19),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(19)
    );
\M_PWDATA[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(1),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(1)
    );
\M_PWDATA[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(20),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(20)
    );
\M_PWDATA[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(21),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(21)
    );
\M_PWDATA[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(22),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(22)
    );
\M_PWDATA[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(23),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(23)
    );
\M_PWDATA[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(24),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(24)
    );
\M_PWDATA[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(25),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(25)
    );
\M_PWDATA[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(26),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(26)
    );
\M_PWDATA[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(27),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(27)
    );
\M_PWDATA[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(28),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(28)
    );
\M_PWDATA[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(29),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(29)
    );
\M_PWDATA[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(2),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(2)
    );
\M_PWDATA[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(30),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(30)
    );
\M_PWDATA[31]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(31),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(31)
    );
\M_PWDATA[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(3),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(3)
    );
\M_PWDATA[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(4),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(4)
    );
\M_PWDATA[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(5),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(5)
    );
\M_PWDATA[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(6),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(6)
    );
\M_PWDATA[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(7),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(7)
    );
\M_PWDATA[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(8),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(8)
    );
\M_PWDATA[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => Twdata(9),
      I1 => p_0_in(0),
      I2 => p_0_in(1),
      O => DATAW(9)
    );
\M_PWDATA_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(0),
      Q => M2_APB_PWDATA(0)
    );
\M_PWDATA_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(10),
      Q => M2_APB_PWDATA(10)
    );
\M_PWDATA_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(11),
      Q => M2_APB_PWDATA(11)
    );
\M_PWDATA_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(12),
      Q => M2_APB_PWDATA(12)
    );
\M_PWDATA_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(13),
      Q => M2_APB_PWDATA(13)
    );
\M_PWDATA_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(14),
      Q => M2_APB_PWDATA(14)
    );
\M_PWDATA_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(15),
      Q => M2_APB_PWDATA(15)
    );
\M_PWDATA_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(16),
      Q => M2_APB_PWDATA(16)
    );
\M_PWDATA_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(17),
      Q => M2_APB_PWDATA(17)
    );
\M_PWDATA_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(18),
      Q => M2_APB_PWDATA(18)
    );
\M_PWDATA_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(19),
      Q => M2_APB_PWDATA(19)
    );
\M_PWDATA_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(1),
      Q => M2_APB_PWDATA(1)
    );
\M_PWDATA_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(20),
      Q => M2_APB_PWDATA(20)
    );
\M_PWDATA_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(21),
      Q => M2_APB_PWDATA(21)
    );
\M_PWDATA_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(22),
      Q => M2_APB_PWDATA(22)
    );
\M_PWDATA_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(23),
      Q => M2_APB_PWDATA(23)
    );
\M_PWDATA_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(24),
      Q => M2_APB_PWDATA(24)
    );
\M_PWDATA_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(25),
      Q => M2_APB_PWDATA(25)
    );
\M_PWDATA_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(26),
      Q => M2_APB_PWDATA(26)
    );
\M_PWDATA_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(27),
      Q => M2_APB_PWDATA(27)
    );
\M_PWDATA_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(28),
      Q => M2_APB_PWDATA(28)
    );
\M_PWDATA_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(29),
      Q => M2_APB_PWDATA(29)
    );
\M_PWDATA_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(2),
      Q => M2_APB_PWDATA(2)
    );
\M_PWDATA_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(30),
      Q => M2_APB_PWDATA(30)
    );
\M_PWDATA_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(31),
      Q => M2_APB_PWDATA(31)
    );
\M_PWDATA_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(3),
      Q => M2_APB_PWDATA(3)
    );
\M_PWDATA_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(4),
      Q => M2_APB_PWDATA(4)
    );
\M_PWDATA_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(5),
      Q => M2_APB_PWDATA(5)
    );
\M_PWDATA_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(6),
      Q => M2_APB_PWDATA(6)
    );
\M_PWDATA_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(7),
      Q => M2_APB_PWDATA(7)
    );
\M_PWDATA_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(8),
      Q => M2_APB_PWDATA(8)
    );
\M_PWDATA_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => DATAW(9),
      Q => M2_APB_PWDATA(9)
    );
M_PWRITE_i_1: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => p_0_in(1),
      I1 => p_0_in(0),
      O => WR
    );
M_PWRITE_reg: unisim.vcomponents.FDCE
     port map (
      C => PCLK,
      CE => \M_PADDR[31]_i_1_n_0\,
      CLR => \M_PADDR[31]_i_3_n_0\,
      D => WR,
      Q => M2_APB_PWRITE
    );
\RDATA[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(0),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[0]_i_1_n_0\
    );
\RDATA[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(10),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[10]_i_1_n_0\
    );
\RDATA[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(11),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[11]_i_1_n_0\
    );
\RDATA[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(12),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[12]_i_1_n_0\
    );
\RDATA[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(13),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[13]_i_1_n_0\
    );
\RDATA[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(14),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[14]_i_1_n_0\
    );
\RDATA[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(15),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[15]_i_1_n_0\
    );
\RDATA[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(16),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[16]_i_1_n_0\
    );
\RDATA[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(17),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[17]_i_1_n_0\
    );
\RDATA[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(18),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[18]_i_1_n_0\
    );
\RDATA[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(19),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[19]_i_1_n_0\
    );
\RDATA[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(1),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[1]_i_1_n_0\
    );
\RDATA[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(20),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[20]_i_1_n_0\
    );
\RDATA[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(21),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[21]_i_1_n_0\
    );
\RDATA[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(22),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[22]_i_1_n_0\
    );
\RDATA[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(23),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[23]_i_1_n_0\
    );
\RDATA[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(24),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[24]_i_1_n_0\
    );
\RDATA[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(25),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[25]_i_1_n_0\
    );
\RDATA[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(26),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[26]_i_1_n_0\
    );
\RDATA[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(27),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[27]_i_1_n_0\
    );
\RDATA[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(28),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[28]_i_1_n_0\
    );
\RDATA[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(29),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[29]_i_1_n_0\
    );
\RDATA[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(2),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[2]_i_1_n_0\
    );
\RDATA[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(30),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[30]_i_1_n_0\
    );
\RDATA[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"440050AA"
    )
        port map (
      I0 => \stateR_reg_n_0_[0]\,
      I1 => s_axi_rready,
      I2 => ACK_reg_n_0,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => \stateR_reg_n_0_[2]\,
      O => \RDATA[31]_i_1_n_0\
    );
\RDATA[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(31),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[31]_i_2_n_0\
    );
\RDATA[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(3),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[3]_i_1_n_0\
    );
\RDATA[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(4),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[4]_i_1_n_0\
    );
\RDATA[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(5),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[5]_i_1_n_0\
    );
\RDATA[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(6),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[6]_i_1_n_0\
    );
\RDATA[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(7),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[7]_i_1_n_0\
    );
\RDATA[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(8),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[8]_i_1_n_0\
    );
\RDATA[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"20"
    )
        port map (
      I0 => \DATAR__0\(9),
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \RDATA[9]_i_1_n_0\
    );
\RDATA_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[0]_i_1_n_0\,
      Q => s_axi_rdata(0)
    );
\RDATA_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[10]_i_1_n_0\,
      Q => s_axi_rdata(10)
    );
\RDATA_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[11]_i_1_n_0\,
      Q => s_axi_rdata(11)
    );
\RDATA_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[12]_i_1_n_0\,
      Q => s_axi_rdata(12)
    );
\RDATA_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[13]_i_1_n_0\,
      Q => s_axi_rdata(13)
    );
\RDATA_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[14]_i_1_n_0\,
      Q => s_axi_rdata(14)
    );
\RDATA_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[15]_i_1_n_0\,
      Q => s_axi_rdata(15)
    );
\RDATA_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[16]_i_1_n_0\,
      Q => s_axi_rdata(16)
    );
\RDATA_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[17]_i_1_n_0\,
      Q => s_axi_rdata(17)
    );
\RDATA_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[18]_i_1_n_0\,
      Q => s_axi_rdata(18)
    );
\RDATA_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[19]_i_1_n_0\,
      Q => s_axi_rdata(19)
    );
\RDATA_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[1]_i_1_n_0\,
      Q => s_axi_rdata(1)
    );
\RDATA_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[20]_i_1_n_0\,
      Q => s_axi_rdata(20)
    );
\RDATA_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[21]_i_1_n_0\,
      Q => s_axi_rdata(21)
    );
\RDATA_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[22]_i_1_n_0\,
      Q => s_axi_rdata(22)
    );
\RDATA_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[23]_i_1_n_0\,
      Q => s_axi_rdata(23)
    );
\RDATA_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[24]_i_1_n_0\,
      Q => s_axi_rdata(24)
    );
\RDATA_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[25]_i_1_n_0\,
      Q => s_axi_rdata(25)
    );
\RDATA_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[26]_i_1_n_0\,
      Q => s_axi_rdata(26)
    );
\RDATA_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[27]_i_1_n_0\,
      Q => s_axi_rdata(27)
    );
\RDATA_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[28]_i_1_n_0\,
      Q => s_axi_rdata(28)
    );
\RDATA_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[29]_i_1_n_0\,
      Q => s_axi_rdata(29)
    );
\RDATA_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[2]_i_1_n_0\,
      Q => s_axi_rdata(2)
    );
\RDATA_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[30]_i_1_n_0\,
      Q => s_axi_rdata(30)
    );
\RDATA_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[31]_i_2_n_0\,
      Q => s_axi_rdata(31)
    );
\RDATA_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[3]_i_1_n_0\,
      Q => s_axi_rdata(3)
    );
\RDATA_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[4]_i_1_n_0\,
      Q => s_axi_rdata(4)
    );
\RDATA_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[5]_i_1_n_0\,
      Q => s_axi_rdata(5)
    );
\RDATA_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[6]_i_1_n_0\,
      Q => s_axi_rdata(6)
    );
\RDATA_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[7]_i_1_n_0\,
      Q => s_axi_rdata(7)
    );
\RDATA_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[8]_i_1_n_0\,
      Q => s_axi_rdata(8)
    );
\RDATA_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RDATA[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \RDATA[9]_i_1_n_0\,
      Q => s_axi_rdata(9)
    );
\RID[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => \stateR_reg_n_0_[1]\,
      I1 => \stateR_reg_n_0_[0]\,
      I2 => \stateR_reg_n_0_[2]\,
      O => \RID[3]_i_1_n_0\
    );
\RID_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RID[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arid(0),
      Q => s_axi_rid(0)
    );
\RID_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RID[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arid(1),
      Q => s_axi_rid(1)
    );
\RID_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RID[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arid(2),
      Q => s_axi_rid(2)
    );
\RID_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \RID[3]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_arid(3),
      Q => s_axi_rid(3)
    );
RLAST_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2FFF2000"
    )
        port map (
      I0 => ARSTRB_reg1,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => RLAST_i_2_n_0,
      I3 => \stateR_reg_n_0_[0]\,
      I4 => \^s_axi_rlast\,
      O => RLAST_i_1_n_0
    );
RLAST_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A202"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => ACK_reg_n_0,
      I2 => \stateR_reg_n_0_[1]\,
      I3 => s_axi_rready,
      O => RLAST_i_2_n_0
    );
RLAST_reg: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => RLAST_i_1_n_0,
      Q => \^s_axi_rlast\
    );
\RRESP[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFBF0000"
    )
        port map (
      I0 => ACK_reg_n_0,
      I1 => \stateR_reg_n_0_[0]\,
      I2 => \stateR_reg_n_0_[2]\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => \^s_axi_rresp\(0),
      O => \RRESP[0]_i_1_n_0\
    );
\RRESP[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFBF0000"
    )
        port map (
      I0 => ACK_reg_n_0,
      I1 => \stateR_reg_n_0_[0]\,
      I2 => \stateR_reg_n_0_[2]\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => \^s_axi_rresp\(1),
      O => \RRESP[1]_i_1_n_0\
    );
\RRESP_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => \RRESP[0]_i_1_n_0\,
      Q => \^s_axi_rresp\(0)
    );
\RRESP_reg[1]\: unisim.vcomponents.FDPE
     port map (
      C => axi_aclk,
      CE => '1',
      D => \RRESP[1]_i_1_n_0\,
      PRE => AWREADY_i_2_n_0,
      Q => \^s_axi_rresp\(1)
    );
RVALID_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7F7F7F7F00003000"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => \stateR_reg_n_0_[2]\,
      I3 => \stateR_reg_n_0_[0]\,
      I4 => ACK_reg_n_0,
      I5 => \^s_axi_rvalid\,
      O => RVALID_i_1_n_0
    );
RVALID_reg: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => RVALID_i_1_n_0,
      Q => \^s_axi_rvalid\
    );
\Traddr[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"08080808303030FF"
    )
        port map (
      I0 => s_axi_rready,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[0]\,
      I3 => \Traddr[31]_i_2_n_0\,
      I4 => ACK_reg_n_0,
      I5 => \stateR_reg_n_0_[1]\,
      O => Trstrb
    );
\Traddr[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFF0001FFFFFFFF"
    )
        port map (
      I0 => ARSTRB_reg(2),
      I1 => ARSTRB_reg(1),
      I2 => ARSTRB_reg(3),
      I3 => ARSTRB_reg(0),
      I4 => \stateR_reg_n_0_[0]\,
      I5 => \stateR_reg_n_0_[2]\,
      O => \Traddr[31]_i_2_n_0\
    );
\Traddr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(0),
      Q => Traddr(0)
    );
\Traddr_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(10),
      Q => Traddr(10)
    );
\Traddr_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(11),
      Q => Traddr(11)
    );
\Traddr_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(12),
      Q => Traddr(12)
    );
\Traddr_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(13),
      Q => Traddr(13)
    );
\Traddr_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(14),
      Q => Traddr(14)
    );
\Traddr_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(15),
      Q => Traddr(15)
    );
\Traddr_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(16),
      Q => Traddr(16)
    );
\Traddr_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(17),
      Q => Traddr(17)
    );
\Traddr_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(18),
      Q => Traddr(18)
    );
\Traddr_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(19),
      Q => Traddr(19)
    );
\Traddr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(1),
      Q => Traddr(1)
    );
\Traddr_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(20),
      Q => Traddr(20)
    );
\Traddr_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(21),
      Q => Traddr(21)
    );
\Traddr_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(22),
      Q => Traddr(22)
    );
\Traddr_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(23),
      Q => Traddr(23)
    );
\Traddr_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(24),
      Q => Traddr(24)
    );
\Traddr_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(25),
      Q => Traddr(25)
    );
\Traddr_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(26),
      Q => Traddr(26)
    );
\Traddr_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(27),
      Q => Traddr(27)
    );
\Traddr_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(28),
      Q => Traddr(28)
    );
\Traddr_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(29),
      Q => Traddr(29)
    );
\Traddr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(2),
      Q => Traddr(2)
    );
\Traddr_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(30),
      Q => Traddr(30)
    );
\Traddr_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(31),
      Q => Traddr(31)
    );
\Traddr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(3),
      Q => Traddr(3)
    );
\Traddr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(4),
      Q => Traddr(4)
    );
\Traddr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(5),
      Q => Traddr(5)
    );
\Traddr_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(6),
      Q => Traddr(6)
    );
\Traddr_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(7),
      Q => Traddr(7)
    );
\Traddr_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(8),
      Q => Traddr(8)
    );
\Traddr_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Trstrb,
      CLR => AWREADY_i_2_n_0,
      D => addrRT(9),
      Q => Traddr(9)
    );
Tren_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C077FFFFC0770000"
    )
        port map (
      I0 => Tren_i_2_n_0,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => s_axi_rready,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => Tren_i_3_n_0,
      I5 => Tren_reg_n_0,
      O => Tren_i_1_n_0
    );
Tren_i_2: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => ARSTRB_reg(0),
      I1 => ARSTRB_reg(3),
      I2 => ARSTRB_reg(1),
      I3 => ARSTRB_reg(2),
      O => Tren_i_2_n_0
    );
Tren_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"03070307F0C53005"
    )
        port map (
      I0 => \Traddr[31]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      I3 => ACK_reg_n_0,
      I4 => s_axi_rready,
      I5 => \stateR_reg_n_0_[0]\,
      O => Tren_i_3_n_0
    );
Tren_reg: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => Tren_i_1_n_0,
      Q => Tren_reg_n_0
    );
\Twaddr[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000030000AA0000"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => \stateW[2]_i_2_n_0\,
      I2 => ACK_reg_n_0,
      I3 => \stateW_reg_n_0_[0]\,
      I4 => \stateW_reg_n_0_[1]\,
      I5 => \stateW_reg_n_0_[2]\,
      O => \Twaddr[31]_i_1_n_0\
    );
\Twaddr_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(0),
      Q => Twaddr(0)
    );
\Twaddr_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(10),
      Q => Twaddr(10)
    );
\Twaddr_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(11),
      Q => Twaddr(11)
    );
\Twaddr_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(12),
      Q => Twaddr(12)
    );
\Twaddr_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(13),
      Q => Twaddr(13)
    );
\Twaddr_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(14),
      Q => Twaddr(14)
    );
\Twaddr_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(15),
      Q => Twaddr(15)
    );
\Twaddr_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(16),
      Q => Twaddr(16)
    );
\Twaddr_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(17),
      Q => Twaddr(17)
    );
\Twaddr_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(18),
      Q => Twaddr(18)
    );
\Twaddr_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(19),
      Q => Twaddr(19)
    );
\Twaddr_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(1),
      Q => Twaddr(1)
    );
\Twaddr_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(20),
      Q => Twaddr(20)
    );
\Twaddr_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(21),
      Q => Twaddr(21)
    );
\Twaddr_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(22),
      Q => Twaddr(22)
    );
\Twaddr_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(23),
      Q => Twaddr(23)
    );
\Twaddr_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(24),
      Q => Twaddr(24)
    );
\Twaddr_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(25),
      Q => Twaddr(25)
    );
\Twaddr_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(26),
      Q => Twaddr(26)
    );
\Twaddr_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(27),
      Q => Twaddr(27)
    );
\Twaddr_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(28),
      Q => Twaddr(28)
    );
\Twaddr_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(29),
      Q => Twaddr(29)
    );
\Twaddr_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(2),
      Q => Twaddr(2)
    );
\Twaddr_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(30),
      Q => Twaddr(30)
    );
\Twaddr_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(31),
      Q => Twaddr(31)
    );
\Twaddr_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(3),
      Q => Twaddr(3)
    );
\Twaddr_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(4),
      Q => Twaddr(4)
    );
\Twaddr_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(5),
      Q => Twaddr(5)
    );
\Twaddr_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(6),
      Q => Twaddr(6)
    );
\Twaddr_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(7),
      Q => Twaddr(7)
    );
\Twaddr_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(8),
      Q => Twaddr(8)
    );
\Twaddr_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \Twaddr[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => addrWT(9),
      Q => Twaddr(9)
    );
\Twdata[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(0),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(0),
      O => \Twdata[0]_i_1_n_0\
    );
\Twdata[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(10),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(10),
      O => \Twdata[10]_i_1_n_0\
    );
\Twdata[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(11),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(11),
      O => \Twdata[11]_i_1_n_0\
    );
\Twdata[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(12),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(12),
      O => \Twdata[12]_i_1_n_0\
    );
\Twdata[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(13),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(13),
      O => \Twdata[13]_i_1_n_0\
    );
\Twdata[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(14),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(14),
      O => \Twdata[14]_i_1_n_0\
    );
\Twdata[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(15),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(15),
      O => \Twdata[15]_i_1_n_0\
    );
\Twdata[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(16),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(16),
      O => \Twdata[16]_i_1_n_0\
    );
\Twdata[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(17),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(17),
      O => \Twdata[17]_i_1_n_0\
    );
\Twdata[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(18),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(18),
      O => \Twdata[18]_i_1_n_0\
    );
\Twdata[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(19),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(19),
      O => \Twdata[19]_i_1_n_0\
    );
\Twdata[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(1),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(1),
      O => \Twdata[1]_i_1_n_0\
    );
\Twdata[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(20),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(20),
      O => \Twdata[20]_i_1_n_0\
    );
\Twdata[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(21),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(21),
      O => \Twdata[21]_i_1_n_0\
    );
\Twdata[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(22),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(22),
      O => \Twdata[22]_i_1_n_0\
    );
\Twdata[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(23),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(23),
      O => \Twdata[23]_i_1_n_0\
    );
\Twdata[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(24),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(24),
      O => \Twdata[24]_i_1_n_0\
    );
\Twdata[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(25),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(25),
      O => \Twdata[25]_i_1_n_0\
    );
\Twdata[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(26),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(26),
      O => \Twdata[26]_i_1_n_0\
    );
\Twdata[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(27),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(27),
      O => \Twdata[27]_i_1_n_0\
    );
\Twdata[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(28),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(28),
      O => \Twdata[28]_i_1_n_0\
    );
\Twdata[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(29),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(29),
      O => \Twdata[29]_i_1_n_0\
    );
\Twdata[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(2),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(2),
      O => \Twdata[2]_i_1_n_0\
    );
\Twdata[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(30),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(30),
      O => \Twdata[30]_i_1_n_0\
    );
\Twdata[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00200C20"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \stateW_reg_n_0_[0]\,
      I4 => ACK_reg_n_0,
      O => Twstrb
    );
\Twdata[31]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(31),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(31),
      O => \Twdata[31]_i_2_n_0\
    );
\Twdata[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(3),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(3),
      O => \Twdata[3]_i_1_n_0\
    );
\Twdata[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(4),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(4),
      O => \Twdata[4]_i_1_n_0\
    );
\Twdata[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(5),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(5),
      O => \Twdata[5]_i_1_n_0\
    );
\Twdata[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(6),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(6),
      O => \Twdata[6]_i_1_n_0\
    );
\Twdata[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(7),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(7),
      O => \Twdata[7]_i_1_n_0\
    );
\Twdata[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(8),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(8),
      O => \Twdata[8]_i_1_n_0\
    );
\Twdata[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2F20"
    )
        port map (
      I0 => WDATA_reg(9),
      I1 => \stateW[2]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wdata(9),
      O => \Twdata[9]_i_1_n_0\
    );
\Twdata_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[0]_i_1_n_0\,
      Q => Twdata(0)
    );
\Twdata_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[10]_i_1_n_0\,
      Q => Twdata(10)
    );
\Twdata_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[11]_i_1_n_0\,
      Q => Twdata(11)
    );
\Twdata_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[12]_i_1_n_0\,
      Q => Twdata(12)
    );
\Twdata_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[13]_i_1_n_0\,
      Q => Twdata(13)
    );
\Twdata_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[14]_i_1_n_0\,
      Q => Twdata(14)
    );
\Twdata_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[15]_i_1_n_0\,
      Q => Twdata(15)
    );
\Twdata_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[16]_i_1_n_0\,
      Q => Twdata(16)
    );
\Twdata_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[17]_i_1_n_0\,
      Q => Twdata(17)
    );
\Twdata_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[18]_i_1_n_0\,
      Q => Twdata(18)
    );
\Twdata_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[19]_i_1_n_0\,
      Q => Twdata(19)
    );
\Twdata_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[1]_i_1_n_0\,
      Q => Twdata(1)
    );
\Twdata_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[20]_i_1_n_0\,
      Q => Twdata(20)
    );
\Twdata_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[21]_i_1_n_0\,
      Q => Twdata(21)
    );
\Twdata_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[22]_i_1_n_0\,
      Q => Twdata(22)
    );
\Twdata_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[23]_i_1_n_0\,
      Q => Twdata(23)
    );
\Twdata_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[24]_i_1_n_0\,
      Q => Twdata(24)
    );
\Twdata_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[25]_i_1_n_0\,
      Q => Twdata(25)
    );
\Twdata_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[26]_i_1_n_0\,
      Q => Twdata(26)
    );
\Twdata_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[27]_i_1_n_0\,
      Q => Twdata(27)
    );
\Twdata_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[28]_i_1_n_0\,
      Q => Twdata(28)
    );
\Twdata_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[29]_i_1_n_0\,
      Q => Twdata(29)
    );
\Twdata_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[2]_i_1_n_0\,
      Q => Twdata(2)
    );
\Twdata_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[30]_i_1_n_0\,
      Q => Twdata(30)
    );
\Twdata_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[31]_i_2_n_0\,
      Q => Twdata(31)
    );
\Twdata_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[3]_i_1_n_0\,
      Q => Twdata(3)
    );
\Twdata_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[4]_i_1_n_0\,
      Q => Twdata(4)
    );
\Twdata_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[5]_i_1_n_0\,
      Q => Twdata(5)
    );
\Twdata_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[6]_i_1_n_0\,
      Q => Twdata(6)
    );
\Twdata_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[7]_i_1_n_0\,
      Q => Twdata(7)
    );
\Twdata_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[8]_i_1_n_0\,
      Q => Twdata(8)
    );
\Twdata_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twdata[9]_i_1_n_0\,
      Q => Twdata(9)
    );
Twen_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"444FFFFF444F0000"
    )
        port map (
      I0 => \stateW_reg_n_0_[0]\,
      I1 => s_axi_wvalid,
      I2 => \stateW[2]_i_2_n_0\,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => Twen_i_2_n_0,
      I5 => Twen,
      O => Twen_i_1_n_0
    );
Twen_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0010CF00"
    )
        port map (
      I0 => \stateW[2]_i_2_n_0\,
      I1 => ACK_reg_n_0,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => \stateW_reg_n_0_[2]\,
      O => Twen_i_2_n_0
    );
Twen_reg: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => Twen_i_1_n_0,
      Q => Twen
    );
\Twstrb[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \WSTRB_reg_reg_n_0_[0]\,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => s_axi_wstrb(0),
      O => \Twstrb[0]_i_1_n_0\
    );
\Twstrb[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \WSTRB_reg_reg_n_0_[1]\,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => s_axi_wstrb(1),
      O => \Twstrb[1]_i_1_n_0\
    );
\Twstrb[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \WSTRB_reg_reg_n_0_[2]\,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => s_axi_wstrb(2),
      O => \Twstrb[2]_i_1_n_0\
    );
\Twstrb[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \WSTRB_reg_reg_n_0_[3]\,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => s_axi_wstrb(3),
      O => \Twstrb[3]_i_1_n_0\
    );
\Twstrb_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twstrb[0]_i_1_n_0\,
      Q => \Twstrb_reg_n_0_[0]\
    );
\Twstrb_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twstrb[1]_i_1_n_0\,
      Q => \Twstrb_reg_n_0_[1]\
    );
\Twstrb_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twstrb[2]_i_1_n_0\,
      Q => \Twstrb_reg_n_0_[2]\
    );
\Twstrb_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => Twstrb,
      CLR => AWREADY_i_2_n_0,
      D => \Twstrb[3]_i_1_n_0\,
      Q => \Twstrb_reg_n_0_[3]\
    );
\WDATA_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(0),
      Q => WDATA_reg(0)
    );
\WDATA_reg_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(10),
      Q => WDATA_reg(10)
    );
\WDATA_reg_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(11),
      Q => WDATA_reg(11)
    );
\WDATA_reg_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(12),
      Q => WDATA_reg(12)
    );
\WDATA_reg_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(13),
      Q => WDATA_reg(13)
    );
\WDATA_reg_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(14),
      Q => WDATA_reg(14)
    );
\WDATA_reg_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(15),
      Q => WDATA_reg(15)
    );
\WDATA_reg_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(16),
      Q => WDATA_reg(16)
    );
\WDATA_reg_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(17),
      Q => WDATA_reg(17)
    );
\WDATA_reg_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(18),
      Q => WDATA_reg(18)
    );
\WDATA_reg_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(19),
      Q => WDATA_reg(19)
    );
\WDATA_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(1),
      Q => WDATA_reg(1)
    );
\WDATA_reg_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(20),
      Q => WDATA_reg(20)
    );
\WDATA_reg_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(21),
      Q => WDATA_reg(21)
    );
\WDATA_reg_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(22),
      Q => WDATA_reg(22)
    );
\WDATA_reg_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(23),
      Q => WDATA_reg(23)
    );
\WDATA_reg_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(24),
      Q => WDATA_reg(24)
    );
\WDATA_reg_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(25),
      Q => WDATA_reg(25)
    );
\WDATA_reg_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(26),
      Q => WDATA_reg(26)
    );
\WDATA_reg_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(27),
      Q => WDATA_reg(27)
    );
\WDATA_reg_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(28),
      Q => WDATA_reg(28)
    );
\WDATA_reg_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(29),
      Q => WDATA_reg(29)
    );
\WDATA_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(2),
      Q => WDATA_reg(2)
    );
\WDATA_reg_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(30),
      Q => WDATA_reg(30)
    );
\WDATA_reg_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(31),
      Q => WDATA_reg(31)
    );
\WDATA_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(3),
      Q => WDATA_reg(3)
    );
\WDATA_reg_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(4),
      Q => WDATA_reg(4)
    );
\WDATA_reg_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(5),
      Q => WDATA_reg(5)
    );
\WDATA_reg_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(6),
      Q => WDATA_reg(6)
    );
\WDATA_reg_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(7),
      Q => WDATA_reg(7)
    );
\WDATA_reg_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(8),
      Q => WDATA_reg(8)
    );
\WDATA_reg_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wdata(9),
      Q => WDATA_reg(9)
    );
WREADY_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFF5FF000F3000"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => ACK_reg_n_0,
      I2 => \stateW_reg_n_0_[2]\,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => \stateW_reg_n_0_[0]\,
      I5 => \^s_axi_wready\,
      O => WREADY_i_1_n_0
    );
WREADY_reg: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => WREADY_i_1_n_0,
      Q => \^s_axi_wready\
    );
\WSTRB_reg[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0400"
    )
        port map (
      I0 => \stateW_reg_n_0_[2]\,
      I1 => \stateW_reg_n_0_[1]\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => s_axi_wvalid,
      O => WSTRB_reg
    );
\WSTRB_reg_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wstrb(0),
      Q => \WSTRB_reg_reg_n_0_[0]\
    );
\WSTRB_reg_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wstrb(1),
      Q => \WSTRB_reg_reg_n_0_[1]\
    );
\WSTRB_reg_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wstrb(2),
      Q => \WSTRB_reg_reg_n_0_[2]\
    );
\WSTRB_reg_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => WSTRB_reg,
      CLR => AWREADY_i_2_n_0,
      D => s_axi_wstrb(3),
      Q => \WSTRB_reg_reg_n_0_[3]\
    );
addrRT0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => addrRT0_carry_n_0,
      CO(2) => addrRT0_carry_n_1,
      CO(1) => addrRT0_carry_n_2,
      CO(0) => addrRT0_carry_n_3,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => addrRT(2),
      DI(0) => '0',
      O(3 downto 0) => addrRT0(4 downto 1),
      S(3 downto 2) => addrRT(4 downto 3),
      S(1) => addrRT0_carry_i_1_n_0,
      S(0) => addrRT(1)
    );
\addrRT0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => addrRT0_carry_n_0,
      CO(3) => \addrRT0_carry__0_n_0\,
      CO(2) => \addrRT0_carry__0_n_1\,
      CO(1) => \addrRT0_carry__0_n_2\,
      CO(0) => \addrRT0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrRT0(8 downto 5),
      S(3 downto 0) => addrRT(8 downto 5)
    );
\addrRT0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrRT0_carry__0_n_0\,
      CO(3) => \addrRT0_carry__1_n_0\,
      CO(2) => \addrRT0_carry__1_n_1\,
      CO(1) => \addrRT0_carry__1_n_2\,
      CO(0) => \addrRT0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrRT0(12 downto 9),
      S(3 downto 0) => addrRT(12 downto 9)
    );
\addrRT0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrRT0_carry__1_n_0\,
      CO(3) => \addrRT0_carry__2_n_0\,
      CO(2) => \addrRT0_carry__2_n_1\,
      CO(1) => \addrRT0_carry__2_n_2\,
      CO(0) => \addrRT0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrRT0(16 downto 13),
      S(3 downto 0) => addrRT(16 downto 13)
    );
\addrRT0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrRT0_carry__2_n_0\,
      CO(3) => \addrRT0_carry__3_n_0\,
      CO(2) => \addrRT0_carry__3_n_1\,
      CO(1) => \addrRT0_carry__3_n_2\,
      CO(0) => \addrRT0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrRT0(20 downto 17),
      S(3 downto 0) => addrRT(20 downto 17)
    );
\addrRT0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrRT0_carry__3_n_0\,
      CO(3) => \addrRT0_carry__4_n_0\,
      CO(2) => \addrRT0_carry__4_n_1\,
      CO(1) => \addrRT0_carry__4_n_2\,
      CO(0) => \addrRT0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrRT0(24 downto 21),
      S(3 downto 0) => addrRT(24 downto 21)
    );
\addrRT0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrRT0_carry__4_n_0\,
      CO(3) => \addrRT0_carry__5_n_0\,
      CO(2) => \addrRT0_carry__5_n_1\,
      CO(1) => \addrRT0_carry__5_n_2\,
      CO(0) => \addrRT0_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrRT0(28 downto 25),
      S(3 downto 0) => addrRT(28 downto 25)
    );
\addrRT0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrRT0_carry__5_n_0\,
      CO(3 downto 2) => \NLW_addrRT0_carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \addrRT0_carry__6_n_2\,
      CO(0) => \addrRT0_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_addrRT0_carry__6_O_UNCONNECTED\(3),
      O(2 downto 0) => addrRT0(31 downto 29),
      S(3) => '0',
      S(2 downto 0) => addrRT(31 downto 29)
    );
addrRT0_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => addrRT(2),
      O => addrRT0_carry_i_1_n_0
    );
\addrRT[0]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT(0),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[0]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(0),
      O => \addrRT[0]_i_1_n_0\
    );
\addrRT[10]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(10),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[10]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(10),
      O => \addrRT[10]_i_1_n_0\
    );
\addrRT[11]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(11),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[11]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(11),
      O => \addrRT[11]_i_1_n_0\
    );
\addrRT[12]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(12),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[12]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(12),
      O => \addrRT[12]_i_1_n_0\
    );
\addrRT[13]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(13),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[13]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(13),
      O => \addrRT[13]_i_1_n_0\
    );
\addrRT[14]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(14),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[14]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(14),
      O => \addrRT[14]_i_1_n_0\
    );
\addrRT[15]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(15),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[15]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(15),
      O => \addrRT[15]_i_1_n_0\
    );
\addrRT[16]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(16),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[16]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(16),
      O => \addrRT[16]_i_1_n_0\
    );
\addrRT[17]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(17),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[17]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(17),
      O => \addrRT[17]_i_1_n_0\
    );
\addrRT[18]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(18),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[18]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(18),
      O => \addrRT[18]_i_1_n_0\
    );
\addrRT[19]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(19),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[19]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(19),
      O => \addrRT[19]_i_1_n_0\
    );
\addrRT[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(1),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[1]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(1),
      O => \addrRT[1]_i_1_n_0\
    );
\addrRT[20]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(20),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[20]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(20),
      O => \addrRT[20]_i_1_n_0\
    );
\addrRT[21]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(21),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[21]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(21),
      O => \addrRT[21]_i_1_n_0\
    );
\addrRT[22]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(22),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[22]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(22),
      O => \addrRT[22]_i_1_n_0\
    );
\addrRT[23]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(23),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[23]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(23),
      O => \addrRT[23]_i_1_n_0\
    );
\addrRT[24]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(24),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[24]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(24),
      O => \addrRT[24]_i_1_n_0\
    );
\addrRT[25]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(25),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[25]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(25),
      O => \addrRT[25]_i_1_n_0\
    );
\addrRT[26]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(26),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[26]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(26),
      O => \addrRT[26]_i_1_n_0\
    );
\addrRT[27]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(27),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[27]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(27),
      O => \addrRT[27]_i_1_n_0\
    );
\addrRT[28]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(28),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[28]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(28),
      O => \addrRT[28]_i_1_n_0\
    );
\addrRT[29]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(29),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[29]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(29),
      O => \addrRT[29]_i_1_n_0\
    );
\addrRT[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(2),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[2]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(2),
      O => \addrRT[2]_i_1_n_0\
    );
\addrRT[30]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(30),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[30]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(30),
      O => \addrRT[30]_i_1_n_0\
    );
\addrRT[31]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"AAAAFEAA"
    )
        port map (
      I0 => \ARLEN_reg[7]_i_1_n_0\,
      I1 => ACK_reg_n_0,
      I2 => \stateR_reg_n_0_[0]\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => \stateR_reg_n_0_[2]\,
      O => \addrRT[31]_i_1_n_0\
    );
\addrRT[31]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(31),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[31]_i_3_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(31),
      O => \addrRT[31]_i_2_n_0\
    );
\addrRT[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(3),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[3]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(3),
      O => \addrRT[3]_i_1_n_0\
    );
\addrRT[4]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(4),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[4]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(4),
      O => \addrRT[4]_i_1_n_0\
    );
\addrRT[5]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(5),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[5]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(5),
      O => \addrRT[5]_i_1_n_0\
    );
\addrRT[6]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(6),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[6]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(6),
      O => \addrRT[6]_i_1_n_0\
    );
\addrRT[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(7),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[7]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(7),
      O => \addrRT[7]_i_1_n_0\
    );
\addrRT[8]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(8),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[8]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(8),
      O => \addrRT[8]_i_1_n_0\
    );
\addrRT[9]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"B8FFB800"
    )
        port map (
      I0 => addrRT0(9),
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \addrR[9]_i_2_n_0\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_araddr(9),
      O => \addrRT[9]_i_1_n_0\
    );
\addrRT_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[0]_i_1_n_0\,
      Q => addrRT(0)
    );
\addrRT_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[10]_i_1_n_0\,
      Q => addrRT(10)
    );
\addrRT_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[11]_i_1_n_0\,
      Q => addrRT(11)
    );
\addrRT_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[12]_i_1_n_0\,
      Q => addrRT(12)
    );
\addrRT_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[13]_i_1_n_0\,
      Q => addrRT(13)
    );
\addrRT_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[14]_i_1_n_0\,
      Q => addrRT(14)
    );
\addrRT_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[15]_i_1_n_0\,
      Q => addrRT(15)
    );
\addrRT_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[16]_i_1_n_0\,
      Q => addrRT(16)
    );
\addrRT_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[17]_i_1_n_0\,
      Q => addrRT(17)
    );
\addrRT_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[18]_i_1_n_0\,
      Q => addrRT(18)
    );
\addrRT_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[19]_i_1_n_0\,
      Q => addrRT(19)
    );
\addrRT_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[1]_i_1_n_0\,
      Q => addrRT(1)
    );
\addrRT_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[20]_i_1_n_0\,
      Q => addrRT(20)
    );
\addrRT_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[21]_i_1_n_0\,
      Q => addrRT(21)
    );
\addrRT_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[22]_i_1_n_0\,
      Q => addrRT(22)
    );
\addrRT_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[23]_i_1_n_0\,
      Q => addrRT(23)
    );
\addrRT_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[24]_i_1_n_0\,
      Q => addrRT(24)
    );
\addrRT_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[25]_i_1_n_0\,
      Q => addrRT(25)
    );
\addrRT_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[26]_i_1_n_0\,
      Q => addrRT(26)
    );
\addrRT_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[27]_i_1_n_0\,
      Q => addrRT(27)
    );
\addrRT_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[28]_i_1_n_0\,
      Q => addrRT(28)
    );
\addrRT_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[29]_i_1_n_0\,
      Q => addrRT(29)
    );
\addrRT_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[2]_i_1_n_0\,
      Q => addrRT(2)
    );
\addrRT_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[30]_i_1_n_0\,
      Q => addrRT(30)
    );
\addrRT_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[31]_i_2_n_0\,
      Q => addrRT(31)
    );
\addrRT_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[3]_i_1_n_0\,
      Q => addrRT(3)
    );
\addrRT_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[4]_i_1_n_0\,
      Q => addrRT(4)
    );
\addrRT_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[5]_i_1_n_0\,
      Q => addrRT(5)
    );
\addrRT_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[6]_i_1_n_0\,
      Q => addrRT(6)
    );
\addrRT_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[7]_i_1_n_0\,
      Q => addrRT(7)
    );
\addrRT_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[8]_i_1_n_0\,
      Q => addrRT(8)
    );
\addrRT_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrRT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrRT[9]_i_1_n_0\,
      Q => addrRT(9)
    );
\addrR[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[0]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(0),
      O => \addrR[0]_i_1_n_0\
    );
\addrR[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA0CCA0CCAFCCA0C"
    )
        port map (
      I0 => \addrR[0]_i_3_n_0\,
      I1 => \addrR_reg_n_0_[0]\,
      I2 => \ARBURST_reg_reg_n_0_[0]\,
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => get_next_addr_rd00_in(0),
      I5 => \ARSTRB_reg[3]_i_4_n_0\,
      O => \addrR[0]_i_2_n_0\
    );
\addrR[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => \addrR_reg_n_0_[0]\,
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(0),
      I4 => ARLEN_reg(0),
      I5 => get_next_addr_rd2(0),
      O => \addrR[0]_i_3_n_0\
    );
\addrR[10]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[10]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(10),
      O => \addrR[10]_i_1_n_0\
    );
\addrR[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \addrR_reg_n_0_[10]\,
      I1 => \ARSTRB_reg[1]_i_3_n_0\,
      I2 => \p_1_out_carry__1_n_7\,
      I3 => get_next_addr_rd2(10),
      I4 => \addrR[15]_i_4_n_0\,
      I5 => \addrR[10]_i_3_n_0\,
      O => \addrR[10]_i_2_n_0\
    );
\addrR[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_rd0(8),
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => get_next_addr_rd00_in(10),
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => \ARBURST_reg_reg_n_0_[0]\,
      I5 => \addrR_reg_n_0_[10]\,
      O => \addrR[10]_i_3_n_0\
    );
\addrR[11]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[11]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(11),
      O => \addrR[11]_i_1_n_0\
    );
\addrR[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \addrR_reg_n_0_[11]\,
      I1 => \ARSTRB_reg[1]_i_3_n_0\,
      I2 => \p_1_out_carry__1_n_6\,
      I3 => get_next_addr_rd2(11),
      I4 => \addrR[15]_i_4_n_0\,
      I5 => \addrR[11]_i_4_n_0\,
      O => \addrR[11]_i_2_n_0\
    );
\addrR[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_rd0(9),
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => get_next_addr_rd00_in(11),
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => \ARBURST_reg_reg_n_0_[0]\,
      I5 => \addrR_reg_n_0_[11]\,
      O => \addrR[11]_i_4_n_0\
    );
\addrR[11]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[11]\,
      I1 => \p_1_out_carry__1_n_6\,
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      O => get_next_addr_rd3(11)
    );
\addrR[11]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[10]\,
      I1 => \p_1_out_carry__1_n_7\,
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      O => get_next_addr_rd3(10)
    );
\addrR[11]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[9]\,
      I1 => \p_1_out_carry__0_n_4\,
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      O => get_next_addr_rd3(9)
    );
\addrR[11]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[8]\,
      I1 => \p_1_out_carry__0_n_5\,
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      O => get_next_addr_rd3(8)
    );
\addrR[12]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[12]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(12),
      O => \addrR[12]_i_1_n_0\
    );
\addrR[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \addrR_reg_n_0_[12]\,
      I1 => \ARSTRB_reg[1]_i_3_n_0\,
      I2 => \p_1_out_carry__1_n_5\,
      I3 => get_next_addr_rd2(12),
      I4 => \addrR[15]_i_4_n_0\,
      I5 => \addrR[12]_i_3_n_0\,
      O => \addrR[12]_i_2_n_0\
    );
\addrR[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_rd0(10),
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => get_next_addr_rd00_in(12),
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => \ARBURST_reg_reg_n_0_[0]\,
      I5 => \addrR_reg_n_0_[12]\,
      O => \addrR[12]_i_3_n_0\
    );
\addrR[13]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[13]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(13),
      O => \addrR[13]_i_1_n_0\
    );
\addrR[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \addrR_reg_n_0_[13]\,
      I1 => \ARSTRB_reg[1]_i_3_n_0\,
      I2 => \p_1_out_carry__1_n_4\,
      I3 => get_next_addr_rd2(13),
      I4 => \addrR[15]_i_4_n_0\,
      I5 => \addrR[13]_i_3_n_0\,
      O => \addrR[13]_i_2_n_0\
    );
\addrR[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_rd0(11),
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => get_next_addr_rd00_in(13),
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => \ARBURST_reg_reg_n_0_[0]\,
      I5 => \addrR_reg_n_0_[13]\,
      O => \addrR[13]_i_3_n_0\
    );
\addrR[14]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[14]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(14),
      O => \addrR[14]_i_1_n_0\
    );
\addrR[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \addrR_reg_n_0_[14]\,
      I1 => \ARSTRB_reg[1]_i_3_n_0\,
      I2 => \p_1_out_carry__2_n_7\,
      I3 => get_next_addr_rd2(14),
      I4 => \addrR[15]_i_4_n_0\,
      I5 => \addrR[14]_i_3_n_0\,
      O => \addrR[14]_i_2_n_0\
    );
\addrR[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_rd0(12),
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => get_next_addr_rd00_in(14),
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => \ARBURST_reg_reg_n_0_[0]\,
      I5 => \addrR_reg_n_0_[14]\,
      O => \addrR[14]_i_3_n_0\
    );
\addrR[15]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[15]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(15),
      O => \addrR[15]_i_1_n_0\
    );
\addrR[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \addrR_reg_n_0_[15]\,
      I1 => \ARSTRB_reg[1]_i_3_n_0\,
      I2 => \p_1_out_carry__2_n_6\,
      I3 => get_next_addr_rd2(15),
      I4 => \addrR[15]_i_4_n_0\,
      I5 => \addrR[15]_i_5_n_0\,
      O => \addrR[15]_i_2_n_0\
    );
\addrR[15]_i_4\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \ARBURST_reg_reg_n_0_[1]\,
      I1 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[15]_i_4_n_0\
    );
\addrR[15]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_rd0(13),
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => get_next_addr_rd00_in(15),
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => \ARBURST_reg_reg_n_0_[0]\,
      I5 => \addrR_reg_n_0_[15]\,
      O => \addrR[15]_i_5_n_0\
    );
\addrR[15]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[15]\,
      I1 => \p_1_out_carry__2_n_6\,
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      O => get_next_addr_rd3(15)
    );
\addrR[15]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[14]\,
      I1 => \p_1_out_carry__2_n_7\,
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      O => get_next_addr_rd3(14)
    );
\addrR[15]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[13]\,
      I1 => \p_1_out_carry__1_n_4\,
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      O => get_next_addr_rd3(13)
    );
\addrR[15]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[12]\,
      I1 => \p_1_out_carry__1_n_5\,
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      O => get_next_addr_rd3(12)
    );
\addrR[16]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[16]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(16),
      O => \addrR[16]_i_1_n_0\
    );
\addrR[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(16),
      I2 => \addrR_reg_n_0_[16]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[16]_i_3_n_0\,
      O => \addrR[16]_i_2_n_0\
    );
\addrR[16]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(16),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(14),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[16]_i_3_n_0\
    );
\addrR[17]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[17]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(17),
      O => \addrR[17]_i_1_n_0\
    );
\addrR[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(17),
      I2 => \addrR_reg_n_0_[17]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[17]_i_3_n_0\,
      O => \addrR[17]_i_2_n_0\
    );
\addrR[17]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(17),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(15),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[17]_i_3_n_0\
    );
\addrR[18]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[18]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(18),
      O => \addrR[18]_i_1_n_0\
    );
\addrR[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(18),
      I2 => \addrR_reg_n_0_[18]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[18]_i_3_n_0\,
      O => \addrR[18]_i_2_n_0\
    );
\addrR[18]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(18),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(16),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[18]_i_3_n_0\
    );
\addrR[19]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[19]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(19),
      O => \addrR[19]_i_1_n_0\
    );
\addrR[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(19),
      I2 => \addrR_reg_n_0_[19]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[19]_i_4_n_0\,
      O => \addrR[19]_i_2_n_0\
    );
\addrR[19]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(19),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(17),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[19]_i_4_n_0\
    );
\addrR[19]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[19]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(19)
    );
\addrR[19]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[18]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(18)
    );
\addrR[19]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[17]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(17)
    );
\addrR[19]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[16]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(16)
    );
\addrR[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[1]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(1),
      O => \addrR[1]_i_1_n_0\
    );
\addrR[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA0CCA0CCAFCCA0C"
    )
        port map (
      I0 => \addrR[1]_i_3_n_0\,
      I1 => \addrR_reg_n_0_[1]\,
      I2 => \ARBURST_reg_reg_n_0_[0]\,
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => get_next_addr_rd00_in(1),
      I5 => \ARSTRB_reg[3]_i_4_n_0\,
      O => \addrR[1]_i_2_n_0\
    );
\addrR[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEFA0000220A"
    )
        port map (
      I0 => \addrR_reg_n_0_[1]\,
      I1 => ARLEN_reg(0),
      I2 => ARLEN_reg(1),
      I3 => ARSIZE_reg(0),
      I4 => \ARSTRB_reg[3]_i_4_n_0\,
      I5 => get_next_addr_rd2(1),
      O => \addrR[1]_i_3_n_0\
    );
\addrR[20]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[20]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(20),
      O => \addrR[20]_i_1_n_0\
    );
\addrR[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(20),
      I2 => \addrR_reg_n_0_[20]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[20]_i_3_n_0\,
      O => \addrR[20]_i_2_n_0\
    );
\addrR[20]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(20),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(18),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[20]_i_3_n_0\
    );
\addrR[21]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[21]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(21),
      O => \addrR[21]_i_1_n_0\
    );
\addrR[21]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(21),
      I2 => \addrR_reg_n_0_[21]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[21]_i_3_n_0\,
      O => \addrR[21]_i_2_n_0\
    );
\addrR[21]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(21),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(19),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[21]_i_3_n_0\
    );
\addrR[22]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[22]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(22),
      O => \addrR[22]_i_1_n_0\
    );
\addrR[22]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(22),
      I2 => \addrR_reg_n_0_[22]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[22]_i_3_n_0\,
      O => \addrR[22]_i_2_n_0\
    );
\addrR[22]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(22),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(20),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[22]_i_3_n_0\
    );
\addrR[23]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[23]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(23),
      O => \addrR[23]_i_1_n_0\
    );
\addrR[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(23),
      I2 => \addrR_reg_n_0_[23]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[23]_i_4_n_0\,
      O => \addrR[23]_i_2_n_0\
    );
\addrR[23]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(23),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(21),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[23]_i_4_n_0\
    );
\addrR[23]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[23]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(23)
    );
\addrR[23]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[22]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(22)
    );
\addrR[23]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[21]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(21)
    );
\addrR[23]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[20]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(20)
    );
\addrR[24]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[24]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(24),
      O => \addrR[24]_i_1_n_0\
    );
\addrR[24]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(24),
      I2 => \addrR_reg_n_0_[24]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[24]_i_3_n_0\,
      O => \addrR[24]_i_2_n_0\
    );
\addrR[24]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(24),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(22),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[24]_i_3_n_0\
    );
\addrR[25]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[25]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(25),
      O => \addrR[25]_i_1_n_0\
    );
\addrR[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(25),
      I2 => \addrR_reg_n_0_[25]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[25]_i_3_n_0\,
      O => \addrR[25]_i_2_n_0\
    );
\addrR[25]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(25),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(23),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[25]_i_3_n_0\
    );
\addrR[26]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[26]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(26),
      O => \addrR[26]_i_1_n_0\
    );
\addrR[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(26),
      I2 => \addrR_reg_n_0_[26]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[26]_i_3_n_0\,
      O => \addrR[26]_i_2_n_0\
    );
\addrR[26]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(26),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(24),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[26]_i_3_n_0\
    );
\addrR[27]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[27]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(27),
      O => \addrR[27]_i_1_n_0\
    );
\addrR[27]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(27),
      I2 => \addrR_reg_n_0_[27]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[27]_i_4_n_0\,
      O => \addrR[27]_i_2_n_0\
    );
\addrR[27]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(27),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(25),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[27]_i_4_n_0\
    );
\addrR[27]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[27]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(27)
    );
\addrR[27]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[26]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(26)
    );
\addrR[27]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[25]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(25)
    );
\addrR[27]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[24]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(24)
    );
\addrR[28]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[28]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(28),
      O => \addrR[28]_i_1_n_0\
    );
\addrR[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(28),
      I2 => \addrR_reg_n_0_[28]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[28]_i_3_n_0\,
      O => \addrR[28]_i_2_n_0\
    );
\addrR[28]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(28),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(26),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[28]_i_3_n_0\
    );
\addrR[29]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[29]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(29),
      O => \addrR[29]_i_1_n_0\
    );
\addrR[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(29),
      I2 => \addrR_reg_n_0_[29]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[29]_i_3_n_0\,
      O => \addrR[29]_i_2_n_0\
    );
\addrR[29]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(29),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(27),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[29]_i_3_n_0\
    );
\addrR[2]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[2]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(2),
      O => \addrR[2]_i_1_n_0\
    );
\addrR[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA3CCA3CCAFCCA0C"
    )
        port map (
      I0 => \addrR[2]_i_3_n_0\,
      I1 => \addrR_reg_n_0_[2]\,
      I2 => \ARBURST_reg_reg_n_0_[0]\,
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => get_next_addr_rd00_in(2),
      I5 => \ARSTRB_reg[3]_i_4_n_0\,
      O => \addrR[2]_i_2_n_0\
    );
\addrR[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEAAAE0002AAA2"
    )
        port map (
      I0 => \addrR_reg_n_0_[2]\,
      I1 => ARLEN_reg(2),
      I2 => ARSIZE_reg(0),
      I3 => \ARSTRB_reg[3]_i_4_n_0\,
      I4 => p_1_out_carry_n_7,
      I5 => get_next_addr_rd2(2),
      O => \addrR[2]_i_3_n_0\
    );
\addrR[2]_i_5\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA6A"
    )
        port map (
      I0 => \addrR_reg_n_0_[3]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(2),
      O => \addrR[2]_i_5_n_0\
    );
\addrR[2]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA9A"
    )
        port map (
      I0 => \addrR_reg_n_0_[2]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(2),
      O => \addrR[2]_i_6_n_0\
    );
\addrR[2]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A9AA"
    )
        port map (
      I0 => \addrR_reg_n_0_[1]\,
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(0),
      O => \addrR[2]_i_7_n_0\
    );
\addrR[2]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA9"
    )
        port map (
      I0 => \addrR_reg_n_0_[0]\,
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(0),
      O => \addrR[2]_i_8_n_0\
    );
\addrR[30]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[30]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(30),
      O => \addrR[30]_i_1_n_0\
    );
\addrR[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(30),
      I2 => \addrR_reg_n_0_[30]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[30]_i_3_n_0\,
      O => \addrR[30]_i_2_n_0\
    );
\addrR[30]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(30),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(28),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[30]_i_3_n_0\
    );
\addrR[31]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"ABAAABAAABAAAAAA"
    )
        port map (
      I0 => \ARLEN_reg[7]_i_1_n_0\,
      I1 => \tickR[3]_i_3_n_0\,
      I2 => \stateR_reg_n_0_[2]\,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => \stateR_reg_n_0_[0]\,
      I5 => ACK_reg_n_0,
      O => \addrR[31]_i_1_n_0\
    );
\addrR[31]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[28]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(28)
    );
\addrR[31]_i_2\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[31]_i_3_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(31),
      O => \addrR[31]_i_2_n_0\
    );
\addrR[31]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[31]_i_4_n_0\,
      I1 => get_next_addr_rd2(31),
      I2 => \addrR_reg_n_0_[31]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[31]_i_6_n_0\,
      O => \addrR[31]_i_3_n_0\
    );
\addrR[31]_i_4\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAAB"
    )
        port map (
      I0 => \p_1_out_carry__2_n_1\,
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(0),
      O => \addrR[31]_i_4_n_0\
    );
\addrR[31]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(31),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(29),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[31]_i_6_n_0\
    );
\addrR[31]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[31]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(31)
    );
\addrR[31]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[30]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(30)
    );
\addrR[31]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \addrR_reg_n_0_[29]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__2_n_1\,
      O => get_next_addr_rd3(29)
    );
\addrR[3]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[3]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(3),
      O => \addrR[3]_i_1_n_0\
    );
\addrR[3]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C03FC0C0A0"
    )
        port map (
      I0 => ARLEN_reg(3),
      I1 => p_1_out_carry_n_6,
      I2 => \addrR_reg_n_0_[3]\,
      I3 => ARSIZE_reg(0),
      I4 => ARSIZE_reg(1),
      I5 => ARSIZE_reg(2),
      O => \addrR[3]_i_10_n_0\
    );
\addrR[3]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C0C03FC0A0"
    )
        port map (
      I0 => ARLEN_reg(2),
      I1 => p_1_out_carry_n_7,
      I2 => \addrR_reg_n_0_[2]\,
      I3 => ARSIZE_reg(0),
      I4 => ARSIZE_reg(1),
      I5 => ARSIZE_reg(2),
      O => \addrR[3]_i_11_n_0\
    );
\addrR[3]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0F0F05FF0F0F0C0"
    )
        port map (
      I0 => ARLEN_reg(0),
      I1 => ARLEN_reg(1),
      I2 => \addrR_reg_n_0_[1]\,
      I3 => ARSIZE_reg(1),
      I4 => ARSIZE_reg(2),
      I5 => ARSIZE_reg(0),
      O => \addrR[3]_i_12_n_0\
    );
\addrR[3]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCCCCCC7"
    )
        port map (
      I0 => ARLEN_reg(0),
      I1 => \addrR_reg_n_0_[0]\,
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(0),
      O => \addrR[3]_i_13_n_0\
    );
\addrR[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[3]_i_3_n_0\,
      I1 => get_next_addr_rd2(3),
      I2 => \addrR_reg_n_0_[3]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[3]_i_5_n_0\,
      O => \addrR[3]_i_2_n_0\
    );
\addrR[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => ARLEN_reg(3),
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => p_1_out_carry_n_6,
      O => \addrR[3]_i_3_n_0\
    );
\addrR[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(3),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(1),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[3]_i_5_n_0\
    );
\addrR[3]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => ARSIZE_reg(2),
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(0),
      O => \addrR[3]_i_6_n_0\
    );
\addrR[3]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => ARSIZE_reg(2),
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(0),
      O => \addrR[3]_i_7_n_0\
    );
\addrR[3]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAA8A8AAA8A8"
    )
        port map (
      I0 => \addrR_reg_n_0_[1]\,
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(0),
      I4 => ARLEN_reg(1),
      I5 => ARLEN_reg(0),
      O => get_next_addr_rd3(1)
    );
\addrR[3]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      O => \addrR[3]_i_9_n_0\
    );
\addrR[4]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[4]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(4),
      O => \addrR[4]_i_1_n_0\
    );
\addrR[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[4]_i_3_n_0\,
      I1 => get_next_addr_rd2(4),
      I2 => \addrR_reg_n_0_[4]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[4]_i_4_n_0\,
      O => \addrR[4]_i_2_n_0\
    );
\addrR[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => ARLEN_reg(4),
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => p_1_out_carry_n_5,
      O => \addrR[4]_i_3_n_0\
    );
\addrR[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(4),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(2),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[4]_i_4_n_0\
    );
\addrR[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[5]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(5),
      O => \addrR[5]_i_1_n_0\
    );
\addrR[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[5]_i_3_n_0\,
      I1 => get_next_addr_rd2(5),
      I2 => \addrR_reg_n_0_[5]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[5]_i_4_n_0\,
      O => \addrR[5]_i_2_n_0\
    );
\addrR[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => ARLEN_reg(5),
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => p_1_out_carry_n_4,
      O => \addrR[5]_i_3_n_0\
    );
\addrR[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(5),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(3),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[5]_i_4_n_0\
    );
\addrR[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[6]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(6),
      O => \addrR[6]_i_1_n_0\
    );
\addrR[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[6]_i_3_n_0\,
      I1 => get_next_addr_rd2(6),
      I2 => \addrR_reg_n_0_[6]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[6]_i_4_n_0\,
      O => \addrR[6]_i_2_n_0\
    );
\addrR[6]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => ARLEN_reg(6),
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__0_n_7\,
      O => \addrR[6]_i_3_n_0\
    );
\addrR[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(6),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(4),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[6]_i_4_n_0\
    );
\addrR[7]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[7]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(7),
      O => \addrR[7]_i_1_n_0\
    );
\addrR[7]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3FC0C0C0C0C0C0A0"
    )
        port map (
      I0 => ARLEN_reg(7),
      I1 => \p_1_out_carry__0_n_6\,
      I2 => \addrR_reg_n_0_[7]\,
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(1),
      I5 => ARSIZE_reg(0),
      O => \addrR[7]_i_10_n_0\
    );
\addrR[7]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C03FC0C0C0C0C0A0"
    )
        port map (
      I0 => ARLEN_reg(6),
      I1 => \p_1_out_carry__0_n_7\,
      I2 => \addrR_reg_n_0_[6]\,
      I3 => ARSIZE_reg(0),
      I4 => ARSIZE_reg(2),
      I5 => ARSIZE_reg(1),
      O => \addrR[7]_i_11_n_0\
    );
\addrR[7]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C03FC0C0A0"
    )
        port map (
      I0 => ARLEN_reg(5),
      I1 => p_1_out_carry_n_4,
      I2 => \addrR_reg_n_0_[5]\,
      I3 => ARSIZE_reg(0),
      I4 => ARSIZE_reg(2),
      I5 => ARSIZE_reg(1),
      O => \addrR[7]_i_12_n_0\
    );
\addrR[7]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C0C03FC0A0"
    )
        port map (
      I0 => ARLEN_reg(4),
      I1 => p_1_out_carry_n_5,
      I2 => \addrR_reg_n_0_[4]\,
      I3 => ARSIZE_reg(0),
      I4 => ARSIZE_reg(2),
      I5 => ARSIZE_reg(1),
      O => \addrR[7]_i_13_n_0\
    );
\addrR[7]_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \addrR_reg_n_0_[7]\,
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(0),
      O => \addrR[7]_i_15_n_0\
    );
\addrR[7]_i_16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9AAA"
    )
        port map (
      I0 => \addrR_reg_n_0_[6]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      O => \addrR[7]_i_16_n_0\
    );
\addrR[7]_i_17\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA6A"
    )
        port map (
      I0 => \addrR_reg_n_0_[5]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      O => \addrR[7]_i_17_n_0\
    );
\addrR[7]_i_18\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA9A"
    )
        port map (
      I0 => \addrR_reg_n_0_[4]\,
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      O => \addrR[7]_i_18_n_0\
    );
\addrR[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrR[7]_i_3_n_0\,
      I1 => get_next_addr_rd2(7),
      I2 => \addrR_reg_n_0_[7]\,
      I3 => \ARBURST_reg_reg_n_0_[0]\,
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \addrR[7]_i_5_n_0\,
      O => \addrR[7]_i_2_n_0\
    );
\addrR[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => ARLEN_reg(7),
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__0_n_6\,
      O => \addrR[7]_i_3_n_0\
    );
\addrR[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_rd00_in(7),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => get_next_addr_rd0(5),
      I4 => \ARBURST_reg_reg_n_0_[1]\,
      I5 => \ARBURST_reg_reg_n_0_[0]\,
      O => \addrR[7]_i_5_n_0\
    );
\addrR[7]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      O => \addrR[7]_i_6_n_0\
    );
\addrR[7]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888A88888880"
    )
        port map (
      I0 => \addrR_reg_n_0_[6]\,
      I1 => \p_1_out_carry__0_n_7\,
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(0),
      I5 => ARLEN_reg(6),
      O => get_next_addr_rd3(6)
    );
\addrR[7]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => ARSIZE_reg(1),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(0),
      O => \addrR[7]_i_8_n_0\
    );
\addrR[7]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => ARSIZE_reg(1),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(0),
      O => \addrR[7]_i_9_n_0\
    );
\addrR[8]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[8]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(8),
      O => \addrR[8]_i_1_n_0\
    );
\addrR[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \addrR_reg_n_0_[8]\,
      I1 => \ARSTRB_reg[1]_i_3_n_0\,
      I2 => \p_1_out_carry__0_n_5\,
      I3 => get_next_addr_rd2(8),
      I4 => \addrR[15]_i_4_n_0\,
      I5 => \addrR[8]_i_3_n_0\,
      O => \addrR[8]_i_2_n_0\
    );
\addrR[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_rd0(6),
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => get_next_addr_rd00_in(8),
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => \ARBURST_reg_reg_n_0_[0]\,
      I5 => \addrR_reg_n_0_[8]\,
      O => \addrR[8]_i_3_n_0\
    );
\addrR[9]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \addrR[9]_i_2_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => s_axi_araddr(9),
      O => \addrR[9]_i_1_n_0\
    );
\addrR[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \addrR_reg_n_0_[9]\,
      I1 => \ARSTRB_reg[1]_i_3_n_0\,
      I2 => \p_1_out_carry__0_n_4\,
      I3 => get_next_addr_rd2(9),
      I4 => \addrR[15]_i_4_n_0\,
      I5 => \addrR[9]_i_3_n_0\,
      O => \addrR[9]_i_2_n_0\
    );
\addrR[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_rd0(7),
      I1 => \ARSTRB_reg[3]_i_4_n_0\,
      I2 => get_next_addr_rd00_in(9),
      I3 => \ARBURST_reg_reg_n_0_[1]\,
      I4 => \ARBURST_reg_reg_n_0_[0]\,
      I5 => \addrR_reg_n_0_[9]\,
      O => \addrR[9]_i_3_n_0\
    );
\addrR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[0]_i_1_n_0\,
      Q => \addrR_reg_n_0_[0]\
    );
\addrR_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[10]_i_1_n_0\,
      Q => \addrR_reg_n_0_[10]\
    );
\addrR_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[11]_i_1_n_0\,
      Q => \addrR_reg_n_0_[11]\
    );
\addrR_reg[11]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[7]_i_4_n_0\,
      CO(3) => \addrR_reg[11]_i_3_n_0\,
      CO(2) => \addrR_reg[11]_i_3_n_1\,
      CO(1) => \addrR_reg[11]_i_3_n_2\,
      CO(0) => \addrR_reg[11]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd2(11 downto 8),
      S(3 downto 0) => get_next_addr_rd3(11 downto 8)
    );
\addrR_reg[11]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[7]_i_14_n_0\,
      CO(3) => \addrR_reg[11]_i_9_n_0\,
      CO(2) => \addrR_reg[11]_i_9_n_1\,
      CO(1) => \addrR_reg[11]_i_9_n_2\,
      CO(0) => \addrR_reg[11]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd00_in(11 downto 8),
      S(3) => \addrR_reg_n_0_[11]\,
      S(2) => \addrR_reg_n_0_[10]\,
      S(1) => \addrR_reg_n_0_[9]\,
      S(0) => \addrR_reg_n_0_[8]\
    );
\addrR_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[12]_i_1_n_0\,
      Q => \addrR_reg_n_0_[12]\
    );
\addrR_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[13]_i_1_n_0\,
      Q => \addrR_reg_n_0_[13]\
    );
\addrR_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[14]_i_1_n_0\,
      Q => \addrR_reg_n_0_[14]\
    );
\addrR_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[15]_i_1_n_0\,
      Q => \addrR_reg_n_0_[15]\
    );
\addrR_reg[15]_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[11]_i_9_n_0\,
      CO(3) => \addrR_reg[15]_i_10_n_0\,
      CO(2) => \addrR_reg[15]_i_10_n_1\,
      CO(1) => \addrR_reg[15]_i_10_n_2\,
      CO(0) => \addrR_reg[15]_i_10_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd00_in(15 downto 12),
      S(3) => \addrR_reg_n_0_[15]\,
      S(2) => \addrR_reg_n_0_[14]\,
      S(1) => \addrR_reg_n_0_[13]\,
      S(0) => \addrR_reg_n_0_[12]\
    );
\addrR_reg[15]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[11]_i_3_n_0\,
      CO(3) => \addrR_reg[15]_i_3_n_0\,
      CO(2) => \addrR_reg[15]_i_3_n_1\,
      CO(1) => \addrR_reg[15]_i_3_n_2\,
      CO(0) => \addrR_reg[15]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd2(15 downto 12),
      S(3 downto 0) => get_next_addr_rd3(15 downto 12)
    );
\addrR_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[16]_i_1_n_0\,
      Q => \addrR_reg_n_0_[16]\
    );
\addrR_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[17]_i_1_n_0\,
      Q => \addrR_reg_n_0_[17]\
    );
\addrR_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[18]_i_1_n_0\,
      Q => \addrR_reg_n_0_[18]\
    );
\addrR_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[19]_i_1_n_0\,
      Q => \addrR_reg_n_0_[19]\
    );
\addrR_reg[19]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[15]_i_3_n_0\,
      CO(3) => \addrR_reg[19]_i_3_n_0\,
      CO(2) => \addrR_reg[19]_i_3_n_1\,
      CO(1) => \addrR_reg[19]_i_3_n_2\,
      CO(0) => \addrR_reg[19]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd2(19 downto 16),
      S(3 downto 0) => get_next_addr_rd3(19 downto 16)
    );
\addrR_reg[19]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[15]_i_10_n_0\,
      CO(3) => \addrR_reg[19]_i_9_n_0\,
      CO(2) => \addrR_reg[19]_i_9_n_1\,
      CO(1) => \addrR_reg[19]_i_9_n_2\,
      CO(0) => \addrR_reg[19]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd00_in(19 downto 16),
      S(3) => \addrR_reg_n_0_[19]\,
      S(2) => \addrR_reg_n_0_[18]\,
      S(1) => \addrR_reg_n_0_[17]\,
      S(0) => \addrR_reg_n_0_[16]\
    );
\addrR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[1]_i_1_n_0\,
      Q => \addrR_reg_n_0_[1]\
    );
\addrR_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[20]_i_1_n_0\,
      Q => \addrR_reg_n_0_[20]\
    );
\addrR_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[21]_i_1_n_0\,
      Q => \addrR_reg_n_0_[21]\
    );
\addrR_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[22]_i_1_n_0\,
      Q => \addrR_reg_n_0_[22]\
    );
\addrR_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[23]_i_1_n_0\,
      Q => \addrR_reg_n_0_[23]\
    );
\addrR_reg[23]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[19]_i_3_n_0\,
      CO(3) => \addrR_reg[23]_i_3_n_0\,
      CO(2) => \addrR_reg[23]_i_3_n_1\,
      CO(1) => \addrR_reg[23]_i_3_n_2\,
      CO(0) => \addrR_reg[23]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd2(23 downto 20),
      S(3 downto 0) => get_next_addr_rd3(23 downto 20)
    );
\addrR_reg[23]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[19]_i_9_n_0\,
      CO(3) => \addrR_reg[23]_i_9_n_0\,
      CO(2) => \addrR_reg[23]_i_9_n_1\,
      CO(1) => \addrR_reg[23]_i_9_n_2\,
      CO(0) => \addrR_reg[23]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd00_in(23 downto 20),
      S(3) => \addrR_reg_n_0_[23]\,
      S(2) => \addrR_reg_n_0_[22]\,
      S(1) => \addrR_reg_n_0_[21]\,
      S(0) => \addrR_reg_n_0_[20]\
    );
\addrR_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[24]_i_1_n_0\,
      Q => \addrR_reg_n_0_[24]\
    );
\addrR_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[25]_i_1_n_0\,
      Q => \addrR_reg_n_0_[25]\
    );
\addrR_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[26]_i_1_n_0\,
      Q => \addrR_reg_n_0_[26]\
    );
\addrR_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[27]_i_1_n_0\,
      Q => \addrR_reg_n_0_[27]\
    );
\addrR_reg[27]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[23]_i_3_n_0\,
      CO(3) => \addrR_reg[27]_i_3_n_0\,
      CO(2) => \addrR_reg[27]_i_3_n_1\,
      CO(1) => \addrR_reg[27]_i_3_n_2\,
      CO(0) => \addrR_reg[27]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd2(27 downto 24),
      S(3 downto 0) => get_next_addr_rd3(27 downto 24)
    );
\addrR_reg[27]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[23]_i_9_n_0\,
      CO(3) => \addrR_reg[27]_i_9_n_0\,
      CO(2) => \addrR_reg[27]_i_9_n_1\,
      CO(1) => \addrR_reg[27]_i_9_n_2\,
      CO(0) => \addrR_reg[27]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd00_in(27 downto 24),
      S(3) => \addrR_reg_n_0_[27]\,
      S(2) => \addrR_reg_n_0_[26]\,
      S(1) => \addrR_reg_n_0_[25]\,
      S(0) => \addrR_reg_n_0_[24]\
    );
\addrR_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[28]_i_1_n_0\,
      Q => \addrR_reg_n_0_[28]\
    );
\addrR_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[29]_i_1_n_0\,
      Q => \addrR_reg_n_0_[29]\
    );
\addrR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[2]_i_1_n_0\,
      Q => \addrR_reg_n_0_[2]\
    );
\addrR_reg[2]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \addrR_reg[2]_i_4_n_0\,
      CO(2) => \addrR_reg[2]_i_4_n_1\,
      CO(1) => \addrR_reg[2]_i_4_n_2\,
      CO(0) => \addrR_reg[2]_i_4_n_3\,
      CYINIT => '0',
      DI(3) => \addrR_reg_n_0_[3]\,
      DI(2) => \addrR_reg_n_0_[2]\,
      DI(1) => \addrR_reg_n_0_[1]\,
      DI(0) => \addrR_reg_n_0_[0]\,
      O(3 downto 0) => get_next_addr_rd00_in(3 downto 0),
      S(3) => \addrR[2]_i_5_n_0\,
      S(2) => \addrR[2]_i_6_n_0\,
      S(1) => \addrR[2]_i_7_n_0\,
      S(0) => \addrR[2]_i_8_n_0\
    );
\addrR_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[30]_i_1_n_0\,
      Q => \addrR_reg_n_0_[30]\
    );
\addrR_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[31]_i_2_n_0\,
      Q => \addrR_reg_n_0_[31]\
    );
\addrR_reg[31]_i_11\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[27]_i_9_n_0\,
      CO(3) => \NLW_addrR_reg[31]_i_11_CO_UNCONNECTED\(3),
      CO(2) => \addrR_reg[31]_i_11_n_1\,
      CO(1) => \addrR_reg[31]_i_11_n_2\,
      CO(0) => \addrR_reg[31]_i_11_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd00_in(31 downto 28),
      S(3) => \addrR_reg_n_0_[31]\,
      S(2) => \addrR_reg_n_0_[30]\,
      S(1) => \addrR_reg_n_0_[29]\,
      S(0) => \addrR_reg_n_0_[28]\
    );
\addrR_reg[31]_i_5\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[27]_i_3_n_0\,
      CO(3) => \NLW_addrR_reg[31]_i_5_CO_UNCONNECTED\(3),
      CO(2) => \addrR_reg[31]_i_5_n_1\,
      CO(1) => \addrR_reg[31]_i_5_n_2\,
      CO(0) => \addrR_reg[31]_i_5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd2(31 downto 28),
      S(3 downto 0) => get_next_addr_rd3(31 downto 28)
    );
\addrR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[3]_i_1_n_0\,
      Q => \addrR_reg_n_0_[3]\
    );
\addrR_reg[3]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \addrR_reg[3]_i_4_n_0\,
      CO(2) => \addrR_reg[3]_i_4_n_1\,
      CO(1) => \addrR_reg[3]_i_4_n_2\,
      CO(0) => \addrR_reg[3]_i_4_n_3\,
      CYINIT => '0',
      DI(3) => \addrR[3]_i_6_n_0\,
      DI(2) => \addrR[3]_i_7_n_0\,
      DI(1) => get_next_addr_rd3(1),
      DI(0) => \addrR[3]_i_9_n_0\,
      O(3 downto 0) => get_next_addr_rd2(3 downto 0),
      S(3) => \addrR[3]_i_10_n_0\,
      S(2) => \addrR[3]_i_11_n_0\,
      S(1) => \addrR[3]_i_12_n_0\,
      S(0) => \addrR[3]_i_13_n_0\
    );
\addrR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[4]_i_1_n_0\,
      Q => \addrR_reg_n_0_[4]\
    );
\addrR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[5]_i_1_n_0\,
      Q => \addrR_reg_n_0_[5]\
    );
\addrR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[6]_i_1_n_0\,
      Q => \addrR_reg_n_0_[6]\
    );
\addrR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[7]_i_1_n_0\,
      Q => \addrR_reg_n_0_[7]\
    );
\addrR_reg[7]_i_14\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[2]_i_4_n_0\,
      CO(3) => \addrR_reg[7]_i_14_n_0\,
      CO(2) => \addrR_reg[7]_i_14_n_1\,
      CO(1) => \addrR_reg[7]_i_14_n_2\,
      CO(0) => \addrR_reg[7]_i_14_n_3\,
      CYINIT => '0',
      DI(3) => \addrR_reg_n_0_[7]\,
      DI(2) => \addrR_reg_n_0_[6]\,
      DI(1) => \addrR_reg_n_0_[5]\,
      DI(0) => \addrR_reg_n_0_[4]\,
      O(3 downto 0) => get_next_addr_rd00_in(7 downto 4),
      S(3) => \addrR[7]_i_15_n_0\,
      S(2) => \addrR[7]_i_16_n_0\,
      S(1) => \addrR[7]_i_17_n_0\,
      S(0) => \addrR[7]_i_18_n_0\
    );
\addrR_reg[7]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrR_reg[3]_i_4_n_0\,
      CO(3) => \addrR_reg[7]_i_4_n_0\,
      CO(2) => \addrR_reg[7]_i_4_n_1\,
      CO(1) => \addrR_reg[7]_i_4_n_2\,
      CO(0) => \addrR_reg[7]_i_4_n_3\,
      CYINIT => '0',
      DI(3) => \addrR[7]_i_6_n_0\,
      DI(2) => get_next_addr_rd3(6),
      DI(1) => \addrR[7]_i_8_n_0\,
      DI(0) => \addrR[7]_i_9_n_0\,
      O(3 downto 0) => get_next_addr_rd2(7 downto 4),
      S(3) => \addrR[7]_i_10_n_0\,
      S(2) => \addrR[7]_i_11_n_0\,
      S(1) => \addrR[7]_i_12_n_0\,
      S(0) => \addrR[7]_i_13_n_0\
    );
\addrR_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[8]_i_1_n_0\,
      Q => \addrR_reg_n_0_[8]\
    );
\addrR_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrR[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrR[9]_i_1_n_0\,
      Q => \addrR_reg_n_0_[9]\
    );
addrWT0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => addrWT0_carry_n_0,
      CO(2) => addrWT0_carry_n_1,
      CO(1) => addrWT0_carry_n_2,
      CO(0) => addrWT0_carry_n_3,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => addrWT(2),
      DI(0) => '0',
      O(3 downto 0) => addrWT0(4 downto 1),
      S(3 downto 2) => addrWT(4 downto 3),
      S(1) => addrWT0_carry_i_1_n_0,
      S(0) => addrWT(1)
    );
\addrWT0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => addrWT0_carry_n_0,
      CO(3) => \addrWT0_carry__0_n_0\,
      CO(2) => \addrWT0_carry__0_n_1\,
      CO(1) => \addrWT0_carry__0_n_2\,
      CO(0) => \addrWT0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrWT0(8 downto 5),
      S(3 downto 0) => addrWT(8 downto 5)
    );
\addrWT0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrWT0_carry__0_n_0\,
      CO(3) => \addrWT0_carry__1_n_0\,
      CO(2) => \addrWT0_carry__1_n_1\,
      CO(1) => \addrWT0_carry__1_n_2\,
      CO(0) => \addrWT0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrWT0(12 downto 9),
      S(3 downto 0) => addrWT(12 downto 9)
    );
\addrWT0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrWT0_carry__1_n_0\,
      CO(3) => \addrWT0_carry__2_n_0\,
      CO(2) => \addrWT0_carry__2_n_1\,
      CO(1) => \addrWT0_carry__2_n_2\,
      CO(0) => \addrWT0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrWT0(16 downto 13),
      S(3 downto 0) => addrWT(16 downto 13)
    );
\addrWT0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrWT0_carry__2_n_0\,
      CO(3) => \addrWT0_carry__3_n_0\,
      CO(2) => \addrWT0_carry__3_n_1\,
      CO(1) => \addrWT0_carry__3_n_2\,
      CO(0) => \addrWT0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrWT0(20 downto 17),
      S(3 downto 0) => addrWT(20 downto 17)
    );
\addrWT0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrWT0_carry__3_n_0\,
      CO(3) => \addrWT0_carry__4_n_0\,
      CO(2) => \addrWT0_carry__4_n_1\,
      CO(1) => \addrWT0_carry__4_n_2\,
      CO(0) => \addrWT0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrWT0(24 downto 21),
      S(3 downto 0) => addrWT(24 downto 21)
    );
\addrWT0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrWT0_carry__4_n_0\,
      CO(3) => \addrWT0_carry__5_n_0\,
      CO(2) => \addrWT0_carry__5_n_1\,
      CO(1) => \addrWT0_carry__5_n_2\,
      CO(0) => \addrWT0_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => addrWT0(28 downto 25),
      S(3 downto 0) => addrWT(28 downto 25)
    );
\addrWT0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrWT0_carry__5_n_0\,
      CO(3 downto 2) => \NLW_addrWT0_carry__6_CO_UNCONNECTED\(3 downto 2),
      CO(1) => \addrWT0_carry__6_n_2\,
      CO(0) => \addrWT0_carry__6_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3) => \NLW_addrWT0_carry__6_O_UNCONNECTED\(3),
      O(2 downto 0) => addrWT0(31 downto 29),
      S(3) => '0',
      S(2 downto 0) => addrWT(31 downto 29)
    );
addrWT0_carry_i_1: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => addrWT(2),
      O => addrWT0_carry_i_1_n_0
    );
\addrWT[0]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(0),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT(0),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[0]_i_2_n_0\,
      O => \addrWT[0]_i_1_n_0\
    );
\addrWT[10]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(10),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(10),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[10]_i_2_n_0\,
      O => \addrWT[10]_i_1_n_0\
    );
\addrWT[11]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(11),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(11),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[11]_i_2_n_0\,
      O => \addrWT[11]_i_1_n_0\
    );
\addrWT[12]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(12),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(12),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[12]_i_2_n_0\,
      O => \addrWT[12]_i_1_n_0\
    );
\addrWT[13]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(13),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(13),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[13]_i_2_n_0\,
      O => \addrWT[13]_i_1_n_0\
    );
\addrWT[14]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(14),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(14),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[14]_i_2_n_0\,
      O => \addrWT[14]_i_1_n_0\
    );
\addrWT[15]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(15),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(15),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[15]_i_2_n_0\,
      O => \addrWT[15]_i_1_n_0\
    );
\addrWT[16]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(16),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(16),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[16]_i_2_n_0\,
      O => \addrWT[16]_i_1_n_0\
    );
\addrWT[17]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(17),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(17),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[17]_i_2_n_0\,
      O => \addrWT[17]_i_1_n_0\
    );
\addrWT[18]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(18),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(18),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[18]_i_2_n_0\,
      O => \addrWT[18]_i_1_n_0\
    );
\addrWT[19]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(19),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(19),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[19]_i_2_n_0\,
      O => \addrWT[19]_i_1_n_0\
    );
\addrWT[1]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(1),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(1),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[1]_i_2_n_0\,
      O => \addrWT[1]_i_1_n_0\
    );
\addrWT[20]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(20),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(20),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[20]_i_2_n_0\,
      O => \addrWT[20]_i_1_n_0\
    );
\addrWT[21]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(21),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(21),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[21]_i_2_n_0\,
      O => \addrWT[21]_i_1_n_0\
    );
\addrWT[22]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(22),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(22),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[22]_i_2_n_0\,
      O => \addrWT[22]_i_1_n_0\
    );
\addrWT[23]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(23),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(23),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[23]_i_2_n_0\,
      O => \addrWT[23]_i_1_n_0\
    );
\addrWT[24]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(24),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(24),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[24]_i_2_n_0\,
      O => \addrWT[24]_i_1_n_0\
    );
\addrWT[25]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(25),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(25),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[25]_i_2_n_0\,
      O => \addrWT[25]_i_1_n_0\
    );
\addrWT[26]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(26),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(26),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[26]_i_2_n_0\,
      O => \addrWT[26]_i_1_n_0\
    );
\addrWT[27]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(27),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(27),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[27]_i_2_n_0\,
      O => \addrWT[27]_i_1_n_0\
    );
\addrWT[28]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(28),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(28),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[28]_i_2_n_0\,
      O => \addrWT[28]_i_1_n_0\
    );
\addrWT[29]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(29),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(29),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[29]_i_2_n_0\,
      O => \addrWT[29]_i_1_n_0\
    );
\addrWT[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(2),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(2),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[2]_i_2_n_0\,
      O => \addrWT[2]_i_1_n_0\
    );
\addrWT[30]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(30),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(30),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[30]_i_2_n_0\,
      O => \addrWT[30]_i_1_n_0\
    );
\addrWT[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3414"
    )
        port map (
      I0 => \stateW_reg_n_0_[1]\,
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => ACK_reg_n_0,
      O => \addrWT[31]_i_1_n_0\
    );
\addrWT[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(31),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(31),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[31]_i_2_n_0\,
      O => \addrWT[31]_i_2_n_0\
    );
\addrWT[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(3),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(3),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[3]_i_2_n_0\,
      O => \addrWT[3]_i_1_n_0\
    );
\addrWT[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(4),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(4),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[4]_i_2_n_0\,
      O => \addrWT[4]_i_1_n_0\
    );
\addrWT[5]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(5),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(5),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[5]_i_2_n_0\,
      O => \addrWT[5]_i_1_n_0\
    );
\addrWT[6]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(6),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(6),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[6]_i_2_n_0\,
      O => \addrWT[6]_i_1_n_0\
    );
\addrWT[7]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(7),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(7),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[7]_i_2_n_0\,
      O => \addrWT[7]_i_1_n_0\
    );
\addrWT[8]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(8),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(8),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[8]_i_2_n_0\,
      O => \addrWT[8]_i_1_n_0\
    );
\addrWT[9]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FE02FEFEFE020202"
    )
        port map (
      I0 => AWADDR_reg(9),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => addrWT0(9),
      I4 => \BID[3]_i_2_n_0\,
      I5 => \addrW[9]_i_2_n_0\,
      O => \addrWT[9]_i_1_n_0\
    );
\addrWT_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[0]_i_1_n_0\,
      Q => addrWT(0)
    );
\addrWT_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[10]_i_1_n_0\,
      Q => addrWT(10)
    );
\addrWT_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[11]_i_1_n_0\,
      Q => addrWT(11)
    );
\addrWT_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[12]_i_1_n_0\,
      Q => addrWT(12)
    );
\addrWT_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[13]_i_1_n_0\,
      Q => addrWT(13)
    );
\addrWT_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[14]_i_1_n_0\,
      Q => addrWT(14)
    );
\addrWT_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[15]_i_1_n_0\,
      Q => addrWT(15)
    );
\addrWT_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[16]_i_1_n_0\,
      Q => addrWT(16)
    );
\addrWT_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[17]_i_1_n_0\,
      Q => addrWT(17)
    );
\addrWT_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[18]_i_1_n_0\,
      Q => addrWT(18)
    );
\addrWT_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[19]_i_1_n_0\,
      Q => addrWT(19)
    );
\addrWT_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[1]_i_1_n_0\,
      Q => addrWT(1)
    );
\addrWT_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[20]_i_1_n_0\,
      Q => addrWT(20)
    );
\addrWT_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[21]_i_1_n_0\,
      Q => addrWT(21)
    );
\addrWT_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[22]_i_1_n_0\,
      Q => addrWT(22)
    );
\addrWT_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[23]_i_1_n_0\,
      Q => addrWT(23)
    );
\addrWT_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[24]_i_1_n_0\,
      Q => addrWT(24)
    );
\addrWT_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[25]_i_1_n_0\,
      Q => addrWT(25)
    );
\addrWT_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[26]_i_1_n_0\,
      Q => addrWT(26)
    );
\addrWT_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[27]_i_1_n_0\,
      Q => addrWT(27)
    );
\addrWT_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[28]_i_1_n_0\,
      Q => addrWT(28)
    );
\addrWT_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[29]_i_1_n_0\,
      Q => addrWT(29)
    );
\addrWT_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[2]_i_1_n_0\,
      Q => addrWT(2)
    );
\addrWT_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[30]_i_1_n_0\,
      Q => addrWT(30)
    );
\addrWT_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[31]_i_2_n_0\,
      Q => addrWT(31)
    );
\addrWT_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[3]_i_1_n_0\,
      Q => addrWT(3)
    );
\addrWT_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[4]_i_1_n_0\,
      Q => addrWT(4)
    );
\addrWT_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[5]_i_1_n_0\,
      Q => addrWT(5)
    );
\addrWT_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[6]_i_1_n_0\,
      Q => addrWT(6)
    );
\addrWT_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[7]_i_1_n_0\,
      Q => addrWT(7)
    );
\addrWT_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[8]_i_1_n_0\,
      Q => addrWT(8)
    );
\addrWT_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \addrWT[31]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \addrWT[9]_i_1_n_0\,
      Q => addrWT(9)
    );
\addrW[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(0),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[0]_i_2_n_0\,
      O => \addrW[0]_i_1_n_0\
    );
\addrW[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA0CCA0CCAFCCA0C"
    )
        port map (
      I0 => \addrW[0]_i_3_n_0\,
      I1 => \^addr\(0),
      I2 => \AWBURST_reg_reg_n_0_[0]\,
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => get_next_addr_wr00_in(0),
      I5 => \addrW[2]_i_5_n_0\,
      O => \addrW[0]_i_2_n_0\
    );
\addrW[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFE00000002"
    )
        port map (
      I0 => \^addr\(0),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(0),
      I4 => AWLEN_reg(0),
      I5 => get_next_addr_wr2(0),
      O => \addrW[0]_i_3_n_0\
    );
\addrW[10]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(10),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[10]_i_2_n_0\,
      O => \addrW[10]_i_1_n_0\
    );
\addrW[10]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \^addr\(10),
      I1 => \addrW[15]_i_3_n_0\,
      I2 => \p_1_out_inferred__0/i__carry__1_n_7\,
      I3 => get_next_addr_wr2(10),
      I4 => \addrW[15]_i_5_n_0\,
      I5 => \addrW[10]_i_3_n_0\,
      O => \addrW[10]_i_2_n_0\
    );
\addrW[10]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_wr0(8),
      I1 => \addrW[2]_i_5_n_0\,
      I2 => get_next_addr_wr00_in(10),
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => \AWBURST_reg_reg_n_0_[0]\,
      I5 => \^addr\(10),
      O => \addrW[10]_i_3_n_0\
    );
\addrW[11]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(11),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[11]_i_2_n_0\,
      O => \addrW[11]_i_1_n_0\
    );
\addrW[11]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \^addr\(11),
      I1 => \addrW[15]_i_3_n_0\,
      I2 => \p_1_out_inferred__0/i__carry__1_n_6\,
      I3 => get_next_addr_wr2(11),
      I4 => \addrW[15]_i_5_n_0\,
      I5 => \addrW[11]_i_4_n_0\,
      O => \addrW[11]_i_2_n_0\
    );
\addrW[11]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_wr0(9),
      I1 => \addrW[2]_i_5_n_0\,
      I2 => get_next_addr_wr00_in(11),
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => \AWBURST_reg_reg_n_0_[0]\,
      I5 => \^addr\(11),
      O => \addrW[11]_i_4_n_0\
    );
\addrW[11]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \^addr\(11),
      I1 => \p_1_out_inferred__0/i__carry__1_n_6\,
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      O => get_next_addr_wr3(11)
    );
\addrW[11]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \^addr\(10),
      I1 => \p_1_out_inferred__0/i__carry__1_n_7\,
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      O => get_next_addr_wr3(10)
    );
\addrW[11]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \^addr\(9),
      I1 => \p_1_out_inferred__0/i__carry__0_n_4\,
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      O => get_next_addr_wr3(9)
    );
\addrW[11]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \^addr\(8),
      I1 => \p_1_out_inferred__0/i__carry__0_n_5\,
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      O => get_next_addr_wr3(8)
    );
\addrW[12]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(12),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[12]_i_2_n_0\,
      O => \addrW[12]_i_1_n_0\
    );
\addrW[12]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \^addr\(12),
      I1 => \addrW[15]_i_3_n_0\,
      I2 => \p_1_out_inferred__0/i__carry__1_n_5\,
      I3 => get_next_addr_wr2(12),
      I4 => \addrW[15]_i_5_n_0\,
      I5 => \addrW[12]_i_3_n_0\,
      O => \addrW[12]_i_2_n_0\
    );
\addrW[12]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_wr0(10),
      I1 => \addrW[2]_i_5_n_0\,
      I2 => get_next_addr_wr00_in(12),
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => \AWBURST_reg_reg_n_0_[0]\,
      I5 => \^addr\(12),
      O => \addrW[12]_i_3_n_0\
    );
\addrW[13]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(13),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[13]_i_2_n_0\,
      O => \addrW[13]_i_1_n_0\
    );
\addrW[13]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \^addr\(13),
      I1 => \addrW[15]_i_3_n_0\,
      I2 => \p_1_out_inferred__0/i__carry__1_n_4\,
      I3 => get_next_addr_wr2(13),
      I4 => \addrW[15]_i_5_n_0\,
      I5 => \addrW[13]_i_3_n_0\,
      O => \addrW[13]_i_2_n_0\
    );
\addrW[13]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_wr0(11),
      I1 => \addrW[2]_i_5_n_0\,
      I2 => get_next_addr_wr00_in(13),
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => \AWBURST_reg_reg_n_0_[0]\,
      I5 => \^addr\(13),
      O => \addrW[13]_i_3_n_0\
    );
\addrW[14]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(14),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[14]_i_2_n_0\,
      O => \addrW[14]_i_1_n_0\
    );
\addrW[14]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \^addr\(14),
      I1 => \addrW[15]_i_3_n_0\,
      I2 => \p_1_out_inferred__0/i__carry__2_n_7\,
      I3 => get_next_addr_wr2(14),
      I4 => \addrW[15]_i_5_n_0\,
      I5 => \addrW[14]_i_3_n_0\,
      O => \addrW[14]_i_2_n_0\
    );
\addrW[14]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_wr0(12),
      I1 => \addrW[2]_i_5_n_0\,
      I2 => get_next_addr_wr00_in(14),
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => \AWBURST_reg_reg_n_0_[0]\,
      I5 => \^addr\(14),
      O => \addrW[14]_i_3_n_0\
    );
\addrW[15]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(15),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[15]_i_2_n_0\,
      O => \addrW[15]_i_1_n_0\
    );
\addrW[15]_i_10\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \^addr\(12),
      I1 => \p_1_out_inferred__0/i__carry__1_n_5\,
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      O => get_next_addr_wr3(12)
    );
\addrW[15]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \^addr\(15),
      I1 => \addrW[15]_i_3_n_0\,
      I2 => \p_1_out_inferred__0/i__carry__2_n_6\,
      I3 => get_next_addr_wr2(15),
      I4 => \addrW[15]_i_5_n_0\,
      I5 => \addrW[15]_i_6_n_0\,
      O => \addrW[15]_i_2_n_0\
    );
\addrW[15]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      O => \addrW[15]_i_3_n_0\
    );
\addrW[15]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \AWBURST_reg_reg_n_0_[1]\,
      I1 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[15]_i_5_n_0\
    );
\addrW[15]_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_wr0(13),
      I1 => \addrW[2]_i_5_n_0\,
      I2 => get_next_addr_wr00_in(15),
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => \AWBURST_reg_reg_n_0_[0]\,
      I5 => \^addr\(15),
      O => \addrW[15]_i_6_n_0\
    );
\addrW[15]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \^addr\(15),
      I1 => \p_1_out_inferred__0/i__carry__2_n_6\,
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      O => get_next_addr_wr3(15)
    );
\addrW[15]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \^addr\(14),
      I1 => \p_1_out_inferred__0/i__carry__2_n_7\,
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      O => get_next_addr_wr3(14)
    );
\addrW[15]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888880"
    )
        port map (
      I0 => \^addr\(13),
      I1 => \p_1_out_inferred__0/i__carry__1_n_4\,
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      O => get_next_addr_wr3(13)
    );
\addrW[16]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(16),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[16]_i_2_n_0\,
      O => \addrW[16]_i_1_n_0\
    );
\addrW[16]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(16),
      I2 => \^addr\(16),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[16]_i_3_n_0\,
      O => \addrW[16]_i_2_n_0\
    );
\addrW[16]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(16),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(14),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[16]_i_3_n_0\
    );
\addrW[17]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(17),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[17]_i_2_n_0\,
      O => \addrW[17]_i_1_n_0\
    );
\addrW[17]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(17),
      I2 => \^addr\(17),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[17]_i_3_n_0\,
      O => \addrW[17]_i_2_n_0\
    );
\addrW[17]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(17),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(15),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[17]_i_3_n_0\
    );
\addrW[18]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(18),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[18]_i_2_n_0\,
      O => \addrW[18]_i_1_n_0\
    );
\addrW[18]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(18),
      I2 => \^addr\(18),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[18]_i_3_n_0\,
      O => \addrW[18]_i_2_n_0\
    );
\addrW[18]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(18),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(16),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[18]_i_3_n_0\
    );
\addrW[19]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(19),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[19]_i_2_n_0\,
      O => \addrW[19]_i_1_n_0\
    );
\addrW[19]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(19),
      I2 => \^addr\(19),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[19]_i_4_n_0\,
      O => \addrW[19]_i_2_n_0\
    );
\addrW[19]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(19),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(17),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[19]_i_4_n_0\
    );
\addrW[19]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(19),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(19)
    );
\addrW[19]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(18),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(18)
    );
\addrW[19]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(17),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(17)
    );
\addrW[19]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(16),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(16)
    );
\addrW[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(1),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[1]_i_2_n_0\,
      O => \addrW[1]_i_1_n_0\
    );
\addrW[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA0CCA0CCAFCCA0C"
    )
        port map (
      I0 => \addrW[1]_i_3_n_0\,
      I1 => \^addr\(1),
      I2 => \AWBURST_reg_reg_n_0_[0]\,
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => get_next_addr_wr00_in(1),
      I5 => \addrW[2]_i_5_n_0\,
      O => \addrW[1]_i_2_n_0\
    );
\addrW[1]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFEEFA0000220A"
    )
        port map (
      I0 => \^addr\(1),
      I1 => AWLEN_reg(0),
      I2 => AWLEN_reg(1),
      I3 => AWSIZE_reg(0),
      I4 => \addrW[2]_i_5_n_0\,
      I5 => get_next_addr_wr2(1),
      O => \addrW[1]_i_3_n_0\
    );
\addrW[20]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(20),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[20]_i_2_n_0\,
      O => \addrW[20]_i_1_n_0\
    );
\addrW[20]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(20),
      I2 => \^addr\(20),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[20]_i_3_n_0\,
      O => \addrW[20]_i_2_n_0\
    );
\addrW[20]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(20),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(18),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[20]_i_3_n_0\
    );
\addrW[21]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(21),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[21]_i_2_n_0\,
      O => \addrW[21]_i_1_n_0\
    );
\addrW[21]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(21),
      I2 => \^addr\(21),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[21]_i_3_n_0\,
      O => \addrW[21]_i_2_n_0\
    );
\addrW[21]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(21),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(19),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[21]_i_3_n_0\
    );
\addrW[22]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(22),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[22]_i_2_n_0\,
      O => \addrW[22]_i_1_n_0\
    );
\addrW[22]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(22),
      I2 => \^addr\(22),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[22]_i_3_n_0\,
      O => \addrW[22]_i_2_n_0\
    );
\addrW[22]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(22),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(20),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[22]_i_3_n_0\
    );
\addrW[23]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(23),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[23]_i_2_n_0\,
      O => \addrW[23]_i_1_n_0\
    );
\addrW[23]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(23),
      I2 => \^addr\(23),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[23]_i_4_n_0\,
      O => \addrW[23]_i_2_n_0\
    );
\addrW[23]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(23),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(21),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[23]_i_4_n_0\
    );
\addrW[23]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(23),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(23)
    );
\addrW[23]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(22),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(22)
    );
\addrW[23]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(21),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(21)
    );
\addrW[23]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(20),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(20)
    );
\addrW[24]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(24),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[24]_i_2_n_0\,
      O => \addrW[24]_i_1_n_0\
    );
\addrW[24]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(24),
      I2 => \^addr\(24),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[24]_i_3_n_0\,
      O => \addrW[24]_i_2_n_0\
    );
\addrW[24]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(24),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(22),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[24]_i_3_n_0\
    );
\addrW[25]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(25),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[25]_i_2_n_0\,
      O => \addrW[25]_i_1_n_0\
    );
\addrW[25]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(25),
      I2 => \^addr\(25),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[25]_i_3_n_0\,
      O => \addrW[25]_i_2_n_0\
    );
\addrW[25]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(25),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(23),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[25]_i_3_n_0\
    );
\addrW[26]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(26),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[26]_i_2_n_0\,
      O => \addrW[26]_i_1_n_0\
    );
\addrW[26]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(26),
      I2 => \^addr\(26),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[26]_i_3_n_0\,
      O => \addrW[26]_i_2_n_0\
    );
\addrW[26]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(26),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(24),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[26]_i_3_n_0\
    );
\addrW[27]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(27),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[27]_i_2_n_0\,
      O => \addrW[27]_i_1_n_0\
    );
\addrW[27]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(27),
      I2 => \^addr\(27),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[27]_i_4_n_0\,
      O => \addrW[27]_i_2_n_0\
    );
\addrW[27]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(27),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(25),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[27]_i_4_n_0\
    );
\addrW[27]_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(27),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(27)
    );
\addrW[27]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(26),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(26)
    );
\addrW[27]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(25),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(25)
    );
\addrW[27]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(24),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(24)
    );
\addrW[28]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(28),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[28]_i_2_n_0\,
      O => \addrW[28]_i_1_n_0\
    );
\addrW[28]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(28),
      I2 => \^addr\(28),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[28]_i_3_n_0\,
      O => \addrW[28]_i_2_n_0\
    );
\addrW[28]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(28),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(26),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[28]_i_3_n_0\
    );
\addrW[29]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(29),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[29]_i_2_n_0\,
      O => \addrW[29]_i_1_n_0\
    );
\addrW[29]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(29),
      I2 => \^addr\(29),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[29]_i_3_n_0\,
      O => \addrW[29]_i_2_n_0\
    );
\addrW[29]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(29),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(27),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[29]_i_3_n_0\
    );
\addrW[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(2),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[2]_i_2_n_0\,
      O => \addrW[2]_i_1_n_0\
    );
\addrW[2]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CA3CCA3CCAFCCA0C"
    )
        port map (
      I0 => \addrW[2]_i_3_n_0\,
      I1 => \^addr\(2),
      I2 => \AWBURST_reg_reg_n_0_[0]\,
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => get_next_addr_wr00_in(2),
      I5 => \addrW[2]_i_5_n_0\,
      O => \addrW[2]_i_2_n_0\
    );
\addrW[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFEAAAE0002AAA2"
    )
        port map (
      I0 => \^addr\(2),
      I1 => AWLEN_reg(2),
      I2 => AWSIZE_reg(0),
      I3 => \addrW[2]_i_5_n_0\,
      I4 => \p_1_out_inferred__0/i__carry_n_7\,
      I5 => get_next_addr_wr2(2),
      O => \addrW[2]_i_3_n_0\
    );
\addrW[2]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"E"
    )
        port map (
      I0 => AWSIZE_reg(1),
      I1 => AWSIZE_reg(2),
      O => \addrW[2]_i_5_n_0\
    );
\addrW[2]_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA6A"
    )
        port map (
      I0 => \^addr\(3),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(2),
      O => \addrW[2]_i_6_n_0\
    );
\addrW[2]_i_7\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA9A"
    )
        port map (
      I0 => \^addr\(2),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(2),
      O => \addrW[2]_i_7_n_0\
    );
\addrW[2]_i_8\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"A9AA"
    )
        port map (
      I0 => \^addr\(1),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(0),
      O => \addrW[2]_i_8_n_0\
    );
\addrW[2]_i_9\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAA9"
    )
        port map (
      I0 => \^addr\(0),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(0),
      O => \addrW[2]_i_9_n_0\
    );
\addrW[30]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(30),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[30]_i_2_n_0\,
      O => \addrW[30]_i_1_n_0\
    );
\addrW[30]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(30),
      I2 => \^addr\(30),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[30]_i_3_n_0\,
      O => \addrW[30]_i_2_n_0\
    );
\addrW[30]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(30),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(28),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[30]_i_3_n_0\
    );
\addrW[31]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(31),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[31]_i_2_n_0\,
      O => \addrW[31]_i_1_n_0\
    );
\addrW[31]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[31]_i_3_n_0\,
      I1 => get_next_addr_wr2(31),
      I2 => \^addr\(31),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[31]_i_5_n_0\,
      O => \addrW[31]_i_2_n_0\
    );
\addrW[31]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AAAB"
    )
        port map (
      I0 => \p_1_out_inferred__0/i__carry__2_n_1\,
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(0),
      O => \addrW[31]_i_3_n_0\
    );
\addrW[31]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(31),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(29),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[31]_i_5_n_0\
    );
\addrW[31]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(31),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(31)
    );
\addrW[31]_i_7\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(30),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(30)
    );
\addrW[31]_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(29),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(29)
    );
\addrW[31]_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0000AAA8"
    )
        port map (
      I0 => \^addr\(28),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__2_n_1\,
      O => get_next_addr_wr3(28)
    );
\addrW[3]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(3),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[3]_i_2_n_0\,
      O => \addrW[3]_i_1_n_0\
    );
\addrW[3]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C03FC0C0A0"
    )
        port map (
      I0 => AWLEN_reg(3),
      I1 => \p_1_out_inferred__0/i__carry_n_6\,
      I2 => \^addr\(3),
      I3 => AWSIZE_reg(0),
      I4 => AWSIZE_reg(1),
      I5 => AWSIZE_reg(2),
      O => \addrW[3]_i_10_n_0\
    );
\addrW[3]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C0C03FC0A0"
    )
        port map (
      I0 => AWLEN_reg(2),
      I1 => \p_1_out_inferred__0/i__carry_n_7\,
      I2 => \^addr\(2),
      I3 => AWSIZE_reg(0),
      I4 => AWSIZE_reg(1),
      I5 => AWSIZE_reg(2),
      O => \addrW[3]_i_11_n_0\
    );
\addrW[3]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F0F0F05FF0F0F0C0"
    )
        port map (
      I0 => AWLEN_reg(0),
      I1 => AWLEN_reg(1),
      I2 => \^addr\(1),
      I3 => AWSIZE_reg(1),
      I4 => AWSIZE_reg(2),
      I5 => AWSIZE_reg(0),
      O => \addrW[3]_i_12_n_0\
    );
\addrW[3]_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"CCCCCCC7"
    )
        port map (
      I0 => AWLEN_reg(0),
      I1 => \^addr\(0),
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(0),
      O => \addrW[3]_i_13_n_0\
    );
\addrW[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[3]_i_3_n_0\,
      I1 => get_next_addr_wr2(3),
      I2 => \^addr\(3),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[3]_i_5_n_0\,
      O => \addrW[3]_i_2_n_0\
    );
\addrW[3]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => AWLEN_reg(3),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry_n_6\,
      O => \addrW[3]_i_3_n_0\
    );
\addrW[3]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(3),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(1),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[3]_i_5_n_0\
    );
\addrW[3]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => AWSIZE_reg(2),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(0),
      O => \addrW[3]_i_6_n_0\
    );
\addrW[3]_i_7\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => AWSIZE_reg(2),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(0),
      O => \addrW[3]_i_7_n_0\
    );
\addrW[3]_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAAAAA8A8AAA8A8"
    )
        port map (
      I0 => \^addr\(1),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(0),
      I4 => AWLEN_reg(1),
      I5 => AWLEN_reg(0),
      O => get_next_addr_wr3(1)
    );
\addrW[3]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      O => \addrW[3]_i_9_n_0\
    );
\addrW[4]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(4),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[4]_i_2_n_0\,
      O => \addrW[4]_i_1_n_0\
    );
\addrW[4]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[4]_i_3_n_0\,
      I1 => get_next_addr_wr2(4),
      I2 => \^addr\(4),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[4]_i_4_n_0\,
      O => \addrW[4]_i_2_n_0\
    );
\addrW[4]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => AWLEN_reg(4),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry_n_5\,
      O => \addrW[4]_i_3_n_0\
    );
\addrW[4]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(4),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(2),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[4]_i_4_n_0\
    );
\addrW[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(5),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[5]_i_2_n_0\,
      O => \addrW[5]_i_1_n_0\
    );
\addrW[5]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[5]_i_3_n_0\,
      I1 => get_next_addr_wr2(5),
      I2 => \^addr\(5),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[5]_i_4_n_0\,
      O => \addrW[5]_i_2_n_0\
    );
\addrW[5]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => AWLEN_reg(5),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry_n_4\,
      O => \addrW[5]_i_3_n_0\
    );
\addrW[5]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(5),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(3),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[5]_i_4_n_0\
    );
\addrW[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(6),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[6]_i_2_n_0\,
      O => \addrW[6]_i_1_n_0\
    );
\addrW[6]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[6]_i_3_n_0\,
      I1 => get_next_addr_wr2(6),
      I2 => \^addr\(6),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[6]_i_4_n_0\,
      O => \addrW[6]_i_2_n_0\
    );
\addrW[6]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => AWLEN_reg(6),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__0_n_7\,
      O => \addrW[6]_i_3_n_0\
    );
\addrW[6]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(6),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(4),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[6]_i_4_n_0\
    );
\addrW[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(7),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[7]_i_2_n_0\,
      O => \addrW[7]_i_1_n_0\
    );
\addrW[7]_i_10\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3FC0C0C0C0C0C0A0"
    )
        port map (
      I0 => AWLEN_reg(7),
      I1 => \p_1_out_inferred__0/i__carry__0_n_6\,
      I2 => \^addr\(7),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      I5 => AWSIZE_reg(0),
      O => \addrW[7]_i_10_n_0\
    );
\addrW[7]_i_11\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C03FC0C0C0C0C0A0"
    )
        port map (
      I0 => AWLEN_reg(6),
      I1 => \p_1_out_inferred__0/i__carry__0_n_7\,
      I2 => \^addr\(6),
      I3 => AWSIZE_reg(0),
      I4 => AWSIZE_reg(2),
      I5 => AWSIZE_reg(1),
      O => \addrW[7]_i_11_n_0\
    );
\addrW[7]_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C03FC0C0A0"
    )
        port map (
      I0 => AWLEN_reg(5),
      I1 => \p_1_out_inferred__0/i__carry_n_4\,
      I2 => \^addr\(5),
      I3 => AWSIZE_reg(0),
      I4 => AWSIZE_reg(2),
      I5 => AWSIZE_reg(1),
      O => \addrW[7]_i_12_n_0\
    );
\addrW[7]_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0C0C0C0C03FC0A0"
    )
        port map (
      I0 => AWLEN_reg(4),
      I1 => \p_1_out_inferred__0/i__carry_n_5\,
      I2 => \^addr\(4),
      I3 => AWSIZE_reg(0),
      I4 => AWSIZE_reg(2),
      I5 => AWSIZE_reg(1),
      O => \addrW[7]_i_13_n_0\
    );
\addrW[7]_i_15\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => \^addr\(7),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(0),
      O => \addrW[7]_i_15_n_0\
    );
\addrW[7]_i_16\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9AAA"
    )
        port map (
      I0 => \^addr\(6),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      O => \addrW[7]_i_16_n_0\
    );
\addrW[7]_i_17\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA6A"
    )
        port map (
      I0 => \^addr\(5),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      O => \addrW[7]_i_17_n_0\
    );
\addrW[7]_i_18\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"AA9A"
    )
        port map (
      I0 => \^addr\(4),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      O => \addrW[7]_i_18_n_0\
    );
\addrW[7]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFF0E400F0"
    )
        port map (
      I0 => \addrW[7]_i_3_n_0\,
      I1 => get_next_addr_wr2(7),
      I2 => \^addr\(7),
      I3 => \AWBURST_reg_reg_n_0_[0]\,
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \addrW[7]_i_5_n_0\,
      O => \addrW[7]_i_2_n_0\
    );
\addrW[7]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0001FFFD"
    )
        port map (
      I0 => AWLEN_reg(7),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \p_1_out_inferred__0/i__carry__0_n_6\,
      O => \addrW[7]_i_3_n_0\
    );
\addrW[7]_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000FE0200000000"
    )
        port map (
      I0 => get_next_addr_wr00_in(7),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => get_next_addr_wr0(5),
      I4 => \AWBURST_reg_reg_n_0_[1]\,
      I5 => \AWBURST_reg_reg_n_0_[0]\,
      O => \addrW[7]_i_5_n_0\
    );
\addrW[7]_i_6\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      O => \addrW[7]_i_6_n_0\
    );
\addrW[7]_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8888888A88888880"
    )
        port map (
      I0 => \^addr\(6),
      I1 => \p_1_out_inferred__0/i__carry__0_n_7\,
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(0),
      I5 => AWLEN_reg(6),
      O => get_next_addr_wr3(6)
    );
\addrW[7]_i_8\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"40"
    )
        port map (
      I0 => AWSIZE_reg(1),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(0),
      O => \addrW[7]_i_8_n_0\
    );
\addrW[7]_i_9\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"04"
    )
        port map (
      I0 => AWSIZE_reg(1),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(0),
      O => \addrW[7]_i_9_n_0\
    );
\addrW[8]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(8),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[8]_i_2_n_0\,
      O => \addrW[8]_i_1_n_0\
    );
\addrW[8]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \^addr\(8),
      I1 => \addrW[15]_i_3_n_0\,
      I2 => \p_1_out_inferred__0/i__carry__0_n_5\,
      I3 => get_next_addr_wr2(8),
      I4 => \addrW[15]_i_5_n_0\,
      I5 => \addrW[8]_i_3_n_0\,
      O => \addrW[8]_i_2_n_0\
    );
\addrW[8]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_wr0(6),
      I1 => \addrW[2]_i_5_n_0\,
      I2 => get_next_addr_wr00_in(8),
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => \AWBURST_reg_reg_n_0_[0]\,
      I5 => \^addr\(8),
      O => \addrW[8]_i_3_n_0\
    );
\addrW[9]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"FE02"
    )
        port map (
      I0 => AWADDR_reg(9),
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \addrW[9]_i_2_n_0\,
      O => \addrW[9]_i_1_n_0\
    );
\addrW[9]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFBA8A0000"
    )
        port map (
      I0 => \^addr\(9),
      I1 => \addrW[15]_i_3_n_0\,
      I2 => \p_1_out_inferred__0/i__carry__0_n_4\,
      I3 => get_next_addr_wr2(9),
      I4 => \addrW[15]_i_5_n_0\,
      I5 => \addrW[9]_i_3_n_0\,
      O => \addrW[9]_i_2_n_0\
    );
\addrW[9]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFB800FF00B80000"
    )
        port map (
      I0 => get_next_addr_wr0(7),
      I1 => \addrW[2]_i_5_n_0\,
      I2 => get_next_addr_wr00_in(9),
      I3 => \AWBURST_reg_reg_n_0_[1]\,
      I4 => \AWBURST_reg_reg_n_0_[0]\,
      I5 => \^addr\(9),
      O => \addrW[9]_i_3_n_0\
    );
\addrW_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[0]_i_1_n_0\,
      Q => \^addr\(0)
    );
\addrW_reg[10]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[10]_i_1_n_0\,
      Q => \^addr\(10)
    );
\addrW_reg[11]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[11]_i_1_n_0\,
      Q => \^addr\(11)
    );
\addrW_reg[11]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[7]_i_4_n_0\,
      CO(3) => \addrW_reg[11]_i_3_n_0\,
      CO(2) => \addrW_reg[11]_i_3_n_1\,
      CO(1) => \addrW_reg[11]_i_3_n_2\,
      CO(0) => \addrW_reg[11]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr2(11 downto 8),
      S(3 downto 0) => get_next_addr_wr3(11 downto 8)
    );
\addrW_reg[11]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[7]_i_14_n_0\,
      CO(3) => \addrW_reg[11]_i_9_n_0\,
      CO(2) => \addrW_reg[11]_i_9_n_1\,
      CO(1) => \addrW_reg[11]_i_9_n_2\,
      CO(0) => \addrW_reg[11]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr00_in(11 downto 8),
      S(3 downto 0) => \^addr\(11 downto 8)
    );
\addrW_reg[12]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[12]_i_1_n_0\,
      Q => \^addr\(12)
    );
\addrW_reg[13]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[13]_i_1_n_0\,
      Q => \^addr\(13)
    );
\addrW_reg[14]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[14]_i_1_n_0\,
      Q => \^addr\(14)
    );
\addrW_reg[15]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[15]_i_1_n_0\,
      Q => \^addr\(15)
    );
\addrW_reg[15]_i_11\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[11]_i_9_n_0\,
      CO(3) => \addrW_reg[15]_i_11_n_0\,
      CO(2) => \addrW_reg[15]_i_11_n_1\,
      CO(1) => \addrW_reg[15]_i_11_n_2\,
      CO(0) => \addrW_reg[15]_i_11_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr00_in(15 downto 12),
      S(3 downto 0) => \^addr\(15 downto 12)
    );
\addrW_reg[15]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[11]_i_3_n_0\,
      CO(3) => \addrW_reg[15]_i_4_n_0\,
      CO(2) => \addrW_reg[15]_i_4_n_1\,
      CO(1) => \addrW_reg[15]_i_4_n_2\,
      CO(0) => \addrW_reg[15]_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr2(15 downto 12),
      S(3 downto 0) => get_next_addr_wr3(15 downto 12)
    );
\addrW_reg[16]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[16]_i_1_n_0\,
      Q => \^addr\(16)
    );
\addrW_reg[17]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[17]_i_1_n_0\,
      Q => \^addr\(17)
    );
\addrW_reg[18]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[18]_i_1_n_0\,
      Q => \^addr\(18)
    );
\addrW_reg[19]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[19]_i_1_n_0\,
      Q => \^addr\(19)
    );
\addrW_reg[19]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[15]_i_4_n_0\,
      CO(3) => \addrW_reg[19]_i_3_n_0\,
      CO(2) => \addrW_reg[19]_i_3_n_1\,
      CO(1) => \addrW_reg[19]_i_3_n_2\,
      CO(0) => \addrW_reg[19]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr2(19 downto 16),
      S(3 downto 0) => get_next_addr_wr3(19 downto 16)
    );
\addrW_reg[19]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[15]_i_11_n_0\,
      CO(3) => \addrW_reg[19]_i_9_n_0\,
      CO(2) => \addrW_reg[19]_i_9_n_1\,
      CO(1) => \addrW_reg[19]_i_9_n_2\,
      CO(0) => \addrW_reg[19]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr00_in(19 downto 16),
      S(3 downto 0) => \^addr\(19 downto 16)
    );
\addrW_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[1]_i_1_n_0\,
      Q => \^addr\(1)
    );
\addrW_reg[20]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[20]_i_1_n_0\,
      Q => \^addr\(20)
    );
\addrW_reg[21]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[21]_i_1_n_0\,
      Q => \^addr\(21)
    );
\addrW_reg[22]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[22]_i_1_n_0\,
      Q => \^addr\(22)
    );
\addrW_reg[23]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[23]_i_1_n_0\,
      Q => \^addr\(23)
    );
\addrW_reg[23]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[19]_i_3_n_0\,
      CO(3) => \addrW_reg[23]_i_3_n_0\,
      CO(2) => \addrW_reg[23]_i_3_n_1\,
      CO(1) => \addrW_reg[23]_i_3_n_2\,
      CO(0) => \addrW_reg[23]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr2(23 downto 20),
      S(3 downto 0) => get_next_addr_wr3(23 downto 20)
    );
\addrW_reg[23]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[19]_i_9_n_0\,
      CO(3) => \addrW_reg[23]_i_9_n_0\,
      CO(2) => \addrW_reg[23]_i_9_n_1\,
      CO(1) => \addrW_reg[23]_i_9_n_2\,
      CO(0) => \addrW_reg[23]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr00_in(23 downto 20),
      S(3 downto 0) => \^addr\(23 downto 20)
    );
\addrW_reg[24]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[24]_i_1_n_0\,
      Q => \^addr\(24)
    );
\addrW_reg[25]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[25]_i_1_n_0\,
      Q => \^addr\(25)
    );
\addrW_reg[26]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[26]_i_1_n_0\,
      Q => \^addr\(26)
    );
\addrW_reg[27]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[27]_i_1_n_0\,
      Q => \^addr\(27)
    );
\addrW_reg[27]_i_3\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[23]_i_3_n_0\,
      CO(3) => \addrW_reg[27]_i_3_n_0\,
      CO(2) => \addrW_reg[27]_i_3_n_1\,
      CO(1) => \addrW_reg[27]_i_3_n_2\,
      CO(0) => \addrW_reg[27]_i_3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr2(27 downto 24),
      S(3 downto 0) => get_next_addr_wr3(27 downto 24)
    );
\addrW_reg[27]_i_9\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[23]_i_9_n_0\,
      CO(3) => \addrW_reg[27]_i_9_n_0\,
      CO(2) => \addrW_reg[27]_i_9_n_1\,
      CO(1) => \addrW_reg[27]_i_9_n_2\,
      CO(0) => \addrW_reg[27]_i_9_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr00_in(27 downto 24),
      S(3 downto 0) => \^addr\(27 downto 24)
    );
\addrW_reg[28]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[28]_i_1_n_0\,
      Q => \^addr\(28)
    );
\addrW_reg[29]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[29]_i_1_n_0\,
      Q => \^addr\(29)
    );
\addrW_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[2]_i_1_n_0\,
      Q => \^addr\(2)
    );
\addrW_reg[2]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \addrW_reg[2]_i_4_n_0\,
      CO(2) => \addrW_reg[2]_i_4_n_1\,
      CO(1) => \addrW_reg[2]_i_4_n_2\,
      CO(0) => \addrW_reg[2]_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \^addr\(3 downto 0),
      O(3 downto 0) => get_next_addr_wr00_in(3 downto 0),
      S(3) => \addrW[2]_i_6_n_0\,
      S(2) => \addrW[2]_i_7_n_0\,
      S(1) => \addrW[2]_i_8_n_0\,
      S(0) => \addrW[2]_i_9_n_0\
    );
\addrW_reg[30]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[30]_i_1_n_0\,
      Q => \^addr\(30)
    );
\addrW_reg[31]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[31]_i_1_n_0\,
      Q => \^addr\(31)
    );
\addrW_reg[31]_i_10\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[27]_i_9_n_0\,
      CO(3) => \NLW_addrW_reg[31]_i_10_CO_UNCONNECTED\(3),
      CO(2) => \addrW_reg[31]_i_10_n_1\,
      CO(1) => \addrW_reg[31]_i_10_n_2\,
      CO(0) => \addrW_reg[31]_i_10_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr00_in(31 downto 28),
      S(3 downto 0) => \^addr\(31 downto 28)
    );
\addrW_reg[31]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[27]_i_3_n_0\,
      CO(3) => \NLW_addrW_reg[31]_i_4_CO_UNCONNECTED\(3),
      CO(2) => \addrW_reg[31]_i_4_n_1\,
      CO(1) => \addrW_reg[31]_i_4_n_2\,
      CO(0) => \addrW_reg[31]_i_4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr2(31 downto 28),
      S(3 downto 0) => get_next_addr_wr3(31 downto 28)
    );
\addrW_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[3]_i_1_n_0\,
      Q => \^addr\(3)
    );
\addrW_reg[3]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \addrW_reg[3]_i_4_n_0\,
      CO(2) => \addrW_reg[3]_i_4_n_1\,
      CO(1) => \addrW_reg[3]_i_4_n_2\,
      CO(0) => \addrW_reg[3]_i_4_n_3\,
      CYINIT => '0',
      DI(3) => \addrW[3]_i_6_n_0\,
      DI(2) => \addrW[3]_i_7_n_0\,
      DI(1) => get_next_addr_wr3(1),
      DI(0) => \addrW[3]_i_9_n_0\,
      O(3 downto 0) => get_next_addr_wr2(3 downto 0),
      S(3) => \addrW[3]_i_10_n_0\,
      S(2) => \addrW[3]_i_11_n_0\,
      S(1) => \addrW[3]_i_12_n_0\,
      S(0) => \addrW[3]_i_13_n_0\
    );
\addrW_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[4]_i_1_n_0\,
      Q => \^addr\(4)
    );
\addrW_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[5]_i_1_n_0\,
      Q => \^addr\(5)
    );
\addrW_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[6]_i_1_n_0\,
      Q => \^addr\(6)
    );
\addrW_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[7]_i_1_n_0\,
      Q => \^addr\(7)
    );
\addrW_reg[7]_i_14\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[2]_i_4_n_0\,
      CO(3) => \addrW_reg[7]_i_14_n_0\,
      CO(2) => \addrW_reg[7]_i_14_n_1\,
      CO(1) => \addrW_reg[7]_i_14_n_2\,
      CO(0) => \addrW_reg[7]_i_14_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => \^addr\(7 downto 4),
      O(3 downto 0) => get_next_addr_wr00_in(7 downto 4),
      S(3) => \addrW[7]_i_15_n_0\,
      S(2) => \addrW[7]_i_16_n_0\,
      S(1) => \addrW[7]_i_17_n_0\,
      S(0) => \addrW[7]_i_18_n_0\
    );
\addrW_reg[7]_i_4\: unisim.vcomponents.CARRY4
     port map (
      CI => \addrW_reg[3]_i_4_n_0\,
      CO(3) => \addrW_reg[7]_i_4_n_0\,
      CO(2) => \addrW_reg[7]_i_4_n_1\,
      CO(1) => \addrW_reg[7]_i_4_n_2\,
      CO(0) => \addrW_reg[7]_i_4_n_3\,
      CYINIT => '0',
      DI(3) => \addrW[7]_i_6_n_0\,
      DI(2) => get_next_addr_wr3(6),
      DI(1) => \addrW[7]_i_8_n_0\,
      DI(0) => \addrW[7]_i_9_n_0\,
      O(3 downto 0) => get_next_addr_wr2(7 downto 4),
      S(3) => \addrW[7]_i_10_n_0\,
      S(2) => \addrW[7]_i_11_n_0\,
      S(1) => \addrW[7]_i_12_n_0\,
      S(0) => \addrW[7]_i_13_n_0\
    );
\addrW_reg[8]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[8]_i_1_n_0\,
      Q => \^addr\(8)
    );
\addrW_reg[9]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \addrW[9]_i_1_n_0\,
      Q => \^addr\(9)
    );
\beatR[0]_i_1\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => beatR(0),
      O => p_1_in(0)
    );
\beatR[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => beatR(1),
      I1 => beatR(0),
      I2 => \stateR_reg_n_0_[2]\,
      O => \beatR[1]_i_1_n_0\
    );
\beatR[2]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2A80"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => beatR(0),
      I2 => beatR(1),
      I3 => beatR(2),
      O => p_1_in(2)
    );
\beatR[3]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2AAA8000"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => beatR(1),
      I2 => beatR(0),
      I3 => beatR(2),
      I4 => beatR(3),
      O => p_1_in(3)
    );
\beatR[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"2AAAAAAA80000000"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => beatR(2),
      I2 => beatR(0),
      I3 => beatR(1),
      I4 => beatR(3),
      I5 => beatR(4),
      O => p_1_in(4)
    );
\beatR[5]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"28"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => \beatR[5]_i_2_n_0\,
      I2 => beatR(5),
      O => p_1_in(5)
    );
\beatR[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => beatR(3),
      I1 => beatR(1),
      I2 => beatR(0),
      I3 => beatR(2),
      I4 => beatR(4),
      O => \beatR[5]_i_2_n_0\
    );
\beatR[6]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"60"
    )
        port map (
      I0 => \beatR[7]_i_3_n_0\,
      I1 => beatR(6),
      I2 => \stateR_reg_n_0_[2]\,
      O => \beatR[6]_i_1_n_0\
    );
\beatR[7]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"4022"
    )
        port map (
      I0 => \stateR_reg_n_0_[0]\,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => s_axi_rready,
      I3 => \stateR_reg_n_0_[1]\,
      O => \beatR[7]_i_1_n_0\
    );
\beatR[7]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"2A80"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => beatR(6),
      I2 => \beatR[7]_i_3_n_0\,
      I3 => beatR(7),
      O => p_1_in(7)
    );
\beatR[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => beatR(4),
      I1 => beatR(2),
      I2 => beatR(0),
      I3 => beatR(1),
      I4 => beatR(3),
      I5 => beatR(5),
      O => \beatR[7]_i_3_n_0\
    );
\beatR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \beatR[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => p_1_in(0),
      Q => beatR(0)
    );
\beatR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \beatR[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \beatR[1]_i_1_n_0\,
      Q => beatR(1)
    );
\beatR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \beatR[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => p_1_in(2),
      Q => beatR(2)
    );
\beatR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \beatR[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => p_1_in(3),
      Q => beatR(3)
    );
\beatR_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \beatR[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => p_1_in(4),
      Q => beatR(4)
    );
\beatR_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \beatR[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => p_1_in(5),
      Q => beatR(5)
    );
\beatR_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \beatR[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => \beatR[6]_i_1_n_0\,
      Q => beatR(6)
    );
\beatR_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => \beatR[7]_i_1_n_0\,
      CLR => AWREADY_i_2_n_0,
      D => p_1_in(7),
      Q => beatR(7)
    );
\beatW[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"54"
    )
        port map (
      I0 => \beatW_reg_n_0_[0]\,
      I1 => \stateW_reg_n_0_[1]\,
      I2 => \stateW_reg_n_0_[2]\,
      O => \beatW[0]_i_1_n_0\
    );
\beatW[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6660"
    )
        port map (
      I0 => \beatW_reg_n_0_[1]\,
      I1 => \beatW_reg_n_0_[0]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \stateW_reg_n_0_[2]\,
      O => \beatW[1]_i_1_n_0\
    );
\beatW[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0EEEE000"
    )
        port map (
      I0 => \stateW_reg_n_0_[1]\,
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \beatW_reg_n_0_[0]\,
      I3 => \beatW_reg_n_0_[1]\,
      I4 => \beatW_reg_n_0_[2]\,
      O => \beatW[2]_i_1_n_0\
    );
\beatW[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0EEEEEEEE0000000"
    )
        port map (
      I0 => \stateW_reg_n_0_[1]\,
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \beatW_reg_n_0_[1]\,
      I3 => \beatW_reg_n_0_[0]\,
      I4 => \beatW_reg_n_0_[2]\,
      I5 => \beatW_reg_n_0_[3]\,
      O => \beatW[3]_i_1_n_0\
    );
\beatW[4]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1555555540000000"
    )
        port map (
      I0 => \beatW[4]_i_2_n_0\,
      I1 => \beatW_reg_n_0_[2]\,
      I2 => \beatW_reg_n_0_[0]\,
      I3 => \beatW_reg_n_0_[1]\,
      I4 => \beatW_reg_n_0_[3]\,
      I5 => \beatW_reg_n_0_[4]\,
      O => \beatW[4]_i_1_n_0\
    );
\beatW[4]_i_2\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => \stateW_reg_n_0_[2]\,
      I1 => \stateW_reg_n_0_[1]\,
      O => \beatW[4]_i_2_n_0\
    );
\beatW[5]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0EE0"
    )
        port map (
      I0 => \stateW_reg_n_0_[1]\,
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \beatW[5]_i_2_n_0\,
      I3 => \beatW_reg_n_0_[5]\,
      O => \beatW[5]_i_1_n_0\
    );
\beatW[5]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => \beatW_reg_n_0_[3]\,
      I1 => \beatW_reg_n_0_[1]\,
      I2 => \beatW_reg_n_0_[0]\,
      I3 => \beatW_reg_n_0_[2]\,
      I4 => \beatW_reg_n_0_[4]\,
      O => \beatW[5]_i_2_n_0\
    );
\beatW[6]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6660"
    )
        port map (
      I0 => \beatW[7]_i_3_n_0\,
      I1 => \beatW_reg_n_0_[6]\,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \stateW_reg_n_0_[2]\,
      O => \beatW[6]_i_1_n_0\
    );
\beatW[7]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00404466"
    )
        port map (
      I0 => \stateW_reg_n_0_[2]\,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => ACK_reg_n_0,
      I3 => \BID[3]_i_2_n_0\,
      I4 => \stateW_reg_n_0_[1]\,
      O => beatW
    );
\beatW[7]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0EEEE000"
    )
        port map (
      I0 => \stateW_reg_n_0_[1]\,
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \beatW_reg_n_0_[6]\,
      I3 => \beatW[7]_i_3_n_0\,
      I4 => \beatW_reg_n_0_[7]\,
      O => \beatW[7]_i_2_n_0\
    );
\beatW[7]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => \beatW_reg_n_0_[4]\,
      I1 => \beatW_reg_n_0_[2]\,
      I2 => \beatW_reg_n_0_[0]\,
      I3 => \beatW_reg_n_0_[1]\,
      I4 => \beatW_reg_n_0_[3]\,
      I5 => \beatW_reg_n_0_[5]\,
      O => \beatW[7]_i_3_n_0\
    );
\beatW_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \beatW[0]_i_1_n_0\,
      Q => \beatW_reg_n_0_[0]\
    );
\beatW_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \beatW[1]_i_1_n_0\,
      Q => \beatW_reg_n_0_[1]\
    );
\beatW_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \beatW[2]_i_1_n_0\,
      Q => \beatW_reg_n_0_[2]\
    );
\beatW_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \beatW[3]_i_1_n_0\,
      Q => \beatW_reg_n_0_[3]\
    );
\beatW_reg[4]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \beatW[4]_i_1_n_0\,
      Q => \beatW_reg_n_0_[4]\
    );
\beatW_reg[5]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \beatW[5]_i_1_n_0\,
      Q => \beatW_reg_n_0_[5]\
    );
\beatW_reg[6]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \beatW[6]_i_1_n_0\,
      Q => \beatW_reg_n_0_[6]\
    );
\beatW_reg[7]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => beatW,
      CLR => AWREADY_i_2_n_0,
      D => \beatW[7]_i_2_n_0\,
      Q => \beatW_reg_n_0_[7]\
    );
get_next_addr_rd0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => get_next_addr_rd0_carry_n_0,
      CO(2) => get_next_addr_rd0_carry_n_1,
      CO(1) => get_next_addr_rd0_carry_n_2,
      CO(0) => get_next_addr_rd0_carry_n_3,
      CYINIT => \addrR_reg_n_0_[2]\,
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd0(4 downto 1),
      S(3) => \addrR_reg_n_0_[6]\,
      S(2) => \addrR_reg_n_0_[5]\,
      S(1) => \addrR_reg_n_0_[4]\,
      S(0) => \addrR_reg_n_0_[3]\
    );
\get_next_addr_rd0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => get_next_addr_rd0_carry_n_0,
      CO(3) => \get_next_addr_rd0_carry__0_n_0\,
      CO(2) => \get_next_addr_rd0_carry__0_n_1\,
      CO(1) => \get_next_addr_rd0_carry__0_n_2\,
      CO(0) => \get_next_addr_rd0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd0(8 downto 5),
      S(3) => \addrR_reg_n_0_[10]\,
      S(2) => \addrR_reg_n_0_[9]\,
      S(1) => \addrR_reg_n_0_[8]\,
      S(0) => \addrR_reg_n_0_[7]\
    );
\get_next_addr_rd0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_rd0_carry__0_n_0\,
      CO(3) => \get_next_addr_rd0_carry__1_n_0\,
      CO(2) => \get_next_addr_rd0_carry__1_n_1\,
      CO(1) => \get_next_addr_rd0_carry__1_n_2\,
      CO(0) => \get_next_addr_rd0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd0(12 downto 9),
      S(3) => \addrR_reg_n_0_[14]\,
      S(2) => \addrR_reg_n_0_[13]\,
      S(1) => \addrR_reg_n_0_[12]\,
      S(0) => \addrR_reg_n_0_[11]\
    );
\get_next_addr_rd0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_rd0_carry__1_n_0\,
      CO(3) => \get_next_addr_rd0_carry__2_n_0\,
      CO(2) => \get_next_addr_rd0_carry__2_n_1\,
      CO(1) => \get_next_addr_rd0_carry__2_n_2\,
      CO(0) => \get_next_addr_rd0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd0(16 downto 13),
      S(3) => \addrR_reg_n_0_[18]\,
      S(2) => \addrR_reg_n_0_[17]\,
      S(1) => \addrR_reg_n_0_[16]\,
      S(0) => \addrR_reg_n_0_[15]\
    );
\get_next_addr_rd0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_rd0_carry__2_n_0\,
      CO(3) => \get_next_addr_rd0_carry__3_n_0\,
      CO(2) => \get_next_addr_rd0_carry__3_n_1\,
      CO(1) => \get_next_addr_rd0_carry__3_n_2\,
      CO(0) => \get_next_addr_rd0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd0(20 downto 17),
      S(3) => \addrR_reg_n_0_[22]\,
      S(2) => \addrR_reg_n_0_[21]\,
      S(1) => \addrR_reg_n_0_[20]\,
      S(0) => \addrR_reg_n_0_[19]\
    );
\get_next_addr_rd0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_rd0_carry__3_n_0\,
      CO(3) => \get_next_addr_rd0_carry__4_n_0\,
      CO(2) => \get_next_addr_rd0_carry__4_n_1\,
      CO(1) => \get_next_addr_rd0_carry__4_n_2\,
      CO(0) => \get_next_addr_rd0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd0(24 downto 21),
      S(3) => \addrR_reg_n_0_[26]\,
      S(2) => \addrR_reg_n_0_[25]\,
      S(1) => \addrR_reg_n_0_[24]\,
      S(0) => \addrR_reg_n_0_[23]\
    );
\get_next_addr_rd0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_rd0_carry__4_n_0\,
      CO(3) => \get_next_addr_rd0_carry__5_n_0\,
      CO(2) => \get_next_addr_rd0_carry__5_n_1\,
      CO(1) => \get_next_addr_rd0_carry__5_n_2\,
      CO(0) => \get_next_addr_rd0_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_rd0(28 downto 25),
      S(3) => \addrR_reg_n_0_[30]\,
      S(2) => \addrR_reg_n_0_[29]\,
      S(1) => \addrR_reg_n_0_[28]\,
      S(0) => \addrR_reg_n_0_[27]\
    );
\get_next_addr_rd0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_rd0_carry__5_n_0\,
      CO(3 downto 0) => \NLW_get_next_addr_rd0_carry__6_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_get_next_addr_rd0_carry__6_O_UNCONNECTED\(3 downto 1),
      O(0) => get_next_addr_rd0(29),
      S(3 downto 1) => B"000",
      S(0) => \addrR_reg_n_0_[31]\
    );
get_next_addr_wr0_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => get_next_addr_wr0_carry_n_0,
      CO(2) => get_next_addr_wr0_carry_n_1,
      CO(1) => get_next_addr_wr0_carry_n_2,
      CO(0) => get_next_addr_wr0_carry_n_3,
      CYINIT => \^addr\(2),
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr0(4 downto 1),
      S(3 downto 0) => \^addr\(6 downto 3)
    );
\get_next_addr_wr0_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => get_next_addr_wr0_carry_n_0,
      CO(3) => \get_next_addr_wr0_carry__0_n_0\,
      CO(2) => \get_next_addr_wr0_carry__0_n_1\,
      CO(1) => \get_next_addr_wr0_carry__0_n_2\,
      CO(0) => \get_next_addr_wr0_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr0(8 downto 5),
      S(3 downto 0) => \^addr\(10 downto 7)
    );
\get_next_addr_wr0_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_wr0_carry__0_n_0\,
      CO(3) => \get_next_addr_wr0_carry__1_n_0\,
      CO(2) => \get_next_addr_wr0_carry__1_n_1\,
      CO(1) => \get_next_addr_wr0_carry__1_n_2\,
      CO(0) => \get_next_addr_wr0_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr0(12 downto 9),
      S(3 downto 0) => \^addr\(14 downto 11)
    );
\get_next_addr_wr0_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_wr0_carry__1_n_0\,
      CO(3) => \get_next_addr_wr0_carry__2_n_0\,
      CO(2) => \get_next_addr_wr0_carry__2_n_1\,
      CO(1) => \get_next_addr_wr0_carry__2_n_2\,
      CO(0) => \get_next_addr_wr0_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr0(16 downto 13),
      S(3 downto 0) => \^addr\(18 downto 15)
    );
\get_next_addr_wr0_carry__3\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_wr0_carry__2_n_0\,
      CO(3) => \get_next_addr_wr0_carry__3_n_0\,
      CO(2) => \get_next_addr_wr0_carry__3_n_1\,
      CO(1) => \get_next_addr_wr0_carry__3_n_2\,
      CO(0) => \get_next_addr_wr0_carry__3_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr0(20 downto 17),
      S(3 downto 0) => \^addr\(22 downto 19)
    );
\get_next_addr_wr0_carry__4\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_wr0_carry__3_n_0\,
      CO(3) => \get_next_addr_wr0_carry__4_n_0\,
      CO(2) => \get_next_addr_wr0_carry__4_n_1\,
      CO(1) => \get_next_addr_wr0_carry__4_n_2\,
      CO(0) => \get_next_addr_wr0_carry__4_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr0(24 downto 21),
      S(3 downto 0) => \^addr\(26 downto 23)
    );
\get_next_addr_wr0_carry__5\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_wr0_carry__4_n_0\,
      CO(3) => \get_next_addr_wr0_carry__5_n_0\,
      CO(2) => \get_next_addr_wr0_carry__5_n_1\,
      CO(1) => \get_next_addr_wr0_carry__5_n_2\,
      CO(0) => \get_next_addr_wr0_carry__5_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 0) => get_next_addr_wr0(28 downto 25),
      S(3 downto 0) => \^addr\(30 downto 27)
    );
\get_next_addr_wr0_carry__6\: unisim.vcomponents.CARRY4
     port map (
      CI => \get_next_addr_wr0_carry__5_n_0\,
      CO(3 downto 0) => \NLW_get_next_addr_wr0_carry__6_CO_UNCONNECTED\(3 downto 0),
      CYINIT => '0',
      DI(3 downto 0) => B"0000",
      O(3 downto 1) => \NLW_get_next_addr_wr0_carry__6_O_UNCONNECTED\(3 downto 1),
      O(0) => get_next_addr_wr0(29),
      S(3 downto 1) => B"000",
      S(0) => \^addr\(31)
    );
grant_read_i_1: unisim.vcomponents.LUT5
    generic map(
      INIT => X"ABBBA888"
    )
        port map (
      I0 => grant_read_i_2_n_0,
      I1 => \ARLEN_reg[7]_i_1_n_0\,
      I2 => grant_read_i_3_n_0,
      I3 => ARSTRB_reg1,
      I4 => p_0_in(0),
      O => grant_read_i_1_n_0
    );
grant_read_i_2: unisim.vcomponents.LUT5
    generic map(
      INIT => X"88888B88"
    )
        port map (
      I0 => ACK_reg_n_0,
      I1 => \stateR_reg_n_0_[0]\,
      I2 => s_axi_awvalid,
      I3 => s_axi_arvalid,
      I4 => p_0_in(1),
      O => grant_read_i_2_n_0
    );
grant_read_i_3: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0040"
    )
        port map (
      I0 => ACK_reg_n_0,
      I1 => \stateR_reg_n_0_[0]\,
      I2 => \stateR_reg_n_0_[2]\,
      I3 => \stateR_reg_n_0_[1]\,
      O => grant_read_i_3_n_0
    );
grant_read_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => grant_read_i_1_n_0,
      Q => p_0_in(0)
    );
grant_write_i_1: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BBFFFFFF00000030"
    )
        port map (
      I0 => ACK_reg_n_0,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => grant_write_i_2_n_0,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => \stateW_reg_n_0_[2]\,
      I5 => p_0_in(1),
      O => grant_write_i_1_n_0
    );
grant_write_i_2: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => p_0_in(0),
      O => grant_write_i_2_n_0
    );
grant_write_reg: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => grant_write_i_1_n_0,
      Q => p_0_in(1)
    );
\i__carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FDFFF8FF"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => \i__carry__0_i_9_n_0\,
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \i__carry__0_i_10_n_0\,
      I5 => \i__carry__0_i_11_n_0\,
      O => \i__carry__0_i_1_n_0\
    );
\i__carry__0_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => AWLEN_reg(7),
      I1 => AWLEN_reg(6),
      I2 => \i__carry__1_i_9_n_0\,
      O => \i__carry__0_i_10_n_0\
    );
\i__carry__0_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"01C10DCD"
    )
        port map (
      I0 => \i__carry__1_i_10_n_0\,
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => \i__carry__0_i_19_n_0\,
      I4 => \i__carry__1_i_13_n_0\,
      O => \i__carry__0_i_11_n_0\
    );
\i__carry__0_i_12\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"3500350F"
    )
        port map (
      I0 => \i__carry__1_i_15_n_0\,
      I1 => \i__carry__0_i_20_n_0\,
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(2),
      I4 => \i__carry__0_i_10_n_0\,
      O => \i__carry__0_i_12_n_0\
    );
\i__carry__0_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => AWLEN_reg(5),
      I1 => AWLEN_reg(4),
      I2 => AWLEN_reg(2),
      I3 => AWLEN_reg(0),
      I4 => AWLEN_reg(1),
      I5 => AWLEN_reg(3),
      O => \i__carry__0_i_13_n_0\
    );
\i__carry__0_i_14\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => AWLEN_reg(4),
      I1 => AWLEN_reg(3),
      I2 => AWLEN_reg(1),
      I3 => AWLEN_reg(0),
      I4 => AWLEN_reg(2),
      O => \i__carry__0_i_14_n_0\
    );
\i__carry__0_i_15\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
        port map (
      I0 => AWSIZE_reg(2),
      I1 => AWSIZE_reg(0),
      I2 => AWSIZE_reg(1),
      O => \i__carry__0_i_15_n_0\
    );
\i__carry__0_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22EE2EE200CC0000"
    )
        port map (
      I0 => \i__carry__0_i_19_n_0\,
      I1 => AWSIZE_reg(1),
      I2 => AWLEN_reg(1),
      I3 => AWLEN_reg(0),
      I4 => AWSIZE_reg(0),
      I5 => AWSIZE_reg(2),
      O => \i__carry__0_i_16_n_0\
    );
\i__carry__0_i_17\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => AWSIZE_reg(1),
      I1 => AWSIZE_reg(2),
      O => \i__carry__0_i_17_n_0\
    );
\i__carry__0_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F5C50000F5C50F0F"
    )
        port map (
      I0 => \i__carry__0_i_20_n_0\,
      I1 => AWLEN_reg(0),
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(0),
      I4 => AWSIZE_reg(2),
      I5 => \i__carry__0_i_13_n_0\,
      O => \i__carry__0_i_18_n_0\
    );
\i__carry__0_i_19\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1EE4E4E4"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWLEN_reg(3),
      I2 => AWLEN_reg(2),
      I3 => AWLEN_reg(0),
      I4 => AWLEN_reg(1),
      O => \i__carry__0_i_19_n_0\
    );
\i__carry__0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5551555555405555"
    )
        port map (
      I0 => \i__carry__0_i_12_n_0\,
      I1 => AWSIZE_reg(0),
      I2 => \i__carry__0_i_13_n_0\,
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      I5 => \i__carry__0_i_9_n_0\,
      O => \i__carry__0_i_2_n_0\
    );
\i__carry__0_i_20\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1EE4"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWLEN_reg(2),
      I2 => AWLEN_reg(1),
      I3 => AWLEN_reg(0),
      O => \i__carry__0_i_20_n_0\
    );
\i__carry__0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AACCAACCFFFFF000"
    )
        port map (
      I0 => \i__carry__0_i_13_n_0\,
      I1 => \i__carry__0_i_14_n_0\,
      I2 => \i__carry__0_i_9_n_0\,
      I3 => \i__carry__0_i_15_n_0\,
      I4 => \i__carry__0_i_16_n_0\,
      I5 => \i__carry__0_i_17_n_0\,
      O => \i__carry__0_i_3_n_0\
    );
\i__carry__0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FDFFF8FF"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => \i__carry_i_11_n_0\,
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \i__carry__0_i_14_n_0\,
      I5 => \i__carry__0_i_18_n_0\,
      O => \i__carry__0_i_4_n_0\
    );
\i__carry__0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF02000700"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => \i__carry__0_i_9_n_0\,
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \i__carry__0_i_10_n_0\,
      I5 => \i__carry__0_i_11_n_0\,
      O => \i__carry__0_i_5_n_0\
    );
\i__carry__0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AAAEAAAAAABFAAAA"
    )
        port map (
      I0 => \i__carry__0_i_12_n_0\,
      I1 => AWSIZE_reg(0),
      I2 => \i__carry__0_i_13_n_0\,
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(1),
      I5 => \i__carry__0_i_9_n_0\,
      O => \i__carry__0_i_6_n_0\
    );
\i__carry__0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"5533553300000FFF"
    )
        port map (
      I0 => \i__carry__0_i_13_n_0\,
      I1 => \i__carry__0_i_14_n_0\,
      I2 => \i__carry__0_i_9_n_0\,
      I3 => \i__carry__0_i_15_n_0\,
      I4 => \i__carry__0_i_16_n_0\,
      I5 => \i__carry__0_i_17_n_0\,
      O => \i__carry__0_i_7_n_0\
    );
\i__carry__0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF02000700"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => \i__carry_i_11_n_0\,
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \i__carry__0_i_14_n_0\,
      I5 => \i__carry__0_i_18_n_0\,
      O => \i__carry__0_i_8_n_0\
    );
\i__carry__0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => AWLEN_reg(6),
      I1 => \i__carry__1_i_9_n_0\,
      O => \i__carry__0_i_9_n_0\
    );
\i__carry__1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3C6A000080000000"
    )
        port map (
      I0 => AWLEN_reg(7),
      I1 => \i__carry__1_i_9_n_0\,
      I2 => AWLEN_reg(6),
      I3 => AWSIZE_reg(0),
      I4 => AWSIZE_reg(2),
      I5 => AWSIZE_reg(1),
      O => \i__carry__1_i_1_n_0\
    );
\i__carry__1_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => AWLEN_reg(6),
      I1 => \i__carry__1_i_9_n_0\,
      I2 => AWLEN_reg(7),
      O => \i__carry__1_i_10_n_0\
    );
\i__carry__1_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C297"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => \i__carry__1_i_16_n_0\,
      I2 => AWLEN_reg(5),
      I3 => AWLEN_reg(6),
      O => \i__carry__1_i_11_n_0\
    );
\i__carry__1_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C297"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => \i__carry__1_i_9_n_0\,
      I2 => AWLEN_reg(6),
      I3 => AWLEN_reg(7),
      O => \i__carry__1_i_12_n_0\
    );
\i__carry__1_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \i__carry__0_i_14_n_0\,
      I1 => AWSIZE_reg(0),
      I2 => \i__carry__0_i_13_n_0\,
      O => \i__carry__1_i_13_n_0\
    );
\i__carry__1_i_14\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF87FF7FFF"
    )
        port map (
      I0 => \i__carry__1_i_9_n_0\,
      I1 => AWLEN_reg(6),
      I2 => AWLEN_reg(7),
      I3 => AWSIZE_reg(1),
      I4 => AWSIZE_reg(0),
      I5 => AWSIZE_reg(2),
      O => \i__carry__1_i_14_n_0\
    );
\i__carry__1_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1EE4E4E4E4E4E4E4"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWLEN_reg(4),
      I2 => AWLEN_reg(3),
      I3 => AWLEN_reg(1),
      I4 => AWLEN_reg(0),
      I5 => AWLEN_reg(2),
      O => \i__carry__1_i_15_n_0\
    );
\i__carry__1_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => AWLEN_reg(3),
      I1 => AWLEN_reg(1),
      I2 => AWLEN_reg(0),
      I3 => AWLEN_reg(2),
      I4 => AWLEN_reg(4),
      O => \i__carry__1_i_16_n_0\
    );
\i__carry__1_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00FFB8B800000000"
    )
        port map (
      I0 => \i__carry__0_i_10_n_0\,
      I1 => AWSIZE_reg(0),
      I2 => \i__carry__1_i_10_n_0\,
      I3 => \i__carry__1_i_11_n_0\,
      I4 => AWSIZE_reg(1),
      I5 => AWSIZE_reg(2),
      O => \i__carry__1_i_2_n_0\
    );
\i__carry__1_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CF50C050C050C050"
    )
        port map (
      I0 => \i__carry__1_i_12_n_0\,
      I1 => \i__carry__1_i_13_n_0\,
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \i__carry__1_i_10_n_0\,
      I5 => AWSIZE_reg(0),
      O => \i__carry__1_i_3_n_0\
    );
\i__carry__1_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"D5F55575"
    )
        port map (
      I0 => \i__carry__1_i_14_n_0\,
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => \i__carry__1_i_11_n_0\,
      I4 => \i__carry__1_i_15_n_0\,
      O => \i__carry__1_i_4_n_0\
    );
\i__carry__1_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BF7777F7F77F7FFF"
    )
        port map (
      I0 => AWSIZE_reg(1),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(0),
      I3 => AWLEN_reg(6),
      I4 => \i__carry__1_i_9_n_0\,
      I5 => AWLEN_reg(7),
      O => \i__carry__1_i_5_n_0\
    );
\i__carry__1_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF004747FFFFFFFF"
    )
        port map (
      I0 => \i__carry__0_i_10_n_0\,
      I1 => AWSIZE_reg(0),
      I2 => \i__carry__1_i_10_n_0\,
      I3 => \i__carry__1_i_11_n_0\,
      I4 => AWSIZE_reg(1),
      I5 => AWSIZE_reg(2),
      O => \i__carry__1_i_6_n_0\
    );
\i__carry__1_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"30AF3FAF3FAF3FAF"
    )
        port map (
      I0 => \i__carry__1_i_12_n_0\,
      I1 => \i__carry__1_i_13_n_0\,
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => \i__carry__1_i_10_n_0\,
      I5 => AWSIZE_reg(0),
      O => \i__carry__1_i_7_n_0\
    );
\i__carry__1_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2A0AAA8A"
    )
        port map (
      I0 => \i__carry__1_i_14_n_0\,
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => \i__carry__1_i_11_n_0\,
      I4 => \i__carry__1_i_15_n_0\,
      O => \i__carry__1_i_8_n_0\
    );
\i__carry__1_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => AWLEN_reg(4),
      I1 => AWLEN_reg(2),
      I2 => AWLEN_reg(0),
      I3 => AWLEN_reg(1),
      I4 => AWLEN_reg(3),
      I5 => AWLEN_reg(5),
      O => \i__carry__1_i_9_n_0\
    );
\i__carry__2_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \i__carry__1_i_10_n_0\,
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(0),
      O => \i__carry__2_i_1_n_0\
    );
\i__carry__2_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888800080000000"
    )
        port map (
      I0 => AWSIZE_reg(2),
      I1 => AWSIZE_reg(1),
      I2 => AWLEN_reg(6),
      I3 => \i__carry__1_i_9_n_0\,
      I4 => AWLEN_reg(7),
      I5 => AWSIZE_reg(0),
      O => \i__carry__2_i_2_n_0\
    );
\i__carry__2_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => \i__carry__1_i_10_n_0\,
      O => \i__carry__2_i_3_n_0\
    );
\i__carry__2_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9777FFFFFFFFFFFF"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWLEN_reg(7),
      I2 => \i__carry__1_i_9_n_0\,
      I3 => AWLEN_reg(6),
      I4 => AWSIZE_reg(1),
      I5 => AWSIZE_reg(2),
      O => \i__carry__2_i_4_n_0\
    );
\i__carry_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => AWLEN_reg(0),
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      O => \i__carry_i_1_n_0\
    );
\i__carry_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => AWLEN_reg(2),
      I1 => AWLEN_reg(1),
      I2 => AWLEN_reg(0),
      O => \i__carry_i_10_n_0\
    );
\i__carry_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => AWLEN_reg(3),
      I1 => AWLEN_reg(2),
      I2 => AWLEN_reg(0),
      I3 => AWLEN_reg(1),
      O => \i__carry_i_11_n_0\
    );
\i__carry_i_12\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02020E0E020E0E02"
    )
        port map (
      I0 => \i__carry__0_i_14_n_0\,
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(1),
      I3 => AWSIZE_reg(0),
      I4 => AWLEN_reg(0),
      I5 => AWLEN_reg(1),
      O => \i__carry_i_12_n_0\
    );
\i__carry_i_13\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C3C3C395C395C395"
    )
        port map (
      I0 => AWLEN_reg(2),
      I1 => AWLEN_reg(1),
      I2 => AWLEN_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWSIZE_reg(0),
      I5 => AWSIZE_reg(1),
      O => \i__carry_i_13_n_0\
    );
\i__carry_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF23002000"
    )
        port map (
      I0 => \i__carry_i_10_n_0\,
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(1),
      I4 => \i__carry_i_11_n_0\,
      I5 => \i__carry_i_12_n_0\,
      O => \i__carry_i_2_n_0\
    );
\i__carry_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0704070407043734"
    )
        port map (
      I0 => \i__carry_i_13_n_0\,
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => \i__carry_i_11_n_0\,
      I4 => AWLEN_reg(0),
      I5 => AWSIZE_reg(0),
      O => \i__carry_i_3_n_0\
    );
\i__carry_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0055007B00660048"
    )
        port map (
      I0 => AWLEN_reg(0),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(2),
      I4 => AWLEN_reg(1),
      I5 => AWLEN_reg(2),
      O => \i__carry_i_4_n_0\
    );
\i__carry_i_5\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00070304"
    )
        port map (
      I0 => AWSIZE_reg(0),
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => AWLEN_reg(0),
      I4 => AWLEN_reg(1),
      O => \i__carry_i_5_n_0\
    );
\i__carry_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000DCFFDFFF"
    )
        port map (
      I0 => \i__carry_i_10_n_0\,
      I1 => AWSIZE_reg(2),
      I2 => AWSIZE_reg(0),
      I3 => AWSIZE_reg(1),
      I4 => \i__carry_i_11_n_0\,
      I5 => \i__carry_i_12_n_0\,
      O => \i__carry_i_6_n_0\
    );
\i__carry_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8FBF8FBF8FBC8CB"
    )
        port map (
      I0 => \i__carry_i_13_n_0\,
      I1 => AWSIZE_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => \i__carry_i_11_n_0\,
      I4 => AWLEN_reg(0),
      I5 => AWSIZE_reg(0),
      O => \i__carry_i_7_n_0\
    );
\i__carry_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFCF9F9F0F3F5F5"
    )
        port map (
      I0 => AWLEN_reg(2),
      I1 => AWLEN_reg(1),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(0),
      I4 => AWSIZE_reg(1),
      I5 => AWLEN_reg(0),
      O => \i__carry_i_8_n_0\
    );
\i__carry_i_9\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF9FCF9"
    )
        port map (
      I0 => AWLEN_reg(1),
      I1 => AWLEN_reg(0),
      I2 => AWSIZE_reg(2),
      I3 => AWSIZE_reg(1),
      I4 => AWSIZE_reg(0),
      O => \i__carry_i_9_n_0\
    );
p_1_out_carry: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => p_1_out_carry_n_0,
      CO(2) => p_1_out_carry_n_1,
      CO(1) => p_1_out_carry_n_2,
      CO(0) => p_1_out_carry_n_3,
      CYINIT => p_1_out_carry_i_1_n_0,
      DI(3 downto 0) => p_0_out(5 downto 2),
      O(3) => p_1_out_carry_n_4,
      O(2) => p_1_out_carry_n_5,
      O(1) => p_1_out_carry_n_6,
      O(0) => p_1_out_carry_n_7,
      S(3) => p_1_out_carry_i_6_n_0,
      S(2) => p_1_out_carry_i_7_n_0,
      S(1) => p_1_out_carry_i_8_n_0,
      S(0) => p_1_out_carry_i_9_n_0
    );
\p_1_out_carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => p_1_out_carry_n_0,
      CO(3) => \p_1_out_carry__0_n_0\,
      CO(2) => \p_1_out_carry__0_n_1\,
      CO(1) => \p_1_out_carry__0_n_2\,
      CO(0) => \p_1_out_carry__0_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => p_0_out(9 downto 6),
      O(3) => \p_1_out_carry__0_n_4\,
      O(2) => \p_1_out_carry__0_n_5\,
      O(1) => \p_1_out_carry__0_n_6\,
      O(0) => \p_1_out_carry__0_n_7\,
      S(3) => \p_1_out_carry__0_i_5_n_0\,
      S(2) => \p_1_out_carry__0_i_6_n_0\,
      S(1) => \p_1_out_carry__0_i_7_n_0\,
      S(0) => \p_1_out_carry__0_i_8_n_0\
    );
\p_1_out_carry__0_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000FDFFF8FF"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => \p_1_out_carry__0_i_9_n_0\,
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__0_i_10_n_0\,
      I5 => \p_1_out_carry__0_i_11_n_0\,
      O => p_0_out(9)
    );
\p_1_out_carry__0_i_10\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => ARLEN_reg(7),
      I1 => ARLEN_reg(6),
      I2 => \p_1_out_carry__1_i_9_n_0\,
      O => \p_1_out_carry__0_i_10_n_0\
    );
\p_1_out_carry__0_i_11\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"0C110CDD"
    )
        port map (
      I0 => \p_1_out_carry__1_i_14_n_0\,
      I1 => ARSIZE_reg(2),
      I2 => \p_1_out_carry__0_i_20_n_0\,
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__1_i_13_n_0\,
      O => \p_1_out_carry__0_i_11_n_0\
    );
\p_1_out_carry__0_i_12\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"15"
    )
        port map (
      I0 => ARSIZE_reg(2),
      I1 => ARSIZE_reg(0),
      I2 => ARSIZE_reg(1),
      O => \p_1_out_carry__0_i_12_n_0\
    );
\p_1_out_carry__0_i_13\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"80000000"
    )
        port map (
      I0 => ARLEN_reg(3),
      I1 => ARLEN_reg(1),
      I2 => ARLEN_reg(0),
      I3 => ARLEN_reg(2),
      I4 => ARLEN_reg(4),
      O => \p_1_out_carry__0_i_13_n_0\
    );
\p_1_out_carry__0_i_14\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"2"
    )
        port map (
      I0 => ARSIZE_reg(1),
      I1 => ARSIZE_reg(2),
      O => \p_1_out_carry__0_i_14_n_0\
    );
\p_1_out_carry__0_i_15\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"E233E200"
    )
        port map (
      I0 => \p_1_out_carry__1_i_16_n_0\,
      I1 => ARSIZE_reg(1),
      I2 => \p_1_out_carry__0_i_21_n_0\,
      I3 => ARSIZE_reg(2),
      I4 => \p_1_out_carry__0_i_10_n_0\,
      O => \p_1_out_carry__0_i_15_n_0\
    );
\p_1_out_carry__0_i_16\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"6AAAAAAA"
    )
        port map (
      I0 => ARLEN_reg(4),
      I1 => ARLEN_reg(3),
      I2 => ARLEN_reg(1),
      I3 => ARLEN_reg(0),
      I4 => ARLEN_reg(2),
      O => \p_1_out_carry__0_i_16_n_0\
    );
\p_1_out_carry__0_i_17\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"6AAAAAAAAAAAAAAA"
    )
        port map (
      I0 => ARLEN_reg(5),
      I1 => ARLEN_reg(4),
      I2 => ARLEN_reg(2),
      I3 => ARLEN_reg(0),
      I4 => ARLEN_reg(1),
      I5 => ARLEN_reg(3),
      O => \p_1_out_carry__0_i_17_n_0\
    );
\p_1_out_carry__0_i_18\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"22EE2EE200CC0000"
    )
        port map (
      I0 => \p_1_out_carry__0_i_20_n_0\,
      I1 => ARSIZE_reg(1),
      I2 => ARLEN_reg(1),
      I3 => ARLEN_reg(0),
      I4 => ARSIZE_reg(0),
      I5 => ARSIZE_reg(2),
      O => \p_1_out_carry__0_i_18_n_0\
    );
\p_1_out_carry__0_i_19\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000F003C006A00"
    )
        port map (
      I0 => ARLEN_reg(2),
      I1 => ARLEN_reg(1),
      I2 => ARLEN_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(0),
      I5 => ARSIZE_reg(1),
      O => \p_1_out_carry__0_i_19_n_0\
    );
\p_1_out_carry__0_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF4BB80000"
    )
        port map (
      I0 => ARLEN_reg(6),
      I1 => \p_1_out_carry__0_i_12_n_0\,
      I2 => ARLEN_reg(5),
      I3 => \p_1_out_carry__0_i_13_n_0\,
      I4 => \p_1_out_carry__0_i_14_n_0\,
      I5 => \p_1_out_carry__0_i_15_n_0\,
      O => p_0_out(8)
    );
\p_1_out_carry__0_i_20\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"1EE4E4E4"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARLEN_reg(3),
      I2 => ARLEN_reg(2),
      I3 => ARLEN_reg(0),
      I4 => ARLEN_reg(1),
      O => \p_1_out_carry__0_i_20_n_0\
    );
\p_1_out_carry__0_i_21\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"1EE4"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARLEN_reg(2),
      I2 => ARLEN_reg(1),
      I3 => ARLEN_reg(0),
      O => \p_1_out_carry__0_i_21_n_0\
    );
\p_1_out_carry__0_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CCAACCAAFFFFF000"
    )
        port map (
      I0 => \p_1_out_carry__0_i_16_n_0\,
      I1 => \p_1_out_carry__0_i_17_n_0\,
      I2 => \p_1_out_carry__0_i_9_n_0\,
      I3 => \p_1_out_carry__0_i_12_n_0\,
      I4 => \p_1_out_carry__0_i_18_n_0\,
      I5 => \p_1_out_carry__0_i_14_n_0\,
      O => p_0_out(7)
    );
\p_1_out_carry__0_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"AFCFAFCFAFC0A0C0"
    )
        port map (
      I0 => \p_1_out_carry__0_i_16_n_0\,
      I1 => p_1_out_carry_i_11_n_0,
      I2 => \p_1_out_carry__0_i_14_n_0\,
      I3 => \p_1_out_carry__0_i_12_n_0\,
      I4 => \p_1_out_carry__0_i_17_n_0\,
      I5 => \p_1_out_carry__0_i_19_n_0\,
      O => p_0_out(6)
    );
\p_1_out_carry__0_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF02000700"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => \p_1_out_carry__0_i_9_n_0\,
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__0_i_10_n_0\,
      I5 => \p_1_out_carry__0_i_11_n_0\,
      O => \p_1_out_carry__0_i_5_n_0\
    );
\p_1_out_carry__0_i_6\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000B447FFFF"
    )
        port map (
      I0 => ARLEN_reg(6),
      I1 => \p_1_out_carry__0_i_12_n_0\,
      I2 => ARLEN_reg(5),
      I3 => \p_1_out_carry__0_i_13_n_0\,
      I4 => \p_1_out_carry__0_i_14_n_0\,
      I5 => \p_1_out_carry__0_i_15_n_0\,
      O => \p_1_out_carry__0_i_6_n_0\
    );
\p_1_out_carry__0_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3355335500000FFF"
    )
        port map (
      I0 => \p_1_out_carry__0_i_16_n_0\,
      I1 => \p_1_out_carry__0_i_17_n_0\,
      I2 => \p_1_out_carry__0_i_9_n_0\,
      I3 => \p_1_out_carry__0_i_12_n_0\,
      I4 => \p_1_out_carry__0_i_18_n_0\,
      I5 => \p_1_out_carry__0_i_14_n_0\,
      O => \p_1_out_carry__0_i_7_n_0\
    );
\p_1_out_carry__0_i_8\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"50305030503F5F3F"
    )
        port map (
      I0 => \p_1_out_carry__0_i_16_n_0\,
      I1 => p_1_out_carry_i_11_n_0,
      I2 => \p_1_out_carry__0_i_14_n_0\,
      I3 => \p_1_out_carry__0_i_12_n_0\,
      I4 => \p_1_out_carry__0_i_17_n_0\,
      I5 => \p_1_out_carry__0_i_19_n_0\,
      O => \p_1_out_carry__0_i_8_n_0\
    );
\p_1_out_carry__0_i_9\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"6"
    )
        port map (
      I0 => ARLEN_reg(6),
      I1 => \p_1_out_carry__1_i_9_n_0\,
      O => \p_1_out_carry__0_i_9_n_0\
    );
\p_1_out_carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \p_1_out_carry__0_n_0\,
      CO(3) => \p_1_out_carry__1_n_0\,
      CO(2) => \p_1_out_carry__1_n_1\,
      CO(1) => \p_1_out_carry__1_n_2\,
      CO(0) => \p_1_out_carry__1_n_3\,
      CYINIT => '0',
      DI(3 downto 0) => p_0_out(13 downto 10),
      O(3) => \p_1_out_carry__1_n_4\,
      O(2) => \p_1_out_carry__1_n_5\,
      O(1) => \p_1_out_carry__1_n_6\,
      O(0) => \p_1_out_carry__1_n_7\,
      S(3) => \p_1_out_carry__1_i_5_n_0\,
      S(2) => \p_1_out_carry__1_i_6_n_0\,
      S(1) => \p_1_out_carry__1_i_7_n_0\,
      S(0) => \p_1_out_carry__1_i_8_n_0\
    );
\p_1_out_carry__1_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3C6A000080000000"
    )
        port map (
      I0 => ARLEN_reg(7),
      I1 => \p_1_out_carry__1_i_9_n_0\,
      I2 => ARLEN_reg(6),
      I3 => ARSIZE_reg(0),
      I4 => ARSIZE_reg(2),
      I5 => ARSIZE_reg(1),
      O => p_0_out(13)
    );
\p_1_out_carry__1_i_10\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"9777"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARLEN_reg(7),
      I2 => \p_1_out_carry__1_i_9_n_0\,
      I3 => ARLEN_reg(6),
      O => \p_1_out_carry__1_i_10_n_0\
    );
\p_1_out_carry__1_i_11\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C297"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => \p_1_out_carry__0_i_13_n_0\,
      I2 => ARLEN_reg(5),
      I3 => ARLEN_reg(6),
      O => \p_1_out_carry__1_i_11_n_0\
    );
\p_1_out_carry__1_i_12\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"C297"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => \p_1_out_carry__1_i_9_n_0\,
      I2 => ARLEN_reg(6),
      I3 => ARLEN_reg(7),
      O => \p_1_out_carry__1_i_12_n_0\
    );
\p_1_out_carry__1_i_13\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \p_1_out_carry__0_i_16_n_0\,
      I1 => ARSIZE_reg(0),
      I2 => \p_1_out_carry__0_i_17_n_0\,
      O => \p_1_out_carry__1_i_13_n_0\
    );
\p_1_out_carry__1_i_14\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"80"
    )
        port map (
      I0 => ARLEN_reg(6),
      I1 => \p_1_out_carry__1_i_9_n_0\,
      I2 => ARLEN_reg(7),
      O => \p_1_out_carry__1_i_14_n_0\
    );
\p_1_out_carry__1_i_15\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF87FF7FFF"
    )
        port map (
      I0 => \p_1_out_carry__1_i_9_n_0\,
      I1 => ARLEN_reg(6),
      I2 => ARLEN_reg(7),
      I3 => ARSIZE_reg(1),
      I4 => ARSIZE_reg(0),
      I5 => ARSIZE_reg(2),
      O => \p_1_out_carry__1_i_15_n_0\
    );
\p_1_out_carry__1_i_16\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1EE4E4E4E4E4E4E4"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARLEN_reg(4),
      I2 => ARLEN_reg(3),
      I3 => ARLEN_reg(1),
      I4 => ARLEN_reg(0),
      I5 => ARLEN_reg(2),
      O => \p_1_out_carry__1_i_16_n_0\
    );
\p_1_out_carry__1_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"3500"
    )
        port map (
      I0 => \p_1_out_carry__1_i_10_n_0\,
      I1 => \p_1_out_carry__1_i_11_n_0\,
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(2),
      O => p_0_out(12)
    );
\p_1_out_carry__1_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"CF50C050C050C050"
    )
        port map (
      I0 => \p_1_out_carry__1_i_12_n_0\,
      I1 => \p_1_out_carry__1_i_13_n_0\,
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__1_i_14_n_0\,
      I5 => ARSIZE_reg(0),
      O => p_0_out(11)
    );
\p_1_out_carry__1_i_4\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"D5F55575"
    )
        port map (
      I0 => \p_1_out_carry__1_i_15_n_0\,
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => \p_1_out_carry__1_i_11_n_0\,
      I4 => \p_1_out_carry__1_i_16_n_0\,
      O => p_0_out(10)
    );
\p_1_out_carry__1_i_5\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"BF7777F7F77F7FFF"
    )
        port map (
      I0 => ARSIZE_reg(1),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(0),
      I3 => ARLEN_reg(6),
      I4 => \p_1_out_carry__1_i_9_n_0\,
      I5 => ARLEN_reg(7),
      O => \p_1_out_carry__1_i_5_n_0\
    );
\p_1_out_carry__1_i_6\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"CAFF"
    )
        port map (
      I0 => \p_1_out_carry__1_i_10_n_0\,
      I1 => \p_1_out_carry__1_i_11_n_0\,
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(2),
      O => \p_1_out_carry__1_i_6_n_0\
    );
\p_1_out_carry__1_i_7\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"30AF3FAF3FAF3FAF"
    )
        port map (
      I0 => \p_1_out_carry__1_i_12_n_0\,
      I1 => \p_1_out_carry__1_i_13_n_0\,
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => \p_1_out_carry__1_i_14_n_0\,
      I5 => ARSIZE_reg(0),
      O => \p_1_out_carry__1_i_7_n_0\
    );
\p_1_out_carry__1_i_8\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"2A0AAA8A"
    )
        port map (
      I0 => \p_1_out_carry__1_i_15_n_0\,
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => \p_1_out_carry__1_i_11_n_0\,
      I4 => \p_1_out_carry__1_i_16_n_0\,
      O => \p_1_out_carry__1_i_8_n_0\
    );
\p_1_out_carry__1_i_9\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"8000000000000000"
    )
        port map (
      I0 => ARLEN_reg(4),
      I1 => ARLEN_reg(2),
      I2 => ARLEN_reg(0),
      I3 => ARLEN_reg(1),
      I4 => ARLEN_reg(3),
      I5 => ARLEN_reg(5),
      O => \p_1_out_carry__1_i_9_n_0\
    );
\p_1_out_carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \p_1_out_carry__1_n_0\,
      CO(3) => \NLW_p_1_out_carry__2_CO_UNCONNECTED\(3),
      CO(2) => \p_1_out_carry__2_n_1\,
      CO(1) => \NLW_p_1_out_carry__2_CO_UNCONNECTED\(1),
      CO(0) => \p_1_out_carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \p_1_out_carry__2_i_1_n_0\,
      DI(0) => p_0_out(14),
      O(3 downto 2) => \NLW_p_1_out_carry__2_O_UNCONNECTED\(3 downto 2),
      O(1) => \p_1_out_carry__2_n_6\,
      O(0) => \p_1_out_carry__2_n_7\,
      S(3 downto 2) => B"01",
      S(1) => \p_1_out_carry__2_i_3_n_0\,
      S(0) => \p_1_out_carry__2_i_4_n_0\
    );
\p_1_out_carry__2_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"8000"
    )
        port map (
      I0 => \p_1_out_carry__1_i_14_n_0\,
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(0),
      O => \p_1_out_carry__2_i_1_n_0\
    );
\p_1_out_carry__2_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0888800080000000"
    )
        port map (
      I0 => ARSIZE_reg(2),
      I1 => ARSIZE_reg(1),
      I2 => ARLEN_reg(6),
      I3 => \p_1_out_carry__1_i_9_n_0\,
      I4 => ARLEN_reg(7),
      I5 => ARSIZE_reg(0),
      O => p_0_out(14)
    );
\p_1_out_carry__2_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"7FFF"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => \p_1_out_carry__1_i_14_n_0\,
      O => \p_1_out_carry__2_i_3_n_0\
    );
\p_1_out_carry__2_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"9777FFFFFFFFFFFF"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARLEN_reg(7),
      I2 => \p_1_out_carry__1_i_9_n_0\,
      I3 => ARLEN_reg(6),
      I4 => ARSIZE_reg(1),
      I5 => ARSIZE_reg(2),
      O => \p_1_out_carry__2_i_4_n_0\
    );
p_1_out_carry_i_1: unisim.vcomponents.LUT3
    generic map(
      INIT => X"01"
    )
        port map (
      I0 => ARLEN_reg(0),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      O => p_1_out_carry_i_1_n_0
    );
p_1_out_carry_i_10: unisim.vcomponents.LUT3
    generic map(
      INIT => X"6A"
    )
        port map (
      I0 => ARLEN_reg(2),
      I1 => ARLEN_reg(1),
      I2 => ARLEN_reg(0),
      O => p_1_out_carry_i_10_n_0
    );
p_1_out_carry_i_11: unisim.vcomponents.LUT4
    generic map(
      INIT => X"6AAA"
    )
        port map (
      I0 => ARLEN_reg(3),
      I1 => ARLEN_reg(2),
      I2 => ARLEN_reg(0),
      I3 => ARLEN_reg(1),
      O => p_1_out_carry_i_11_n_0
    );
p_1_out_carry_i_12: unisim.vcomponents.LUT6
    generic map(
      INIT => X"02020E0E020E0E02"
    )
        port map (
      I0 => \p_1_out_carry__0_i_16_n_0\,
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(0),
      I4 => ARLEN_reg(0),
      I5 => ARLEN_reg(1),
      O => p_1_out_carry_i_12_n_0
    );
p_1_out_carry_i_13: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C3C3C395C395C395"
    )
        port map (
      I0 => ARLEN_reg(2),
      I1 => ARLEN_reg(1),
      I2 => ARLEN_reg(0),
      I3 => ARSIZE_reg(2),
      I4 => ARSIZE_reg(0),
      I5 => ARSIZE_reg(1),
      O => p_1_out_carry_i_13_n_0
    );
p_1_out_carry_i_2: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFF23002000"
    )
        port map (
      I0 => p_1_out_carry_i_10_n_0,
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(1),
      I4 => p_1_out_carry_i_11_n_0,
      I5 => p_1_out_carry_i_12_n_0,
      O => p_0_out(5)
    );
p_1_out_carry_i_3: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0704070407043734"
    )
        port map (
      I0 => p_1_out_carry_i_13_n_0,
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => p_1_out_carry_i_11_n_0,
      I4 => ARLEN_reg(0),
      I5 => ARSIZE_reg(0),
      O => p_0_out(4)
    );
p_1_out_carry_i_4: unisim.vcomponents.LUT6
    generic map(
      INIT => X"0000367700003688"
    )
        port map (
      I0 => ARLEN_reg(1),
      I1 => ARLEN_reg(0),
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(1),
      I4 => ARSIZE_reg(2),
      I5 => ARLEN_reg(2),
      O => p_0_out(3)
    );
p_1_out_carry_i_5: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00070304"
    )
        port map (
      I0 => ARSIZE_reg(0),
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => ARLEN_reg(0),
      I4 => ARLEN_reg(1),
      O => p_0_out(2)
    );
p_1_out_carry_i_6: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00000000DCFFDFFF"
    )
        port map (
      I0 => p_1_out_carry_i_10_n_0,
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(0),
      I3 => ARSIZE_reg(1),
      I4 => p_1_out_carry_i_11_n_0,
      I5 => p_1_out_carry_i_12_n_0,
      O => p_1_out_carry_i_6_n_0
    );
p_1_out_carry_i_7: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F8FBF8FBF8FBC8CB"
    )
        port map (
      I0 => p_1_out_carry_i_13_n_0,
      I1 => ARSIZE_reg(1),
      I2 => ARSIZE_reg(2),
      I3 => p_1_out_carry_i_11_n_0,
      I4 => ARLEN_reg(0),
      I5 => ARSIZE_reg(0),
      O => p_1_out_carry_i_7_n_0
    );
p_1_out_carry_i_8: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FEFECDCDFDCDCDFD"
    )
        port map (
      I0 => ARLEN_reg(2),
      I1 => ARSIZE_reg(2),
      I2 => ARSIZE_reg(1),
      I3 => ARSIZE_reg(0),
      I4 => ARLEN_reg(0),
      I5 => ARLEN_reg(1),
      O => p_1_out_carry_i_8_n_0
    );
p_1_out_carry_i_9: unisim.vcomponents.LUT5
    generic map(
      INIT => X"FFF9FCF9"
    )
        port map (
      I0 => ARLEN_reg(1),
      I1 => ARLEN_reg(0),
      I2 => ARSIZE_reg(2),
      I3 => ARSIZE_reg(1),
      I4 => ARSIZE_reg(0),
      O => p_1_out_carry_i_9_n_0
    );
\p_1_out_inferred__0/i__carry\: unisim.vcomponents.CARRY4
     port map (
      CI => '0',
      CO(3) => \p_1_out_inferred__0/i__carry_n_0\,
      CO(2) => \p_1_out_inferred__0/i__carry_n_1\,
      CO(1) => \p_1_out_inferred__0/i__carry_n_2\,
      CO(0) => \p_1_out_inferred__0/i__carry_n_3\,
      CYINIT => \i__carry_i_1_n_0\,
      DI(3) => \i__carry_i_2_n_0\,
      DI(2) => \i__carry_i_3_n_0\,
      DI(1) => \i__carry_i_4_n_0\,
      DI(0) => \i__carry_i_5_n_0\,
      O(3) => \p_1_out_inferred__0/i__carry_n_4\,
      O(2) => \p_1_out_inferred__0/i__carry_n_5\,
      O(1) => \p_1_out_inferred__0/i__carry_n_6\,
      O(0) => \p_1_out_inferred__0/i__carry_n_7\,
      S(3) => \i__carry_i_6_n_0\,
      S(2) => \i__carry_i_7_n_0\,
      S(1) => \i__carry_i_8_n_0\,
      S(0) => \i__carry_i_9_n_0\
    );
\p_1_out_inferred__0/i__carry__0\: unisim.vcomponents.CARRY4
     port map (
      CI => \p_1_out_inferred__0/i__carry_n_0\,
      CO(3) => \p_1_out_inferred__0/i__carry__0_n_0\,
      CO(2) => \p_1_out_inferred__0/i__carry__0_n_1\,
      CO(1) => \p_1_out_inferred__0/i__carry__0_n_2\,
      CO(0) => \p_1_out_inferred__0/i__carry__0_n_3\,
      CYINIT => '0',
      DI(3) => \i__carry__0_i_1_n_0\,
      DI(2) => \i__carry__0_i_2_n_0\,
      DI(1) => \i__carry__0_i_3_n_0\,
      DI(0) => \i__carry__0_i_4_n_0\,
      O(3) => \p_1_out_inferred__0/i__carry__0_n_4\,
      O(2) => \p_1_out_inferred__0/i__carry__0_n_5\,
      O(1) => \p_1_out_inferred__0/i__carry__0_n_6\,
      O(0) => \p_1_out_inferred__0/i__carry__0_n_7\,
      S(3) => \i__carry__0_i_5_n_0\,
      S(2) => \i__carry__0_i_6_n_0\,
      S(1) => \i__carry__0_i_7_n_0\,
      S(0) => \i__carry__0_i_8_n_0\
    );
\p_1_out_inferred__0/i__carry__1\: unisim.vcomponents.CARRY4
     port map (
      CI => \p_1_out_inferred__0/i__carry__0_n_0\,
      CO(3) => \p_1_out_inferred__0/i__carry__1_n_0\,
      CO(2) => \p_1_out_inferred__0/i__carry__1_n_1\,
      CO(1) => \p_1_out_inferred__0/i__carry__1_n_2\,
      CO(0) => \p_1_out_inferred__0/i__carry__1_n_3\,
      CYINIT => '0',
      DI(3) => \i__carry__1_i_1_n_0\,
      DI(2) => \i__carry__1_i_2_n_0\,
      DI(1) => \i__carry__1_i_3_n_0\,
      DI(0) => \i__carry__1_i_4_n_0\,
      O(3) => \p_1_out_inferred__0/i__carry__1_n_4\,
      O(2) => \p_1_out_inferred__0/i__carry__1_n_5\,
      O(1) => \p_1_out_inferred__0/i__carry__1_n_6\,
      O(0) => \p_1_out_inferred__0/i__carry__1_n_7\,
      S(3) => \i__carry__1_i_5_n_0\,
      S(2) => \i__carry__1_i_6_n_0\,
      S(1) => \i__carry__1_i_7_n_0\,
      S(0) => \i__carry__1_i_8_n_0\
    );
\p_1_out_inferred__0/i__carry__2\: unisim.vcomponents.CARRY4
     port map (
      CI => \p_1_out_inferred__0/i__carry__1_n_0\,
      CO(3) => \NLW_p_1_out_inferred__0/i__carry__2_CO_UNCONNECTED\(3),
      CO(2) => \p_1_out_inferred__0/i__carry__2_n_1\,
      CO(1) => \NLW_p_1_out_inferred__0/i__carry__2_CO_UNCONNECTED\(1),
      CO(0) => \p_1_out_inferred__0/i__carry__2_n_3\,
      CYINIT => '0',
      DI(3 downto 2) => B"00",
      DI(1) => \i__carry__2_i_1_n_0\,
      DI(0) => \i__carry__2_i_2_n_0\,
      O(3 downto 2) => \NLW_p_1_out_inferred__0/i__carry__2_O_UNCONNECTED\(3 downto 2),
      O(1) => \p_1_out_inferred__0/i__carry__2_n_6\,
      O(0) => \p_1_out_inferred__0/i__carry__2_n_7\,
      S(3 downto 2) => B"01",
      S(1) => \i__carry__2_i_3_n_0\,
      S(0) => \i__carry__2_i_4_n_0\
    );
\stateR[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \stateR[0]_i_2_n_0\,
      I1 => stateR,
      I2 => \stateR_reg_n_0_[0]\,
      O => \stateR[0]_i_1_n_0\
    );
\stateR[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"3044337700440044"
    )
        port map (
      I0 => \tickR[3]_i_3_n_0\,
      I1 => \stateR_reg_n_0_[1]\,
      I2 => ARSTRB_reg1,
      I3 => \stateR_reg_n_0_[2]\,
      I4 => \stateR_reg_n_0_[0]\,
      I5 => \Traddr[31]_i_2_n_0\,
      O => \stateR[0]_i_2_n_0\
    );
\stateR[0]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FF3F333FFC2E302E"
    )
        port map (
      I0 => ARREADY_i_2_n_0,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => ACK_reg_n_0,
      I3 => \stateR_reg_n_0_[1]\,
      I4 => s_axi_rready,
      I5 => \stateR_reg_n_0_[0]\,
      O => stateR
    );
\stateR[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"07A7B2B2"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => ACK_reg_n_0,
      I2 => \stateR_reg_n_0_[1]\,
      I3 => s_axi_rready,
      I4 => \stateR_reg_n_0_[0]\,
      O => \stateR[1]_i_1_n_0\
    );
\stateR[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"5AFA48E8"
    )
        port map (
      I0 => \stateR_reg_n_0_[2]\,
      I1 => ACK_reg_n_0,
      I2 => \stateR_reg_n_0_[1]\,
      I3 => s_axi_rready,
      I4 => \stateR_reg_n_0_[0]\,
      O => \stateR[2]_i_1_n_0\
    );
\stateR_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => \stateR[0]_i_1_n_0\,
      Q => \stateR_reg_n_0_[0]\
    );
\stateR_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => \stateR[1]_i_1_n_0\,
      Q => \stateR_reg_n_0_[1]\
    );
\stateR_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => \stateR[2]_i_1_n_0\,
      Q => \stateR_reg_n_0_[2]\
    );
\stateW[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \stateW[0]_i_2_n_0\,
      I1 => stateW,
      I2 => \stateW_reg_n_0_[0]\,
      O => \stateW[0]_i_1_n_0\
    );
\stateW[0]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"830383C38F338FF3"
    )
        port map (
      I0 => ACK_reg_n_0,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => \stateW_reg_n_0_[2]\,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => \stateW[2]_i_2_n_0\,
      I5 => \stateW[0]_i_3_n_0\,
      O => \stateW[0]_i_2_n_0\
    );
\stateW[0]_i_3\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"55555554"
    )
        port map (
      I0 => BID0_carry_n_0,
      I1 => \tickW_reg_n_0_[3]\,
      I2 => \tickW_reg_n_0_[2]\,
      I3 => \tickW_reg_n_0_[0]\,
      I4 => \tickW_reg_n_0_[1]\,
      O => \stateW[0]_i_3_n_0\
    );
\stateW[1]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"B8"
    )
        port map (
      I0 => \stateW[1]_i_2_n_0\,
      I1 => stateW,
      I2 => \stateW_reg_n_0_[1]\,
      O => \stateW[1]_i_1_n_0\
    );
\stateW[1]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"F35FFF30035FFF30"
    )
        port map (
      I0 => \stateW[2]_i_2_n_0\,
      I1 => \BID[3]_i_2_n_0\,
      I2 => \stateW_reg_n_0_[2]\,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => \stateW_reg_n_0_[0]\,
      I5 => ACK_reg_n_0,
      O => \stateW[1]_i_2_n_0\
    );
\stateW[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"C0AFFFFFF0000000"
    )
        port map (
      I0 => \stateW[2]_i_2_n_0\,
      I1 => ACK_reg_n_0,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => \stateW_reg_n_0_[1]\,
      I4 => stateW,
      I5 => \stateW_reg_n_0_[2]\,
      O => \stateW[2]_i_1_n_0\
    );
\stateW[2]_i_2\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \WSTRB_reg_reg_n_0_[3]\,
      I1 => \WSTRB_reg_reg_n_0_[0]\,
      I2 => \WSTRB_reg_reg_n_0_[2]\,
      I3 => \WSTRB_reg_reg_n_0_[1]\,
      O => \stateW[2]_i_2_n_0\
    );
\stateW[2]_i_3\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"FFFFFFFFEEFEEEEE"
    )
        port map (
      I0 => \stateW[2]_i_4_n_0\,
      I1 => WSTRB_reg,
      I2 => \stateW_reg_n_0_[1]\,
      I3 => \stateW_reg_n_0_[2]\,
      I4 => \stateW[2]_i_5_n_0\,
      I5 => \stateW[2]_i_6_n_0\,
      O => stateW
    );
\stateW[2]_i_4\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"008F00000FFF0000"
    )
        port map (
      I0 => \^s_axi_bvalid\,
      I1 => s_axi_bready,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => ACK_reg_n_0,
      I4 => \stateW_reg_n_0_[2]\,
      I5 => \stateW_reg_n_0_[1]\,
      O => \stateW[2]_i_4_n_0\
    );
\stateW[2]_i_5\: unisim.vcomponents.LUT2
    generic map(
      INIT => X"8"
    )
        port map (
      I0 => ACK_reg_n_0,
      I1 => \stateW_reg_n_0_[0]\,
      O => \stateW[2]_i_5_n_0\
    );
\stateW[2]_i_6\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00000F02"
    )
        port map (
      I0 => s_axi_awvalid,
      I1 => p_0_in(0),
      I2 => \stateW_reg_n_0_[2]\,
      I3 => \stateW_reg_n_0_[0]\,
      I4 => \stateW_reg_n_0_[1]\,
      O => \stateW[2]_i_6_n_0\
    );
\stateW_reg[0]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => \stateW[0]_i_1_n_0\,
      Q => \stateW_reg_n_0_[0]\
    );
\stateW_reg[1]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => \stateW[1]_i_1_n_0\,
      Q => \stateW_reg_n_0_[1]\
    );
\stateW_reg[2]\: unisim.vcomponents.FDCE
    generic map(
      INIT => '0'
    )
        port map (
      C => axi_aclk,
      CE => '1',
      CLR => AWREADY_i_2_n_0,
      D => \stateW[2]_i_1_n_0\,
      Q => \stateW_reg_n_0_[2]\
    );
\tickR[0]_i_1\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"C7"
    )
        port map (
      I0 => \tickR_reg_n_0_[0]\,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \stateR_reg_n_0_[1]\,
      O => \tickR[0]_i_1_n_0\
    );
\tickR[1]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0600"
    )
        port map (
      I0 => \tickR_reg_n_0_[0]\,
      I1 => \tickR_reg_n_0_[1]\,
      I2 => \stateR_reg_n_0_[1]\,
      I3 => \stateR_reg_n_0_[2]\,
      O => \tickR[1]_i_1_n_0\
    );
\tickR[2]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"04404040"
    )
        port map (
      I0 => \stateR_reg_n_0_[1]\,
      I1 => \stateR_reg_n_0_[2]\,
      I2 => \tickR_reg_n_0_[2]\,
      I3 => \tickR_reg_n_0_[0]\,
      I4 => \tickR_reg_n_0_[1]\,
      O => \tickR[2]_i_1_n_0\
    );
\tickR[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"00005F5FC0CF5000"
    )
        port map (
      I0 => \tickR[3]_i_3_n_0\,
      I1 => s_axi_rready,
      I2 => \stateR_reg_n_0_[1]\,
      I3 => ACK_reg_n_0,
      I4 => \stateR_reg_n_0_[2]\,
      I5 => \stateR_reg_n_0_[0]\,
      O => tickR
    );
\tickR[3]_i_2\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"1444444400000000"
    )
        port map (
      I0 => \stateR_reg_n_0_[1]\,
      I1 => \tickR_reg_n_0_[3]\,
      I2 => \tickR_reg_n_0_[2]\,
      I3 => \tickR_reg_n_0_[0]\,
      I4 => \tickR_reg_n_0_[1]\,
      I5 => \stateR_reg_n_0_[2]\,
      O => \tickR[3]_i_2_n_0\
    );
\tickR[3]_i_3\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"0001"
    )
        port map (
      I0 => \tickR_reg_n_0_[1]\,
      I1 => \tickR_reg_n_0_[0]\,
      I2 => \tickR_reg_n_0_[2]\,
      I3 => \tickR_reg_n_0_[3]\,
      O => \tickR[3]_i_3_n_0\
    );
\tickR_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => tickR,
      CLR => AWREADY_i_2_n_0,
      D => \tickR[0]_i_1_n_0\,
      Q => \tickR_reg_n_0_[0]\
    );
\tickR_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => tickR,
      CLR => AWREADY_i_2_n_0,
      D => \tickR[1]_i_1_n_0\,
      Q => \tickR_reg_n_0_[1]\
    );
\tickR_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => tickR,
      CLR => AWREADY_i_2_n_0,
      D => \tickR[2]_i_1_n_0\,
      Q => \tickR_reg_n_0_[2]\
    );
\tickR_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => tickR,
      CLR => AWREADY_i_2_n_0,
      D => \tickR[3]_i_2_n_0\,
      Q => \tickR_reg_n_0_[3]\
    );
\tickW[0]_i_1\: unisim.vcomponents.LUT4
    generic map(
      INIT => X"5140"
    )
        port map (
      I0 => \tickW_reg_n_0_[0]\,
      I1 => \stateW_reg_n_0_[0]\,
      I2 => \stateW_reg_n_0_[2]\,
      I3 => \stateW_reg_n_0_[1]\,
      O => \tickW[0]_i_1_n_0\
    );
\tickW[1]_i_1\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"66066000"
    )
        port map (
      I0 => \tickW_reg_n_0_[1]\,
      I1 => \tickW_reg_n_0_[0]\,
      I2 => \stateW_reg_n_0_[0]\,
      I3 => \stateW_reg_n_0_[2]\,
      I4 => \stateW_reg_n_0_[1]\,
      O => \tickW[1]_i_1_n_0\
    );
\tickW[2]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"7878007878000000"
    )
        port map (
      I0 => \tickW_reg_n_0_[0]\,
      I1 => \tickW_reg_n_0_[1]\,
      I2 => \tickW_reg_n_0_[2]\,
      I3 => \stateW_reg_n_0_[0]\,
      I4 => \stateW_reg_n_0_[2]\,
      I5 => \stateW_reg_n_0_[1]\,
      O => \tickW[2]_i_1_n_0\
    );
\tickW[3]_i_1\: unisim.vcomponents.LUT6
    generic map(
      INIT => X"000030AA0F33FF00"
    )
        port map (
      I0 => s_axi_wvalid,
      I1 => \BID[3]_i_2_n_0\,
      I2 => ACK_reg_n_0,
      I3 => \stateW_reg_n_0_[0]\,
      I4 => \stateW_reg_n_0_[2]\,
      I5 => \stateW_reg_n_0_[1]\,
      O => tickW
    );
\tickW[3]_i_2\: unisim.vcomponents.LUT5
    generic map(
      INIT => X"00007F80"
    )
        port map (
      I0 => \tickW_reg_n_0_[2]\,
      I1 => \tickW_reg_n_0_[1]\,
      I2 => \tickW_reg_n_0_[0]\,
      I3 => \tickW_reg_n_0_[3]\,
      I4 => \tickW[3]_i_3_n_0\,
      O => \tickW[3]_i_2_n_0\
    );
\tickW[3]_i_3\: unisim.vcomponents.LUT3
    generic map(
      INIT => X"35"
    )
        port map (
      I0 => \stateW_reg_n_0_[1]\,
      I1 => \stateW_reg_n_0_[2]\,
      I2 => \stateW_reg_n_0_[0]\,
      O => \tickW[3]_i_3_n_0\
    );
\tickW_reg[0]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => tickW,
      CLR => AWREADY_i_2_n_0,
      D => \tickW[0]_i_1_n_0\,
      Q => \tickW_reg_n_0_[0]\
    );
\tickW_reg[1]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => tickW,
      CLR => AWREADY_i_2_n_0,
      D => \tickW[1]_i_1_n_0\,
      Q => \tickW_reg_n_0_[1]\
    );
\tickW_reg[2]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => tickW,
      CLR => AWREADY_i_2_n_0,
      D => \tickW[2]_i_1_n_0\,
      Q => \tickW_reg_n_0_[2]\
    );
\tickW_reg[3]\: unisim.vcomponents.FDCE
     port map (
      C => axi_aclk,
      CE => tickW,
      CLR => AWREADY_i_2_n_0,
      D => \tickW[3]_i_2_n_0\,
      Q => \tickW_reg_n_0_[3]\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_zed_axi4_to_apb4_s3_0_0_axi4_to_apb4_s3 is
  port (
    s_axi_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    M0_APB_PADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    \M_PADDR_reg[13]\ : out STD_LOGIC;
    \M_PADDR_reg[12]\ : out STD_LOGIC;
    M0_APB_PSEL : out STD_LOGIC;
    s_axi_bvalid : out STD_LOGIC;
    M2_APB_PWRITE : out STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bresp : out STD_LOGIC_VECTOR ( 0 to 0 );
    s_axi_arready : out STD_LOGIC;
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    M2_APB_PENABLE : out STD_LOGIC;
    s_axi_awvalid : in STD_LOGIC;
    s_axi_arvalid : in STD_LOGIC;
    PCLK : in STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    axi_aclk : in STD_LOGIC;
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PREADY : in STD_LOGIC;
    M0_APB_PREADY : in STD_LOGIC;
    M1_APB_PREADY : in STD_LOGIC;
    M0_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M1_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_bready : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    axi_aresetn : in STD_LOGIC;
    PRESETn : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of design_zed_axi4_to_apb4_s3_0_0_axi4_to_apb4_s3 : entity is "axi4_to_apb4_s3";
end design_zed_axi4_to_apb4_s3_0_0_axi4_to_apb4_s3;

architecture STRUCTURE of design_zed_axi4_to_apb4_s3_0_0_axi4_to_apb4_s3 is
begin
u_bridge: entity work.design_zed_axi4_to_apb4_s3_0_0_axi_to_apb_bridge
     port map (
      M0_APB_PADDR(31 downto 0) => M0_APB_PADDR(31 downto 0),
      M0_APB_PRDATA(31 downto 0) => M0_APB_PRDATA(31 downto 0),
      M0_APB_PREADY => M0_APB_PREADY,
      M0_APB_PSEL => M0_APB_PSEL,
      M1_APB_PRDATA(31 downto 0) => M1_APB_PRDATA(31 downto 0),
      M1_APB_PREADY => M1_APB_PREADY,
      M2_APB_PENABLE => M2_APB_PENABLE,
      M2_APB_PRDATA(31 downto 0) => M2_APB_PRDATA(31 downto 0),
      M2_APB_PREADY => M2_APB_PREADY,
      M2_APB_PSTRB(3 downto 0) => M2_APB_PSTRB(3 downto 0),
      M2_APB_PWDATA(31 downto 0) => M2_APB_PWDATA(31 downto 0),
      M2_APB_PWRITE => M2_APB_PWRITE,
      \M_PADDR_reg[12]_0\ => \M_PADDR_reg[12]\,
      \M_PADDR_reg[13]_0\ => \M_PADDR_reg[13]\,
      PCLK => PCLK,
      PRESETn => PRESETn,
      axi_aclk => axi_aclk,
      axi_aresetn => axi_aresetn,
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_arid(3 downto 0) => s_axi_arid(3 downto 0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awid(3 downto 0) => s_axi_awid(3 downto 0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(3 downto 0) => s_axi_bid(3 downto 0),
      s_axi_bready => s_axi_bready,
      s_axi_bresp(0) => s_axi_bresp(0),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rid(3 downto 0) => s_axi_rid(3 downto 0),
      s_axi_rlast => s_axi_rlast,
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wid(3 downto 0) => s_axi_wid(3 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_zed_axi4_to_apb4_s3_0_0 is
  port (
    axi_aresetn : in STD_LOGIC;
    axi_aclk : in STD_LOGIC;
    s_axi_awid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_awaddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_awlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_awsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_awburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_awvalid : in STD_LOGIC;
    s_axi_awready : out STD_LOGIC;
    s_axi_wid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_wstrb : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_wlast : in STD_LOGIC;
    s_axi_wvalid : in STD_LOGIC;
    s_axi_wready : out STD_LOGIC;
    s_axi_bid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_bresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_bvalid : out STD_LOGIC;
    s_axi_bready : in STD_LOGIC;
    s_axi_arid : in STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_araddr : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_arlen : in STD_LOGIC_VECTOR ( 7 downto 0 );
    s_axi_arsize : in STD_LOGIC_VECTOR ( 2 downto 0 );
    s_axi_arburst : in STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_arvalid : in STD_LOGIC;
    s_axi_arready : out STD_LOGIC;
    s_axi_rid : out STD_LOGIC_VECTOR ( 3 downto 0 );
    s_axi_rdata : out STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axi_rresp : out STD_LOGIC_VECTOR ( 1 downto 0 );
    s_axi_rlast : out STD_LOGIC;
    s_axi_rvalid : out STD_LOGIC;
    s_axi_rready : in STD_LOGIC;
    PRESETn : in STD_LOGIC;
    PCLK : in STD_LOGIC;
    M0_APB_PADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M0_APB_PENABLE : out STD_LOGIC;
    M0_APB_PWRITE : out STD_LOGIC;
    M0_APB_PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M0_APB_PSEL : out STD_LOGIC;
    M0_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M0_APB_PREADY : in STD_LOGIC;
    M0_APB_PSLVERR : in STD_LOGIC;
    M0_APB_PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M1_APB_PADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M1_APB_PENABLE : out STD_LOGIC;
    M1_APB_PWRITE : out STD_LOGIC;
    M1_APB_PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M1_APB_PSEL : out STD_LOGIC;
    M1_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M1_APB_PREADY : in STD_LOGIC;
    M1_APB_PSLVERR : in STD_LOGIC;
    M1_APB_PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    M2_APB_PADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PENABLE : out STD_LOGIC;
    M2_APB_PWRITE : out STD_LOGIC;
    M2_APB_PWDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PSEL : out STD_LOGIC;
    M2_APB_PRDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    M2_APB_PREADY : in STD_LOGIC;
    M2_APB_PSLVERR : in STD_LOGIC;
    M2_APB_PSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of design_zed_axi4_to_apb4_s3_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of design_zed_axi4_to_apb4_s3_0_0 : entity is "design_zed_axi4_to_apb4_s3_0_0,axi4_to_apb4_s3,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of design_zed_axi4_to_apb4_s3_0_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of design_zed_axi4_to_apb4_s3_0_0 : entity is "module_ref";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of design_zed_axi4_to_apb4_s3_0_0 : entity is "axi4_to_apb4_s3,Vivado 2020.2";
end design_zed_axi4_to_apb4_s3_0_0;

architecture STRUCTURE of design_zed_axi4_to_apb4_s3_0_0 is
  signal \<const0>\ : STD_LOGIC;
  signal \^m0_apb_paddr\ : STD_LOGIC_VECTOR ( 31 downto 10 );
  signal \^m2_apb_paddr\ : STD_LOGIC_VECTOR ( 9 downto 0 );
  signal \^m2_apb_penable\ : STD_LOGIC;
  signal \^m2_apb_pstrb\ : STD_LOGIC_VECTOR ( 3 downto 0 );
  signal \^m2_apb_pwdata\ : STD_LOGIC_VECTOR ( 31 downto 0 );
  signal \^m2_apb_pwrite\ : STD_LOGIC;
  signal \^s_axi_bresp\ : STD_LOGIC_VECTOR ( 1 to 1 );
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of M0_APB_PENABLE : signal is "xilinx.com:interface:apb:1.0 M0_APB PENABLE";
  attribute X_INTERFACE_INFO of M0_APB_PREADY : signal is "xilinx.com:interface:apb:1.0 M0_APB PREADY";
  attribute X_INTERFACE_INFO of M0_APB_PSEL : signal is "xilinx.com:interface:apb:1.0 M0_APB PSEL";
  attribute X_INTERFACE_INFO of M0_APB_PSLVERR : signal is "xilinx.com:interface:apb:1.0 M0_APB PSLVERR";
  attribute X_INTERFACE_INFO of M0_APB_PWRITE : signal is "xilinx.com:interface:apb:1.0 M0_APB PWRITE";
  attribute X_INTERFACE_INFO of M1_APB_PENABLE : signal is "xilinx.com:interface:apb:1.0 M1_APB PENABLE";
  attribute X_INTERFACE_INFO of M1_APB_PREADY : signal is "xilinx.com:interface:apb:1.0 M1_APB PREADY";
  attribute X_INTERFACE_INFO of M1_APB_PSEL : signal is "xilinx.com:interface:apb:1.0 M1_APB PSEL";
  attribute X_INTERFACE_INFO of M1_APB_PSLVERR : signal is "xilinx.com:interface:apb:1.0 M1_APB PSLVERR";
  attribute X_INTERFACE_INFO of M1_APB_PWRITE : signal is "xilinx.com:interface:apb:1.0 M1_APB PWRITE";
  attribute X_INTERFACE_INFO of M2_APB_PENABLE : signal is "xilinx.com:interface:apb:1.0 M2_APB PENABLE";
  attribute X_INTERFACE_INFO of M2_APB_PREADY : signal is "xilinx.com:interface:apb:1.0 M2_APB PREADY";
  attribute X_INTERFACE_INFO of M2_APB_PSEL : signal is "xilinx.com:interface:apb:1.0 M2_APB PSEL";
  attribute X_INTERFACE_INFO of M2_APB_PSLVERR : signal is "xilinx.com:interface:apb:1.0 M2_APB PSLVERR";
  attribute X_INTERFACE_INFO of M2_APB_PWRITE : signal is "xilinx.com:interface:apb:1.0 M2_APB PWRITE";
  attribute X_INTERFACE_INFO of PCLK : signal is "xilinx.com:signal:clock:1.0 PCLK CLK";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of PCLK : signal is "XIL_INTERFACENAME PCLK, ASSOCIATED_RESET PRESETn, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of PRESETn : signal is "xilinx.com:signal:reset:1.0 PRESETn RST";
  attribute X_INTERFACE_PARAMETER of PRESETn : signal is "XIL_INTERFACENAME PRESETn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of axi_aclk : signal is "xilinx.com:signal:clock:1.0 axi_aclk CLK";
  attribute X_INTERFACE_PARAMETER of axi_aclk : signal is "XIL_INTERFACENAME axi_aclk, ASSOCIATED_BUSIF s_axi:m_axil, ASSOCIATED_RESET axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of axi_aresetn : signal is "xilinx.com:signal:reset:1.0 axi_aresetn RST";
  attribute X_INTERFACE_PARAMETER of axi_aresetn : signal is "XIL_INTERFACENAME axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_arready : signal is "xilinx.com:interface:aximm:1.0 s_axi ARREADY";
  attribute X_INTERFACE_INFO of s_axi_arvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARVALID";
  attribute X_INTERFACE_INFO of s_axi_awready : signal is "xilinx.com:interface:aximm:1.0 s_axi AWREADY";
  attribute X_INTERFACE_INFO of s_axi_awvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWVALID";
  attribute X_INTERFACE_INFO of s_axi_bready : signal is "xilinx.com:interface:aximm:1.0 s_axi BREADY";
  attribute X_INTERFACE_INFO of s_axi_bvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi BVALID";
  attribute X_INTERFACE_INFO of s_axi_rlast : signal is "xilinx.com:interface:aximm:1.0 s_axi RLAST";
  attribute X_INTERFACE_INFO of s_axi_rready : signal is "xilinx.com:interface:aximm:1.0 s_axi RREADY";
  attribute X_INTERFACE_PARAMETER of s_axi_rready : signal is "XIL_INTERFACENAME s_axi, ASSOCIATED_BUSIF s_axi:m_axil, ASSOCIATED_RESET axi_aresetn, RUSER_WIDTH 0, WUSER_WIDTH 0, ARUSER_WIDTH 0, AWUSER_WIDTH 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 0, HAS_QOS 0, HAS_REGION 0, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 4, ADDR_WIDTH 32, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of s_axi_rvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi RVALID";
  attribute X_INTERFACE_INFO of s_axi_wlast : signal is "xilinx.com:interface:aximm:1.0 s_axi WLAST";
  attribute X_INTERFACE_INFO of s_axi_wready : signal is "xilinx.com:interface:aximm:1.0 s_axi WREADY";
  attribute X_INTERFACE_INFO of s_axi_wvalid : signal is "xilinx.com:interface:aximm:1.0 s_axi WVALID";
  attribute X_INTERFACE_INFO of M0_APB_PADDR : signal is "xilinx.com:interface:apb:1.0 M0_APB PADDR";
  attribute X_INTERFACE_INFO of M0_APB_PRDATA : signal is "xilinx.com:interface:apb:1.0 M0_APB PRDATA";
  attribute X_INTERFACE_INFO of M0_APB_PSTRB : signal is "xilinx.com:interface:apb:1.0 M0_APB PSTRB";
  attribute X_INTERFACE_PARAMETER of M0_APB_PSTRB : signal is "XIL_INTERFACENAME M0_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn";
  attribute X_INTERFACE_INFO of M0_APB_PWDATA : signal is "xilinx.com:interface:apb:1.0 M0_APB PWDATA";
  attribute X_INTERFACE_INFO of M1_APB_PADDR : signal is "xilinx.com:interface:apb:1.0 M1_APB PADDR";
  attribute X_INTERFACE_INFO of M1_APB_PRDATA : signal is "xilinx.com:interface:apb:1.0 M1_APB PRDATA";
  attribute X_INTERFACE_INFO of M1_APB_PSTRB : signal is "xilinx.com:interface:apb:1.0 M1_APB PSTRB";
  attribute X_INTERFACE_PARAMETER of M1_APB_PSTRB : signal is "XIL_INTERFACENAME M1_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn";
  attribute X_INTERFACE_INFO of M1_APB_PWDATA : signal is "xilinx.com:interface:apb:1.0 M1_APB PWDATA";
  attribute X_INTERFACE_INFO of M2_APB_PADDR : signal is "xilinx.com:interface:apb:1.0 M2_APB PADDR";
  attribute X_INTERFACE_INFO of M2_APB_PRDATA : signal is "xilinx.com:interface:apb:1.0 M2_APB PRDATA";
  attribute X_INTERFACE_INFO of M2_APB_PSTRB : signal is "xilinx.com:interface:apb:1.0 M2_APB PSTRB";
  attribute X_INTERFACE_PARAMETER of M2_APB_PSTRB : signal is "XIL_INTERFACENAME M2_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn";
  attribute X_INTERFACE_INFO of M2_APB_PWDATA : signal is "xilinx.com:interface:apb:1.0 M2_APB PWDATA";
  attribute X_INTERFACE_INFO of s_axi_araddr : signal is "xilinx.com:interface:aximm:1.0 s_axi ARADDR";
  attribute X_INTERFACE_INFO of s_axi_arburst : signal is "xilinx.com:interface:aximm:1.0 s_axi ARBURST";
  attribute X_INTERFACE_INFO of s_axi_arid : signal is "xilinx.com:interface:aximm:1.0 s_axi ARID";
  attribute X_INTERFACE_INFO of s_axi_arlen : signal is "xilinx.com:interface:aximm:1.0 s_axi ARLEN";
  attribute X_INTERFACE_INFO of s_axi_arsize : signal is "xilinx.com:interface:aximm:1.0 s_axi ARSIZE";
  attribute X_INTERFACE_INFO of s_axi_awaddr : signal is "xilinx.com:interface:aximm:1.0 s_axi AWADDR";
  attribute X_INTERFACE_INFO of s_axi_awburst : signal is "xilinx.com:interface:aximm:1.0 s_axi AWBURST";
  attribute X_INTERFACE_INFO of s_axi_awid : signal is "xilinx.com:interface:aximm:1.0 s_axi AWID";
  attribute X_INTERFACE_PARAMETER of s_axi_awid : signal is "ASSOCIATED_BUSIF s_axi,ASSOCIATED_RESET axi_aresetn,CLK_DOMAIN axi_aclk,                                RUSER_WIDTH 0,WUSER_WIDTH 0,ARUSER_WIDTH 0,AWUSER_WIDTH 0,                                HAS_CACHE 0,HAS_LOCK 0,HAS_PROT 0,HAS_QOS 0,HAS_REGION 0";
  attribute X_INTERFACE_INFO of s_axi_awlen : signal is "xilinx.com:interface:aximm:1.0 s_axi AWLEN";
  attribute X_INTERFACE_INFO of s_axi_awsize : signal is "xilinx.com:interface:aximm:1.0 s_axi AWSIZE";
  attribute X_INTERFACE_INFO of s_axi_bid : signal is "xilinx.com:interface:aximm:1.0 s_axi BID";
  attribute X_INTERFACE_INFO of s_axi_bresp : signal is "xilinx.com:interface:aximm:1.0 s_axi BRESP";
  attribute X_INTERFACE_INFO of s_axi_rdata : signal is "xilinx.com:interface:aximm:1.0 s_axi RDATA";
  attribute X_INTERFACE_INFO of s_axi_rid : signal is "xilinx.com:interface:aximm:1.0 s_axi RID";
  attribute X_INTERFACE_INFO of s_axi_rresp : signal is "xilinx.com:interface:aximm:1.0 s_axi RRESP";
  attribute X_INTERFACE_INFO of s_axi_wdata : signal is "xilinx.com:interface:aximm:1.0 s_axi WDATA";
  attribute X_INTERFACE_INFO of s_axi_wid : signal is "xilinx.com:interface:aximm:1.0 s_axi WID";
  attribute X_INTERFACE_INFO of s_axi_wstrb : signal is "xilinx.com:interface:aximm:1.0 s_axi WSTRB";
begin
  M0_APB_PADDR(31 downto 10) <= \^m0_apb_paddr\(31 downto 10);
  M0_APB_PADDR(9 downto 0) <= \^m2_apb_paddr\(9 downto 0);
  M0_APB_PENABLE <= \^m2_apb_penable\;
  M0_APB_PSTRB(3 downto 0) <= \^m2_apb_pstrb\(3 downto 0);
  M0_APB_PWDATA(31 downto 0) <= \^m2_apb_pwdata\(31 downto 0);
  M0_APB_PWRITE <= \^m2_apb_pwrite\;
  M1_APB_PADDR(31 downto 10) <= \^m0_apb_paddr\(31 downto 10);
  M1_APB_PADDR(9 downto 0) <= \^m2_apb_paddr\(9 downto 0);
  M1_APB_PENABLE <= \^m2_apb_penable\;
  M1_APB_PSTRB(3 downto 0) <= \^m2_apb_pstrb\(3 downto 0);
  M1_APB_PWDATA(31 downto 0) <= \^m2_apb_pwdata\(31 downto 0);
  M1_APB_PWRITE <= \^m2_apb_pwrite\;
  M2_APB_PADDR(31 downto 10) <= \^m0_apb_paddr\(31 downto 10);
  M2_APB_PADDR(9 downto 0) <= \^m2_apb_paddr\(9 downto 0);
  M2_APB_PENABLE <= \^m2_apb_penable\;
  M2_APB_PSTRB(3 downto 0) <= \^m2_apb_pstrb\(3 downto 0);
  M2_APB_PWDATA(31 downto 0) <= \^m2_apb_pwdata\(31 downto 0);
  M2_APB_PWRITE <= \^m2_apb_pwrite\;
  s_axi_bresp(1) <= \^s_axi_bresp\(1);
  s_axi_bresp(0) <= \<const0>\;
GND: unisim.vcomponents.GND
     port map (
      G => \<const0>\
    );
inst: entity work.design_zed_axi4_to_apb4_s3_0_0_axi4_to_apb4_s3
     port map (
      M0_APB_PADDR(31 downto 10) => \^m0_apb_paddr\(31 downto 10),
      M0_APB_PADDR(9 downto 0) => \^m2_apb_paddr\(9 downto 0),
      M0_APB_PRDATA(31 downto 0) => M0_APB_PRDATA(31 downto 0),
      M0_APB_PREADY => M0_APB_PREADY,
      M0_APB_PSEL => M0_APB_PSEL,
      M1_APB_PRDATA(31 downto 0) => M1_APB_PRDATA(31 downto 0),
      M1_APB_PREADY => M1_APB_PREADY,
      M2_APB_PENABLE => \^m2_apb_penable\,
      M2_APB_PRDATA(31 downto 0) => M2_APB_PRDATA(31 downto 0),
      M2_APB_PREADY => M2_APB_PREADY,
      M2_APB_PSTRB(3 downto 0) => \^m2_apb_pstrb\(3 downto 0),
      M2_APB_PWDATA(31 downto 0) => \^m2_apb_pwdata\(31 downto 0),
      M2_APB_PWRITE => \^m2_apb_pwrite\,
      \M_PADDR_reg[12]\ => M1_APB_PSEL,
      \M_PADDR_reg[13]\ => M2_APB_PSEL,
      PCLK => PCLK,
      PRESETn => PRESETn,
      axi_aclk => axi_aclk,
      axi_aresetn => axi_aresetn,
      s_axi_araddr(31 downto 0) => s_axi_araddr(31 downto 0),
      s_axi_arburst(1 downto 0) => s_axi_arburst(1 downto 0),
      s_axi_arid(3 downto 0) => s_axi_arid(3 downto 0),
      s_axi_arlen(7 downto 0) => s_axi_arlen(7 downto 0),
      s_axi_arready => s_axi_arready,
      s_axi_arsize(2 downto 0) => s_axi_arsize(2 downto 0),
      s_axi_arvalid => s_axi_arvalid,
      s_axi_awaddr(31 downto 0) => s_axi_awaddr(31 downto 0),
      s_axi_awburst(1 downto 0) => s_axi_awburst(1 downto 0),
      s_axi_awid(3 downto 0) => s_axi_awid(3 downto 0),
      s_axi_awlen(7 downto 0) => s_axi_awlen(7 downto 0),
      s_axi_awready => s_axi_awready,
      s_axi_awsize(2 downto 0) => s_axi_awsize(2 downto 0),
      s_axi_awvalid => s_axi_awvalid,
      s_axi_bid(3 downto 0) => s_axi_bid(3 downto 0),
      s_axi_bready => s_axi_bready,
      s_axi_bresp(0) => \^s_axi_bresp\(1),
      s_axi_bvalid => s_axi_bvalid,
      s_axi_rdata(31 downto 0) => s_axi_rdata(31 downto 0),
      s_axi_rid(3 downto 0) => s_axi_rid(3 downto 0),
      s_axi_rlast => s_axi_rlast,
      s_axi_rready => s_axi_rready,
      s_axi_rresp(1 downto 0) => s_axi_rresp(1 downto 0),
      s_axi_rvalid => s_axi_rvalid,
      s_axi_wdata(31 downto 0) => s_axi_wdata(31 downto 0),
      s_axi_wid(3 downto 0) => s_axi_wid(3 downto 0),
      s_axi_wlast => s_axi_wlast,
      s_axi_wready => s_axi_wready,
      s_axi_wstrb(3 downto 0) => s_axi_wstrb(3 downto 0),
      s_axi_wvalid => s_axi_wvalid
    );
end STRUCTURE;
