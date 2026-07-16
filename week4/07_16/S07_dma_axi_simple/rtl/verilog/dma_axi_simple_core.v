//----------------------------------------------------------
// Copyright (c) 2015 by Future Design Systems Co., Ltd.
// All right reserved.
//----------------------------------------------------------
// VERSION: 2015.07.12.
//----------------------------------------------------------
// DMA AXI simplified version
//----------------------------------------------------------
// Limitations:
//----------------------------------------------------------
`include "dma_axi_simple_core_read.v"
`include "dma_axi_simple_core_write.v"
`include "dma_axi_simple_fifo_sync_small.v"

module dma_axi_simple_core
     #(parameter AXI_WIDTH_ID =4         // ID width in bits
               , AXI_WIDTH_ADDR =32        // address width
               , AXI_WIDTH_DATA =32        // data width
               , AXI_WIDTH_STRB =(AXI_WIDTH_DATA/8))// data strobe width
(
      input  wire                      aresetn
    , input  wire                      aclk
    , output wire [AXI_WIDTH_ID-1:0]   axi_awid
    , output wire [AXI_WIDTH_ADDR-1:0] axi_awaddr
    , output wire [ 7:0]               axi_awlen
    , output wire [ 2:0]               axi_awsize
    , output wire [ 1:0]               axi_awburst
    , output wire                      axi_awvalid
    , input  wire                      axi_awready
    , output wire [AXI_WIDTH_ID-1:0]   axi_wid
    , output wire [AXI_WIDTH_DATA-1:0] axi_wdata
    , output wire [AXI_WIDTH_STRB-1:0] axi_wstrb
    , output wire                      axi_wlast
    , output wire                      axi_wvalid
    , input  wire                      axi_wready
    , input  wire [AXI_WIDTH_ID-1:0]   axi_bid
    , input  wire [ 1:0]               axi_bresp
    , input  wire                      axi_bvalid
    , output wire                      axi_bready
    , output wire [AXI_WIDTH_ID-1:0]   axi_arid
    , output wire [AXI_WIDTH_ADDR-1:0] axi_araddr
    , output wire [ 7:0]               axi_arlen
    , output wire [ 2:0]               axi_arsize
    , output wire [ 1:0]               axi_arburst
    , output wire                      axi_arvalid
    , input  wire                      axi_arready
    , input  wire [AXI_WIDTH_ID-1:0]   axi_rid
    , input  wire [AXI_WIDTH_DATA-1:0] axi_rdata
    , input  wire [ 1:0]               axi_rresp
    , input  wire                      axi_rlast
    , input  wire                      axi_rvalid
    , output wire                      axi_rready
     //-----------------------------------------------------------
    , input   wire            DMA_EN
    , input   wire            DMA_GO
    , output  wire            DMA_BUSY
    , output  wire            DMA_DONE
    , input   wire  [31:0]    DMA_SRC
    , input   wire  [31:0]    DMA_DST
    , input   wire  [15:0]    DMA_BNUM // num of bytes to move
    , input   wire  [ 7:0]    DMA_CHUNK// num of bytes to move at a time
);
   //-----------------------------------------------------
   wire  DMA_BUSY_R;
   wire  DMA_DONE_R;
   wire  DMA_BUSY_W;
   wire  DMA_DONE_W;
   assign DMA_BUSY = DMA_BUSY_R | DMA_BUSY_W;
   assign DMA_DONE = DMA_DONE_R & DMA_DONE_W;
   //-----------------------------------------------------
   localparam FIFO_DW = AXI_WIDTH_STRB + AXI_WIDTH_DATA
            , FIFO_AW = 4;
   wire               fifo_wr_rdy;
   wire               fifo_wr_vld;
   wire [FIFO_DW-1:0] fifo_wr_dat;
   wire               fifo_rd_rdy;
   wire               fifo_rd_vld;
   wire [FIFO_DW-1:0] fifo_rd_dat;
   wire               fifo_full  ;
   wire               fifo_empty ;
   wire [FIFO_AW:0]   fifo_items ;
   wire [FIFO_AW:0]   fifo_rooms ;
   //-----------------------------------------------------
   dma_axi_simple_core_read #(.AXI_WIDTH_ID   (AXI_WIDTH_ID )
                             ,.AXI_WIDTH_ADDR (AXI_WIDTH_ADDR )
                             ,.AXI_WIDTH_DATA (AXI_WIDTH_DATA )
                             ,.FIFO_WIDTH   (FIFO_DW      )
                             ,.FIFO_DEPTH   (1<<FIFO_AW   ))
   u_read (
       .aresetn     ( aresetn   )
     , .aclk        ( aclk      )
     , .axi_arid    ( axi_arid    )
     , .axi_araddr  ( axi_araddr  )
     , .axi_arlen   ( axi_arlen   )
     , .axi_arsize  ( axi_arsize  )
     , .axi_arburst ( axi_arburst )
     , .axi_arvalid ( axi_arvalid )
     , .axi_arready ( axi_arready )
     , .axi_rid     ( axi_rid     )
     , .axi_rdata   ( axi_rdata   )
     , .axi_rresp   ( axi_rresp   )
     , .axi_rlast   ( axi_rlast   )
     , .axi_rvalid  ( axi_rvalid  )
     , .axi_rready  ( axi_rready  )
     //-----------------------------------------------------------
     , .DMA_EN    (DMA_EN    )
     , .DMA_GO    (DMA_GO    )
     , .DMA_BUSY  (DMA_BUSY_R)
     , .DMA_DONE  (DMA_DONE_R)
     , .DMA_SRC   (DMA_SRC   )
     , .DMA_BNUM  (DMA_BNUM  )
     , .DMA_CHUNK (DMA_CHUNK )
     //-----------------------------------------------------------
     , .fifo_wr_rdy(fifo_wr_rdy)
     , .fifo_wr_vld(fifo_wr_vld)
     , .fifo_wr_dat(fifo_wr_dat)
     , .fifo_empty (fifo_empty )
     , .fifo_rooms (fifo_rooms )
   );
   //-----------------------------------------------------
   dma_axi_simple_core_write #(.AXI_WIDTH_ID   (AXI_WIDTH_ID )
                              ,.AXI_WIDTH_ADDR (AXI_WIDTH_ADDR )
                              ,.AXI_WIDTH_DATA (AXI_WIDTH_DATA )
                              ,.FIFO_WIDTH   (FIFO_DW      )
                              ,.FIFO_DEPTH   (1<<FIFO_AW   ))
   u_write (
       .aresetn     ( aresetn   )
     , .aclk        ( aclk      )
     , .axi_awid    ( axi_awid    )
     , .axi_awaddr  ( axi_awaddr  )
     , .axi_awlen   ( axi_awlen   )
     , .axi_awsize  ( axi_awsize  )
     , .axi_awburst ( axi_awburst )
     , .axi_awvalid ( axi_awvalid )
     , .axi_awready ( axi_awready )
     , .axi_wid     ( axi_wid     )
     , .axi_wdata   ( axi_wdata   )
     , .axi_wstrb   ( axi_wstrb   )
     , .axi_wlast   ( axi_wlast   )
     , .axi_wvalid  ( axi_wvalid  )
     , .axi_wready  ( axi_wready  )
     , .axi_bid     ( axi_bid     )
     , .axi_bresp   ( axi_bresp   )
     , .axi_bvalid  ( axi_bvalid  )
     , .axi_bready  ( axi_bready  )
     //-----------------------------------------------------------
     , .DMA_EN    (DMA_EN    )
     , .DMA_GO    (DMA_GO    )
     , .DMA_BUSY  (DMA_BUSY_W)
     , .DMA_DONE  (DMA_DONE_W)
     , .DMA_DST   (DMA_DST   )
     , .DMA_BNUM  (DMA_BNUM  )
     , .DMA_CHUNK (DMA_CHUNK )
     //-----------------------------------------------------------
     , .fifo_rd_rdy(fifo_rd_rdy)
     , .fifo_rd_vld(fifo_rd_vld)
     , .fifo_rd_dat(fifo_rd_dat)
     , .fifo_items (fifo_items )
   );
   //-----------------------------------------------------------
   // Note each transaction consists of 'len' entries.
   dma_axi_simple_fifo_sync_small
          #(.FDW(FIFO_DW) // fifof data width (data+rid+last)
           ,.FAW(FIFO_AW))// num of entries in 2 to the power FAW
   u_fifo (
       .rst     (~aresetn)
     , .clr     (~DMA_EN )
     , .clk     ( aclk   )
     , .wr_rdy  (fifo_wr_rdy )
     , .wr_vld  (fifo_wr_vld )
     , .wr_din  (fifo_wr_dat )
     , .rd_rdy  (fifo_rd_rdy )
     , .rd_vld  (fifo_rd_vld )
     , .rd_dout (fifo_rd_dat )
     , .full    (fifo_full   )
     , .empty   (fifo_empty  )
     , .fullN   ()
     , .emptyN  ()
     , .rd_cnt  (fifo_items  )
     , .wr_cnt  (fifo_rooms  )
   );
   //-----------------------------------------------------------
   // synthesis translate_off
   localparam AXI_WIDTH_DSB=$clog2(AXI_WIDTH_STRB);// data strobe width
   always @ (posedge aclk) begin
       if (DMA_EN&DMA_GO) begin
           if (DMA_SRC[AXI_WIDTH_DSB-1:0]!==DMA_DST[AXI_WIDTH_DSB-1:0]) begin
$display($time,,"%m src dst not aligned: 0x%X 0x%X",
           DMA_SRC[AXI_WIDTH_DSB-1:0],DMA_DST[AXI_WIDTH_DSB-1:0]);
           end
       end
   end
   // synthesis translate_on
   //-----------------------------------------------------------
endmodule
//----------------------------------------------------------
// Revision history
//
// 2015.07.12: Started by Ando Ki.
//----------------------------------------------------------
