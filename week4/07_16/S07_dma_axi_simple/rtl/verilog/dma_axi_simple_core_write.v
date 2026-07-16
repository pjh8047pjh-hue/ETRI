//----------------------------------------------------------
// Copyright (c) 2024 by Future Design Systems
// All right reserved.
//----------------------------------------------------------
// VERSION: 2024.06.10.
//----------------------------------------------------------
// DMA AXI simplified version
//----------------------------------------------------------
// Limitations:
//----------------------------------------------------------
module dma_axi_simple_core_write
     #(parameter AXI_WIDTH_ID =4         // ID width in bits
               , AXI_WIDTH_ADDR =32        // address width
               , AXI_WIDTH_DATA =32        // data width
               , AXI_WIDTH_STRB =(AXI_WIDTH_DATA/8) // data strobe width
               , FIFO_WIDTH   =AXI_WIDTH_STRB+AXI_WIDTH_DATA
               , FIFO_AW      =4
               , FIFO_DEPTH   =1<<FIFO_AW
               )
(
      input  wire                      aresetn
    , input  wire                      aclk
    , output reg  [AXI_WIDTH_ID-1:0]   axi_awid
    , output reg  [AXI_WIDTH_ADDR-1:0] axi_awaddr
    , output reg  [ 7:0]               axi_awlen
    , output reg  [ 2:0]               axi_awsize
    , output reg  [ 1:0]               axi_awburst
    , output reg                       axi_awvalid
    , input  wire                      axi_awready
    , output reg  [AXI_WIDTH_ID-1:0]   axi_wid
    , output reg  [AXI_WIDTH_DATA-1:0] axi_wdata
    , output reg  [AXI_WIDTH_STRB-1:0] axi_wstrb
    , output reg                       axi_wlast
    , output reg                       axi_wvalid
    , input  wire                      axi_wready
    , input  wire [AXI_WIDTH_ID-1:0]   axi_bid
    , input  wire [ 1:0]               axi_bresp
    , input  wire                      axi_bvalid
    , output reg                       axi_bready
     //-----------------------------------------------------------
     , input   wire            DMA_EN
     , input   wire            DMA_GO
     , output  reg             DMA_BUSY
     , output  reg             DMA_DONE
     , input   wire  [31:0]    DMA_DST
     , input   wire  [15:0]    DMA_BNUM // num of bytes to move
     , input   wire  [ 7:0]    DMA_CHUNK// num of bytes to move at a time
     //-----------------------------------------------------------
     , output  reg                    fifo_rd_rdy
     , input   wire                   fifo_rd_vld
     , input   wire  [FIFO_WIDTH-1:0] fifo_rd_dat
     , input   wire  [FIFO_AW:0]      fifo_items
);
   localparam AXI_WIDTH_DSB=$clog2(AXI_WIDTH_STRB); // data strobe width
   //-----------------------------------------------------
   reg  [31:0]              W_addr =32'h0;
   reg  [AXI_WIDTH_DSB:0]   W_size =  'h0; //1=1byte, 2=2byte, 4=4-byte, 8=8-byte
   reg  [ 8:0]              W_len  = 9'h0; //1=1beat, 2=2beat, ..
   reg  [15:0]              W_rem  =16'h0;
   reg  [15:0]              W_chunk=16'h0;
   reg  [15:0]              W_inc  =16'h0;
   reg                      W_go   = 1'b0;
   reg                      W_done = 1'b0;
   //-----------------------------------------------------
   localparam ST_READY     = 'h0
            , ST_MISALIGN  = 'h1
            , ST_ALIGN     = 'h2
            , ST_WRITE     = 'h3
            , ST_WRITE_DONE= 'h4;
   (* mark_debug="true" *) reg [2:0] state = ST_READY; // synthesis attribute keep of state is "true";
   //-----------------------------------------------------
   always @ (posedge aclk or negedge aresetn) begin
   if (aresetn==1'b0) begin
       DMA_BUSY <= 1'b0;
       DMA_DONE <= 1'b0;
       W_addr   <= 32'h0;
       W_size   <=   'h0; //1=1byte, 2=2byte, 4=4-byte, 8=8-byte
       W_len    <=  9'h0; //1=1beat, 2=2beat, ..
       W_rem    <= 16'h0;
       W_chunk  <= 16'h0;
       W_inc    <= 16'h0;
       W_go     <=  1'b0;
       state <= ST_READY;
   end else if (DMA_EN==1'b0) begin
       DMA_BUSY <= 1'b0;
       DMA_DONE <= 1'b0;
       W_addr   <= 32'h0;
       W_size   <=   'h0; //1=1byte, 2=2byte, 4=4-byte, 8=8-byte
       W_len    <=  9'h0; //1=1beat, 2=2beat, ..
       W_rem    <= 16'h0;
       W_chunk  <= 16'h0;
       W_inc    <= 16'h0;
       W_go     <=  1'b0;
       state <= ST_READY;
   end else begin
   case (state)
   ST_READY: begin
      if (DMA_GO==1'b0) DMA_DONE <= 1'b0;
      if ((DMA_DONE==1'b0)&& // wait until end of previous one
          (fifo_rd_vld==1'b1)&& // wait until DMA read starts
          (DMA_GO==1'b1)&&(DMA_BNUM!=0)) begin
          DMA_BUSY  <=  1'b1;
          DMA_DONE  <=  1'b0;
          W_addr    <= DMA_DST;
          W_size    <=   'h0; //1=1byte, 2=2byte, ..
          W_len     <=  9'h0; //1=1beat, 2=2beat, ..
          W_rem     <= DMA_BNUM;
          W_go      <=  1'b0;
          if (DMA_BNUM<=AXI_WIDTH_STRB) begin
              W_chunk   <= DMA_BNUM;
          end else if (DMA_CHUNK<=AXI_WIDTH_STRB) begin
              W_chunk   <= AXI_WIDTH_STRB;
          end else begin
              W_chunk   <= {DMA_CHUNK[7:AXI_WIDTH_DSB],{AXI_WIDTH_DSB{1'b0}}};
          end
          if (|DMA_DST[AXI_WIDTH_DSB-1:0]) begin // mis-aligned start
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
      if (W_rem<(AXI_WIDTH_STRB-W_addr[AXI_WIDTH_DSB-1:0])) begin
           W_size <= 1; // byte access
           W_len  <= 'h1;
           W_inc  <= 1; // W_size*W_len
           W_go   <= 1'b1;
           state  <= ST_WRITE;
      end else begin
           //              |<-  AXI_WIDTH_STRB ->|
           //              +----+----+----+----+
           //              |DDDD|DDDD|DDDD|    |
           //              +----+----+----+----+
           //                          /|\
           //                           |
           //                      addr[AXI_WIDTH_DSB-1:0]
           //W_size <= AXI_WIDTH_STRB-W_addr[AXI_WIDTH_DSB-1:0];
           W_size <= AXI_WIDTH_STRB; // note length 1, partial access
           W_len  <=  'h1;
           W_inc  <= AXI_WIDTH_STRB-W_addr[AXI_WIDTH_DSB-1:0]; // W_size*W_len
           W_go   <= 1'b1;
           state  <= ST_WRITE;
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
      if (W_rem>=W_chunk) begin
          // as large as a chunk
          W_size <= AXI_WIDTH_STRB;
          W_len  <= W_chunk[15:AXI_WIDTH_DSB];
          W_inc  <= (AXI_WIDTH_STRB*W_chunk[15:AXI_WIDTH_DSB]); // W_size*W_len
          W_go   <= 1'b1;
          state  <= ST_WRITE;
      end else begin
          if (W_rem[15:AXI_WIDTH_DSB]) begin
              // how many lines
              W_size <= AXI_WIDTH_STRB;
              W_len  <= W_rem[15:AXI_WIDTH_DSB];
              W_inc  <= (AXI_WIDTH_STRB*W_rem[15:AXI_WIDTH_DSB]); // W_size*W_len
              W_go   <= 1'b1;
              state  <= ST_WRITE;
          end else begin
              // as small as a line
              //              |<-  AXI_WIDTH_STRB ->|
              //              +----+----+----+----+
              //              |    |    |DDDD|DDDD|
              //              +----+----+----+----+
              //                               /|\
              //                                |
              //                           addr[AXI_WIDTH_DSB-1:0]
              W_size <=  'h1;
              W_len  <=  'h1;
              W_inc  <=  'h1;
              W_go   <= 1'b1;
              state  <= ST_WRITE;
          end
      end
      end // ST_ALIGN
   ST_WRITE: begin
      if (W_done==1'b1) begin
          W_go   <= 1'b0;
          W_addr <= W_addr + W_inc;
          W_rem  <= W_rem  - W_inc;
          state  <= ST_WRITE_DONE;
      end
      end // ST_WRITE
   ST_WRITE_DONE: begin
      if (W_done==1'b0) begin
          if (|W_rem) begin
              if (|W_addr[AXI_WIDTH_DSB-1:0]) begin // mis-aligned start
                  state <= ST_MISALIGN;
              end else begin // aligned start
                  state <= ST_ALIGN;
              end
          end else begin
              DMA_DONE  <= 1'b1;
              state  <= ST_READY;
          end
      end
      end // ST_WRITE_DONE
   endcase
   end // if
   end // always
   //-------------------------------------------------------
   reg  [ 8:0] W_cnt= 9'h0; //1=1beat, 2=2beat, ..
   //-------------------------------------------------------
   localparam SW_IDLE = 'h0
            , SW_ARB  = 'h1
            , SW_WR   = 'h2
            , SW_BR   = 'h3
            , SW_DONE = 'h4;
   reg [2:0] state_write=SW_IDLE; // synthesis attribute keep of state_write is "true";
   always @ (posedge aclk or negedge aresetn) begin
   if (aresetn==0) begin
       axi_awid     <= 'h0;
       axi_awaddr   <= 'h0;
       axi_awlen    <= 'h0;
       axi_awsize   <= 'h0;
       axi_awburst  <= 'h1; // incremental
       axi_awvalid  <= 'h0;
       axi_wid      <= 'h0;
       axi_wstrb    <= 'h0;
       axi_bready   <= 'b0;
       W_cnt        <= 9'h0;
       state_write<= SW_IDLE;
   end else if (DMA_EN==0) begin
       axi_awid     <= 'h0;
       axi_awaddr   <= 'h0;
       axi_awlen    <= 'h0;
       axi_awsize   <= 'h0;
       axi_awburst  <= 'h1; // incremental
       axi_awvalid  <= 'h0;
       axi_wid      <= 'h0;
       axi_wstrb    <= 'h0;
       axi_bready   <= 'b0;
       W_cnt        <= 9'h0;
       state_write<= SW_IDLE;
   end else begin // if (aresetn==0) begin
   case (state_write)
   SW_IDLE: begin
      if (W_go==1'b1) begin
          axi_awaddr   <= W_addr;
          axi_awlen    <= W_len - 1;
          case (W_size)
          'd1:  axi_awsize <= 'h0;
          'd2:  axi_awsize <= 'h1;
          'd4:  axi_awsize <= 'h2;
          'd8:  axi_awsize <= 'h3;
          'd16: axi_awsize <= 'h4;
          default: axi_awsize <= 'h0;
          endcase
          axi_awvalid   <= 1'b1;
          state_write <= SW_ARB;
      end
      end // SW_IDLE
   SW_ARB: begin
      if (axi_awready) begin
          axi_awvalid  <= 1'b0;
          W_cnt        <= 9'h1;
          axi_wid      <= axi_awid;
          axi_wstrb    <= get_strb(W_addr[AXI_WIDTH_DSB-1:0],W_size);
          state_write  <= SW_WR;
      end
      end // SW_ARB
   SW_WR: begin
      if (axi_wvalid&axi_wready) begin
          W_cnt <= W_cnt + 1;
          if (W_cnt>=W_len) begin
               axi_bready    <= 1'b1;
               state_write <= SW_BR;
          end
      end
      end // SW_WR
   SW_BR: begin
      if (axi_bvalid) begin
          axi_bready    <= 1'b0;
          W_done      <= 1'b1;
          state_write <= SW_DONE;
          // synthesis translate_off
          if (axi_bid[AXI_WIDTH_ID-1:0]!==axi_awid) begin
              $display("%m ERROR BID mis-match.");
          end
          if (axi_bresp!=2'b0) begin
              $display("%m ERROR BRESP not-OK.");
          end
          // synthesis translate_on
      end
      end // SW_BR
   SW_DONE: begin
      if (W_go==1'b0) begin
          W_done      <= 1'b0;
          axi_awid    <= axi_awid + 1;
          state_write <= SW_IDLE;
      end
      end // SW_DONE
   endcase
   end // if
   end // always
   //---------------------------------------------------------
   always @ ( * ) begin
     //fifo_rd_rdy = (state_write==SW_WR);
       fifo_rd_rdy = (state_write==SW_WR) & fifo_rd_vld & axi_wready;
       axi_wdata     = fifo_rd_dat;
     //axi_wvalid    = (state_write==SW_WR) & fifo_rd_rdy & fifo_rd_vld;
       axi_wvalid    = (state_write==SW_WR) & fifo_rd_vld;
       axi_wlast     = (state_write==SW_WR) & (W_cnt==W_len);
   end
   //---------------------------------------------------------
   function  [AXI_WIDTH_STRB-1:0] get_strb;
       input [AXI_WIDTH_DSB-1:0] addr;
       input [AXI_WIDTH_DSB:0]   size;
   begin
       if (AXI_WIDTH_DATA==32) begin
          case ({size[2:0],addr[1:0]})
          `ifdef ENDIAN_BIG
          `else // little-endian -- default
          5'b001_00: get_strb = 4'b0001; // byte
          5'b001_01: get_strb = 4'b0010; // byte
          5'b001_10: get_strb = 4'b0100; // byte
          5'b001_11: get_strb = 4'b1000; // byte

          5'b010_00: get_strb = 4'b0011; // halfword
          5'b010_01: get_strb = 4'b0010; // halfword
          5'b010_10: get_strb = 4'b1100; // halfword
          5'b010_11: get_strb = 4'b1000; // halfword

          5'b100_00: get_strb = 4'b1111; // word
          5'b100_01: get_strb = 4'b1110; // word
          5'b100_10: get_strb = 4'b1100; // word
          5'b100_11: get_strb = 4'b1000; // word
          `endif
          default:  get_strb = {4{1'b1}};
          endcase
       end else if (AXI_WIDTH_DATA==64) begin
          case ({size[3:0],addr[2:0]})
          `ifdef ENDIAN_BIG
          `else // little-endian -- default
          7'b0001_000: get_strb = 8'b0000_0001; // byte
          7'b0001_001: get_strb = 8'b0000_0010; // byte
          7'b0001_010: get_strb = 8'b0000_0100; // byte
          7'b0001_011: get_strb = 8'b0000_1000; // byte
          7'b0001_100: get_strb = 8'b0001_0000; // byte
          7'b0001_101: get_strb = 8'b0010_0000; // byte
          7'b0001_110: get_strb = 8'b0100_0000; // byte
          7'b0001_111: get_strb = 8'b1000_0000; // byte

          7'b0010_000: get_strb = 8'b0000_0011; // halfword
          7'b0010_001: get_strb = 8'b0000_0010; // halfword
          7'b0010_010: get_strb = 8'b0000_1100; // halfword
          7'b0010_011: get_strb = 8'b0000_1000; // halfword
          7'b0010_100: get_strb = 8'b0011_0000; // halfword
          7'b0010_101: get_strb = 8'b0010_0000; // halfword
          7'b0010_110: get_strb = 8'b1100_0000; // halfword
          7'b0010_111: get_strb = 8'b1000_0000; // halfword

          7'b0100_000: get_strb = 8'b0000_1111; // word
          7'b0100_001: get_strb = 8'b0000_1110; // word
          7'b0100_010: get_strb = 8'b0000_1100; // word
          7'b0100_011: get_strb = 8'b0000_1000; // word
          7'b0100_100: get_strb = 8'b1111_0000; // word
          7'b0100_101: get_strb = 8'b1110_0000; // word
          7'b0100_110: get_strb = 8'b1100_0000; // word
          7'b0100_111: get_strb = 8'b1000_0000; // word

          7'b1000_000: get_strb = 8'b1111_1111; // double-word
          7'b1000_001: get_strb = 8'b1111_1110; // double-word
          7'b1000_010: get_strb = 8'b1111_1100; // double-word
          7'b1000_011: get_strb = 8'b1111_1000; // double-word
          7'b1000_100: get_strb = 8'b1111_0000; // double-word
          7'b1000_101: get_strb = 8'b1110_0000; // double-word
          7'b1000_100: get_strb = 8'b1100_0000; // double-word
          7'b1000_101: get_strb = 8'b1000_0000; // double-word
          `endif
          default:  get_strb = {8{1'b1}};
          endcase
       end else if (AXI_WIDTH_DATA==128) begin
          case ({size[4:0],addr[3:0]})
          `ifdef ENDIAN_BIG
          `else // little-endian -- default
          9'b0_0001_0000: get_strb = 16'b0000_0000_0000_0001; // byte
          9'b0_0001_0001: get_strb = 16'b0000_0000_0000_0010; // byte
          9'b0_0001_0010: get_strb = 16'b0000_0000_0000_0100; // byte
          9'b0_0001_0011: get_strb = 16'b0000_0000_0000_1000; // byte
          9'b0_0001_0100: get_strb = 16'b0000_0000_0001_0000; // byte
          9'b0_0001_0101: get_strb = 16'b0000_0000_0010_0000; // byte
          9'b0_0001_0110: get_strb = 16'b0000_0000_0100_0000; // byte
          9'b0_0001_0111: get_strb = 16'b0000_0000_1000_0000; // byte
          9'b0_0001_1000: get_strb = 16'b0000_0001_0000_0000; // byte
          9'b0_0001_1001: get_strb = 16'b0000_0010_0000_0000; // byte
          9'b0_0001_1010: get_strb = 16'b0000_0100_0000_0000; // byte
          9'b0_0001_1011: get_strb = 16'b0000_1000_0000_0000; // byte
          9'b0_0001_1100: get_strb = 16'b0001_0000_0000_0000; // byte
          9'b0_0001_1101: get_strb = 16'b0010_0000_0000_0000; // byte
          9'b0_0001_1110: get_strb = 16'b0100_0000_0000_0000; // byte
          9'b0_0001_1111: get_strb = 16'b1000_0000_0000_0000; // byte

          9'b0_0010_0000: get_strb = 16'b0000_0000_0000_0011; // halfword
          9'b0_0010_0001: get_strb = 16'b0000_0000_0000_0010; // halfword
          9'b0_0010_0010: get_strb = 16'b0000_0000_0000_1100; // halfword
          9'b0_0010_0011: get_strb = 16'b0000_0000_0000_1000; // halfword
          9'b0_0010_0100: get_strb = 16'b0000_0000_0011_0000; // halfword
          9'b0_0010_0101: get_strb = 16'b0000_0000_0010_0000; // halfword
          9'b0_0010_0110: get_strb = 16'b0000_0000_1100_0000; // halfword
          9'b0_0010_0111: get_strb = 16'b0000_0000_1000_0000; // halfword
          9'b0_0010_1000: get_strb = 16'b0000_0011_0000_0000; // halfword
          9'b0_0010_1001: get_strb = 16'b0000_0010_0000_0000; // halfword
          9'b0_0010_1010: get_strb = 16'b0000_1100_0000_0000; // halfword
          9'b0_0010_1011: get_strb = 16'b0000_1000_0000_0000; // halfword
          9'b0_0010_1100: get_strb = 16'b0011_0000_0000_0000; // halfword
          9'b0_0010_1101: get_strb = 16'b0010_0000_0000_0000; // halfword
          9'b0_0010_1110: get_strb = 16'b1100_0000_0000_0000; // halfword
          9'b0_0010_1111: get_strb = 16'b1000_0000_0000_0000; // halfword

          9'b0_0100_0000: get_strb = 16'b0000_0000_0000_1111; // word
          9'b0_0100_0001: get_strb = 16'b0000_0000_0000_1110; // word
          9'b0_0100_0010: get_strb = 16'b0000_0000_0000_1100; // word
          9'b0_0100_0011: get_strb = 16'b0000_0000_0000_1000; // word
          9'b0_0100_0100: get_strb = 16'b0000_0000_1111_0000; // word
          9'b0_0100_0101: get_strb = 16'b0000_0000_1110_0000; // word
          9'b0_0100_0110: get_strb = 16'b0000_0000_1100_0000; // word
          9'b0_0100_0111: get_strb = 16'b0000_0000_1000_0000; // word
          9'b0_0100_1000: get_strb = 16'b0000_1111_0000_0000; // word
          9'b0_0100_1001: get_strb = 16'b0000_1110_0000_0000; // word
          9'b0_0100_1010: get_strb = 16'b0000_1100_0000_0000; // word
          9'b0_0100_1011: get_strb = 16'b0000_1000_0000_0000; // word
          9'b0_0100_1100: get_strb = 16'b1111_0000_0000_0000; // word
          9'b0_0100_1101: get_strb = 16'b1110_0000_0000_0000; // word
          9'b0_0100_1110: get_strb = 16'b1100_0000_0000_0000; // word
          9'b0_0100_1111: get_strb = 16'b1000_0000_0000_0000; // word

          9'b0_1000_0000: get_strb = 16'b0000_0000_1111_1111; // double-word
          9'b0_1000_0001: get_strb = 16'b0000_0000_1111_1110; // double-word
          9'b0_1000_0010: get_strb = 16'b0000_0000_1111_1100; // double-word
          9'b0_1000_0011: get_strb = 16'b0000_0000_1111_1000; // double-word
          9'b0_1000_0100: get_strb = 16'b0000_0000_1111_0000; // double-word
          9'b0_1000_0101: get_strb = 16'b0000_0000_1110_0000; // double-word
          9'b0_1000_0110: get_strb = 16'b0000_0000_1100_0000; // double-word
          9'b0_1000_0111: get_strb = 16'b0000_0000_1000_0000; // double-word
          9'b0_1000_1000: get_strb = 16'b1111_1111_0000_0000; // double-word
          9'b0_1000_1001: get_strb = 16'b1111_1110_0000_0000; // double-word
          9'b0_1000_1010: get_strb = 16'b1111_1100_0000_0000; // double-word
          9'b0_1000_1011: get_strb = 16'b1111_1000_0000_0000; // double-word
          9'b0_1000_1100: get_strb = 16'b1111_0000_0000_0000; // double-word
          9'b0_1000_1101: get_strb = 16'b1110_0000_0000_0000; // double-word
          9'b0_1000_1110: get_strb = 16'b1100_0000_0000_0000; // double-word
          9'b0_1000_1111: get_strb = 16'b1000_0000_0000_0000; // double-word

          9'b1_0000_0000: get_strb = 16'b1111_1111_1111_1111; // quad-word
          9'b1_0000_0001: get_strb = 16'b1111_1111_1111_1110; // quad-word
          9'b1_0000_0010: get_strb = 16'b1111_1111_1111_1100; // quad-word
          9'b1_0000_0011: get_strb = 16'b1111_1111_1111_1000; // quad-word
          9'b1_0000_0100: get_strb = 16'b1111_1111_1111_0000; // quad-word
          9'b1_0000_0101: get_strb = 16'b1111_1111_1110_0000; // quad-word
          9'b1_0000_0110: get_strb = 16'b1111_1111_1100_0000; // quad-word
          9'b1_0000_0111: get_strb = 16'b1111_1111_1000_0000; // quad-word
          9'b1_0000_1000: get_strb = 16'b1111_1111_0000_0000; // quad-word
          9'b1_0000_1001: get_strb = 16'b1111_1110_0000_0000; // quad-word
          9'b1_0000_1010: get_strb = 16'b1111_1100_0000_0000; // quad-word
          9'b1_0000_1011: get_strb = 16'b1111_1000_0000_0000; // quad-word
          9'b1_0000_1100: get_strb = 16'b1111_0000_0000_0000; // quad-word
          9'b1_0000_1101: get_strb = 16'b1110_0000_0000_0000; // quad-word
          9'b1_0000_1110: get_strb = 16'b1100_0000_0000_0000; // quad-word
          9'b1_0000_1111: get_strb = 16'b1000_0000_0000_0000; // quad-word
          `endif
          default:  get_strb = {16{1'b1}};
          endcase
       end else begin
           // synopsys translate_off
           $display($time,,"%m ERROR %d-bit data-width not supported yet", AXI_WIDTH_DATA);
           // synopsys translate_on
       end
   end
   endfunction
   //-----------------------------------------------------------
endmodule
//----------------------------------------------------------
// Revision history
//
// 2024.06.19: Rewritten.
// 2019.11.02: bug-fixed - to deal with delayed M_WREADY
//       fifo_rd_rdy and M_WVALID
// 2015.07.12: Started by Ando Ki.
//----------------------------------------------------------
