-- Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
-- Date        : Wed Jul  8 12:08:13 2026
-- Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {c:/Users/user/Documents/JH/week
--               3/07_08/ex_mem_apb_zedboard/hw/impl.zed/project_zed/project_zed.gen/sources_1/bd/design_zed/ip/design_zed_mem_apb4_2_0/design_zed_mem_apb4_2_0_stub.vhdl}
-- Design      : design_zed_mem_apb4_2_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_zed_mem_apb4_2_0 is
  Port ( 
    PRESETn : in STD_LOGIC;
    PCLK : in STD_LOGIC;
    S_APB_PSEL : in STD_LOGIC;
    S_APB_PENABLE : in STD_LOGIC;
    S_APB_PADDR : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_APB_PWRITE : in STD_LOGIC;
    S_APB_PWDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    S_APB_PRDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    S_APB_PREADY : out STD_LOGIC;
    S_APB_PSLVERR : out STD_LOGIC;
    S_APB_PSTRB : in STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end design_zed_mem_apb4_2_0;

architecture stub of design_zed_mem_apb4_2_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "PRESETn,PCLK,S_APB_PSEL,S_APB_PENABLE,S_APB_PADDR[31:0],S_APB_PWRITE,S_APB_PWDATA[31:0],S_APB_PRDATA[31:0],S_APB_PREADY,S_APB_PSLVERR,S_APB_PSTRB[3:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "mem_apb4,Vivado 2020.2";
begin
end;
