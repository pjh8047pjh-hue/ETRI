 //-----------------------------------------------------------------------------
 // Copyright (c) 2023 by Ando Ki.
 // All right reserved.
 // 
 // http://www.future-ds.com
 // adki@future-ds.com
 //-----------------------------------------------------------------------------
`timescale 1ns/1ps

`ifndef NET_DELAY
`define NET_DELAY  #(0.1)
`endif

module top ;
    localparam AXI_WIDTH_ID = 4 // ID width in bits
             , AXI_WIDTH_ADDR =32 // address width
             , AXI_WIDTH_DATA =32 // data width
             , AXI_WIDTH_STRB =(AXI_WIDTH_DATA/8)  // data strobe width
             , P_SIZE_IN_BYTES=1024;
    //--------------------------------------------------------------------------
    localparam integer CLK_FREQ_MHZ=100;
    localparam real CLOCK_FREQ =CLK_FREQ_MHZ*1_000_000;
    localparam real CLOCK_HALF =(1_000_000_000.0/CLOCK_FREQ/2.0);
    //--------------------------------------------------------------------------
    reg  axi_aresetn=1'b0;
    reg  axi_aclk=1'b0; always #(CLOCK_HALF) axi_aclk = ~axi_aclk;
    //--------------------------------------------------------------------------
    wire [AXI_WIDTH_ID-1:0]   `NET_DELAY s_axi_awid   ;
    wire [AXI_WIDTH_ADDR-1:0] `NET_DELAY s_axi_awaddr ;
    wire [ 7:0]               `NET_DELAY s_axi_awlen  ;
    wire [ 2:0]               `NET_DELAY s_axi_awsize ;
    wire [ 1:0]               `NET_DELAY s_axi_awburst;
    wire                      `NET_DELAY s_axi_awvalid;
    wire                      `NET_DELAY s_axi_awready;
    wire [AXI_WIDTH_ID-1:0]   `NET_DELAY s_axi_wid    ;
    wire [AXI_WIDTH_DATA-1:0] `NET_DELAY s_axi_wdata  ;
    wire [AXI_WIDTH_STRB-1:0] `NET_DELAY s_axi_wstrb  ;
    wire                      `NET_DELAY s_axi_wlast  ;
    wire                      `NET_DELAY s_axi_wvalid ;
    wire                      `NET_DELAY s_axi_wready ;
    wire [AXI_WIDTH_ID-1:0]   `NET_DELAY s_axi_bid    ;
    wire [ 1:0]               `NET_DELAY s_axi_bresp  ;
    wire                      `NET_DELAY s_axi_bvalid ;
    wire                      `NET_DELAY s_axi_bready ;
    wire [AXI_WIDTH_ID-1:0]   `NET_DELAY s_axi_arid   ;
    wire [AXI_WIDTH_ADDR-1:0] `NET_DELAY s_axi_araddr ;
    wire [ 7:0]               `NET_DELAY s_axi_arlen  ;
    wire [ 2:0]               `NET_DELAY s_axi_arsize ;
    wire [ 1:0]               `NET_DELAY s_axi_arburst;
    wire                      `NET_DELAY s_axi_arvalid;
    wire                      `NET_DELAY s_axi_arready;
    wire [AXI_WIDTH_ID-1:0]   `NET_DELAY s_axi_rid    ;
    wire [AXI_WIDTH_DATA-1:0] `NET_DELAY s_axi_rdata  ;
    wire [ 1:0]               `NET_DELAY s_axi_rresp  ;
    wire                      `NET_DELAY s_axi_rlast  ;
    wire                      `NET_DELAY s_axi_rvalid ;
    wire                      `NET_DELAY s_axi_rready ;
    //--------------------------------------------------------------------------
    mem_axi #(.AXI_WIDTH_ID   (AXI_WIDTH_ID   )
             ,.AXI_WIDTH_ADDR (AXI_WIDTH_ADDR )
             ,.AXI_WIDTH_DATA (AXI_WIDTH_DATA )
             ,.AXI_WIDTH_STRB (AXI_WIDTH_STRB )
             ,.P_SIZE_IN_BYTES(P_SIZE_IN_BYTES))
    u_mem_axi (
          .axi_aresetn   ( ... )
        , .axi_aclk      ( ... )
        , .s_axi_awid    ( ... )
        , .s_axi_awaddr  ( ... )
        , .s_axi_awlen   ( ... )
        , .s_axi_awsize  ( ... )
        , .s_axi_awburst ( ... )
        , .s_axi_awvalid ( ... )
        , .s_axi_awready ( ... )
        , .s_axi_wid     ( ... )
        , .s_axi_wdata   ( ... )
        , .s_axi_wstrb   ( ... )
        , .s_axi_wlast   ( ... )
        , .s_axi_wvalid  ( ... )
        , .s_axi_wready  ( ... )
        , .s_axi_bid     ( ... )
        , .s_axi_bresp   ( ... )
        , .s_axi_bvalid  ( ... )
        , .s_axi_bready  ( ... )
        , .s_axi_arid    ( ... )
        , .s_axi_araddr  ( ... )
        , .s_axi_arlen   ( ... )
        , .s_axi_arsize  ( ... )
        , .s_axi_arburst ( ... )
        , .s_axi_arvalid ( ... )
        , .s_axi_arready ( ... )
        , .s_axi_rid     ( ... )
        , .s_axi_rdata   ( ... )
        , .s_axi_rresp   ( ... )
        , .s_axi_rlast   ( ... )
        , .s_axi_rvalid  ( ... )
        , .s_axi_rready  ( ... )
    );
    //--------------------------------------------------------------------------
    bfm_axi #(.WIDTH_ID(AXI_WIDTH_ID)
             ,.WIDTH_AD(AXI_WIDTH_ADDR)
             ,.WIDTH_DA(AXI_WIDTH_DATA))
    u_bfm (
          .aresetn       ( ... )
        , .aclk          ( ... )
        , .m_axi_awid    ( ... )
        , .m_axi_awaddr  ( ... )
        , .m_axi_awlen   ( ... )
        , .m_axi_awlock  ( ... )
        , .m_axi_awsize  ( ... )
        , .m_axi_awburst ( ... )
        , .m_axi_awvalid ( ... )
        , .m_axi_awready ( ... )
        , .m_axi_wid     ( ... )
        , .m_axi_wdata   ( ... )
        , .m_axi_wstrb   ( ... )
        , .m_axi_wlast   ( ... )
        , .m_axi_wvalid  ( ... )
        , .m_axi_wready  ( ... )
        , .m_axi_bid     ( ... )
        , .m_axi_bresp   ( ... )
        , .m_axi_bvalid  ( ... )
        , .m_axi_bready  ( ... )
        , .m_axi_arid    ( ... )
        , .m_axi_araddr  ( ... )
        , .m_axi_arlen   ( ... )
        , .m_axi_arlock  ( ... )
        , .m_axi_arsize  ( ... )
        , .m_axi_arburst ( ... )
        , .m_axi_arvalid ( ... )
        , .m_axi_arready ( ... )
        , .m_axi_rid     ( ... )
        , .m_axi_rdata   ( ... )
        , .m_axi_rresp   ( ... )
        , .m_axi_rlast   ( ... )
        , .m_axi_rvalid  ( ... )
        , .m_axi_rready  ( ... )
    );
    //--------------------------------------------------------------------------
   initial begin
       axi_aresetn = 0;
       axi_aclk    = 0;
       repeat (5) @ (posedge axi_aclk);
       axi_aresetn = 1;
       repeat (5) @ (posedge axi_aclk);
       wait (u_bfm.DONE==1'b1);
       repeat (10) @ (posedge axi_aclk);
       $finish;
   end
   initial begin
       $dumpfile("wave.vcd");
       $dumpvars(0);
   end
endmodule
