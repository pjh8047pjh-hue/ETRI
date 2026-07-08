`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/02 11:46:07
// Design Name: 
// Module Name: counter
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

module counter(
    input clk_in, rst,
    output led
    );
    
    parameter sec_half = 50000000; // simulation 
    
    reg led = 1'b0;
    reg [26:0] cnt = 26'd0;
    
    
    wire clk, locked;
    
//    assign clk = clk_in; // testbench ¿ë
    
    clk_wiz_0 clk_u0 (.clk_out1(clk), .locked(locked),  .clk_in1(clk_in));
    
    always @(posedge clk) begin
        cnt <= cnt + 1;
        if (cnt == sec_half) begin
            led <= ~led;
            cnt <= 1;
        end    
        else led <= led;
    end    
endmodule
