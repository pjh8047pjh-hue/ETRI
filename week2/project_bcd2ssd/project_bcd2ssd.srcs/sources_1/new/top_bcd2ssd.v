`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/02 15:23:39
// Design Name: 
// Module Name: top_bcd2ssd
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


module top_bcd2ssd(
    input clk, rst,
    input [3:0] sec_1, sec_10, min_1, min_10,
    output [6:0] ssd1, ssd2,
    output cat1, cat2
    );
    
    bcd2ssd dut_sec_1 (.bcd(sec_1), .ssd(ssd_s1));
    bcd2ssd dut_sec_10 (.bcd(sec_10), .ssd(ssd_s10));
    bcd2ssd dut_min_1 (.bcd(min_1), .ssd(ssd_m1));
    bcd2ssd dut_min_10 (.bcd(min_10), .ssd(ssd_m10));
   
    wire [6:0] ssd_s1, ssd_s10, ssd_m1, ssd_m10;
    reg [18:0] clk_bcd2ssd;
    reg bcd2ssd_sel;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_bcd2ssd <= 0;
            bcd2ssd_sel <= 0;
        end else if (clk_bcd2ssd == 500_000) begin
            clk_bcd2ssd <= 0;
            bcd2ssd_sel <= ~bcd2ssd_sel;   // �ڸ� ���?
        end else begin
            clk_bcd2ssd <= clk_bcd2ssd + 1;
        end
    end
    
    assign cat1 = bcd2ssd_sel;
    assign cat2 = bcd2ssd_sel;
    
    assign ssd1 = cat1 ? ssd_s1 : ssd_s10;
    assign ssd2 = cat2 ? ssd_m1 : ssd_m10;
    
endmodule
