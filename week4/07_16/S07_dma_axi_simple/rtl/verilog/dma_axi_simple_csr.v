//----------------------------------------------------------
// Copyright (c) 2015 by Future Design Systems Co., Ltd.
// All right reserved.
//----------------------------------------------------------
// dma_axi_simple_csr.v
//----------------------------------------------------------
// VERSION: 2015.07.12.
//----------------------------------------------------------
// Limitations:
//----------------------------------------------------------
//------------------------------------------------------------------------------
// CSR access signals
//             __    __    __    __    __
// clk      __|  |__|  |__|  |__|  |__|  |
//             _____                    
// rd_addr  XXX_____XXXXXXXXXXXXXXXXXXXXX
//             _____
// rd       __|     |____________________
//                   _____
// rd_data  XXXXXXXXX_____XXXXXXXXXXXXXXX
//
//             __    __    __    __    __ 
// clk      __|  |__|  |__|  |__|  |__|  |
//                               _____
// wr_addr  XXXXXXXXXXXXXXXXXXXXX_____XXX
//                               _____
// wr       ____________________|     |__
//                               _____
// wr_data  XXXXXXXXXXXXXXXXXXXXX_____XXXX
//----------------------------------------------------------
`include "dma_axi_simple_axi_lite_if.v"

module dma_axi_simple_csr
(
      input  wire           aresetn
    , input  wire           aclk
    , input  wire   [31:0]  axi_lite_awaddr
    , input  wire           axi_lite_awvalid
    , output wire           axi_lite_awready
    , input  wire   [31:0]  axi_lite_wdata
    , input  wire           axi_lite_wvalid
    , output wire           axi_lite_wready
    , output wire   [ 1:0]  axi_lite_bresp
    , output wire           axi_lite_bvalid
    , input  wire           axi_lite_bready
    , input  wire   [31:0]  axi_lite_araddr
    , input  wire           axi_lite_arvalid
    , output wire           axi_lite_arready
    , output wire   [31:0]  axi_lite_rdata
    , output wire   [ 1:0]  axi_lite_rresp
    , output wire           axi_lite_rvalid
    , input  wire           axi_lite_rready
    , output wire           IRQ
    , output wire           DMA_EN
    , output wire           DMA_GO
    , input  wire           DMA_BUSY
    , input  wire           DMA_DONE
    , output wire  [31:0]   DMA_SRC
    , output wire  [31:0]   DMA_DST
    , output wire  [15:0]   DMA_BNUM // num of bytes to move
    , output wire  [ 7:0]   DMA_CHUNK// num of bytes to move at a time
);
    //--------------------------------------------------------------------------
    localparam T_ADDR_WID=8;
    //--------------------------------------------------------------------------
    (* mark_debug="true" *) wire                   bram_wr;
    (* mark_debug="true" *) wire [T_ADDR_WID-1:0]  bram_wr_addr;
    (* mark_debug="true" *) wire [31:0]            bram_wr_data;
    (* mark_debug="true" *) wire                   bram_rd;
    (* mark_debug="true" *) wire [T_ADDR_WID-1:0]  bram_rd_addr;
    (* mark_debug="true" *) wire [31:0]            bram_rd_data;
    //--------------------------------------------------------------------------
    dma_axi_simple_axi_lite_if #(.T_ADDR_WID(T_ADDR_WID))
    u_if (
          .s_axi_aresetn ( aresetn )
        , .s_axi_aclk    ( aclk    )
        , .s_axi_awaddr  ( axi_lite_awaddr  )
        , .s_axi_awvalid ( axi_lite_awvalid )
        , .s_axi_awready ( axi_lite_awready )
        , .s_axi_wdata   ( axi_lite_wdata   )
        , .s_axi_wvalid  ( axi_lite_wvalid  )
        , .s_axi_wready  ( axi_lite_wready  )
        , .s_axi_bresp   ( axi_lite_bresp   )
        , .s_axi_bvalid  ( axi_lite_bvalid  )
        , .s_axi_bready  ( axi_lite_bready  )
        , .s_axi_araddr  ( axi_lite_araddr  )
        , .s_axi_arvalid ( axi_lite_arvalid )
        , .s_axi_arready ( axi_lite_arready )
        , .s_axi_rdata   ( axi_lite_rdata   )
        , .s_axi_rresp   ( axi_lite_rresp   )
        , .s_axi_rvalid  ( axi_lite_rvalid  )
        , .s_axi_rready  ( axi_lite_rready  )
        , .bram_wr       ( bram_wr       )
        , .bram_wr_addr  ( bram_wr_addr  )
        , .bram_wr_data  ( bram_wr_data  )
        , .bram_rd       ( bram_rd       )
        , .bram_rd_addr  ( bram_rd_addr  )
        , .bram_rd_data  ( bram_rd_data  )
    );
    //--------------------------------------------------------------------------
    dma_axi_simple_csr_core #(.T_ADDR_WID(T_ADDR_WID))
    u_csr_core (
          .RESET_N   ( aresetn   )
        , .CLK       ( aclk      )
        , .bram_wr       ( bram_wr       )
        , .bram_wr_addr  ( bram_wr_addr  )
        , .bram_wr_data  ( bram_wr_data  )
        , .bram_rd       ( bram_rd       )
        , .bram_rd_addr  ( bram_rd_addr  )
        , .bram_rd_data  ( bram_rd_data  )
        , .IRQ       ( IRQ       )
        , .DMA_EN    ( DMA_EN    )
        , .DMA_GO    ( DMA_GO    )
        , .DMA_BUSY  ( DMA_BUSY  )
        , .DMA_DONE  ( DMA_DONE  )
        , .DMA_SRC   ( DMA_SRC   )
        , .DMA_DST   ( DMA_DST   )
        , .DMA_BNUM  ( DMA_BNUM  )// num of bytes to move
        , .DMA_CHUNK ( DMA_CHUNK )// num of bytes to move at a time
    );
endmodule

module dma_axi_simple_csr_core
     #(parameter T_ADDR_WID=8)
(
       input  wire                     RESET_N
     , input  wire                     CLK
     , input  wire                     bram_wr
     , input  wire   [T_ADDR_WID-1:0]  bram_wr_addr
     , input  wire   [31:0]            bram_wr_data
     , input  wire                     bram_rd
     , input  wire   [T_ADDR_WID-1:0]  bram_rd_addr
     , output reg    [31:0]            bram_rd_data
     //-----------------------------------------------------
     , output  wire                   IRQ
     //-----------------------------------------------------
     , output  wire            DMA_EN
     , output  wire            DMA_GO
     , input   wire            DMA_BUSY
     , input   wire            DMA_DONE
     , output  wire  [31:0]    DMA_SRC
     , output  wire  [31:0]    DMA_DST
     , output  wire  [15:0]    DMA_BNUM // num of bytes to move
     , output  wire  [ 7:0]    DMA_CHUNK// num of bytes to move at a time
);
   //--------------------------------------------------------
   // CSR address
   //-------------------------------------------------------
   localparam CSRA_NAME0   = 8'h00,
              CSRA_NAME1   = 8'h04,
              CSRA_NAME2   = 8'h08,
              CSRA_NAME3   = 8'h0C,
              CSRA_COMP0   = 8'h10,
              CSRA_COMP1   = 8'h14,
              CSRA_COMP2   = 8'h18,
              CSRA_COMP3   = 8'h1C,
              CSRA_VERSION = 8'h20,
              CSRA_CONTROL = 8'h30,
              CSRA_NUM     = 8'h40,
              CSRA_SOURCE  = 8'h44,
              CSRA_DEST    = 8'h48;
   //-------------------------------------------------------
   // CSR
   //-------------------------------------------------------
   wire [31:0] csr_name0   = "DMA "; // 
   wire [31:0] csr_name1   = "AXI "; // 
   wire [31:0] csr_name2   = "    "; // 
   wire [31:0] csr_name3   = "    "; // 
   wire [31:0] csr_comp0   = "FDS "; // 
   wire [31:0] csr_comp1   = "    "; // 
   wire [31:0] csr_comp2   = "    "; // 
   wire [31:0] csr_comp3   = "    "; // 
   wire [31:0] csr_version = 32'h20240610;//
   //-------------------------------------------------------
   reg         csr_ctl_en    = 1'b0; // bit-31
   reg         csr_ctl_ip    = 1'b0; // bit-1
   reg         csr_ctl_ie    = 1'b0; // bit-0
   //-------------------------------------------------------
   reg         csr_num_go    = 1'b0; // bit-31
   reg  [ 7:0] csr_num_chunk = 8'b0; // bit-23~16
   reg  [15:0] csr_num_byte  =16'b0; // bit-15~0
   //-------------------------------------------------------
   reg  [31:0] csr_source    = 1'b0; // bit-31~0
   reg  [31:0] csr_dest      = 9'b0; // bit-31~0
   //-------------------------------------------------------
   // CSR read
   always @ (posedge CLK or negedge RESET_N) begin
   if (RESET_N==1'b0) begin
       bram_rd_data <= 'h0;
   end else begin
      if (bram_rd) begin
         case (bram_rd_addr)
           CSRA_NAME0   : bram_rd_data <= csr_name0  ;
           CSRA_NAME1   : bram_rd_data <= csr_name1  ;
           CSRA_NAME2   : bram_rd_data <= csr_name2  ;
           CSRA_NAME3   : bram_rd_data <= csr_name3  ;
           CSRA_COMP0   : bram_rd_data <= csr_comp0  ;
           CSRA_COMP1   : bram_rd_data <= csr_comp1  ;
           CSRA_COMP2   : bram_rd_data <= csr_comp2  ;
           CSRA_COMP3   : bram_rd_data <= csr_comp3  ;
           CSRA_VERSION : bram_rd_data <= csr_version;
           CSRA_CONTROL : bram_rd_data <= {csr_ctl_en // bit-31
                                     ,29'h0      // bit-30~2
                                     ,csr_ctl_ip // bit-1
                                     ,csr_ctl_ie // bit-0
                                     };
           CSRA_NUM     : bram_rd_data <= {csr_num_go    // bit-31
                                     ,DMA_BUSY      // bit-30
                                     ,DMA_DONE      // bit-29
                                     ,5'h0          // bit-28~24
                                     ,csr_num_chunk // bit-23~16
                                     ,csr_num_byte  // bit-15~0
                                     };
           CSRA_SOURCE  : bram_rd_data <= csr_source;
           CSRA_DEST    : bram_rd_data <= csr_dest;
           default: begin
                    bram_rd_data <=32'h0;
           end
         endcase
      end else bram_rd_data <= 'h0;
   end // if
   end // always
   //-------------------------------------------------------
   // CSR write
   always @ (posedge CLK or negedge RESET_N) begin
   if (RESET_N==1'b0) begin
       csr_ctl_en    <= 1'b0;
       csr_num_chunk <= 8'b0;
       csr_num_byte  <= 16'h0;
       csr_source    <= 32'h0;
       csr_dest      <= 32'h0;
   end else begin
      if (bram_wr) begin
         case (bram_wr_addr)
           CSRA_CONTROL : csr_ctl_en // bit-31
                          <= bram_wr_data[31];
           CSRA_NUM     : begin
                          csr_num_chunk // bit-23~16
                          <= bram_wr_data[23:16];
                          csr_num_byte  // bit-15~0
                          <= bram_wr_data[15:0];
                          end
           CSRA_SOURCE  : csr_source <= bram_wr_data;
           CSRA_DEST    : csr_dest <= bram_wr_data;
         endcase
      end
   end // if
   end // always
   //-------------------------------------------------------
   // go
   always @ (posedge CLK or negedge RESET_N) begin
   if (RESET_N==1'b0) begin
       csr_num_go <= 1'b0; // bit-0
   end else begin
       if (bram_wr&&(bram_wr_addr==CSRA_NUM)) begin
           csr_num_go  <= csr_ctl_en & bram_wr_data[31];
       end else begin
           if (DMA_DONE) csr_num_go <= 1'b0;
       end
   end // if
   end // always
   //-------------------------------------------------------
   // interrupt
   always @ (posedge CLK or negedge RESET_N) begin
   if (RESET_N==1'b0) begin
       csr_ctl_ie <= 1'b0; // bit-0
       csr_ctl_ip <= 1'b0; // bit-1
   end else begin
       if (bram_wr&&(bram_wr_addr==CSRA_CONTROL)) begin
           csr_ctl_ie <=  bram_wr_data[0];
           csr_ctl_ip <= (bram_wr_data[1]==1'b1) ? 1'b0 : csr_ctl_ip;
       end else begin
           if (csr_ctl_ie & DMA_GO & DMA_DONE)
               csr_ctl_ip <= 1'b1;
       end
   end // if
   end // always
   //-------------------------------------------------------
   assign IRQ = csr_ctl_ip;
   //-------------------------------------------------------
   assign DMA_EN = csr_ctl_en;
   assign DMA_GO = csr_ctl_en & csr_num_go;
   assign DMA_SRC = csr_source;
   assign DMA_DST = csr_dest;
   assign DMA_BNUM = csr_num_byte;
   assign DMA_CHUNK = csr_num_chunk;
   //-------------------------------------------------------
endmodule
//-------------------------------------------------------
// Revision History
//
// 2015.07.12: Started by Ando Ki 
//-------------------------------------------------------
