//-----------------------------------------------------------------------------
// Copyright (c) 2022 by Future Design Systems.
// All right reserved.
//------------------------------------------------------------------------------
// VERSION: 2022.08.01.
//------------------------------------------------------------------------------
module dma_axi_simple_axi_lite_if
     #(parameter T_ADDR_WID=8)
(
       input  wire           s_axi_aresetn
     , input  wire           s_axi_aclk
     , input  wire   [31:0]  s_axi_awaddr
     , input  wire           s_axi_awvalid
     , output reg            s_axi_awready
     , input  wire   [31:0]  s_axi_wdata
     , input  wire           s_axi_wvalid
     , output reg            s_axi_wready
     , output reg    [ 1:0]  s_axi_bresp
     , output reg            s_axi_bvalid
     , input  wire           s_axi_bready
     , input  wire   [31:0]  s_axi_araddr
     , input  wire           s_axi_arvalid
     , output reg            s_axi_arready
     , output reg    [31:0]  s_axi_rdata
     , output reg    [ 1:0]  s_axi_rresp
     , output reg            s_axi_rvalid
     , input  wire           s_axi_rready
     , output reg                      bram_wr
     , output reg    [T_ADDR_WID-1:0]  bram_wr_addr
     , output reg    [31:0]            bram_wr_data
     , output reg                      bram_rd
     , output reg    [T_ADDR_WID-1:0]  bram_rd_addr
     , input  wire   [31:0]            bram_rd_data
);
     //-------------------------------------------------------------------------
     // write case
     //------------------------------------------------------------------------------
     // CSR access signals
     //             __    __    __    __    __
     // clk      __|  |__|  |__|  |__|  |__|  |
     //                               _____
     // wr_addr  XXXXXXXXXXXXXXXXXXXXX_____XXX
     //                               _____
     // wr       ____________________|     |__
     //                               _____
     // wr_data  XXXXXXXXXXXXXXXXXXXXX_____XXXX
     //-------------------------------------------------------------------------
     localparam STW_READY  = 'h0,
                STW_ARB    = 'h1,
                STW_WRITE  = 'h2,
                STW_RSP    = 'h3;
     reg [1:0] stateW=STW_READY; // synthesis attribute keep of stateW is "true";
     always @ (posedge s_axi_aclk or negedge s_axi_aresetn) begin
     if (s_axi_aresetn==1'b0) begin
         s_axi_awready <= 1'b0;
         s_axi_wready  <= 1'b0;
         s_axi_bresp   <= 2'b10; // SLAVE ERROR
         s_axi_bvalid  <= 1'b0;
         bram_wr       <= 1'b0;
         bram_wr_addr  <=  'b0;
         bram_wr_data  <=  'b0;
         stateW        <= STW_READY;
     end else begin
         case (stateW)
         STW_READY: begin
             if ((s_axi_awvalid==1'b1)&&(s_axi_awready==1'b1)) begin
                  s_axi_awready <= 1'b0;
                  s_axi_bresp   <= 2'b00; // OKAY
                  bram_wr_addr  <= s_axi_awaddr[T_ADDR_WID-1:0];
                  s_axi_wready  <= 1'b1;
                  stateW        <= STW_WRITE;
             end else begin
                  s_axi_awready <= 1'b1;
             end
             end // STW_READY
         STW_WRITE: begin
             if (s_axi_wvalid==1'b1) begin
                 s_axi_wready <= 1'b0;
                 s_axi_bresp  <= 2'b00;
                 s_axi_bvalid <= 1'b1;
                 bram_wr_data <= s_axi_wdata;
                 bram_wr      <= 1'b1;
                 stateW       <= STW_RSP;
             end
             end // STW_WRITE
         STW_RSP: begin
             bram_wr  <= 1'b0;
             if (s_axi_bready==1'b1) begin
                 s_axi_bvalid  <= 1'b0;
                 s_axi_bresp   <= 2'b10; // SLAVE ERROR
                 s_axi_awready <= 1'b1;
                 stateW        <= STW_READY;
             end
             end // STW_RSP
         default: begin
             s_axi_awready <= 1'b0;
             s_axi_wready  <= 1'b0;
             s_axi_bresp   <= 2'b10; // SLAVE ERROR
             s_axi_bvalid  <= 1'b0;
             bram_wr       <= 1'b0;
             bram_wr_addr  <=  'b0;
             bram_wr_data  <=  'b0;
             stateW        <= STW_READY;
             end
         endcase
     end // if
     end // always
     //-------------------------------------------------------------------------
     // synthesis translate_off
     reg  [8*10-1:0] stateW_ascii = "READY";
     always @ (stateW) begin
     case (stateW)
         STW_READY : stateW_ascii="READY ";
         STW_WRITE : stateW_ascii="WRITE ";
         STW_RSP   : stateW_ascii="RSP   ";
         default   : stateW_ascii="ERROR ";
     endcase
     end
     // synthesis translate_on
     //-------------------------------------------------------------------------
     // read case
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
     //-------------------------------------------------------------------------
     localparam STR_READY= 'h0
              , STR_ARB  = 'h1
              , STR_READ0= 'h2
              , STR_READ1= 'h3
              , STR_END  = 'h4;
     reg [2:0] stateR=STR_READY; // synthesis attribute keep of stateR is "true";
     always @ (posedge s_axi_aclk or negedge s_axi_aresetn) begin
     if (s_axi_aresetn==1'b0) begin
         s_axi_arready <= 1'b0;
         s_axi_rresp   <= 2'b10; // SLAERROR
         s_axi_rdata   <=  'h0;
         s_axi_rvalid  <= 1'b0;
         bram_rd       <= 1'b0;
         bram_rd_addr  <=  'b0;
         stateR        <= STR_READY;
     end else begin
         case (stateR)
         STR_READY: begin
             if ((s_axi_arvalid==1'b1)&&(s_axi_arready==1'b1)) begin
                  s_axi_arready <= 1'b0;
                  bram_rd_addr  <= s_axi_araddr[T_ADDR_WID-1:0];
                  bram_rd       <= 1'b1;
                  stateR        <= STR_READ0;
             end else begin
                 s_axi_arready <= 1'b1;
             end
             end // STR_READY
         STR_READ0: begin // address only
             bram_rd <= 1'b0;
             stateR  <= STR_READ1;
             end // STR_READ0
         STR_READ1: begin // data only
             s_axi_rdata  <= bram_rd_data;
             s_axi_rresp  <= 2'b00;
             s_axi_rvalid <= 1'b1;
             stateR <= STR_END;
             end // STR_READ1
         STR_END: begin // data only
             if (s_axi_rready==1'b1) begin
                 s_axi_rdata    <=  'h0;
                 s_axi_rresp    <= 2'b10; // SLVERR
                 s_axi_rvalid   <= 1'b0;
                 s_axi_arready  <= 1'b1;
                 stateR   <= STR_READY;
             end
             end // STR_END
         default: begin
             s_axi_arready     <= 1'b0;
             s_axi_rresp       <= 2'b10; // SLAERROR
             s_axi_rdata       <=  'h0;
             s_axi_rvalid      <= 1'b0;
             bram_rd       <= 1'b0;
             bram_rd_addr  <=  'b0;
             stateR      <= STR_READY;
             end
         endcase
     end // if
     end // always
     //-------------------------------------------------------------------------
     // synthesis translate_off
     reg  [8*10-1:0] stateR_ascii = "READY";
     always @ (stateR) begin
     case (stateR)
         STR_READY : stateR_ascii="READY";
         STR_READ0 : stateR_ascii="READ0";
         STR_READ1 : stateR_ascii="READ1";
         STR_END   : stateR_ascii="END  ";
         default   : stateW_ascii="ERROR";
     endcase
     end
     // synthesis translate_on
     //-------------------------------------------------------------------------
endmodule
//------------------------------------------------------------------------------
// Revision history
//
// 2022.08.01: Started by Ando Ki.
//------------------------------------------------------------------------------
