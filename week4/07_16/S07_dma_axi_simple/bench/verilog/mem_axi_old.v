//------------------------------------------------------------------------------
//  Copyright (c) 2024 by Future Design Systems.
//  http://www.future-ds.com
//------------------------------------------------------------------------------
// mem_axi.v
//------------------------------------------------------------------------------
// VERSION: 2024.07.15.
//------------------------------------------------------------------------------
// MACROS:
//    BURST_TYPE_WRAPP_ENABLED   - Burst wrapping type enabled
// PARAMETERS:
//    P_SIZE_IN_BYTES - size of memory in bytes
//------------------------------------------------------------------------------

module mem_axi
     #(parameter AXI_WIDTH_ID = 4 // ID width in bits
               , AXI_WIDTH_ADDR =32 // address width
               , AXI_WIDTH_DATA =32 // data width
               , AXI_WIDTH_STRB =(AXI_WIDTH_DATA/8)  // data strobe width
               , P_SIZE_IN_BYTES=1024)
(
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 axi_aresetn RST"  *) input  wire                      axi_aresetn,
    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axi:m_axil, ASSOCIATED_RESET axi_aresetn" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 axi_aclk CLK"     *) input  wire                      axi_aclk,
`ifndef __ICARUS__
    (* X_INTERFACE_PARAMETER = "CLK_DOMAIN axi_aclk,RUSER_WIDTH 0,WUSER_WIDTH 0,ARUSER_WIDTH 0,AWUSER_WIDTH 0,\
                                HAS_CACHE 0,HAS_LOCK 0,HAS_PROT 0,HAS_QOS 0,HAS_REGION 0" *)
`endif
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWID"    *) input  wire [AXI_WIDTH_ID-1:0]   s_axi_awid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR"  *) input  wire [AXI_WIDTH_ADDR-1:0] s_axi_awaddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWLEN"   *) input  wire [ 7:0]               s_axi_awlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWSIZE"  *) input  wire [ 2:0]               s_axi_awsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWBURST" *) input  wire [ 1:0]               s_axi_awburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input  wire                      s_axi_awvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output reg                       s_axi_awready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WID"     *) input  wire [AXI_WIDTH_ID-1:0]   s_axi_wid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA"   *) input  wire [AXI_WIDTH_DATA-1:0] s_axi_wdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB"   *) input  wire [AXI_WIDTH_STRB-1:0] s_axi_wstrb,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WLAST"   *) input  wire                      s_axi_wlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID"  *) input  wire                      s_axi_wvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY"  *) output reg                       s_axi_wready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BID"     *) output reg  [AXI_WIDTH_ID-1:0]   s_axi_bid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP"   *) output reg  [ 1:0]               s_axi_bresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID"  *) output reg                       s_axi_bvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY"  *) input  wire                      s_axi_bready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARID"    *) input  wire [AXI_WIDTH_ID-1:0]   s_axi_arid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR"  *) input  wire [AXI_WIDTH_ADDR-1:0] s_axi_araddr,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARLEN"   *) input  wire [ 7:0]               s_axi_arlen,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARSIZE"  *) input  wire [ 2:0]               s_axi_arsize,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARBURST" *) input  wire [ 1:0]               s_axi_arburst,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input  wire                      s_axi_arvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output reg                       s_axi_arready,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RID"     *) output reg  [AXI_WIDTH_ID-1:0]   s_axi_rid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA"   *) output reg  [AXI_WIDTH_DATA-1:0] s_axi_rdata,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP"   *) output reg  [ 1:0]               s_axi_rresp,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RLAST"   *) output reg                       s_axi_rlast,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID"  *) output reg                       s_axi_rvalid,
    (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY"  *) input  wire                      s_axi_rready
);
     //-------------------------------------------------------------------------
     localparam AXI_WIDTH_DSB=$clog2(AXI_WIDTH_STRB);// data strobe width
     localparam ADDR_LENGTH=$clog2(P_SIZE_IN_BYTES);
     //-------------------------------------------------------------------------
     reg  [ADDR_LENGTH-1:0]    Twaddr;
     reg  [AXI_WIDTH_DATA-1:0] Twdata;
     reg  [AXI_WIDTH_STRB-1:0] Twstrb;
     reg                       Twen  ;
     reg  [ADDR_LENGTH-1:0]    Traddr;
     wire [AXI_WIDTH_DATA-1:0] Trdata;
     reg  [AXI_WIDTH_STRB-1:0] Trstrb;
     reg                       Tren  ; // driven by stateR
     wire                      TrenX ; // actual Tren
     //-------------------------------------------------------------------------
     // write case
     //-------------------------------------------------------------------------
     reg  [AXI_WIDTH_ID-1:0]  AWID_reg   ;
     reg  [AXI_WIDTH_ADDR-1:0]  AWADDR_reg ;
     reg  [ 7:0]              AWLEN_reg  ;
     reg  [ 2:0]              AWSIZE_reg ;
     reg  [ 1:0]              AWBURST_reg;
     //-------------------------------------------------------------------------
     reg  [ADDR_LENGTH-1:0] addrW; // address of each transfer within a burst
     reg  [ 7:0]            beatW; // keeps num of transfers within a burst
     //-------------------------------------------------------------------------
     localparam STW_IDLE   = 'h0,
                STW_WRITE0 = 'h1,
                STW_WRITE  = 'h2,
                STW_RSP    = 'h3;
     reg [1:0] stateW=STW_IDLE;
     always @ (posedge axi_aclk or negedge axi_aresetn) begin
     if (axi_aresetn==1'b0) begin
         AWID_reg    <= 'h0;
         AWADDR_reg  <= 'h0;
         AWLEN_reg   <= 'h0;
         AWSIZE_reg  <= 'b0;
         AWBURST_reg <= 'b0;
         s_axi_awready     <= 1'b0;
         s_axi_wready      <= 1'b0;
         s_axi_bid         <=  'h0;
         s_axi_bresp       <= 2'b10; // SLAVE ERROR
         s_axi_bvalid      <= 1'b0;
         addrW       <=  'h0;
         beatW       <=  'h0;
         Twaddr      <=  'h0;
         Twdata      <=  'h0;
         Twstrb      <=  'h0;
         Twen        <= 1'b0;
         stateW      <= STW_IDLE;
     end else begin
         case (stateW)
         STW_IDLE: begin
             if ((s_axi_awvalid==1'b1)&&(s_axi_awready==1'b1)) begin
                  AWID_reg    <= s_axi_awid   ;
                  AWADDR_reg  <= s_axi_awaddr ;
                  AWLEN_reg   <= s_axi_awlen  ;
                  AWSIZE_reg  <= s_axi_awsize ;
                  AWBURST_reg <= s_axi_awburst;
                  s_axi_awready     <= 1'b0;
                  s_axi_wready      <= 1'b1;
                  s_axi_bresp       <= 2'b00; // OKAY
                  addrW       <= s_axi_awaddr[ADDR_LENGTH-1:0];
                  beatW       <=  'h0;
                  stateW      <= STW_WRITE0;
             end else begin
                  s_axi_awready <= 1'b1;
             end
             end // STW_IDLE
         STW_WRITE0: begin
             if (s_axi_wvalid==1'b1) begin
                 Twaddr <= addrW;
                 Twdata <= s_axi_wdata;
                 Twstrb <= s_axi_wstrb;
                 Twen   <= 1'b1;
                 beatW  <= beatW + 1;
                 addrW  <= get_next_addr_wr(addrW,AWSIZE_reg
                                           ,AWBURST_reg,AWLEN_reg);
                 if (beatW>=AWLEN_reg) begin
                     s_axi_wready <= 1'b0;
                     s_axi_bvalid <= 1'b1;
                     s_axi_bid    <= AWID_reg;
                     if (s_axi_wlast==1'b0) s_axi_bresp <= 2'b10; // SLVERR - missing last
                     stateW <= STW_RSP;
                 end else begin
                     stateW <= STW_WRITE;
                 end
                 if (s_axi_wid!=AWID_reg)
                     s_axi_bresp <= 2'b10; // SLVERR - ID mis-match occured
             end else begin
                 Twen   <= 1'b0;
             end
             end // STW_WRITE0
         STW_WRITE: begin
             if (s_axi_wvalid==1'b1) begin
                 Twaddr <= addrW;
                 Twdata <= s_axi_wdata;
                 Twstrb <= s_axi_wstrb;
                 Twen   <= 1'b1;
                 beatW  <= beatW + 1;
                 addrW  <= get_next_addr_wr(addrW,AWSIZE_reg
                                           ,AWBURST_reg,AWLEN_reg);
                 if (beatW>=AWLEN_reg) begin
                     s_axi_wready <= 1'b0;
                     s_axi_bvalid <= 1'b1;
                     s_axi_bid    <= AWID_reg;
                     if (s_axi_wlast==1'b0) s_axi_bresp <= 2'b10; // SLVERR - missing last
                     stateW <= STW_RSP;
                 end
                 if (s_axi_wid!=AWID_reg)
                     s_axi_bresp <= 2'b10; // SLVERR - ID mis-match occured
             end else begin
                 Twen   <= 1'b0;
             end
             end // STW_WRITE
         STW_RSP: begin
             Twen   <= 1'b0;
             if (s_axi_bready==1'b1) begin
                 s_axi_bvalid  <= 1'b0;
                 s_axi_awready <= 1'b1;
                 stateW  <= STW_IDLE;
             end
             end // STW_RSP
         endcase
     end // if
     end // always
     //-------------------------------------------------------------------------
     // read case
     //-------------------------------------------------------------------------
     reg  [AXI_WIDTH_ADDR-1:0]  ARADDR_reg ;
     reg  [ 7:0]          ARLEN_reg  ;
     reg  [ 2:0]          ARSIZE_reg ;
     reg  [ 1:0]          ARBURST_reg;
     //-------------------------------------------------------------------------
     reg  [AXI_WIDTH_DATA-1:0] dataR;
     reg  [ADDR_LENGTH-1:0]  addrR; // address of each transfer within a burst
     reg  [AXI_WIDTH_STRB-1:0] strbR; // strobe
     reg  [ 7:0]             beatR; // keeps num of transfers within a burst
     //-------------------------------------------------------------------------
     localparam STR_IDLE   = 'h0,
                STR_READ0  = 'h1,
                STR_READ1  = 'h2,
                STR_READ2  = 'h3,
                STR_READ21 = 'h4,
                STR_READ22 = 'h5,
                STR_READ3  = 'h6,
                STR_READ31 = 'h7,
                STR_READ32 = 'h8,
                STR_READ33 = 'h9,
                STR_READ34 = 'hA,
                STR_END    = 'hB;
     reg [3:0] stateR=STR_IDLE;
     always @ (posedge axi_aclk or negedge axi_aresetn) begin
     if (axi_aresetn==1'b0) begin
         ARADDR_reg  <= 'h0;
         ARLEN_reg   <= 'h0;
         ARSIZE_reg  <= 'b0;
         ARBURST_reg <= 'b0;
         s_axi_arready     <= 1'b0;
         s_axi_rid         <=  'h0;
         s_axi_rlast       <= 1'b0;
         s_axi_rresp       <= 2'b10; // SLAERROR
         s_axi_rdata       <=  'h0;
         s_axi_rvalid      <= 1'b0;
         dataR       <=  'h0;
         addrR       <=  'h0;
         strbR       <=  'h0;
         beatR       <=  'h0;
         Traddr      <=  'h0;
         Trstrb      <=  'h0;
         Tren        <= 1'b0;
         stateR      <= STR_IDLE;
     end else begin
         case (stateR)
         STR_IDLE: begin
             if ((s_axi_arvalid==1'b1)&&(s_axi_arready==1'b1)) begin
                  ARADDR_reg  <= s_axi_araddr ;
                  ARLEN_reg   <= s_axi_arlen  ;
                  ARSIZE_reg  <= s_axi_arsize ;
                  ARBURST_reg <= s_axi_arburst;
                  s_axi_arready     <= 1'b0;
                  s_axi_rid         <= s_axi_arid;
                  addrR       <= get_next_addr_rd(s_axi_araddr[ADDR_LENGTH-1:0]
                                                 ,s_axi_arsize,s_axi_arburst,s_axi_arlen);
                  beatR       <=  'h0;
                  Traddr      <= s_axi_araddr[ADDR_LENGTH-1:0];
                  Trstrb      <= get_strb(s_axi_araddr[ADDR_LENGTH-1:0],s_axi_arsize);
                  Tren        <= 1'b1;
                  stateR      <= STR_READ0;
             end else begin
                 s_axi_arready <= 1'b1;
             end
             end // STR_IDLE
         STR_READ0: begin // address only
             if (ARLEN_reg=='h0) begin // single beat burst
                 Tren   <= 1'b0;
                 stateR <= STR_READ1;
             end else if (ARLEN_reg=='h1) begin // two-beat burst
                 Tren   <= 1'b1;
                 Traddr <= addrR;
                 Trstrb <= get_strb(addrR,ARSIZE_reg);
                 stateR <= STR_READ2;
             end else begin // three or more beat burst
                 Tren   <= 1'b1;
                 Traddr <= addrR;
                 Trstrb <= get_strb(addrR,ARSIZE_reg);
                 addrR  <= get_next_addr_rd(addrR,ARSIZE_reg
                                           ,ARBURST_reg,ARLEN_reg);
                 beatR  <= 1;
                 stateR <= STR_READ3;
             end
             end // STR_READ0
         STR_READ1: begin // data only
             Tren   <= 1'b0;
             s_axi_rlast  <= 1'b1;
             s_axi_rdata  <= Trdata;
             s_axi_rresp  <= 2'b00;
             s_axi_rvalid <= 1'b1;
             stateR <= STR_END;
             end // STR_READ1
         STR_READ2: begin // two-beat burst
             Tren   <= 1'b0;
             s_axi_rlast  <= 1'b0;
             s_axi_rdata  <= Trdata;
             s_axi_rresp  <= 2'b00;
             s_axi_rvalid <= 1'b1;
             stateR <= STR_READ21;
             end // STR_READ2;
         STR_READ21: begin // two-beat burst
             if (s_axi_rready==1'b1) begin
                 Tren   <= 1'b0;
                 s_axi_rlast  <= 1'b1;
                 s_axi_rdata  <= Trdata;
                 s_axi_rresp  <= 2'b00;
                 s_axi_rvalid <= 1'b1;
                 stateR <= STR_END;
             end else begin
                 dataR   <= Trdata;
                 stateR  <= STR_READ22;
             end
             end // STR_READ21
         STR_READ22: begin // two-beat burst
             if (s_axi_rready==1'b1) begin
                 Tren   <= 1'b0;
                 s_axi_rlast  <= 1'b1;
                 s_axi_rdata  <= dataR ;
                 s_axi_rresp  <= 2'b00;
                 s_axi_rvalid <= 1'b1;
                 stateR <= STR_END;
             end
             end // STR_READ22
         STR_READ3: begin // n-beat burst
             s_axi_rlast  <= 1'b0;
             s_axi_rdata  <= Trdata;
             s_axi_rresp  <= 2'b00;
             s_axi_rvalid <= 1'b1;
             Tren   <= 1'b1;
             Traddr <= addrR;
             Trstrb <= get_strb(addrR,ARSIZE_reg);
             addrR  <= get_next_addr_rd(addrR,ARSIZE_reg
                                       ,ARBURST_reg,ARLEN_reg);
             beatR  <= beatR + 1;
             stateR <= STR_READ31;
             end // STR_READ3;
         STR_READ31: begin
             if (s_axi_rready==1'b1) begin
                 s_axi_rlast  <= 1'b0;
                 s_axi_rdata  <= Trdata;
                 s_axi_rresp  <= 2'b00;
                 s_axi_rvalid <= 1'b1;
                 if (beatR>=ARLEN_reg) begin
                    Tren   <= 1'b1; // actually RREADY determines it
                    Traddr <= addrR;
                    stateR <= STR_READ33;
                 end else begin
                    Tren   <= 1'b1;
                    Traddr <= addrR;
                    Trstrb <= get_strb(addrR,ARSIZE_reg);
                    addrR  <= get_next_addr_rd(addrR,ARSIZE_reg
                                              ,ARBURST_reg,ARLEN_reg);
                 end
                 beatR  <= beatR + 1;
             end else begin
                 Tren   <= 1'b1; // actually RREADY determines it
                 dataR  <= Trdata;
                 stateR <= STR_READ32;
             end
             end // STR_READ31
         STR_READ32: begin
             if (s_axi_rready==1'b1) begin
                 s_axi_rlast  <= 1'b0;
                 s_axi_rdata  <= dataR;
                 s_axi_rresp  <= 2'b00;
                 s_axi_rvalid <= 1'b1;
                 dataR  <= Trdata;
                 if (beatR>=ARLEN_reg) begin
                    Tren   <= 1'b0;
                    stateR <= STR_READ33;
                 end else begin
                    Tren   <= 1'b1; // actually RREADY determines it
                    Traddr <= addrR;
                    Trstrb <= get_strb(addrR,ARSIZE_reg);
                    addrR  <= get_next_addr_rd(addrR,ARSIZE_reg
                                              ,ARBURST_reg,ARLEN_reg);
                    stateR <= STR_READ31;
                 end
                 beatR  <= beatR + 1;
             end
             end // STR_READ32
         STR_READ33: begin
             if (s_axi_rready==1'b1) begin
                 Tren   <= 1'b0;
                 s_axi_rlast  <= 1'b1;
                 s_axi_rdata  <= Trdata;
                 s_axi_rresp  <= 2'b00;
                 s_axi_rvalid <= 1'b1;
                 stateR <= STR_END;
             end else begin
                 Tren   <= 1'b0;
                 dataR  <= Trdata;
                 stateR <= STR_READ34;
             end
             end // STR_READ33
         STR_READ34: begin
             if (s_axi_rready==1'b1) begin
                 Tren   <= 1'b0;
                 s_axi_rlast  <= 1'b1;
                 s_axi_rdata  <= dataR;
                 s_axi_rresp  <= 2'b00;
                 s_axi_rvalid <= 1'b1;
                 stateR <= STR_END;
             end
             end // STR_READ34
         STR_END: begin // data only
             Tren <= 1'b0;
             if (s_axi_rready==1'b1) begin
                 s_axi_rdata   <=  'h0;
                 s_axi_rresp   <= 2'b10; // SLVERR
                 s_axi_rlast   <= 1'b0;
                 s_axi_rvalid  <= 1'b0;
                 s_axi_arready <= 1'b1;
                 stateR  <= STR_IDLE;
             end
             end // STR_END
         endcase
     end // if
     end // always
     //-------------------------------------------------------------------------
     function [7:0] get_bytes;
     input [2:0] size;
          get_bytes = 1<<size;
     endfunction
     //-------------------------------------------------------------------------
     function [AXI_WIDTH_STRB-1:0] get_strb;
     input [ADDR_LENGTH-1:0] addr;
     input [ 2:0]            size;  // num. of byte to move: 0=1-byte, 1=2-byte
     reg   [AXI_WIDTH_STRB-1:0]    offset;
     begin
          offset = addr[AXI_WIDTH_DSB-1:0]; //offset = addr%AXI_WIDTH_DS;
          case (size)
          3'b000: get_strb = {  1{1'b1}}<<offset;
          3'b001: get_strb = {  2{1'b1}}<<offset;
          3'b010: get_strb = {  4{1'b1}}<<offset;
          3'b011: get_strb = {  8{1'b1}}<<offset;
          3'b100: get_strb = { 16{1'b1}}<<offset;
          3'b101: get_strb = { 32{1'b1}}<<offset;
          3'b110: get_strb = { 64{1'b1}}<<offset;
          3'b111: get_strb = {128{1'b1}}<<offset;
          endcase
     end
     endfunction
     //-------------------------------------------------------------------------
     function [ADDR_LENGTH-1:0] get_next_addr_wr;
     input [ADDR_LENGTH-1:0] addr ;
     input [ 2:0]            size ;
     input [ 1:0]            burst; // burst type
     input [ 7:0]            len  ; // burst length
     reg   [ADDR_LENGTH-AXI_WIDTH_DSB-1:0] naddr;
     reg   [ADDR_LENGTH-1:0] mask ;
     begin
          case (burst)
          2'b00: get_next_addr_wr = addr;
          2'b01: begin
                 if ((1<<size)<AXI_WIDTH_STRB) begin
                    get_next_addr_wr = addr + (1<<size);
                 end else begin
                     naddr = addr[ADDR_LENGTH-1:AXI_WIDTH_DSB];
                     naddr = naddr + 1;
                     get_next_addr_wr = {naddr,{AXI_WIDTH_DSB{1'b0}}};
                 end
                 end
          2'b10: begin
                 `ifdef BURST_TYPE_WRAPP_ENABLED
                 mask          = get_wrap_mask(size,len);
                 get_next_addr_wr = (addr&~mask)
                               | (((addr&mask)+(1<<size))&mask);
                 `else
                 // synopsys translate_off
                 $display($time,,"%m ERROR BURST WRAP not supported");
                 // synopsys translate_on
                 `endif
                 end
          2'b11: begin
                 get_next_addr_wr = addr;
                 // synopsys translate_off
                 $display($time,,"%m ERROR un-defined BURST %01x", burst);
                 // synopsys translate_on
                 end
          endcase
     end
     endfunction
     //-------------------------------------------------------------------------
     function [ADDR_LENGTH-1:0] get_next_addr_rd;
     input [ADDR_LENGTH-1:0] addr ;
     input [ 2:0]            size ;
     input [ 1:0]            burst; // burst type
     input [ 7:0]            len  ; // burst length
     reg   [ADDR_LENGTH-AXI_WIDTH_DSB-1:0] naddr;
     reg   [ADDR_LENGTH-1:0] mask ;
     begin
          case (burst)
          2'b00: get_next_addr_rd = addr;
          2'b01: begin
                 if ((1<<size)<AXI_WIDTH_STRB) begin
                    get_next_addr_rd = addr + (1<<size);
                 end else begin
                     naddr = addr[ADDR_LENGTH-1:AXI_WIDTH_DSB];
                     naddr = naddr + 1;
                     get_next_addr_rd = {naddr,{AXI_WIDTH_DSB{1'b0}}};
                 end
                 end
          2'b10: begin
                 `ifdef BURST_TYPE_WRAPP_ENABLED
                 mask          = get_wrap_mask(size,len);
                 get_next_addr_rd = (addr&~mask)
                               | (((addr&mask)+(1<<size))&mask);
                 `else
                 // synopsys translate_off
                 $display($time,,"%m ERROR BURST WRAP not supported");
                 // synopsys translate_on
                 `endif
                 end
          2'b11: begin
                 get_next_addr_rd = addr;
                 // synopsys translate_off
                 $display($time,,"%m ERROR un-defined BURST %01x", burst);
                 // synopsys translate_on
                 end
          endcase
     end
     endfunction
     //-------------------------------------------------------------------------
     `ifdef BURST_TYPE_WRAPP_ENABLED
     function [ADDR_LENGTH-1:0] get_wrap_mask;
     input [ 2:0]      size ;
     input [ 7:0]      len  ; // burst length
     begin
          case (size)
          3'b000: get_wrap_mask = (    len)-1;
          3'b001: get_wrap_mask = (  2*len)-1;
          3'b010: get_wrap_mask = (  4*len)-1;
          3'b011: get_wrap_mask = (  8*len)-1;
          3'b100: get_wrap_mask = ( 16*len)-1;
          3'b101: get_wrap_mask = ( 32*len)-1;
          3'b110: get_wrap_mask = ( 64*len)-1;
          3'b111: get_wrap_mask = (128*len)-1;
          endcase
     end
     endfunction
     `endif
     //-------------------------------------------------------------------------
     function integer clogb2;
     input [31:0] value;
     reg   [31:0] tmp;
     begin
        tmp = value - 1;
        for (clogb2 = 0; tmp > 0; clogb2 = clogb2 + 1) tmp = tmp >> 1;
     end
     endfunction
     //-------------------------------------------------------------------------
     assign TrenX = ((stateR==STR_READ31)||(stateR==STR_READ32))
                  ? s_axi_rready : Tren;
     //-------------------------------------------------------------------------
     generate
     genvar idx;
     for (idx=0; idx<AXI_WIDTH_STRB; idx=idx+1) begin : AXI_IDX
          mem_axi_core #(.WIDTH_AD(ADDR_LENGTH-AXI_WIDTH_DSB))
          u_mem_axi_core (
                .RESETn (axi_aresetn         )
              , .CLK    (axi_aclk                )
              , .WADDR  (Twaddr[ADDR_LENGTH-1:AXI_WIDTH_DSB])
              , .WDATA  (Twdata[8*idx+7:8*idx] )
              , .WEN    (Twen&Twstrb[idx]      )
              , .RADDR  (Traddr[ADDR_LENGTH-1:AXI_WIDTH_DSB])
              , .RDATA  (Trdata[8*idx+7:8*idx] )
              , .REN    (TrenX&Trstrb[idx]     )
          );
     end
     endgenerate
     //-----------------------------------------------------------
     // synthesis translate_off
     task write;
         input [AXI_WIDTH_ADDR-1:0] addr;
         input [AXI_WIDTH_DATA-1:0] data;
         input [AXI_WIDTH_STRB-1:0] be  ;

         reg   [AXI_WIDTH_ADDR-AXI_WIDTH_DSB-1:0] ta;
         integer idx;
     begin
           ta = addr[AXI_WIDTH_ADDR-1:AXI_WIDTH_DSB];
           if (be[0]) AXI_IDX[0].u_mem_axi_core.mem[ta] = data[(0*8) +: 8];
           for (idx=0; idx<AXI_WIDTH_STRB; idx=idx+1) begin
                //if (be[idx]) mem_axi.\AXI_IDX[0].u_mem_axi_core.mem[ta] = data[(idx*8) +: 8];
           end
     end
     endtask
     //-------------------------------------------------------------------------
     task read;
         input  [AXI_WIDTH_ADDR-1:0] addr;
         output [AXI_WIDTH_DATA-1:0] data;

         reg    [AXI_WIDTH_ADDR-AXI_WIDTH_DSB-1:0] ta  ;
         integer idx;
     begin
           ta = addr[AXI_WIDTH_ADDR-1:AXI_WIDTH_DSB];
           for (idx=0; idx<AXI_WIDTH_STRB; idx=idx+1) begin
                //data[(idx*8)+:8] = AXI_IDX[idx].u_mem_axi_core.mem[ta];
           end
     end
     endtask
     // synthesis translate_on
     //-------------------------------------------------------------------------
endmodule

//------------------------------------------------------------------------------
module mem_axi_core #(parameter WIDTH_AD=8)
(
       input  wire                 RESETn
     , input  wire                 CLK
     , input  wire [WIDTH_AD-1:0]  WADDR
     , input  wire [7:0]           WDATA
     , input  wire                 WEN
     , input  wire [WIDTH_AD-1:0]  RADDR
     , output reg  [7:0]           RDATA
     , input  wire                 REN
);
     //-------------------------------------------------------------------------
     localparam DEPTH = (1<<WIDTH_AD);
     //-------------------------------------------------------------------------
     (* ram_style = "block" , ramstyle="no_rw_check" *) reg [7:0] mem[0:DEPTH-1]; // synthesis syn_ramstyle="block_ram"; 
     //-------------------------------------------------------------------------
    `ifndef uuYYxx
     always @ (posedge CLK) begin
        if (WEN) mem[WADDR] <= WDATA;
     end
     always @ (posedge CLK) begin
        if (REN) RDATA <= mem[RADDR];
     end
    `else
     always @ (posedge CLK or negedge RESETn) begin
     if (RESETn==1'b0) begin
         RDATA <= 'h0;
     end else begin
         case ({WEN,REN})
         2'b01: RDATA <= mem[RADDR];
         2'b10: mem[WADDR] <= WDATA;
         2'b11: begin
                mem[WADDR] <= WDATA;
                if (RADDR==WADDR) begin
                    RDATA <= WDATA;
                end else begin
                    RDATA <= mem[RADDR];
                end
                end
         2'b00: RDATA <= 'h0;
         endcase
     end
     end
     `endif
     //-------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
// Revision History
//
// 2024.07.15: write()/read() tasks added.
// 2024.06.01: Started by Ando Ki (adki@future-ds.com)
//------------------------------------------------------------------------------
