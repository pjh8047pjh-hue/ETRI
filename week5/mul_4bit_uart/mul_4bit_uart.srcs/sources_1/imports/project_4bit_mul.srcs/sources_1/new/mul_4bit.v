`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2026 10:33:54 PM
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


module mul_4bit #(
    parameter WIDTH = 8,
    parameter CHUNK = 4
)(
    input [CHUNK-1:0] data_a, 
    input [CHUNK-1:0] data_b,
    output [2*CHUNK-1:0] mul_init
    );

assign mul_init = data_a * data_b; 

endmodule
