`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/30 13:58:23
// Design Name: 
// Module Name: mul_4bit
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


module mul_4bit(
    input [8:0] a, b,
    output reg [15:0] result
    );

always @(posedge clk) begin
    //일의 자리 수를 곱하고 1이면 1, 0이면 0이 나오도록 만듦
    result [0] = a[0] * b[0];
    result [1] = a[1] * b[1];
    result [2] = a[1] * b[1];
    
end
    
    
endmodule
