-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Wed Jul  8 12:07:54 2026
-- Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/user/Documents/JH/week
--               3/07_08/ex_mem_apb_zedboard/hw/impl.zed/project_zed/project_zed.gen/sources_1/bd/design_zed/ip/design_zed_axi4_to_apb4_s3_0_0/design_zed_axi4_to_apb4_s3_0_0_stub.vhdl}
-- Design      : design_zed_axi4_to_apb4_s3_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_zed_axi4_to_apb4_s3_0_0 is
  Port ( 
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

end design_zed_axi4_to_apb4_s3_0_0;

architecture stub of design_zed_axi4_to_apb4_s3_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "axi_aresetn,axi_aclk,s_axi_awid[3:0],s_axi_awaddr[31:0],s_axi_awlen[7:0],s_axi_awsize[2:0],s_axi_awburst[1:0],s_axi_awvalid,s_axi_awready,s_axi_wid[3:0],s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wlast,s_axi_wvalid,s_axi_wready,s_axi_bid[3:0],s_axi_bresp[1:0],s_axi_bvalid,s_axi_bready,s_axi_arid[3:0],s_axi_araddr[31:0],s_axi_arlen[7:0],s_axi_arsize[2:0],s_axi_arburst[1:0],s_axi_arvalid,s_axi_arready,s_axi_rid[3:0],s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rlast,s_axi_rvalid,s_axi_rready,PRESETn,PCLK,M0_APB_PADDR[31:0],M0_APB_PENABLE,M0_APB_PWRITE,M0_APB_PWDATA[31:0],M0_APB_PSEL,M0_APB_PRDATA[31:0],M0_APB_PREADY,M0_APB_PSLVERR,M0_APB_PSTRB[3:0],M1_APB_PADDR[31:0],M1_APB_PENABLE,M1_APB_PWRITE,M1_APB_PWDATA[31:0],M1_APB_PSEL,M1_APB_PRDATA[31:0],M1_APB_PREADY,M1_APB_PSLVERR,M1_APB_PSTRB[3:0],M2_APB_PADDR[31:0],M2_APB_PENABLE,M2_APB_PWRITE,M2_APB_PWDATA[31:0],M2_APB_PSEL,M2_APB_PRDATA[31:0],M2_APB_PREADY,M2_APB_PSLVERR,M2_APB_PSTRB[3:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "axi4_to_apb4_s3,Vivado 2020.2";
begin
end;
