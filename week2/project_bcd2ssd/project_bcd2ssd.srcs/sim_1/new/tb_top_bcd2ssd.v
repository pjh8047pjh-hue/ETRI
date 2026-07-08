`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/02 16:04:19
// Design Name: 
// Module Name: tb_top_bcd2ssd
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


module tb_top_bcd2ssd();
    top_bcd2ssd dut(
        .clk(clk), 
        .rst(rst), 
        .sec_1(sec_1), 
        .sec_10(sec_10), 
        .min_1(min_1), 
        .min_10(min_10),
        .ssd1(ssd1),
        .ssd2(ssd2),
        .cat(cat));
        
        reg clk, rst;
        reg [3:0] sec_1, sec_10, min_1, min_10;
        wire [6:0] ssd1, ssd2;
        wire cat;
                
     initial begin
        clk = 0;
        rst = 0; #25;
        rst = 1; #25;
        rst = 0; #25;
        forever #25 clk = ~clk;
     end   
     
     initial begin
        sec_1 = 4'd0; #25;
        sec_10 = 4'd0; #25;
        min_1 = 4'd0; #25;
        min_10 = 4'd0; #25;
        
        sec_1 = 4'd1; #25;
        sec_10 = 4'd0; #25;
        min_1 = 4'd0; #25;
        min_10 = 4'd0; #25
        
        sec_1 = 4'd1; #25;
        sec_10 = 4'd1; #25;
        min_1 = 4'd1; #25;
        min_10 = 4'd0; #25
        
        sec_1 = 4'd2; #25;
        sec_10 = 4'd3; #25;
        min_1 = 4'd2; #25;
        min_10 = 4'd1; #25;        
     end
endmodule
