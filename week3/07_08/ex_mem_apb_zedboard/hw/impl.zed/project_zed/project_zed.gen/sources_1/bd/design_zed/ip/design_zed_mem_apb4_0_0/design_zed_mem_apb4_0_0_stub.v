// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Jul  8 12:08:13 2026
// Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/user/Documents/JH/week
//               3/07_08/ex_mem_apb_zedboard/hw/impl.zed/project_zed/project_zed.gen/sources_1/bd/design_zed/ip/design_zed_mem_apb4_0_0/design_zed_mem_apb4_0_0_stub.v}
// Design      : design_zed_mem_apb4_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "mem_apb4,Vivado 2020.2" *)
module design_zed_mem_apb4_0_0(PRESETn, PCLK, S_APB_PSEL, S_APB_PENABLE, 
  S_APB_PADDR, S_APB_PWRITE, S_APB_PWDATA, S_APB_PRDATA, S_APB_PREADY, S_APB_PSLVERR, 
  S_APB_PSTRB)
/* synthesis syn_black_box black_box_pad_pin="PRESETn,PCLK,S_APB_PSEL,S_APB_PENABLE,S_APB_PADDR[31:0],S_APB_PWRITE,S_APB_PWDATA[31:0],S_APB_PRDATA[31:0],S_APB_PREADY,S_APB_PSLVERR,S_APB_PSTRB[3:0]" */;
  input PRESETn;
  input PCLK;
  input S_APB_PSEL;
  input S_APB_PENABLE;
  input [31:0]S_APB_PADDR;
  input S_APB_PWRITE;
  input [31:0]S_APB_PWDATA;
  output [31:0]S_APB_PRDATA;
  output S_APB_PREADY;
  output S_APB_PSLVERR;
  input [3:0]S_APB_PSTRB;
endmodule
