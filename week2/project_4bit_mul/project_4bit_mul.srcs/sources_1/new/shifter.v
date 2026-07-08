`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/30 13:42:55
// Design Name: 
// Module Name: shifter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module shifter(
    input [7:0] inp,
    input [1:0] shift_cntrl,
    output reg [15:0] shift_out
    );

    always @(*) begin

        case(shift_cntrl)
            2'b01: shift_out = inp << 4;
            2'b10: shift_out = inp << 8;
            default: shift_out = inp;
        endcase

    end
endmodule
