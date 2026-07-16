//----------------------------------------------------------------
//  Copyright (c) 2024 by Ando Ki.
//  All right reserved.
//  http://www.future-ds.com
//  All rights are reserved by Ando Ki.
//  Do not use in any means or/and methods without Ando Ki's permission.
//----------------------------------------------------------------
// bfm_axi.sv
//----------------------------------------------------------------
// VERSION: 2024.06.17.
//----------------------------------------------------------------
//  [MACROS]
//    AMBA_AXI4       - AMBA AXI4
//    AMBA_AXI_CACHE  -
//    AMBA_AXI_PROT   -
//----------------------------------------------------------------
`timescale 1ns/1ns

module bfm_axi #(parameter WIDTH_ID =4         // ID width in bits
                         , WIDTH_AD =32        // address width
                         , WIDTH_DA =32        // data width
                         , WIDTH_DS =(WIDTH_DA/8) // data strobe width
                         , WIDTH_DSB=$clog2(WIDTH_DS) // data strobe width
                   )
(
       input  wire                 aresetn
     , input  wire                 aclk
     //-----------------------------------------------------------
     , output reg  [WIDTH_ID-1:0]  m_axi_awid
     , output reg  [WIDTH_AD-1:0]  m_axi_awaddr
     , output reg  [ 7:0]          m_axi_awlen
     , output reg                  m_axi_awlock
     , output reg  [ 2:0]          m_axi_awsize
     , output reg  [ 1:0]          m_axi_awburst
     , output reg                  m_axi_awvalid
     , input  wire                 m_axi_awready
     //-----------------------------------------------------------
     , output reg  [WIDTH_ID-1:0]  m_axi_wid
     , output reg  [WIDTH_DA-1:0]  m_axi_wdata
     , output reg  [WIDTH_DS-1:0]  m_axi_wstrb
     , output reg                  m_axi_wlast
     , output reg                  m_axi_wvalid
     , input  wire                 m_axi_wready
     //-----------------------------------------------------------
     , input  wire [WIDTH_ID-1:0]  m_axi_bid
     , input  wire [ 1:0]          m_axi_bresp
     , input  wire                 m_axi_bvalid
     , output reg                  m_axi_bready
     //-----------------------------------------------------------
     , output reg  [WIDTH_ID-1:0]  m_axi_arid
     , output reg  [WIDTH_AD-1:0]  m_axi_araddr
     , output reg  [ 7:0]          m_axi_arlen
     , output reg                  m_axi_arlock
     , output reg  [ 2:0]          m_axi_arsize
     , output reg  [ 1:0]          m_axi_arburst
     , output reg                  m_axi_arvalid
     , input  wire                 m_axi_arready
     //-----------------------------------------------------------
     , input  wire [WIDTH_ID-1:0]  m_axi_rid
     , input  wire [WIDTH_DA-1:0]  m_axi_rdata
     , input  wire [ 1:0]          m_axi_rresp
     , input  wire                 m_axi_rlast
     , input  wire                 m_axi_rvalid
     , output reg                  m_axi_rready
     //-----------------------------------------------------------
);
     //-----------------------------------------------------------
     reg [15:0] bnum ; initial bnum  = 0;
     reg [15:0] blen ; initial blen  = 0;
     reg [15:0] bsize; initial bsize = 0;
     reg        delay; initial delay = 0;
     reg [31:0] saddr, depth;
     reg        DONE = 1'b0;
     integer    nm, ns;
     //-----------------------------------------------------------
     initial begin
           m_axi_awid        = 0;
           m_axi_awaddr      = ~0;
           m_axi_awlen       = 0;
           m_axi_awlock      = 0;
           m_axi_awsize      = 0;
           m_axi_awburst     = 0;
           m_axi_awvalid     = 0;
           m_axi_wid         = 0;
           m_axi_wdata       = ~0;
           m_axi_wstrb       = 0;
           m_axi_wlast       = 0;
           m_axi_wvalid      = 0;
           m_axi_bready      = 0;
           m_axi_arid        = 0;
           m_axi_araddr      = ~0;
           m_axi_arlen       = 0;
           m_axi_arlock      = 0;
           m_axi_arsize      = 0;
           m_axi_arburst     = 0;
           m_axi_arvalid     = 0;
           m_axi_rready      = 0; 
           wait (aresetn==1'b0);
           wait (aresetn==1'b1);
           repeat (5) @ (posedge aclk);
           //-----------------------------------------------------
   // single-burst with different size
   if (0) begin
   test_raw( 32'h1  //input [31:0] id;
           , 32'h4000_0000  //input [31:0] saddr; // start address
           , 32'h10 //input [31:0] depth; // size in byte
           , 32'h4  //input [31:0] bsize; // burst size in byte
           , 32'h1  //input [31:0] bleng; // burst length
   );
   end
   if (0) begin
   test_raw( 32'h2  //input [31:0] id;
           , 32'h4000_0000 //input [31:0] saddr; // start address
           , 32'h10 //input [31:0] depth; // size in byte
           , 32'h2  //input [31:0] bsize; // burst size in byte
           , 32'h1  //input [31:0] bleng; // burst length
   );
   end
   if (0) begin
   test_raw( 32'h3  //input [31:0] id;
           , 32'h4000_0000 //input [31:0] saddr; // start address
           , 32'h10 //input [31:0] depth; // size in byte
           , 32'h1  //input [31:0] bsize; // burst size in byte
           , 32'h1  //input [31:0] bleng; // burst length
   );
   end
   //---------------------------------------------------------
   // burst with different size
   if (0) begin
   test_raw_all( 32'h4  //input [31:0] id;
               , 32'h4001_0000 //input [31:0] saddr; // start address
               , 32'h10 //input [31:0] depth; // size in byte
               , 32'h4  //input [31:0] bsize; // burst size in byte
               , 32'h10 //input [31:0] bleng; // burst length
   );
   end
   if (0) begin
   test_raw_all( 32'h5  //input [31:0] id;
               , 32'h4001_0000 //input [31:0] saddr; // start address
               , 32'h10 //input [31:0] depth; // size in byte
               , 32'h2  //input [31:0] bsize; // burst size in byte
               , 32'h10 //input [31:0] bleng; // burst length
   );
   end
   if (0) begin
   test_raw_all( 32'h6  //input [31:0] id;
               , 32'h4001_0000 //input [31:0] saddr; // start address
               , 32'h10 //input [31:0] depth; // size in byte
               , 32'h1  //input [31:0] bsize; // burst size in byte
               , 32'h10 //input [31:0] bleng; // burst length
   );
   end
   //---------------------------------------------------------
   // burst with different size
   if (0) begin
   blen  = 4;
   bsize = 4;
   test_raw_burst ( 32'h7  //input [31:0] id;
                  , 32'h4000_0000 //input [31:0] saddr; // start address
                  , bsize*blen*2//input [31:0] depth; // size in byte
                  , bsize  //input [31:0] bsize; // burst size in byte
                  , blen   //input [31:0] bleng; // burst length
   );
   end
   if (0) begin
   test_raw_burst ( 32'h8  //input [31:0] id;
                  , 32'h4000_0000 //input [31:0] saddr; // start address
                  , 32'h10 //input [31:0] depth; // size in byte
                  , 32'h2  //input [31:0] bsize; // burst size in byte
                  , 32'h4  //input [31:0] bleng; // burst length
   );
   end
   if (0) begin
   test_raw_burst ( 32'h9  //input [31:0] id;
                  , 32'h4000_0000 //input [31:0] saddr; // start address
                  , 32'h10 //input [31:0] depth; // size in byte
                  , 32'h1  //input [31:0] bsize; // burst size in byte
                  , 32'h4  //input [31:0] bleng; // burst length
   );
   end
           //-----------------------------------------------------
   if (0) begin
   csr_test();
   end
           //-----------------------------------------------------
   if (1) begin
   one_dma_test(32'h4000_0000
               ,32'h4001_0000
	       ,'h100 // num of bytes to move
	       ,8'h10);// chunk in bytes
   end
           //-----------------------------------------------------
           repeat (10) @ (posedge aclk);
           DONE = 1'b1;
           //$finish(2);
     end
     //-----------------------------------------------------------
     `include "bfm_axi_tasks.sv"
     `include "bfm_dma_tasks.sv"
     //-----------------------------------------------------------
endmodule
//----------------------------------------------------------------
// Revision History
//
// 2024.06.17: Rewritten by Ando Ki.
// 2013.02.03: Started by Ando Ki (adki@future-ds.com)
//----------------------------------------------------------------
