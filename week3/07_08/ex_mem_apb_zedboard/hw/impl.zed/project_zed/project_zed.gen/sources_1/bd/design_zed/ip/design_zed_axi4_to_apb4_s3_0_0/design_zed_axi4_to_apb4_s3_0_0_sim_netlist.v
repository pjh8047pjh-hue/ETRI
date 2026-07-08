// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.2 (win64) Build 3064766 Wed Nov 18 09:12:45 MST 2020
// Date        : Wed Jul  8 12:07:54 2026
// Host        : DESKTOP-DLOB77A running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim {c:/Users/user/Documents/JH/week
//               3/07_08/ex_mem_apb_zedboard/hw/impl.zed/project_zed/project_zed.gen/sources_1/bd/design_zed/ip/design_zed_axi4_to_apb4_s3_0_0/design_zed_axi4_to_apb4_s3_0_0_sim_netlist.v}
// Design      : design_zed_axi4_to_apb4_s3_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "design_zed_axi4_to_apb4_s3_0_0,axi4_to_apb4_s3,{}" *) (* DowngradeIPIdentifiedWarnings = "yes" *) (* IP_DEFINITION_SOURCE = "module_ref" *) 
(* X_CORE_INFO = "axi4_to_apb4_s3,Vivado 2020.2" *) 
(* NotValidForBitStream *)
module design_zed_axi4_to_apb4_s3_0_0
   (axi_aresetn,
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
    M2_APB_PSTRB);
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 axi_aresetn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_aresetn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input axi_aresetn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 axi_aclk CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME axi_aclk, ASSOCIATED_BUSIF s_axi:m_axil, ASSOCIATED_RESET axi_aresetn, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input axi_aclk;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWID" *) (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axi,ASSOCIATED_RESET axi_aresetn,CLK_DOMAIN axi_aclk,                                RUSER_WIDTH 0,WUSER_WIDTH 0,ARUSER_WIDTH 0,AWUSER_WIDTH 0,                                HAS_CACHE 0,HAS_LOCK 0,HAS_PROT 0,HAS_QOS 0,HAS_REGION 0" *) input [3:0]s_axi_awid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR" *) input [31:0]s_axi_awaddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWLEN" *) input [7:0]s_axi_awlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWSIZE" *) input [2:0]s_axi_awsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWBURST" *) input [1:0]s_axi_awburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input s_axi_awvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output s_axi_awready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WID" *) input [3:0]s_axi_wid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA" *) input [31:0]s_axi_wdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB" *) input [3:0]s_axi_wstrb;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WLAST" *) input s_axi_wlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID" *) input s_axi_wvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY" *) output s_axi_wready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BID" *) output [3:0]s_axi_bid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP" *) output [1:0]s_axi_bresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID" *) output s_axi_bvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY" *) input s_axi_bready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARID" *) input [3:0]s_axi_arid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR" *) input [31:0]s_axi_araddr;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARLEN" *) input [7:0]s_axi_arlen;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARSIZE" *) input [2:0]s_axi_arsize;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARBURST" *) input [1:0]s_axi_arburst;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input s_axi_arvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output s_axi_arready;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RID" *) output [3:0]s_axi_rid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA" *) output [31:0]s_axi_rdata;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP" *) output [1:0]s_axi_rresp;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RLAST" *) output s_axi_rlast;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID" *) output s_axi_rvalid;
  (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME s_axi, ASSOCIATED_BUSIF s_axi:m_axil, ASSOCIATED_RESET axi_aresetn, RUSER_WIDTH 0, WUSER_WIDTH 0, ARUSER_WIDTH 0, AWUSER_WIDTH 0, HAS_CACHE 0, HAS_LOCK 0, HAS_PROT 0, HAS_QOS 0, HAS_REGION 0, DATA_WIDTH 32, PROTOCOL AXI4, FREQ_HZ 100000000, ID_WIDTH 4, ADDR_WIDTH 32, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, NUM_READ_OUTSTANDING 2, NUM_WRITE_OUTSTANDING 2, MAX_BURST_LENGTH 256, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, NUM_READ_THREADS 1, NUM_WRITE_THREADS 1, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0, INSERT_VIP 0" *) input s_axi_rready;
  (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 PRESETn RST" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME PRESETn, POLARITY ACTIVE_LOW, INSERT_VIP 0" *) input PRESETn;
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PCLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME PCLK, ASSOCIATED_RESET PRESETn, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.000, CLK_DOMAIN design_zed_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input PCLK;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PADDR" *) output [31:0]M0_APB_PADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PENABLE" *) output M0_APB_PENABLE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PWRITE" *) output M0_APB_PWRITE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PWDATA" *) output [31:0]M0_APB_PWDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PSEL" *) output M0_APB_PSEL;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PRDATA" *) input [31:0]M0_APB_PRDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PREADY" *) input M0_APB_PREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PSLVERR" *) input M0_APB_PSLVERR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M0_APB PSTRB" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M0_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn" *) output [3:0]M0_APB_PSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PADDR" *) output [31:0]M1_APB_PADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PENABLE" *) output M1_APB_PENABLE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PWRITE" *) output M1_APB_PWRITE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PWDATA" *) output [31:0]M1_APB_PWDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PSEL" *) output M1_APB_PSEL;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PRDATA" *) input [31:0]M1_APB_PRDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PREADY" *) input M1_APB_PREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PSLVERR" *) input M1_APB_PSLVERR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M1_APB PSTRB" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M1_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn" *) output [3:0]M1_APB_PSTRB;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PADDR" *) output [31:0]M2_APB_PADDR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PENABLE" *) output M2_APB_PENABLE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PWRITE" *) output M2_APB_PWRITE;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PWDATA" *) output [31:0]M2_APB_PWDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PSEL" *) output M2_APB_PSEL;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PRDATA" *) input [31:0]M2_APB_PRDATA;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PREADY" *) input M2_APB_PREADY;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PSLVERR" *) input M2_APB_PSLVERR;
  (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 M2_APB PSTRB" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME M2_APB, ASSOCIATED_BUSIF M0_APB:M1_APB:M2_APB, ASSOCIATED_RESET PRESETn" *) output [3:0]M2_APB_PSTRB;

  wire \<const0> ;
  wire [31:10]\^M0_APB_PADDR ;
  wire [31:0]M0_APB_PRDATA;
  wire M0_APB_PREADY;
  wire M0_APB_PSEL;
  wire [31:0]M1_APB_PRDATA;
  wire M1_APB_PREADY;
  wire M1_APB_PSEL;
  wire [9:0]\^M2_APB_PADDR ;
  wire M2_APB_PENABLE;
  wire [31:0]M2_APB_PRDATA;
  wire M2_APB_PREADY;
  wire M2_APB_PSEL;
  wire [3:0]M2_APB_PSTRB;
  wire [31:0]M2_APB_PWDATA;
  wire M2_APB_PWRITE;
  wire PCLK;
  wire PRESETn;
  wire axi_aclk;
  wire axi_aresetn;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire [2:0]s_axi_awsize;
  wire s_axi_awvalid;
  wire [3:0]s_axi_bid;
  wire s_axi_bready;
  wire [1:1]\^s_axi_bresp ;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire [3:0]s_axi_rid;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire [3:0]s_axi_wid;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;

  assign M0_APB_PADDR[31:10] = \^M0_APB_PADDR [31:10];
  assign M0_APB_PADDR[9:0] = \^M2_APB_PADDR [9:0];
  assign M0_APB_PENABLE = M2_APB_PENABLE;
  assign M0_APB_PSTRB[3:0] = M2_APB_PSTRB;
  assign M0_APB_PWDATA[31:0] = M2_APB_PWDATA;
  assign M0_APB_PWRITE = M2_APB_PWRITE;
  assign M1_APB_PADDR[31:10] = \^M0_APB_PADDR [31:10];
  assign M1_APB_PADDR[9:0] = \^M2_APB_PADDR [9:0];
  assign M1_APB_PENABLE = M2_APB_PENABLE;
  assign M1_APB_PSTRB[3:0] = M2_APB_PSTRB;
  assign M1_APB_PWDATA[31:0] = M2_APB_PWDATA;
  assign M1_APB_PWRITE = M2_APB_PWRITE;
  assign M2_APB_PADDR[31:10] = \^M0_APB_PADDR [31:10];
  assign M2_APB_PADDR[9:0] = \^M2_APB_PADDR [9:0];
  assign s_axi_bresp[1] = \^s_axi_bresp [1];
  assign s_axi_bresp[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  design_zed_axi4_to_apb4_s3_0_0_axi4_to_apb4_s3 inst
       (.M0_APB_PADDR({\^M0_APB_PADDR ,\^M2_APB_PADDR }),
        .M0_APB_PRDATA(M0_APB_PRDATA),
        .M0_APB_PREADY(M0_APB_PREADY),
        .M0_APB_PSEL(M0_APB_PSEL),
        .M1_APB_PRDATA(M1_APB_PRDATA),
        .M1_APB_PREADY(M1_APB_PREADY),
        .M2_APB_PENABLE(M2_APB_PENABLE),
        .M2_APB_PRDATA(M2_APB_PRDATA),
        .M2_APB_PREADY(M2_APB_PREADY),
        .M2_APB_PSTRB(M2_APB_PSTRB),
        .M2_APB_PWDATA(M2_APB_PWDATA),
        .M2_APB_PWRITE(M2_APB_PWRITE),
        .\M_PADDR_reg[12] (M1_APB_PSEL),
        .\M_PADDR_reg[13] (M2_APB_PSEL),
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .axi_aclk(axi_aclk),
        .axi_aresetn(axi_aresetn),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arid(s_axi_arid),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arready(s_axi_arready),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awid(s_axi_awid),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awready(s_axi_awready),
        .s_axi_awsize(s_axi_awsize),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bid(s_axi_bid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(\^s_axi_bresp ),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rid(s_axi_rid),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wid(s_axi_wid),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "axi4_to_apb4_s3" *) 
module design_zed_axi4_to_apb4_s3_0_0_axi4_to_apb4_s3
   (s_axi_bid,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    M0_APB_PADDR,
    M2_APB_PWDATA,
    M2_APB_PSTRB,
    \M_PADDR_reg[13] ,
    \M_PADDR_reg[12] ,
    M0_APB_PSEL,
    s_axi_bvalid,
    M2_APB_PWRITE,
    s_axi_awready,
    s_axi_wready,
    s_axi_bresp,
    s_axi_arready,
    s_axi_rlast,
    s_axi_rvalid,
    M2_APB_PENABLE,
    s_axi_awvalid,
    s_axi_arvalid,
    PCLK,
    s_axi_rready,
    axi_aclk,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_wstrb,
    s_axi_awlen,
    s_axi_awid,
    s_axi_arid,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awaddr,
    s_axi_wdata,
    M2_APB_PREADY,
    M0_APB_PREADY,
    M1_APB_PREADY,
    M0_APB_PRDATA,
    M1_APB_PRDATA,
    M2_APB_PRDATA,
    s_axi_bready,
    s_axi_wvalid,
    s_axi_araddr,
    s_axi_wlast,
    s_axi_wid,
    axi_aresetn,
    PRESETn);
  output [3:0]s_axi_bid;
  output [3:0]s_axi_rid;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output [31:0]M0_APB_PADDR;
  output [31:0]M2_APB_PWDATA;
  output [3:0]M2_APB_PSTRB;
  output \M_PADDR_reg[13] ;
  output \M_PADDR_reg[12] ;
  output M0_APB_PSEL;
  output s_axi_bvalid;
  output M2_APB_PWRITE;
  output s_axi_awready;
  output s_axi_wready;
  output [0:0]s_axi_bresp;
  output s_axi_arready;
  output s_axi_rlast;
  output s_axi_rvalid;
  output M2_APB_PENABLE;
  input s_axi_awvalid;
  input s_axi_arvalid;
  input PCLK;
  input s_axi_rready;
  input axi_aclk;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input [3:0]s_axi_wstrb;
  input [7:0]s_axi_awlen;
  input [3:0]s_axi_awid;
  input [3:0]s_axi_arid;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [31:0]s_axi_awaddr;
  input [31:0]s_axi_wdata;
  input M2_APB_PREADY;
  input M0_APB_PREADY;
  input M1_APB_PREADY;
  input [31:0]M0_APB_PRDATA;
  input [31:0]M1_APB_PRDATA;
  input [31:0]M2_APB_PRDATA;
  input s_axi_bready;
  input s_axi_wvalid;
  input [31:0]s_axi_araddr;
  input s_axi_wlast;
  input [3:0]s_axi_wid;
  input axi_aresetn;
  input PRESETn;

  wire [31:0]M0_APB_PADDR;
  wire [31:0]M0_APB_PRDATA;
  wire M0_APB_PREADY;
  wire M0_APB_PSEL;
  wire [31:0]M1_APB_PRDATA;
  wire M1_APB_PREADY;
  wire M2_APB_PENABLE;
  wire [31:0]M2_APB_PRDATA;
  wire M2_APB_PREADY;
  wire [3:0]M2_APB_PSTRB;
  wire [31:0]M2_APB_PWDATA;
  wire M2_APB_PWRITE;
  wire \M_PADDR_reg[12] ;
  wire \M_PADDR_reg[13] ;
  wire PCLK;
  wire PRESETn;
  wire axi_aclk;
  wire axi_aresetn;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire [2:0]s_axi_awsize;
  wire s_axi_awvalid;
  wire [3:0]s_axi_bid;
  wire s_axi_bready;
  wire [0:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire [3:0]s_axi_rid;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire [3:0]s_axi_wid;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;

  design_zed_axi4_to_apb4_s3_0_0_axi_to_apb_bridge u_bridge
       (.M0_APB_PADDR(M0_APB_PADDR),
        .M0_APB_PRDATA(M0_APB_PRDATA),
        .M0_APB_PREADY(M0_APB_PREADY),
        .M0_APB_PSEL(M0_APB_PSEL),
        .M1_APB_PRDATA(M1_APB_PRDATA),
        .M1_APB_PREADY(M1_APB_PREADY),
        .M2_APB_PENABLE(M2_APB_PENABLE),
        .M2_APB_PRDATA(M2_APB_PRDATA),
        .M2_APB_PREADY(M2_APB_PREADY),
        .M2_APB_PSTRB(M2_APB_PSTRB),
        .M2_APB_PWDATA(M2_APB_PWDATA),
        .M2_APB_PWRITE(M2_APB_PWRITE),
        .\M_PADDR_reg[12]_0 (\M_PADDR_reg[12] ),
        .\M_PADDR_reg[13]_0 (\M_PADDR_reg[13] ),
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .axi_aclk(axi_aclk),
        .axi_aresetn(axi_aresetn),
        .s_axi_araddr(s_axi_araddr),
        .s_axi_arburst(s_axi_arburst),
        .s_axi_arid(s_axi_arid),
        .s_axi_arlen(s_axi_arlen),
        .s_axi_arready(s_axi_arready),
        .s_axi_arsize(s_axi_arsize),
        .s_axi_arvalid(s_axi_arvalid),
        .s_axi_awaddr(s_axi_awaddr),
        .s_axi_awburst(s_axi_awburst),
        .s_axi_awid(s_axi_awid),
        .s_axi_awlen(s_axi_awlen),
        .s_axi_awready(s_axi_awready),
        .s_axi_awsize(s_axi_awsize),
        .s_axi_awvalid(s_axi_awvalid),
        .s_axi_bid(s_axi_bid),
        .s_axi_bready(s_axi_bready),
        .s_axi_bresp(s_axi_bresp),
        .s_axi_bvalid(s_axi_bvalid),
        .s_axi_rdata(s_axi_rdata),
        .s_axi_rid(s_axi_rid),
        .s_axi_rlast(s_axi_rlast),
        .s_axi_rready(s_axi_rready),
        .s_axi_rresp(s_axi_rresp),
        .s_axi_rvalid(s_axi_rvalid),
        .s_axi_wdata(s_axi_wdata),
        .s_axi_wid(s_axi_wid),
        .s_axi_wlast(s_axi_wlast),
        .s_axi_wready(s_axi_wready),
        .s_axi_wstrb(s_axi_wstrb),
        .s_axi_wvalid(s_axi_wvalid));
endmodule

(* ORIG_REF_NAME = "axi_to_apb_bridge" *) 
module design_zed_axi4_to_apb4_s3_0_0_axi_to_apb_bridge
   (s_axi_bid,
    s_axi_rid,
    s_axi_rdata,
    s_axi_rresp,
    M0_APB_PADDR,
    M2_APB_PWDATA,
    M2_APB_PSTRB,
    \M_PADDR_reg[13]_0 ,
    \M_PADDR_reg[12]_0 ,
    M0_APB_PSEL,
    s_axi_bvalid,
    M2_APB_PWRITE,
    s_axi_awready,
    s_axi_wready,
    s_axi_bresp,
    s_axi_arready,
    s_axi_rlast,
    s_axi_rvalid,
    M2_APB_PENABLE,
    s_axi_awvalid,
    s_axi_arvalid,
    PCLK,
    s_axi_rready,
    axi_aclk,
    s_axi_arlen,
    s_axi_arsize,
    s_axi_arburst,
    s_axi_wstrb,
    s_axi_awlen,
    s_axi_awid,
    s_axi_arid,
    s_axi_awsize,
    s_axi_awburst,
    s_axi_awaddr,
    s_axi_wdata,
    M2_APB_PREADY,
    M0_APB_PREADY,
    M1_APB_PREADY,
    M0_APB_PRDATA,
    M1_APB_PRDATA,
    M2_APB_PRDATA,
    s_axi_bready,
    s_axi_wvalid,
    s_axi_araddr,
    s_axi_wlast,
    s_axi_wid,
    axi_aresetn,
    PRESETn);
  output [3:0]s_axi_bid;
  output [3:0]s_axi_rid;
  output [31:0]s_axi_rdata;
  output [1:0]s_axi_rresp;
  output [31:0]M0_APB_PADDR;
  output [31:0]M2_APB_PWDATA;
  output [3:0]M2_APB_PSTRB;
  output \M_PADDR_reg[13]_0 ;
  output \M_PADDR_reg[12]_0 ;
  output M0_APB_PSEL;
  output s_axi_bvalid;
  output M2_APB_PWRITE;
  output s_axi_awready;
  output s_axi_wready;
  output [0:0]s_axi_bresp;
  output s_axi_arready;
  output s_axi_rlast;
  output s_axi_rvalid;
  output M2_APB_PENABLE;
  input s_axi_awvalid;
  input s_axi_arvalid;
  input PCLK;
  input s_axi_rready;
  input axi_aclk;
  input [7:0]s_axi_arlen;
  input [2:0]s_axi_arsize;
  input [1:0]s_axi_arburst;
  input [3:0]s_axi_wstrb;
  input [7:0]s_axi_awlen;
  input [3:0]s_axi_awid;
  input [3:0]s_axi_arid;
  input [2:0]s_axi_awsize;
  input [1:0]s_axi_awburst;
  input [31:0]s_axi_awaddr;
  input [31:0]s_axi_wdata;
  input M2_APB_PREADY;
  input M0_APB_PREADY;
  input M1_APB_PREADY;
  input [31:0]M0_APB_PRDATA;
  input [31:0]M1_APB_PRDATA;
  input [31:0]M2_APB_PRDATA;
  input s_axi_bready;
  input s_axi_wvalid;
  input [31:0]s_axi_araddr;
  input s_axi_wlast;
  input [3:0]s_axi_wid;
  input axi_aresetn;
  input PRESETn;

  wire ACK_i_1_n_0;
  wire ACK_reg_n_0;
  wire [31:0]ADDR;
  wire \ARBURST_reg_reg_n_0_[0] ;
  wire \ARBURST_reg_reg_n_0_[1] ;
  wire [7:0]ARLEN_reg;
  wire \ARLEN_reg[7]_i_1_n_0 ;
  wire ARREADY_i_1_n_0;
  wire ARREADY_i_2_n_0;
  wire [2:0]ARSIZE_reg;
  wire [3:0]ARSTRB_reg;
  wire ARSTRB_reg1;
  wire ARSTRB_reg1_carry_i_1_n_0;
  wire ARSTRB_reg1_carry_i_2_n_0;
  wire ARSTRB_reg1_carry_i_3_n_0;
  wire ARSTRB_reg1_carry_i_4_n_0;
  wire ARSTRB_reg1_carry_i_5_n_0;
  wire ARSTRB_reg1_carry_i_6_n_0;
  wire ARSTRB_reg1_carry_i_7_n_0;
  wire ARSTRB_reg1_carry_i_8_n_0;
  wire ARSTRB_reg1_carry_n_1;
  wire ARSTRB_reg1_carry_n_2;
  wire ARSTRB_reg1_carry_n_3;
  wire \ARSTRB_reg[0]_i_1_n_0 ;
  wire \ARSTRB_reg[1]_i_1_n_0 ;
  wire \ARSTRB_reg[1]_i_2_n_0 ;
  wire \ARSTRB_reg[1]_i_3_n_0 ;
  wire \ARSTRB_reg[2]_i_1_n_0 ;
  wire \ARSTRB_reg[2]_i_2_n_0 ;
  wire \ARSTRB_reg[3]_i_1_n_0 ;
  wire \ARSTRB_reg[3]_i_2_n_0 ;
  wire \ARSTRB_reg[3]_i_3_n_0 ;
  wire \ARSTRB_reg[3]_i_4_n_0 ;
  wire [31:0]AWADDR_reg;
  wire AWBURST_reg;
  wire \AWBURST_reg_reg_n_0_[0] ;
  wire \AWBURST_reg_reg_n_0_[1] ;
  wire [3:0]AWID_reg;
  wire [7:0]AWLEN_reg;
  wire AWREADY_i_1_n_0;
  wire AWREADY_i_2_n_0;
  wire [2:0]AWSIZE_reg;
  wire BID0_carry_i_1_n_0;
  wire BID0_carry_i_2_n_0;
  wire BID0_carry_i_3_n_0;
  wire BID0_carry_i_4_n_0;
  wire BID0_carry_i_5_n_0;
  wire BID0_carry_i_6_n_0;
  wire BID0_carry_i_7_n_0;
  wire BID0_carry_i_8_n_0;
  wire BID0_carry_n_0;
  wire BID0_carry_n_1;
  wire BID0_carry_n_2;
  wire BID0_carry_n_3;
  wire \BID[3]_i_1_n_0 ;
  wire \BID[3]_i_2_n_0 ;
  wire \BRESP[1]_i_1_n_0 ;
  wire \BRESP[1]_i_2_n_0 ;
  wire \BRESP[1]_i_3_n_0 ;
  wire BVALID_i_1_n_0;
  wire DATAR;
  wire \DATAR[31]_i_10_n_0 ;
  wire \DATAR[31]_i_11_n_0 ;
  wire \DATAR[31]_i_3_n_0 ;
  wire \DATAR[31]_i_4_n_0 ;
  wire \DATAR[31]_i_5_n_0 ;
  wire \DATAR[31]_i_6_n_0 ;
  wire \DATAR[31]_i_7_n_0 ;
  wire \DATAR[31]_i_8_n_0 ;
  wire \DATAR[31]_i_9_n_0 ;
  wire [31:0]DATAR__0;
  wire [31:0]DATAW;
  wire \FSM_sequential_state[0]_i_1_n_0 ;
  wire \FSM_sequential_state[0]_i_2_n_0 ;
  wire \FSM_sequential_state[1]_i_1_n_0 ;
  wire \FSM_sequential_state[1]_i_2_n_0 ;
  wire [31:0]M0_APB_PADDR;
  wire [31:0]M0_APB_PRDATA;
  wire M0_APB_PREADY;
  wire M0_APB_PSEL;
  wire M0_APB_PSEL_INST_0_i_1_n_0;
  wire M0_APB_PSEL_INST_0_i_2_n_0;
  wire M0_APB_PSEL_INST_0_i_3_n_0;
  wire M0_APB_PSEL_INST_0_i_4_n_0;
  wire M0_APB_PSEL_INST_0_i_5_n_0;
  wire M0_APB_PSEL_INST_0_i_6_n_0;
  wire [31:0]M1_APB_PRDATA;
  wire M1_APB_PREADY;
  wire M1_APB_PSEL_INST_0_i_1_n_0;
  wire M1_APB_PSEL_INST_0_i_2_n_0;
  wire M1_APB_PSEL_INST_0_i_3_n_0;
  wire M1_APB_PSEL_INST_0_i_4_n_0;
  wire M2_APB_PENABLE;
  wire [31:0]M2_APB_PRDATA;
  wire M2_APB_PREADY;
  wire M2_APB_PSEL_INST_0_i_1_n_0;
  wire M2_APB_PSEL_INST_0_i_2_n_0;
  wire M2_APB_PSEL_INST_0_i_3_n_0;
  wire [3:0]M2_APB_PSTRB;
  wire [31:0]M2_APB_PWDATA;
  wire M2_APB_PWRITE;
  wire \M_PADDR[31]_i_1_n_0 ;
  wire \M_PADDR[31]_i_3_n_0 ;
  wire \M_PADDR_reg[12]_0 ;
  wire \M_PADDR_reg[13]_0 ;
  wire M_PENABLE_i_1_n_0;
  wire M_PSEL_i_1_n_0;
  wire \M_PSTRB[0]_i_1_n_0 ;
  wire \M_PSTRB[1]_i_1_n_0 ;
  wire \M_PSTRB[2]_i_1_n_0 ;
  wire \M_PSTRB[3]_i_1_n_0 ;
  wire PCLK;
  wire PRESETn;
  wire \RDATA[0]_i_1_n_0 ;
  wire \RDATA[10]_i_1_n_0 ;
  wire \RDATA[11]_i_1_n_0 ;
  wire \RDATA[12]_i_1_n_0 ;
  wire \RDATA[13]_i_1_n_0 ;
  wire \RDATA[14]_i_1_n_0 ;
  wire \RDATA[15]_i_1_n_0 ;
  wire \RDATA[16]_i_1_n_0 ;
  wire \RDATA[17]_i_1_n_0 ;
  wire \RDATA[18]_i_1_n_0 ;
  wire \RDATA[19]_i_1_n_0 ;
  wire \RDATA[1]_i_1_n_0 ;
  wire \RDATA[20]_i_1_n_0 ;
  wire \RDATA[21]_i_1_n_0 ;
  wire \RDATA[22]_i_1_n_0 ;
  wire \RDATA[23]_i_1_n_0 ;
  wire \RDATA[24]_i_1_n_0 ;
  wire \RDATA[25]_i_1_n_0 ;
  wire \RDATA[26]_i_1_n_0 ;
  wire \RDATA[27]_i_1_n_0 ;
  wire \RDATA[28]_i_1_n_0 ;
  wire \RDATA[29]_i_1_n_0 ;
  wire \RDATA[2]_i_1_n_0 ;
  wire \RDATA[30]_i_1_n_0 ;
  wire \RDATA[31]_i_1_n_0 ;
  wire \RDATA[31]_i_2_n_0 ;
  wire \RDATA[3]_i_1_n_0 ;
  wire \RDATA[4]_i_1_n_0 ;
  wire \RDATA[5]_i_1_n_0 ;
  wire \RDATA[6]_i_1_n_0 ;
  wire \RDATA[7]_i_1_n_0 ;
  wire \RDATA[8]_i_1_n_0 ;
  wire \RDATA[9]_i_1_n_0 ;
  wire \RID[3]_i_1_n_0 ;
  wire RLAST_i_1_n_0;
  wire RLAST_i_2_n_0;
  wire \RRESP[0]_i_1_n_0 ;
  wire \RRESP[1]_i_1_n_0 ;
  wire RVALID_i_1_n_0;
  wire [31:0]Traddr;
  wire \Traddr[31]_i_2_n_0 ;
  wire Tren_i_1_n_0;
  wire Tren_i_2_n_0;
  wire Tren_i_3_n_0;
  wire Tren_reg_n_0;
  wire Trstrb;
  wire [31:0]Twaddr;
  wire \Twaddr[31]_i_1_n_0 ;
  wire [31:0]Twdata;
  wire \Twdata[0]_i_1_n_0 ;
  wire \Twdata[10]_i_1_n_0 ;
  wire \Twdata[11]_i_1_n_0 ;
  wire \Twdata[12]_i_1_n_0 ;
  wire \Twdata[13]_i_1_n_0 ;
  wire \Twdata[14]_i_1_n_0 ;
  wire \Twdata[15]_i_1_n_0 ;
  wire \Twdata[16]_i_1_n_0 ;
  wire \Twdata[17]_i_1_n_0 ;
  wire \Twdata[18]_i_1_n_0 ;
  wire \Twdata[19]_i_1_n_0 ;
  wire \Twdata[1]_i_1_n_0 ;
  wire \Twdata[20]_i_1_n_0 ;
  wire \Twdata[21]_i_1_n_0 ;
  wire \Twdata[22]_i_1_n_0 ;
  wire \Twdata[23]_i_1_n_0 ;
  wire \Twdata[24]_i_1_n_0 ;
  wire \Twdata[25]_i_1_n_0 ;
  wire \Twdata[26]_i_1_n_0 ;
  wire \Twdata[27]_i_1_n_0 ;
  wire \Twdata[28]_i_1_n_0 ;
  wire \Twdata[29]_i_1_n_0 ;
  wire \Twdata[2]_i_1_n_0 ;
  wire \Twdata[30]_i_1_n_0 ;
  wire \Twdata[31]_i_2_n_0 ;
  wire \Twdata[3]_i_1_n_0 ;
  wire \Twdata[4]_i_1_n_0 ;
  wire \Twdata[5]_i_1_n_0 ;
  wire \Twdata[6]_i_1_n_0 ;
  wire \Twdata[7]_i_1_n_0 ;
  wire \Twdata[8]_i_1_n_0 ;
  wire \Twdata[9]_i_1_n_0 ;
  wire Twen;
  wire Twen_i_1_n_0;
  wire Twen_i_2_n_0;
  wire Twstrb;
  wire \Twstrb[0]_i_1_n_0 ;
  wire \Twstrb[1]_i_1_n_0 ;
  wire \Twstrb[2]_i_1_n_0 ;
  wire \Twstrb[3]_i_1_n_0 ;
  wire \Twstrb_reg_n_0_[0] ;
  wire \Twstrb_reg_n_0_[1] ;
  wire \Twstrb_reg_n_0_[2] ;
  wire \Twstrb_reg_n_0_[3] ;
  wire [31:0]WDATA_reg;
  wire WR;
  wire WREADY_i_1_n_0;
  wire WSTRB_reg;
  wire \WSTRB_reg_reg_n_0_[0] ;
  wire \WSTRB_reg_reg_n_0_[1] ;
  wire \WSTRB_reg_reg_n_0_[2] ;
  wire \WSTRB_reg_reg_n_0_[3] ;
  wire [31:0]X_PRDATA;
  wire X_PSEL;
  wire [31:0]addr;
  wire [31:0]addrRT;
  wire [31:1]addrRT0;
  wire addrRT0_carry__0_n_0;
  wire addrRT0_carry__0_n_1;
  wire addrRT0_carry__0_n_2;
  wire addrRT0_carry__0_n_3;
  wire addrRT0_carry__1_n_0;
  wire addrRT0_carry__1_n_1;
  wire addrRT0_carry__1_n_2;
  wire addrRT0_carry__1_n_3;
  wire addrRT0_carry__2_n_0;
  wire addrRT0_carry__2_n_1;
  wire addrRT0_carry__2_n_2;
  wire addrRT0_carry__2_n_3;
  wire addrRT0_carry__3_n_0;
  wire addrRT0_carry__3_n_1;
  wire addrRT0_carry__3_n_2;
  wire addrRT0_carry__3_n_3;
  wire addrRT0_carry__4_n_0;
  wire addrRT0_carry__4_n_1;
  wire addrRT0_carry__4_n_2;
  wire addrRT0_carry__4_n_3;
  wire addrRT0_carry__5_n_0;
  wire addrRT0_carry__5_n_1;
  wire addrRT0_carry__5_n_2;
  wire addrRT0_carry__5_n_3;
  wire addrRT0_carry__6_n_2;
  wire addrRT0_carry__6_n_3;
  wire addrRT0_carry_i_1_n_0;
  wire addrRT0_carry_n_0;
  wire addrRT0_carry_n_1;
  wire addrRT0_carry_n_2;
  wire addrRT0_carry_n_3;
  wire \addrRT[0]_i_1_n_0 ;
  wire \addrRT[10]_i_1_n_0 ;
  wire \addrRT[11]_i_1_n_0 ;
  wire \addrRT[12]_i_1_n_0 ;
  wire \addrRT[13]_i_1_n_0 ;
  wire \addrRT[14]_i_1_n_0 ;
  wire \addrRT[15]_i_1_n_0 ;
  wire \addrRT[16]_i_1_n_0 ;
  wire \addrRT[17]_i_1_n_0 ;
  wire \addrRT[18]_i_1_n_0 ;
  wire \addrRT[19]_i_1_n_0 ;
  wire \addrRT[1]_i_1_n_0 ;
  wire \addrRT[20]_i_1_n_0 ;
  wire \addrRT[21]_i_1_n_0 ;
  wire \addrRT[22]_i_1_n_0 ;
  wire \addrRT[23]_i_1_n_0 ;
  wire \addrRT[24]_i_1_n_0 ;
  wire \addrRT[25]_i_1_n_0 ;
  wire \addrRT[26]_i_1_n_0 ;
  wire \addrRT[27]_i_1_n_0 ;
  wire \addrRT[28]_i_1_n_0 ;
  wire \addrRT[29]_i_1_n_0 ;
  wire \addrRT[2]_i_1_n_0 ;
  wire \addrRT[30]_i_1_n_0 ;
  wire \addrRT[31]_i_1_n_0 ;
  wire \addrRT[31]_i_2_n_0 ;
  wire \addrRT[3]_i_1_n_0 ;
  wire \addrRT[4]_i_1_n_0 ;
  wire \addrRT[5]_i_1_n_0 ;
  wire \addrRT[6]_i_1_n_0 ;
  wire \addrRT[7]_i_1_n_0 ;
  wire \addrRT[8]_i_1_n_0 ;
  wire \addrRT[9]_i_1_n_0 ;
  wire \addrR[0]_i_1_n_0 ;
  wire \addrR[0]_i_2_n_0 ;
  wire \addrR[0]_i_3_n_0 ;
  wire \addrR[10]_i_1_n_0 ;
  wire \addrR[10]_i_2_n_0 ;
  wire \addrR[10]_i_3_n_0 ;
  wire \addrR[11]_i_1_n_0 ;
  wire \addrR[11]_i_2_n_0 ;
  wire \addrR[11]_i_4_n_0 ;
  wire \addrR[12]_i_1_n_0 ;
  wire \addrR[12]_i_2_n_0 ;
  wire \addrR[12]_i_3_n_0 ;
  wire \addrR[13]_i_1_n_0 ;
  wire \addrR[13]_i_2_n_0 ;
  wire \addrR[13]_i_3_n_0 ;
  wire \addrR[14]_i_1_n_0 ;
  wire \addrR[14]_i_2_n_0 ;
  wire \addrR[14]_i_3_n_0 ;
  wire \addrR[15]_i_1_n_0 ;
  wire \addrR[15]_i_2_n_0 ;
  wire \addrR[15]_i_4_n_0 ;
  wire \addrR[15]_i_5_n_0 ;
  wire \addrR[16]_i_1_n_0 ;
  wire \addrR[16]_i_2_n_0 ;
  wire \addrR[16]_i_3_n_0 ;
  wire \addrR[17]_i_1_n_0 ;
  wire \addrR[17]_i_2_n_0 ;
  wire \addrR[17]_i_3_n_0 ;
  wire \addrR[18]_i_1_n_0 ;
  wire \addrR[18]_i_2_n_0 ;
  wire \addrR[18]_i_3_n_0 ;
  wire \addrR[19]_i_1_n_0 ;
  wire \addrR[19]_i_2_n_0 ;
  wire \addrR[19]_i_4_n_0 ;
  wire \addrR[1]_i_1_n_0 ;
  wire \addrR[1]_i_2_n_0 ;
  wire \addrR[1]_i_3_n_0 ;
  wire \addrR[20]_i_1_n_0 ;
  wire \addrR[20]_i_2_n_0 ;
  wire \addrR[20]_i_3_n_0 ;
  wire \addrR[21]_i_1_n_0 ;
  wire \addrR[21]_i_2_n_0 ;
  wire \addrR[21]_i_3_n_0 ;
  wire \addrR[22]_i_1_n_0 ;
  wire \addrR[22]_i_2_n_0 ;
  wire \addrR[22]_i_3_n_0 ;
  wire \addrR[23]_i_1_n_0 ;
  wire \addrR[23]_i_2_n_0 ;
  wire \addrR[23]_i_4_n_0 ;
  wire \addrR[24]_i_1_n_0 ;
  wire \addrR[24]_i_2_n_0 ;
  wire \addrR[24]_i_3_n_0 ;
  wire \addrR[25]_i_1_n_0 ;
  wire \addrR[25]_i_2_n_0 ;
  wire \addrR[25]_i_3_n_0 ;
  wire \addrR[26]_i_1_n_0 ;
  wire \addrR[26]_i_2_n_0 ;
  wire \addrR[26]_i_3_n_0 ;
  wire \addrR[27]_i_1_n_0 ;
  wire \addrR[27]_i_2_n_0 ;
  wire \addrR[27]_i_4_n_0 ;
  wire \addrR[28]_i_1_n_0 ;
  wire \addrR[28]_i_2_n_0 ;
  wire \addrR[28]_i_3_n_0 ;
  wire \addrR[29]_i_1_n_0 ;
  wire \addrR[29]_i_2_n_0 ;
  wire \addrR[29]_i_3_n_0 ;
  wire \addrR[2]_i_1_n_0 ;
  wire \addrR[2]_i_2_n_0 ;
  wire \addrR[2]_i_3_n_0 ;
  wire \addrR[2]_i_5_n_0 ;
  wire \addrR[2]_i_6_n_0 ;
  wire \addrR[2]_i_7_n_0 ;
  wire \addrR[2]_i_8_n_0 ;
  wire \addrR[30]_i_1_n_0 ;
  wire \addrR[30]_i_2_n_0 ;
  wire \addrR[30]_i_3_n_0 ;
  wire \addrR[31]_i_1_n_0 ;
  wire \addrR[31]_i_2_n_0 ;
  wire \addrR[31]_i_3_n_0 ;
  wire \addrR[31]_i_4_n_0 ;
  wire \addrR[31]_i_6_n_0 ;
  wire \addrR[3]_i_10_n_0 ;
  wire \addrR[3]_i_11_n_0 ;
  wire \addrR[3]_i_12_n_0 ;
  wire \addrR[3]_i_13_n_0 ;
  wire \addrR[3]_i_1_n_0 ;
  wire \addrR[3]_i_2_n_0 ;
  wire \addrR[3]_i_3_n_0 ;
  wire \addrR[3]_i_5_n_0 ;
  wire \addrR[3]_i_6_n_0 ;
  wire \addrR[3]_i_7_n_0 ;
  wire \addrR[3]_i_9_n_0 ;
  wire \addrR[4]_i_1_n_0 ;
  wire \addrR[4]_i_2_n_0 ;
  wire \addrR[4]_i_3_n_0 ;
  wire \addrR[4]_i_4_n_0 ;
  wire \addrR[5]_i_1_n_0 ;
  wire \addrR[5]_i_2_n_0 ;
  wire \addrR[5]_i_3_n_0 ;
  wire \addrR[5]_i_4_n_0 ;
  wire \addrR[6]_i_1_n_0 ;
  wire \addrR[6]_i_2_n_0 ;
  wire \addrR[6]_i_3_n_0 ;
  wire \addrR[6]_i_4_n_0 ;
  wire \addrR[7]_i_10_n_0 ;
  wire \addrR[7]_i_11_n_0 ;
  wire \addrR[7]_i_12_n_0 ;
  wire \addrR[7]_i_13_n_0 ;
  wire \addrR[7]_i_15_n_0 ;
  wire \addrR[7]_i_16_n_0 ;
  wire \addrR[7]_i_17_n_0 ;
  wire \addrR[7]_i_18_n_0 ;
  wire \addrR[7]_i_1_n_0 ;
  wire \addrR[7]_i_2_n_0 ;
  wire \addrR[7]_i_3_n_0 ;
  wire \addrR[7]_i_5_n_0 ;
  wire \addrR[7]_i_6_n_0 ;
  wire \addrR[7]_i_8_n_0 ;
  wire \addrR[7]_i_9_n_0 ;
  wire \addrR[8]_i_1_n_0 ;
  wire \addrR[8]_i_2_n_0 ;
  wire \addrR[8]_i_3_n_0 ;
  wire \addrR[9]_i_1_n_0 ;
  wire \addrR[9]_i_2_n_0 ;
  wire \addrR[9]_i_3_n_0 ;
  wire \addrR_reg[11]_i_3_n_0 ;
  wire \addrR_reg[11]_i_3_n_1 ;
  wire \addrR_reg[11]_i_3_n_2 ;
  wire \addrR_reg[11]_i_3_n_3 ;
  wire \addrR_reg[11]_i_9_n_0 ;
  wire \addrR_reg[11]_i_9_n_1 ;
  wire \addrR_reg[11]_i_9_n_2 ;
  wire \addrR_reg[11]_i_9_n_3 ;
  wire \addrR_reg[15]_i_10_n_0 ;
  wire \addrR_reg[15]_i_10_n_1 ;
  wire \addrR_reg[15]_i_10_n_2 ;
  wire \addrR_reg[15]_i_10_n_3 ;
  wire \addrR_reg[15]_i_3_n_0 ;
  wire \addrR_reg[15]_i_3_n_1 ;
  wire \addrR_reg[15]_i_3_n_2 ;
  wire \addrR_reg[15]_i_3_n_3 ;
  wire \addrR_reg[19]_i_3_n_0 ;
  wire \addrR_reg[19]_i_3_n_1 ;
  wire \addrR_reg[19]_i_3_n_2 ;
  wire \addrR_reg[19]_i_3_n_3 ;
  wire \addrR_reg[19]_i_9_n_0 ;
  wire \addrR_reg[19]_i_9_n_1 ;
  wire \addrR_reg[19]_i_9_n_2 ;
  wire \addrR_reg[19]_i_9_n_3 ;
  wire \addrR_reg[23]_i_3_n_0 ;
  wire \addrR_reg[23]_i_3_n_1 ;
  wire \addrR_reg[23]_i_3_n_2 ;
  wire \addrR_reg[23]_i_3_n_3 ;
  wire \addrR_reg[23]_i_9_n_0 ;
  wire \addrR_reg[23]_i_9_n_1 ;
  wire \addrR_reg[23]_i_9_n_2 ;
  wire \addrR_reg[23]_i_9_n_3 ;
  wire \addrR_reg[27]_i_3_n_0 ;
  wire \addrR_reg[27]_i_3_n_1 ;
  wire \addrR_reg[27]_i_3_n_2 ;
  wire \addrR_reg[27]_i_3_n_3 ;
  wire \addrR_reg[27]_i_9_n_0 ;
  wire \addrR_reg[27]_i_9_n_1 ;
  wire \addrR_reg[27]_i_9_n_2 ;
  wire \addrR_reg[27]_i_9_n_3 ;
  wire \addrR_reg[2]_i_4_n_0 ;
  wire \addrR_reg[2]_i_4_n_1 ;
  wire \addrR_reg[2]_i_4_n_2 ;
  wire \addrR_reg[2]_i_4_n_3 ;
  wire \addrR_reg[31]_i_11_n_1 ;
  wire \addrR_reg[31]_i_11_n_2 ;
  wire \addrR_reg[31]_i_11_n_3 ;
  wire \addrR_reg[31]_i_5_n_1 ;
  wire \addrR_reg[31]_i_5_n_2 ;
  wire \addrR_reg[31]_i_5_n_3 ;
  wire \addrR_reg[3]_i_4_n_0 ;
  wire \addrR_reg[3]_i_4_n_1 ;
  wire \addrR_reg[3]_i_4_n_2 ;
  wire \addrR_reg[3]_i_4_n_3 ;
  wire \addrR_reg[7]_i_14_n_0 ;
  wire \addrR_reg[7]_i_14_n_1 ;
  wire \addrR_reg[7]_i_14_n_2 ;
  wire \addrR_reg[7]_i_14_n_3 ;
  wire \addrR_reg[7]_i_4_n_0 ;
  wire \addrR_reg[7]_i_4_n_1 ;
  wire \addrR_reg[7]_i_4_n_2 ;
  wire \addrR_reg[7]_i_4_n_3 ;
  wire \addrR_reg_n_0_[0] ;
  wire \addrR_reg_n_0_[10] ;
  wire \addrR_reg_n_0_[11] ;
  wire \addrR_reg_n_0_[12] ;
  wire \addrR_reg_n_0_[13] ;
  wire \addrR_reg_n_0_[14] ;
  wire \addrR_reg_n_0_[15] ;
  wire \addrR_reg_n_0_[16] ;
  wire \addrR_reg_n_0_[17] ;
  wire \addrR_reg_n_0_[18] ;
  wire \addrR_reg_n_0_[19] ;
  wire \addrR_reg_n_0_[1] ;
  wire \addrR_reg_n_0_[20] ;
  wire \addrR_reg_n_0_[21] ;
  wire \addrR_reg_n_0_[22] ;
  wire \addrR_reg_n_0_[23] ;
  wire \addrR_reg_n_0_[24] ;
  wire \addrR_reg_n_0_[25] ;
  wire \addrR_reg_n_0_[26] ;
  wire \addrR_reg_n_0_[27] ;
  wire \addrR_reg_n_0_[28] ;
  wire \addrR_reg_n_0_[29] ;
  wire \addrR_reg_n_0_[2] ;
  wire \addrR_reg_n_0_[30] ;
  wire \addrR_reg_n_0_[31] ;
  wire \addrR_reg_n_0_[3] ;
  wire \addrR_reg_n_0_[4] ;
  wire \addrR_reg_n_0_[5] ;
  wire \addrR_reg_n_0_[6] ;
  wire \addrR_reg_n_0_[7] ;
  wire \addrR_reg_n_0_[8] ;
  wire \addrR_reg_n_0_[9] ;
  wire [31:0]addrWT;
  wire [31:1]addrWT0;
  wire addrWT0_carry__0_n_0;
  wire addrWT0_carry__0_n_1;
  wire addrWT0_carry__0_n_2;
  wire addrWT0_carry__0_n_3;
  wire addrWT0_carry__1_n_0;
  wire addrWT0_carry__1_n_1;
  wire addrWT0_carry__1_n_2;
  wire addrWT0_carry__1_n_3;
  wire addrWT0_carry__2_n_0;
  wire addrWT0_carry__2_n_1;
  wire addrWT0_carry__2_n_2;
  wire addrWT0_carry__2_n_3;
  wire addrWT0_carry__3_n_0;
  wire addrWT0_carry__3_n_1;
  wire addrWT0_carry__3_n_2;
  wire addrWT0_carry__3_n_3;
  wire addrWT0_carry__4_n_0;
  wire addrWT0_carry__4_n_1;
  wire addrWT0_carry__4_n_2;
  wire addrWT0_carry__4_n_3;
  wire addrWT0_carry__5_n_0;
  wire addrWT0_carry__5_n_1;
  wire addrWT0_carry__5_n_2;
  wire addrWT0_carry__5_n_3;
  wire addrWT0_carry__6_n_2;
  wire addrWT0_carry__6_n_3;
  wire addrWT0_carry_i_1_n_0;
  wire addrWT0_carry_n_0;
  wire addrWT0_carry_n_1;
  wire addrWT0_carry_n_2;
  wire addrWT0_carry_n_3;
  wire \addrWT[0]_i_1_n_0 ;
  wire \addrWT[10]_i_1_n_0 ;
  wire \addrWT[11]_i_1_n_0 ;
  wire \addrWT[12]_i_1_n_0 ;
  wire \addrWT[13]_i_1_n_0 ;
  wire \addrWT[14]_i_1_n_0 ;
  wire \addrWT[15]_i_1_n_0 ;
  wire \addrWT[16]_i_1_n_0 ;
  wire \addrWT[17]_i_1_n_0 ;
  wire \addrWT[18]_i_1_n_0 ;
  wire \addrWT[19]_i_1_n_0 ;
  wire \addrWT[1]_i_1_n_0 ;
  wire \addrWT[20]_i_1_n_0 ;
  wire \addrWT[21]_i_1_n_0 ;
  wire \addrWT[22]_i_1_n_0 ;
  wire \addrWT[23]_i_1_n_0 ;
  wire \addrWT[24]_i_1_n_0 ;
  wire \addrWT[25]_i_1_n_0 ;
  wire \addrWT[26]_i_1_n_0 ;
  wire \addrWT[27]_i_1_n_0 ;
  wire \addrWT[28]_i_1_n_0 ;
  wire \addrWT[29]_i_1_n_0 ;
  wire \addrWT[2]_i_1_n_0 ;
  wire \addrWT[30]_i_1_n_0 ;
  wire \addrWT[31]_i_1_n_0 ;
  wire \addrWT[31]_i_2_n_0 ;
  wire \addrWT[3]_i_1_n_0 ;
  wire \addrWT[4]_i_1_n_0 ;
  wire \addrWT[5]_i_1_n_0 ;
  wire \addrWT[6]_i_1_n_0 ;
  wire \addrWT[7]_i_1_n_0 ;
  wire \addrWT[8]_i_1_n_0 ;
  wire \addrWT[9]_i_1_n_0 ;
  wire \addrW[0]_i_1_n_0 ;
  wire \addrW[0]_i_2_n_0 ;
  wire \addrW[0]_i_3_n_0 ;
  wire \addrW[10]_i_1_n_0 ;
  wire \addrW[10]_i_2_n_0 ;
  wire \addrW[10]_i_3_n_0 ;
  wire \addrW[11]_i_1_n_0 ;
  wire \addrW[11]_i_2_n_0 ;
  wire \addrW[11]_i_4_n_0 ;
  wire \addrW[12]_i_1_n_0 ;
  wire \addrW[12]_i_2_n_0 ;
  wire \addrW[12]_i_3_n_0 ;
  wire \addrW[13]_i_1_n_0 ;
  wire \addrW[13]_i_2_n_0 ;
  wire \addrW[13]_i_3_n_0 ;
  wire \addrW[14]_i_1_n_0 ;
  wire \addrW[14]_i_2_n_0 ;
  wire \addrW[14]_i_3_n_0 ;
  wire \addrW[15]_i_1_n_0 ;
  wire \addrW[15]_i_2_n_0 ;
  wire \addrW[15]_i_3_n_0 ;
  wire \addrW[15]_i_5_n_0 ;
  wire \addrW[15]_i_6_n_0 ;
  wire \addrW[16]_i_1_n_0 ;
  wire \addrW[16]_i_2_n_0 ;
  wire \addrW[16]_i_3_n_0 ;
  wire \addrW[17]_i_1_n_0 ;
  wire \addrW[17]_i_2_n_0 ;
  wire \addrW[17]_i_3_n_0 ;
  wire \addrW[18]_i_1_n_0 ;
  wire \addrW[18]_i_2_n_0 ;
  wire \addrW[18]_i_3_n_0 ;
  wire \addrW[19]_i_1_n_0 ;
  wire \addrW[19]_i_2_n_0 ;
  wire \addrW[19]_i_4_n_0 ;
  wire \addrW[1]_i_1_n_0 ;
  wire \addrW[1]_i_2_n_0 ;
  wire \addrW[1]_i_3_n_0 ;
  wire \addrW[20]_i_1_n_0 ;
  wire \addrW[20]_i_2_n_0 ;
  wire \addrW[20]_i_3_n_0 ;
  wire \addrW[21]_i_1_n_0 ;
  wire \addrW[21]_i_2_n_0 ;
  wire \addrW[21]_i_3_n_0 ;
  wire \addrW[22]_i_1_n_0 ;
  wire \addrW[22]_i_2_n_0 ;
  wire \addrW[22]_i_3_n_0 ;
  wire \addrW[23]_i_1_n_0 ;
  wire \addrW[23]_i_2_n_0 ;
  wire \addrW[23]_i_4_n_0 ;
  wire \addrW[24]_i_1_n_0 ;
  wire \addrW[24]_i_2_n_0 ;
  wire \addrW[24]_i_3_n_0 ;
  wire \addrW[25]_i_1_n_0 ;
  wire \addrW[25]_i_2_n_0 ;
  wire \addrW[25]_i_3_n_0 ;
  wire \addrW[26]_i_1_n_0 ;
  wire \addrW[26]_i_2_n_0 ;
  wire \addrW[26]_i_3_n_0 ;
  wire \addrW[27]_i_1_n_0 ;
  wire \addrW[27]_i_2_n_0 ;
  wire \addrW[27]_i_4_n_0 ;
  wire \addrW[28]_i_1_n_0 ;
  wire \addrW[28]_i_2_n_0 ;
  wire \addrW[28]_i_3_n_0 ;
  wire \addrW[29]_i_1_n_0 ;
  wire \addrW[29]_i_2_n_0 ;
  wire \addrW[29]_i_3_n_0 ;
  wire \addrW[2]_i_1_n_0 ;
  wire \addrW[2]_i_2_n_0 ;
  wire \addrW[2]_i_3_n_0 ;
  wire \addrW[2]_i_5_n_0 ;
  wire \addrW[2]_i_6_n_0 ;
  wire \addrW[2]_i_7_n_0 ;
  wire \addrW[2]_i_8_n_0 ;
  wire \addrW[2]_i_9_n_0 ;
  wire \addrW[30]_i_1_n_0 ;
  wire \addrW[30]_i_2_n_0 ;
  wire \addrW[30]_i_3_n_0 ;
  wire \addrW[31]_i_1_n_0 ;
  wire \addrW[31]_i_2_n_0 ;
  wire \addrW[31]_i_3_n_0 ;
  wire \addrW[31]_i_5_n_0 ;
  wire \addrW[3]_i_10_n_0 ;
  wire \addrW[3]_i_11_n_0 ;
  wire \addrW[3]_i_12_n_0 ;
  wire \addrW[3]_i_13_n_0 ;
  wire \addrW[3]_i_1_n_0 ;
  wire \addrW[3]_i_2_n_0 ;
  wire \addrW[3]_i_3_n_0 ;
  wire \addrW[3]_i_5_n_0 ;
  wire \addrW[3]_i_6_n_0 ;
  wire \addrW[3]_i_7_n_0 ;
  wire \addrW[3]_i_9_n_0 ;
  wire \addrW[4]_i_1_n_0 ;
  wire \addrW[4]_i_2_n_0 ;
  wire \addrW[4]_i_3_n_0 ;
  wire \addrW[4]_i_4_n_0 ;
  wire \addrW[5]_i_1_n_0 ;
  wire \addrW[5]_i_2_n_0 ;
  wire \addrW[5]_i_3_n_0 ;
  wire \addrW[5]_i_4_n_0 ;
  wire \addrW[6]_i_1_n_0 ;
  wire \addrW[6]_i_2_n_0 ;
  wire \addrW[6]_i_3_n_0 ;
  wire \addrW[6]_i_4_n_0 ;
  wire \addrW[7]_i_10_n_0 ;
  wire \addrW[7]_i_11_n_0 ;
  wire \addrW[7]_i_12_n_0 ;
  wire \addrW[7]_i_13_n_0 ;
  wire \addrW[7]_i_15_n_0 ;
  wire \addrW[7]_i_16_n_0 ;
  wire \addrW[7]_i_17_n_0 ;
  wire \addrW[7]_i_18_n_0 ;
  wire \addrW[7]_i_1_n_0 ;
  wire \addrW[7]_i_2_n_0 ;
  wire \addrW[7]_i_3_n_0 ;
  wire \addrW[7]_i_5_n_0 ;
  wire \addrW[7]_i_6_n_0 ;
  wire \addrW[7]_i_8_n_0 ;
  wire \addrW[7]_i_9_n_0 ;
  wire \addrW[8]_i_1_n_0 ;
  wire \addrW[8]_i_2_n_0 ;
  wire \addrW[8]_i_3_n_0 ;
  wire \addrW[9]_i_1_n_0 ;
  wire \addrW[9]_i_2_n_0 ;
  wire \addrW[9]_i_3_n_0 ;
  wire \addrW_reg[11]_i_3_n_0 ;
  wire \addrW_reg[11]_i_3_n_1 ;
  wire \addrW_reg[11]_i_3_n_2 ;
  wire \addrW_reg[11]_i_3_n_3 ;
  wire \addrW_reg[11]_i_9_n_0 ;
  wire \addrW_reg[11]_i_9_n_1 ;
  wire \addrW_reg[11]_i_9_n_2 ;
  wire \addrW_reg[11]_i_9_n_3 ;
  wire \addrW_reg[15]_i_11_n_0 ;
  wire \addrW_reg[15]_i_11_n_1 ;
  wire \addrW_reg[15]_i_11_n_2 ;
  wire \addrW_reg[15]_i_11_n_3 ;
  wire \addrW_reg[15]_i_4_n_0 ;
  wire \addrW_reg[15]_i_4_n_1 ;
  wire \addrW_reg[15]_i_4_n_2 ;
  wire \addrW_reg[15]_i_4_n_3 ;
  wire \addrW_reg[19]_i_3_n_0 ;
  wire \addrW_reg[19]_i_3_n_1 ;
  wire \addrW_reg[19]_i_3_n_2 ;
  wire \addrW_reg[19]_i_3_n_3 ;
  wire \addrW_reg[19]_i_9_n_0 ;
  wire \addrW_reg[19]_i_9_n_1 ;
  wire \addrW_reg[19]_i_9_n_2 ;
  wire \addrW_reg[19]_i_9_n_3 ;
  wire \addrW_reg[23]_i_3_n_0 ;
  wire \addrW_reg[23]_i_3_n_1 ;
  wire \addrW_reg[23]_i_3_n_2 ;
  wire \addrW_reg[23]_i_3_n_3 ;
  wire \addrW_reg[23]_i_9_n_0 ;
  wire \addrW_reg[23]_i_9_n_1 ;
  wire \addrW_reg[23]_i_9_n_2 ;
  wire \addrW_reg[23]_i_9_n_3 ;
  wire \addrW_reg[27]_i_3_n_0 ;
  wire \addrW_reg[27]_i_3_n_1 ;
  wire \addrW_reg[27]_i_3_n_2 ;
  wire \addrW_reg[27]_i_3_n_3 ;
  wire \addrW_reg[27]_i_9_n_0 ;
  wire \addrW_reg[27]_i_9_n_1 ;
  wire \addrW_reg[27]_i_9_n_2 ;
  wire \addrW_reg[27]_i_9_n_3 ;
  wire \addrW_reg[2]_i_4_n_0 ;
  wire \addrW_reg[2]_i_4_n_1 ;
  wire \addrW_reg[2]_i_4_n_2 ;
  wire \addrW_reg[2]_i_4_n_3 ;
  wire \addrW_reg[31]_i_10_n_1 ;
  wire \addrW_reg[31]_i_10_n_2 ;
  wire \addrW_reg[31]_i_10_n_3 ;
  wire \addrW_reg[31]_i_4_n_1 ;
  wire \addrW_reg[31]_i_4_n_2 ;
  wire \addrW_reg[31]_i_4_n_3 ;
  wire \addrW_reg[3]_i_4_n_0 ;
  wire \addrW_reg[3]_i_4_n_1 ;
  wire \addrW_reg[3]_i_4_n_2 ;
  wire \addrW_reg[3]_i_4_n_3 ;
  wire \addrW_reg[7]_i_14_n_0 ;
  wire \addrW_reg[7]_i_14_n_1 ;
  wire \addrW_reg[7]_i_14_n_2 ;
  wire \addrW_reg[7]_i_14_n_3 ;
  wire \addrW_reg[7]_i_4_n_0 ;
  wire \addrW_reg[7]_i_4_n_1 ;
  wire \addrW_reg[7]_i_4_n_2 ;
  wire \addrW_reg[7]_i_4_n_3 ;
  wire axi_aclk;
  wire axi_aresetn;
  wire [7:0]beatR;
  wire \beatR[1]_i_1_n_0 ;
  wire \beatR[5]_i_2_n_0 ;
  wire \beatR[6]_i_1_n_0 ;
  wire \beatR[7]_i_1_n_0 ;
  wire \beatR[7]_i_3_n_0 ;
  wire beatW;
  wire \beatW[0]_i_1_n_0 ;
  wire \beatW[1]_i_1_n_0 ;
  wire \beatW[2]_i_1_n_0 ;
  wire \beatW[3]_i_1_n_0 ;
  wire \beatW[4]_i_1_n_0 ;
  wire \beatW[4]_i_2_n_0 ;
  wire \beatW[5]_i_1_n_0 ;
  wire \beatW[5]_i_2_n_0 ;
  wire \beatW[6]_i_1_n_0 ;
  wire \beatW[7]_i_2_n_0 ;
  wire \beatW[7]_i_3_n_0 ;
  wire \beatW_reg_n_0_[0] ;
  wire \beatW_reg_n_0_[1] ;
  wire \beatW_reg_n_0_[2] ;
  wire \beatW_reg_n_0_[3] ;
  wire \beatW_reg_n_0_[4] ;
  wire \beatW_reg_n_0_[5] ;
  wire \beatW_reg_n_0_[6] ;
  wire \beatW_reg_n_0_[7] ;
  wire [29:1]get_next_addr_rd0;
  wire [31:0]get_next_addr_rd00_in;
  wire get_next_addr_rd0_carry__0_n_0;
  wire get_next_addr_rd0_carry__0_n_1;
  wire get_next_addr_rd0_carry__0_n_2;
  wire get_next_addr_rd0_carry__0_n_3;
  wire get_next_addr_rd0_carry__1_n_0;
  wire get_next_addr_rd0_carry__1_n_1;
  wire get_next_addr_rd0_carry__1_n_2;
  wire get_next_addr_rd0_carry__1_n_3;
  wire get_next_addr_rd0_carry__2_n_0;
  wire get_next_addr_rd0_carry__2_n_1;
  wire get_next_addr_rd0_carry__2_n_2;
  wire get_next_addr_rd0_carry__2_n_3;
  wire get_next_addr_rd0_carry__3_n_0;
  wire get_next_addr_rd0_carry__3_n_1;
  wire get_next_addr_rd0_carry__3_n_2;
  wire get_next_addr_rd0_carry__3_n_3;
  wire get_next_addr_rd0_carry__4_n_0;
  wire get_next_addr_rd0_carry__4_n_1;
  wire get_next_addr_rd0_carry__4_n_2;
  wire get_next_addr_rd0_carry__4_n_3;
  wire get_next_addr_rd0_carry__5_n_0;
  wire get_next_addr_rd0_carry__5_n_1;
  wire get_next_addr_rd0_carry__5_n_2;
  wire get_next_addr_rd0_carry__5_n_3;
  wire get_next_addr_rd0_carry_n_0;
  wire get_next_addr_rd0_carry_n_1;
  wire get_next_addr_rd0_carry_n_2;
  wire get_next_addr_rd0_carry_n_3;
  wire [31:0]get_next_addr_rd2;
  wire [31:1]get_next_addr_rd3;
  wire [29:1]get_next_addr_wr0;
  wire [31:0]get_next_addr_wr00_in;
  wire get_next_addr_wr0_carry__0_n_0;
  wire get_next_addr_wr0_carry__0_n_1;
  wire get_next_addr_wr0_carry__0_n_2;
  wire get_next_addr_wr0_carry__0_n_3;
  wire get_next_addr_wr0_carry__1_n_0;
  wire get_next_addr_wr0_carry__1_n_1;
  wire get_next_addr_wr0_carry__1_n_2;
  wire get_next_addr_wr0_carry__1_n_3;
  wire get_next_addr_wr0_carry__2_n_0;
  wire get_next_addr_wr0_carry__2_n_1;
  wire get_next_addr_wr0_carry__2_n_2;
  wire get_next_addr_wr0_carry__2_n_3;
  wire get_next_addr_wr0_carry__3_n_0;
  wire get_next_addr_wr0_carry__3_n_1;
  wire get_next_addr_wr0_carry__3_n_2;
  wire get_next_addr_wr0_carry__3_n_3;
  wire get_next_addr_wr0_carry__4_n_0;
  wire get_next_addr_wr0_carry__4_n_1;
  wire get_next_addr_wr0_carry__4_n_2;
  wire get_next_addr_wr0_carry__4_n_3;
  wire get_next_addr_wr0_carry__5_n_0;
  wire get_next_addr_wr0_carry__5_n_1;
  wire get_next_addr_wr0_carry__5_n_2;
  wire get_next_addr_wr0_carry__5_n_3;
  wire get_next_addr_wr0_carry_n_0;
  wire get_next_addr_wr0_carry_n_1;
  wire get_next_addr_wr0_carry_n_2;
  wire get_next_addr_wr0_carry_n_3;
  wire [31:0]get_next_addr_wr2;
  wire [31:1]get_next_addr_wr3;
  wire grant_read_i_1_n_0;
  wire grant_read_i_2_n_0;
  wire grant_read_i_3_n_0;
  wire grant_write_i_1_n_0;
  wire grant_write_i_2_n_0;
  wire i__carry__0_i_10_n_0;
  wire i__carry__0_i_11_n_0;
  wire i__carry__0_i_12_n_0;
  wire i__carry__0_i_13_n_0;
  wire i__carry__0_i_14_n_0;
  wire i__carry__0_i_15_n_0;
  wire i__carry__0_i_16_n_0;
  wire i__carry__0_i_17_n_0;
  wire i__carry__0_i_18_n_0;
  wire i__carry__0_i_19_n_0;
  wire i__carry__0_i_1_n_0;
  wire i__carry__0_i_20_n_0;
  wire i__carry__0_i_2_n_0;
  wire i__carry__0_i_3_n_0;
  wire i__carry__0_i_4_n_0;
  wire i__carry__0_i_5_n_0;
  wire i__carry__0_i_6_n_0;
  wire i__carry__0_i_7_n_0;
  wire i__carry__0_i_8_n_0;
  wire i__carry__0_i_9_n_0;
  wire i__carry__1_i_10_n_0;
  wire i__carry__1_i_11_n_0;
  wire i__carry__1_i_12_n_0;
  wire i__carry__1_i_13_n_0;
  wire i__carry__1_i_14_n_0;
  wire i__carry__1_i_15_n_0;
  wire i__carry__1_i_16_n_0;
  wire i__carry__1_i_1_n_0;
  wire i__carry__1_i_2_n_0;
  wire i__carry__1_i_3_n_0;
  wire i__carry__1_i_4_n_0;
  wire i__carry__1_i_5_n_0;
  wire i__carry__1_i_6_n_0;
  wire i__carry__1_i_7_n_0;
  wire i__carry__1_i_8_n_0;
  wire i__carry__1_i_9_n_0;
  wire i__carry__2_i_1_n_0;
  wire i__carry__2_i_2_n_0;
  wire i__carry__2_i_3_n_0;
  wire i__carry__2_i_4_n_0;
  wire i__carry_i_10_n_0;
  wire i__carry_i_11_n_0;
  wire i__carry_i_12_n_0;
  wire i__carry_i_13_n_0;
  wire i__carry_i_1_n_0;
  wire i__carry_i_2_n_0;
  wire i__carry_i_3_n_0;
  wire i__carry_i_4_n_0;
  wire i__carry_i_5_n_0;
  wire i__carry_i_6_n_0;
  wire i__carry_i_7_n_0;
  wire i__carry_i_8_n_0;
  wire i__carry_i_9_n_0;
  wire [1:0]p_0_in;
  wire [14:2]p_0_out;
  wire [7:0]p_1_in;
  wire p_1_out_carry__0_i_10_n_0;
  wire p_1_out_carry__0_i_11_n_0;
  wire p_1_out_carry__0_i_12_n_0;
  wire p_1_out_carry__0_i_13_n_0;
  wire p_1_out_carry__0_i_14_n_0;
  wire p_1_out_carry__0_i_15_n_0;
  wire p_1_out_carry__0_i_16_n_0;
  wire p_1_out_carry__0_i_17_n_0;
  wire p_1_out_carry__0_i_18_n_0;
  wire p_1_out_carry__0_i_19_n_0;
  wire p_1_out_carry__0_i_20_n_0;
  wire p_1_out_carry__0_i_21_n_0;
  wire p_1_out_carry__0_i_5_n_0;
  wire p_1_out_carry__0_i_6_n_0;
  wire p_1_out_carry__0_i_7_n_0;
  wire p_1_out_carry__0_i_8_n_0;
  wire p_1_out_carry__0_i_9_n_0;
  wire p_1_out_carry__0_n_0;
  wire p_1_out_carry__0_n_1;
  wire p_1_out_carry__0_n_2;
  wire p_1_out_carry__0_n_3;
  wire p_1_out_carry__0_n_4;
  wire p_1_out_carry__0_n_5;
  wire p_1_out_carry__0_n_6;
  wire p_1_out_carry__0_n_7;
  wire p_1_out_carry__1_i_10_n_0;
  wire p_1_out_carry__1_i_11_n_0;
  wire p_1_out_carry__1_i_12_n_0;
  wire p_1_out_carry__1_i_13_n_0;
  wire p_1_out_carry__1_i_14_n_0;
  wire p_1_out_carry__1_i_15_n_0;
  wire p_1_out_carry__1_i_16_n_0;
  wire p_1_out_carry__1_i_5_n_0;
  wire p_1_out_carry__1_i_6_n_0;
  wire p_1_out_carry__1_i_7_n_0;
  wire p_1_out_carry__1_i_8_n_0;
  wire p_1_out_carry__1_i_9_n_0;
  wire p_1_out_carry__1_n_0;
  wire p_1_out_carry__1_n_1;
  wire p_1_out_carry__1_n_2;
  wire p_1_out_carry__1_n_3;
  wire p_1_out_carry__1_n_4;
  wire p_1_out_carry__1_n_5;
  wire p_1_out_carry__1_n_6;
  wire p_1_out_carry__1_n_7;
  wire p_1_out_carry__2_i_1_n_0;
  wire p_1_out_carry__2_i_3_n_0;
  wire p_1_out_carry__2_i_4_n_0;
  wire p_1_out_carry__2_n_1;
  wire p_1_out_carry__2_n_3;
  wire p_1_out_carry__2_n_6;
  wire p_1_out_carry__2_n_7;
  wire p_1_out_carry_i_10_n_0;
  wire p_1_out_carry_i_11_n_0;
  wire p_1_out_carry_i_12_n_0;
  wire p_1_out_carry_i_13_n_0;
  wire p_1_out_carry_i_1_n_0;
  wire p_1_out_carry_i_6_n_0;
  wire p_1_out_carry_i_7_n_0;
  wire p_1_out_carry_i_8_n_0;
  wire p_1_out_carry_i_9_n_0;
  wire p_1_out_carry_n_0;
  wire p_1_out_carry_n_1;
  wire p_1_out_carry_n_2;
  wire p_1_out_carry_n_3;
  wire p_1_out_carry_n_4;
  wire p_1_out_carry_n_5;
  wire p_1_out_carry_n_6;
  wire p_1_out_carry_n_7;
  wire \p_1_out_inferred__0/i__carry__0_n_0 ;
  wire \p_1_out_inferred__0/i__carry__0_n_1 ;
  wire \p_1_out_inferred__0/i__carry__0_n_2 ;
  wire \p_1_out_inferred__0/i__carry__0_n_3 ;
  wire \p_1_out_inferred__0/i__carry__0_n_4 ;
  wire \p_1_out_inferred__0/i__carry__0_n_5 ;
  wire \p_1_out_inferred__0/i__carry__0_n_6 ;
  wire \p_1_out_inferred__0/i__carry__0_n_7 ;
  wire \p_1_out_inferred__0/i__carry__1_n_0 ;
  wire \p_1_out_inferred__0/i__carry__1_n_1 ;
  wire \p_1_out_inferred__0/i__carry__1_n_2 ;
  wire \p_1_out_inferred__0/i__carry__1_n_3 ;
  wire \p_1_out_inferred__0/i__carry__1_n_4 ;
  wire \p_1_out_inferred__0/i__carry__1_n_5 ;
  wire \p_1_out_inferred__0/i__carry__1_n_6 ;
  wire \p_1_out_inferred__0/i__carry__1_n_7 ;
  wire \p_1_out_inferred__0/i__carry__2_n_1 ;
  wire \p_1_out_inferred__0/i__carry__2_n_3 ;
  wire \p_1_out_inferred__0/i__carry__2_n_6 ;
  wire \p_1_out_inferred__0/i__carry__2_n_7 ;
  wire \p_1_out_inferred__0/i__carry_n_0 ;
  wire \p_1_out_inferred__0/i__carry_n_1 ;
  wire \p_1_out_inferred__0/i__carry_n_2 ;
  wire \p_1_out_inferred__0/i__carry_n_3 ;
  wire \p_1_out_inferred__0/i__carry_n_4 ;
  wire \p_1_out_inferred__0/i__carry_n_5 ;
  wire \p_1_out_inferred__0/i__carry_n_6 ;
  wire \p_1_out_inferred__0/i__carry_n_7 ;
  wire [31:0]s_axi_araddr;
  wire [1:0]s_axi_arburst;
  wire [3:0]s_axi_arid;
  wire [7:0]s_axi_arlen;
  wire s_axi_arready;
  wire [2:0]s_axi_arsize;
  wire s_axi_arvalid;
  wire [31:0]s_axi_awaddr;
  wire [1:0]s_axi_awburst;
  wire [3:0]s_axi_awid;
  wire [7:0]s_axi_awlen;
  wire s_axi_awready;
  wire [2:0]s_axi_awsize;
  wire s_axi_awvalid;
  wire [3:0]s_axi_bid;
  wire s_axi_bready;
  wire [0:0]s_axi_bresp;
  wire s_axi_bvalid;
  wire [31:0]s_axi_rdata;
  wire [3:0]s_axi_rid;
  wire s_axi_rlast;
  wire s_axi_rready;
  wire [1:0]s_axi_rresp;
  wire s_axi_rvalid;
  wire [31:0]s_axi_wdata;
  wire [3:0]s_axi_wid;
  wire s_axi_wlast;
  wire s_axi_wready;
  wire [3:0]s_axi_wstrb;
  wire s_axi_wvalid;
  wire [1:0]state;
  wire stateR;
  wire \stateR[0]_i_1_n_0 ;
  wire \stateR[0]_i_2_n_0 ;
  wire \stateR[1]_i_1_n_0 ;
  wire \stateR[2]_i_1_n_0 ;
  wire \stateR_reg_n_0_[0] ;
  wire \stateR_reg_n_0_[1] ;
  wire \stateR_reg_n_0_[2] ;
  wire stateW;
  wire \stateW[0]_i_1_n_0 ;
  wire \stateW[0]_i_2_n_0 ;
  wire \stateW[0]_i_3_n_0 ;
  wire \stateW[1]_i_1_n_0 ;
  wire \stateW[1]_i_2_n_0 ;
  wire \stateW[2]_i_1_n_0 ;
  wire \stateW[2]_i_2_n_0 ;
  wire \stateW[2]_i_4_n_0 ;
  wire \stateW[2]_i_5_n_0 ;
  wire \stateW[2]_i_6_n_0 ;
  wire \stateW_reg_n_0_[0] ;
  wire \stateW_reg_n_0_[1] ;
  wire \stateW_reg_n_0_[2] ;
  wire tickR;
  wire \tickR[0]_i_1_n_0 ;
  wire \tickR[1]_i_1_n_0 ;
  wire \tickR[2]_i_1_n_0 ;
  wire \tickR[3]_i_2_n_0 ;
  wire \tickR[3]_i_3_n_0 ;
  wire \tickR_reg_n_0_[0] ;
  wire \tickR_reg_n_0_[1] ;
  wire \tickR_reg_n_0_[2] ;
  wire \tickR_reg_n_0_[3] ;
  wire tickW;
  wire \tickW[0]_i_1_n_0 ;
  wire \tickW[1]_i_1_n_0 ;
  wire \tickW[2]_i_1_n_0 ;
  wire \tickW[3]_i_2_n_0 ;
  wire \tickW[3]_i_3_n_0 ;
  wire \tickW_reg_n_0_[0] ;
  wire \tickW_reg_n_0_[1] ;
  wire \tickW_reg_n_0_[2] ;
  wire \tickW_reg_n_0_[3] ;
  wire [3:0]NLW_ARSTRB_reg1_carry_O_UNCONNECTED;
  wire [3:0]NLW_BID0_carry_O_UNCONNECTED;
  wire [3:2]NLW_addrRT0_carry__6_CO_UNCONNECTED;
  wire [3:3]NLW_addrRT0_carry__6_O_UNCONNECTED;
  wire [3:3]\NLW_addrR_reg[31]_i_11_CO_UNCONNECTED ;
  wire [3:3]\NLW_addrR_reg[31]_i_5_CO_UNCONNECTED ;
  wire [3:2]NLW_addrWT0_carry__6_CO_UNCONNECTED;
  wire [3:3]NLW_addrWT0_carry__6_O_UNCONNECTED;
  wire [3:3]\NLW_addrW_reg[31]_i_10_CO_UNCONNECTED ;
  wire [3:3]\NLW_addrW_reg[31]_i_4_CO_UNCONNECTED ;
  wire [3:0]NLW_get_next_addr_rd0_carry__6_CO_UNCONNECTED;
  wire [3:1]NLW_get_next_addr_rd0_carry__6_O_UNCONNECTED;
  wire [3:0]NLW_get_next_addr_wr0_carry__6_CO_UNCONNECTED;
  wire [3:1]NLW_get_next_addr_wr0_carry__6_O_UNCONNECTED;
  wire [3:1]NLW_p_1_out_carry__2_CO_UNCONNECTED;
  wire [3:2]NLW_p_1_out_carry__2_O_UNCONNECTED;
  wire [3:1]\NLW_p_1_out_inferred__0/i__carry__2_CO_UNCONNECTED ;
  wire [3:2]\NLW_p_1_out_inferred__0/i__carry__2_O_UNCONNECTED ;

  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT5 #(
    .INIT(32'hF3FF0044)) 
    ACK_i_1
       (.I0(\FSM_sequential_state[0]_i_2_n_0 ),
        .I1(state[1]),
        .I2(\FSM_sequential_state[1]_i_2_n_0 ),
        .I3(state[0]),
        .I4(ACK_reg_n_0),
        .O(ACK_i_1_n_0));
  FDCE #(
    .INIT(1'b0)) 
    ACK_reg
       (.C(PCLK),
        .CE(1'b1),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ACK_i_1_n_0),
        .Q(ACK_reg_n_0));
  FDCE \ARBURST_reg_reg[0] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arburst[0]),
        .Q(\ARBURST_reg_reg_n_0_[0] ));
  FDCE \ARBURST_reg_reg[1] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arburst[1]),
        .Q(\ARBURST_reg_reg_n_0_[1] ));
  LUT6 #(
    .INIT(64'h0000000000010000)) 
    \ARLEN_reg[7]_i_1 
       (.I0(\stateR_reg_n_0_[0] ),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .I3(s_axi_awvalid),
        .I4(s_axi_arvalid),
        .I5(p_0_in[1]),
        .O(\ARLEN_reg[7]_i_1_n_0 ));
  FDCE \ARLEN_reg_reg[0] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arlen[0]),
        .Q(ARLEN_reg[0]));
  FDCE \ARLEN_reg_reg[1] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arlen[1]),
        .Q(ARLEN_reg[1]));
  FDCE \ARLEN_reg_reg[2] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arlen[2]),
        .Q(ARLEN_reg[2]));
  FDCE \ARLEN_reg_reg[3] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arlen[3]),
        .Q(ARLEN_reg[3]));
  FDCE \ARLEN_reg_reg[4] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arlen[4]),
        .Q(ARLEN_reg[4]));
  FDCE \ARLEN_reg_reg[5] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arlen[5]),
        .Q(ARLEN_reg[5]));
  FDCE \ARLEN_reg_reg[6] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arlen[6]),
        .Q(ARLEN_reg[6]));
  FDCE \ARLEN_reg_reg[7] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arlen[7]),
        .Q(ARLEN_reg[7]));
  LUT5 #(
    .INIT(32'hFDFD0100)) 
    ARREADY_i_1
       (.I0(\stateR_reg_n_0_[0] ),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .I3(ARREADY_i_2_n_0),
        .I4(s_axi_arready),
        .O(ARREADY_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'h04)) 
    ARREADY_i_2
       (.I0(s_axi_awvalid),
        .I1(s_axi_arvalid),
        .I2(p_0_in[1]),
        .O(ARREADY_i_2_n_0));
  FDCE ARREADY_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(ARREADY_i_1_n_0),
        .Q(s_axi_arready));
  FDCE \ARSIZE_reg_reg[0] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arsize[0]),
        .Q(ARSIZE_reg[0]));
  FDCE \ARSIZE_reg_reg[1] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arsize[1]),
        .Q(ARSIZE_reg[1]));
  FDCE \ARSIZE_reg_reg[2] 
       (.C(axi_aclk),
        .CE(\ARLEN_reg[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arsize[2]),
        .Q(ARSIZE_reg[2]));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 ARSTRB_reg1_carry
       (.CI(1'b0),
        .CO({ARSTRB_reg1,ARSTRB_reg1_carry_n_1,ARSTRB_reg1_carry_n_2,ARSTRB_reg1_carry_n_3}),
        .CYINIT(1'b1),
        .DI({ARSTRB_reg1_carry_i_1_n_0,ARSTRB_reg1_carry_i_2_n_0,ARSTRB_reg1_carry_i_3_n_0,ARSTRB_reg1_carry_i_4_n_0}),
        .O(NLW_ARSTRB_reg1_carry_O_UNCONNECTED[3:0]),
        .S({ARSTRB_reg1_carry_i_5_n_0,ARSTRB_reg1_carry_i_6_n_0,ARSTRB_reg1_carry_i_7_n_0,ARSTRB_reg1_carry_i_8_n_0}));
  LUT4 #(
    .INIT(16'h22B2)) 
    ARSTRB_reg1_carry_i_1
       (.I0(beatR[7]),
        .I1(ARLEN_reg[7]),
        .I2(beatR[6]),
        .I3(ARLEN_reg[6]),
        .O(ARSTRB_reg1_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    ARSTRB_reg1_carry_i_2
       (.I0(beatR[5]),
        .I1(ARLEN_reg[5]),
        .I2(beatR[4]),
        .I3(ARLEN_reg[4]),
        .O(ARSTRB_reg1_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    ARSTRB_reg1_carry_i_3
       (.I0(beatR[3]),
        .I1(ARLEN_reg[3]),
        .I2(beatR[2]),
        .I3(ARLEN_reg[2]),
        .O(ARSTRB_reg1_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    ARSTRB_reg1_carry_i_4
       (.I0(beatR[1]),
        .I1(ARLEN_reg[1]),
        .I2(beatR[0]),
        .I3(ARLEN_reg[0]),
        .O(ARSTRB_reg1_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ARSTRB_reg1_carry_i_5
       (.I0(ARLEN_reg[7]),
        .I1(beatR[7]),
        .I2(ARLEN_reg[6]),
        .I3(beatR[6]),
        .O(ARSTRB_reg1_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ARSTRB_reg1_carry_i_6
       (.I0(ARLEN_reg[5]),
        .I1(beatR[5]),
        .I2(ARLEN_reg[4]),
        .I3(beatR[4]),
        .O(ARSTRB_reg1_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ARSTRB_reg1_carry_i_7
       (.I0(ARLEN_reg[3]),
        .I1(beatR[3]),
        .I2(ARLEN_reg[2]),
        .I3(beatR[2]),
        .O(ARSTRB_reg1_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    ARSTRB_reg1_carry_i_8
       (.I0(ARLEN_reg[1]),
        .I1(beatR[1]),
        .I2(ARLEN_reg[0]),
        .I3(beatR[0]),
        .O(ARSTRB_reg1_carry_i_8_n_0));
  LUT5 #(
    .INIT(32'h1010101F)) 
    \ARSTRB_reg[0]_i_1 
       (.I0(\addrR_reg_n_0_[1] ),
        .I1(\addrR_reg_n_0_[0] ),
        .I2(\stateR_reg_n_0_[0] ),
        .I3(s_axi_araddr[1]),
        .I4(s_axi_araddr[0]),
        .O(\ARSTRB_reg[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1F1111111F111F11)) 
    \ARSTRB_reg[1]_i_1 
       (.I0(\ARSTRB_reg[1]_i_2_n_0 ),
        .I1(s_axi_araddr[1]),
        .I2(\addrR_reg_n_0_[1] ),
        .I3(\stateR_reg_n_0_[0] ),
        .I4(\addrR_reg_n_0_[0] ),
        .I5(\ARSTRB_reg[1]_i_3_n_0 ),
        .O(\ARSTRB_reg[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAAAAAAAB)) 
    \ARSTRB_reg[1]_i_2 
       (.I0(\stateR_reg_n_0_[0] ),
        .I1(s_axi_araddr[0]),
        .I2(s_axi_arsize[0]),
        .I3(s_axi_arsize[2]),
        .I4(s_axi_arsize[1]),
        .O(\ARSTRB_reg[1]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \ARSTRB_reg[1]_i_3 
       (.I0(ARSIZE_reg[0]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .O(\ARSTRB_reg[1]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFF70607040)) 
    \ARSTRB_reg[2]_i_1 
       (.I0(\addrR_reg_n_0_[0] ),
        .I1(\addrR_reg_n_0_[1] ),
        .I2(\stateR_reg_n_0_[0] ),
        .I3(\ARSTRB_reg[3]_i_4_n_0 ),
        .I4(ARSIZE_reg[0]),
        .I5(\ARSTRB_reg[2]_i_2_n_0 ),
        .O(\ARSTRB_reg[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000000000FEFFFC)) 
    \ARSTRB_reg[2]_i_2 
       (.I0(s_axi_arsize[0]),
        .I1(s_axi_arsize[1]),
        .I2(s_axi_arsize[2]),
        .I3(s_axi_araddr[1]),
        .I4(s_axi_araddr[0]),
        .I5(\stateR_reg_n_0_[0] ),
        .O(\ARSTRB_reg[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAAAABAAAAAA)) 
    \ARSTRB_reg[3]_i_1 
       (.I0(\ARLEN_reg[7]_i_1_n_0 ),
        .I1(ARSTRB_reg1),
        .I2(ACK_reg_n_0),
        .I3(\stateR_reg_n_0_[0] ),
        .I4(\stateR_reg_n_0_[2] ),
        .I5(\stateR_reg_n_0_[1] ),
        .O(\ARSTRB_reg[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFEAAFEAAFEAAEEAA)) 
    \ARSTRB_reg[3]_i_2 
       (.I0(\ARSTRB_reg[3]_i_3_n_0 ),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(\addrR_reg_n_0_[1] ),
        .I3(\stateR_reg_n_0_[0] ),
        .I4(\addrR_reg_n_0_[0] ),
        .I5(ARSIZE_reg[0]),
        .O(\ARSTRB_reg[3]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h00000000FEFEFEFC)) 
    \ARSTRB_reg[3]_i_3 
       (.I0(s_axi_araddr[1]),
        .I1(s_axi_arsize[1]),
        .I2(s_axi_arsize[2]),
        .I3(s_axi_arsize[0]),
        .I4(s_axi_araddr[0]),
        .I5(\stateR_reg_n_0_[0] ),
        .O(\ARSTRB_reg[3]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \ARSTRB_reg[3]_i_4 
       (.I0(ARSIZE_reg[1]),
        .I1(ARSIZE_reg[2]),
        .O(\ARSTRB_reg[3]_i_4_n_0 ));
  FDCE \ARSTRB_reg_reg[0] 
       (.C(axi_aclk),
        .CE(\ARSTRB_reg[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\ARSTRB_reg[0]_i_1_n_0 ),
        .Q(ARSTRB_reg[0]));
  FDCE \ARSTRB_reg_reg[1] 
       (.C(axi_aclk),
        .CE(\ARSTRB_reg[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\ARSTRB_reg[1]_i_1_n_0 ),
        .Q(ARSTRB_reg[1]));
  FDCE \ARSTRB_reg_reg[2] 
       (.C(axi_aclk),
        .CE(\ARSTRB_reg[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\ARSTRB_reg[2]_i_1_n_0 ),
        .Q(ARSTRB_reg[2]));
  FDCE \ARSTRB_reg_reg[3] 
       (.C(axi_aclk),
        .CE(\ARSTRB_reg[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\ARSTRB_reg[3]_i_2_n_0 ),
        .Q(ARSTRB_reg[3]));
  FDCE \AWADDR_reg_reg[0] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[0]),
        .Q(AWADDR_reg[0]));
  FDCE \AWADDR_reg_reg[10] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[10]),
        .Q(AWADDR_reg[10]));
  FDCE \AWADDR_reg_reg[11] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[11]),
        .Q(AWADDR_reg[11]));
  FDCE \AWADDR_reg_reg[12] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[12]),
        .Q(AWADDR_reg[12]));
  FDCE \AWADDR_reg_reg[13] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[13]),
        .Q(AWADDR_reg[13]));
  FDCE \AWADDR_reg_reg[14] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[14]),
        .Q(AWADDR_reg[14]));
  FDCE \AWADDR_reg_reg[15] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[15]),
        .Q(AWADDR_reg[15]));
  FDCE \AWADDR_reg_reg[16] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[16]),
        .Q(AWADDR_reg[16]));
  FDCE \AWADDR_reg_reg[17] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[17]),
        .Q(AWADDR_reg[17]));
  FDCE \AWADDR_reg_reg[18] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[18]),
        .Q(AWADDR_reg[18]));
  FDCE \AWADDR_reg_reg[19] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[19]),
        .Q(AWADDR_reg[19]));
  FDCE \AWADDR_reg_reg[1] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[1]),
        .Q(AWADDR_reg[1]));
  FDCE \AWADDR_reg_reg[20] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[20]),
        .Q(AWADDR_reg[20]));
  FDCE \AWADDR_reg_reg[21] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[21]),
        .Q(AWADDR_reg[21]));
  FDCE \AWADDR_reg_reg[22] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[22]),
        .Q(AWADDR_reg[22]));
  FDCE \AWADDR_reg_reg[23] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[23]),
        .Q(AWADDR_reg[23]));
  FDCE \AWADDR_reg_reg[24] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[24]),
        .Q(AWADDR_reg[24]));
  FDCE \AWADDR_reg_reg[25] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[25]),
        .Q(AWADDR_reg[25]));
  FDCE \AWADDR_reg_reg[26] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[26]),
        .Q(AWADDR_reg[26]));
  FDCE \AWADDR_reg_reg[27] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[27]),
        .Q(AWADDR_reg[27]));
  FDCE \AWADDR_reg_reg[28] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[28]),
        .Q(AWADDR_reg[28]));
  FDCE \AWADDR_reg_reg[29] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[29]),
        .Q(AWADDR_reg[29]));
  FDCE \AWADDR_reg_reg[2] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[2]),
        .Q(AWADDR_reg[2]));
  FDCE \AWADDR_reg_reg[30] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[30]),
        .Q(AWADDR_reg[30]));
  FDCE \AWADDR_reg_reg[31] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[31]),
        .Q(AWADDR_reg[31]));
  FDCE \AWADDR_reg_reg[3] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[3]),
        .Q(AWADDR_reg[3]));
  FDCE \AWADDR_reg_reg[4] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[4]),
        .Q(AWADDR_reg[4]));
  FDCE \AWADDR_reg_reg[5] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[5]),
        .Q(AWADDR_reg[5]));
  FDCE \AWADDR_reg_reg[6] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[6]),
        .Q(AWADDR_reg[6]));
  FDCE \AWADDR_reg_reg[7] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[7]),
        .Q(AWADDR_reg[7]));
  FDCE \AWADDR_reg_reg[8] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[8]),
        .Q(AWADDR_reg[8]));
  FDCE \AWADDR_reg_reg[9] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awaddr[9]),
        .Q(AWADDR_reg[9]));
  FDCE \AWBURST_reg_reg[0] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awburst[0]),
        .Q(\AWBURST_reg_reg_n_0_[0] ));
  FDCE \AWBURST_reg_reg[1] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awburst[1]),
        .Q(\AWBURST_reg_reg_n_0_[1] ));
  FDCE \AWID_reg_reg[0] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awid[0]),
        .Q(AWID_reg[0]));
  FDCE \AWID_reg_reg[1] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awid[1]),
        .Q(AWID_reg[1]));
  FDCE \AWID_reg_reg[2] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awid[2]),
        .Q(AWID_reg[2]));
  FDCE \AWID_reg_reg[3] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awid[3]),
        .Q(AWID_reg[3]));
  LUT5 #(
    .INIT(32'h00000010)) 
    \AWLEN_reg[7]_i_1 
       (.I0(\stateW_reg_n_0_[2] ),
        .I1(\stateW_reg_n_0_[1] ),
        .I2(s_axi_awvalid),
        .I3(p_0_in[0]),
        .I4(\stateW_reg_n_0_[0] ),
        .O(AWBURST_reg));
  FDCE \AWLEN_reg_reg[0] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awlen[0]),
        .Q(AWLEN_reg[0]));
  FDCE \AWLEN_reg_reg[1] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awlen[1]),
        .Q(AWLEN_reg[1]));
  FDCE \AWLEN_reg_reg[2] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awlen[2]),
        .Q(AWLEN_reg[2]));
  FDCE \AWLEN_reg_reg[3] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awlen[3]),
        .Q(AWLEN_reg[3]));
  FDCE \AWLEN_reg_reg[4] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awlen[4]),
        .Q(AWLEN_reg[4]));
  FDCE \AWLEN_reg_reg[5] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awlen[5]),
        .Q(AWLEN_reg[5]));
  FDCE \AWLEN_reg_reg[6] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awlen[6]),
        .Q(AWLEN_reg[6]));
  FDCE \AWLEN_reg_reg[7] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awlen[7]),
        .Q(AWLEN_reg[7]));
  LUT6 #(
    .INIT(64'hFFFFF0FF00000002)) 
    AWREADY_i_1
       (.I0(s_axi_awvalid),
        .I1(p_0_in[0]),
        .I2(\stateW_reg_n_0_[2] ),
        .I3(\stateW_reg_n_0_[0] ),
        .I4(\stateW_reg_n_0_[1] ),
        .I5(s_axi_awready),
        .O(AWREADY_i_1_n_0));
  LUT1 #(
    .INIT(2'h1)) 
    AWREADY_i_2
       (.I0(axi_aresetn),
        .O(AWREADY_i_2_n_0));
  FDCE AWREADY_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(AWREADY_i_1_n_0),
        .Q(s_axi_awready));
  FDCE \AWSIZE_reg_reg[0] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awsize[0]),
        .Q(AWSIZE_reg[0]));
  FDCE \AWSIZE_reg_reg[1] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awsize[1]),
        .Q(AWSIZE_reg[1]));
  FDCE \AWSIZE_reg_reg[2] 
       (.C(axi_aclk),
        .CE(AWBURST_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_awsize[2]),
        .Q(AWSIZE_reg[2]));
  (* COMPARATOR_THRESHOLD = "11" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 BID0_carry
       (.CI(1'b0),
        .CO({BID0_carry_n_0,BID0_carry_n_1,BID0_carry_n_2,BID0_carry_n_3}),
        .CYINIT(1'b1),
        .DI({BID0_carry_i_1_n_0,BID0_carry_i_2_n_0,BID0_carry_i_3_n_0,BID0_carry_i_4_n_0}),
        .O(NLW_BID0_carry_O_UNCONNECTED[3:0]),
        .S({BID0_carry_i_5_n_0,BID0_carry_i_6_n_0,BID0_carry_i_7_n_0,BID0_carry_i_8_n_0}));
  LUT4 #(
    .INIT(16'h22B2)) 
    BID0_carry_i_1
       (.I0(\beatW_reg_n_0_[7] ),
        .I1(AWLEN_reg[7]),
        .I2(\beatW_reg_n_0_[6] ),
        .I3(AWLEN_reg[6]),
        .O(BID0_carry_i_1_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    BID0_carry_i_2
       (.I0(\beatW_reg_n_0_[5] ),
        .I1(AWLEN_reg[5]),
        .I2(\beatW_reg_n_0_[4] ),
        .I3(AWLEN_reg[4]),
        .O(BID0_carry_i_2_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    BID0_carry_i_3
       (.I0(\beatW_reg_n_0_[3] ),
        .I1(AWLEN_reg[3]),
        .I2(\beatW_reg_n_0_[2] ),
        .I3(AWLEN_reg[2]),
        .O(BID0_carry_i_3_n_0));
  LUT4 #(
    .INIT(16'h22B2)) 
    BID0_carry_i_4
       (.I0(\beatW_reg_n_0_[1] ),
        .I1(AWLEN_reg[1]),
        .I2(\beatW_reg_n_0_[0] ),
        .I3(AWLEN_reg[0]),
        .O(BID0_carry_i_4_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    BID0_carry_i_5
       (.I0(AWLEN_reg[7]),
        .I1(\beatW_reg_n_0_[7] ),
        .I2(AWLEN_reg[6]),
        .I3(\beatW_reg_n_0_[6] ),
        .O(BID0_carry_i_5_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    BID0_carry_i_6
       (.I0(AWLEN_reg[5]),
        .I1(\beatW_reg_n_0_[5] ),
        .I2(AWLEN_reg[4]),
        .I3(\beatW_reg_n_0_[4] ),
        .O(BID0_carry_i_6_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    BID0_carry_i_7
       (.I0(AWLEN_reg[3]),
        .I1(\beatW_reg_n_0_[3] ),
        .I2(AWLEN_reg[2]),
        .I3(\beatW_reg_n_0_[2] ),
        .O(BID0_carry_i_7_n_0));
  LUT4 #(
    .INIT(16'h9009)) 
    BID0_carry_i_8
       (.I0(AWLEN_reg[1]),
        .I1(\beatW_reg_n_0_[1] ),
        .I2(AWLEN_reg[0]),
        .I3(\beatW_reg_n_0_[0] ),
        .O(BID0_carry_i_8_n_0));
  LUT6 #(
    .INIT(64'h0000080003000000)) 
    \BID[3]_i_1 
       (.I0(ACK_reg_n_0),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(\BID[3]_i_2_n_0 ),
        .I3(BID0_carry_n_0),
        .I4(\stateW_reg_n_0_[2] ),
        .I5(\stateW_reg_n_0_[1] ),
        .O(\BID[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \BID[3]_i_2 
       (.I0(\tickW_reg_n_0_[1] ),
        .I1(\tickW_reg_n_0_[0] ),
        .I2(\tickW_reg_n_0_[2] ),
        .I3(\tickW_reg_n_0_[3] ),
        .O(\BID[3]_i_2_n_0 ));
  FDCE \BID_reg[0] 
       (.C(axi_aclk),
        .CE(\BID[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(AWID_reg[0]),
        .Q(s_axi_bid[0]));
  FDCE \BID_reg[1] 
       (.C(axi_aclk),
        .CE(\BID[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(AWID_reg[1]),
        .Q(s_axi_bid[1]));
  FDCE \BID_reg[2] 
       (.C(axi_aclk),
        .CE(\BID[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(AWID_reg[2]),
        .Q(s_axi_bid[2]));
  FDCE \BID_reg[3] 
       (.C(axi_aclk),
        .CE(\BID[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(AWID_reg[3]),
        .Q(s_axi_bid[3]));
  LUT6 #(
    .INIT(64'hFFFFFF0F00000200)) 
    \BRESP[1]_i_1 
       (.I0(s_axi_wvalid),
        .I1(\BRESP[1]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(\stateW_reg_n_0_[2] ),
        .I5(s_axi_bresp),
        .O(\BRESP[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0D00000D)) 
    \BRESP[1]_i_2 
       (.I0(BID0_carry_n_0),
        .I1(s_axi_wlast),
        .I2(\BRESP[1]_i_3_n_0 ),
        .I3(s_axi_wid[3]),
        .I4(AWID_reg[3]),
        .O(\BRESP[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h6FF6FFFFFFFF6FF6)) 
    \BRESP[1]_i_3 
       (.I0(AWID_reg[0]),
        .I1(s_axi_wid[0]),
        .I2(s_axi_wid[2]),
        .I3(AWID_reg[2]),
        .I4(s_axi_wid[1]),
        .I5(AWID_reg[1]),
        .O(\BRESP[1]_i_3_n_0 ));
  FDPE \BRESP_reg[1] 
       (.C(axi_aclk),
        .CE(1'b1),
        .D(\BRESP[1]_i_1_n_0 ),
        .PRE(AWREADY_i_2_n_0),
        .Q(s_axi_bresp));
  LUT6 #(
    .INIT(64'hDFFFFFFF30000000)) 
    BVALID_i_1
       (.I0(s_axi_bready),
        .I1(ACK_reg_n_0),
        .I2(\stateW_reg_n_0_[2] ),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(\stateW_reg_n_0_[0] ),
        .I5(s_axi_bvalid),
        .O(BVALID_i_1_n_0));
  FDCE BVALID_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(BVALID_i_1_n_0),
        .Q(s_axi_bvalid));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[0]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[0]),
        .I2(M1_APB_PRDATA[0]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[0]),
        .O(X_PRDATA[0]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[10]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[10]),
        .I2(M1_APB_PRDATA[10]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[10]),
        .O(X_PRDATA[10]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[11]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[11]),
        .I2(M1_APB_PRDATA[11]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[11]),
        .O(X_PRDATA[11]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[12]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[12]),
        .I2(M1_APB_PRDATA[12]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[12]),
        .O(X_PRDATA[12]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[13]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[13]),
        .I2(M1_APB_PRDATA[13]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[13]),
        .O(X_PRDATA[13]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[14]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[14]),
        .I2(M1_APB_PRDATA[14]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[14]),
        .O(X_PRDATA[14]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[15]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[15]),
        .I2(M1_APB_PRDATA[15]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[15]),
        .O(X_PRDATA[15]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[16]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[16]),
        .I2(M1_APB_PRDATA[16]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[16]),
        .O(X_PRDATA[16]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[17]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[17]),
        .I2(M1_APB_PRDATA[17]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[17]),
        .O(X_PRDATA[17]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[18]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[18]),
        .I2(M1_APB_PRDATA[18]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[18]),
        .O(X_PRDATA[18]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[19]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[19]),
        .I2(M1_APB_PRDATA[19]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[19]),
        .O(X_PRDATA[19]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[1]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[1]),
        .I2(M1_APB_PRDATA[1]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[1]),
        .O(X_PRDATA[1]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[20]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[20]),
        .I2(M1_APB_PRDATA[20]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[20]),
        .O(X_PRDATA[20]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[21]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[21]),
        .I2(M1_APB_PRDATA[21]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[21]),
        .O(X_PRDATA[21]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[22]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[22]),
        .I2(M1_APB_PRDATA[22]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[22]),
        .O(X_PRDATA[22]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[23]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[23]),
        .I2(M1_APB_PRDATA[23]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[23]),
        .O(X_PRDATA[23]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[24]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[24]),
        .I2(M1_APB_PRDATA[24]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[24]),
        .O(X_PRDATA[24]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[25]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[25]),
        .I2(M1_APB_PRDATA[25]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[25]),
        .O(X_PRDATA[25]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[26]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[26]),
        .I2(M1_APB_PRDATA[26]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[26]),
        .O(X_PRDATA[26]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[27]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[27]),
        .I2(M1_APB_PRDATA[27]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[27]),
        .O(X_PRDATA[27]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[28]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[28]),
        .I2(M1_APB_PRDATA[28]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[28]),
        .O(X_PRDATA[28]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[29]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[29]),
        .I2(M1_APB_PRDATA[29]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[29]),
        .O(X_PRDATA[29]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[2]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[2]),
        .I2(M1_APB_PRDATA[2]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[2]),
        .O(X_PRDATA[2]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[30]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[30]),
        .I2(M1_APB_PRDATA[30]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[30]),
        .O(X_PRDATA[30]));
  LUT6 #(
    .INIT(64'h00000000AAAAAA08)) 
    \DATAR[31]_i_1 
       (.I0(state[1]),
        .I1(M0_APB_PSEL_INST_0_i_1_n_0),
        .I2(\DATAR[31]_i_3_n_0 ),
        .I3(\DATAR[31]_i_4_n_0 ),
        .I4(\DATAR[31]_i_5_n_0 ),
        .I5(state[0]),
        .O(DATAR));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    \DATAR[31]_i_10 
       (.I0(M0_APB_PADDR[26]),
        .I1(M0_APB_PADDR[27]),
        .I2(M0_APB_PADDR[13]),
        .I3(M0_APB_PADDR[28]),
        .O(\DATAR[31]_i_10_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \DATAR[31]_i_11 
       (.I0(M0_APB_PADDR[10]),
        .I1(M0_APB_PADDR[11]),
        .O(\DATAR[31]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[31]_i_2 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[31]),
        .I2(M1_APB_PRDATA[31]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[31]),
        .O(X_PRDATA[31]));
  LUT6 #(
    .INIT(64'h05CF000005050000)) 
    \DATAR[31]_i_3 
       (.I0(\DATAR[31]_i_6_n_0 ),
        .I1(\DATAR[31]_i_7_n_0 ),
        .I2(M1_APB_PSEL_INST_0_i_2_n_0),
        .I3(\DATAR[31]_i_8_n_0 ),
        .I4(M2_APB_PSEL_INST_0_i_1_n_0),
        .I5(M0_APB_PSEL_INST_0_i_2_n_0),
        .O(\DATAR[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0200FFFF02000200)) 
    \DATAR[31]_i_4 
       (.I0(M2_APB_PSEL_INST_0_i_1_n_0),
        .I1(\DATAR[31]_i_6_n_0 ),
        .I2(M1_APB_PSEL_INST_0_i_2_n_0),
        .I3(M2_APB_PREADY),
        .I4(M0_APB_PSEL_INST_0_i_1_n_0),
        .I5(M0_APB_PREADY),
        .O(\DATAR[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h4040404000000040)) 
    \DATAR[31]_i_5 
       (.I0(\DATAR[31]_i_9_n_0 ),
        .I1(M0_APB_PSEL_INST_0_i_2_n_0),
        .I2(M2_APB_PSEL_INST_0_i_1_n_0),
        .I3(\DATAR[31]_i_6_n_0 ),
        .I4(M1_APB_PSEL_INST_0_i_2_n_0),
        .I5(M1_APB_PREADY),
        .O(\DATAR[31]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT5 #(
    .INIT(32'hFFFEAAAA)) 
    \DATAR[31]_i_6 
       (.I0(M2_APB_PSEL_INST_0_i_2_n_0),
        .I1(M0_APB_PADDR[11]),
        .I2(M0_APB_PADDR[10]),
        .I3(M0_APB_PADDR[12]),
        .I4(M0_APB_PADDR[13]),
        .O(\DATAR[31]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFFFFFFFFE)) 
    \DATAR[31]_i_7 
       (.I0(M0_APB_PADDR[12]),
        .I1(M0_APB_PSEL_INST_0_i_3_n_0),
        .I2(M0_APB_PADDR[16]),
        .I3(M0_APB_PADDR[20]),
        .I4(M0_APB_PADDR[19]),
        .I5(M0_APB_PADDR[14]),
        .O(\DATAR[31]_i_7_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hA8)) 
    \DATAR[31]_i_8 
       (.I0(M0_APB_PADDR[12]),
        .I1(M0_APB_PADDR[11]),
        .I2(M0_APB_PADDR[10]),
        .O(\DATAR[31]_i_8_n_0 ));
  LUT6 #(
    .INIT(64'h0000FFFF00100010)) 
    \DATAR[31]_i_9 
       (.I0(M0_APB_PSEL_INST_0_i_3_n_0),
        .I1(M0_APB_PSEL_INST_0_i_4_n_0),
        .I2(M0_APB_PSEL_INST_0_i_6_n_0),
        .I3(\DATAR[31]_i_10_n_0 ),
        .I4(\DATAR[31]_i_11_n_0 ),
        .I5(M0_APB_PADDR[12]),
        .O(\DATAR[31]_i_9_n_0 ));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[3]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[3]),
        .I2(M1_APB_PRDATA[3]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[3]),
        .O(X_PRDATA[3]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[4]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[4]),
        .I2(M1_APB_PRDATA[4]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[4]),
        .O(X_PRDATA[4]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[5]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[5]),
        .I2(M1_APB_PRDATA[5]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[5]),
        .O(X_PRDATA[5]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[6]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[6]),
        .I2(M1_APB_PRDATA[6]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[6]),
        .O(X_PRDATA[6]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[7]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[7]),
        .I2(M1_APB_PRDATA[7]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[7]),
        .O(X_PRDATA[7]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[8]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[8]),
        .I2(M1_APB_PRDATA[8]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[8]),
        .O(X_PRDATA[8]));
  LUT6 #(
    .INIT(64'h44F4FF4444F44444)) 
    \DATAR[9]_i_1 
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PRDATA[9]),
        .I2(M1_APB_PRDATA[9]),
        .I3(\M_PADDR_reg[13]_0 ),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M2_APB_PRDATA[9]),
        .O(X_PRDATA[9]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[0] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[0]),
        .Q(DATAR__0[0]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[10] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[10]),
        .Q(DATAR__0[10]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[11] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[11]),
        .Q(DATAR__0[11]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[12] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[12]),
        .Q(DATAR__0[12]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[13] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[13]),
        .Q(DATAR__0[13]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[14] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[14]),
        .Q(DATAR__0[14]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[15] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[15]),
        .Q(DATAR__0[15]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[16] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[16]),
        .Q(DATAR__0[16]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[17] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[17]),
        .Q(DATAR__0[17]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[18] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[18]),
        .Q(DATAR__0[18]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[19] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[19]),
        .Q(DATAR__0[19]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[1] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[1]),
        .Q(DATAR__0[1]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[20] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[20]),
        .Q(DATAR__0[20]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[21] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[21]),
        .Q(DATAR__0[21]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[22] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[22]),
        .Q(DATAR__0[22]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[23] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[23]),
        .Q(DATAR__0[23]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[24] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[24]),
        .Q(DATAR__0[24]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[25] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[25]),
        .Q(DATAR__0[25]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[26] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[26]),
        .Q(DATAR__0[26]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[27] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[27]),
        .Q(DATAR__0[27]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[28] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[28]),
        .Q(DATAR__0[28]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[29] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[29]),
        .Q(DATAR__0[29]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[2] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[2]),
        .Q(DATAR__0[2]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[30] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[30]),
        .Q(DATAR__0[30]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[31] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[31]),
        .Q(DATAR__0[31]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[3] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[3]),
        .Q(DATAR__0[3]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[4] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[4]),
        .Q(DATAR__0[4]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[5] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[5]),
        .Q(DATAR__0[5]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[6] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[6]),
        .Q(DATAR__0[6]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[7] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[7]),
        .Q(DATAR__0[7]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[8] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[8]),
        .Q(DATAR__0[8]));
  FDCE #(
    .INIT(1'b0)) 
    \DATAR_reg[9] 
       (.C(PCLK),
        .CE(DATAR),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(X_PRDATA[9]),
        .Q(DATAR__0[9]));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT4 #(
    .INIT(16'hC05C)) 
    \FSM_sequential_state[0]_i_1 
       (.I0(\FSM_sequential_state[0]_i_2_n_0 ),
        .I1(\FSM_sequential_state[1]_i_2_n_0 ),
        .I2(state[1]),
        .I3(state[0]),
        .O(\FSM_sequential_state[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0000202750552027)) 
    \FSM_sequential_state[0]_i_2 
       (.I0(\M_PADDR_reg[13]_0 ),
        .I1(M2_APB_PREADY),
        .I2(M0_APB_PSEL_INST_0_i_1_n_0),
        .I3(M0_APB_PREADY),
        .I4(\M_PADDR_reg[12]_0 ),
        .I5(M1_APB_PREADY),
        .O(\FSM_sequential_state[0]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT4 #(
    .INIT(16'hEFFA)) 
    \FSM_sequential_state[1]_i_1 
       (.I0(DATAR),
        .I1(\FSM_sequential_state[1]_i_2_n_0 ),
        .I2(state[1]),
        .I3(state[0]),
        .O(\FSM_sequential_state[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT4 #(
    .INIT(16'h3088)) 
    \FSM_sequential_state[1]_i_2 
       (.I0(Tren_reg_n_0),
        .I1(p_0_in[0]),
        .I2(Twen),
        .I3(p_0_in[1]),
        .O(\FSM_sequential_state[1]_i_2_n_0 ));
  (* FSM_ENCODED_STATES = "ST_ADDR:01,ST_WAIT:10,ST_IDLE:00,ST_END:11" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[0] 
       (.C(PCLK),
        .CE(1'b1),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(\FSM_sequential_state[0]_i_1_n_0 ),
        .Q(state[0]));
  (* FSM_ENCODED_STATES = "ST_ADDR:01,ST_WAIT:10,ST_IDLE:00,ST_END:11" *) 
  FDCE #(
    .INIT(1'b0)) 
    \FSM_sequential_state_reg[1] 
       (.C(PCLK),
        .CE(1'b1),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(\FSM_sequential_state[1]_i_1_n_0 ),
        .Q(state[1]));
  LUT1 #(
    .INIT(2'h1)) 
    M0_APB_PSEL_INST_0
       (.I0(M0_APB_PSEL_INST_0_i_1_n_0),
        .O(M0_APB_PSEL));
  LUT6 #(
    .INIT(64'hFDFFFFFFFFFFFFFF)) 
    M0_APB_PSEL_INST_0_i_1
       (.I0(M0_APB_PSEL_INST_0_i_2_n_0),
        .I1(M0_APB_PSEL_INST_0_i_3_n_0),
        .I2(M0_APB_PSEL_INST_0_i_4_n_0),
        .I3(M0_APB_PSEL_INST_0_i_5_n_0),
        .I4(M0_APB_PSEL_INST_0_i_6_n_0),
        .I5(M2_APB_PSEL_INST_0_i_3_n_0),
        .O(M0_APB_PSEL_INST_0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT5 #(
    .INIT(32'h10000000)) 
    M0_APB_PSEL_INST_0_i_2
       (.I0(M0_APB_PADDR[13]),
        .I1(M0_APB_PADDR[31]),
        .I2(M0_APB_PADDR[30]),
        .I3(X_PSEL),
        .I4(M0_APB_PADDR[29]),
        .O(M0_APB_PSEL_INST_0_i_2_n_0));
  LUT4 #(
    .INIT(16'hFFFE)) 
    M0_APB_PSEL_INST_0_i_3
       (.I0(M0_APB_PADDR[15]),
        .I1(M0_APB_PADDR[21]),
        .I2(M0_APB_PADDR[17]),
        .I3(M0_APB_PADDR[18]),
        .O(M0_APB_PSEL_INST_0_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT4 #(
    .INIT(16'hFFFE)) 
    M0_APB_PSEL_INST_0_i_4
       (.I0(M0_APB_PADDR[16]),
        .I1(M0_APB_PADDR[20]),
        .I2(M0_APB_PADDR[19]),
        .I3(M0_APB_PADDR[14]),
        .O(M0_APB_PSEL_INST_0_i_4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT3 #(
    .INIT(8'h01)) 
    M0_APB_PSEL_INST_0_i_5
       (.I0(M0_APB_PADDR[28]),
        .I1(M0_APB_PADDR[26]),
        .I2(M0_APB_PADDR[27]),
        .O(M0_APB_PSEL_INST_0_i_5_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    M0_APB_PSEL_INST_0_i_6
       (.I0(M0_APB_PADDR[24]),
        .I1(M0_APB_PADDR[25]),
        .I2(M0_APB_PADDR[22]),
        .I3(M0_APB_PADDR[23]),
        .O(M0_APB_PSEL_INST_0_i_6_n_0));
  LUT6 #(
    .INIT(64'h1115111500041115)) 
    M1_APB_PSEL_INST_0
       (.I0(M1_APB_PSEL_INST_0_i_1_n_0),
        .I1(M0_APB_PADDR[12]),
        .I2(M0_APB_PADDR[11]),
        .I3(M0_APB_PADDR[10]),
        .I4(M1_APB_PSEL_INST_0_i_2_n_0),
        .I5(M1_APB_PSEL_INST_0_i_3_n_0),
        .O(\M_PADDR_reg[12]_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFDFFFFFFFF)) 
    M1_APB_PSEL_INST_0_i_1
       (.I0(M0_APB_PSEL_INST_0_i_6_n_0),
        .I1(M1_APB_PSEL_INST_0_i_4_n_0),
        .I2(M0_APB_PADDR[28]),
        .I3(M0_APB_PSEL_INST_0_i_4_n_0),
        .I4(M0_APB_PSEL_INST_0_i_3_n_0),
        .I5(M0_APB_PSEL_INST_0_i_2_n_0),
        .O(M1_APB_PSEL_INST_0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT5 #(
    .INIT(32'h00000002)) 
    M1_APB_PSEL_INST_0_i_2
       (.I0(M0_APB_PSEL_INST_0_i_6_n_0),
        .I1(M0_APB_PADDR[28]),
        .I2(M0_APB_PADDR[13]),
        .I3(M0_APB_PADDR[27]),
        .I4(M0_APB_PADDR[26]),
        .O(M1_APB_PSEL_INST_0_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT5 #(
    .INIT(32'hFFFFFFFE)) 
    M1_APB_PSEL_INST_0_i_3
       (.I0(M0_APB_PADDR[14]),
        .I1(M0_APB_PADDR[19]),
        .I2(M0_APB_PADDR[20]),
        .I3(M0_APB_PADDR[16]),
        .I4(M0_APB_PSEL_INST_0_i_3_n_0),
        .O(M1_APB_PSEL_INST_0_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair75" *) 
  LUT2 #(
    .INIT(4'hE)) 
    M1_APB_PSEL_INST_0_i_4
       (.I0(M0_APB_PADDR[27]),
        .I1(M0_APB_PADDR[26]),
        .O(M1_APB_PSEL_INST_0_i_4_n_0));
  LUT5 #(
    .INIT(32'h00002022)) 
    M2_APB_PSEL_INST_0
       (.I0(M2_APB_PSEL_INST_0_i_1_n_0),
        .I1(M2_APB_PSEL_INST_0_i_2_n_0),
        .I2(M2_APB_PSEL_INST_0_i_3_n_0),
        .I3(M0_APB_PADDR[13]),
        .I4(M1_APB_PSEL_INST_0_i_2_n_0),
        .O(\M_PADDR_reg[13]_0 ));
  LUT6 #(
    .INIT(64'h0000000100000000)) 
    M2_APB_PSEL_INST_0_i_1
       (.I0(M0_APB_PSEL_INST_0_i_3_n_0),
        .I1(M0_APB_PSEL_INST_0_i_4_n_0),
        .I2(M0_APB_PADDR[28]),
        .I3(M0_APB_PADDR[26]),
        .I4(M0_APB_PADDR[27]),
        .I5(M0_APB_PSEL_INST_0_i_6_n_0),
        .O(M2_APB_PSEL_INST_0_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT4 #(
    .INIT(16'hFF7F)) 
    M2_APB_PSEL_INST_0_i_2
       (.I0(M0_APB_PADDR[29]),
        .I1(X_PSEL),
        .I2(M0_APB_PADDR[30]),
        .I3(M0_APB_PADDR[31]),
        .O(M2_APB_PSEL_INST_0_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair74" *) 
  LUT3 #(
    .INIT(8'h01)) 
    M2_APB_PSEL_INST_0_i_3
       (.I0(M0_APB_PADDR[11]),
        .I1(M0_APB_PADDR[10]),
        .I2(M0_APB_PADDR[12]),
        .O(M2_APB_PSEL_INST_0_i_3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[0]_i_1 
       (.I0(Traddr[0]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[0]),
        .O(ADDR[0]));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[10]_i_1 
       (.I0(Traddr[10]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[10]),
        .O(ADDR[10]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[11]_i_1 
       (.I0(Traddr[11]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[11]),
        .O(ADDR[11]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[12]_i_1 
       (.I0(Traddr[12]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[12]),
        .O(ADDR[12]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[13]_i_1 
       (.I0(Traddr[13]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[13]),
        .O(ADDR[13]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[14]_i_1 
       (.I0(Traddr[14]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[14]),
        .O(ADDR[14]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[15]_i_1 
       (.I0(Traddr[15]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[15]),
        .O(ADDR[15]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[16]_i_1 
       (.I0(Traddr[16]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[16]),
        .O(ADDR[16]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[17]_i_1 
       (.I0(Traddr[17]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[17]),
        .O(ADDR[17]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[18]_i_1 
       (.I0(Traddr[18]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[18]),
        .O(ADDR[18]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[19]_i_1 
       (.I0(Traddr[19]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[19]),
        .O(ADDR[19]));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[1]_i_1 
       (.I0(Traddr[1]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[1]),
        .O(ADDR[1]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[20]_i_1 
       (.I0(Traddr[20]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[20]),
        .O(ADDR[20]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[21]_i_1 
       (.I0(Traddr[21]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[21]),
        .O(ADDR[21]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[22]_i_1 
       (.I0(Traddr[22]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[22]),
        .O(ADDR[22]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[23]_i_1 
       (.I0(Traddr[23]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[23]),
        .O(ADDR[23]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[24]_i_1 
       (.I0(Traddr[24]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[24]),
        .O(ADDR[24]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[25]_i_1 
       (.I0(Traddr[25]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[25]),
        .O(ADDR[25]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[26]_i_1 
       (.I0(Traddr[26]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[26]),
        .O(ADDR[26]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[27]_i_1 
       (.I0(Traddr[27]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[27]),
        .O(ADDR[27]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[28]_i_1 
       (.I0(Traddr[28]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[28]),
        .O(ADDR[28]));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[29]_i_1 
       (.I0(Traddr[29]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[29]),
        .O(ADDR[29]));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[2]_i_1 
       (.I0(Traddr[2]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[2]),
        .O(ADDR[2]));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[30]_i_1 
       (.I0(Traddr[30]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[30]),
        .O(ADDR[30]));
  LUT6 #(
    .INIT(64'h0000000005004040)) 
    \M_PADDR[31]_i_1 
       (.I0(state[1]),
        .I1(Tren_reg_n_0),
        .I2(p_0_in[0]),
        .I3(Twen),
        .I4(p_0_in[1]),
        .I5(state[0]),
        .O(\M_PADDR[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[31]_i_2 
       (.I0(Traddr[31]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[31]),
        .O(ADDR[31]));
  LUT1 #(
    .INIT(2'h1)) 
    \M_PADDR[31]_i_3 
       (.I0(PRESETn),
        .O(\M_PADDR[31]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[3]_i_1 
       (.I0(Traddr[3]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[3]),
        .O(ADDR[3]));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[4]_i_1 
       (.I0(Traddr[4]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[4]),
        .O(ADDR[4]));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[5]_i_1 
       (.I0(Traddr[5]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[5]),
        .O(ADDR[5]));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[6]_i_1 
       (.I0(Traddr[6]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[6]),
        .O(ADDR[6]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[7]_i_1 
       (.I0(Traddr[7]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[7]),
        .O(ADDR[7]));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[8]_i_1 
       (.I0(Traddr[8]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[8]),
        .O(ADDR[8]));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT4 #(
    .INIT(16'h3808)) 
    \M_PADDR[9]_i_1 
       (.I0(Traddr[9]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .I3(Twaddr[9]),
        .O(ADDR[9]));
  FDCE \M_PADDR_reg[0] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[0]),
        .Q(M0_APB_PADDR[0]));
  FDCE \M_PADDR_reg[10] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[10]),
        .Q(M0_APB_PADDR[10]));
  FDCE \M_PADDR_reg[11] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[11]),
        .Q(M0_APB_PADDR[11]));
  FDCE \M_PADDR_reg[12] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[12]),
        .Q(M0_APB_PADDR[12]));
  FDCE \M_PADDR_reg[13] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[13]),
        .Q(M0_APB_PADDR[13]));
  FDCE \M_PADDR_reg[14] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[14]),
        .Q(M0_APB_PADDR[14]));
  FDCE \M_PADDR_reg[15] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[15]),
        .Q(M0_APB_PADDR[15]));
  FDCE \M_PADDR_reg[16] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[16]),
        .Q(M0_APB_PADDR[16]));
  FDCE \M_PADDR_reg[17] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[17]),
        .Q(M0_APB_PADDR[17]));
  FDCE \M_PADDR_reg[18] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[18]),
        .Q(M0_APB_PADDR[18]));
  FDCE \M_PADDR_reg[19] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[19]),
        .Q(M0_APB_PADDR[19]));
  FDCE \M_PADDR_reg[1] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[1]),
        .Q(M0_APB_PADDR[1]));
  FDCE \M_PADDR_reg[20] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[20]),
        .Q(M0_APB_PADDR[20]));
  FDCE \M_PADDR_reg[21] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[21]),
        .Q(M0_APB_PADDR[21]));
  FDCE \M_PADDR_reg[22] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[22]),
        .Q(M0_APB_PADDR[22]));
  FDCE \M_PADDR_reg[23] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[23]),
        .Q(M0_APB_PADDR[23]));
  FDCE \M_PADDR_reg[24] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[24]),
        .Q(M0_APB_PADDR[24]));
  FDCE \M_PADDR_reg[25] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[25]),
        .Q(M0_APB_PADDR[25]));
  FDCE \M_PADDR_reg[26] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[26]),
        .Q(M0_APB_PADDR[26]));
  FDCE \M_PADDR_reg[27] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[27]),
        .Q(M0_APB_PADDR[27]));
  FDCE \M_PADDR_reg[28] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[28]),
        .Q(M0_APB_PADDR[28]));
  FDCE \M_PADDR_reg[29] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[29]),
        .Q(M0_APB_PADDR[29]));
  FDCE \M_PADDR_reg[2] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[2]),
        .Q(M0_APB_PADDR[2]));
  FDCE \M_PADDR_reg[30] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[30]),
        .Q(M0_APB_PADDR[30]));
  FDCE \M_PADDR_reg[31] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[31]),
        .Q(M0_APB_PADDR[31]));
  FDCE \M_PADDR_reg[3] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[3]),
        .Q(M0_APB_PADDR[3]));
  FDCE \M_PADDR_reg[4] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[4]),
        .Q(M0_APB_PADDR[4]));
  FDCE \M_PADDR_reg[5] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[5]),
        .Q(M0_APB_PADDR[5]));
  FDCE \M_PADDR_reg[6] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[6]),
        .Q(M0_APB_PADDR[6]));
  FDCE \M_PADDR_reg[7] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[7]),
        .Q(M0_APB_PADDR[7]));
  FDCE \M_PADDR_reg[8] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[8]),
        .Q(M0_APB_PADDR[8]));
  FDCE \M_PADDR_reg[9] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(ADDR[9]),
        .Q(M0_APB_PADDR[9]));
  LUT4 #(
    .INIT(16'h7732)) 
    M_PENABLE_i_1
       (.I0(DATAR),
        .I1(state[1]),
        .I2(state[0]),
        .I3(M2_APB_PENABLE),
        .O(M_PENABLE_i_1_n_0));
  FDCE M_PENABLE_reg
       (.C(PCLK),
        .CE(1'b1),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(M_PENABLE_i_1_n_0),
        .Q(M2_APB_PENABLE));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT5 #(
    .INIT(32'h0CFF0C04)) 
    M_PSEL_i_1
       (.I0(state[0]),
        .I1(\FSM_sequential_state[1]_i_2_n_0 ),
        .I2(state[1]),
        .I3(DATAR),
        .I4(X_PSEL),
        .O(M_PSEL_i_1_n_0));
  FDCE M_PSEL_reg
       (.C(PCLK),
        .CE(1'b1),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(M_PSEL_i_1_n_0),
        .Q(X_PSEL));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \M_PSTRB[0]_i_1 
       (.I0(\Twstrb_reg_n_0_[0] ),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(\M_PSTRB[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \M_PSTRB[1]_i_1 
       (.I0(\Twstrb_reg_n_0_[1] ),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(\M_PSTRB[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \M_PSTRB[2]_i_1 
       (.I0(\Twstrb_reg_n_0_[2] ),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(\M_PSTRB[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT3 #(
    .INIT(8'hEF)) 
    \M_PSTRB[3]_i_1 
       (.I0(\Twstrb_reg_n_0_[3] ),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(\M_PSTRB[3]_i_1_n_0 ));
  FDCE \M_PSTRB_reg[0] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(\M_PSTRB[0]_i_1_n_0 ),
        .Q(M2_APB_PSTRB[0]));
  FDCE \M_PSTRB_reg[1] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(\M_PSTRB[1]_i_1_n_0 ),
        .Q(M2_APB_PSTRB[1]));
  FDCE \M_PSTRB_reg[2] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(\M_PSTRB[2]_i_1_n_0 ),
        .Q(M2_APB_PSTRB[2]));
  FDCE \M_PSTRB_reg[3] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(\M_PSTRB[3]_i_1_n_0 ),
        .Q(M2_APB_PSTRB[3]));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[0]_i_1 
       (.I0(Twdata[0]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[0]));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[10]_i_1 
       (.I0(Twdata[10]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[10]));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[11]_i_1 
       (.I0(Twdata[11]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[11]));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[12]_i_1 
       (.I0(Twdata[12]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[12]));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[13]_i_1 
       (.I0(Twdata[13]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[13]));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[14]_i_1 
       (.I0(Twdata[14]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[14]));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[15]_i_1 
       (.I0(Twdata[15]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[15]));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[16]_i_1 
       (.I0(Twdata[16]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[16]));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[17]_i_1 
       (.I0(Twdata[17]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[17]));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[18]_i_1 
       (.I0(Twdata[18]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[18]));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[19]_i_1 
       (.I0(Twdata[19]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[19]));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[1]_i_1 
       (.I0(Twdata[1]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[1]));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[20]_i_1 
       (.I0(Twdata[20]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[20]));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[21]_i_1 
       (.I0(Twdata[21]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[21]));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[22]_i_1 
       (.I0(Twdata[22]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[22]));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[23]_i_1 
       (.I0(Twdata[23]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[23]));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[24]_i_1 
       (.I0(Twdata[24]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[24]));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[25]_i_1 
       (.I0(Twdata[25]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[25]));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[26]_i_1 
       (.I0(Twdata[26]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[26]));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[27]_i_1 
       (.I0(Twdata[27]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[27]));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[28]_i_1 
       (.I0(Twdata[28]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[28]));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[29]_i_1 
       (.I0(Twdata[29]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[29]));
  (* SOFT_HLUTNM = "soft_lutpair108" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[2]_i_1 
       (.I0(Twdata[2]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[2]));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[30]_i_1 
       (.I0(Twdata[30]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[30]));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[31]_i_1 
       (.I0(Twdata[31]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[31]));
  (* SOFT_HLUTNM = "soft_lutpair70" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[3]_i_1 
       (.I0(Twdata[3]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[3]));
  (* SOFT_HLUTNM = "soft_lutpair69" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[4]_i_1 
       (.I0(Twdata[4]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[4]));
  (* SOFT_HLUTNM = "soft_lutpair68" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[5]_i_1 
       (.I0(Twdata[5]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[5]));
  (* SOFT_HLUTNM = "soft_lutpair67" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[6]_i_1 
       (.I0(Twdata[6]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[6]));
  (* SOFT_HLUTNM = "soft_lutpair66" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[7]_i_1 
       (.I0(Twdata[7]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[7]));
  (* SOFT_HLUTNM = "soft_lutpair65" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[8]_i_1 
       (.I0(Twdata[8]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[8]));
  (* SOFT_HLUTNM = "soft_lutpair64" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \M_PWDATA[9]_i_1 
       (.I0(Twdata[9]),
        .I1(p_0_in[0]),
        .I2(p_0_in[1]),
        .O(DATAW[9]));
  FDCE \M_PWDATA_reg[0] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[0]),
        .Q(M2_APB_PWDATA[0]));
  FDCE \M_PWDATA_reg[10] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[10]),
        .Q(M2_APB_PWDATA[10]));
  FDCE \M_PWDATA_reg[11] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[11]),
        .Q(M2_APB_PWDATA[11]));
  FDCE \M_PWDATA_reg[12] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[12]),
        .Q(M2_APB_PWDATA[12]));
  FDCE \M_PWDATA_reg[13] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[13]),
        .Q(M2_APB_PWDATA[13]));
  FDCE \M_PWDATA_reg[14] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[14]),
        .Q(M2_APB_PWDATA[14]));
  FDCE \M_PWDATA_reg[15] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[15]),
        .Q(M2_APB_PWDATA[15]));
  FDCE \M_PWDATA_reg[16] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[16]),
        .Q(M2_APB_PWDATA[16]));
  FDCE \M_PWDATA_reg[17] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[17]),
        .Q(M2_APB_PWDATA[17]));
  FDCE \M_PWDATA_reg[18] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[18]),
        .Q(M2_APB_PWDATA[18]));
  FDCE \M_PWDATA_reg[19] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[19]),
        .Q(M2_APB_PWDATA[19]));
  FDCE \M_PWDATA_reg[1] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[1]),
        .Q(M2_APB_PWDATA[1]));
  FDCE \M_PWDATA_reg[20] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[20]),
        .Q(M2_APB_PWDATA[20]));
  FDCE \M_PWDATA_reg[21] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[21]),
        .Q(M2_APB_PWDATA[21]));
  FDCE \M_PWDATA_reg[22] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[22]),
        .Q(M2_APB_PWDATA[22]));
  FDCE \M_PWDATA_reg[23] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[23]),
        .Q(M2_APB_PWDATA[23]));
  FDCE \M_PWDATA_reg[24] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[24]),
        .Q(M2_APB_PWDATA[24]));
  FDCE \M_PWDATA_reg[25] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[25]),
        .Q(M2_APB_PWDATA[25]));
  FDCE \M_PWDATA_reg[26] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[26]),
        .Q(M2_APB_PWDATA[26]));
  FDCE \M_PWDATA_reg[27] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[27]),
        .Q(M2_APB_PWDATA[27]));
  FDCE \M_PWDATA_reg[28] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[28]),
        .Q(M2_APB_PWDATA[28]));
  FDCE \M_PWDATA_reg[29] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[29]),
        .Q(M2_APB_PWDATA[29]));
  FDCE \M_PWDATA_reg[2] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[2]),
        .Q(M2_APB_PWDATA[2]));
  FDCE \M_PWDATA_reg[30] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[30]),
        .Q(M2_APB_PWDATA[30]));
  FDCE \M_PWDATA_reg[31] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[31]),
        .Q(M2_APB_PWDATA[31]));
  FDCE \M_PWDATA_reg[3] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[3]),
        .Q(M2_APB_PWDATA[3]));
  FDCE \M_PWDATA_reg[4] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[4]),
        .Q(M2_APB_PWDATA[4]));
  FDCE \M_PWDATA_reg[5] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[5]),
        .Q(M2_APB_PWDATA[5]));
  FDCE \M_PWDATA_reg[6] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[6]),
        .Q(M2_APB_PWDATA[6]));
  FDCE \M_PWDATA_reg[7] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[7]),
        .Q(M2_APB_PWDATA[7]));
  FDCE \M_PWDATA_reg[8] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[8]),
        .Q(M2_APB_PWDATA[8]));
  FDCE \M_PWDATA_reg[9] 
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(DATAW[9]),
        .Q(M2_APB_PWDATA[9]));
  (* SOFT_HLUTNM = "soft_lutpair109" *) 
  LUT2 #(
    .INIT(4'h2)) 
    M_PWRITE_i_1
       (.I0(p_0_in[1]),
        .I1(p_0_in[0]),
        .O(WR));
  FDCE M_PWRITE_reg
       (.C(PCLK),
        .CE(\M_PADDR[31]_i_1_n_0 ),
        .CLR(\M_PADDR[31]_i_3_n_0 ),
        .D(WR),
        .Q(M2_APB_PWRITE));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[0]_i_1 
       (.I0(DATAR__0[0]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[10]_i_1 
       (.I0(DATAR__0[10]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[10]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair97" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[11]_i_1 
       (.I0(DATAR__0[11]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[12]_i_1 
       (.I0(DATAR__0[12]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair98" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[13]_i_1 
       (.I0(DATAR__0[13]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[14]_i_1 
       (.I0(DATAR__0[14]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[14]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair99" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[15]_i_1 
       (.I0(DATAR__0[15]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[16]_i_1 
       (.I0(DATAR__0[16]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair100" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[17]_i_1 
       (.I0(DATAR__0[17]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[17]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[18]_i_1 
       (.I0(DATAR__0[18]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[18]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair101" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[19]_i_1 
       (.I0(DATAR__0[19]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[19]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair92" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[1]_i_1 
       (.I0(DATAR__0[1]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[20]_i_1 
       (.I0(DATAR__0[20]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[20]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair102" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[21]_i_1 
       (.I0(DATAR__0[21]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[21]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[22]_i_1 
       (.I0(DATAR__0[22]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[22]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair103" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[23]_i_1 
       (.I0(DATAR__0[23]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[23]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[24]_i_1 
       (.I0(DATAR__0[24]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[24]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair104" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[25]_i_1 
       (.I0(DATAR__0[25]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[25]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[26]_i_1 
       (.I0(DATAR__0[26]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[26]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair105" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[27]_i_1 
       (.I0(DATAR__0[27]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[27]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[28]_i_1 
       (.I0(DATAR__0[28]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[28]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair106" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[29]_i_1 
       (.I0(DATAR__0[29]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[29]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[2]_i_1 
       (.I0(DATAR__0[2]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[30]_i_1 
       (.I0(DATAR__0[30]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h440050AA)) 
    \RDATA[31]_i_1 
       (.I0(\stateR_reg_n_0_[0] ),
        .I1(s_axi_rready),
        .I2(ACK_reg_n_0),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(\stateR_reg_n_0_[2] ),
        .O(\RDATA[31]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair107" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[31]_i_2 
       (.I0(DATAR__0[31]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[31]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair93" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[3]_i_1 
       (.I0(DATAR__0[3]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[4]_i_1 
       (.I0(DATAR__0[4]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair94" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[5]_i_1 
       (.I0(DATAR__0[5]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[6]_i_1 
       (.I0(DATAR__0[6]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[6]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair95" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[7]_i_1 
       (.I0(DATAR__0[7]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[8]_i_1 
       (.I0(DATAR__0[8]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair96" *) 
  LUT3 #(
    .INIT(8'h20)) 
    \RDATA[9]_i_1 
       (.I0(DATAR__0[9]),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\RDATA[9]_i_1_n_0 ));
  FDCE \RDATA_reg[0] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[0]_i_1_n_0 ),
        .Q(s_axi_rdata[0]));
  FDCE \RDATA_reg[10] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[10]_i_1_n_0 ),
        .Q(s_axi_rdata[10]));
  FDCE \RDATA_reg[11] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[11]_i_1_n_0 ),
        .Q(s_axi_rdata[11]));
  FDCE \RDATA_reg[12] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[12]_i_1_n_0 ),
        .Q(s_axi_rdata[12]));
  FDCE \RDATA_reg[13] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[13]_i_1_n_0 ),
        .Q(s_axi_rdata[13]));
  FDCE \RDATA_reg[14] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[14]_i_1_n_0 ),
        .Q(s_axi_rdata[14]));
  FDCE \RDATA_reg[15] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[15]_i_1_n_0 ),
        .Q(s_axi_rdata[15]));
  FDCE \RDATA_reg[16] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[16]_i_1_n_0 ),
        .Q(s_axi_rdata[16]));
  FDCE \RDATA_reg[17] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[17]_i_1_n_0 ),
        .Q(s_axi_rdata[17]));
  FDCE \RDATA_reg[18] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[18]_i_1_n_0 ),
        .Q(s_axi_rdata[18]));
  FDCE \RDATA_reg[19] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[19]_i_1_n_0 ),
        .Q(s_axi_rdata[19]));
  FDCE \RDATA_reg[1] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[1]_i_1_n_0 ),
        .Q(s_axi_rdata[1]));
  FDCE \RDATA_reg[20] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[20]_i_1_n_0 ),
        .Q(s_axi_rdata[20]));
  FDCE \RDATA_reg[21] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[21]_i_1_n_0 ),
        .Q(s_axi_rdata[21]));
  FDCE \RDATA_reg[22] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[22]_i_1_n_0 ),
        .Q(s_axi_rdata[22]));
  FDCE \RDATA_reg[23] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[23]_i_1_n_0 ),
        .Q(s_axi_rdata[23]));
  FDCE \RDATA_reg[24] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[24]_i_1_n_0 ),
        .Q(s_axi_rdata[24]));
  FDCE \RDATA_reg[25] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[25]_i_1_n_0 ),
        .Q(s_axi_rdata[25]));
  FDCE \RDATA_reg[26] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[26]_i_1_n_0 ),
        .Q(s_axi_rdata[26]));
  FDCE \RDATA_reg[27] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[27]_i_1_n_0 ),
        .Q(s_axi_rdata[27]));
  FDCE \RDATA_reg[28] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[28]_i_1_n_0 ),
        .Q(s_axi_rdata[28]));
  FDCE \RDATA_reg[29] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[29]_i_1_n_0 ),
        .Q(s_axi_rdata[29]));
  FDCE \RDATA_reg[2] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[2]_i_1_n_0 ),
        .Q(s_axi_rdata[2]));
  FDCE \RDATA_reg[30] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[30]_i_1_n_0 ),
        .Q(s_axi_rdata[30]));
  FDCE \RDATA_reg[31] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[31]_i_2_n_0 ),
        .Q(s_axi_rdata[31]));
  FDCE \RDATA_reg[3] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[3]_i_1_n_0 ),
        .Q(s_axi_rdata[3]));
  FDCE \RDATA_reg[4] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[4]_i_1_n_0 ),
        .Q(s_axi_rdata[4]));
  FDCE \RDATA_reg[5] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[5]_i_1_n_0 ),
        .Q(s_axi_rdata[5]));
  FDCE \RDATA_reg[6] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[6]_i_1_n_0 ),
        .Q(s_axi_rdata[6]));
  FDCE \RDATA_reg[7] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[7]_i_1_n_0 ),
        .Q(s_axi_rdata[7]));
  FDCE \RDATA_reg[8] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[8]_i_1_n_0 ),
        .Q(s_axi_rdata[8]));
  FDCE \RDATA_reg[9] 
       (.C(axi_aclk),
        .CE(\RDATA[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\RDATA[9]_i_1_n_0 ),
        .Q(s_axi_rdata[9]));
  LUT3 #(
    .INIT(8'h04)) 
    \RID[3]_i_1 
       (.I0(\stateR_reg_n_0_[1] ),
        .I1(\stateR_reg_n_0_[0] ),
        .I2(\stateR_reg_n_0_[2] ),
        .O(\RID[3]_i_1_n_0 ));
  FDCE \RID_reg[0] 
       (.C(axi_aclk),
        .CE(\RID[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arid[0]),
        .Q(s_axi_rid[0]));
  FDCE \RID_reg[1] 
       (.C(axi_aclk),
        .CE(\RID[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arid[1]),
        .Q(s_axi_rid[1]));
  FDCE \RID_reg[2] 
       (.C(axi_aclk),
        .CE(\RID[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arid[2]),
        .Q(s_axi_rid[2]));
  FDCE \RID_reg[3] 
       (.C(axi_aclk),
        .CE(\RID[3]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_arid[3]),
        .Q(s_axi_rid[3]));
  LUT5 #(
    .INIT(32'h2FFF2000)) 
    RLAST_i_1
       (.I0(ARSTRB_reg1),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(RLAST_i_2_n_0),
        .I3(\stateR_reg_n_0_[0] ),
        .I4(s_axi_rlast),
        .O(RLAST_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT4 #(
    .INIT(16'hA202)) 
    RLAST_i_2
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(ACK_reg_n_0),
        .I2(\stateR_reg_n_0_[1] ),
        .I3(s_axi_rready),
        .O(RLAST_i_2_n_0));
  FDCE RLAST_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(RLAST_i_1_n_0),
        .Q(s_axi_rlast));
  LUT5 #(
    .INIT(32'hFFBF0000)) 
    \RRESP[0]_i_1 
       (.I0(ACK_reg_n_0),
        .I1(\stateR_reg_n_0_[0] ),
        .I2(\stateR_reg_n_0_[2] ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_rresp[0]),
        .O(\RRESP[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT5 #(
    .INIT(32'hFFBF0000)) 
    \RRESP[1]_i_1 
       (.I0(ACK_reg_n_0),
        .I1(\stateR_reg_n_0_[0] ),
        .I2(\stateR_reg_n_0_[2] ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_rresp[1]),
        .O(\RRESP[1]_i_1_n_0 ));
  FDCE \RRESP_reg[0] 
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(\RRESP[0]_i_1_n_0 ),
        .Q(s_axi_rresp[0]));
  FDPE \RRESP_reg[1] 
       (.C(axi_aclk),
        .CE(1'b1),
        .D(\RRESP[1]_i_1_n_0 ),
        .PRE(AWREADY_i_2_n_0),
        .Q(s_axi_rresp[1]));
  LUT6 #(
    .INIT(64'h7F7F7F7F00003000)) 
    RVALID_i_1
       (.I0(s_axi_rready),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(\stateR_reg_n_0_[2] ),
        .I3(\stateR_reg_n_0_[0] ),
        .I4(ACK_reg_n_0),
        .I5(s_axi_rvalid),
        .O(RVALID_i_1_n_0));
  FDCE RVALID_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(RVALID_i_1_n_0),
        .Q(s_axi_rvalid));
  LUT6 #(
    .INIT(64'h08080808303030FF)) 
    \Traddr[31]_i_1 
       (.I0(s_axi_rready),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[0] ),
        .I3(\Traddr[31]_i_2_n_0 ),
        .I4(ACK_reg_n_0),
        .I5(\stateR_reg_n_0_[1] ),
        .O(Trstrb));
  LUT6 #(
    .INIT(64'hFFFF0001FFFFFFFF)) 
    \Traddr[31]_i_2 
       (.I0(ARSTRB_reg[2]),
        .I1(ARSTRB_reg[1]),
        .I2(ARSTRB_reg[3]),
        .I3(ARSTRB_reg[0]),
        .I4(\stateR_reg_n_0_[0] ),
        .I5(\stateR_reg_n_0_[2] ),
        .O(\Traddr[31]_i_2_n_0 ));
  FDCE \Traddr_reg[0] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[0]),
        .Q(Traddr[0]));
  FDCE \Traddr_reg[10] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[10]),
        .Q(Traddr[10]));
  FDCE \Traddr_reg[11] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[11]),
        .Q(Traddr[11]));
  FDCE \Traddr_reg[12] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[12]),
        .Q(Traddr[12]));
  FDCE \Traddr_reg[13] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[13]),
        .Q(Traddr[13]));
  FDCE \Traddr_reg[14] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[14]),
        .Q(Traddr[14]));
  FDCE \Traddr_reg[15] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[15]),
        .Q(Traddr[15]));
  FDCE \Traddr_reg[16] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[16]),
        .Q(Traddr[16]));
  FDCE \Traddr_reg[17] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[17]),
        .Q(Traddr[17]));
  FDCE \Traddr_reg[18] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[18]),
        .Q(Traddr[18]));
  FDCE \Traddr_reg[19] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[19]),
        .Q(Traddr[19]));
  FDCE \Traddr_reg[1] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[1]),
        .Q(Traddr[1]));
  FDCE \Traddr_reg[20] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[20]),
        .Q(Traddr[20]));
  FDCE \Traddr_reg[21] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[21]),
        .Q(Traddr[21]));
  FDCE \Traddr_reg[22] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[22]),
        .Q(Traddr[22]));
  FDCE \Traddr_reg[23] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[23]),
        .Q(Traddr[23]));
  FDCE \Traddr_reg[24] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[24]),
        .Q(Traddr[24]));
  FDCE \Traddr_reg[25] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[25]),
        .Q(Traddr[25]));
  FDCE \Traddr_reg[26] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[26]),
        .Q(Traddr[26]));
  FDCE \Traddr_reg[27] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[27]),
        .Q(Traddr[27]));
  FDCE \Traddr_reg[28] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[28]),
        .Q(Traddr[28]));
  FDCE \Traddr_reg[29] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[29]),
        .Q(Traddr[29]));
  FDCE \Traddr_reg[2] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[2]),
        .Q(Traddr[2]));
  FDCE \Traddr_reg[30] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[30]),
        .Q(Traddr[30]));
  FDCE \Traddr_reg[31] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[31]),
        .Q(Traddr[31]));
  FDCE \Traddr_reg[3] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[3]),
        .Q(Traddr[3]));
  FDCE \Traddr_reg[4] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[4]),
        .Q(Traddr[4]));
  FDCE \Traddr_reg[5] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[5]),
        .Q(Traddr[5]));
  FDCE \Traddr_reg[6] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[6]),
        .Q(Traddr[6]));
  FDCE \Traddr_reg[7] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[7]),
        .Q(Traddr[7]));
  FDCE \Traddr_reg[8] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[8]),
        .Q(Traddr[8]));
  FDCE \Traddr_reg[9] 
       (.C(axi_aclk),
        .CE(Trstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(addrRT[9]),
        .Q(Traddr[9]));
  LUT6 #(
    .INIT(64'hC077FFFFC0770000)) 
    Tren_i_1
       (.I0(Tren_i_2_n_0),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(s_axi_rready),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(Tren_i_3_n_0),
        .I5(Tren_reg_n_0),
        .O(Tren_i_1_n_0));
  LUT4 #(
    .INIT(16'h0001)) 
    Tren_i_2
       (.I0(ARSTRB_reg[0]),
        .I1(ARSTRB_reg[3]),
        .I2(ARSTRB_reg[1]),
        .I3(ARSTRB_reg[2]),
        .O(Tren_i_2_n_0));
  LUT6 #(
    .INIT(64'h03070307F0C53005)) 
    Tren_i_3
       (.I0(\Traddr[31]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .I3(ACK_reg_n_0),
        .I4(s_axi_rready),
        .I5(\stateR_reg_n_0_[0] ),
        .O(Tren_i_3_n_0));
  FDCE Tren_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(Tren_i_1_n_0),
        .Q(Tren_reg_n_0));
  LUT6 #(
    .INIT(64'h0000030000AA0000)) 
    \Twaddr[31]_i_1 
       (.I0(s_axi_wvalid),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(ACK_reg_n_0),
        .I3(\stateW_reg_n_0_[0] ),
        .I4(\stateW_reg_n_0_[1] ),
        .I5(\stateW_reg_n_0_[2] ),
        .O(\Twaddr[31]_i_1_n_0 ));
  FDCE \Twaddr_reg[0] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[0]),
        .Q(Twaddr[0]));
  FDCE \Twaddr_reg[10] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[10]),
        .Q(Twaddr[10]));
  FDCE \Twaddr_reg[11] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[11]),
        .Q(Twaddr[11]));
  FDCE \Twaddr_reg[12] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[12]),
        .Q(Twaddr[12]));
  FDCE \Twaddr_reg[13] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[13]),
        .Q(Twaddr[13]));
  FDCE \Twaddr_reg[14] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[14]),
        .Q(Twaddr[14]));
  FDCE \Twaddr_reg[15] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[15]),
        .Q(Twaddr[15]));
  FDCE \Twaddr_reg[16] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[16]),
        .Q(Twaddr[16]));
  FDCE \Twaddr_reg[17] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[17]),
        .Q(Twaddr[17]));
  FDCE \Twaddr_reg[18] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[18]),
        .Q(Twaddr[18]));
  FDCE \Twaddr_reg[19] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[19]),
        .Q(Twaddr[19]));
  FDCE \Twaddr_reg[1] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[1]),
        .Q(Twaddr[1]));
  FDCE \Twaddr_reg[20] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[20]),
        .Q(Twaddr[20]));
  FDCE \Twaddr_reg[21] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[21]),
        .Q(Twaddr[21]));
  FDCE \Twaddr_reg[22] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[22]),
        .Q(Twaddr[22]));
  FDCE \Twaddr_reg[23] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[23]),
        .Q(Twaddr[23]));
  FDCE \Twaddr_reg[24] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[24]),
        .Q(Twaddr[24]));
  FDCE \Twaddr_reg[25] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[25]),
        .Q(Twaddr[25]));
  FDCE \Twaddr_reg[26] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[26]),
        .Q(Twaddr[26]));
  FDCE \Twaddr_reg[27] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[27]),
        .Q(Twaddr[27]));
  FDCE \Twaddr_reg[28] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[28]),
        .Q(Twaddr[28]));
  FDCE \Twaddr_reg[29] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[29]),
        .Q(Twaddr[29]));
  FDCE \Twaddr_reg[2] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[2]),
        .Q(Twaddr[2]));
  FDCE \Twaddr_reg[30] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[30]),
        .Q(Twaddr[30]));
  FDCE \Twaddr_reg[31] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[31]),
        .Q(Twaddr[31]));
  FDCE \Twaddr_reg[3] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[3]),
        .Q(Twaddr[3]));
  FDCE \Twaddr_reg[4] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[4]),
        .Q(Twaddr[4]));
  FDCE \Twaddr_reg[5] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[5]),
        .Q(Twaddr[5]));
  FDCE \Twaddr_reg[6] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[6]),
        .Q(Twaddr[6]));
  FDCE \Twaddr_reg[7] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[7]),
        .Q(Twaddr[7]));
  FDCE \Twaddr_reg[8] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[8]),
        .Q(Twaddr[8]));
  FDCE \Twaddr_reg[9] 
       (.C(axi_aclk),
        .CE(\Twaddr[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(addrWT[9]),
        .Q(Twaddr[9]));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[0]_i_1 
       (.I0(WDATA_reg[0]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[0]),
        .O(\Twdata[0]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[10]_i_1 
       (.I0(WDATA_reg[10]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[10]),
        .O(\Twdata[10]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[11]_i_1 
       (.I0(WDATA_reg[11]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[11]),
        .O(\Twdata[11]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[12]_i_1 
       (.I0(WDATA_reg[12]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[12]),
        .O(\Twdata[12]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[13]_i_1 
       (.I0(WDATA_reg[13]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[13]),
        .O(\Twdata[13]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[14]_i_1 
       (.I0(WDATA_reg[14]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[14]),
        .O(\Twdata[14]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[15]_i_1 
       (.I0(WDATA_reg[15]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[15]),
        .O(\Twdata[15]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[16]_i_1 
       (.I0(WDATA_reg[16]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[16]),
        .O(\Twdata[16]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[17]_i_1 
       (.I0(WDATA_reg[17]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[17]),
        .O(\Twdata[17]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[18]_i_1 
       (.I0(WDATA_reg[18]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[18]),
        .O(\Twdata[18]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[19]_i_1 
       (.I0(WDATA_reg[19]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[19]),
        .O(\Twdata[19]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[1]_i_1 
       (.I0(WDATA_reg[1]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[1]),
        .O(\Twdata[1]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[20]_i_1 
       (.I0(WDATA_reg[20]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[20]),
        .O(\Twdata[20]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[21]_i_1 
       (.I0(WDATA_reg[21]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[21]),
        .O(\Twdata[21]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[22]_i_1 
       (.I0(WDATA_reg[22]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[22]),
        .O(\Twdata[22]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[23]_i_1 
       (.I0(WDATA_reg[23]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[23]),
        .O(\Twdata[23]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[24]_i_1 
       (.I0(WDATA_reg[24]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[24]),
        .O(\Twdata[24]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[25]_i_1 
       (.I0(WDATA_reg[25]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[25]),
        .O(\Twdata[25]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[26]_i_1 
       (.I0(WDATA_reg[26]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[26]),
        .O(\Twdata[26]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[27]_i_1 
       (.I0(WDATA_reg[27]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[27]),
        .O(\Twdata[27]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[28]_i_1 
       (.I0(WDATA_reg[28]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[28]),
        .O(\Twdata[28]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[29]_i_1 
       (.I0(WDATA_reg[29]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[29]),
        .O(\Twdata[29]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[2]_i_1 
       (.I0(WDATA_reg[2]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[2]),
        .O(\Twdata[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[30]_i_1 
       (.I0(WDATA_reg[30]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[30]),
        .O(\Twdata[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00200C20)) 
    \Twdata[31]_i_1 
       (.I0(s_axi_wvalid),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\stateW_reg_n_0_[0] ),
        .I4(ACK_reg_n_0),
        .O(Twstrb));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[31]_i_2 
       (.I0(WDATA_reg[31]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[31]),
        .O(\Twdata[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[3]_i_1 
       (.I0(WDATA_reg[3]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[3]),
        .O(\Twdata[3]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[4]_i_1 
       (.I0(WDATA_reg[4]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[4]),
        .O(\Twdata[4]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[5]_i_1 
       (.I0(WDATA_reg[5]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[5]),
        .O(\Twdata[5]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[6]_i_1 
       (.I0(WDATA_reg[6]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[6]),
        .O(\Twdata[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[7]_i_1 
       (.I0(WDATA_reg[7]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[7]),
        .O(\Twdata[7]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[8]_i_1 
       (.I0(WDATA_reg[8]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[8]),
        .O(\Twdata[8]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h2F20)) 
    \Twdata[9]_i_1 
       (.I0(WDATA_reg[9]),
        .I1(\stateW[2]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wdata[9]),
        .O(\Twdata[9]_i_1_n_0 ));
  FDCE \Twdata_reg[0] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[0]_i_1_n_0 ),
        .Q(Twdata[0]));
  FDCE \Twdata_reg[10] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[10]_i_1_n_0 ),
        .Q(Twdata[10]));
  FDCE \Twdata_reg[11] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[11]_i_1_n_0 ),
        .Q(Twdata[11]));
  FDCE \Twdata_reg[12] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[12]_i_1_n_0 ),
        .Q(Twdata[12]));
  FDCE \Twdata_reg[13] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[13]_i_1_n_0 ),
        .Q(Twdata[13]));
  FDCE \Twdata_reg[14] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[14]_i_1_n_0 ),
        .Q(Twdata[14]));
  FDCE \Twdata_reg[15] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[15]_i_1_n_0 ),
        .Q(Twdata[15]));
  FDCE \Twdata_reg[16] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[16]_i_1_n_0 ),
        .Q(Twdata[16]));
  FDCE \Twdata_reg[17] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[17]_i_1_n_0 ),
        .Q(Twdata[17]));
  FDCE \Twdata_reg[18] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[18]_i_1_n_0 ),
        .Q(Twdata[18]));
  FDCE \Twdata_reg[19] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[19]_i_1_n_0 ),
        .Q(Twdata[19]));
  FDCE \Twdata_reg[1] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[1]_i_1_n_0 ),
        .Q(Twdata[1]));
  FDCE \Twdata_reg[20] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[20]_i_1_n_0 ),
        .Q(Twdata[20]));
  FDCE \Twdata_reg[21] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[21]_i_1_n_0 ),
        .Q(Twdata[21]));
  FDCE \Twdata_reg[22] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[22]_i_1_n_0 ),
        .Q(Twdata[22]));
  FDCE \Twdata_reg[23] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[23]_i_1_n_0 ),
        .Q(Twdata[23]));
  FDCE \Twdata_reg[24] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[24]_i_1_n_0 ),
        .Q(Twdata[24]));
  FDCE \Twdata_reg[25] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[25]_i_1_n_0 ),
        .Q(Twdata[25]));
  FDCE \Twdata_reg[26] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[26]_i_1_n_0 ),
        .Q(Twdata[26]));
  FDCE \Twdata_reg[27] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[27]_i_1_n_0 ),
        .Q(Twdata[27]));
  FDCE \Twdata_reg[28] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[28]_i_1_n_0 ),
        .Q(Twdata[28]));
  FDCE \Twdata_reg[29] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[29]_i_1_n_0 ),
        .Q(Twdata[29]));
  FDCE \Twdata_reg[2] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[2]_i_1_n_0 ),
        .Q(Twdata[2]));
  FDCE \Twdata_reg[30] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[30]_i_1_n_0 ),
        .Q(Twdata[30]));
  FDCE \Twdata_reg[31] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[31]_i_2_n_0 ),
        .Q(Twdata[31]));
  FDCE \Twdata_reg[3] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[3]_i_1_n_0 ),
        .Q(Twdata[3]));
  FDCE \Twdata_reg[4] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[4]_i_1_n_0 ),
        .Q(Twdata[4]));
  FDCE \Twdata_reg[5] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[5]_i_1_n_0 ),
        .Q(Twdata[5]));
  FDCE \Twdata_reg[6] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[6]_i_1_n_0 ),
        .Q(Twdata[6]));
  FDCE \Twdata_reg[7] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[7]_i_1_n_0 ),
        .Q(Twdata[7]));
  FDCE \Twdata_reg[8] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[8]_i_1_n_0 ),
        .Q(Twdata[8]));
  FDCE \Twdata_reg[9] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twdata[9]_i_1_n_0 ),
        .Q(Twdata[9]));
  LUT6 #(
    .INIT(64'h444FFFFF444F0000)) 
    Twen_i_1
       (.I0(\stateW_reg_n_0_[0] ),
        .I1(s_axi_wvalid),
        .I2(\stateW[2]_i_2_n_0 ),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(Twen_i_2_n_0),
        .I5(Twen),
        .O(Twen_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT5 #(
    .INIT(32'h0010CF00)) 
    Twen_i_2
       (.I0(\stateW[2]_i_2_n_0 ),
        .I1(ACK_reg_n_0),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(\stateW_reg_n_0_[2] ),
        .O(Twen_i_2_n_0));
  FDCE Twen_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(Twen_i_1_n_0),
        .Q(Twen));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \Twstrb[0]_i_1 
       (.I0(\WSTRB_reg_reg_n_0_[0] ),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(s_axi_wstrb[0]),
        .O(\Twstrb[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair111" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \Twstrb[1]_i_1 
       (.I0(\WSTRB_reg_reg_n_0_[1] ),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(s_axi_wstrb[1]),
        .O(\Twstrb[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \Twstrb[2]_i_1 
       (.I0(\WSTRB_reg_reg_n_0_[2] ),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(s_axi_wstrb[2]),
        .O(\Twstrb[2]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair110" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \Twstrb[3]_i_1 
       (.I0(\WSTRB_reg_reg_n_0_[3] ),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(s_axi_wstrb[3]),
        .O(\Twstrb[3]_i_1_n_0 ));
  FDCE \Twstrb_reg[0] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twstrb[0]_i_1_n_0 ),
        .Q(\Twstrb_reg_n_0_[0] ));
  FDCE \Twstrb_reg[1] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twstrb[1]_i_1_n_0 ),
        .Q(\Twstrb_reg_n_0_[1] ));
  FDCE \Twstrb_reg[2] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twstrb[2]_i_1_n_0 ),
        .Q(\Twstrb_reg_n_0_[2] ));
  FDCE \Twstrb_reg[3] 
       (.C(axi_aclk),
        .CE(Twstrb),
        .CLR(AWREADY_i_2_n_0),
        .D(\Twstrb[3]_i_1_n_0 ),
        .Q(\Twstrb_reg_n_0_[3] ));
  FDCE \WDATA_reg_reg[0] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[0]),
        .Q(WDATA_reg[0]));
  FDCE \WDATA_reg_reg[10] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[10]),
        .Q(WDATA_reg[10]));
  FDCE \WDATA_reg_reg[11] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[11]),
        .Q(WDATA_reg[11]));
  FDCE \WDATA_reg_reg[12] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[12]),
        .Q(WDATA_reg[12]));
  FDCE \WDATA_reg_reg[13] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[13]),
        .Q(WDATA_reg[13]));
  FDCE \WDATA_reg_reg[14] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[14]),
        .Q(WDATA_reg[14]));
  FDCE \WDATA_reg_reg[15] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[15]),
        .Q(WDATA_reg[15]));
  FDCE \WDATA_reg_reg[16] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[16]),
        .Q(WDATA_reg[16]));
  FDCE \WDATA_reg_reg[17] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[17]),
        .Q(WDATA_reg[17]));
  FDCE \WDATA_reg_reg[18] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[18]),
        .Q(WDATA_reg[18]));
  FDCE \WDATA_reg_reg[19] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[19]),
        .Q(WDATA_reg[19]));
  FDCE \WDATA_reg_reg[1] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[1]),
        .Q(WDATA_reg[1]));
  FDCE \WDATA_reg_reg[20] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[20]),
        .Q(WDATA_reg[20]));
  FDCE \WDATA_reg_reg[21] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[21]),
        .Q(WDATA_reg[21]));
  FDCE \WDATA_reg_reg[22] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[22]),
        .Q(WDATA_reg[22]));
  FDCE \WDATA_reg_reg[23] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[23]),
        .Q(WDATA_reg[23]));
  FDCE \WDATA_reg_reg[24] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[24]),
        .Q(WDATA_reg[24]));
  FDCE \WDATA_reg_reg[25] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[25]),
        .Q(WDATA_reg[25]));
  FDCE \WDATA_reg_reg[26] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[26]),
        .Q(WDATA_reg[26]));
  FDCE \WDATA_reg_reg[27] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[27]),
        .Q(WDATA_reg[27]));
  FDCE \WDATA_reg_reg[28] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[28]),
        .Q(WDATA_reg[28]));
  FDCE \WDATA_reg_reg[29] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[29]),
        .Q(WDATA_reg[29]));
  FDCE \WDATA_reg_reg[2] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[2]),
        .Q(WDATA_reg[2]));
  FDCE \WDATA_reg_reg[30] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[30]),
        .Q(WDATA_reg[30]));
  FDCE \WDATA_reg_reg[31] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[31]),
        .Q(WDATA_reg[31]));
  FDCE \WDATA_reg_reg[3] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[3]),
        .Q(WDATA_reg[3]));
  FDCE \WDATA_reg_reg[4] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[4]),
        .Q(WDATA_reg[4]));
  FDCE \WDATA_reg_reg[5] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[5]),
        .Q(WDATA_reg[5]));
  FDCE \WDATA_reg_reg[6] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[6]),
        .Q(WDATA_reg[6]));
  FDCE \WDATA_reg_reg[7] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[7]),
        .Q(WDATA_reg[7]));
  FDCE \WDATA_reg_reg[8] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[8]),
        .Q(WDATA_reg[8]));
  FDCE \WDATA_reg_reg[9] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wdata[9]),
        .Q(WDATA_reg[9]));
  LUT6 #(
    .INIT(64'hFFFFF5FF000F3000)) 
    WREADY_i_1
       (.I0(s_axi_wvalid),
        .I1(ACK_reg_n_0),
        .I2(\stateW_reg_n_0_[2] ),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(\stateW_reg_n_0_[0] ),
        .I5(s_axi_wready),
        .O(WREADY_i_1_n_0));
  FDCE WREADY_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(WREADY_i_1_n_0),
        .Q(s_axi_wready));
  LUT4 #(
    .INIT(16'h0400)) 
    \WSTRB_reg[3]_i_1 
       (.I0(\stateW_reg_n_0_[2] ),
        .I1(\stateW_reg_n_0_[1] ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(s_axi_wvalid),
        .O(WSTRB_reg));
  FDCE \WSTRB_reg_reg[0] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wstrb[0]),
        .Q(\WSTRB_reg_reg_n_0_[0] ));
  FDCE \WSTRB_reg_reg[1] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wstrb[1]),
        .Q(\WSTRB_reg_reg_n_0_[1] ));
  FDCE \WSTRB_reg_reg[2] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wstrb[2]),
        .Q(\WSTRB_reg_reg_n_0_[2] ));
  FDCE \WSTRB_reg_reg[3] 
       (.C(axi_aclk),
        .CE(WSTRB_reg),
        .CLR(AWREADY_i_2_n_0),
        .D(s_axi_wstrb[3]),
        .Q(\WSTRB_reg_reg_n_0_[3] ));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrRT0_carry
       (.CI(1'b0),
        .CO({addrRT0_carry_n_0,addrRT0_carry_n_1,addrRT0_carry_n_2,addrRT0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,addrRT[2],1'b0}),
        .O(addrRT0[4:1]),
        .S({addrRT[4:3],addrRT0_carry_i_1_n_0,addrRT[1]}));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrRT0_carry__0
       (.CI(addrRT0_carry_n_0),
        .CO({addrRT0_carry__0_n_0,addrRT0_carry__0_n_1,addrRT0_carry__0_n_2,addrRT0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrRT0[8:5]),
        .S(addrRT[8:5]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrRT0_carry__1
       (.CI(addrRT0_carry__0_n_0),
        .CO({addrRT0_carry__1_n_0,addrRT0_carry__1_n_1,addrRT0_carry__1_n_2,addrRT0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrRT0[12:9]),
        .S(addrRT[12:9]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrRT0_carry__2
       (.CI(addrRT0_carry__1_n_0),
        .CO({addrRT0_carry__2_n_0,addrRT0_carry__2_n_1,addrRT0_carry__2_n_2,addrRT0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrRT0[16:13]),
        .S(addrRT[16:13]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrRT0_carry__3
       (.CI(addrRT0_carry__2_n_0),
        .CO({addrRT0_carry__3_n_0,addrRT0_carry__3_n_1,addrRT0_carry__3_n_2,addrRT0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrRT0[20:17]),
        .S(addrRT[20:17]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrRT0_carry__4
       (.CI(addrRT0_carry__3_n_0),
        .CO({addrRT0_carry__4_n_0,addrRT0_carry__4_n_1,addrRT0_carry__4_n_2,addrRT0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrRT0[24:21]),
        .S(addrRT[24:21]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrRT0_carry__5
       (.CI(addrRT0_carry__4_n_0),
        .CO({addrRT0_carry__5_n_0,addrRT0_carry__5_n_1,addrRT0_carry__5_n_2,addrRT0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrRT0[28:25]),
        .S(addrRT[28:25]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrRT0_carry__6
       (.CI(addrRT0_carry__5_n_0),
        .CO({NLW_addrRT0_carry__6_CO_UNCONNECTED[3:2],addrRT0_carry__6_n_2,addrRT0_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_addrRT0_carry__6_O_UNCONNECTED[3],addrRT0[31:29]}),
        .S({1'b0,addrRT[31:29]}));
  LUT1 #(
    .INIT(2'h1)) 
    addrRT0_carry_i_1
       (.I0(addrRT[2]),
        .O(addrRT0_carry_i_1_n_0));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[0]_i_1 
       (.I0(addrRT[0]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[0]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[0]),
        .O(\addrRT[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[10]_i_1 
       (.I0(addrRT0[10]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[10]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[10]),
        .O(\addrRT[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[11]_i_1 
       (.I0(addrRT0[11]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[11]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[11]),
        .O(\addrRT[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[12]_i_1 
       (.I0(addrRT0[12]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[12]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[12]),
        .O(\addrRT[12]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[13]_i_1 
       (.I0(addrRT0[13]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[13]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[13]),
        .O(\addrRT[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[14]_i_1 
       (.I0(addrRT0[14]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[14]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[14]),
        .O(\addrRT[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[15]_i_1 
       (.I0(addrRT0[15]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[15]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[15]),
        .O(\addrRT[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[16]_i_1 
       (.I0(addrRT0[16]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[16]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[16]),
        .O(\addrRT[16]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[17]_i_1 
       (.I0(addrRT0[17]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[17]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[17]),
        .O(\addrRT[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[18]_i_1 
       (.I0(addrRT0[18]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[18]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[18]),
        .O(\addrRT[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[19]_i_1 
       (.I0(addrRT0[19]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[19]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[19]),
        .O(\addrRT[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[1]_i_1 
       (.I0(addrRT0[1]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[1]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[1]),
        .O(\addrRT[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[20]_i_1 
       (.I0(addrRT0[20]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[20]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[20]),
        .O(\addrRT[20]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[21]_i_1 
       (.I0(addrRT0[21]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[21]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[21]),
        .O(\addrRT[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[22]_i_1 
       (.I0(addrRT0[22]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[22]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[22]),
        .O(\addrRT[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[23]_i_1 
       (.I0(addrRT0[23]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[23]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[23]),
        .O(\addrRT[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[24]_i_1 
       (.I0(addrRT0[24]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[24]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[24]),
        .O(\addrRT[24]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[25]_i_1 
       (.I0(addrRT0[25]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[25]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[25]),
        .O(\addrRT[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[26]_i_1 
       (.I0(addrRT0[26]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[26]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[26]),
        .O(\addrRT[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[27]_i_1 
       (.I0(addrRT0[27]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[27]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[27]),
        .O(\addrRT[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[28]_i_1 
       (.I0(addrRT0[28]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[28]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[28]),
        .O(\addrRT[28]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[29]_i_1 
       (.I0(addrRT0[29]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[29]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[29]),
        .O(\addrRT[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[2]_i_1 
       (.I0(addrRT0[2]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[2]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[2]),
        .O(\addrRT[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[30]_i_1 
       (.I0(addrRT0[30]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[30]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[30]),
        .O(\addrRT[30]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hAAAAFEAA)) 
    \addrRT[31]_i_1 
       (.I0(\ARLEN_reg[7]_i_1_n_0 ),
        .I1(ACK_reg_n_0),
        .I2(\stateR_reg_n_0_[0] ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(\stateR_reg_n_0_[2] ),
        .O(\addrRT[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[31]_i_2 
       (.I0(addrRT0[31]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[31]_i_3_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[31]),
        .O(\addrRT[31]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[3]_i_1 
       (.I0(addrRT0[3]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[3]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[3]),
        .O(\addrRT[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[4]_i_1 
       (.I0(addrRT0[4]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[4]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[4]),
        .O(\addrRT[4]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[5]_i_1 
       (.I0(addrRT0[5]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[5]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[5]),
        .O(\addrRT[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[6]_i_1 
       (.I0(addrRT0[6]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[6]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[6]),
        .O(\addrRT[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[7]_i_1 
       (.I0(addrRT0[7]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[7]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[7]),
        .O(\addrRT[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[8]_i_1 
       (.I0(addrRT0[8]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[8]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[8]),
        .O(\addrRT[8]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8FFB800)) 
    \addrRT[9]_i_1 
       (.I0(addrRT0[9]),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\addrR[9]_i_2_n_0 ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_araddr[9]),
        .O(\addrRT[9]_i_1_n_0 ));
  FDCE \addrRT_reg[0] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[0]_i_1_n_0 ),
        .Q(addrRT[0]));
  FDCE \addrRT_reg[10] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[10]_i_1_n_0 ),
        .Q(addrRT[10]));
  FDCE \addrRT_reg[11] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[11]_i_1_n_0 ),
        .Q(addrRT[11]));
  FDCE \addrRT_reg[12] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[12]_i_1_n_0 ),
        .Q(addrRT[12]));
  FDCE \addrRT_reg[13] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[13]_i_1_n_0 ),
        .Q(addrRT[13]));
  FDCE \addrRT_reg[14] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[14]_i_1_n_0 ),
        .Q(addrRT[14]));
  FDCE \addrRT_reg[15] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[15]_i_1_n_0 ),
        .Q(addrRT[15]));
  FDCE \addrRT_reg[16] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[16]_i_1_n_0 ),
        .Q(addrRT[16]));
  FDCE \addrRT_reg[17] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[17]_i_1_n_0 ),
        .Q(addrRT[17]));
  FDCE \addrRT_reg[18] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[18]_i_1_n_0 ),
        .Q(addrRT[18]));
  FDCE \addrRT_reg[19] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[19]_i_1_n_0 ),
        .Q(addrRT[19]));
  FDCE \addrRT_reg[1] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[1]_i_1_n_0 ),
        .Q(addrRT[1]));
  FDCE \addrRT_reg[20] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[20]_i_1_n_0 ),
        .Q(addrRT[20]));
  FDCE \addrRT_reg[21] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[21]_i_1_n_0 ),
        .Q(addrRT[21]));
  FDCE \addrRT_reg[22] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[22]_i_1_n_0 ),
        .Q(addrRT[22]));
  FDCE \addrRT_reg[23] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[23]_i_1_n_0 ),
        .Q(addrRT[23]));
  FDCE \addrRT_reg[24] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[24]_i_1_n_0 ),
        .Q(addrRT[24]));
  FDCE \addrRT_reg[25] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[25]_i_1_n_0 ),
        .Q(addrRT[25]));
  FDCE \addrRT_reg[26] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[26]_i_1_n_0 ),
        .Q(addrRT[26]));
  FDCE \addrRT_reg[27] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[27]_i_1_n_0 ),
        .Q(addrRT[27]));
  FDCE \addrRT_reg[28] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[28]_i_1_n_0 ),
        .Q(addrRT[28]));
  FDCE \addrRT_reg[29] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[29]_i_1_n_0 ),
        .Q(addrRT[29]));
  FDCE \addrRT_reg[2] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[2]_i_1_n_0 ),
        .Q(addrRT[2]));
  FDCE \addrRT_reg[30] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[30]_i_1_n_0 ),
        .Q(addrRT[30]));
  FDCE \addrRT_reg[31] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[31]_i_2_n_0 ),
        .Q(addrRT[31]));
  FDCE \addrRT_reg[3] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[3]_i_1_n_0 ),
        .Q(addrRT[3]));
  FDCE \addrRT_reg[4] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[4]_i_1_n_0 ),
        .Q(addrRT[4]));
  FDCE \addrRT_reg[5] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[5]_i_1_n_0 ),
        .Q(addrRT[5]));
  FDCE \addrRT_reg[6] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[6]_i_1_n_0 ),
        .Q(addrRT[6]));
  FDCE \addrRT_reg[7] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[7]_i_1_n_0 ),
        .Q(addrRT[7]));
  FDCE \addrRT_reg[8] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[8]_i_1_n_0 ),
        .Q(addrRT[8]));
  FDCE \addrRT_reg[9] 
       (.C(axi_aclk),
        .CE(\addrRT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrRT[9]_i_1_n_0 ),
        .Q(addrRT[9]));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[0]_i_1 
       (.I0(\addrR[0]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[0]),
        .O(\addrR[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA0CCA0CCAFCCA0C)) 
    \addrR[0]_i_2 
       (.I0(\addrR[0]_i_3_n_0 ),
        .I1(\addrR_reg_n_0_[0] ),
        .I2(\ARBURST_reg_reg_n_0_[0] ),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(get_next_addr_rd00_in[0]),
        .I5(\ARSTRB_reg[3]_i_4_n_0 ),
        .O(\addrR[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \addrR[0]_i_3 
       (.I0(\addrR_reg_n_0_[0] ),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[0]),
        .I4(ARLEN_reg[0]),
        .I5(get_next_addr_rd2[0]),
        .O(\addrR[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[10]_i_1 
       (.I0(\addrR[10]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[10]),
        .O(\addrR[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrR[10]_i_2 
       (.I0(\addrR_reg_n_0_[10] ),
        .I1(\ARSTRB_reg[1]_i_3_n_0 ),
        .I2(p_1_out_carry__1_n_7),
        .I3(get_next_addr_rd2[10]),
        .I4(\addrR[15]_i_4_n_0 ),
        .I5(\addrR[10]_i_3_n_0 ),
        .O(\addrR[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrR[10]_i_3 
       (.I0(get_next_addr_rd0[8]),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(get_next_addr_rd00_in[10]),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(\ARBURST_reg_reg_n_0_[0] ),
        .I5(\addrR_reg_n_0_[10] ),
        .O(\addrR[10]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[11]_i_1 
       (.I0(\addrR[11]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[11]),
        .O(\addrR[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrR[11]_i_2 
       (.I0(\addrR_reg_n_0_[11] ),
        .I1(\ARSTRB_reg[1]_i_3_n_0 ),
        .I2(p_1_out_carry__1_n_6),
        .I3(get_next_addr_rd2[11]),
        .I4(\addrR[15]_i_4_n_0 ),
        .I5(\addrR[11]_i_4_n_0 ),
        .O(\addrR[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrR[11]_i_4 
       (.I0(get_next_addr_rd0[9]),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(get_next_addr_rd00_in[11]),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(\ARBURST_reg_reg_n_0_[0] ),
        .I5(\addrR_reg_n_0_[11] ),
        .O(\addrR[11]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrR[11]_i_5 
       (.I0(\addrR_reg_n_0_[11] ),
        .I1(p_1_out_carry__1_n_6),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .O(get_next_addr_rd3[11]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrR[11]_i_6 
       (.I0(\addrR_reg_n_0_[10] ),
        .I1(p_1_out_carry__1_n_7),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .O(get_next_addr_rd3[10]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrR[11]_i_7 
       (.I0(\addrR_reg_n_0_[9] ),
        .I1(p_1_out_carry__0_n_4),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .O(get_next_addr_rd3[9]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrR[11]_i_8 
       (.I0(\addrR_reg_n_0_[8] ),
        .I1(p_1_out_carry__0_n_5),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .O(get_next_addr_rd3[8]));
  (* SOFT_HLUTNM = "soft_lutpair81" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[12]_i_1 
       (.I0(\addrR[12]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[12]),
        .O(\addrR[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrR[12]_i_2 
       (.I0(\addrR_reg_n_0_[12] ),
        .I1(\ARSTRB_reg[1]_i_3_n_0 ),
        .I2(p_1_out_carry__1_n_5),
        .I3(get_next_addr_rd2[12]),
        .I4(\addrR[15]_i_4_n_0 ),
        .I5(\addrR[12]_i_3_n_0 ),
        .O(\addrR[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrR[12]_i_3 
       (.I0(get_next_addr_rd0[10]),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(get_next_addr_rd00_in[12]),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(\ARBURST_reg_reg_n_0_[0] ),
        .I5(\addrR_reg_n_0_[12] ),
        .O(\addrR[12]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[13]_i_1 
       (.I0(\addrR[13]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[13]),
        .O(\addrR[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrR[13]_i_2 
       (.I0(\addrR_reg_n_0_[13] ),
        .I1(\ARSTRB_reg[1]_i_3_n_0 ),
        .I2(p_1_out_carry__1_n_4),
        .I3(get_next_addr_rd2[13]),
        .I4(\addrR[15]_i_4_n_0 ),
        .I5(\addrR[13]_i_3_n_0 ),
        .O(\addrR[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrR[13]_i_3 
       (.I0(get_next_addr_rd0[11]),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(get_next_addr_rd00_in[13]),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(\ARBURST_reg_reg_n_0_[0] ),
        .I5(\addrR_reg_n_0_[13] ),
        .O(\addrR[13]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair82" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[14]_i_1 
       (.I0(\addrR[14]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[14]),
        .O(\addrR[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrR[14]_i_2 
       (.I0(\addrR_reg_n_0_[14] ),
        .I1(\ARSTRB_reg[1]_i_3_n_0 ),
        .I2(p_1_out_carry__2_n_7),
        .I3(get_next_addr_rd2[14]),
        .I4(\addrR[15]_i_4_n_0 ),
        .I5(\addrR[14]_i_3_n_0 ),
        .O(\addrR[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrR[14]_i_3 
       (.I0(get_next_addr_rd0[12]),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(get_next_addr_rd00_in[14]),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(\ARBURST_reg_reg_n_0_[0] ),
        .I5(\addrR_reg_n_0_[14] ),
        .O(\addrR[14]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[15]_i_1 
       (.I0(\addrR[15]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[15]),
        .O(\addrR[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrR[15]_i_2 
       (.I0(\addrR_reg_n_0_[15] ),
        .I1(\ARSTRB_reg[1]_i_3_n_0 ),
        .I2(p_1_out_carry__2_n_6),
        .I3(get_next_addr_rd2[15]),
        .I4(\addrR[15]_i_4_n_0 ),
        .I5(\addrR[15]_i_5_n_0 ),
        .O(\addrR[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \addrR[15]_i_4 
       (.I0(\ARBURST_reg_reg_n_0_[1] ),
        .I1(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[15]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrR[15]_i_5 
       (.I0(get_next_addr_rd0[13]),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(get_next_addr_rd00_in[15]),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(\ARBURST_reg_reg_n_0_[0] ),
        .I5(\addrR_reg_n_0_[15] ),
        .O(\addrR[15]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrR[15]_i_6 
       (.I0(\addrR_reg_n_0_[15] ),
        .I1(p_1_out_carry__2_n_6),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .O(get_next_addr_rd3[15]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrR[15]_i_7 
       (.I0(\addrR_reg_n_0_[14] ),
        .I1(p_1_out_carry__2_n_7),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .O(get_next_addr_rd3[14]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrR[15]_i_8 
       (.I0(\addrR_reg_n_0_[13] ),
        .I1(p_1_out_carry__1_n_4),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .O(get_next_addr_rd3[13]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrR[15]_i_9 
       (.I0(\addrR_reg_n_0_[12] ),
        .I1(p_1_out_carry__1_n_5),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .O(get_next_addr_rd3[12]));
  (* SOFT_HLUTNM = "soft_lutpair83" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[16]_i_1 
       (.I0(\addrR[16]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[16]),
        .O(\addrR[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[16]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[16]),
        .I2(\addrR_reg_n_0_[16] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[16]_i_3_n_0 ),
        .O(\addrR[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[16]_i_3 
       (.I0(get_next_addr_rd00_in[16]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[14]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[16]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[17]_i_1 
       (.I0(\addrR[17]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[17]),
        .O(\addrR[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[17]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[17]),
        .I2(\addrR_reg_n_0_[17] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[17]_i_3_n_0 ),
        .O(\addrR[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[17]_i_3 
       (.I0(get_next_addr_rd00_in[17]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[15]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[17]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair84" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[18]_i_1 
       (.I0(\addrR[18]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[18]),
        .O(\addrR[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[18]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[18]),
        .I2(\addrR_reg_n_0_[18] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[18]_i_3_n_0 ),
        .O(\addrR[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[18]_i_3 
       (.I0(get_next_addr_rd00_in[18]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[16]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[18]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[19]_i_1 
       (.I0(\addrR[19]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[19]),
        .O(\addrR[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[19]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[19]),
        .I2(\addrR_reg_n_0_[19] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[19]_i_4_n_0 ),
        .O(\addrR[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[19]_i_4 
       (.I0(get_next_addr_rd00_in[19]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[17]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[19]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[19]_i_5 
       (.I0(\addrR_reg_n_0_[19] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[19]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[19]_i_6 
       (.I0(\addrR_reg_n_0_[18] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[18]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[19]_i_7 
       (.I0(\addrR_reg_n_0_[17] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[17]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[19]_i_8 
       (.I0(\addrR_reg_n_0_[16] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[16]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[1]_i_1 
       (.I0(\addrR[1]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[1]),
        .O(\addrR[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA0CCA0CCAFCCA0C)) 
    \addrR[1]_i_2 
       (.I0(\addrR[1]_i_3_n_0 ),
        .I1(\addrR_reg_n_0_[1] ),
        .I2(\ARBURST_reg_reg_n_0_[0] ),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(get_next_addr_rd00_in[1]),
        .I5(\ARSTRB_reg[3]_i_4_n_0 ),
        .O(\addrR[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEEFA0000220A)) 
    \addrR[1]_i_3 
       (.I0(\addrR_reg_n_0_[1] ),
        .I1(ARLEN_reg[0]),
        .I2(ARLEN_reg[1]),
        .I3(ARSIZE_reg[0]),
        .I4(\ARSTRB_reg[3]_i_4_n_0 ),
        .I5(get_next_addr_rd2[1]),
        .O(\addrR[1]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair85" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[20]_i_1 
       (.I0(\addrR[20]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[20]),
        .O(\addrR[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[20]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[20]),
        .I2(\addrR_reg_n_0_[20] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[20]_i_3_n_0 ),
        .O(\addrR[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[20]_i_3 
       (.I0(get_next_addr_rd00_in[20]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[18]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[20]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[21]_i_1 
       (.I0(\addrR[21]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[21]),
        .O(\addrR[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[21]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[21]),
        .I2(\addrR_reg_n_0_[21] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[21]_i_3_n_0 ),
        .O(\addrR[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[21]_i_3 
       (.I0(get_next_addr_rd00_in[21]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[19]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[21]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair86" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[22]_i_1 
       (.I0(\addrR[22]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[22]),
        .O(\addrR[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[22]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[22]),
        .I2(\addrR_reg_n_0_[22] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[22]_i_3_n_0 ),
        .O(\addrR[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[22]_i_3 
       (.I0(get_next_addr_rd00_in[22]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[20]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[22]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[23]_i_1 
       (.I0(\addrR[23]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[23]),
        .O(\addrR[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[23]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[23]),
        .I2(\addrR_reg_n_0_[23] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[23]_i_4_n_0 ),
        .O(\addrR[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[23]_i_4 
       (.I0(get_next_addr_rd00_in[23]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[21]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[23]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[23]_i_5 
       (.I0(\addrR_reg_n_0_[23] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[23]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[23]_i_6 
       (.I0(\addrR_reg_n_0_[22] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[22]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[23]_i_7 
       (.I0(\addrR_reg_n_0_[21] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[21]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[23]_i_8 
       (.I0(\addrR_reg_n_0_[20] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[20]));
  (* SOFT_HLUTNM = "soft_lutpair87" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[24]_i_1 
       (.I0(\addrR[24]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[24]),
        .O(\addrR[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[24]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[24]),
        .I2(\addrR_reg_n_0_[24] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[24]_i_3_n_0 ),
        .O(\addrR[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[24]_i_3 
       (.I0(get_next_addr_rd00_in[24]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[22]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[24]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[25]_i_1 
       (.I0(\addrR[25]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[25]),
        .O(\addrR[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[25]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[25]),
        .I2(\addrR_reg_n_0_[25] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[25]_i_3_n_0 ),
        .O(\addrR[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[25]_i_3 
       (.I0(get_next_addr_rd00_in[25]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[23]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[25]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair88" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[26]_i_1 
       (.I0(\addrR[26]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[26]),
        .O(\addrR[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[26]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[26]),
        .I2(\addrR_reg_n_0_[26] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[26]_i_3_n_0 ),
        .O(\addrR[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[26]_i_3 
       (.I0(get_next_addr_rd00_in[26]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[24]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[26]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[27]_i_1 
       (.I0(\addrR[27]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[27]),
        .O(\addrR[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[27]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[27]),
        .I2(\addrR_reg_n_0_[27] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[27]_i_4_n_0 ),
        .O(\addrR[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[27]_i_4 
       (.I0(get_next_addr_rd00_in[27]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[25]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[27]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[27]_i_5 
       (.I0(\addrR_reg_n_0_[27] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[27]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[27]_i_6 
       (.I0(\addrR_reg_n_0_[26] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[26]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[27]_i_7 
       (.I0(\addrR_reg_n_0_[25] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[25]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[27]_i_8 
       (.I0(\addrR_reg_n_0_[24] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[24]));
  (* SOFT_HLUTNM = "soft_lutpair89" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[28]_i_1 
       (.I0(\addrR[28]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[28]),
        .O(\addrR[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[28]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[28]),
        .I2(\addrR_reg_n_0_[28] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[28]_i_3_n_0 ),
        .O(\addrR[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[28]_i_3 
       (.I0(get_next_addr_rd00_in[28]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[26]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[28]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[29]_i_1 
       (.I0(\addrR[29]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[29]),
        .O(\addrR[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[29]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[29]),
        .I2(\addrR_reg_n_0_[29] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[29]_i_3_n_0 ),
        .O(\addrR[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[29]_i_3 
       (.I0(get_next_addr_rd00_in[29]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[27]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[29]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair76" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[2]_i_1 
       (.I0(\addrR[2]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[2]),
        .O(\addrR[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA3CCA3CCAFCCA0C)) 
    \addrR[2]_i_2 
       (.I0(\addrR[2]_i_3_n_0 ),
        .I1(\addrR_reg_n_0_[2] ),
        .I2(\ARBURST_reg_reg_n_0_[0] ),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(get_next_addr_rd00_in[2]),
        .I5(\ARSTRB_reg[3]_i_4_n_0 ),
        .O(\addrR[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFEAAAE0002AAA2)) 
    \addrR[2]_i_3 
       (.I0(\addrR_reg_n_0_[2] ),
        .I1(ARLEN_reg[2]),
        .I2(ARSIZE_reg[0]),
        .I3(\ARSTRB_reg[3]_i_4_n_0 ),
        .I4(p_1_out_carry_n_7),
        .I5(get_next_addr_rd2[2]),
        .O(\addrR[2]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \addrR[2]_i_5 
       (.I0(\addrR_reg_n_0_[3] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[2]),
        .O(\addrR[2]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hAA9A)) 
    \addrR[2]_i_6 
       (.I0(\addrR_reg_n_0_[2] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[2]),
        .O(\addrR[2]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hA9AA)) 
    \addrR[2]_i_7 
       (.I0(\addrR_reg_n_0_[1] ),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[0]),
        .O(\addrR[2]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hAAA9)) 
    \addrR[2]_i_8 
       (.I0(\addrR_reg_n_0_[0] ),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[0]),
        .O(\addrR[2]_i_8_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair90" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[30]_i_1 
       (.I0(\addrR[30]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[30]),
        .O(\addrR[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[30]_i_2 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[30]),
        .I2(\addrR_reg_n_0_[30] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[30]_i_3_n_0 ),
        .O(\addrR[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[30]_i_3 
       (.I0(get_next_addr_rd00_in[30]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[28]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[30]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'hABAAABAAABAAAAAA)) 
    \addrR[31]_i_1 
       (.I0(\ARLEN_reg[7]_i_1_n_0 ),
        .I1(\tickR[3]_i_3_n_0 ),
        .I2(\stateR_reg_n_0_[2] ),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(\stateR_reg_n_0_[0] ),
        .I5(ACK_reg_n_0),
        .O(\addrR[31]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[31]_i_10 
       (.I0(\addrR_reg_n_0_[28] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[28]));
  (* SOFT_HLUTNM = "soft_lutpair91" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[31]_i_2 
       (.I0(\addrR[31]_i_3_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[31]),
        .O(\addrR[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[31]_i_3 
       (.I0(\addrR[31]_i_4_n_0 ),
        .I1(get_next_addr_rd2[31]),
        .I2(\addrR_reg_n_0_[31] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[31]_i_6_n_0 ),
        .O(\addrR[31]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hAAAB)) 
    \addrR[31]_i_4 
       (.I0(p_1_out_carry__2_n_1),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[0]),
        .O(\addrR[31]_i_4_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[31]_i_6 
       (.I0(get_next_addr_rd00_in[31]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[29]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[31]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[31]_i_7 
       (.I0(\addrR_reg_n_0_[31] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[31]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[31]_i_8 
       (.I0(\addrR_reg_n_0_[30] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[30]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrR[31]_i_9 
       (.I0(\addrR_reg_n_0_[29] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__2_n_1),
        .O(get_next_addr_rd3[29]));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[3]_i_1 
       (.I0(\addrR[3]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[3]),
        .O(\addrR[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC0C0C0C03FC0C0A0)) 
    \addrR[3]_i_10 
       (.I0(ARLEN_reg[3]),
        .I1(p_1_out_carry_n_6),
        .I2(\addrR_reg_n_0_[3] ),
        .I3(ARSIZE_reg[0]),
        .I4(ARSIZE_reg[1]),
        .I5(ARSIZE_reg[2]),
        .O(\addrR[3]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hC0C0C0C0C03FC0A0)) 
    \addrR[3]_i_11 
       (.I0(ARLEN_reg[2]),
        .I1(p_1_out_carry_n_7),
        .I2(\addrR_reg_n_0_[2] ),
        .I3(ARSIZE_reg[0]),
        .I4(ARSIZE_reg[1]),
        .I5(ARSIZE_reg[2]),
        .O(\addrR[3]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hF0F0F05FF0F0F0C0)) 
    \addrR[3]_i_12 
       (.I0(ARLEN_reg[0]),
        .I1(ARLEN_reg[1]),
        .I2(\addrR_reg_n_0_[1] ),
        .I3(ARSIZE_reg[1]),
        .I4(ARSIZE_reg[2]),
        .I5(ARSIZE_reg[0]),
        .O(\addrR[3]_i_12_n_0 ));
  LUT5 #(
    .INIT(32'hCCCCCCC7)) 
    \addrR[3]_i_13 
       (.I0(ARLEN_reg[0]),
        .I1(\addrR_reg_n_0_[0] ),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[0]),
        .O(\addrR[3]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[3]_i_2 
       (.I0(\addrR[3]_i_3_n_0 ),
        .I1(get_next_addr_rd2[3]),
        .I2(\addrR_reg_n_0_[3] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[3]_i_5_n_0 ),
        .O(\addrR[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrR[3]_i_3 
       (.I0(ARLEN_reg[3]),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry_n_6),
        .O(\addrR[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[3]_i_5 
       (.I0(get_next_addr_rd00_in[3]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[1]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[3]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h40)) 
    \addrR[3]_i_6 
       (.I0(ARSIZE_reg[2]),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[0]),
        .O(\addrR[3]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \addrR[3]_i_7 
       (.I0(ARSIZE_reg[2]),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[0]),
        .O(\addrR[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAA8A8AAA8A8)) 
    \addrR[3]_i_8 
       (.I0(\addrR_reg_n_0_[1] ),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[0]),
        .I4(ARLEN_reg[1]),
        .I5(ARLEN_reg[0]),
        .O(get_next_addr_rd3[1]));
  LUT3 #(
    .INIT(8'h01)) 
    \addrR[3]_i_9 
       (.I0(ARSIZE_reg[0]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .O(\addrR[3]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair77" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[4]_i_1 
       (.I0(\addrR[4]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[4]),
        .O(\addrR[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[4]_i_2 
       (.I0(\addrR[4]_i_3_n_0 ),
        .I1(get_next_addr_rd2[4]),
        .I2(\addrR_reg_n_0_[4] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[4]_i_4_n_0 ),
        .O(\addrR[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrR[4]_i_3 
       (.I0(ARLEN_reg[4]),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry_n_5),
        .O(\addrR[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[4]_i_4 
       (.I0(get_next_addr_rd00_in[4]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[2]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[4]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[5]_i_1 
       (.I0(\addrR[5]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[5]),
        .O(\addrR[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[5]_i_2 
       (.I0(\addrR[5]_i_3_n_0 ),
        .I1(get_next_addr_rd2[5]),
        .I2(\addrR_reg_n_0_[5] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[5]_i_4_n_0 ),
        .O(\addrR[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrR[5]_i_3 
       (.I0(ARLEN_reg[5]),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry_n_4),
        .O(\addrR[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[5]_i_4 
       (.I0(get_next_addr_rd00_in[5]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[3]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[5]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair78" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[6]_i_1 
       (.I0(\addrR[6]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[6]),
        .O(\addrR[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[6]_i_2 
       (.I0(\addrR[6]_i_3_n_0 ),
        .I1(get_next_addr_rd2[6]),
        .I2(\addrR_reg_n_0_[6] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[6]_i_4_n_0 ),
        .O(\addrR[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrR[6]_i_3 
       (.I0(ARLEN_reg[6]),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__0_n_7),
        .O(\addrR[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[6]_i_4 
       (.I0(get_next_addr_rd00_in[6]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[4]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[6]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[7]_i_1 
       (.I0(\addrR[7]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[7]),
        .O(\addrR[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3FC0C0C0C0C0C0A0)) 
    \addrR[7]_i_10 
       (.I0(ARLEN_reg[7]),
        .I1(p_1_out_carry__0_n_6),
        .I2(\addrR_reg_n_0_[7] ),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[1]),
        .I5(ARSIZE_reg[0]),
        .O(\addrR[7]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hC03FC0C0C0C0C0A0)) 
    \addrR[7]_i_11 
       (.I0(ARLEN_reg[6]),
        .I1(p_1_out_carry__0_n_7),
        .I2(\addrR_reg_n_0_[6] ),
        .I3(ARSIZE_reg[0]),
        .I4(ARSIZE_reg[2]),
        .I5(ARSIZE_reg[1]),
        .O(\addrR[7]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hC0C0C0C03FC0C0A0)) 
    \addrR[7]_i_12 
       (.I0(ARLEN_reg[5]),
        .I1(p_1_out_carry_n_4),
        .I2(\addrR_reg_n_0_[5] ),
        .I3(ARSIZE_reg[0]),
        .I4(ARSIZE_reg[2]),
        .I5(ARSIZE_reg[1]),
        .O(\addrR[7]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hC0C0C0C0C03FC0A0)) 
    \addrR[7]_i_13 
       (.I0(ARLEN_reg[4]),
        .I1(p_1_out_carry_n_5),
        .I2(\addrR_reg_n_0_[4] ),
        .I3(ARSIZE_reg[0]),
        .I4(ARSIZE_reg[2]),
        .I5(ARSIZE_reg[1]),
        .O(\addrR[7]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \addrR[7]_i_15 
       (.I0(\addrR_reg_n_0_[7] ),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[0]),
        .O(\addrR[7]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h9AAA)) 
    \addrR[7]_i_16 
       (.I0(\addrR_reg_n_0_[6] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .O(\addrR[7]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \addrR[7]_i_17 
       (.I0(\addrR_reg_n_0_[5] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .O(\addrR[7]_i_17_n_0 ));
  LUT4 #(
    .INIT(16'hAA9A)) 
    \addrR[7]_i_18 
       (.I0(\addrR_reg_n_0_[4] ),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .O(\addrR[7]_i_18_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrR[7]_i_2 
       (.I0(\addrR[7]_i_3_n_0 ),
        .I1(get_next_addr_rd2[7]),
        .I2(\addrR_reg_n_0_[7] ),
        .I3(\ARBURST_reg_reg_n_0_[0] ),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\addrR[7]_i_5_n_0 ),
        .O(\addrR[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrR[7]_i_3 
       (.I0(ARLEN_reg[7]),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__0_n_6),
        .O(\addrR[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrR[7]_i_5 
       (.I0(get_next_addr_rd00_in[7]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(get_next_addr_rd0[5]),
        .I4(\ARBURST_reg_reg_n_0_[1] ),
        .I5(\ARBURST_reg_reg_n_0_[0] ),
        .O(\addrR[7]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \addrR[7]_i_6 
       (.I0(ARSIZE_reg[0]),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .O(\addrR[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8888888A88888880)) 
    \addrR[7]_i_7 
       (.I0(\addrR_reg_n_0_[6] ),
        .I1(p_1_out_carry__0_n_7),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[0]),
        .I5(ARLEN_reg[6]),
        .O(get_next_addr_rd3[6]));
  LUT3 #(
    .INIT(8'h40)) 
    \addrR[7]_i_8 
       (.I0(ARSIZE_reg[1]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[0]),
        .O(\addrR[7]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \addrR[7]_i_9 
       (.I0(ARSIZE_reg[1]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[0]),
        .O(\addrR[7]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair79" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[8]_i_1 
       (.I0(\addrR[8]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[8]),
        .O(\addrR[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrR[8]_i_2 
       (.I0(\addrR_reg_n_0_[8] ),
        .I1(\ARSTRB_reg[1]_i_3_n_0 ),
        .I2(p_1_out_carry__0_n_5),
        .I3(get_next_addr_rd2[8]),
        .I4(\addrR[15]_i_4_n_0 ),
        .I5(\addrR[8]_i_3_n_0 ),
        .O(\addrR[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrR[8]_i_3 
       (.I0(get_next_addr_rd0[6]),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(get_next_addr_rd00_in[8]),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(\ARBURST_reg_reg_n_0_[0] ),
        .I5(\addrR_reg_n_0_[8] ),
        .O(\addrR[8]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair80" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \addrR[9]_i_1 
       (.I0(\addrR[9]_i_2_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(s_axi_araddr[9]),
        .O(\addrR[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrR[9]_i_2 
       (.I0(\addrR_reg_n_0_[9] ),
        .I1(\ARSTRB_reg[1]_i_3_n_0 ),
        .I2(p_1_out_carry__0_n_4),
        .I3(get_next_addr_rd2[9]),
        .I4(\addrR[15]_i_4_n_0 ),
        .I5(\addrR[9]_i_3_n_0 ),
        .O(\addrR[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrR[9]_i_3 
       (.I0(get_next_addr_rd0[7]),
        .I1(\ARSTRB_reg[3]_i_4_n_0 ),
        .I2(get_next_addr_rd00_in[9]),
        .I3(\ARBURST_reg_reg_n_0_[1] ),
        .I4(\ARBURST_reg_reg_n_0_[0] ),
        .I5(\addrR_reg_n_0_[9] ),
        .O(\addrR[9]_i_3_n_0 ));
  FDCE \addrR_reg[0] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[0]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[0] ));
  FDCE \addrR_reg[10] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[10]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[10] ));
  FDCE \addrR_reg[11] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[11]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[11] ));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrR_reg[11]_i_3 
       (.CI(\addrR_reg[7]_i_4_n_0 ),
        .CO({\addrR_reg[11]_i_3_n_0 ,\addrR_reg[11]_i_3_n_1 ,\addrR_reg[11]_i_3_n_2 ,\addrR_reg[11]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd2[11:8]),
        .S(get_next_addr_rd3[11:8]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addrR_reg[11]_i_9 
       (.CI(\addrR_reg[7]_i_14_n_0 ),
        .CO({\addrR_reg[11]_i_9_n_0 ,\addrR_reg[11]_i_9_n_1 ,\addrR_reg[11]_i_9_n_2 ,\addrR_reg[11]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd00_in[11:8]),
        .S({\addrR_reg_n_0_[11] ,\addrR_reg_n_0_[10] ,\addrR_reg_n_0_[9] ,\addrR_reg_n_0_[8] }));
  FDCE \addrR_reg[12] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[12]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[12] ));
  FDCE \addrR_reg[13] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[13]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[13] ));
  FDCE \addrR_reg[14] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[14]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[14] ));
  FDCE \addrR_reg[15] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[15]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[15] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addrR_reg[15]_i_10 
       (.CI(\addrR_reg[11]_i_9_n_0 ),
        .CO({\addrR_reg[15]_i_10_n_0 ,\addrR_reg[15]_i_10_n_1 ,\addrR_reg[15]_i_10_n_2 ,\addrR_reg[15]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd00_in[15:12]),
        .S({\addrR_reg_n_0_[15] ,\addrR_reg_n_0_[14] ,\addrR_reg_n_0_[13] ,\addrR_reg_n_0_[12] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrR_reg[15]_i_3 
       (.CI(\addrR_reg[11]_i_3_n_0 ),
        .CO({\addrR_reg[15]_i_3_n_0 ,\addrR_reg[15]_i_3_n_1 ,\addrR_reg[15]_i_3_n_2 ,\addrR_reg[15]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd2[15:12]),
        .S(get_next_addr_rd3[15:12]));
  FDCE \addrR_reg[16] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[16]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[16] ));
  FDCE \addrR_reg[17] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[17]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[17] ));
  FDCE \addrR_reg[18] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[18]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[18] ));
  FDCE \addrR_reg[19] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[19]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[19] ));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrR_reg[19]_i_3 
       (.CI(\addrR_reg[15]_i_3_n_0 ),
        .CO({\addrR_reg[19]_i_3_n_0 ,\addrR_reg[19]_i_3_n_1 ,\addrR_reg[19]_i_3_n_2 ,\addrR_reg[19]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd2[19:16]),
        .S(get_next_addr_rd3[19:16]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addrR_reg[19]_i_9 
       (.CI(\addrR_reg[15]_i_10_n_0 ),
        .CO({\addrR_reg[19]_i_9_n_0 ,\addrR_reg[19]_i_9_n_1 ,\addrR_reg[19]_i_9_n_2 ,\addrR_reg[19]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd00_in[19:16]),
        .S({\addrR_reg_n_0_[19] ,\addrR_reg_n_0_[18] ,\addrR_reg_n_0_[17] ,\addrR_reg_n_0_[16] }));
  FDCE \addrR_reg[1] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[1]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[1] ));
  FDCE \addrR_reg[20] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[20]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[20] ));
  FDCE \addrR_reg[21] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[21]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[21] ));
  FDCE \addrR_reg[22] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[22]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[22] ));
  FDCE \addrR_reg[23] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[23]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[23] ));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrR_reg[23]_i_3 
       (.CI(\addrR_reg[19]_i_3_n_0 ),
        .CO({\addrR_reg[23]_i_3_n_0 ,\addrR_reg[23]_i_3_n_1 ,\addrR_reg[23]_i_3_n_2 ,\addrR_reg[23]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd2[23:20]),
        .S(get_next_addr_rd3[23:20]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addrR_reg[23]_i_9 
       (.CI(\addrR_reg[19]_i_9_n_0 ),
        .CO({\addrR_reg[23]_i_9_n_0 ,\addrR_reg[23]_i_9_n_1 ,\addrR_reg[23]_i_9_n_2 ,\addrR_reg[23]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd00_in[23:20]),
        .S({\addrR_reg_n_0_[23] ,\addrR_reg_n_0_[22] ,\addrR_reg_n_0_[21] ,\addrR_reg_n_0_[20] }));
  FDCE \addrR_reg[24] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[24]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[24] ));
  FDCE \addrR_reg[25] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[25]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[25] ));
  FDCE \addrR_reg[26] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[26]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[26] ));
  FDCE \addrR_reg[27] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[27]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[27] ));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrR_reg[27]_i_3 
       (.CI(\addrR_reg[23]_i_3_n_0 ),
        .CO({\addrR_reg[27]_i_3_n_0 ,\addrR_reg[27]_i_3_n_1 ,\addrR_reg[27]_i_3_n_2 ,\addrR_reg[27]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd2[27:24]),
        .S(get_next_addr_rd3[27:24]));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addrR_reg[27]_i_9 
       (.CI(\addrR_reg[23]_i_9_n_0 ),
        .CO({\addrR_reg[27]_i_9_n_0 ,\addrR_reg[27]_i_9_n_1 ,\addrR_reg[27]_i_9_n_2 ,\addrR_reg[27]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd00_in[27:24]),
        .S({\addrR_reg_n_0_[27] ,\addrR_reg_n_0_[26] ,\addrR_reg_n_0_[25] ,\addrR_reg_n_0_[24] }));
  FDCE \addrR_reg[28] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[28]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[28] ));
  FDCE \addrR_reg[29] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[29]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[29] ));
  FDCE \addrR_reg[2] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[2]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[2] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addrR_reg[2]_i_4 
       (.CI(1'b0),
        .CO({\addrR_reg[2]_i_4_n_0 ,\addrR_reg[2]_i_4_n_1 ,\addrR_reg[2]_i_4_n_2 ,\addrR_reg[2]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({\addrR_reg_n_0_[3] ,\addrR_reg_n_0_[2] ,\addrR_reg_n_0_[1] ,\addrR_reg_n_0_[0] }),
        .O(get_next_addr_rd00_in[3:0]),
        .S({\addrR[2]_i_5_n_0 ,\addrR[2]_i_6_n_0 ,\addrR[2]_i_7_n_0 ,\addrR[2]_i_8_n_0 }));
  FDCE \addrR_reg[30] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[30]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[30] ));
  FDCE \addrR_reg[31] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[31]_i_2_n_0 ),
        .Q(\addrR_reg_n_0_[31] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addrR_reg[31]_i_11 
       (.CI(\addrR_reg[27]_i_9_n_0 ),
        .CO({\NLW_addrR_reg[31]_i_11_CO_UNCONNECTED [3],\addrR_reg[31]_i_11_n_1 ,\addrR_reg[31]_i_11_n_2 ,\addrR_reg[31]_i_11_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd00_in[31:28]),
        .S({\addrR_reg_n_0_[31] ,\addrR_reg_n_0_[30] ,\addrR_reg_n_0_[29] ,\addrR_reg_n_0_[28] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrR_reg[31]_i_5 
       (.CI(\addrR_reg[27]_i_3_n_0 ),
        .CO({\NLW_addrR_reg[31]_i_5_CO_UNCONNECTED [3],\addrR_reg[31]_i_5_n_1 ,\addrR_reg[31]_i_5_n_2 ,\addrR_reg[31]_i_5_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd2[31:28]),
        .S(get_next_addr_rd3[31:28]));
  FDCE \addrR_reg[3] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[3]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[3] ));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrR_reg[3]_i_4 
       (.CI(1'b0),
        .CO({\addrR_reg[3]_i_4_n_0 ,\addrR_reg[3]_i_4_n_1 ,\addrR_reg[3]_i_4_n_2 ,\addrR_reg[3]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({\addrR[3]_i_6_n_0 ,\addrR[3]_i_7_n_0 ,get_next_addr_rd3[1],\addrR[3]_i_9_n_0 }),
        .O(get_next_addr_rd2[3:0]),
        .S({\addrR[3]_i_10_n_0 ,\addrR[3]_i_11_n_0 ,\addrR[3]_i_12_n_0 ,\addrR[3]_i_13_n_0 }));
  FDCE \addrR_reg[4] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[4]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[4] ));
  FDCE \addrR_reg[5] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[5]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[5] ));
  FDCE \addrR_reg[6] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[6]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[6] ));
  FDCE \addrR_reg[7] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[7]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[7] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \addrR_reg[7]_i_14 
       (.CI(\addrR_reg[2]_i_4_n_0 ),
        .CO({\addrR_reg[7]_i_14_n_0 ,\addrR_reg[7]_i_14_n_1 ,\addrR_reg[7]_i_14_n_2 ,\addrR_reg[7]_i_14_n_3 }),
        .CYINIT(1'b0),
        .DI({\addrR_reg_n_0_[7] ,\addrR_reg_n_0_[6] ,\addrR_reg_n_0_[5] ,\addrR_reg_n_0_[4] }),
        .O(get_next_addr_rd00_in[7:4]),
        .S({\addrR[7]_i_15_n_0 ,\addrR[7]_i_16_n_0 ,\addrR[7]_i_17_n_0 ,\addrR[7]_i_18_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrR_reg[7]_i_4 
       (.CI(\addrR_reg[3]_i_4_n_0 ),
        .CO({\addrR_reg[7]_i_4_n_0 ,\addrR_reg[7]_i_4_n_1 ,\addrR_reg[7]_i_4_n_2 ,\addrR_reg[7]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({\addrR[7]_i_6_n_0 ,get_next_addr_rd3[6],\addrR[7]_i_8_n_0 ,\addrR[7]_i_9_n_0 }),
        .O(get_next_addr_rd2[7:4]),
        .S({\addrR[7]_i_10_n_0 ,\addrR[7]_i_11_n_0 ,\addrR[7]_i_12_n_0 ,\addrR[7]_i_13_n_0 }));
  FDCE \addrR_reg[8] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[8]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[8] ));
  FDCE \addrR_reg[9] 
       (.C(axi_aclk),
        .CE(\addrR[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrR[9]_i_1_n_0 ),
        .Q(\addrR_reg_n_0_[9] ));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrWT0_carry
       (.CI(1'b0),
        .CO({addrWT0_carry_n_0,addrWT0_carry_n_1,addrWT0_carry_n_2,addrWT0_carry_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,addrWT[2],1'b0}),
        .O(addrWT0[4:1]),
        .S({addrWT[4:3],addrWT0_carry_i_1_n_0,addrWT[1]}));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrWT0_carry__0
       (.CI(addrWT0_carry_n_0),
        .CO({addrWT0_carry__0_n_0,addrWT0_carry__0_n_1,addrWT0_carry__0_n_2,addrWT0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrWT0[8:5]),
        .S(addrWT[8:5]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrWT0_carry__1
       (.CI(addrWT0_carry__0_n_0),
        .CO({addrWT0_carry__1_n_0,addrWT0_carry__1_n_1,addrWT0_carry__1_n_2,addrWT0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrWT0[12:9]),
        .S(addrWT[12:9]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrWT0_carry__2
       (.CI(addrWT0_carry__1_n_0),
        .CO({addrWT0_carry__2_n_0,addrWT0_carry__2_n_1,addrWT0_carry__2_n_2,addrWT0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrWT0[16:13]),
        .S(addrWT[16:13]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrWT0_carry__3
       (.CI(addrWT0_carry__2_n_0),
        .CO({addrWT0_carry__3_n_0,addrWT0_carry__3_n_1,addrWT0_carry__3_n_2,addrWT0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrWT0[20:17]),
        .S(addrWT[20:17]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrWT0_carry__4
       (.CI(addrWT0_carry__3_n_0),
        .CO({addrWT0_carry__4_n_0,addrWT0_carry__4_n_1,addrWT0_carry__4_n_2,addrWT0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrWT0[24:21]),
        .S(addrWT[24:21]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrWT0_carry__5
       (.CI(addrWT0_carry__4_n_0),
        .CO({addrWT0_carry__5_n_0,addrWT0_carry__5_n_1,addrWT0_carry__5_n_2,addrWT0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(addrWT0[28:25]),
        .S(addrWT[28:25]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 addrWT0_carry__6
       (.CI(addrWT0_carry__5_n_0),
        .CO({NLW_addrWT0_carry__6_CO_UNCONNECTED[3:2],addrWT0_carry__6_n_2,addrWT0_carry__6_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_addrWT0_carry__6_O_UNCONNECTED[3],addrWT0[31:29]}),
        .S({1'b0,addrWT[31:29]}));
  LUT1 #(
    .INIT(2'h1)) 
    addrWT0_carry_i_1
       (.I0(addrWT[2]),
        .O(addrWT0_carry_i_1_n_0));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[0]_i_1 
       (.I0(AWADDR_reg[0]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT[0]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[0]_i_2_n_0 ),
        .O(\addrWT[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[10]_i_1 
       (.I0(AWADDR_reg[10]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[10]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[10]_i_2_n_0 ),
        .O(\addrWT[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[11]_i_1 
       (.I0(AWADDR_reg[11]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[11]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[11]_i_2_n_0 ),
        .O(\addrWT[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[12]_i_1 
       (.I0(AWADDR_reg[12]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[12]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[12]_i_2_n_0 ),
        .O(\addrWT[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[13]_i_1 
       (.I0(AWADDR_reg[13]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[13]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[13]_i_2_n_0 ),
        .O(\addrWT[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[14]_i_1 
       (.I0(AWADDR_reg[14]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[14]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[14]_i_2_n_0 ),
        .O(\addrWT[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[15]_i_1 
       (.I0(AWADDR_reg[15]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[15]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[15]_i_2_n_0 ),
        .O(\addrWT[15]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[16]_i_1 
       (.I0(AWADDR_reg[16]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[16]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[16]_i_2_n_0 ),
        .O(\addrWT[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[17]_i_1 
       (.I0(AWADDR_reg[17]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[17]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[17]_i_2_n_0 ),
        .O(\addrWT[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[18]_i_1 
       (.I0(AWADDR_reg[18]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[18]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[18]_i_2_n_0 ),
        .O(\addrWT[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[19]_i_1 
       (.I0(AWADDR_reg[19]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[19]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[19]_i_2_n_0 ),
        .O(\addrWT[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[1]_i_1 
       (.I0(AWADDR_reg[1]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[1]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[1]_i_2_n_0 ),
        .O(\addrWT[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[20]_i_1 
       (.I0(AWADDR_reg[20]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[20]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[20]_i_2_n_0 ),
        .O(\addrWT[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[21]_i_1 
       (.I0(AWADDR_reg[21]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[21]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[21]_i_2_n_0 ),
        .O(\addrWT[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[22]_i_1 
       (.I0(AWADDR_reg[22]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[22]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[22]_i_2_n_0 ),
        .O(\addrWT[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[23]_i_1 
       (.I0(AWADDR_reg[23]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[23]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[23]_i_2_n_0 ),
        .O(\addrWT[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[24]_i_1 
       (.I0(AWADDR_reg[24]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[24]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[24]_i_2_n_0 ),
        .O(\addrWT[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[25]_i_1 
       (.I0(AWADDR_reg[25]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[25]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[25]_i_2_n_0 ),
        .O(\addrWT[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[26]_i_1 
       (.I0(AWADDR_reg[26]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[26]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[26]_i_2_n_0 ),
        .O(\addrWT[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[27]_i_1 
       (.I0(AWADDR_reg[27]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[27]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[27]_i_2_n_0 ),
        .O(\addrWT[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[28]_i_1 
       (.I0(AWADDR_reg[28]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[28]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[28]_i_2_n_0 ),
        .O(\addrWT[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[29]_i_1 
       (.I0(AWADDR_reg[29]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[29]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[29]_i_2_n_0 ),
        .O(\addrWT[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[2]_i_1 
       (.I0(AWADDR_reg[2]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[2]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[2]_i_2_n_0 ),
        .O(\addrWT[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[30]_i_1 
       (.I0(AWADDR_reg[30]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[30]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[30]_i_2_n_0 ),
        .O(\addrWT[30]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h3414)) 
    \addrWT[31]_i_1 
       (.I0(\stateW_reg_n_0_[1] ),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(ACK_reg_n_0),
        .O(\addrWT[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[31]_i_2 
       (.I0(AWADDR_reg[31]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[31]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[31]_i_2_n_0 ),
        .O(\addrWT[31]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[3]_i_1 
       (.I0(AWADDR_reg[3]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[3]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[3]_i_2_n_0 ),
        .O(\addrWT[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[4]_i_1 
       (.I0(AWADDR_reg[4]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[4]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[4]_i_2_n_0 ),
        .O(\addrWT[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[5]_i_1 
       (.I0(AWADDR_reg[5]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[5]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[5]_i_2_n_0 ),
        .O(\addrWT[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[6]_i_1 
       (.I0(AWADDR_reg[6]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[6]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[6]_i_2_n_0 ),
        .O(\addrWT[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[7]_i_1 
       (.I0(AWADDR_reg[7]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[7]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[7]_i_2_n_0 ),
        .O(\addrWT[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[8]_i_1 
       (.I0(AWADDR_reg[8]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[8]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[8]_i_2_n_0 ),
        .O(\addrWT[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFE02FEFEFE020202)) 
    \addrWT[9]_i_1 
       (.I0(AWADDR_reg[9]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(addrWT0[9]),
        .I4(\BID[3]_i_2_n_0 ),
        .I5(\addrW[9]_i_2_n_0 ),
        .O(\addrWT[9]_i_1_n_0 ));
  FDCE \addrWT_reg[0] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[0]_i_1_n_0 ),
        .Q(addrWT[0]));
  FDCE \addrWT_reg[10] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[10]_i_1_n_0 ),
        .Q(addrWT[10]));
  FDCE \addrWT_reg[11] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[11]_i_1_n_0 ),
        .Q(addrWT[11]));
  FDCE \addrWT_reg[12] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[12]_i_1_n_0 ),
        .Q(addrWT[12]));
  FDCE \addrWT_reg[13] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[13]_i_1_n_0 ),
        .Q(addrWT[13]));
  FDCE \addrWT_reg[14] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[14]_i_1_n_0 ),
        .Q(addrWT[14]));
  FDCE \addrWT_reg[15] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[15]_i_1_n_0 ),
        .Q(addrWT[15]));
  FDCE \addrWT_reg[16] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[16]_i_1_n_0 ),
        .Q(addrWT[16]));
  FDCE \addrWT_reg[17] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[17]_i_1_n_0 ),
        .Q(addrWT[17]));
  FDCE \addrWT_reg[18] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[18]_i_1_n_0 ),
        .Q(addrWT[18]));
  FDCE \addrWT_reg[19] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[19]_i_1_n_0 ),
        .Q(addrWT[19]));
  FDCE \addrWT_reg[1] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[1]_i_1_n_0 ),
        .Q(addrWT[1]));
  FDCE \addrWT_reg[20] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[20]_i_1_n_0 ),
        .Q(addrWT[20]));
  FDCE \addrWT_reg[21] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[21]_i_1_n_0 ),
        .Q(addrWT[21]));
  FDCE \addrWT_reg[22] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[22]_i_1_n_0 ),
        .Q(addrWT[22]));
  FDCE \addrWT_reg[23] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[23]_i_1_n_0 ),
        .Q(addrWT[23]));
  FDCE \addrWT_reg[24] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[24]_i_1_n_0 ),
        .Q(addrWT[24]));
  FDCE \addrWT_reg[25] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[25]_i_1_n_0 ),
        .Q(addrWT[25]));
  FDCE \addrWT_reg[26] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[26]_i_1_n_0 ),
        .Q(addrWT[26]));
  FDCE \addrWT_reg[27] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[27]_i_1_n_0 ),
        .Q(addrWT[27]));
  FDCE \addrWT_reg[28] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[28]_i_1_n_0 ),
        .Q(addrWT[28]));
  FDCE \addrWT_reg[29] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[29]_i_1_n_0 ),
        .Q(addrWT[29]));
  FDCE \addrWT_reg[2] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[2]_i_1_n_0 ),
        .Q(addrWT[2]));
  FDCE \addrWT_reg[30] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[30]_i_1_n_0 ),
        .Q(addrWT[30]));
  FDCE \addrWT_reg[31] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[31]_i_2_n_0 ),
        .Q(addrWT[31]));
  FDCE \addrWT_reg[3] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[3]_i_1_n_0 ),
        .Q(addrWT[3]));
  FDCE \addrWT_reg[4] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[4]_i_1_n_0 ),
        .Q(addrWT[4]));
  FDCE \addrWT_reg[5] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[5]_i_1_n_0 ),
        .Q(addrWT[5]));
  FDCE \addrWT_reg[6] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[6]_i_1_n_0 ),
        .Q(addrWT[6]));
  FDCE \addrWT_reg[7] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[7]_i_1_n_0 ),
        .Q(addrWT[7]));
  FDCE \addrWT_reg[8] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[8]_i_1_n_0 ),
        .Q(addrWT[8]));
  FDCE \addrWT_reg[9] 
       (.C(axi_aclk),
        .CE(\addrWT[31]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrWT[9]_i_1_n_0 ),
        .Q(addrWT[9]));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[0]_i_1 
       (.I0(AWADDR_reg[0]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[0]_i_2_n_0 ),
        .O(\addrW[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA0CCA0CCAFCCA0C)) 
    \addrW[0]_i_2 
       (.I0(\addrW[0]_i_3_n_0 ),
        .I1(addr[0]),
        .I2(\AWBURST_reg_reg_n_0_[0] ),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(get_next_addr_wr00_in[0]),
        .I5(\addrW[2]_i_5_n_0 ),
        .O(\addrW[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFE00000002)) 
    \addrW[0]_i_3 
       (.I0(addr[0]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[0]),
        .I4(AWLEN_reg[0]),
        .I5(get_next_addr_wr2[0]),
        .O(\addrW[0]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[10]_i_1 
       (.I0(AWADDR_reg[10]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[10]_i_2_n_0 ),
        .O(\addrW[10]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrW[10]_i_2 
       (.I0(addr[10]),
        .I1(\addrW[15]_i_3_n_0 ),
        .I2(\p_1_out_inferred__0/i__carry__1_n_7 ),
        .I3(get_next_addr_wr2[10]),
        .I4(\addrW[15]_i_5_n_0 ),
        .I5(\addrW[10]_i_3_n_0 ),
        .O(\addrW[10]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrW[10]_i_3 
       (.I0(get_next_addr_wr0[8]),
        .I1(\addrW[2]_i_5_n_0 ),
        .I2(get_next_addr_wr00_in[10]),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(\AWBURST_reg_reg_n_0_[0] ),
        .I5(addr[10]),
        .O(\addrW[10]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[11]_i_1 
       (.I0(AWADDR_reg[11]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[11]_i_2_n_0 ),
        .O(\addrW[11]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrW[11]_i_2 
       (.I0(addr[11]),
        .I1(\addrW[15]_i_3_n_0 ),
        .I2(\p_1_out_inferred__0/i__carry__1_n_6 ),
        .I3(get_next_addr_wr2[11]),
        .I4(\addrW[15]_i_5_n_0 ),
        .I5(\addrW[11]_i_4_n_0 ),
        .O(\addrW[11]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrW[11]_i_4 
       (.I0(get_next_addr_wr0[9]),
        .I1(\addrW[2]_i_5_n_0 ),
        .I2(get_next_addr_wr00_in[11]),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(\AWBURST_reg_reg_n_0_[0] ),
        .I5(addr[11]),
        .O(\addrW[11]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrW[11]_i_5 
       (.I0(addr[11]),
        .I1(\p_1_out_inferred__0/i__carry__1_n_6 ),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .O(get_next_addr_wr3[11]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrW[11]_i_6 
       (.I0(addr[10]),
        .I1(\p_1_out_inferred__0/i__carry__1_n_7 ),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .O(get_next_addr_wr3[10]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrW[11]_i_7 
       (.I0(addr[9]),
        .I1(\p_1_out_inferred__0/i__carry__0_n_4 ),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .O(get_next_addr_wr3[9]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrW[11]_i_8 
       (.I0(addr[8]),
        .I1(\p_1_out_inferred__0/i__carry__0_n_5 ),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .O(get_next_addr_wr3[8]));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[12]_i_1 
       (.I0(AWADDR_reg[12]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[12]_i_2_n_0 ),
        .O(\addrW[12]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrW[12]_i_2 
       (.I0(addr[12]),
        .I1(\addrW[15]_i_3_n_0 ),
        .I2(\p_1_out_inferred__0/i__carry__1_n_5 ),
        .I3(get_next_addr_wr2[12]),
        .I4(\addrW[15]_i_5_n_0 ),
        .I5(\addrW[12]_i_3_n_0 ),
        .O(\addrW[12]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrW[12]_i_3 
       (.I0(get_next_addr_wr0[10]),
        .I1(\addrW[2]_i_5_n_0 ),
        .I2(get_next_addr_wr00_in[12]),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(\AWBURST_reg_reg_n_0_[0] ),
        .I5(addr[12]),
        .O(\addrW[12]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[13]_i_1 
       (.I0(AWADDR_reg[13]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[13]_i_2_n_0 ),
        .O(\addrW[13]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrW[13]_i_2 
       (.I0(addr[13]),
        .I1(\addrW[15]_i_3_n_0 ),
        .I2(\p_1_out_inferred__0/i__carry__1_n_4 ),
        .I3(get_next_addr_wr2[13]),
        .I4(\addrW[15]_i_5_n_0 ),
        .I5(\addrW[13]_i_3_n_0 ),
        .O(\addrW[13]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrW[13]_i_3 
       (.I0(get_next_addr_wr0[11]),
        .I1(\addrW[2]_i_5_n_0 ),
        .I2(get_next_addr_wr00_in[13]),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(\AWBURST_reg_reg_n_0_[0] ),
        .I5(addr[13]),
        .O(\addrW[13]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[14]_i_1 
       (.I0(AWADDR_reg[14]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[14]_i_2_n_0 ),
        .O(\addrW[14]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrW[14]_i_2 
       (.I0(addr[14]),
        .I1(\addrW[15]_i_3_n_0 ),
        .I2(\p_1_out_inferred__0/i__carry__2_n_7 ),
        .I3(get_next_addr_wr2[14]),
        .I4(\addrW[15]_i_5_n_0 ),
        .I5(\addrW[14]_i_3_n_0 ),
        .O(\addrW[14]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrW[14]_i_3 
       (.I0(get_next_addr_wr0[12]),
        .I1(\addrW[2]_i_5_n_0 ),
        .I2(get_next_addr_wr00_in[14]),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(\AWBURST_reg_reg_n_0_[0] ),
        .I5(addr[14]),
        .O(\addrW[14]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[15]_i_1 
       (.I0(AWADDR_reg[15]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[15]_i_2_n_0 ),
        .O(\addrW[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrW[15]_i_10 
       (.I0(addr[12]),
        .I1(\p_1_out_inferred__0/i__carry__1_n_5 ),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .O(get_next_addr_wr3[12]));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrW[15]_i_2 
       (.I0(addr[15]),
        .I1(\addrW[15]_i_3_n_0 ),
        .I2(\p_1_out_inferred__0/i__carry__2_n_6 ),
        .I3(get_next_addr_wr2[15]),
        .I4(\addrW[15]_i_5_n_0 ),
        .I5(\addrW[15]_i_6_n_0 ),
        .O(\addrW[15]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT3 #(
    .INIT(8'h01)) 
    \addrW[15]_i_3 
       (.I0(AWSIZE_reg[0]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .O(\addrW[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h2)) 
    \addrW[15]_i_5 
       (.I0(\AWBURST_reg_reg_n_0_[1] ),
        .I1(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[15]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrW[15]_i_6 
       (.I0(get_next_addr_wr0[13]),
        .I1(\addrW[2]_i_5_n_0 ),
        .I2(get_next_addr_wr00_in[15]),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(\AWBURST_reg_reg_n_0_[0] ),
        .I5(addr[15]),
        .O(\addrW[15]_i_6_n_0 ));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrW[15]_i_7 
       (.I0(addr[15]),
        .I1(\p_1_out_inferred__0/i__carry__2_n_6 ),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .O(get_next_addr_wr3[15]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrW[15]_i_8 
       (.I0(addr[14]),
        .I1(\p_1_out_inferred__0/i__carry__2_n_7 ),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .O(get_next_addr_wr3[14]));
  LUT5 #(
    .INIT(32'h88888880)) 
    \addrW[15]_i_9 
       (.I0(addr[13]),
        .I1(\p_1_out_inferred__0/i__carry__1_n_4 ),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .O(get_next_addr_wr3[13]));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[16]_i_1 
       (.I0(AWADDR_reg[16]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[16]_i_2_n_0 ),
        .O(\addrW[16]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[16]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[16]),
        .I2(addr[16]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[16]_i_3_n_0 ),
        .O(\addrW[16]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[16]_i_3 
       (.I0(get_next_addr_wr00_in[16]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[14]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[16]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[17]_i_1 
       (.I0(AWADDR_reg[17]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[17]_i_2_n_0 ),
        .O(\addrW[17]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[17]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[17]),
        .I2(addr[17]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[17]_i_3_n_0 ),
        .O(\addrW[17]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[17]_i_3 
       (.I0(get_next_addr_wr00_in[17]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[15]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[17]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[18]_i_1 
       (.I0(AWADDR_reg[18]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[18]_i_2_n_0 ),
        .O(\addrW[18]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[18]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[18]),
        .I2(addr[18]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[18]_i_3_n_0 ),
        .O(\addrW[18]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[18]_i_3 
       (.I0(get_next_addr_wr00_in[18]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[16]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[18]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[19]_i_1 
       (.I0(AWADDR_reg[19]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[19]_i_2_n_0 ),
        .O(\addrW[19]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[19]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[19]),
        .I2(addr[19]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[19]_i_4_n_0 ),
        .O(\addrW[19]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[19]_i_4 
       (.I0(get_next_addr_wr00_in[19]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[17]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[19]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[19]_i_5 
       (.I0(addr[19]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[19]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[19]_i_6 
       (.I0(addr[18]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[18]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[19]_i_7 
       (.I0(addr[17]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[17]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[19]_i_8 
       (.I0(addr[16]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[16]));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[1]_i_1 
       (.I0(AWADDR_reg[1]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[1]_i_2_n_0 ),
        .O(\addrW[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA0CCA0CCAFCCA0C)) 
    \addrW[1]_i_2 
       (.I0(\addrW[1]_i_3_n_0 ),
        .I1(addr[1]),
        .I2(\AWBURST_reg_reg_n_0_[0] ),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(get_next_addr_wr00_in[1]),
        .I5(\addrW[2]_i_5_n_0 ),
        .O(\addrW[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFEEFA0000220A)) 
    \addrW[1]_i_3 
       (.I0(addr[1]),
        .I1(AWLEN_reg[0]),
        .I2(AWLEN_reg[1]),
        .I3(AWSIZE_reg[0]),
        .I4(\addrW[2]_i_5_n_0 ),
        .I5(get_next_addr_wr2[1]),
        .O(\addrW[1]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[20]_i_1 
       (.I0(AWADDR_reg[20]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[20]_i_2_n_0 ),
        .O(\addrW[20]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[20]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[20]),
        .I2(addr[20]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[20]_i_3_n_0 ),
        .O(\addrW[20]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[20]_i_3 
       (.I0(get_next_addr_wr00_in[20]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[18]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[20]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[21]_i_1 
       (.I0(AWADDR_reg[21]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[21]_i_2_n_0 ),
        .O(\addrW[21]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[21]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[21]),
        .I2(addr[21]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[21]_i_3_n_0 ),
        .O(\addrW[21]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[21]_i_3 
       (.I0(get_next_addr_wr00_in[21]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[19]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[21]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[22]_i_1 
       (.I0(AWADDR_reg[22]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[22]_i_2_n_0 ),
        .O(\addrW[22]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[22]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[22]),
        .I2(addr[22]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[22]_i_3_n_0 ),
        .O(\addrW[22]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[22]_i_3 
       (.I0(get_next_addr_wr00_in[22]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[20]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[22]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[23]_i_1 
       (.I0(AWADDR_reg[23]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[23]_i_2_n_0 ),
        .O(\addrW[23]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[23]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[23]),
        .I2(addr[23]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[23]_i_4_n_0 ),
        .O(\addrW[23]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[23]_i_4 
       (.I0(get_next_addr_wr00_in[23]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[21]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[23]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[23]_i_5 
       (.I0(addr[23]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[23]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[23]_i_6 
       (.I0(addr[22]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[22]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[23]_i_7 
       (.I0(addr[21]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[21]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[23]_i_8 
       (.I0(addr[20]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[20]));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[24]_i_1 
       (.I0(AWADDR_reg[24]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[24]_i_2_n_0 ),
        .O(\addrW[24]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[24]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[24]),
        .I2(addr[24]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[24]_i_3_n_0 ),
        .O(\addrW[24]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[24]_i_3 
       (.I0(get_next_addr_wr00_in[24]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[22]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[24]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[25]_i_1 
       (.I0(AWADDR_reg[25]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[25]_i_2_n_0 ),
        .O(\addrW[25]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[25]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[25]),
        .I2(addr[25]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[25]_i_3_n_0 ),
        .O(\addrW[25]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[25]_i_3 
       (.I0(get_next_addr_wr00_in[25]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[23]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[25]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[26]_i_1 
       (.I0(AWADDR_reg[26]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[26]_i_2_n_0 ),
        .O(\addrW[26]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[26]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[26]),
        .I2(addr[26]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[26]_i_3_n_0 ),
        .O(\addrW[26]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[26]_i_3 
       (.I0(get_next_addr_wr00_in[26]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[24]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[26]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[27]_i_1 
       (.I0(AWADDR_reg[27]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[27]_i_2_n_0 ),
        .O(\addrW[27]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[27]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[27]),
        .I2(addr[27]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[27]_i_4_n_0 ),
        .O(\addrW[27]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[27]_i_4 
       (.I0(get_next_addr_wr00_in[27]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[25]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[27]_i_4_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[27]_i_5 
       (.I0(addr[27]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[27]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[27]_i_6 
       (.I0(addr[26]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[26]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[27]_i_7 
       (.I0(addr[25]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[25]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[27]_i_8 
       (.I0(addr[24]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[24]));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[28]_i_1 
       (.I0(AWADDR_reg[28]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[28]_i_2_n_0 ),
        .O(\addrW[28]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[28]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[28]),
        .I2(addr[28]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[28]_i_3_n_0 ),
        .O(\addrW[28]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[28]_i_3 
       (.I0(get_next_addr_wr00_in[28]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[26]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[28]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[29]_i_1 
       (.I0(AWADDR_reg[29]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[29]_i_2_n_0 ),
        .O(\addrW[29]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[29]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[29]),
        .I2(addr[29]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[29]_i_3_n_0 ),
        .O(\addrW[29]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[29]_i_3 
       (.I0(get_next_addr_wr00_in[29]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[27]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[29]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[2]_i_1 
       (.I0(AWADDR_reg[2]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[2]_i_2_n_0 ),
        .O(\addrW[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hCA3CCA3CCAFCCA0C)) 
    \addrW[2]_i_2 
       (.I0(\addrW[2]_i_3_n_0 ),
        .I1(addr[2]),
        .I2(\AWBURST_reg_reg_n_0_[0] ),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(get_next_addr_wr00_in[2]),
        .I5(\addrW[2]_i_5_n_0 ),
        .O(\addrW[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFEAAAE0002AAA2)) 
    \addrW[2]_i_3 
       (.I0(addr[2]),
        .I1(AWLEN_reg[2]),
        .I2(AWSIZE_reg[0]),
        .I3(\addrW[2]_i_5_n_0 ),
        .I4(\p_1_out_inferred__0/i__carry_n_7 ),
        .I5(get_next_addr_wr2[2]),
        .O(\addrW[2]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'hE)) 
    \addrW[2]_i_5 
       (.I0(AWSIZE_reg[1]),
        .I1(AWSIZE_reg[2]),
        .O(\addrW[2]_i_5_n_0 ));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \addrW[2]_i_6 
       (.I0(addr[3]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[2]),
        .O(\addrW[2]_i_6_n_0 ));
  LUT4 #(
    .INIT(16'hAA9A)) 
    \addrW[2]_i_7 
       (.I0(addr[2]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[2]),
        .O(\addrW[2]_i_7_n_0 ));
  LUT4 #(
    .INIT(16'hA9AA)) 
    \addrW[2]_i_8 
       (.I0(addr[1]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[0]),
        .O(\addrW[2]_i_8_n_0 ));
  LUT4 #(
    .INIT(16'hAAA9)) 
    \addrW[2]_i_9 
       (.I0(addr[0]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[0]),
        .O(\addrW[2]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[30]_i_1 
       (.I0(AWADDR_reg[30]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[30]_i_2_n_0 ),
        .O(\addrW[30]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[30]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[30]),
        .I2(addr[30]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[30]_i_3_n_0 ),
        .O(\addrW[30]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[30]_i_3 
       (.I0(get_next_addr_wr00_in[30]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[28]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[30]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[31]_i_1 
       (.I0(AWADDR_reg[31]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[31]_i_2_n_0 ),
        .O(\addrW[31]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[31]_i_2 
       (.I0(\addrW[31]_i_3_n_0 ),
        .I1(get_next_addr_wr2[31]),
        .I2(addr[31]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[31]_i_5_n_0 ),
        .O(\addrW[31]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'hAAAB)) 
    \addrW[31]_i_3 
       (.I0(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[0]),
        .O(\addrW[31]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[31]_i_5 
       (.I0(get_next_addr_wr00_in[31]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[29]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[31]_i_5_n_0 ));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[31]_i_6 
       (.I0(addr[31]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[31]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[31]_i_7 
       (.I0(addr[30]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[30]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[31]_i_8 
       (.I0(addr[29]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[29]));
  LUT5 #(
    .INIT(32'h0000AAA8)) 
    \addrW[31]_i_9 
       (.I0(addr[28]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__2_n_1 ),
        .O(get_next_addr_wr3[28]));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[3]_i_1 
       (.I0(AWADDR_reg[3]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[3]_i_2_n_0 ),
        .O(\addrW[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hC0C0C0C03FC0C0A0)) 
    \addrW[3]_i_10 
       (.I0(AWLEN_reg[3]),
        .I1(\p_1_out_inferred__0/i__carry_n_6 ),
        .I2(addr[3]),
        .I3(AWSIZE_reg[0]),
        .I4(AWSIZE_reg[1]),
        .I5(AWSIZE_reg[2]),
        .O(\addrW[3]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hC0C0C0C0C03FC0A0)) 
    \addrW[3]_i_11 
       (.I0(AWLEN_reg[2]),
        .I1(\p_1_out_inferred__0/i__carry_n_7 ),
        .I2(addr[2]),
        .I3(AWSIZE_reg[0]),
        .I4(AWSIZE_reg[1]),
        .I5(AWSIZE_reg[2]),
        .O(\addrW[3]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hF0F0F05FF0F0F0C0)) 
    \addrW[3]_i_12 
       (.I0(AWLEN_reg[0]),
        .I1(AWLEN_reg[1]),
        .I2(addr[1]),
        .I3(AWSIZE_reg[1]),
        .I4(AWSIZE_reg[2]),
        .I5(AWSIZE_reg[0]),
        .O(\addrW[3]_i_12_n_0 ));
  LUT5 #(
    .INIT(32'hCCCCCCC7)) 
    \addrW[3]_i_13 
       (.I0(AWLEN_reg[0]),
        .I1(addr[0]),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[0]),
        .O(\addrW[3]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[3]_i_2 
       (.I0(\addrW[3]_i_3_n_0 ),
        .I1(get_next_addr_wr2[3]),
        .I2(addr[3]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[3]_i_5_n_0 ),
        .O(\addrW[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrW[3]_i_3 
       (.I0(AWLEN_reg[3]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry_n_6 ),
        .O(\addrW[3]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[3]_i_5 
       (.I0(get_next_addr_wr00_in[3]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[1]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[3]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h40)) 
    \addrW[3]_i_6 
       (.I0(AWSIZE_reg[2]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[0]),
        .O(\addrW[3]_i_6_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \addrW[3]_i_7 
       (.I0(AWSIZE_reg[2]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[0]),
        .O(\addrW[3]_i_7_n_0 ));
  LUT6 #(
    .INIT(64'hAAAAAAA8A8AAA8A8)) 
    \addrW[3]_i_8 
       (.I0(addr[1]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[0]),
        .I4(AWLEN_reg[1]),
        .I5(AWLEN_reg[0]),
        .O(get_next_addr_wr3[1]));
  LUT3 #(
    .INIT(8'h01)) 
    \addrW[3]_i_9 
       (.I0(AWSIZE_reg[0]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .O(\addrW[3]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[4]_i_1 
       (.I0(AWADDR_reg[4]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[4]_i_2_n_0 ),
        .O(\addrW[4]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[4]_i_2 
       (.I0(\addrW[4]_i_3_n_0 ),
        .I1(get_next_addr_wr2[4]),
        .I2(addr[4]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[4]_i_4_n_0 ),
        .O(\addrW[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrW[4]_i_3 
       (.I0(AWLEN_reg[4]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry_n_5 ),
        .O(\addrW[4]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[4]_i_4 
       (.I0(get_next_addr_wr00_in[4]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[2]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[4]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[5]_i_1 
       (.I0(AWADDR_reg[5]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[5]_i_2_n_0 ),
        .O(\addrW[5]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[5]_i_2 
       (.I0(\addrW[5]_i_3_n_0 ),
        .I1(get_next_addr_wr2[5]),
        .I2(addr[5]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[5]_i_4_n_0 ),
        .O(\addrW[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrW[5]_i_3 
       (.I0(AWLEN_reg[5]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry_n_4 ),
        .O(\addrW[5]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[5]_i_4 
       (.I0(get_next_addr_wr00_in[5]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[3]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[5]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[6]_i_1 
       (.I0(AWADDR_reg[6]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[6]_i_2_n_0 ),
        .O(\addrW[6]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[6]_i_2 
       (.I0(\addrW[6]_i_3_n_0 ),
        .I1(get_next_addr_wr2[6]),
        .I2(addr[6]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[6]_i_4_n_0 ),
        .O(\addrW[6]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrW[6]_i_3 
       (.I0(AWLEN_reg[6]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__0_n_7 ),
        .O(\addrW[6]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[6]_i_4 
       (.I0(get_next_addr_wr00_in[6]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[4]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[6]_i_4_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[7]_i_1 
       (.I0(AWADDR_reg[7]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[7]_i_2_n_0 ),
        .O(\addrW[7]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3FC0C0C0C0C0C0A0)) 
    \addrW[7]_i_10 
       (.I0(AWLEN_reg[7]),
        .I1(\p_1_out_inferred__0/i__carry__0_n_6 ),
        .I2(addr[7]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .I5(AWSIZE_reg[0]),
        .O(\addrW[7]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'hC03FC0C0C0C0C0A0)) 
    \addrW[7]_i_11 
       (.I0(AWLEN_reg[6]),
        .I1(\p_1_out_inferred__0/i__carry__0_n_7 ),
        .I2(addr[6]),
        .I3(AWSIZE_reg[0]),
        .I4(AWSIZE_reg[2]),
        .I5(AWSIZE_reg[1]),
        .O(\addrW[7]_i_11_n_0 ));
  LUT6 #(
    .INIT(64'hC0C0C0C03FC0C0A0)) 
    \addrW[7]_i_12 
       (.I0(AWLEN_reg[5]),
        .I1(\p_1_out_inferred__0/i__carry_n_4 ),
        .I2(addr[5]),
        .I3(AWSIZE_reg[0]),
        .I4(AWSIZE_reg[2]),
        .I5(AWSIZE_reg[1]),
        .O(\addrW[7]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'hC0C0C0C0C03FC0A0)) 
    \addrW[7]_i_13 
       (.I0(AWLEN_reg[4]),
        .I1(\p_1_out_inferred__0/i__carry_n_5 ),
        .I2(addr[4]),
        .I3(AWSIZE_reg[0]),
        .I4(AWSIZE_reg[2]),
        .I5(AWSIZE_reg[1]),
        .O(\addrW[7]_i_13_n_0 ));
  LUT4 #(
    .INIT(16'h6AAA)) 
    \addrW[7]_i_15 
       (.I0(addr[7]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[0]),
        .O(\addrW[7]_i_15_n_0 ));
  LUT4 #(
    .INIT(16'h9AAA)) 
    \addrW[7]_i_16 
       (.I0(addr[6]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .O(\addrW[7]_i_16_n_0 ));
  LUT4 #(
    .INIT(16'hAA6A)) 
    \addrW[7]_i_17 
       (.I0(addr[5]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .O(\addrW[7]_i_17_n_0 ));
  LUT4 #(
    .INIT(16'hAA9A)) 
    \addrW[7]_i_18 
       (.I0(addr[4]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .O(\addrW[7]_i_18_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFF0E400F0)) 
    \addrW[7]_i_2 
       (.I0(\addrW[7]_i_3_n_0 ),
        .I1(get_next_addr_wr2[7]),
        .I2(addr[7]),
        .I3(\AWBURST_reg_reg_n_0_[0] ),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\addrW[7]_i_5_n_0 ),
        .O(\addrW[7]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h0001FFFD)) 
    \addrW[7]_i_3 
       (.I0(AWLEN_reg[7]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(\p_1_out_inferred__0/i__carry__0_n_6 ),
        .O(\addrW[7]_i_3_n_0 ));
  LUT6 #(
    .INIT(64'h0000FE0200000000)) 
    \addrW[7]_i_5 
       (.I0(get_next_addr_wr00_in[7]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(get_next_addr_wr0[5]),
        .I4(\AWBURST_reg_reg_n_0_[1] ),
        .I5(\AWBURST_reg_reg_n_0_[0] ),
        .O(\addrW[7]_i_5_n_0 ));
  LUT3 #(
    .INIT(8'h80)) 
    \addrW[7]_i_6 
       (.I0(AWSIZE_reg[0]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .O(\addrW[7]_i_6_n_0 ));
  LUT6 #(
    .INIT(64'h8888888A88888880)) 
    \addrW[7]_i_7 
       (.I0(addr[6]),
        .I1(\p_1_out_inferred__0/i__carry__0_n_7 ),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[0]),
        .I5(AWLEN_reg[6]),
        .O(get_next_addr_wr3[6]));
  LUT3 #(
    .INIT(8'h40)) 
    \addrW[7]_i_8 
       (.I0(AWSIZE_reg[1]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[0]),
        .O(\addrW[7]_i_8_n_0 ));
  LUT3 #(
    .INIT(8'h04)) 
    \addrW[7]_i_9 
       (.I0(AWSIZE_reg[1]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[0]),
        .O(\addrW[7]_i_9_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[8]_i_1 
       (.I0(AWADDR_reg[8]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[8]_i_2_n_0 ),
        .O(\addrW[8]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrW[8]_i_2 
       (.I0(addr[8]),
        .I1(\addrW[15]_i_3_n_0 ),
        .I2(\p_1_out_inferred__0/i__carry__0_n_5 ),
        .I3(get_next_addr_wr2[8]),
        .I4(\addrW[15]_i_5_n_0 ),
        .I5(\addrW[8]_i_3_n_0 ),
        .O(\addrW[8]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrW[8]_i_3 
       (.I0(get_next_addr_wr0[6]),
        .I1(\addrW[2]_i_5_n_0 ),
        .I2(get_next_addr_wr00_in[8]),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(\AWBURST_reg_reg_n_0_[0] ),
        .I5(addr[8]),
        .O(\addrW[8]_i_3_n_0 ));
  LUT4 #(
    .INIT(16'hFE02)) 
    \addrW[9]_i_1 
       (.I0(AWADDR_reg[9]),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\addrW[9]_i_2_n_0 ),
        .O(\addrW[9]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFBA8A0000)) 
    \addrW[9]_i_2 
       (.I0(addr[9]),
        .I1(\addrW[15]_i_3_n_0 ),
        .I2(\p_1_out_inferred__0/i__carry__0_n_4 ),
        .I3(get_next_addr_wr2[9]),
        .I4(\addrW[15]_i_5_n_0 ),
        .I5(\addrW[9]_i_3_n_0 ),
        .O(\addrW[9]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFB800FF00B80000)) 
    \addrW[9]_i_3 
       (.I0(get_next_addr_wr0[7]),
        .I1(\addrW[2]_i_5_n_0 ),
        .I2(get_next_addr_wr00_in[9]),
        .I3(\AWBURST_reg_reg_n_0_[1] ),
        .I4(\AWBURST_reg_reg_n_0_[0] ),
        .I5(addr[9]),
        .O(\addrW[9]_i_3_n_0 ));
  FDCE \addrW_reg[0] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[0]_i_1_n_0 ),
        .Q(addr[0]));
  FDCE \addrW_reg[10] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[10]_i_1_n_0 ),
        .Q(addr[10]));
  FDCE \addrW_reg[11] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[11]_i_1_n_0 ),
        .Q(addr[11]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[11]_i_3 
       (.CI(\addrW_reg[7]_i_4_n_0 ),
        .CO({\addrW_reg[11]_i_3_n_0 ,\addrW_reg[11]_i_3_n_1 ,\addrW_reg[11]_i_3_n_2 ,\addrW_reg[11]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr2[11:8]),
        .S(get_next_addr_wr3[11:8]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[11]_i_9 
       (.CI(\addrW_reg[7]_i_14_n_0 ),
        .CO({\addrW_reg[11]_i_9_n_0 ,\addrW_reg[11]_i_9_n_1 ,\addrW_reg[11]_i_9_n_2 ,\addrW_reg[11]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr00_in[11:8]),
        .S(addr[11:8]));
  FDCE \addrW_reg[12] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[12]_i_1_n_0 ),
        .Q(addr[12]));
  FDCE \addrW_reg[13] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[13]_i_1_n_0 ),
        .Q(addr[13]));
  FDCE \addrW_reg[14] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[14]_i_1_n_0 ),
        .Q(addr[14]));
  FDCE \addrW_reg[15] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[15]_i_1_n_0 ),
        .Q(addr[15]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[15]_i_11 
       (.CI(\addrW_reg[11]_i_9_n_0 ),
        .CO({\addrW_reg[15]_i_11_n_0 ,\addrW_reg[15]_i_11_n_1 ,\addrW_reg[15]_i_11_n_2 ,\addrW_reg[15]_i_11_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr00_in[15:12]),
        .S(addr[15:12]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[15]_i_4 
       (.CI(\addrW_reg[11]_i_3_n_0 ),
        .CO({\addrW_reg[15]_i_4_n_0 ,\addrW_reg[15]_i_4_n_1 ,\addrW_reg[15]_i_4_n_2 ,\addrW_reg[15]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr2[15:12]),
        .S(get_next_addr_wr3[15:12]));
  FDCE \addrW_reg[16] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[16]_i_1_n_0 ),
        .Q(addr[16]));
  FDCE \addrW_reg[17] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[17]_i_1_n_0 ),
        .Q(addr[17]));
  FDCE \addrW_reg[18] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[18]_i_1_n_0 ),
        .Q(addr[18]));
  FDCE \addrW_reg[19] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[19]_i_1_n_0 ),
        .Q(addr[19]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[19]_i_3 
       (.CI(\addrW_reg[15]_i_4_n_0 ),
        .CO({\addrW_reg[19]_i_3_n_0 ,\addrW_reg[19]_i_3_n_1 ,\addrW_reg[19]_i_3_n_2 ,\addrW_reg[19]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr2[19:16]),
        .S(get_next_addr_wr3[19:16]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[19]_i_9 
       (.CI(\addrW_reg[15]_i_11_n_0 ),
        .CO({\addrW_reg[19]_i_9_n_0 ,\addrW_reg[19]_i_9_n_1 ,\addrW_reg[19]_i_9_n_2 ,\addrW_reg[19]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr00_in[19:16]),
        .S(addr[19:16]));
  FDCE \addrW_reg[1] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[1]_i_1_n_0 ),
        .Q(addr[1]));
  FDCE \addrW_reg[20] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[20]_i_1_n_0 ),
        .Q(addr[20]));
  FDCE \addrW_reg[21] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[21]_i_1_n_0 ),
        .Q(addr[21]));
  FDCE \addrW_reg[22] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[22]_i_1_n_0 ),
        .Q(addr[22]));
  FDCE \addrW_reg[23] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[23]_i_1_n_0 ),
        .Q(addr[23]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[23]_i_3 
       (.CI(\addrW_reg[19]_i_3_n_0 ),
        .CO({\addrW_reg[23]_i_3_n_0 ,\addrW_reg[23]_i_3_n_1 ,\addrW_reg[23]_i_3_n_2 ,\addrW_reg[23]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr2[23:20]),
        .S(get_next_addr_wr3[23:20]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[23]_i_9 
       (.CI(\addrW_reg[19]_i_9_n_0 ),
        .CO({\addrW_reg[23]_i_9_n_0 ,\addrW_reg[23]_i_9_n_1 ,\addrW_reg[23]_i_9_n_2 ,\addrW_reg[23]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr00_in[23:20]),
        .S(addr[23:20]));
  FDCE \addrW_reg[24] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[24]_i_1_n_0 ),
        .Q(addr[24]));
  FDCE \addrW_reg[25] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[25]_i_1_n_0 ),
        .Q(addr[25]));
  FDCE \addrW_reg[26] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[26]_i_1_n_0 ),
        .Q(addr[26]));
  FDCE \addrW_reg[27] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[27]_i_1_n_0 ),
        .Q(addr[27]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[27]_i_3 
       (.CI(\addrW_reg[23]_i_3_n_0 ),
        .CO({\addrW_reg[27]_i_3_n_0 ,\addrW_reg[27]_i_3_n_1 ,\addrW_reg[27]_i_3_n_2 ,\addrW_reg[27]_i_3_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr2[27:24]),
        .S(get_next_addr_wr3[27:24]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[27]_i_9 
       (.CI(\addrW_reg[23]_i_9_n_0 ),
        .CO({\addrW_reg[27]_i_9_n_0 ,\addrW_reg[27]_i_9_n_1 ,\addrW_reg[27]_i_9_n_2 ,\addrW_reg[27]_i_9_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr00_in[27:24]),
        .S(addr[27:24]));
  FDCE \addrW_reg[28] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[28]_i_1_n_0 ),
        .Q(addr[28]));
  FDCE \addrW_reg[29] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[29]_i_1_n_0 ),
        .Q(addr[29]));
  FDCE \addrW_reg[2] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[2]_i_1_n_0 ),
        .Q(addr[2]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[2]_i_4 
       (.CI(1'b0),
        .CO({\addrW_reg[2]_i_4_n_0 ,\addrW_reg[2]_i_4_n_1 ,\addrW_reg[2]_i_4_n_2 ,\addrW_reg[2]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI(addr[3:0]),
        .O(get_next_addr_wr00_in[3:0]),
        .S({\addrW[2]_i_6_n_0 ,\addrW[2]_i_7_n_0 ,\addrW[2]_i_8_n_0 ,\addrW[2]_i_9_n_0 }));
  FDCE \addrW_reg[30] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[30]_i_1_n_0 ),
        .Q(addr[30]));
  FDCE \addrW_reg[31] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[31]_i_1_n_0 ),
        .Q(addr[31]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[31]_i_10 
       (.CI(\addrW_reg[27]_i_9_n_0 ),
        .CO({\NLW_addrW_reg[31]_i_10_CO_UNCONNECTED [3],\addrW_reg[31]_i_10_n_1 ,\addrW_reg[31]_i_10_n_2 ,\addrW_reg[31]_i_10_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr00_in[31:28]),
        .S(addr[31:28]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[31]_i_4 
       (.CI(\addrW_reg[27]_i_3_n_0 ),
        .CO({\NLW_addrW_reg[31]_i_4_CO_UNCONNECTED [3],\addrW_reg[31]_i_4_n_1 ,\addrW_reg[31]_i_4_n_2 ,\addrW_reg[31]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr2[31:28]),
        .S(get_next_addr_wr3[31:28]));
  FDCE \addrW_reg[3] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[3]_i_1_n_0 ),
        .Q(addr[3]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[3]_i_4 
       (.CI(1'b0),
        .CO({\addrW_reg[3]_i_4_n_0 ,\addrW_reg[3]_i_4_n_1 ,\addrW_reg[3]_i_4_n_2 ,\addrW_reg[3]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({\addrW[3]_i_6_n_0 ,\addrW[3]_i_7_n_0 ,get_next_addr_wr3[1],\addrW[3]_i_9_n_0 }),
        .O(get_next_addr_wr2[3:0]),
        .S({\addrW[3]_i_10_n_0 ,\addrW[3]_i_11_n_0 ,\addrW[3]_i_12_n_0 ,\addrW[3]_i_13_n_0 }));
  FDCE \addrW_reg[4] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[4]_i_1_n_0 ),
        .Q(addr[4]));
  FDCE \addrW_reg[5] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[5]_i_1_n_0 ),
        .Q(addr[5]));
  FDCE \addrW_reg[6] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[6]_i_1_n_0 ),
        .Q(addr[6]));
  FDCE \addrW_reg[7] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[7]_i_1_n_0 ),
        .Q(addr[7]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[7]_i_14 
       (.CI(\addrW_reg[2]_i_4_n_0 ),
        .CO({\addrW_reg[7]_i_14_n_0 ,\addrW_reg[7]_i_14_n_1 ,\addrW_reg[7]_i_14_n_2 ,\addrW_reg[7]_i_14_n_3 }),
        .CYINIT(1'b0),
        .DI(addr[7:4]),
        .O(get_next_addr_wr00_in[7:4]),
        .S({\addrW[7]_i_15_n_0 ,\addrW[7]_i_16_n_0 ,\addrW[7]_i_17_n_0 ,\addrW[7]_i_18_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \addrW_reg[7]_i_4 
       (.CI(\addrW_reg[3]_i_4_n_0 ),
        .CO({\addrW_reg[7]_i_4_n_0 ,\addrW_reg[7]_i_4_n_1 ,\addrW_reg[7]_i_4_n_2 ,\addrW_reg[7]_i_4_n_3 }),
        .CYINIT(1'b0),
        .DI({\addrW[7]_i_6_n_0 ,get_next_addr_wr3[6],\addrW[7]_i_8_n_0 ,\addrW[7]_i_9_n_0 }),
        .O(get_next_addr_wr2[7:4]),
        .S({\addrW[7]_i_10_n_0 ,\addrW[7]_i_11_n_0 ,\addrW[7]_i_12_n_0 ,\addrW[7]_i_13_n_0 }));
  FDCE \addrW_reg[8] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[8]_i_1_n_0 ),
        .Q(addr[8]));
  FDCE \addrW_reg[9] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\addrW[9]_i_1_n_0 ),
        .Q(addr[9]));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT2 #(
    .INIT(4'h2)) 
    \beatR[0]_i_1 
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(beatR[0]),
        .O(p_1_in[0]));
  (* SOFT_HLUTNM = "soft_lutpair72" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \beatR[1]_i_1 
       (.I0(beatR[1]),
        .I1(beatR[0]),
        .I2(\stateR_reg_n_0_[2] ),
        .O(\beatR[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT4 #(
    .INIT(16'h2A80)) 
    \beatR[2]_i_1 
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(beatR[0]),
        .I2(beatR[1]),
        .I3(beatR[2]),
        .O(p_1_in[2]));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT5 #(
    .INIT(32'h2AAA8000)) 
    \beatR[3]_i_1 
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(beatR[1]),
        .I2(beatR[0]),
        .I3(beatR[2]),
        .I4(beatR[3]),
        .O(p_1_in[3]));
  LUT6 #(
    .INIT(64'h2AAAAAAA80000000)) 
    \beatR[4]_i_1 
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(beatR[2]),
        .I2(beatR[0]),
        .I3(beatR[1]),
        .I4(beatR[3]),
        .I5(beatR[4]),
        .O(p_1_in[4]));
  LUT3 #(
    .INIT(8'h28)) 
    \beatR[5]_i_1 
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(\beatR[5]_i_2_n_0 ),
        .I2(beatR[5]),
        .O(p_1_in[5]));
  LUT5 #(
    .INIT(32'h80000000)) 
    \beatR[5]_i_2 
       (.I0(beatR[3]),
        .I1(beatR[1]),
        .I2(beatR[0]),
        .I3(beatR[2]),
        .I4(beatR[4]),
        .O(\beatR[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT3 #(
    .INIT(8'h60)) 
    \beatR[6]_i_1 
       (.I0(\beatR[7]_i_3_n_0 ),
        .I1(beatR[6]),
        .I2(\stateR_reg_n_0_[2] ),
        .O(\beatR[6]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h4022)) 
    \beatR[7]_i_1 
       (.I0(\stateR_reg_n_0_[0] ),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(s_axi_rready),
        .I3(\stateR_reg_n_0_[1] ),
        .O(\beatR[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT4 #(
    .INIT(16'h2A80)) 
    \beatR[7]_i_2 
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(beatR[6]),
        .I2(\beatR[7]_i_3_n_0 ),
        .I3(beatR[7]),
        .O(p_1_in[7]));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \beatR[7]_i_3 
       (.I0(beatR[4]),
        .I1(beatR[2]),
        .I2(beatR[0]),
        .I3(beatR[1]),
        .I4(beatR[3]),
        .I5(beatR[5]),
        .O(\beatR[7]_i_3_n_0 ));
  FDCE \beatR_reg[0] 
       (.C(axi_aclk),
        .CE(\beatR[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(p_1_in[0]),
        .Q(beatR[0]));
  FDCE \beatR_reg[1] 
       (.C(axi_aclk),
        .CE(\beatR[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatR[1]_i_1_n_0 ),
        .Q(beatR[1]));
  FDCE \beatR_reg[2] 
       (.C(axi_aclk),
        .CE(\beatR[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(p_1_in[2]),
        .Q(beatR[2]));
  FDCE \beatR_reg[3] 
       (.C(axi_aclk),
        .CE(\beatR[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(p_1_in[3]),
        .Q(beatR[3]));
  FDCE \beatR_reg[4] 
       (.C(axi_aclk),
        .CE(\beatR[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(p_1_in[4]),
        .Q(beatR[4]));
  FDCE \beatR_reg[5] 
       (.C(axi_aclk),
        .CE(\beatR[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(p_1_in[5]),
        .Q(beatR[5]));
  FDCE \beatR_reg[6] 
       (.C(axi_aclk),
        .CE(\beatR[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatR[6]_i_1_n_0 ),
        .Q(beatR[6]));
  FDCE \beatR_reg[7] 
       (.C(axi_aclk),
        .CE(\beatR[7]_i_1_n_0 ),
        .CLR(AWREADY_i_2_n_0),
        .D(p_1_in[7]),
        .Q(beatR[7]));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT3 #(
    .INIT(8'h54)) 
    \beatW[0]_i_1 
       (.I0(\beatW_reg_n_0_[0] ),
        .I1(\stateW_reg_n_0_[1] ),
        .I2(\stateW_reg_n_0_[2] ),
        .O(\beatW[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT4 #(
    .INIT(16'h6660)) 
    \beatW[1]_i_1 
       (.I0(\beatW_reg_n_0_[1] ),
        .I1(\beatW_reg_n_0_[0] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\stateW_reg_n_0_[2] ),
        .O(\beatW[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT5 #(
    .INIT(32'h0EEEE000)) 
    \beatW[2]_i_1 
       (.I0(\stateW_reg_n_0_[1] ),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\beatW_reg_n_0_[0] ),
        .I3(\beatW_reg_n_0_[1] ),
        .I4(\beatW_reg_n_0_[2] ),
        .O(\beatW[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h0EEEEEEEE0000000)) 
    \beatW[3]_i_1 
       (.I0(\stateW_reg_n_0_[1] ),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\beatW_reg_n_0_[1] ),
        .I3(\beatW_reg_n_0_[0] ),
        .I4(\beatW_reg_n_0_[2] ),
        .I5(\beatW_reg_n_0_[3] ),
        .O(\beatW[3]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h1555555540000000)) 
    \beatW[4]_i_1 
       (.I0(\beatW[4]_i_2_n_0 ),
        .I1(\beatW_reg_n_0_[2] ),
        .I2(\beatW_reg_n_0_[0] ),
        .I3(\beatW_reg_n_0_[1] ),
        .I4(\beatW_reg_n_0_[3] ),
        .I5(\beatW_reg_n_0_[4] ),
        .O(\beatW[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h1)) 
    \beatW[4]_i_2 
       (.I0(\stateW_reg_n_0_[2] ),
        .I1(\stateW_reg_n_0_[1] ),
        .O(\beatW[4]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT4 #(
    .INIT(16'h0EE0)) 
    \beatW[5]_i_1 
       (.I0(\stateW_reg_n_0_[1] ),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\beatW[5]_i_2_n_0 ),
        .I3(\beatW_reg_n_0_[5] ),
        .O(\beatW[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h80000000)) 
    \beatW[5]_i_2 
       (.I0(\beatW_reg_n_0_[3] ),
        .I1(\beatW_reg_n_0_[1] ),
        .I2(\beatW_reg_n_0_[0] ),
        .I3(\beatW_reg_n_0_[2] ),
        .I4(\beatW_reg_n_0_[4] ),
        .O(\beatW[5]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT4 #(
    .INIT(16'h6660)) 
    \beatW[6]_i_1 
       (.I0(\beatW[7]_i_3_n_0 ),
        .I1(\beatW_reg_n_0_[6] ),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\stateW_reg_n_0_[2] ),
        .O(\beatW[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'h00404466)) 
    \beatW[7]_i_1 
       (.I0(\stateW_reg_n_0_[2] ),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(ACK_reg_n_0),
        .I3(\BID[3]_i_2_n_0 ),
        .I4(\stateW_reg_n_0_[1] ),
        .O(beatW));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT5 #(
    .INIT(32'h0EEEE000)) 
    \beatW[7]_i_2 
       (.I0(\stateW_reg_n_0_[1] ),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\beatW_reg_n_0_[6] ),
        .I3(\beatW[7]_i_3_n_0 ),
        .I4(\beatW_reg_n_0_[7] ),
        .O(\beatW[7]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    \beatW[7]_i_3 
       (.I0(\beatW_reg_n_0_[4] ),
        .I1(\beatW_reg_n_0_[2] ),
        .I2(\beatW_reg_n_0_[0] ),
        .I3(\beatW_reg_n_0_[1] ),
        .I4(\beatW_reg_n_0_[3] ),
        .I5(\beatW_reg_n_0_[5] ),
        .O(\beatW[7]_i_3_n_0 ));
  FDCE \beatW_reg[0] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatW[0]_i_1_n_0 ),
        .Q(\beatW_reg_n_0_[0] ));
  FDCE \beatW_reg[1] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatW[1]_i_1_n_0 ),
        .Q(\beatW_reg_n_0_[1] ));
  FDCE \beatW_reg[2] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatW[2]_i_1_n_0 ),
        .Q(\beatW_reg_n_0_[2] ));
  FDCE \beatW_reg[3] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatW[3]_i_1_n_0 ),
        .Q(\beatW_reg_n_0_[3] ));
  FDCE \beatW_reg[4] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatW[4]_i_1_n_0 ),
        .Q(\beatW_reg_n_0_[4] ));
  FDCE \beatW_reg[5] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatW[5]_i_1_n_0 ),
        .Q(\beatW_reg_n_0_[5] ));
  FDCE \beatW_reg[6] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatW[6]_i_1_n_0 ),
        .Q(\beatW_reg_n_0_[6] ));
  FDCE \beatW_reg[7] 
       (.C(axi_aclk),
        .CE(beatW),
        .CLR(AWREADY_i_2_n_0),
        .D(\beatW[7]_i_2_n_0 ),
        .Q(\beatW_reg_n_0_[7] ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 get_next_addr_rd0_carry
       (.CI(1'b0),
        .CO({get_next_addr_rd0_carry_n_0,get_next_addr_rd0_carry_n_1,get_next_addr_rd0_carry_n_2,get_next_addr_rd0_carry_n_3}),
        .CYINIT(\addrR_reg_n_0_[2] ),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd0[4:1]),
        .S({\addrR_reg_n_0_[6] ,\addrR_reg_n_0_[5] ,\addrR_reg_n_0_[4] ,\addrR_reg_n_0_[3] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 get_next_addr_rd0_carry__0
       (.CI(get_next_addr_rd0_carry_n_0),
        .CO({get_next_addr_rd0_carry__0_n_0,get_next_addr_rd0_carry__0_n_1,get_next_addr_rd0_carry__0_n_2,get_next_addr_rd0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd0[8:5]),
        .S({\addrR_reg_n_0_[10] ,\addrR_reg_n_0_[9] ,\addrR_reg_n_0_[8] ,\addrR_reg_n_0_[7] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 get_next_addr_rd0_carry__1
       (.CI(get_next_addr_rd0_carry__0_n_0),
        .CO({get_next_addr_rd0_carry__1_n_0,get_next_addr_rd0_carry__1_n_1,get_next_addr_rd0_carry__1_n_2,get_next_addr_rd0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd0[12:9]),
        .S({\addrR_reg_n_0_[14] ,\addrR_reg_n_0_[13] ,\addrR_reg_n_0_[12] ,\addrR_reg_n_0_[11] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 get_next_addr_rd0_carry__2
       (.CI(get_next_addr_rd0_carry__1_n_0),
        .CO({get_next_addr_rd0_carry__2_n_0,get_next_addr_rd0_carry__2_n_1,get_next_addr_rd0_carry__2_n_2,get_next_addr_rd0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd0[16:13]),
        .S({\addrR_reg_n_0_[18] ,\addrR_reg_n_0_[17] ,\addrR_reg_n_0_[16] ,\addrR_reg_n_0_[15] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 get_next_addr_rd0_carry__3
       (.CI(get_next_addr_rd0_carry__2_n_0),
        .CO({get_next_addr_rd0_carry__3_n_0,get_next_addr_rd0_carry__3_n_1,get_next_addr_rd0_carry__3_n_2,get_next_addr_rd0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd0[20:17]),
        .S({\addrR_reg_n_0_[22] ,\addrR_reg_n_0_[21] ,\addrR_reg_n_0_[20] ,\addrR_reg_n_0_[19] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 get_next_addr_rd0_carry__4
       (.CI(get_next_addr_rd0_carry__3_n_0),
        .CO({get_next_addr_rd0_carry__4_n_0,get_next_addr_rd0_carry__4_n_1,get_next_addr_rd0_carry__4_n_2,get_next_addr_rd0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd0[24:21]),
        .S({\addrR_reg_n_0_[26] ,\addrR_reg_n_0_[25] ,\addrR_reg_n_0_[24] ,\addrR_reg_n_0_[23] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 get_next_addr_rd0_carry__5
       (.CI(get_next_addr_rd0_carry__4_n_0),
        .CO({get_next_addr_rd0_carry__5_n_0,get_next_addr_rd0_carry__5_n_1,get_next_addr_rd0_carry__5_n_2,get_next_addr_rd0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_rd0[28:25]),
        .S({\addrR_reg_n_0_[30] ,\addrR_reg_n_0_[29] ,\addrR_reg_n_0_[28] ,\addrR_reg_n_0_[27] }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 get_next_addr_rd0_carry__6
       (.CI(get_next_addr_rd0_carry__5_n_0),
        .CO(NLW_get_next_addr_rd0_carry__6_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_get_next_addr_rd0_carry__6_O_UNCONNECTED[3:1],get_next_addr_rd0[29]}),
        .S({1'b0,1'b0,1'b0,\addrR_reg_n_0_[31] }));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 get_next_addr_wr0_carry
       (.CI(1'b0),
        .CO({get_next_addr_wr0_carry_n_0,get_next_addr_wr0_carry_n_1,get_next_addr_wr0_carry_n_2,get_next_addr_wr0_carry_n_3}),
        .CYINIT(addr[2]),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr0[4:1]),
        .S(addr[6:3]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 get_next_addr_wr0_carry__0
       (.CI(get_next_addr_wr0_carry_n_0),
        .CO({get_next_addr_wr0_carry__0_n_0,get_next_addr_wr0_carry__0_n_1,get_next_addr_wr0_carry__0_n_2,get_next_addr_wr0_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr0[8:5]),
        .S(addr[10:7]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 get_next_addr_wr0_carry__1
       (.CI(get_next_addr_wr0_carry__0_n_0),
        .CO({get_next_addr_wr0_carry__1_n_0,get_next_addr_wr0_carry__1_n_1,get_next_addr_wr0_carry__1_n_2,get_next_addr_wr0_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr0[12:9]),
        .S(addr[14:11]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 get_next_addr_wr0_carry__2
       (.CI(get_next_addr_wr0_carry__1_n_0),
        .CO({get_next_addr_wr0_carry__2_n_0,get_next_addr_wr0_carry__2_n_1,get_next_addr_wr0_carry__2_n_2,get_next_addr_wr0_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr0[16:13]),
        .S(addr[18:15]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 get_next_addr_wr0_carry__3
       (.CI(get_next_addr_wr0_carry__2_n_0),
        .CO({get_next_addr_wr0_carry__3_n_0,get_next_addr_wr0_carry__3_n_1,get_next_addr_wr0_carry__3_n_2,get_next_addr_wr0_carry__3_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr0[20:17]),
        .S(addr[22:19]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 get_next_addr_wr0_carry__4
       (.CI(get_next_addr_wr0_carry__3_n_0),
        .CO({get_next_addr_wr0_carry__4_n_0,get_next_addr_wr0_carry__4_n_1,get_next_addr_wr0_carry__4_n_2,get_next_addr_wr0_carry__4_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr0[24:21]),
        .S(addr[26:23]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 get_next_addr_wr0_carry__5
       (.CI(get_next_addr_wr0_carry__4_n_0),
        .CO({get_next_addr_wr0_carry__5_n_0,get_next_addr_wr0_carry__5_n_1,get_next_addr_wr0_carry__5_n_2,get_next_addr_wr0_carry__5_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O(get_next_addr_wr0[28:25]),
        .S(addr[30:27]));
  (* ADDER_THRESHOLD = "35" *) 
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 get_next_addr_wr0_carry__6
       (.CI(get_next_addr_wr0_carry__5_n_0),
        .CO(NLW_get_next_addr_wr0_carry__6_CO_UNCONNECTED[3:0]),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,1'b0,1'b0}),
        .O({NLW_get_next_addr_wr0_carry__6_O_UNCONNECTED[3:1],get_next_addr_wr0[29]}),
        .S({1'b0,1'b0,1'b0,addr[31]}));
  LUT5 #(
    .INIT(32'hABBBA888)) 
    grant_read_i_1
       (.I0(grant_read_i_2_n_0),
        .I1(\ARLEN_reg[7]_i_1_n_0 ),
        .I2(grant_read_i_3_n_0),
        .I3(ARSTRB_reg1),
        .I4(p_0_in[0]),
        .O(grant_read_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT5 #(
    .INIT(32'h88888B88)) 
    grant_read_i_2
       (.I0(ACK_reg_n_0),
        .I1(\stateR_reg_n_0_[0] ),
        .I2(s_axi_awvalid),
        .I3(s_axi_arvalid),
        .I4(p_0_in[1]),
        .O(grant_read_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT4 #(
    .INIT(16'h0040)) 
    grant_read_i_3
       (.I0(ACK_reg_n_0),
        .I1(\stateR_reg_n_0_[0] ),
        .I2(\stateR_reg_n_0_[2] ),
        .I3(\stateR_reg_n_0_[1] ),
        .O(grant_read_i_3_n_0));
  FDCE #(
    .INIT(1'b0)) 
    grant_read_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(grant_read_i_1_n_0),
        .Q(p_0_in[0]));
  LUT6 #(
    .INIT(64'hBBFFFFFF00000030)) 
    grant_write_i_1
       (.I0(ACK_reg_n_0),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(grant_write_i_2_n_0),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(\stateW_reg_n_0_[2] ),
        .I5(p_0_in[1]),
        .O(grant_write_i_1_n_0));
  LUT2 #(
    .INIT(4'h2)) 
    grant_write_i_2
       (.I0(s_axi_awvalid),
        .I1(p_0_in[0]),
        .O(grant_write_i_2_n_0));
  FDCE #(
    .INIT(1'b0)) 
    grant_write_reg
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(grant_write_i_1_n_0),
        .Q(p_0_in[1]));
  LUT6 #(
    .INIT(64'h00000000FDFFF8FF)) 
    i__carry__0_i_1
       (.I0(AWSIZE_reg[0]),
        .I1(i__carry__0_i_9_n_0),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(i__carry__0_i_10_n_0),
        .I5(i__carry__0_i_11_n_0),
        .O(i__carry__0_i_1_n_0));
  LUT3 #(
    .INIT(8'h6A)) 
    i__carry__0_i_10
       (.I0(AWLEN_reg[7]),
        .I1(AWLEN_reg[6]),
        .I2(i__carry__1_i_9_n_0),
        .O(i__carry__0_i_10_n_0));
  LUT5 #(
    .INIT(32'h01C10DCD)) 
    i__carry__0_i_11
       (.I0(i__carry__1_i_10_n_0),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(i__carry__0_i_19_n_0),
        .I4(i__carry__1_i_13_n_0),
        .O(i__carry__0_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT5 #(
    .INIT(32'h3500350F)) 
    i__carry__0_i_12
       (.I0(i__carry__1_i_15_n_0),
        .I1(i__carry__0_i_20_n_0),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[2]),
        .I4(i__carry__0_i_10_n_0),
        .O(i__carry__0_i_12_n_0));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    i__carry__0_i_13
       (.I0(AWLEN_reg[5]),
        .I1(AWLEN_reg[4]),
        .I2(AWLEN_reg[2]),
        .I3(AWLEN_reg[0]),
        .I4(AWLEN_reg[1]),
        .I5(AWLEN_reg[3]),
        .O(i__carry__0_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    i__carry__0_i_14
       (.I0(AWLEN_reg[4]),
        .I1(AWLEN_reg[3]),
        .I2(AWLEN_reg[1]),
        .I3(AWLEN_reg[0]),
        .I4(AWLEN_reg[2]),
        .O(i__carry__0_i_14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT3 #(
    .INIT(8'h15)) 
    i__carry__0_i_15
       (.I0(AWSIZE_reg[2]),
        .I1(AWSIZE_reg[0]),
        .I2(AWSIZE_reg[1]),
        .O(i__carry__0_i_15_n_0));
  LUT6 #(
    .INIT(64'h22EE2EE200CC0000)) 
    i__carry__0_i_16
       (.I0(i__carry__0_i_19_n_0),
        .I1(AWSIZE_reg[1]),
        .I2(AWLEN_reg[1]),
        .I3(AWLEN_reg[0]),
        .I4(AWSIZE_reg[0]),
        .I5(AWSIZE_reg[2]),
        .O(i__carry__0_i_16_n_0));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT2 #(
    .INIT(4'h2)) 
    i__carry__0_i_17
       (.I0(AWSIZE_reg[1]),
        .I1(AWSIZE_reg[2]),
        .O(i__carry__0_i_17_n_0));
  LUT6 #(
    .INIT(64'hF5C50000F5C50F0F)) 
    i__carry__0_i_18
       (.I0(i__carry__0_i_20_n_0),
        .I1(AWLEN_reg[0]),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[0]),
        .I4(AWSIZE_reg[2]),
        .I5(i__carry__0_i_13_n_0),
        .O(i__carry__0_i_18_n_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT5 #(
    .INIT(32'h1EE4E4E4)) 
    i__carry__0_i_19
       (.I0(AWSIZE_reg[0]),
        .I1(AWLEN_reg[3]),
        .I2(AWLEN_reg[2]),
        .I3(AWLEN_reg[0]),
        .I4(AWLEN_reg[1]),
        .O(i__carry__0_i_19_n_0));
  LUT6 #(
    .INIT(64'h5551555555405555)) 
    i__carry__0_i_2
       (.I0(i__carry__0_i_12_n_0),
        .I1(AWSIZE_reg[0]),
        .I2(i__carry__0_i_13_n_0),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .I5(i__carry__0_i_9_n_0),
        .O(i__carry__0_i_2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT4 #(
    .INIT(16'h1EE4)) 
    i__carry__0_i_20
       (.I0(AWSIZE_reg[0]),
        .I1(AWLEN_reg[2]),
        .I2(AWLEN_reg[1]),
        .I3(AWLEN_reg[0]),
        .O(i__carry__0_i_20_n_0));
  LUT6 #(
    .INIT(64'hAACCAACCFFFFF000)) 
    i__carry__0_i_3
       (.I0(i__carry__0_i_13_n_0),
        .I1(i__carry__0_i_14_n_0),
        .I2(i__carry__0_i_9_n_0),
        .I3(i__carry__0_i_15_n_0),
        .I4(i__carry__0_i_16_n_0),
        .I5(i__carry__0_i_17_n_0),
        .O(i__carry__0_i_3_n_0));
  LUT6 #(
    .INIT(64'h00000000FDFFF8FF)) 
    i__carry__0_i_4
       (.I0(AWSIZE_reg[0]),
        .I1(i__carry_i_11_n_0),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(i__carry__0_i_14_n_0),
        .I5(i__carry__0_i_18_n_0),
        .O(i__carry__0_i_4_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF02000700)) 
    i__carry__0_i_5
       (.I0(AWSIZE_reg[0]),
        .I1(i__carry__0_i_9_n_0),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(i__carry__0_i_10_n_0),
        .I5(i__carry__0_i_11_n_0),
        .O(i__carry__0_i_5_n_0));
  LUT6 #(
    .INIT(64'hAAAEAAAAAABFAAAA)) 
    i__carry__0_i_6
       (.I0(i__carry__0_i_12_n_0),
        .I1(AWSIZE_reg[0]),
        .I2(i__carry__0_i_13_n_0),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[1]),
        .I5(i__carry__0_i_9_n_0),
        .O(i__carry__0_i_6_n_0));
  LUT6 #(
    .INIT(64'h5533553300000FFF)) 
    i__carry__0_i_7
       (.I0(i__carry__0_i_13_n_0),
        .I1(i__carry__0_i_14_n_0),
        .I2(i__carry__0_i_9_n_0),
        .I3(i__carry__0_i_15_n_0),
        .I4(i__carry__0_i_16_n_0),
        .I5(i__carry__0_i_17_n_0),
        .O(i__carry__0_i_7_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF02000700)) 
    i__carry__0_i_8
       (.I0(AWSIZE_reg[0]),
        .I1(i__carry_i_11_n_0),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(i__carry__0_i_14_n_0),
        .I5(i__carry__0_i_18_n_0),
        .O(i__carry__0_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h6)) 
    i__carry__0_i_9
       (.I0(AWLEN_reg[6]),
        .I1(i__carry__1_i_9_n_0),
        .O(i__carry__0_i_9_n_0));
  LUT6 #(
    .INIT(64'h3C6A000080000000)) 
    i__carry__1_i_1
       (.I0(AWLEN_reg[7]),
        .I1(i__carry__1_i_9_n_0),
        .I2(AWLEN_reg[6]),
        .I3(AWSIZE_reg[0]),
        .I4(AWSIZE_reg[2]),
        .I5(AWSIZE_reg[1]),
        .O(i__carry__1_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT3 #(
    .INIT(8'h80)) 
    i__carry__1_i_10
       (.I0(AWLEN_reg[6]),
        .I1(i__carry__1_i_9_n_0),
        .I2(AWLEN_reg[7]),
        .O(i__carry__1_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT4 #(
    .INIT(16'hC297)) 
    i__carry__1_i_11
       (.I0(AWSIZE_reg[0]),
        .I1(i__carry__1_i_16_n_0),
        .I2(AWLEN_reg[5]),
        .I3(AWLEN_reg[6]),
        .O(i__carry__1_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT4 #(
    .INIT(16'hC297)) 
    i__carry__1_i_12
       (.I0(AWSIZE_reg[0]),
        .I1(i__carry__1_i_9_n_0),
        .I2(AWLEN_reg[6]),
        .I3(AWLEN_reg[7]),
        .O(i__carry__1_i_12_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    i__carry__1_i_13
       (.I0(i__carry__0_i_14_n_0),
        .I1(AWSIZE_reg[0]),
        .I2(i__carry__0_i_13_n_0),
        .O(i__carry__1_i_13_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF87FF7FFF)) 
    i__carry__1_i_14
       (.I0(i__carry__1_i_9_n_0),
        .I1(AWLEN_reg[6]),
        .I2(AWLEN_reg[7]),
        .I3(AWSIZE_reg[1]),
        .I4(AWSIZE_reg[0]),
        .I5(AWSIZE_reg[2]),
        .O(i__carry__1_i_14_n_0));
  LUT6 #(
    .INIT(64'h1EE4E4E4E4E4E4E4)) 
    i__carry__1_i_15
       (.I0(AWSIZE_reg[0]),
        .I1(AWLEN_reg[4]),
        .I2(AWLEN_reg[3]),
        .I3(AWLEN_reg[1]),
        .I4(AWLEN_reg[0]),
        .I5(AWLEN_reg[2]),
        .O(i__carry__1_i_15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    i__carry__1_i_16
       (.I0(AWLEN_reg[3]),
        .I1(AWLEN_reg[1]),
        .I2(AWLEN_reg[0]),
        .I3(AWLEN_reg[2]),
        .I4(AWLEN_reg[4]),
        .O(i__carry__1_i_16_n_0));
  LUT6 #(
    .INIT(64'h00FFB8B800000000)) 
    i__carry__1_i_2
       (.I0(i__carry__0_i_10_n_0),
        .I1(AWSIZE_reg[0]),
        .I2(i__carry__1_i_10_n_0),
        .I3(i__carry__1_i_11_n_0),
        .I4(AWSIZE_reg[1]),
        .I5(AWSIZE_reg[2]),
        .O(i__carry__1_i_2_n_0));
  LUT6 #(
    .INIT(64'hCF50C050C050C050)) 
    i__carry__1_i_3
       (.I0(i__carry__1_i_12_n_0),
        .I1(i__carry__1_i_13_n_0),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(i__carry__1_i_10_n_0),
        .I5(AWSIZE_reg[0]),
        .O(i__carry__1_i_3_n_0));
  LUT5 #(
    .INIT(32'hD5F55575)) 
    i__carry__1_i_4
       (.I0(i__carry__1_i_14_n_0),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(i__carry__1_i_11_n_0),
        .I4(i__carry__1_i_15_n_0),
        .O(i__carry__1_i_4_n_0));
  LUT6 #(
    .INIT(64'hBF7777F7F77F7FFF)) 
    i__carry__1_i_5
       (.I0(AWSIZE_reg[1]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[0]),
        .I3(AWLEN_reg[6]),
        .I4(i__carry__1_i_9_n_0),
        .I5(AWLEN_reg[7]),
        .O(i__carry__1_i_5_n_0));
  LUT6 #(
    .INIT(64'hFF004747FFFFFFFF)) 
    i__carry__1_i_6
       (.I0(i__carry__0_i_10_n_0),
        .I1(AWSIZE_reg[0]),
        .I2(i__carry__1_i_10_n_0),
        .I3(i__carry__1_i_11_n_0),
        .I4(AWSIZE_reg[1]),
        .I5(AWSIZE_reg[2]),
        .O(i__carry__1_i_6_n_0));
  LUT6 #(
    .INIT(64'h30AF3FAF3FAF3FAF)) 
    i__carry__1_i_7
       (.I0(i__carry__1_i_12_n_0),
        .I1(i__carry__1_i_13_n_0),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(i__carry__1_i_10_n_0),
        .I5(AWSIZE_reg[0]),
        .O(i__carry__1_i_7_n_0));
  LUT5 #(
    .INIT(32'h2A0AAA8A)) 
    i__carry__1_i_8
       (.I0(i__carry__1_i_14_n_0),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(i__carry__1_i_11_n_0),
        .I4(i__carry__1_i_15_n_0),
        .O(i__carry__1_i_8_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    i__carry__1_i_9
       (.I0(AWLEN_reg[4]),
        .I1(AWLEN_reg[2]),
        .I2(AWLEN_reg[0]),
        .I3(AWLEN_reg[1]),
        .I4(AWLEN_reg[3]),
        .I5(AWLEN_reg[5]),
        .O(i__carry__1_i_9_n_0));
  LUT4 #(
    .INIT(16'h8000)) 
    i__carry__2_i_1
       (.I0(i__carry__1_i_10_n_0),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[0]),
        .O(i__carry__2_i_1_n_0));
  LUT6 #(
    .INIT(64'h0888800080000000)) 
    i__carry__2_i_2
       (.I0(AWSIZE_reg[2]),
        .I1(AWSIZE_reg[1]),
        .I2(AWLEN_reg[6]),
        .I3(i__carry__1_i_9_n_0),
        .I4(AWLEN_reg[7]),
        .I5(AWSIZE_reg[0]),
        .O(i__carry__2_i_2_n_0));
  LUT4 #(
    .INIT(16'h7FFF)) 
    i__carry__2_i_3
       (.I0(AWSIZE_reg[0]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(i__carry__1_i_10_n_0),
        .O(i__carry__2_i_3_n_0));
  LUT6 #(
    .INIT(64'h9777FFFFFFFFFFFF)) 
    i__carry__2_i_4
       (.I0(AWSIZE_reg[0]),
        .I1(AWLEN_reg[7]),
        .I2(i__carry__1_i_9_n_0),
        .I3(AWLEN_reg[6]),
        .I4(AWSIZE_reg[1]),
        .I5(AWSIZE_reg[2]),
        .O(i__carry__2_i_4_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    i__carry_i_1
       (.I0(AWLEN_reg[0]),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .O(i__carry_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    i__carry_i_10
       (.I0(AWLEN_reg[2]),
        .I1(AWLEN_reg[1]),
        .I2(AWLEN_reg[0]),
        .O(i__carry_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    i__carry_i_11
       (.I0(AWLEN_reg[3]),
        .I1(AWLEN_reg[2]),
        .I2(AWLEN_reg[0]),
        .I3(AWLEN_reg[1]),
        .O(i__carry_i_11_n_0));
  LUT6 #(
    .INIT(64'h02020E0E020E0E02)) 
    i__carry_i_12
       (.I0(i__carry__0_i_14_n_0),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[1]),
        .I3(AWSIZE_reg[0]),
        .I4(AWLEN_reg[0]),
        .I5(AWLEN_reg[1]),
        .O(i__carry_i_12_n_0));
  LUT6 #(
    .INIT(64'hC3C3C395C395C395)) 
    i__carry_i_13
       (.I0(AWLEN_reg[2]),
        .I1(AWLEN_reg[1]),
        .I2(AWLEN_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWSIZE_reg[0]),
        .I5(AWSIZE_reg[1]),
        .O(i__carry_i_13_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF23002000)) 
    i__carry_i_2
       (.I0(i__carry_i_10_n_0),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[1]),
        .I4(i__carry_i_11_n_0),
        .I5(i__carry_i_12_n_0),
        .O(i__carry_i_2_n_0));
  LUT6 #(
    .INIT(64'h0704070407043734)) 
    i__carry_i_3
       (.I0(i__carry_i_13_n_0),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(i__carry_i_11_n_0),
        .I4(AWLEN_reg[0]),
        .I5(AWSIZE_reg[0]),
        .O(i__carry_i_3_n_0));
  LUT6 #(
    .INIT(64'h0055007B00660048)) 
    i__carry_i_4
       (.I0(AWLEN_reg[0]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[2]),
        .I4(AWLEN_reg[1]),
        .I5(AWLEN_reg[2]),
        .O(i__carry_i_4_n_0));
  LUT5 #(
    .INIT(32'h00070304)) 
    i__carry_i_5
       (.I0(AWSIZE_reg[0]),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(AWLEN_reg[0]),
        .I4(AWLEN_reg[1]),
        .O(i__carry_i_5_n_0));
  LUT6 #(
    .INIT(64'h00000000DCFFDFFF)) 
    i__carry_i_6
       (.I0(i__carry_i_10_n_0),
        .I1(AWSIZE_reg[2]),
        .I2(AWSIZE_reg[0]),
        .I3(AWSIZE_reg[1]),
        .I4(i__carry_i_11_n_0),
        .I5(i__carry_i_12_n_0),
        .O(i__carry_i_6_n_0));
  LUT6 #(
    .INIT(64'hF8FBF8FBF8FBC8CB)) 
    i__carry_i_7
       (.I0(i__carry_i_13_n_0),
        .I1(AWSIZE_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(i__carry_i_11_n_0),
        .I4(AWLEN_reg[0]),
        .I5(AWSIZE_reg[0]),
        .O(i__carry_i_7_n_0));
  LUT6 #(
    .INIT(64'hFFFCF9F9F0F3F5F5)) 
    i__carry_i_8
       (.I0(AWLEN_reg[2]),
        .I1(AWLEN_reg[1]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[0]),
        .I4(AWSIZE_reg[1]),
        .I5(AWLEN_reg[0]),
        .O(i__carry_i_8_n_0));
  LUT5 #(
    .INIT(32'hFFF9FCF9)) 
    i__carry_i_9
       (.I0(AWLEN_reg[1]),
        .I1(AWLEN_reg[0]),
        .I2(AWSIZE_reg[2]),
        .I3(AWSIZE_reg[1]),
        .I4(AWSIZE_reg[0]),
        .O(i__carry_i_9_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 p_1_out_carry
       (.CI(1'b0),
        .CO({p_1_out_carry_n_0,p_1_out_carry_n_1,p_1_out_carry_n_2,p_1_out_carry_n_3}),
        .CYINIT(p_1_out_carry_i_1_n_0),
        .DI(p_0_out[5:2]),
        .O({p_1_out_carry_n_4,p_1_out_carry_n_5,p_1_out_carry_n_6,p_1_out_carry_n_7}),
        .S({p_1_out_carry_i_6_n_0,p_1_out_carry_i_7_n_0,p_1_out_carry_i_8_n_0,p_1_out_carry_i_9_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 p_1_out_carry__0
       (.CI(p_1_out_carry_n_0),
        .CO({p_1_out_carry__0_n_0,p_1_out_carry__0_n_1,p_1_out_carry__0_n_2,p_1_out_carry__0_n_3}),
        .CYINIT(1'b0),
        .DI(p_0_out[9:6]),
        .O({p_1_out_carry__0_n_4,p_1_out_carry__0_n_5,p_1_out_carry__0_n_6,p_1_out_carry__0_n_7}),
        .S({p_1_out_carry__0_i_5_n_0,p_1_out_carry__0_i_6_n_0,p_1_out_carry__0_i_7_n_0,p_1_out_carry__0_i_8_n_0}));
  LUT6 #(
    .INIT(64'h00000000FDFFF8FF)) 
    p_1_out_carry__0_i_1
       (.I0(ARSIZE_reg[0]),
        .I1(p_1_out_carry__0_i_9_n_0),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__0_i_10_n_0),
        .I5(p_1_out_carry__0_i_11_n_0),
        .O(p_0_out[9]));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    p_1_out_carry__0_i_10
       (.I0(ARLEN_reg[7]),
        .I1(ARLEN_reg[6]),
        .I2(p_1_out_carry__1_i_9_n_0),
        .O(p_1_out_carry__0_i_10_n_0));
  LUT5 #(
    .INIT(32'h0C110CDD)) 
    p_1_out_carry__0_i_11
       (.I0(p_1_out_carry__1_i_14_n_0),
        .I1(ARSIZE_reg[2]),
        .I2(p_1_out_carry__0_i_20_n_0),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__1_i_13_n_0),
        .O(p_1_out_carry__0_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'h15)) 
    p_1_out_carry__0_i_12
       (.I0(ARSIZE_reg[2]),
        .I1(ARSIZE_reg[0]),
        .I2(ARSIZE_reg[1]),
        .O(p_1_out_carry__0_i_12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h80000000)) 
    p_1_out_carry__0_i_13
       (.I0(ARLEN_reg[3]),
        .I1(ARLEN_reg[1]),
        .I2(ARLEN_reg[0]),
        .I3(ARLEN_reg[2]),
        .I4(ARLEN_reg[4]),
        .O(p_1_out_carry__0_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT2 #(
    .INIT(4'h2)) 
    p_1_out_carry__0_i_14
       (.I0(ARSIZE_reg[1]),
        .I1(ARSIZE_reg[2]),
        .O(p_1_out_carry__0_i_14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT5 #(
    .INIT(32'hE233E200)) 
    p_1_out_carry__0_i_15
       (.I0(p_1_out_carry__1_i_16_n_0),
        .I1(ARSIZE_reg[1]),
        .I2(p_1_out_carry__0_i_21_n_0),
        .I3(ARSIZE_reg[2]),
        .I4(p_1_out_carry__0_i_10_n_0),
        .O(p_1_out_carry__0_i_15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT5 #(
    .INIT(32'h6AAAAAAA)) 
    p_1_out_carry__0_i_16
       (.I0(ARLEN_reg[4]),
        .I1(ARLEN_reg[3]),
        .I2(ARLEN_reg[1]),
        .I3(ARLEN_reg[0]),
        .I4(ARLEN_reg[2]),
        .O(p_1_out_carry__0_i_16_n_0));
  LUT6 #(
    .INIT(64'h6AAAAAAAAAAAAAAA)) 
    p_1_out_carry__0_i_17
       (.I0(ARLEN_reg[5]),
        .I1(ARLEN_reg[4]),
        .I2(ARLEN_reg[2]),
        .I3(ARLEN_reg[0]),
        .I4(ARLEN_reg[1]),
        .I5(ARLEN_reg[3]),
        .O(p_1_out_carry__0_i_17_n_0));
  LUT6 #(
    .INIT(64'h22EE2EE200CC0000)) 
    p_1_out_carry__0_i_18
       (.I0(p_1_out_carry__0_i_20_n_0),
        .I1(ARSIZE_reg[1]),
        .I2(ARLEN_reg[1]),
        .I3(ARLEN_reg[0]),
        .I4(ARSIZE_reg[0]),
        .I5(ARSIZE_reg[2]),
        .O(p_1_out_carry__0_i_18_n_0));
  LUT6 #(
    .INIT(64'h00000F003C006A00)) 
    p_1_out_carry__0_i_19
       (.I0(ARLEN_reg[2]),
        .I1(ARLEN_reg[1]),
        .I2(ARLEN_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[0]),
        .I5(ARSIZE_reg[1]),
        .O(p_1_out_carry__0_i_19_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF4BB80000)) 
    p_1_out_carry__0_i_2
       (.I0(ARLEN_reg[6]),
        .I1(p_1_out_carry__0_i_12_n_0),
        .I2(ARLEN_reg[5]),
        .I3(p_1_out_carry__0_i_13_n_0),
        .I4(p_1_out_carry__0_i_14_n_0),
        .I5(p_1_out_carry__0_i_15_n_0),
        .O(p_0_out[8]));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT5 #(
    .INIT(32'h1EE4E4E4)) 
    p_1_out_carry__0_i_20
       (.I0(ARSIZE_reg[0]),
        .I1(ARLEN_reg[3]),
        .I2(ARLEN_reg[2]),
        .I3(ARLEN_reg[0]),
        .I4(ARLEN_reg[1]),
        .O(p_1_out_carry__0_i_20_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT4 #(
    .INIT(16'h1EE4)) 
    p_1_out_carry__0_i_21
       (.I0(ARSIZE_reg[0]),
        .I1(ARLEN_reg[2]),
        .I2(ARLEN_reg[1]),
        .I3(ARLEN_reg[0]),
        .O(p_1_out_carry__0_i_21_n_0));
  LUT6 #(
    .INIT(64'hCCAACCAAFFFFF000)) 
    p_1_out_carry__0_i_3
       (.I0(p_1_out_carry__0_i_16_n_0),
        .I1(p_1_out_carry__0_i_17_n_0),
        .I2(p_1_out_carry__0_i_9_n_0),
        .I3(p_1_out_carry__0_i_12_n_0),
        .I4(p_1_out_carry__0_i_18_n_0),
        .I5(p_1_out_carry__0_i_14_n_0),
        .O(p_0_out[7]));
  LUT6 #(
    .INIT(64'hAFCFAFCFAFC0A0C0)) 
    p_1_out_carry__0_i_4
       (.I0(p_1_out_carry__0_i_16_n_0),
        .I1(p_1_out_carry_i_11_n_0),
        .I2(p_1_out_carry__0_i_14_n_0),
        .I3(p_1_out_carry__0_i_12_n_0),
        .I4(p_1_out_carry__0_i_17_n_0),
        .I5(p_1_out_carry__0_i_19_n_0),
        .O(p_0_out[6]));
  LUT6 #(
    .INIT(64'hFFFFFFFF02000700)) 
    p_1_out_carry__0_i_5
       (.I0(ARSIZE_reg[0]),
        .I1(p_1_out_carry__0_i_9_n_0),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__0_i_10_n_0),
        .I5(p_1_out_carry__0_i_11_n_0),
        .O(p_1_out_carry__0_i_5_n_0));
  LUT6 #(
    .INIT(64'h00000000B447FFFF)) 
    p_1_out_carry__0_i_6
       (.I0(ARLEN_reg[6]),
        .I1(p_1_out_carry__0_i_12_n_0),
        .I2(ARLEN_reg[5]),
        .I3(p_1_out_carry__0_i_13_n_0),
        .I4(p_1_out_carry__0_i_14_n_0),
        .I5(p_1_out_carry__0_i_15_n_0),
        .O(p_1_out_carry__0_i_6_n_0));
  LUT6 #(
    .INIT(64'h3355335500000FFF)) 
    p_1_out_carry__0_i_7
       (.I0(p_1_out_carry__0_i_16_n_0),
        .I1(p_1_out_carry__0_i_17_n_0),
        .I2(p_1_out_carry__0_i_9_n_0),
        .I3(p_1_out_carry__0_i_12_n_0),
        .I4(p_1_out_carry__0_i_18_n_0),
        .I5(p_1_out_carry__0_i_14_n_0),
        .O(p_1_out_carry__0_i_7_n_0));
  LUT6 #(
    .INIT(64'h50305030503F5F3F)) 
    p_1_out_carry__0_i_8
       (.I0(p_1_out_carry__0_i_16_n_0),
        .I1(p_1_out_carry_i_11_n_0),
        .I2(p_1_out_carry__0_i_14_n_0),
        .I3(p_1_out_carry__0_i_12_n_0),
        .I4(p_1_out_carry__0_i_17_n_0),
        .I5(p_1_out_carry__0_i_19_n_0),
        .O(p_1_out_carry__0_i_8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h6)) 
    p_1_out_carry__0_i_9
       (.I0(ARLEN_reg[6]),
        .I1(p_1_out_carry__1_i_9_n_0),
        .O(p_1_out_carry__0_i_9_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 p_1_out_carry__1
       (.CI(p_1_out_carry__0_n_0),
        .CO({p_1_out_carry__1_n_0,p_1_out_carry__1_n_1,p_1_out_carry__1_n_2,p_1_out_carry__1_n_3}),
        .CYINIT(1'b0),
        .DI(p_0_out[13:10]),
        .O({p_1_out_carry__1_n_4,p_1_out_carry__1_n_5,p_1_out_carry__1_n_6,p_1_out_carry__1_n_7}),
        .S({p_1_out_carry__1_i_5_n_0,p_1_out_carry__1_i_6_n_0,p_1_out_carry__1_i_7_n_0,p_1_out_carry__1_i_8_n_0}));
  LUT6 #(
    .INIT(64'h3C6A000080000000)) 
    p_1_out_carry__1_i_1
       (.I0(ARLEN_reg[7]),
        .I1(p_1_out_carry__1_i_9_n_0),
        .I2(ARLEN_reg[6]),
        .I3(ARSIZE_reg[0]),
        .I4(ARSIZE_reg[2]),
        .I5(ARSIZE_reg[1]),
        .O(p_0_out[13]));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'h9777)) 
    p_1_out_carry__1_i_10
       (.I0(ARSIZE_reg[0]),
        .I1(ARLEN_reg[7]),
        .I2(p_1_out_carry__1_i_9_n_0),
        .I3(ARLEN_reg[6]),
        .O(p_1_out_carry__1_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT4 #(
    .INIT(16'hC297)) 
    p_1_out_carry__1_i_11
       (.I0(ARSIZE_reg[0]),
        .I1(p_1_out_carry__0_i_13_n_0),
        .I2(ARLEN_reg[5]),
        .I3(ARLEN_reg[6]),
        .O(p_1_out_carry__1_i_11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT4 #(
    .INIT(16'hC297)) 
    p_1_out_carry__1_i_12
       (.I0(ARSIZE_reg[0]),
        .I1(p_1_out_carry__1_i_9_n_0),
        .I2(ARLEN_reg[6]),
        .I3(ARLEN_reg[7]),
        .O(p_1_out_carry__1_i_12_n_0));
  LUT3 #(
    .INIT(8'hB8)) 
    p_1_out_carry__1_i_13
       (.I0(p_1_out_carry__0_i_16_n_0),
        .I1(ARSIZE_reg[0]),
        .I2(p_1_out_carry__0_i_17_n_0),
        .O(p_1_out_carry__1_i_13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair71" *) 
  LUT3 #(
    .INIT(8'h80)) 
    p_1_out_carry__1_i_14
       (.I0(ARLEN_reg[6]),
        .I1(p_1_out_carry__1_i_9_n_0),
        .I2(ARLEN_reg[7]),
        .O(p_1_out_carry__1_i_14_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF87FF7FFF)) 
    p_1_out_carry__1_i_15
       (.I0(p_1_out_carry__1_i_9_n_0),
        .I1(ARLEN_reg[6]),
        .I2(ARLEN_reg[7]),
        .I3(ARSIZE_reg[1]),
        .I4(ARSIZE_reg[0]),
        .I5(ARSIZE_reg[2]),
        .O(p_1_out_carry__1_i_15_n_0));
  LUT6 #(
    .INIT(64'h1EE4E4E4E4E4E4E4)) 
    p_1_out_carry__1_i_16
       (.I0(ARSIZE_reg[0]),
        .I1(ARLEN_reg[4]),
        .I2(ARLEN_reg[3]),
        .I3(ARLEN_reg[1]),
        .I4(ARLEN_reg[0]),
        .I5(ARLEN_reg[2]),
        .O(p_1_out_carry__1_i_16_n_0));
  LUT4 #(
    .INIT(16'h3500)) 
    p_1_out_carry__1_i_2
       (.I0(p_1_out_carry__1_i_10_n_0),
        .I1(p_1_out_carry__1_i_11_n_0),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[2]),
        .O(p_0_out[12]));
  LUT6 #(
    .INIT(64'hCF50C050C050C050)) 
    p_1_out_carry__1_i_3
       (.I0(p_1_out_carry__1_i_12_n_0),
        .I1(p_1_out_carry__1_i_13_n_0),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__1_i_14_n_0),
        .I5(ARSIZE_reg[0]),
        .O(p_0_out[11]));
  LUT5 #(
    .INIT(32'hD5F55575)) 
    p_1_out_carry__1_i_4
       (.I0(p_1_out_carry__1_i_15_n_0),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(p_1_out_carry__1_i_11_n_0),
        .I4(p_1_out_carry__1_i_16_n_0),
        .O(p_0_out[10]));
  LUT6 #(
    .INIT(64'hBF7777F7F77F7FFF)) 
    p_1_out_carry__1_i_5
       (.I0(ARSIZE_reg[1]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[0]),
        .I3(ARLEN_reg[6]),
        .I4(p_1_out_carry__1_i_9_n_0),
        .I5(ARLEN_reg[7]),
        .O(p_1_out_carry__1_i_5_n_0));
  LUT4 #(
    .INIT(16'hCAFF)) 
    p_1_out_carry__1_i_6
       (.I0(p_1_out_carry__1_i_10_n_0),
        .I1(p_1_out_carry__1_i_11_n_0),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[2]),
        .O(p_1_out_carry__1_i_6_n_0));
  LUT6 #(
    .INIT(64'h30AF3FAF3FAF3FAF)) 
    p_1_out_carry__1_i_7
       (.I0(p_1_out_carry__1_i_12_n_0),
        .I1(p_1_out_carry__1_i_13_n_0),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry__1_i_14_n_0),
        .I5(ARSIZE_reg[0]),
        .O(p_1_out_carry__1_i_7_n_0));
  LUT5 #(
    .INIT(32'h2A0AAA8A)) 
    p_1_out_carry__1_i_8
       (.I0(p_1_out_carry__1_i_15_n_0),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(p_1_out_carry__1_i_11_n_0),
        .I4(p_1_out_carry__1_i_16_n_0),
        .O(p_1_out_carry__1_i_8_n_0));
  LUT6 #(
    .INIT(64'h8000000000000000)) 
    p_1_out_carry__1_i_9
       (.I0(ARLEN_reg[4]),
        .I1(ARLEN_reg[2]),
        .I2(ARLEN_reg[0]),
        .I3(ARLEN_reg[1]),
        .I4(ARLEN_reg[3]),
        .I5(ARLEN_reg[5]),
        .O(p_1_out_carry__1_i_9_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 p_1_out_carry__2
       (.CI(p_1_out_carry__1_n_0),
        .CO({NLW_p_1_out_carry__2_CO_UNCONNECTED[3],p_1_out_carry__2_n_1,NLW_p_1_out_carry__2_CO_UNCONNECTED[1],p_1_out_carry__2_n_3}),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,p_1_out_carry__2_i_1_n_0,p_0_out[14]}),
        .O({NLW_p_1_out_carry__2_O_UNCONNECTED[3:2],p_1_out_carry__2_n_6,p_1_out_carry__2_n_7}),
        .S({1'b0,1'b1,p_1_out_carry__2_i_3_n_0,p_1_out_carry__2_i_4_n_0}));
  LUT4 #(
    .INIT(16'h8000)) 
    p_1_out_carry__2_i_1
       (.I0(p_1_out_carry__1_i_14_n_0),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[0]),
        .O(p_1_out_carry__2_i_1_n_0));
  LUT6 #(
    .INIT(64'h0888800080000000)) 
    p_1_out_carry__2_i_2
       (.I0(ARSIZE_reg[2]),
        .I1(ARSIZE_reg[1]),
        .I2(ARLEN_reg[6]),
        .I3(p_1_out_carry__1_i_9_n_0),
        .I4(ARLEN_reg[7]),
        .I5(ARSIZE_reg[0]),
        .O(p_0_out[14]));
  LUT4 #(
    .INIT(16'h7FFF)) 
    p_1_out_carry__2_i_3
       (.I0(ARSIZE_reg[0]),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(p_1_out_carry__1_i_14_n_0),
        .O(p_1_out_carry__2_i_3_n_0));
  LUT6 #(
    .INIT(64'h9777FFFFFFFFFFFF)) 
    p_1_out_carry__2_i_4
       (.I0(ARSIZE_reg[0]),
        .I1(ARLEN_reg[7]),
        .I2(p_1_out_carry__1_i_9_n_0),
        .I3(ARLEN_reg[6]),
        .I4(ARSIZE_reg[1]),
        .I5(ARSIZE_reg[2]),
        .O(p_1_out_carry__2_i_4_n_0));
  LUT3 #(
    .INIT(8'h01)) 
    p_1_out_carry_i_1
       (.I0(ARLEN_reg[0]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .O(p_1_out_carry_i_1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT3 #(
    .INIT(8'h6A)) 
    p_1_out_carry_i_10
       (.I0(ARLEN_reg[2]),
        .I1(ARLEN_reg[1]),
        .I2(ARLEN_reg[0]),
        .O(p_1_out_carry_i_10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT4 #(
    .INIT(16'h6AAA)) 
    p_1_out_carry_i_11
       (.I0(ARLEN_reg[3]),
        .I1(ARLEN_reg[2]),
        .I2(ARLEN_reg[0]),
        .I3(ARLEN_reg[1]),
        .O(p_1_out_carry_i_11_n_0));
  LUT6 #(
    .INIT(64'h02020E0E020E0E02)) 
    p_1_out_carry_i_12
       (.I0(p_1_out_carry__0_i_16_n_0),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[0]),
        .I4(ARLEN_reg[0]),
        .I5(ARLEN_reg[1]),
        .O(p_1_out_carry_i_12_n_0));
  LUT6 #(
    .INIT(64'hC3C3C395C395C395)) 
    p_1_out_carry_i_13
       (.I0(ARLEN_reg[2]),
        .I1(ARLEN_reg[1]),
        .I2(ARLEN_reg[0]),
        .I3(ARSIZE_reg[2]),
        .I4(ARSIZE_reg[0]),
        .I5(ARSIZE_reg[1]),
        .O(p_1_out_carry_i_13_n_0));
  LUT6 #(
    .INIT(64'hFFFFFFFF23002000)) 
    p_1_out_carry_i_2
       (.I0(p_1_out_carry_i_10_n_0),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry_i_11_n_0),
        .I5(p_1_out_carry_i_12_n_0),
        .O(p_0_out[5]));
  LUT6 #(
    .INIT(64'h0704070407043734)) 
    p_1_out_carry_i_3
       (.I0(p_1_out_carry_i_13_n_0),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(p_1_out_carry_i_11_n_0),
        .I4(ARLEN_reg[0]),
        .I5(ARSIZE_reg[0]),
        .O(p_0_out[4]));
  LUT6 #(
    .INIT(64'h0000367700003688)) 
    p_1_out_carry_i_4
       (.I0(ARLEN_reg[1]),
        .I1(ARLEN_reg[0]),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[1]),
        .I4(ARSIZE_reg[2]),
        .I5(ARLEN_reg[2]),
        .O(p_0_out[3]));
  LUT5 #(
    .INIT(32'h00070304)) 
    p_1_out_carry_i_5
       (.I0(ARSIZE_reg[0]),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(ARLEN_reg[0]),
        .I4(ARLEN_reg[1]),
        .O(p_0_out[2]));
  LUT6 #(
    .INIT(64'h00000000DCFFDFFF)) 
    p_1_out_carry_i_6
       (.I0(p_1_out_carry_i_10_n_0),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[0]),
        .I3(ARSIZE_reg[1]),
        .I4(p_1_out_carry_i_11_n_0),
        .I5(p_1_out_carry_i_12_n_0),
        .O(p_1_out_carry_i_6_n_0));
  LUT6 #(
    .INIT(64'hF8FBF8FBF8FBC8CB)) 
    p_1_out_carry_i_7
       (.I0(p_1_out_carry_i_13_n_0),
        .I1(ARSIZE_reg[1]),
        .I2(ARSIZE_reg[2]),
        .I3(p_1_out_carry_i_11_n_0),
        .I4(ARLEN_reg[0]),
        .I5(ARSIZE_reg[0]),
        .O(p_1_out_carry_i_7_n_0));
  LUT6 #(
    .INIT(64'hFEFECDCDFDCDCDFD)) 
    p_1_out_carry_i_8
       (.I0(ARLEN_reg[2]),
        .I1(ARSIZE_reg[2]),
        .I2(ARSIZE_reg[1]),
        .I3(ARSIZE_reg[0]),
        .I4(ARLEN_reg[0]),
        .I5(ARLEN_reg[1]),
        .O(p_1_out_carry_i_8_n_0));
  LUT5 #(
    .INIT(32'hFFF9FCF9)) 
    p_1_out_carry_i_9
       (.I0(ARLEN_reg[1]),
        .I1(ARLEN_reg[0]),
        .I2(ARSIZE_reg[2]),
        .I3(ARSIZE_reg[1]),
        .I4(ARSIZE_reg[0]),
        .O(p_1_out_carry_i_9_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \p_1_out_inferred__0/i__carry 
       (.CI(1'b0),
        .CO({\p_1_out_inferred__0/i__carry_n_0 ,\p_1_out_inferred__0/i__carry_n_1 ,\p_1_out_inferred__0/i__carry_n_2 ,\p_1_out_inferred__0/i__carry_n_3 }),
        .CYINIT(i__carry_i_1_n_0),
        .DI({i__carry_i_2_n_0,i__carry_i_3_n_0,i__carry_i_4_n_0,i__carry_i_5_n_0}),
        .O({\p_1_out_inferred__0/i__carry_n_4 ,\p_1_out_inferred__0/i__carry_n_5 ,\p_1_out_inferred__0/i__carry_n_6 ,\p_1_out_inferred__0/i__carry_n_7 }),
        .S({i__carry_i_6_n_0,i__carry_i_7_n_0,i__carry_i_8_n_0,i__carry_i_9_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \p_1_out_inferred__0/i__carry__0 
       (.CI(\p_1_out_inferred__0/i__carry_n_0 ),
        .CO({\p_1_out_inferred__0/i__carry__0_n_0 ,\p_1_out_inferred__0/i__carry__0_n_1 ,\p_1_out_inferred__0/i__carry__0_n_2 ,\p_1_out_inferred__0/i__carry__0_n_3 }),
        .CYINIT(1'b0),
        .DI({i__carry__0_i_1_n_0,i__carry__0_i_2_n_0,i__carry__0_i_3_n_0,i__carry__0_i_4_n_0}),
        .O({\p_1_out_inferred__0/i__carry__0_n_4 ,\p_1_out_inferred__0/i__carry__0_n_5 ,\p_1_out_inferred__0/i__carry__0_n_6 ,\p_1_out_inferred__0/i__carry__0_n_7 }),
        .S({i__carry__0_i_5_n_0,i__carry__0_i_6_n_0,i__carry__0_i_7_n_0,i__carry__0_i_8_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \p_1_out_inferred__0/i__carry__1 
       (.CI(\p_1_out_inferred__0/i__carry__0_n_0 ),
        .CO({\p_1_out_inferred__0/i__carry__1_n_0 ,\p_1_out_inferred__0/i__carry__1_n_1 ,\p_1_out_inferred__0/i__carry__1_n_2 ,\p_1_out_inferred__0/i__carry__1_n_3 }),
        .CYINIT(1'b0),
        .DI({i__carry__1_i_1_n_0,i__carry__1_i_2_n_0,i__carry__1_i_3_n_0,i__carry__1_i_4_n_0}),
        .O({\p_1_out_inferred__0/i__carry__1_n_4 ,\p_1_out_inferred__0/i__carry__1_n_5 ,\p_1_out_inferred__0/i__carry__1_n_6 ,\p_1_out_inferred__0/i__carry__1_n_7 }),
        .S({i__carry__1_i_5_n_0,i__carry__1_i_6_n_0,i__carry__1_i_7_n_0,i__carry__1_i_8_n_0}));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-8 {cell *THIS*}}" *) 
  CARRY4 \p_1_out_inferred__0/i__carry__2 
       (.CI(\p_1_out_inferred__0/i__carry__1_n_0 ),
        .CO({\NLW_p_1_out_inferred__0/i__carry__2_CO_UNCONNECTED [3],\p_1_out_inferred__0/i__carry__2_n_1 ,\NLW_p_1_out_inferred__0/i__carry__2_CO_UNCONNECTED [1],\p_1_out_inferred__0/i__carry__2_n_3 }),
        .CYINIT(1'b0),
        .DI({1'b0,1'b0,i__carry__2_i_1_n_0,i__carry__2_i_2_n_0}),
        .O({\NLW_p_1_out_inferred__0/i__carry__2_O_UNCONNECTED [3:2],\p_1_out_inferred__0/i__carry__2_n_6 ,\p_1_out_inferred__0/i__carry__2_n_7 }),
        .S({1'b0,1'b1,i__carry__2_i_3_n_0,i__carry__2_i_4_n_0}));
  LUT3 #(
    .INIT(8'hB8)) 
    \stateR[0]_i_1 
       (.I0(\stateR[0]_i_2_n_0 ),
        .I1(stateR),
        .I2(\stateR_reg_n_0_[0] ),
        .O(\stateR[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h3044337700440044)) 
    \stateR[0]_i_2 
       (.I0(\tickR[3]_i_3_n_0 ),
        .I1(\stateR_reg_n_0_[1] ),
        .I2(ARSTRB_reg1),
        .I3(\stateR_reg_n_0_[2] ),
        .I4(\stateR_reg_n_0_[0] ),
        .I5(\Traddr[31]_i_2_n_0 ),
        .O(\stateR[0]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFF3F333FFC2E302E)) 
    \stateR[0]_i_3 
       (.I0(ARREADY_i_2_n_0),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(ACK_reg_n_0),
        .I3(\stateR_reg_n_0_[1] ),
        .I4(s_axi_rready),
        .I5(\stateR_reg_n_0_[0] ),
        .O(stateR));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h07A7B2B2)) 
    \stateR[1]_i_1 
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(ACK_reg_n_0),
        .I2(\stateR_reg_n_0_[1] ),
        .I3(s_axi_rready),
        .I4(\stateR_reg_n_0_[0] ),
        .O(\stateR[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT5 #(
    .INIT(32'h5AFA48E8)) 
    \stateR[2]_i_1 
       (.I0(\stateR_reg_n_0_[2] ),
        .I1(ACK_reg_n_0),
        .I2(\stateR_reg_n_0_[1] ),
        .I3(s_axi_rready),
        .I4(\stateR_reg_n_0_[0] ),
        .O(\stateR[2]_i_1_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \stateR_reg[0] 
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(\stateR[0]_i_1_n_0 ),
        .Q(\stateR_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \stateR_reg[1] 
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(\stateR[1]_i_1_n_0 ),
        .Q(\stateR_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \stateR_reg[2] 
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(\stateR[2]_i_1_n_0 ),
        .Q(\stateR_reg_n_0_[2] ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \stateW[0]_i_1 
       (.I0(\stateW[0]_i_2_n_0 ),
        .I1(stateW),
        .I2(\stateW_reg_n_0_[0] ),
        .O(\stateW[0]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h830383C38F338FF3)) 
    \stateW[0]_i_2 
       (.I0(ACK_reg_n_0),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(\stateW_reg_n_0_[2] ),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(\stateW[2]_i_2_n_0 ),
        .I5(\stateW[0]_i_3_n_0 ),
        .O(\stateW[0]_i_2_n_0 ));
  LUT5 #(
    .INIT(32'h55555554)) 
    \stateW[0]_i_3 
       (.I0(BID0_carry_n_0),
        .I1(\tickW_reg_n_0_[3] ),
        .I2(\tickW_reg_n_0_[2] ),
        .I3(\tickW_reg_n_0_[0] ),
        .I4(\tickW_reg_n_0_[1] ),
        .O(\stateW[0]_i_3_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair73" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \stateW[1]_i_1 
       (.I0(\stateW[1]_i_2_n_0 ),
        .I1(stateW),
        .I2(\stateW_reg_n_0_[1] ),
        .O(\stateW[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'hF35FFF30035FFF30)) 
    \stateW[1]_i_2 
       (.I0(\stateW[2]_i_2_n_0 ),
        .I1(\BID[3]_i_2_n_0 ),
        .I2(\stateW_reg_n_0_[2] ),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(\stateW_reg_n_0_[0] ),
        .I5(ACK_reg_n_0),
        .O(\stateW[1]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hC0AFFFFFF0000000)) 
    \stateW[2]_i_1 
       (.I0(\stateW[2]_i_2_n_0 ),
        .I1(ACK_reg_n_0),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(\stateW_reg_n_0_[1] ),
        .I4(stateW),
        .I5(\stateW_reg_n_0_[2] ),
        .O(\stateW[2]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \stateW[2]_i_2 
       (.I0(\WSTRB_reg_reg_n_0_[3] ),
        .I1(\WSTRB_reg_reg_n_0_[0] ),
        .I2(\WSTRB_reg_reg_n_0_[2] ),
        .I3(\WSTRB_reg_reg_n_0_[1] ),
        .O(\stateW[2]_i_2_n_0 ));
  LUT6 #(
    .INIT(64'hFFFFFFFFEEFEEEEE)) 
    \stateW[2]_i_3 
       (.I0(\stateW[2]_i_4_n_0 ),
        .I1(WSTRB_reg),
        .I2(\stateW_reg_n_0_[1] ),
        .I3(\stateW_reg_n_0_[2] ),
        .I4(\stateW[2]_i_5_n_0 ),
        .I5(\stateW[2]_i_6_n_0 ),
        .O(stateW));
  LUT6 #(
    .INIT(64'h008F00000FFF0000)) 
    \stateW[2]_i_4 
       (.I0(s_axi_bvalid),
        .I1(s_axi_bready),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(ACK_reg_n_0),
        .I4(\stateW_reg_n_0_[2] ),
        .I5(\stateW_reg_n_0_[1] ),
        .O(\stateW[2]_i_4_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h8)) 
    \stateW[2]_i_5 
       (.I0(ACK_reg_n_0),
        .I1(\stateW_reg_n_0_[0] ),
        .O(\stateW[2]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT5 #(
    .INIT(32'h00000F02)) 
    \stateW[2]_i_6 
       (.I0(s_axi_awvalid),
        .I1(p_0_in[0]),
        .I2(\stateW_reg_n_0_[2] ),
        .I3(\stateW_reg_n_0_[0] ),
        .I4(\stateW_reg_n_0_[1] ),
        .O(\stateW[2]_i_6_n_0 ));
  FDCE #(
    .INIT(1'b0)) 
    \stateW_reg[0] 
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(\stateW[0]_i_1_n_0 ),
        .Q(\stateW_reg_n_0_[0] ));
  FDCE #(
    .INIT(1'b0)) 
    \stateW_reg[1] 
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(\stateW[1]_i_1_n_0 ),
        .Q(\stateW_reg_n_0_[1] ));
  FDCE #(
    .INIT(1'b0)) 
    \stateW_reg[2] 
       (.C(axi_aclk),
        .CE(1'b1),
        .CLR(AWREADY_i_2_n_0),
        .D(\stateW[2]_i_1_n_0 ),
        .Q(\stateW_reg_n_0_[2] ));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT3 #(
    .INIT(8'hC7)) 
    \tickR[0]_i_1 
       (.I0(\tickR_reg_n_0_[0] ),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\stateR_reg_n_0_[1] ),
        .O(\tickR[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT4 #(
    .INIT(16'h0600)) 
    \tickR[1]_i_1 
       (.I0(\tickR_reg_n_0_[0] ),
        .I1(\tickR_reg_n_0_[1] ),
        .I2(\stateR_reg_n_0_[1] ),
        .I3(\stateR_reg_n_0_[2] ),
        .O(\tickR[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT5 #(
    .INIT(32'h04404040)) 
    \tickR[2]_i_1 
       (.I0(\stateR_reg_n_0_[1] ),
        .I1(\stateR_reg_n_0_[2] ),
        .I2(\tickR_reg_n_0_[2] ),
        .I3(\tickR_reg_n_0_[0] ),
        .I4(\tickR_reg_n_0_[1] ),
        .O(\tickR[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h00005F5FC0CF5000)) 
    \tickR[3]_i_1 
       (.I0(\tickR[3]_i_3_n_0 ),
        .I1(s_axi_rready),
        .I2(\stateR_reg_n_0_[1] ),
        .I3(ACK_reg_n_0),
        .I4(\stateR_reg_n_0_[2] ),
        .I5(\stateR_reg_n_0_[0] ),
        .O(tickR));
  LUT6 #(
    .INIT(64'h1444444400000000)) 
    \tickR[3]_i_2 
       (.I0(\stateR_reg_n_0_[1] ),
        .I1(\tickR_reg_n_0_[3] ),
        .I2(\tickR_reg_n_0_[2] ),
        .I3(\tickR_reg_n_0_[0] ),
        .I4(\tickR_reg_n_0_[1] ),
        .I5(\stateR_reg_n_0_[2] ),
        .O(\tickR[3]_i_2_n_0 ));
  LUT4 #(
    .INIT(16'h0001)) 
    \tickR[3]_i_3 
       (.I0(\tickR_reg_n_0_[1] ),
        .I1(\tickR_reg_n_0_[0] ),
        .I2(\tickR_reg_n_0_[2] ),
        .I3(\tickR_reg_n_0_[3] ),
        .O(\tickR[3]_i_3_n_0 ));
  FDCE \tickR_reg[0] 
       (.C(axi_aclk),
        .CE(tickR),
        .CLR(AWREADY_i_2_n_0),
        .D(\tickR[0]_i_1_n_0 ),
        .Q(\tickR_reg_n_0_[0] ));
  FDCE \tickR_reg[1] 
       (.C(axi_aclk),
        .CE(tickR),
        .CLR(AWREADY_i_2_n_0),
        .D(\tickR[1]_i_1_n_0 ),
        .Q(\tickR_reg_n_0_[1] ));
  FDCE \tickR_reg[2] 
       (.C(axi_aclk),
        .CE(tickR),
        .CLR(AWREADY_i_2_n_0),
        .D(\tickR[2]_i_1_n_0 ),
        .Q(\tickR_reg_n_0_[2] ));
  FDCE \tickR_reg[3] 
       (.C(axi_aclk),
        .CE(tickR),
        .CLR(AWREADY_i_2_n_0),
        .D(\tickR[3]_i_2_n_0 ),
        .Q(\tickR_reg_n_0_[3] ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT4 #(
    .INIT(16'h5140)) 
    \tickW[0]_i_1 
       (.I0(\tickW_reg_n_0_[0] ),
        .I1(\stateW_reg_n_0_[0] ),
        .I2(\stateW_reg_n_0_[2] ),
        .I3(\stateW_reg_n_0_[1] ),
        .O(\tickW[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT5 #(
    .INIT(32'h66066000)) 
    \tickW[1]_i_1 
       (.I0(\tickW_reg_n_0_[1] ),
        .I1(\tickW_reg_n_0_[0] ),
        .I2(\stateW_reg_n_0_[0] ),
        .I3(\stateW_reg_n_0_[2] ),
        .I4(\stateW_reg_n_0_[1] ),
        .O(\tickW[1]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h7878007878000000)) 
    \tickW[2]_i_1 
       (.I0(\tickW_reg_n_0_[0] ),
        .I1(\tickW_reg_n_0_[1] ),
        .I2(\tickW_reg_n_0_[2] ),
        .I3(\stateW_reg_n_0_[0] ),
        .I4(\stateW_reg_n_0_[2] ),
        .I5(\stateW_reg_n_0_[1] ),
        .O(\tickW[2]_i_1_n_0 ));
  LUT6 #(
    .INIT(64'h000030AA0F33FF00)) 
    \tickW[3]_i_1 
       (.I0(s_axi_wvalid),
        .I1(\BID[3]_i_2_n_0 ),
        .I2(ACK_reg_n_0),
        .I3(\stateW_reg_n_0_[0] ),
        .I4(\stateW_reg_n_0_[2] ),
        .I5(\stateW_reg_n_0_[1] ),
        .O(tickW));
  LUT5 #(
    .INIT(32'h00007F80)) 
    \tickW[3]_i_2 
       (.I0(\tickW_reg_n_0_[2] ),
        .I1(\tickW_reg_n_0_[1] ),
        .I2(\tickW_reg_n_0_[0] ),
        .I3(\tickW_reg_n_0_[3] ),
        .I4(\tickW[3]_i_3_n_0 ),
        .O(\tickW[3]_i_2_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'h35)) 
    \tickW[3]_i_3 
       (.I0(\stateW_reg_n_0_[1] ),
        .I1(\stateW_reg_n_0_[2] ),
        .I2(\stateW_reg_n_0_[0] ),
        .O(\tickW[3]_i_3_n_0 ));
  FDCE \tickW_reg[0] 
       (.C(axi_aclk),
        .CE(tickW),
        .CLR(AWREADY_i_2_n_0),
        .D(\tickW[0]_i_1_n_0 ),
        .Q(\tickW_reg_n_0_[0] ));
  FDCE \tickW_reg[1] 
       (.C(axi_aclk),
        .CE(tickW),
        .CLR(AWREADY_i_2_n_0),
        .D(\tickW[1]_i_1_n_0 ),
        .Q(\tickW_reg_n_0_[1] ));
  FDCE \tickW_reg[2] 
       (.C(axi_aclk),
        .CE(tickW),
        .CLR(AWREADY_i_2_n_0),
        .D(\tickW[2]_i_1_n_0 ),
        .Q(\tickW_reg_n_0_[2] ));
  FDCE \tickW_reg[3] 
       (.C(axi_aclk),
        .CE(tickW),
        .CLR(AWREADY_i_2_n_0),
        .D(\tickW[3]_i_2_n_0 ),
        .Q(\tickW_reg_n_0_[3] ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
