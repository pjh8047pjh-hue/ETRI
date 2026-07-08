`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/01 11:02:32
// Design Name: 
// Module Name: count5
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

module count5(

    input clk, rst_n,
    input mode,
    output reg [2:0] cnt
    );
    parameter S_UP = 1'b0, S_DOWN = 1'b1;
    reg cstate;

    always @(posedge mode or negedge rst_n) begin
        if (rst_n == 1'b0) cstate <= S_UP;
        else cstate <= ~cstate;
    end

    // output logic
    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0)
            cnt <= 3'd0;
        else if(cstate == S_UP)
            cnt <= (cnt == 3'd7) ? 3'd0 : cnt + 1'b1;
        else if (cstate == S_DOWN)
            cnt <= (cnt == 3'd0) ? 3'd7 : cnt - 1'b1;
    end
endmodule
