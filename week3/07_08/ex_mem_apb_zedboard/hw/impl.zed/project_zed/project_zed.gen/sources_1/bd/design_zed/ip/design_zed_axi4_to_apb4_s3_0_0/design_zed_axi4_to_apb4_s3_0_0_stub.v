// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Jul  8 12:07:54 2026
// Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/user/Documents/JH/week
//               3/07_08/ex_mem_apb_zedboard/hw/impl.zed/project_zed/project_zed.gen/sources_1/bd/design_zed/ip/design_zed_axi4_to_apb4_s3_0_0/design_zed_axi4_to_apb4_s3_0_0_stub.v}
// Design      : design_zed_axi4_to_apb4_s3_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "axi4_to_apb4_s3,Vivado 2020.2" *)
module design_zed_axi4_to_apb4_s3_0_0(axi_aresetn, axi_aclk, s_axi_awid, 
  s_axi_awaddr, s_axi_awlen, s_axi_awsize, s_axi_awburst, s_axi_awvalid, s_axi_awready, 
  s_axi_wid, s_axi_wdata, s_axi_wstrb, s_axi_wlast, s_axi_wvalid, s_axi_wready, s_axi_bid, 
  s_axi_bresp, s_axi_bvalid, s_axi_bready, s_axi_arid, s_axi_araddr, s_axi_arlen, s_axi_arsize, 
  s_axi_arburst, s_axi_arvalid, s_axi_arready, s_axi_rid, s_axi_rdata, s_axi_rresp, 
  s_axi_rlast, s_axi_rvalid, s_axi_rready, PRESETn, PCLK, M0_APB_PADDR, M0_APB_PENABLE, 
  M0_APB_PWRITE, M0_APB_PWDATA, M0_APB_PSEL, M0_APB_PRDATA, M0_APB_PREADY, M0_APB_PSLVERR, 
  M0_APB_PSTRB, M1_APB_PADDR, M1_APB_PENABLE, M1_APB_PWRITE, M1_APB_PWDATA, M1_APB_PSEL, 
  M1_APB_PRDATA, M1_APB_PREADY, M1_APB_PSLVERR, M1_APB_PSTRB, M2_APB_PADDR, M2_APB_PENABLE, 
  M2_APB_PWRITE, M2_APB_PWDATA, M2_APB_PSEL, M2_APB_PRDATA, M2_APB_PREADY, M2_APB_PSLVERR, 
  M2_APB_PSTRB)
/* synthesis syn_black_box black_box_pad_pin="axi_aresetn,axi_aclk,s_axi_awid[3:0],s_axi_awaddr[31:0],s_axi_awlen[7:0],s_axi_awsize[2:0],s_axi_awburst[1:0],s_axi_awvalid,s_axi_awready,s_axi_wid[3:0],s_axi_wdata[31:0],s_axi_wstrb[3:0],s_axi_wlast,s_axi_wvalid,s_axi_wready,s_axi_bid[3:0],s_axi_bresp[1:0],s_axi_bvalid,s_axi_bready,s_axi_arid[3:0],s_axi_araddr[31:0],s_axi_arlen[7:0],s_axi_arsize[2:0],s_axi_arburst[1:0],s_axi_arvalid,s_axi_arready,s_axi_rid[3:0],s_axi_rdata[31:0],s_axi_rresp[1:0],s_axi_rlast,s_axi_rvalid,s_axi_rready,PRESETn,PCLK,M0_APB_PADDR[31:0],M0_APB_PENABLE,M0_APB_PWRITE,M0_APB_PWDATA[31:0],M0_APB_PSEL,M0_APB_PRDATA[31:0],M0_APB_PREADY,M0_APB_PSLVERR,M0_APB_PSTRB[3:0],M1_APB_PADDR[31:0],M1_APB_PENABLE,M1_APB_PWRITE,M1_APB_PWDATA[31:0],M1_APB_PSEL,M1_APB_PRDATA[31:0],M1_APB_PREADY,M1_APB_PSLVERR,M1_APB_PSTRB[3:0],M2_APB_PADDR[31:0],M2_APB_PENABLE,M2_APB_PWRITE,M2_APB_PWDATA[31:0],M2_APB_PSEL,M2_APB_PRDATA[31:0],M2_APB_PREADY,M2_APB_PSLVERR,M2_APB_PSTRB[3:0]" */;
  input axi_aresetn;
  input axi_aclk;
  input [3:0]s_axi_awid;
  input [31:0]s_axi_awaddr;
  input [7:0]s_axi_awlen;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input s_axi_awvalid;
  output s_axi_awready;
  input [3:0]s_axi_wid;
  input [31:0]s_axi_wdata;
  input [3:0]s_axi_wstrb;
  input s_axi_wlast;
  input s_axi_wvalid;
  output s_axi_wready;
  output [3:0]s_axi_bid;
  output [1:0]s_axi_bresp;
  output s_axi_bvalid;
  input s_axi_bready;
  input [3:0]s_axi_arid;
  input [31:0]s_axi_araddr;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input s_axi_arvalid;
  output s_axi_arready;
  output [3:0]s_axi_rid;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output s_axi_rlast;
  output s_axi_rvalid;
  input s_axi_rready;
  input PRESETn;
  input PCLK;
  output [31:0]M0_APB_PADDR;
  output M0_APB_PENABLE;
  output M0_APB_PWRITE;
  output [31:0]M0_APB_PWDATA;
  output M0_APB_PSEL;
  input [31:0]M0_APB_PRDATA;
  input M0_APB_PREADY;
  input M0_APB_PSLVERR;
  output [3:0]M0_APB_PSTRB;
  output [31:0]M1_APB_PADDR;
  output M1_APB_PENABLE;
  output M1_APB_PWRITE;
  output [31:0]M1_APB_PWDATA;
  output M1_APB_PSEL;
  input [31:0]M1_APB_PRDATA;
  input M1_APB_PREADY;
  input M1_APB_PSLVERR;
  output [3:0]M1_APB_PSTRB;
  output [31:0]M2_APB_PADDR;
  output M2_APB_PENABLE;
  output M2_APB_PWRITE;
  output [31:0]M2_APB_PWDATA;
  output M2_APB_PSEL;
  input [31:0]M2_APB_PRDATA;
  input M2_APB_PREADY;
  input M2_APB_PSLVERR;
  output [3:0]M2_APB_PSTRB;
endmodule
