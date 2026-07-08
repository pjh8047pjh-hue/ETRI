`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/01 11:30:09
// Design Name: 
// Module Name: tb_count5
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


module tb_count5();

    reg clk, rst_n;
    reg mode;
    wire [2:0] cnt;

    count5 dut (.clk(clk), .rst_n(rst_n), .mode(mode), .cnt(cnt));
    
    // clk ����
    initial begin
        clk = 0;
        forever #25 clk = ~clk;
    end
    
    initial begin
         
        rst_n = 0; mode = 0;#100;
        rst_n = 1;#500;
        mode = 1; #50; 
        mode = 0; #500;
        mode = 1; #50; 
        mode = 0; #300;
        $finish;
    end
endmodule
