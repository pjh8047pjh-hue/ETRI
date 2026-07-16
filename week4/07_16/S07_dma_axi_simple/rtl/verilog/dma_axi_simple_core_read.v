//----------------------------------------------------------
// Copyright (c) 2024 by Future Design Systems Co., Ltd.
// All right reserved.
//----------------------------------------------------------
// VERSION: 2024.06.10.
//----------------------------------------------------------
// DMA AXI simplified version
//----------------------------------------------------------
// Limitations:
//----------------------------------------------------------
module dma_axi_simple_core_read
     #(parameter AXI_WIDTH_ID =4         // ID width in bits
               , AXI_WIDTH_ADDR =32        // address width
               , AXI_WIDTH_DATA =32        // data width
               , AXI_WIDTH_STRB =(AXI_WIDTH_DATA/8) // data strobe width
               , FIFO_WIDTH   =AXI_WIDTH_STRB+AXI_WIDTH_DATA
               , FIFO_AW      =4
               , FIFO_DEPTH   =(1<<FIFO_AW))
(
      input  wire                      aresetn
    , input  wire                      aclk
    , output reg  [AXI_WIDTH_ID-1:0]   axi_arid
    , output reg  [AXI_WIDTH_ADDR-1:0] axi_araddr
    , output reg  [ 7:0]               axi_arlen
    , output reg  [ 2:0]               axi_arsize
    , output reg  [ 1:0]               axi_arburst
    , output reg                       axi_arvalid
    , input  wire                      axi_arready
    , input  wire [AXI_WIDTH_ID-1:0]   axi_rid
    , input  wire [AXI_WIDTH_DATA-1:0] axi_rdata
    , input  wire [ 1:0]               axi_rresp
    , input  wire                      axi_rlast
    , input  wire                      axi_rvalid
    , output reg                       axi_rready
     //-----------------------------------------------------------
     , input   wire            DMA_EN
     , input   wire            DMA_GO
     , output  reg             DMA_BUSY
     , output  reg             DMA_DONE
     , input   wire  [31:0]    DMA_SRC
     , input   wire  [15:0]    DMA_BNUM // num of bytes to move
     , input   wire  [ 7:0]    DMA_CHUNK// num of bytes to move at a time
     //-----------------------------------------------------------
     , input   wire                   fifo_wr_rdy
     , output  reg                    fifo_wr_vld
     , output  reg   [FIFO_WIDTH-1:0] fifo_wr_dat
     , input   wire                   fifo_empty
     , input   wire  [FIFO_AW:0]      fifo_rooms
);
   localparam AXI_WIDTH_DSB=$clog2(AXI_WIDTH_STRB); // data strobe width
   //-----------------------------------------------------
   reg  [31:0]              R_addr =32'h0;
   reg  [AXI_WIDTH_DSB:0]   R_size =  'h0; //1=1byte, 2=2byte, 4=4-byte, 8=8-byte
   reg  [ 8:0]              R_len  = 9'h0; //1=1beat, 2=2beat, ..
   reg  [15:0]              R_rem  =16'h0;
   reg  [15:0]              R_chunk=16'h0;
   reg  [15:0]              R_inc  =16'h0; //actually moved in a beat
   reg                      R_go   = 1'b0;
   reg                      R_done = 1'b0;
   //-----------------------------------------------------
   localparam ST_READY    = 'h0
            , ST_MISALIGN = 'h1
            , ST_ALIGN    = 'h2
            , ST_READ     = 'h3
            , ST_READ_DONE= 'h4;
   (* mark_debug="true" *) reg [2:0] state = ST_READY; // synthesis attribute keep of state is "true";
   //-----------------------------------------------------
   always @ (posedge aclk or negedge aresetn) begin
   if (aresetn==1'b0) begin
       DMA_BUSY <= 1'b0;
       DMA_DONE <= 1'b0;
       R_addr   <= 32'h0;
       R_size   <=   'h0; //1=1byte, 2=2byte, 4=4-byte, 8=8-byte
       R_len    <=  9'h0; //1=1beat, 2=2beat, ..
       R_rem    <= 16'h0;
       R_chunk  <= 16'h0;
       R_inc    <= 16'h0;
       R_go     <=  1'b0;
       state    <= ST_READY;
   end else if (DMA_EN==1'b0) begin
       DMA_BUSY <= 1'b0;
       DMA_DONE <= 1'b0;
       R_addr   <= 32'h0;
       R_size   <=   'h0; //1=1byte, 2=2byte, ..
       R_len    <=  9'h0; //1=1beat, 2=2beat, ..
       R_rem    <= 16'h0;
       R_chunk  <= 16'h0;
       R_inc    <= 16'h0;
       R_go     <=  1'b0;
       state    <= ST_READY;
   end else begin
   case (state)
   ST_READY: begin
      if (DMA_GO==1'b0) DMA_DONE <= 1'b0;
      if ((DMA_DONE==1'b0)&& // wait until end of previous one
          (fifo_empty==1'b1)&& // wait until end of DMA write
          (DMA_GO==1'b1)&&(DMA_BNUM!=0)) begin
          DMA_BUSY  <=  1'b1;
          DMA_DONE  <=  1'b0;
          R_go      <=  1'b0;
          R_addr    <= DMA_SRC;
          R_size    <=   'h0; //1=1byte, 2=2byte, ..
          R_len     <=  9'h0; //1=1beat, 2=2beat, ..
          R_rem     <= DMA_BNUM;
          if (DMA_BNUM<=AXI_WIDTH_STRB) begin
              R_chunk   <= DMA_BNUM;
          end else if (DMA_CHUNK<=AXI_WIDTH_STRB) begin
              R_chunk   <= AXI_WIDTH_STRB;
          end else begin
              if (DMA_CHUNK[7:AXI_WIDTH_DSB]>FIFO_DEPTH) begin
                  R_chunk   <= {FIFO_DEPTH,{AXI_WIDTH_DSB{1'b0}}};
              end else begin
                  R_chunk   <= {DMA_CHUNK[7:AXI_WIDTH_DSB],{AXI_WIDTH_DSB{1'b0}}};
              end
          end
          if (|DMA_SRC[AXI_WIDTH_DSB-1:0]) begin // mis-aligned start
              state <= ST_MISALIGN;
          end else begin // aligned start
              state <= ST_ALIGN;
          end
      end
      end // ST_READY
   ST_MISALIGN: begin
      //              |<-  AXI_WIDTH_STRB ->|
      //              +----+----+----+----+
      //              |    |DDDD|DDDD|    |
      //              +----+----+----+----+
      //                          /|\
      //                           |
      //                      addr[AXI_WIDTH_DSB-1:0]
      //
      if (R_rem<(AXI_WIDTH_STRB-R_addr[AXI_WIDTH_DSB-1:0])) begin
           R_size <= 1; // byte access
           R_len  <=  'h1;
           R_inc  <= 16'h1; // R_size*R_len
           R_go   <= 1'b1;
           state  <= ST_READ;
      end else begin
           //              |<-  AXI_WIDTH_STRB ->|
           //              +----+----+----+----+
           //              |DDDD|DDDD|DDDD|    |
           //              +----+----+----+----+
           //                          /|\
           //                           |
           //                      addr[AXI_WIDTH_DSB-1:0]
           //R_size <= AXI_WIDTH_STRB-R_addr[AXI_WIDTH_DSB-1:0];
           R_size <= AXI_WIDTH_STRB; // note length 1, partial access
           R_len  <=  'h1;
           R_inc  <= AXI_WIDTH_STRB-R_addr[AXI_WIDTH_DSB-1:0]; // R_size*R_len
           R_go   <= 1'b1;
           state  <= ST_READ;
      end
      end // ST_MISALIGN
   ST_ALIGN: begin
      //              |<-  AXI_WIDTH_STRB ->|
      //              +----+----+----+----+
      //              |    |    |    |    |
      //              +----+----+----+----+
      //                               /|\
      //                                |
      //                           addr[AXI_WIDTH_DSB-1:0]
      //
      if (R_rem>=R_chunk) begin
          // as large as a chunk
          R_size <= AXI_WIDTH_STRB;
          R_len  <= R_chunk[15:AXI_WIDTH_DSB];
          R_inc  <= (AXI_WIDTH_STRB*R_chunk[15:AXI_WIDTH_DSB]); // R_size*R_len
          R_go   <= 1'b1;
          state  <= ST_READ;
      end else begin
          if (R_rem[15:AXI_WIDTH_DSB]) begin
              // how many lines
              R_size <= AXI_WIDTH_STRB;
              R_len  <= R_rem[15:AXI_WIDTH_DSB];
              R_inc  <= (AXI_WIDTH_STRB*R_rem[15:AXI_WIDTH_DSB]); // R_size*R_len
              R_go   <= 1'b1;
              state  <= ST_READ;
          end else begin
              // as small as a line
              //              |<-  AXI_WIDTH_STRB ->|
              //              +----+----+----+----+
              //              |    |    |DDDD|DDDD|
              //              +----+----+----+----+
              //                               /|\
              //                                |
              //                           addr[AXI_WIDTH_DSB-1:0]
              R_size <=  'h1;
              R_len  <=  'h1;
              R_inc  <=  'h1;
              R_go   <= 1'b1;
              state  <= ST_READ;
          end
      end
      end // ST_ALIGN
   ST_READ: begin
      if (R_done==1'b1) begin
          R_go   <= 1'b0;
          R_addr <= R_addr + R_inc;
          R_rem  <= R_rem  - R_inc;
          state  <= ST_READ_DONE;
      end
      end // ST_READ
   ST_READ_DONE: begin
      if (R_done==1'b0) begin
          if (|R_rem) begin
              if (|R_addr[AXI_WIDTH_DSB-1:0]) begin // mis-aligned start
                  state <= ST_MISALIGN;
              end else begin // aligned start
                  state <= ST_ALIGN;
              end
          end else begin
              DMA_DONE <= 1'b1;
              DMA_BUSY <= 1'b0;
              state    <= ST_READY;
          end
      end
      end // ST_READ_DONE
   endcase
   end // if
   end // always
   //-------------------------------------------------------
   reg  [ 8:0]             R_cnt=9'h0;
   //-------------------------------------------------------
   localparam SR_IDLE = 'h0
            , SR_ARB  = 'h1
            , SR_RD   = 'h2
            , SR_DONE = 'h3;
   reg [1:0] state_read=SR_IDLE; // synthesis attribute keep of state_read is "true";
   //-------------------------------------------------------
   always @ (posedge aclk or negedge aresetn) begin
   if (aresetn==0) begin
       axi_arid     <=  'h0;
       axi_araddr   <=  'h0;
       axi_arlen    <=  'h0;
       axi_arsize   <=  'h0;
       axi_arburst  <=  'h1; // incremental
       axi_arvalid  <= 1'b0;
       R_done     <= 1'b0;
       R_cnt      <= 9'h0;
       state_read <= SR_IDLE;
   end else if (DMA_EN==0) begin
       axi_arid     <=  'h0;
       axi_araddr   <=  'h0;
       axi_arlen    <=  'h0;
       axi_arsize   <=  'h0;
       axi_arburst  <=  'h1; // incremental
       axi_arvalid  <= 1'b0;
       R_done     <= 1'b0;
       R_cnt      <= 9'h0;
       state_read <= SR_IDLE;
   end else begin // if (aresetn==0) begin
   case (state_read)
   SR_IDLE: begin
      if (R_go==1'b1) begin
          axi_araddr   <= R_addr;
          axi_arlen    <= R_len - 1;
          case (R_size)
          'd1:  axi_arsize <= 'h0;
          'd2:  axi_arsize <= 'h1;
          'd4:  axi_arsize <= 'h2;
          'd8:  axi_arsize <= 'h3;
          'd16: axi_arsize <= 'h4;
          default: axi_arsize <= 'h0;
          endcase
          axi_arvalid  <= 1'b1;
          state_read <= SR_ARB;
      end
      end // SR_IDLE
   SR_ARB: begin
      if (axi_arready) begin
          axi_arvalid  <= 1'b0;
          R_cnt      <= 9'h1;
          state_read <= SR_RD;
      end
      end // SR_ARB
   SR_RD: begin
      if (axi_rvalid&axi_rready&fifo_wr_rdy&fifo_wr_vld) begin
          R_cnt <= R_cnt + 1;
          if (R_cnt>=R_len) begin
               R_done     <= 1'b1;
               state_read <= SR_DONE;
               // synthesis translate_off
               if (axi_rlast!=1'b1) begin
                   $display($time,,"%m RLAST not driven");
               end
               if (axi_rid!==axi_arid) begin
                   $display($time,,"%m RID mismatch");
               end
               if (axi_rresp!==2'b0) begin
                   $display($time,,"%m RRESP not-OK.");
               end
               // synthesis translate_on
          end
      end
      end // SR_RD
   SR_DONE: begin
      if (R_go==1'b0) begin
          R_done     <= 1'b0;
          axi_arid   <= axi_arid+1;
          state_read <= SR_IDLE;
      end
      end // SR_DONE
   endcase
   end // if (aresetn==0) begin
   end // always
   //-------------------------------------------------------
   always @ ( * ) axi_rready = (state_read==SR_RD) && fifo_wr_rdy;
   always @ ( * ) fifo_wr_vld = (state_read==SR_RD) && axi_rvalid;
   always @ ( * ) fifo_wr_dat = axi_rdata;
   //-----------------------------------------------------------
endmodule
//----------------------------------------------------------
// Revision history
//
// 2024.06.19: Rewritten.
// 2015.07.12: Started by Ando Ki.
//----------------------------------------------------------
