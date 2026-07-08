// (c) Copyright 1995-2026 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: xilinx.com:module_ref:axi4_to_apb4_s3:1.0
// IP Revision: 1

(* X_CORE_INFO = "axi4_to_apb4_s3,Vivado 2020.2" *)
(* CHECK_LICENSE_TYPE = "design_zed_axi4_to_apb4_s3_0_0,axi4_to_apb4_s3,{}" *)
(* CORE_GENERATION_INFO = "design_zed_axi4_to_apb4_s3_0_0,axi4_to_apb4_s3,{x_ipProduct=Vivado 2020.2,x_ipVendor=xilinx.com,x_ipLibrary=module_ref,x_ipName=axi4_to_apb4_s3,x_ipVersion=1.0,x_ipCoreRevision=1,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,AXI_WIDTH_ID=4,AXI_WIDTH_ADDR=32,AXI_WIDTH_DATA=32,AXI_WIDTH_STRB=4,NUM_PSLAVE=3,WIDTH_PAD=32,WIDTH_PDA=32,WIDTH_PDS=4,ADDR_PBASE0=0x60000000,PSIZE0=0x00000400,ADDR_PBASE1=0x60001000,PSIZE1=0x00000400,ADDR_PBASE2=0x60002000,PSIZE2=0x00000400,CLOCK_SYNC=SYNC}" *)
(* IP_DEFINITION_SOURCE = "module_ref" *)
(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_zed_axi4_to_apb4_s3_0_0 (
  axi_aresetn,
  axi_aclk,
  s_axi_awid,
  s_axi_awaddr,
  s_axi_awlen,
  s_axi_awsize,
  s_axi_awburst,
  s_axi_awvalid,
  s_axi_awready,
  s_axi_wid,
  s_axi_wdata,
  s_axi_wstrb,
  s_axi_wlast,
  s_axi_wvalid,
  s_axi_wready,
  s_axi_bid,
  s_axi_bresp,
  s_axi_bvalid,
  s_axi_bready,
  s_axi_arid,
  s_axi_araddr,
  s_axi_arlen,
  s_axi_arsize,
  s_axi_arburst,
  s_axi_arvalid,
  s_axi_arready,
  s_axi_rid,
  s_axi_rdata,
  s_axi_rresp,
  s_axi_rlast,
  s_axi_rvalid,
  s_axi_rready,
  PRESETn,
  PCLK,
  M0_APB_PADDR,
  M0_APB_PENABLE,
  M0_APB_PWRITE,
  M0_APB_PWDATA,
  M0_APB_PSEL,
  M0_APB_PRDATA,
  M0_APB_PREADY,
  M0_APB_PSLVERR,
  M0_APB_PSTRB,
  M1_APB_PADDR,
  M1_APB_PENABLE,
  M1_APB_PWRITE,
  M1_APB_PWDATA,
  M1_APB_PSEL,
  M1_APB_PRDATA,
  M1_APB_PREADY,
  M1_APB_PSLVERR,
  M1_APB_PSTRB,
  M2_APB_PADDR,
  M2_APB_PENABLE,
  M2_APB_PWRITE,
  M2_APB_PWDATA,
  M2_APB_PSEL,
  M2_APB_PRDATA,
  M2_APB_PREADY,
  M2_APB_PSLVERR,
  M2_APB_PSTRB
);

(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 axi_aresetn RST" *)
input wire axi_aresetn;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_aclk, ASSOCIATED_BUSIF s_axi:m_axil, ASSOCIATED_RESET axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 axi_aclk CLK" *)
input wire axi_aclk;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWID" *)
input wire [3 : 0] s_axi_awid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *)
input wire [31 : 0] s_axi_awaddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWLEN" *)
input wire [7 : 0] s_axi_awlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWSIZE" *)
input wire [2 : 0] s_axi_awsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWBURST" *)
input wire [1 : 0] s_axi_awburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *)
input wire s_axi_awvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *)
output wire s_axi_awready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WID" *)
input wire [3 : 0] s_axi_wid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *)
input wire [31 : 0] s_axi_wdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *)
input wire [3 : 0] s_axi_wstrb;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WLAST" *)
input wire s_axi_wlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *)
input wire s_axi_wvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *)
output wire s_axi_wready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BID" *)
output wire [3 : 0] s_axi_bid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *)
output wire [1 : 0] s_axi_bresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *)
output wire s_axi_bvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *)
input wire s_axi_bready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARID" *)
input wire [3 : 0] s_axi_arid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *)
input wire [31 : 0] s_axi_araddr;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARLEN" *)
input wire [7 : 0] s_axi_arlen;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARSIZE" *)
input wire [2 : 0] s_axi_arsize;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARBURST" *)
input wire [1 : 0] s_axi_arburst;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *)
input wire s_axi_arvalid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *)
output wire s_axi_arready;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RID" *)
output wire [3 : 0] s_axi_rid;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *)
output wire [31 : 0] s_axi_rdata;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *)
output wire [1 : 0] s_axi_rresp;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RLAST" *)
output wire s_axi_rlast;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *)
output wire s_axi_rvalid;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, ASSOCIATED_BUSIF s_axi:m_axil, ASSOCIATED_RESET axi_aresetn, RUSER_WIDTH 0, WUSER_WIDTH 0, ARUSER_WIDTH 0, AWUSER_WIDTH 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 0, HAS_QOS 0, HAS_REGION 0, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 4, ADDR_WIDTH 32, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.000, CLK_DOMAIN\
 design_zed_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *)
input wire s_axi_rready;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME PRESETn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 PRESETn RST" *)
input wire PRESETn;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME PCLK, ASSOCIATED_RESET PRESETn, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *)
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PCLK CLK" *)
input wire PCLK;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PADDR" *)
output wire [31 : 0] M0_APB_PADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PENABLE" *)
output wire M0_APB_PENABLE;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PWRITE" *)
output wire M0_APB_PWRITE;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PWDATA" *)
output wire [31 : 0] M0_APB_PWDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PSEL" *)
output wire M0_APB_PSEL;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PRDATA" *)
input wire [31 : 0] M0_APB_PRDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PREADY" *)
input wire M0_APB_PREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PSLVERR" *)
input wire M0_APB_PSLVERR;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M0_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PSTRB" *)
output wire [3 : 0] M0_APB_PSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PADDR" *)
output wire [31 : 0] M1_APB_PADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PENABLE" *)
output wire M1_APB_PENABLE;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PWRITE" *)
output wire M1_APB_PWRITE;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PWDATA" *)
output wire [31 : 0] M1_APB_PWDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PSEL" *)
output wire M1_APB_PSEL;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PRDATA" *)
input wire [31 : 0] M1_APB_PRDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PREADY" *)
input wire M1_APB_PREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PSLVERR" *)
input wire M1_APB_PSLVERR;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M1_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PSTRB" *)
output wire [3 : 0] M1_APB_PSTRB;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PADDR" *)
output wire [31 : 0] M2_APB_PADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PENABLE" *)
output wire M2_APB_PENABLE;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PWRITE" *)
output wire M2_APB_PWRITE;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PWDATA" *)
output wire [31 : 0] M2_APB_PWDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PSEL" *)
output wire M2_APB_PSEL;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PRDATA" *)
input wire [31 : 0] M2_APB_PRDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PREADY" *)
input wire M2_APB_PREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PSLVERR" *)
input wire M2_APB_PSLVERR;
(* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M2_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn" *)
(* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PSTRB" *)
output wire [3 : 0] M2_APB_PSTRB;

  axi4_to_apb4_s3 #(
    .AXI_WIDTH_ID(4),
    .AXI_WIDTH_ADDR(32),
    .AXI_WIDTH_DATA(32),
    .AXI_WIDTH_STRB(4),
    .NUM_PSLAVE(3),
    .WIDTH_PAD(32),
    .WIDTH_PDA(32),
    .WIDTH_PDS(4),
    .ADDR_PBASE0(32'H60000000),
    .PSIZE0(32'H00000400),
    .ADDR_PBASE1(32'H60001000),
    .PSIZE1(32'H00000400),
    .ADDR_PBASE2(32'H60002000),
    .PSIZE2(32'H00000400),
    .CLOCK_SYNC("SYNC")
  ) inst (
    .axi_aresetn(axi_aresetn),
    .axi_aclk(axi_aclk),
    .s_axi_awid(s_axi_awid),
    .s_axi_awaddr(s_axi_awaddr),
    .s_axi_awlen(s_axi_awlen),
    .s_axi_awsize(s_axi_awsize),
    .s_axi_awburst(s_axi_awburst),
    .s_axi_awvalid(s_axi_awvalid),
    .s_axi_awready(s_axi_awready),
    .s_axi_wid(s_axi_wid),
    .s_axi_wdata(s_axi_wdata),
    .s_axi_wstrb(s_axi_wstrb),
    .s_axi_wlast(s_axi_wlast),
    .s_axi_wvalid(s_axi_wvalid),
    .s_axi_wready(s_axi_wready),
    .s_axi_bid(s_axi_bid),
    .s_axi_bresp(s_axi_bresp),
    .s_axi_bvalid(s_axi_bvalid),
    .s_axi_bready(s_axi_bready),
    .s_axi_arid(s_axi_arid),
    .s_axi_araddr(s_axi_araddr),
    .s_axi_arlen(s_axi_arlen),
    .s_axi_arsize(s_axi_arsize),
    .s_axi_arburst(s_axi_arburst),
    .s_axi_arvalid(s_axi_arvalid),
    .s_axi_arready(s_axi_arready),
    .s_axi_rid(s_axi_rid),
    .s_axi_rdata(s_axi_rdata),
    .s_axi_rresp(s_axi_rresp),
    .s_axi_rlast(s_axi_rlast),
    .s_axi_rvalid(s_axi_rvalid),
    .s_axi_rready(s_axi_rready),
    .PRESETn(PRESETn),
    .PCLK(PCLK),
    .M0_APB_PADDR(M0_APB_PADDR),
    .M0_APB_PENABLE(M0_APB_PENABLE),
    .M0_APB_PWRITE(M0_APB_PWRITE),
    .M0_APB_PWDATA(M0_APB_PWDATA),
    .M0_APB_PSEL(M0_APB_PSEL),
    .M0_APB_PRDATA(M0_APB_PRDATA),
    .M0_APB_PREADY(M0_APB_PREADY),
    .M0_APB_PSLVERR(M0_APB_PSLVERR),
    .M0_APB_PSTRB(M0_APB_PSTRB),
    .M1_APB_PADDR(M1_APB_PADDR),
    .M1_APB_PENABLE(M1_APB_PENABLE),
    .M1_APB_PWRITE(M1_APB_PWRITE),
    .M1_APB_PWDATA(M1_APB_PWDATA),
    .M1_APB_PSEL(M1_APB_PSEL),
    .M1_APB_PRDATA(M1_APB_PRDATA),
    .M1_APB_PREADY(M1_APB_PREADY),
    .M1_APB_PSLVERR(M1_APB_PSLVERR),
    .M1_APB_PSTRB(M1_APB_PSTRB),
    .M2_APB_PADDR(M2_APB_PADDR),
    .M2_APB_PENABLE(M2_APB_PENABLE),
    .M2_APB_PWRITE(M2_APB_PWRITE),
    .M2_APB_PWDATA(M2_APB_PWDATA),
    .M2_APB_PSEL(M2_APB_PSEL),
    .M2_APB_PRDATA(M2_APB_PRDATA),
    .M2_APB_PREADY(M2_APB_PREADY),
    .M2_APB_PSLVERR(M2_APB_PSLVERR),
    .M2_APB_PSTRB(M2_APB_PSTRB)
  );
endmodule
