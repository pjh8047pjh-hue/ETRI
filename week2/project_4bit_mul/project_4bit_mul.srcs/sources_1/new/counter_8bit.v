`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/06/30 14:33:50
// Design Name:
// Module Name: counter_8bit
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


module counter_8bit(
    output reg [7:0] q,
    input [1:0] func,
    input [7:0] d,
    input clk, reset
    );

    reg [7:0] next_q;

    always @(*) begin
        case (func)
            2'b00: next_q = d;
            2'b01: next_q = q + 1;
            2'b10: next_q = q - 1;
            default: next_q = q;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) q <= 8'd0;
        else q <= next_q;
    end

endmodule
