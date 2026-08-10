`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2026 10:28:01 PM
// Design Name: 
// Module Name: selector
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


module selector #(
    parameter WIDTH = 8,
    parameter CHUNK = 4
)(
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    input sel_a,
    input sel_b,
    output [CHUNK-1:0] data_a,
    output [CHUNK-1:0] data_b
    );

assign data_a = sel_a ? a[WIDTH-1:CHUNK] : a[CHUNK-1:0];
assign data_b = sel_b ? b[WIDTH-1:CHUNK] : b[CHUNK-1:0];

endmodule

