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
`ifdef AMBA_APB4
`ifndef AMBA_APB3
ERROR AMBA_APB3 shouldb edefined when AMBA_APB4 is defined
`endif
`endif

module mem_apb
     #(parameter SIZE_IN_BYTES = 1024  // memory size in bytes
     ,           DELAY         = 0     // access delay if required
     )
(
       (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
       (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 PRESETn RST" *) input  wire         PRESETn
     , (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF S_APB, ASSOCIATED_RESET PRESETn" *)
       (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PCLK CLK" *) input  wire         PCLK
     , (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF S_APB, ASSOCIATED_RESET PRESETn, CLK_DOMAIN PCLK" *)
       (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSEL" *) input  wire           S_APB_PSEL
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PENABLE" *) input  wire        S_APB_PENABLE
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PADDR" *) input  wire [31:0]   S_APB_PADDR
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWRITE" *) input  wire         S_APB_PWRITE
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWDATA" *) input  wire [31:0]  S_APB_PWDATA
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PRDATA" *) output reg  [31:0]  S_APB_PRDATA
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PREADY" *) output reg          S_APB_PREADY
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSLVERR" *) output reg         S_APB_PSLVERR
     , (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSTRB" *) input  wire [ 3:0]   S_APB_PSTRB
);
    //----------------------------------------------------
    localparam DEPTH = 256; // 1024 / 4의 값 
    localparam ST_IDLE = 2'b00;
    localparam ST_WR   = 2'b01;

    reg [1:0] cstate, nstate;
    reg [7:0] mem0[0:DEPTH-1];
    reg [7:0] mem1[0:DEPTH-1];
    reg [7:0] mem2[0:DEPTH-1];
    reg [7:0] mem3[0:DEPTH-1];

    wire access = S_APB_PSEL & S_APB_PENABLE;
    wire transfer_done = access & S_APB_PREADY;

    // current state logic
    always @(posedge PCLK or negedge PRESETn) begin
      if(!PRESETn) cstate <= ST_IDLE;
      else  cstate <= nstate;
    end
    
    // next state logic
    always @(*) begin
      S_APB_PRDATA  = 32'd0;
      S_APB_PREADY  = 0;
      S_APB_PSLVERR = 0;
      
      if ((PRESETn == 1'b1) && (S_APB_PSEL == 1'b1)) 

      case (cstate)
        ST_IDLE: begin
          if(transfer_done == 1) nstate = ST_WR;
          else nstate = ST_IDLE;
        end
      
        ST_WR: begin
          if(S_APB_PWRITE == 1) begin
            if (S_APB_PSTRB[0] == 1'b1) mem0 <= S_APB_PWDATA[ 7: 0];
            if (S_APB_PSTRB[1] == 1'b1) mem1 <= S_APB_PWDATA[15: 8];
            if (S_APB_PSTRB[2] == 1'b1) mem2 <= S_APB_PWDATA[23:16];
            if (S_APB_PSTRB[3] == 1'b1) mem3 <= S_APB_PWDATA[31:24];
          end
        end

        
        default: 
      endcase


    end


    // output state login


    //----------------------------------------------------
endmodule

//--------------------------------------------------------
// Revision history
//
// 2020.07.11: Started by Ando Ki (adki@future-ds.com)
//--------------------------------------------------------
