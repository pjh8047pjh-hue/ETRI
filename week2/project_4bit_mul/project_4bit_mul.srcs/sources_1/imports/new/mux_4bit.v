`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/30 10:58:09
// Design Name: 
// Module Name: mux_4bit
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

module mux_4bit(
    output reg [3:0] q,
    input      [3:0] a, b, c, d,
    input      [1:0] sel
);

always @(*) begin
    case (sel)
        2'b00: q = a;
        2'b01: q = b;
        2'b10: q = c;
        2'b11: q = d;
        default: q = 4'b0000;
    endcase
end

endmodule