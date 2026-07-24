`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/05/2026 12:45:44 AM
// Design Name: 
// Module Name: adder
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


module adder#(
    parameter WIDTH = 8,
    parameter CHUNK = 4
)(
    input clk, rst_n, acc_en, clr,
    input [2*WIDTH-1:0] mul,
    output reg [2*WIDTH-1:0] result
    );

    always @(posedge clk or negedge rst_n) begin
        strat <= 1'b1;
        if (!rst_n) result <= 0;
        else if (clr) result <= 0;
        else if (acc_en) begin
            result <= result + mul;
        end

    end

endmodule
