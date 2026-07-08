`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/02 12:59:30
// Design Name: 
// Module Name: tb_counter
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


module tb_counter();

    wire led;
    reg clk_in, rst;

    counter dut (.clk_in(clk_in), .rst(rst), .led(led));

    initial begin
        clk_in = 0;
        forever #10 clk_in = ~clk_in;
    end

    
endmodule
