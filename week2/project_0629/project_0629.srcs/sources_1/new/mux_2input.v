`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/30 11:07:41
// Design Name: 
// Module Name: mux_2input
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


module mux_2input(
    output reg [3:0] q,
    input [3:0] a, b,  
    input sel
    );

always @(*) begin
    if (sel == 1'b0) begin
        q = a;
    end
    else if (sel == 1'b1) begin
        q = b;
    end
    else begin
        q = 4'b0000;
    end
end
endmodule
