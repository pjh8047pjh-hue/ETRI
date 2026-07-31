`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/31 15:52:29
// Design Name: 
// Module Name: accumulator
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


module accumulator(
    input  logic clk,
    input  logic rst,
    input  logic [5:0] ic_cnt,              // ← pixel_end 대신. 0~63, product와 시점 정렬
    input  logic signed [31:0] product,

    output logic signed [37:0] accumulator
    );

// 나중에 enable 신호 추가
    always_ff @(posedge clk or posedge rst) begin
        if (rst)                accumulator <= 0;       
        else if (ic_cnt == 0)   accumulator <= product;
        else                    accumulator <= accumulator + product;
    end

endmodule
