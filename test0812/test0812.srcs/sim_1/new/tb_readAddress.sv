`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/12 12:01:08
// Design Name: 
// Module Name: tb_readAddress
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


module tb_readAddress();
    
   
logic clk, rst, start;
logic [4:0] addr;

always #10 clk = ~clk;

readAddress dut1(.rst(rst), .start(start), .clk(clk), .addr(addr));

initial begin
    clk = 0;
    rst = 0;
    start = 0;
    
    repeat(5) @(posedge clk); rst <= 1;
    @(posedge clk); rst <= 0;
    
    @(posedge clk); start <= 1;
    repeat(100) @(posedge clk); start <= 0;
    
end

endmodule
