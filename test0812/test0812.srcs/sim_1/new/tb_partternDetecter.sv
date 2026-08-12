`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/12 11:43:59
// Design Name: 
// Module Name: tb_partternDetecter
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


module tb_partternDetecter();

logic clk, rstn, data;
logic flag;

always #10 clk = ~clk;

patternDetecter dut1 (.clk(clk), .rstn(rstn), .data(data), .flag(flag));

initial begin
    clk = 0;
    rstn = 1;
    data = 0;
    
    repeat(5) @(posedge clk); rstn <= 0;
    @(posedge clk); rstn <= 1;
    
    @(posedge clk); data <= 0;
    @(posedge clk); data <= 1;
    @(posedge clk); data <= 1;
    @(posedge clk); data <= 0;
    @(posedge clk); data <= 0;
    @(posedge clk); data <= 1;
    
    @(posedge clk); data <= 1;
    @(posedge clk); data <= 0;
    @(posedge clk); data <= 0;
    @(posedge clk); data <= 1;
    @(posedge clk); data <= 0;
    
end

endmodule
