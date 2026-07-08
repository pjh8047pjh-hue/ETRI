`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/03 15:38:07
// Design Name: 
// Module Name: baudrate_gen
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

module baudrate_gen(
    input clk_in, rst, 
    output reg baud_tick
    );
    
    localparam DIV = 868;

    clk_wiz_0 clk_wiz (.clk_in1(clk_in), .clk_out1(clk_out1), .locked(locked), .reset(rst));
    
    // baudrate_gen 모듈이 받아야 하는 input
    wire locked;
    wire clk_out1;

    reg [26:0] cnt;

    always @(posedge clk_out1) begin
        if (rst) begin
            cnt <= 0;
            baud_tick <= 0;
        end
        else if (cnt == DIV - 1) begin
            cnt <= 0;
            baud_tick <= 1;
        end
        else begin
            cnt <= cnt + 1;
            baud_tick <= 0;
        end
    end
endmodule
