//----------------------------------------------------------
// Copyright (c) 2024 by Future Design Systems Co., Ltd.
// All right reserved.
//----------------------------------------------------------
// VERSION: 2024.06.22.
//----------------------------------------------------------
// DMA AXI simplified version
//----------------------------------------------------------
// Limitations:
//----------------------------------------------------------
`include "dma_axi_simple_csr.v"
`include "dma_axi_simple_core.v"

module dma_axi_simple
     #(parameter AXI_WIDTH_ID = 4 // ID width in bits
               , AXI_WIDTH_ADDR =32 // address width
               , AXI_WIDTH_DATA =32 // data width
               , AXI_WIDTH_STRB =(AXI_WIDTH_DATA/8))  // data strobe width
(
     //-----------------------------------------------------------
     // DMA AXI Master Port
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 axi_aresetn RST"  *) input  wire                      axi_aresetn,
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF m_axi, ASSOCIATED_RESET axi_aresetn" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 axi_aclk CLK"     *) input  wire                      axi_aclk,
`ifndef __ICARUS__
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF m_axi,\
                                CLK_DOMAIN axi_aclk,\
                                ASSOCIATED_RESET aresetn,\
                                RUSER_WIDTH 0,WUSER_WIDTH 0,ARUSER_WIDTH 0,AWUSER_WIDTH 0,\
                                HAS_CACHE 0,HAS_LOCK 0,HAS_PROT 0,HAS_QOS 0,HAS_REGION 0" *)
`endif
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWID"    *) output wire [AXI_WIDTH_ID-1:0]   m_axi_awid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWADDR"  *) output wire [AXI_WIDTH_ADDR-1:0] m_axi_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWLEN"   *) output wire [ 7:0]               m_axi_awlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWSIZE"  *) output wire [ 2:0]               m_axi_awsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWBURST" *) output wire [ 1:0]               m_axi_awburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWVALID" *) output wire                      m_axi_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi AWREADY" *) input  wire                      m_axi_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WID"     *) output wire [AXI_WIDTH_ID-1:0]   m_axi_wid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WDATA"   *) output wire [AXI_WIDTH_DATA-1:0] m_axi_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WSTRB"   *) output wire [AXI_WIDTH_STRB-1:0] m_axi_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WLAST"   *) output wire                      m_axi_wlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WVALID"  *) output wire                      m_axi_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi WREADY"  *) input  wire                      m_axi_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BID"     *) input  wire [AXI_WIDTH_ID-1:0]   m_axi_bid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BRESP"   *) input  wire [ 1:0]               m_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BVALID"  *) input  wire                      m_axi_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi BREADY"  *) output wire                      m_axi_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARID"    *) output wire [AXI_WIDTH_ID-1:0]   m_axi_arid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARADDR"  *) output wire [AXI_WIDTH_ADDR-1:0] m_axi_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARLEN"   *) output wire [ 7:0]               m_axi_arlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARSIZE"  *) output wire [ 2:0]               m_axi_arsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARBURST" *) output wire [ 1:0]               m_axi_arburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARVALID" *) output wire                      m_axi_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi ARREADY" *) input  wire                      m_axi_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RID"     *) input  wire [AXI_WIDTH_ID-1:0]   m_axi_rid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RDATA"   *) input  wire [AXI_WIDTH_DATA-1:0] m_axi_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RRESP"   *) input  wire [ 1:0]               m_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RLAST"   *) input  wire                      m_axi_rlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RVALID"  *) input  wire                      m_axi_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 m_axi RREADY"  *) output wire                      m_axi_rready,
     //-----------------------------------------------------------
     // AXI-Lite Slave Port for CSR
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 axi_lite_aresetn RST"  *) input  wire        axi_lite_aresetn,
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axi_lite, ASSOCIATED_RESET axi_lite_aresetn" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 axi_lite_aclk CLK"     *) input  wire        axi_lite_aclk,
`ifndef __ICARUS__
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axi_lite,\
                                ASSOCIATED_RESET aresetn,\
                                CLK_DOMAIN axi_lite_aclk,\
                                ADDR_WIDTH 32,DATA_WIDTH 32,PROTOCOL AXI4LITE" *)
`endif
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite AWADDR"  *) input  wire [31:0] s_axi_lite_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite AWVALID" *) input  wire        s_axi_lite_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite AWREADY" *) output wire        s_axi_lite_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite WDATA"   *) input  wire [31:0] s_axi_lite_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite WVALID"  *) input  wire        s_axi_lite_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite WREADY"  *) output wire        s_axi_lite_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite BRESP"   *) output wire [ 1:0] s_axi_lite_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite BVALID"  *) output wire        s_axi_lite_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite BREADY"  *) input  wire        s_axi_lite_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite ARADDR"  *) input  wire [31:0] s_axi_lite_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite ARVALID" *) input  wire        s_axi_lite_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite ARREADY" *) output wire        s_axi_lite_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite RDATA"   *) output wire [31:0] s_axi_lite_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite RRESP"   *) output wire [ 1:0] s_axi_lite_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite RVALID"  *) output wire        s_axi_lite_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi_lite RREADY"  *) input  wire        s_axi_lite_rready
     //--------------------------------------------------
     , output  wire                    IRQ
);
   //-----------------------------------------------------
   (* mark_debug="true" *) wire          csr_DMA_EN   ;
   (* mark_debug="true" *) wire          csr_DMA_GO   ;
   (* mark_debug="true" *) wire          csr_DMA_BUSY ;
   (* mark_debug="true" *) wire          csr_DMA_DONE ;
   (* mark_debug="true" *) wire  [31:0]  csr_DMA_SRC  ;
   (* mark_debug="true" *) wire  [31:0]  csr_DMA_DST  ;
   (* mark_debug="true" *) wire  [15:0]  csr_DMA_BNUM ;// num of bytes to move
   (* mark_debug="true" *) wire  [ 7:0]  csr_DMA_CHUNK;// AxLEN ( +l beats)
   //-----------------------------------------------------
   dma_axi_simple_csr
   u_csr (
         .aresetn          ( axi_lite_aresetn   )
       , .aclk             ( axi_lite_aclk      )
       , .axi_lite_awaddr  ( s_axi_lite_awaddr  )
       , .axi_lite_awvalid ( s_axi_lite_awvalid )
       , .axi_lite_awready ( s_axi_lite_awready )
       , .axi_lite_wdata   ( s_axi_lite_wdata   )
       , .axi_lite_wvalid  ( s_axi_lite_wvalid  )
       , .axi_lite_wready  ( s_axi_lite_wready  )
       , .axi_lite_bresp   ( s_axi_lite_bresp   )
       , .axi_lite_bvalid  ( s_axi_lite_bvalid  )
       , .axi_lite_bready  ( s_axi_lite_bready  )
       , .axi_lite_araddr  ( s_axi_lite_araddr  )
       , .axi_lite_arvalid ( s_axi_lite_arvalid )
       , .axi_lite_arready ( s_axi_lite_arready )
       , .axi_lite_rdata   ( s_axi_lite_rdata   )
       , .axi_lite_rresp   ( s_axi_lite_rresp   )
       , .axi_lite_rvalid  ( s_axi_lite_rvalid  )
       , .axi_lite_rready  ( s_axi_lite_rready  )
       , .IRQ      (    IRQ       )
       , .DMA_EN   (csr_DMA_EN    )
       , .DMA_GO   (csr_DMA_GO    )
       , .DMA_BUSY (csr_DMA_BUSY  )
       , .DMA_DONE (csr_DMA_DONE  )
       , .DMA_SRC  (csr_DMA_SRC   )
       , .DMA_DST  (csr_DMA_DST   )
       , .DMA_BNUM (csr_DMA_BNUM  )
       , .DMA_CHUNK(csr_DMA_CHUNK )
   );
   //-----------------------------------------------------
   wire          DMA_EN   ;
   wire          DMA_GO   ;
   wire          DMA_BUSY ;
   wire          DMA_DONE ;
   wire  [31:0]  DMA_SRC  ;
   wire  [31:0]  DMA_DST  ;
   wire  [15:0]  DMA_BNUM ;// num of bytes to move
   wire  [ 7:0]  DMA_CHUNK;// AxLEN ( +l beats)
   //-----------------------------------------------------
   dma_axi_simple_core #(.AXI_WIDTH_ID  (AXI_WIDTH_ID  ) // ID width in bits
                        ,.AXI_WIDTH_ADDR(AXI_WIDTH_ADDR) // address width
                        ,.AXI_WIDTH_DATA(AXI_WIDTH_DATA))// data width
   u_core (
       .aresetn     ( axi_aresetn   )
     , .aclk        ( axi_aclk      )
     , .axi_awid    ( m_axi_awid    )
     , .axi_awaddr  ( m_axi_awaddr  )
     , .axi_awlen   ( m_axi_awlen   )
     , .axi_awsize  ( m_axi_awsize  )
     , .axi_awburst ( m_axi_awburst )
     , .axi_awvalid ( m_axi_awvalid )
     , .axi_awready ( m_axi_awready )
     , .axi_wid     ( m_axi_wid     )
     , .axi_wdata   ( m_axi_wdata   )
     , .axi_wstrb   ( m_axi_wstrb   )
     , .axi_wlast   ( m_axi_wlast   )
     , .axi_wvalid  ( m_axi_wvalid  )
     , .axi_wready  ( m_axi_wready  )
     , .axi_bid     ( m_axi_bid     )
     , .axi_bresp   ( m_axi_bresp   )
     , .axi_bvalid  ( m_axi_bvalid  )
     , .axi_bready  ( m_axi_bready  )
     , .axi_arid    ( m_axi_arid    )
     , .axi_araddr  ( m_axi_araddr  )
     , .axi_arlen   ( m_axi_arlen   )
     , .axi_arsize  ( m_axi_arsize  )
     , .axi_arburst ( m_axi_arburst )
     , .axi_arvalid ( m_axi_arvalid )
     , .axi_arready ( m_axi_arready )
     , .axi_rid     ( m_axi_rid     )
     , .axi_rdata   ( m_axi_rdata   )
     , .axi_rresp   ( m_axi_rresp   )
     , .axi_rlast   ( m_axi_rlast   )
     , .axi_rvalid  ( m_axi_rvalid  )
     , .axi_rready  ( m_axi_rready  )
     , .DMA_EN      (DMA_EN    )
     , .DMA_GO      (DMA_GO    )
     , .DMA_BUSY    (DMA_BUSY  )
     , .DMA_DONE    (DMA_DONE  )
     , .DMA_SRC     (DMA_SRC   )
     , .DMA_DST     (DMA_DST   )
     , .DMA_BNUM    (DMA_BNUM  )
     , .DMA_CHUNK   (DMA_CHUNK )
   );
   //-----------------------------------------------------------
   // need synchronization when axi_aclk != axi_lite_aclk.
   assign     DMA_EN   =csr_DMA_EN   ;
   assign     DMA_GO   =csr_DMA_GO   ;
   assign csr_DMA_BUSY =    DMA_BUSY ;
   assign csr_DMA_DONE =    DMA_DONE ;
   assign     DMA_SRC  =csr_DMA_SRC  ;
   assign     DMA_DST  =csr_DMA_DST  ;
   assign     DMA_BNUM =csr_DMA_BNUM ;
   assign     DMA_CHUNK=csr_DMA_CHUNK;
   //-----------------------------------------------------------
endmodule
//----------------------------------------------------------
// Revision history
//
// 2024.06.22: Rewritten by Ando Ki.
// 2015.07.12: Started by Ando Ki.
//----------------------------------------------------------
