//----------------------------------------------------------------
//  Copyright (c) 2024 by Ando Ki.
//  All right reserved.
//  http://www.future-ds.com
//  All rights are reserved by Ando Ki.
//  Do not use in any means or/and methods without Ando Ki's permission.
//----------------------------------------------------------------
// top.v
//----------------------------------------------------------------
// VERSION: 2014.06.20.
//----------------------------------------------------------------
//
//   +------+      +-----+       +-------+ 0x4000_0000
//   | BFM  | [0]  |     | [2]   |  MEM  |
//   |     M|<====>|S   M|<======|S      |
//   +------+      |     |       |       |
//                 |     |       +-------+
//   +------+ [1]  |     | [3]   +------------+ 0x6000_0000
//   |DMA  M|<====>|S   M|<=====>|AXI-to-Lite |
//   |      |      |     |       +------------+
//   +------+      +-----+            /\
//      /\                            ||
//      ||                            ||
//      ++============================++
//----------------------------------------------------------------
`timescale 1ns/1ps

`ifdef __ICARUS__
`define NET_DELAY
`else
`define NET_DELAY  #(0.1)
`endif

module top ;
    //---------------------------------------------------------
    localparam AXI_WIDTH_ID   = 2 // ID width in bits
             , AXI_WIDTH_SID  = 1+AXI_WIDTH_ID
             , AXI_WIDTH_ADDR =32 // address width
             , AXI_WIDTH_DATA =32 // data width
             , AXI_WIDTH_STRB =(AXI_WIDTH_DATA/8);  // data strobe width
    localparam ADDR_LENG0=24 // effective address bits-widgh
             , ADDR_LENG1=10 // effective address bits-widgh
             , ADDR_BASE0=32'h4000_0000
             , ADDR_BASE1=32'h6000_0000;
    localparam P_SIZE_IN_BYTES=1<<ADDR_LENG0;
    //---------------------------------------------------------
    reg  axi_aresetn=1'b0; initial begin #111; axi_aresetn=1'b1; end
    reg  axi_aclk=1'b0; always #10 axi_aclk = ~axi_aclk;
    wire [AXI_WIDTH_SID-1:0]  `NET_DELAY axi_awid   [0:3];
    wire [AXI_WIDTH_ADDR-1:0] `NET_DELAY axi_awaddr [0:3];
    wire [ 7:0]               `NET_DELAY axi_awlen  [0:3];
    wire [ 2:0]               `NET_DELAY axi_awsize [0:3];
    wire [ 1:0]               `NET_DELAY axi_awburst[0:3];
    wire                      `NET_DELAY axi_awvalid[0:3];
    wire                      `NET_DELAY axi_awready[0:3];
    wire [AXI_WIDTH_SID-1:0]  `NET_DELAY axi_wid    [0:3];
    wire [AXI_WIDTH_DATA-1:0] `NET_DELAY axi_wdata  [0:3];
    wire [AXI_WIDTH_STRB-1:0] `NET_DELAY axi_wstrb  [0:3];
    wire                      `NET_DELAY axi_wlast  [0:3];
    wire                      `NET_DELAY axi_wvalid [0:3];
    wire                      `NET_DELAY axi_wready [0:3];
    wire [AXI_WIDTH_SID-1:0]  `NET_DELAY axi_bid    [0:3];
    wire [ 1:0]               `NET_DELAY axi_bresp  [0:3];
    wire                      `NET_DELAY axi_bvalid [0:3];
    wire                      `NET_DELAY axi_bready [0:3];
    wire [AXI_WIDTH_SID-1:0]  `NET_DELAY axi_arid   [0:3];
    wire [AXI_WIDTH_ADDR-1:0] `NET_DELAY axi_araddr [0:3];
    wire [ 7:0]               `NET_DELAY axi_arlen  [0:3];
    wire [ 2:0]               `NET_DELAY axi_arsize [0:3];
    wire [ 1:0]               `NET_DELAY axi_arburst[0:3];
    wire                      `NET_DELAY axi_arvalid[0:3];
    wire                      `NET_DELAY axi_arready[0:3];
    wire [AXI_WIDTH_SID-1:0]  `NET_DELAY axi_rid    [0:3];
    wire [AXI_WIDTH_DATA-1:0] `NET_DELAY axi_rdata  [0:3];
    wire [ 1:0]               `NET_DELAY axi_rresp  [0:3];
    wire                      `NET_DELAY axi_rlast  [0:3];
    wire                      `NET_DELAY axi_rvalid [0:3];
    wire                      `NET_DELAY axi_rready [0:3];
    //---------------------------------------------------------
    wire        axi_lite_aresetn  = axi_aresetn;
    wire        axi_lite_aclk     = axi_aclk;
    wire [31:0] `NET_DELAY axi_lite_awaddr ;
    wire        `NET_DELAY axi_lite_awvalid;
    wire        `NET_DELAY axi_lite_awready;
    wire [31:0] `NET_DELAY axi_lite_wdata  ;
    wire        `NET_DELAY axi_lite_wvalid ;
    wire        `NET_DELAY axi_lite_wready ;
    wire [ 1:0] `NET_DELAY axi_lite_bresp  ;
    wire        `NET_DELAY axi_lite_bvalid ;
    wire        `NET_DELAY axi_lite_bready ;
    wire [31:0] `NET_DELAY axi_lite_araddr ;
    wire        `NET_DELAY axi_lite_arvalid;
    wire        `NET_DELAY axi_lite_arready;
    wire [31:0] `NET_DELAY axi_lite_rdata  ;
    wire [ 1:0] `NET_DELAY axi_lite_rresp  ;
    wire        `NET_DELAY axi_lite_rvalid ;
    wire        `NET_DELAY axi_lite_rready ;
    //---------------------------------------------------------
    wire  IRQ;
    //---------------------------------------------------------
    dma_axi_simple #(.AXI_WIDTH_ID  (AXI_WIDTH_ID  )
                    ,.AXI_WIDTH_ADDR(AXI_WIDTH_ADDR)
                    ,.AXI_WIDTH_DATA(AXI_WIDTH_DATA))
    u_dma (
          .axi_aresetn        ( axi_aresetn      )
        , .axi_aclk           ( axi_aclk         )
        , .m_axi_awid         ( axi_awid      [1][AXI_WIDTH_ID-1:0])
        , .m_axi_awaddr       ( axi_awaddr    [1])
        , .m_axi_awlen        ( axi_awlen     [1])
        , .m_axi_awsize       ( axi_awsize    [1])
        , .m_axi_awburst      ( axi_awburst   [1])
        , .m_axi_awvalid      ( axi_awvalid   [1])
        , .m_axi_awready      ( axi_awready   [1])
        , .m_axi_wid          ( axi_wid       [1][AXI_WIDTH_ID-1:0])
        , .m_axi_wdata        ( axi_wdata     [1])
        , .m_axi_wstrb        ( axi_wstrb     [1])
        , .m_axi_wlast        ( axi_wlast     [1])
        , .m_axi_wvalid       ( axi_wvalid    [1])
        , .m_axi_wready       ( axi_wready    [1])
        , .m_axi_bid          ( axi_bid       [1][AXI_WIDTH_ID-1:0])
        , .m_axi_bresp        ( axi_bresp     [1])
        , .m_axi_bvalid       ( axi_bvalid    [1])
        , .m_axi_bready       ( axi_bready    [1])
        , .m_axi_arid         ( axi_arid      [1][AXI_WIDTH_ID-1:0])
        , .m_axi_araddr       ( axi_araddr    [1])
        , .m_axi_arlen        ( axi_arlen     [1])
        , .m_axi_arsize       ( axi_arsize    [1])
        , .m_axi_arburst      ( axi_arburst   [1])
        , .m_axi_arvalid      ( axi_arvalid   [1])
        , .m_axi_arready      ( axi_arready   [1])
        , .m_axi_rid          ( axi_rid       [1][AXI_WIDTH_ID-1:0])
        , .m_axi_rdata        ( axi_rdata     [1])
        , .m_axi_rresp        ( axi_rresp     [1])
        , .m_axi_rlast        ( axi_rlast     [1])
        , .m_axi_rvalid       ( axi_rvalid    [1])
        , .m_axi_rready       ( axi_rready    [1])
        , .axi_lite_aresetn   ( axi_lite_aresetn )
        , .axi_lite_aclk      ( axi_lite_aclk    )
        , .s_axi_lite_awaddr  ( axi_lite_awaddr  )
        , .s_axi_lite_awvalid ( axi_lite_awvalid )
        , .s_axi_lite_awready ( axi_lite_awready )
        , .s_axi_lite_wdata   ( axi_lite_wdata   )
        , .s_axi_lite_wvalid  ( axi_lite_wvalid  )
        , .s_axi_lite_wready  ( axi_lite_wready  )
        , .s_axi_lite_bresp   ( axi_lite_bresp   )
        , .s_axi_lite_bvalid  ( axi_lite_bvalid  )
        , .s_axi_lite_bready  ( axi_lite_bready  )
        , .s_axi_lite_araddr  ( axi_lite_araddr  )
        , .s_axi_lite_arvalid ( axi_lite_arvalid )
        , .s_axi_lite_arready ( axi_lite_arready )
        , .s_axi_lite_rdata   ( axi_lite_rdata   )
        , .s_axi_lite_rresp   ( axi_lite_rresp   )
        , .s_axi_lite_rvalid  ( axi_lite_rvalid  )
        , .s_axi_lite_rready  ( axi_lite_rready  )
        , .IRQ                ( IRQ              )
    );
    assign axi_awid[1][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    assign axi_wid [1][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    assign axi_bid [1][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    assign axi_arid[1][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    assign axi_rid [1][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    //--------------------------------------------------------------------------
    mem_axi #(.AXI_WIDTH_ID   (AXI_WIDTH_SID  )
             ,.AXI_WIDTH_ADDR (AXI_WIDTH_ADDR )
             ,.AXI_WIDTH_DATA (AXI_WIDTH_DATA )
             ,.AXI_WIDTH_STRB (AXI_WIDTH_STRB )
             ,.P_SIZE_IN_BYTES(P_SIZE_IN_BYTES))
    u_mem (
          .axi_aresetn   ( axi_aresetn )
        , .axi_aclk      ( axi_aclk    )
        , .s_axi_awid    ( axi_awid    [2])
        , .s_axi_awaddr  ( axi_awaddr  [2])
        , .s_axi_awlen   ( axi_awlen   [2])
        , .s_axi_awsize  ( axi_awsize  [2])
        , .s_axi_awburst ( axi_awburst [2])
        , .s_axi_awvalid ( axi_awvalid [2])
        , .s_axi_awready ( axi_awready [2])
        , .s_axi_wid     ( axi_wid     [2])
        , .s_axi_wdata   ( axi_wdata   [2])
        , .s_axi_wstrb   ( axi_wstrb   [2])
        , .s_axi_wlast   ( axi_wlast   [2])
        , .s_axi_wvalid  ( axi_wvalid  [2])
        , .s_axi_wready  ( axi_wready  [2])
        , .s_axi_bid     ( axi_bid     [2])
        , .s_axi_bresp   ( axi_bresp   [2])
        , .s_axi_bvalid  ( axi_bvalid  [2])
        , .s_axi_bready  ( axi_bready  [2])
        , .s_axi_arid    ( axi_arid    [2])
        , .s_axi_araddr  ( axi_araddr  [2])
        , .s_axi_arlen   ( axi_arlen   [2])
        , .s_axi_arsize  ( axi_arsize  [2])
        , .s_axi_arburst ( axi_arburst [2])
        , .s_axi_arvalid ( axi_arvalid [2])
        , .s_axi_arready ( axi_arready [2])
        , .s_axi_rid     ( axi_rid     [2])
        , .s_axi_rdata   ( axi_rdata   [2])
        , .s_axi_rresp   ( axi_rresp   [2])
        , .s_axi_rlast   ( axi_rlast   [2])
        , .s_axi_rvalid  ( axi_rvalid  [2])
        , .s_axi_rready  ( axi_rready  [2])
    );
    //---------------------------------------------------------
    bfm_axi #(.WIDTH_ID(AXI_WIDTH_ID)
             ,.WIDTH_AD(AXI_WIDTH_ADDR)
             ,.WIDTH_DA(AXI_WIDTH_DATA))
    u_bfm (
          .aresetn       ( axi_aresetn )
        , .aclk          ( axi_aclk    )
        , .m_axi_awid    ( axi_awid   [0][AXI_WIDTH_ID-1:0])
        , .m_axi_awaddr  ( axi_awaddr [0])
        , .m_axi_awlen   ( axi_awlen  [0])
        , .m_axi_awlock  (               )
        , .m_axi_awsize  ( axi_awsize [0])
        , .m_axi_awburst ( axi_awburst[0])
        , .m_axi_awvalid ( axi_awvalid[0])
        , .m_axi_awready ( axi_awready[0])
        , .m_axi_wid     ( axi_wid    [0][AXI_WIDTH_ID-1:0])
        , .m_axi_wdata   ( axi_wdata  [0])
        , .m_axi_wstrb   ( axi_wstrb  [0])
        , .m_axi_wlast   ( axi_wlast  [0])
        , .m_axi_wvalid  ( axi_wvalid [0])
        , .m_axi_wready  ( axi_wready [0])
        , .m_axi_bid     ( axi_bid    [0][AXI_WIDTH_ID-1:0])
        , .m_axi_bresp   ( axi_bresp  [0])
        , .m_axi_bvalid  ( axi_bvalid [0])
        , .m_axi_bready  ( axi_bready [0])
        , .m_axi_arid    ( axi_arid   [0][AXI_WIDTH_ID-1:0])
        , .m_axi_araddr  ( axi_araddr [0])
        , .m_axi_arlen   ( axi_arlen  [0])
        , .m_axi_arlock  (               )
        , .m_axi_arsize  ( axi_arsize [0])
        , .m_axi_arburst ( axi_arburst[0])
        , .m_axi_arvalid ( axi_arvalid[0])
        , .m_axi_arready ( axi_arready[0])
        , .m_axi_rid     ( axi_rid    [0][AXI_WIDTH_ID-1:0])
        , .m_axi_rdata   ( axi_rdata  [0])
        , .m_axi_rresp   ( axi_rresp  [0])
        , .m_axi_rlast   ( axi_rlast  [0])
        , .m_axi_rvalid  ( axi_rvalid [0])
        , .m_axi_rready  ( axi_rready [0])
    );
    assign axi_awid[0][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    assign axi_wid [0][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    assign axi_bid [0][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    assign axi_arid[0][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    assign axi_rid [0][AXI_WIDTH_SID-1:AXI_WIDTH_ID] = 'h0;
    //--------------------------------------------------------------------------
    axi4_to_lite #(.AXI_WIDTH_ID  (AXI_WIDTH_SID )
                  ,.AXI_WIDTH_ADDR(AXI_WIDTH_ADDR)
                  ,.AXI_WIDTH_DATA(AXI_WIDTH_DATA))
    u_axi4_to_lite (
          .axi_aresetn     ( axi_aresetn  )
        , .axi_aclk        ( axi_aclk     )
        , .s_axi_awid      ( axi_awid    [3])
        , .s_axi_awaddr    ( axi_awaddr  [3])
        , .s_axi_awlen     ( axi_awlen   [3])
        , .s_axi_awsize    ( axi_awsize  [3])
        , .s_axi_awburst   ( axi_awburst [3])
        , .s_axi_awvalid   ( axi_awvalid [3])
        , .s_axi_awready   ( axi_awready [3])
        , .s_axi_wid       ( axi_wid     [3])
        , .s_axi_wdata     ( axi_wdata   [3])
        , .s_axi_wstrb     ( axi_wstrb   [3])
        , .s_axi_wlast     ( axi_wlast   [3])
        , .s_axi_wvalid    ( axi_wvalid  [3])
        , .s_axi_wready    ( axi_wready  [3])
        , .s_axi_bid       ( axi_bid     [3])
        , .s_axi_bresp     ( axi_bresp   [3])
        , .s_axi_bvalid    ( axi_bvalid  [3])
        , .s_axi_bready    ( axi_bready  [3])
        , .s_axi_arid      ( axi_arid    [3])
        , .s_axi_araddr    ( axi_araddr  [3])
        , .s_axi_arlen     ( axi_arlen   [3])
        , .s_axi_arsize    ( axi_arsize  [3])
        , .s_axi_arburst   ( axi_arburst [3])
        , .s_axi_arvalid   ( axi_arvalid [3])
        , .s_axi_arready   ( axi_arready [3])
        , .s_axi_rid       ( axi_rid     [3])
        , .s_axi_rdata     ( axi_rdata   [3])
        , .s_axi_rresp     ( axi_rresp   [3])
        , .s_axi_rlast     ( axi_rlast   [3])
        , .s_axi_rvalid    ( axi_rvalid  [3])
        , .s_axi_rready    ( axi_rready  [3])
        , .m_axil_awaddr   ( axi_lite_awaddr  )
        , .m_axil_awvalid  ( axi_lite_awvalid )
        , .m_axil_awready  ( axi_lite_awready )
        , .m_axil_wdata    ( axi_lite_wdata   )
        , .m_axil_wvalid   ( axi_lite_wvalid  )
        , .m_axil_wready   ( axi_lite_wready  )
        , .m_axil_bresp    ( axi_lite_bresp   )
        , .m_axil_bvalid   ( axi_lite_bvalid  )
        , .m_axil_bready   ( axi_lite_bready  )
        , .m_axil_araddr   ( axi_lite_araddr  )
        , .m_axil_arvalid  ( axi_lite_arvalid )
        , .m_axil_arready  ( axi_lite_arready )
        , .m_axil_rdata    ( axi_lite_rdata   )
        , .m_axil_rresp    ( axi_lite_rresp   )
        , .m_axil_rvalid   ( axi_lite_rvalid  )
        , .m_axil_rready   ( axi_lite_rready  )
    );
    //---------------------------------------------------------
    amba_axi_m2s2 #(.WIDTH_CID   (1)
                   ,.WIDTH_ID    (2)
                   ,.WIDTH_AD    (AXI_WIDTH_ADDR)
                   ,.WIDTH_DA    (AXI_WIDTH_DATA)
                   ,.SLAVE_EN0(1),.ADDR_LENGTH0(ADDR_LENG0)// effective address bits-widgh
                   ,.SLAVE_EN1(1),.ADDR_LENGTH1(ADDR_LENG1)// effective address bits-widgh
                   ,.ADDR_BASE0  (ADDR_BASE0)
                   ,.ADDR_BASE1  (ADDR_BASE1))
    u_axi (
       .ARESETn      ( axi_aresetn   )
     , .ACLK         ( axi_aclk      )
     , .M0_AWID      ( axi_awid   [0][AXI_WIDTH_ID-1:0])
     , .M0_AWADDR    ( axi_awaddr [0])
     , .M0_AWLEN     ( axi_awlen  [0])
     , .M0_AWSIZE    ( axi_awsize [0])
     , .M0_AWBURST   ( axi_awburst[0])
     , .M0_AWVALID   ( axi_awvalid[0])
     , .M0_AWREADY   ( axi_awready[0])
     , .M0_WID       ( axi_wid    [0][AXI_WIDTH_ID-1:0])
     , .M0_WDATA     ( axi_wdata  [0])
     , .M0_WSTRB     ( axi_wstrb  [0])
     , .M0_WLAST     ( axi_wlast  [0])
     , .M0_WVALID    ( axi_wvalid [0])
     , .M0_WREADY    ( axi_wready [0])
     , .M0_BID       ( axi_bid    [0][AXI_WIDTH_ID-1:0])
     , .M0_BRESP     ( axi_bresp  [0])
     , .M0_BVALID    ( axi_bvalid [0])
     , .M0_BREADY    ( axi_bready [0])
     , .M0_ARID      ( axi_arid   [0][AXI_WIDTH_ID-1:0])
     , .M0_ARADDR    ( axi_araddr [0])
     , .M0_ARLEN     ( axi_arlen  [0])
     , .M0_ARSIZE    ( axi_arsize [0])
     , .M0_ARBURST   ( axi_arburst[0])
     , .M0_ARVALID   ( axi_arvalid[0])
     , .M0_ARREADY   ( axi_arready[0])
     , .M0_RID       ( axi_rid    [0][AXI_WIDTH_ID-1:0])
     , .M0_RDATA     ( axi_rdata  [0])
     , .M0_RRESP     ( axi_rresp  [0])
     , .M0_RLAST     ( axi_rlast  [0])
     , .M0_RVALID    ( axi_rvalid [0])
     , .M0_RREADY    ( axi_rready [0])
     , .M1_AWID      ( axi_awid   [1][AXI_WIDTH_ID-1:0])
     , .M1_AWADDR    ( axi_awaddr [1])
     , .M1_AWLEN     ( axi_awlen  [1])
     , .M1_AWSIZE    ( axi_awsize [1])
     , .M1_AWBURST   ( axi_awburst[1])
     , .M1_AWVALID   ( axi_awvalid[1])
     , .M1_AWREADY   ( axi_awready[1])
     , .M1_WID       ( axi_wid    [1][AXI_WIDTH_ID-1:0])
     , .M1_WDATA     ( axi_wdata  [1])
     , .M1_WSTRB     ( axi_wstrb  [1])
     , .M1_WLAST     ( axi_wlast  [1])
     , .M1_WVALID    ( axi_wvalid [1])
     , .M1_WREADY    ( axi_wready [1])
     , .M1_BID       ( axi_bid    [1][AXI_WIDTH_ID-1:0])
     , .M1_BRESP     ( axi_bresp  [1])
     , .M1_BVALID    ( axi_bvalid [1])
     , .M1_BREADY    ( axi_bready [1])
     , .M1_ARID      ( axi_arid   [1][AXI_WIDTH_ID-1:0])
     , .M1_ARADDR    ( axi_araddr [1])
     , .M1_ARLEN     ( axi_arlen  [1])
     , .M1_ARSIZE    ( axi_arsize [1])
     , .M1_ARBURST   ( axi_arburst[1])
     , .M1_ARVALID   ( axi_arvalid[1])
     , .M1_ARREADY   ( axi_arready[1])
     , .M1_RID       ( axi_rid    [1][AXI_WIDTH_ID-1:0])
     , .M1_RDATA     ( axi_rdata  [1])
     , .M1_RRESP     ( axi_rresp  [1])
     , .M1_RLAST     ( axi_rlast  [1])
     , .M1_RVALID    ( axi_rvalid [1])
     , .M1_RREADY    ( axi_rready [1])
     , .S0_AWID      ( axi_awid   [2])
     , .S0_AWADDR    ( axi_awaddr [2])
     , .S0_AWLEN     ( axi_awlen  [2])
     , .S0_AWSIZE    ( axi_awsize [2])
     , .S0_AWBURST   ( axi_awburst[2])
     , .S0_AWVALID   ( axi_awvalid[2])
     , .S0_AWREADY   ( axi_awready[2])
     , .S0_WID       ( axi_wid    [2])
     , .S0_WDATA     ( axi_wdata  [2])
     , .S0_WSTRB     ( axi_wstrb  [2])
     , .S0_WLAST     ( axi_wlast  [2])
     , .S0_WVALID    ( axi_wvalid [2])
     , .S0_WREADY    ( axi_wready [2])
     , .S0_BID       ( axi_bid    [2])
     , .S0_BRESP     ( axi_bresp  [2])
     , .S0_BVALID    ( axi_bvalid [2])
     , .S0_BREADY    ( axi_bready [2])
     , .S0_ARID      ( axi_arid   [2])
     , .S0_ARADDR    ( axi_araddr [2])
     , .S0_ARLEN     ( axi_arlen  [2])
     , .S0_ARSIZE    ( axi_arsize [2])
     , .S0_ARBURST   ( axi_arburst[2])
     , .S0_ARVALID   ( axi_arvalid[2])
     , .S0_ARREADY   ( axi_arready[2])
     , .S0_RID       ( axi_rid    [2])
     , .S0_RDATA     ( axi_rdata  [2])
     , .S0_RRESP     ( axi_rresp  [2])
     , .S0_RLAST     ( axi_rlast  [2])
     , .S0_RVALID    ( axi_rvalid [2])
     , .S0_RREADY    ( axi_rready [2])
     , .S1_AWID      ( axi_awid   [3])
     , .S1_AWADDR    ( axi_awaddr [3])
     , .S1_AWLEN     ( axi_awlen  [3])
     , .S1_AWSIZE    ( axi_awsize [3])
     , .S1_AWBURST   ( axi_awburst[3])
     , .S1_AWVALID   ( axi_awvalid[3])
     , .S1_AWREADY   ( axi_awready[3])
     , .S1_WID       ( axi_wid    [3])
     , .S1_WDATA     ( axi_wdata  [3])
     , .S1_WSTRB     ( axi_wstrb  [3])
     , .S1_WLAST     ( axi_wlast  [3])
     , .S1_WVALID    ( axi_wvalid [3])
     , .S1_WREADY    ( axi_wready [3])
     , .S1_BID       ( axi_bid    [3])
     , .S1_BRESP     ( axi_bresp  [3])
     , .S1_BVALID    ( axi_bvalid [3])
     , .S1_BREADY    ( axi_bready [3])
     , .S1_ARID      ( axi_arid   [3])
     , .S1_ARADDR    ( axi_araddr [3])
     , .S1_ARLEN     ( axi_arlen  [3])
     , .S1_ARSIZE    ( axi_arsize [3])
     , .S1_ARBURST   ( axi_arburst[3])
     , .S1_ARVALID   ( axi_arvalid[3])
     , .S1_ARREADY   ( axi_arready[3])
     , .S1_RID       ( axi_rid    [3])
     , .S1_RDATA     ( axi_rdata  [3])
     , .S1_RRESP     ( axi_rresp  [3])
     , .S1_RLAST     ( axi_rlast  [3])
     , .S1_RVALID    ( axi_rvalid [3])
     , .S1_RREADY    ( axi_rready [3])
    );
    //---------------------------------------------------------
    initial begin
        wait(axi_aresetn==1'b0);
        wait(axi_aresetn==1'b1);
        repeat (5) @ (posedge axi_aclk);
        wait(u_bfm.DONE==1'b1);
        repeat (5) @ (posedge axi_aclk);
        $finish(2);
    end
    //---------------------------------------------------------
    `ifdef VCD
    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0);
    end
    `endif
    //---------------------------------------------------------
endmodule
//----------------------------------------------------------------
// Revision History
//
// 2024.06.20: Started by Ando Ki (adki@future-ds.com)
//----------------------------------------------------------------
