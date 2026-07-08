//--------------------------------------------------------
// Copyright (c) 2020 by Ando Ki.
// All right reserved.
//
// http://www.future-ds.com
// adki@future-ds.com
//--------------------------------------------------------
// mem_apb.h
//--------------------------------------------------------
// VERSION = 2020.07.11.
//--------------------------------------------------------
// Macros and parameters:
//     SIZE_IN_BYTES: Size of memory in bytes
//     DELAY:         The number of clocks until PREADY
//--------------------------------------------------------
`timescale 1ns/1ns
`ifdef AMBA4
`ifndef AMBA3
ERROR AMBA3 shouldb edefined when AMBA4 is defined
`endif
`endif

module mem_apb4
     #(parameter SIZE_IN_BYTES = 1024  // memory size in bytes
     ,           DELAY         = 0     // access delay if required
     )
(
       (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
       (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 PRESETn RST" *) input  wire         PRESETn
     , (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF S_APB, ASSOCIATED_RESET PRESETn" *)
       (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PCLK CLK" *) input  wire         PCLK
     , (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF S_APB, ASSOCIATED_RESET PRESETn, CLK_DOMAIN PCLK" *)
       (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSEL" *) input  wire         S_APB_PSEL
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PENABLE" *) input  wire         S_APB_PENABLE
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PADDR" *) input  wire [31:0]  S_APB_PADDR
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWRITE" *) input  wire         S_APB_PWRITE
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWDATA" *) input  wire [31:0]  S_APB_PWDATA
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PRDATA" *) output reg  [31:0]  S_APB_PRDATA
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PREADY" *) output reg          S_APB_PREADY
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSLVERR" *) output reg          S_APB_PSLVERR
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSTRB" *) input  wire [ 3:0]  S_APB_PSTRB
);

     //---------------------------------------------------

     //---------------------------------------------------
     localparam ADD_WIDTH  = clogb2(SIZE_IN_BYTES),
                ADD_OFFSET = clogb2(32/8),
                ADD_NEW    = ADD_WIDTH - ADD_OFFSET,
                DEPTH_NEW  = 1 << ADD_NEW;

     reg [7:0] mem0[0:DEPTH_NEW-1];
     reg [7:0] mem1[0:DEPTH_NEW-1];
     reg [7:0] mem2[0:DEPTH_NEW-1];
     reg [7:0] mem3[0:DEPTH_NEW-1];

     wire [ADD_NEW-1:0] local_add = S_APB_PADDR[ADD_WIDTH-1:ADD_OFFSET];
     //---------------------------------------------------
     reg [31:0] cntDly = 'h1; // delay counter

     localparam ST_IDLE  = 'h0,
                ST_DELAY = 'h1;

     reg state = ST_IDLE;

     wire access        = S_APB_PSEL & S_APB_PENABLE;
     wire access_ready  = (state == ST_DELAY) ? (cntDly >= DELAY)
                                               : ((DELAY == 0) || !access);
     wire transfer_done = access & access_ready;

     always @(*) begin
          S_APB_PREADY  = PRESETn ? access_ready : 1'b1;
          S_APB_PSLVERR = 1'b0;
     end

     always @(*) begin
          S_APB_PRDATA = ~32'h0;

          if ((PRESETn == 1'b1) && (S_APB_PSEL == 1'b1) && (S_APB_PWRITE == 1'b0)) begin
               S_APB_PRDATA[ 7: 0] = mem0[local_add];
               S_APB_PRDATA[15: 8] = mem1[local_add];
               S_APB_PRDATA[23:16] = mem2[local_add];
               S_APB_PRDATA[31:24] = mem3[local_add];
          end
     end

     always @(posedge PCLK or negedge PRESETn) begin
          if (PRESETn == 1'b0) begin
               cntDly <= 'h1;
               state  <= ST_IDLE;
          end else begin
               if (transfer_done && (S_APB_PWRITE == 1'b1)) begin
                    if (S_APB_PSTRB[0] == 1'b1) mem0[local_add] <= S_APB_PWDATA[ 7: 0];
                    if (S_APB_PSTRB[1] == 1'b1) mem1[local_add] <= S_APB_PWDATA[15: 8];
                    if (S_APB_PSTRB[2] == 1'b1) mem2[local_add] <= S_APB_PWDATA[23:16];
                    if (S_APB_PSTRB[3] == 1'b1) mem3[local_add] <= S_APB_PWDATA[31:24];
               end

               case (state)
               ST_IDLE: begin
                    if (access && !access_ready) begin
                         cntDly <= 'h1;
                         state  <= ST_DELAY;
                    end
               end // ST_IDLE

               ST_DELAY: begin
                    if (!access || access_ready) begin
                         cntDly <= 'h1;
                         state  <= ST_IDLE;
                    end else begin
                         cntDly <= cntDly + 1;
                    end
               end // ST_DELAY
               endcase
          end // if
     end // always
     //---------------------------------------------------
     function integer clogb2;
          input [31:0] value;
          reg   [31:0] tmp, rt;
     begin
          tmp = value - 1;
          for (rt = 0; tmp > 0; rt = rt + 1) tmp = tmp >> 1;
          clogb2 = rt;
     end
     endfunction
     //---------------------------------------------------
endmodule

//--------------------------------------------------------
// Revision history
//
// 2020.07.11: Started by Ando Ki (adki@future-ds.com)
//--------------------------------------------------------
