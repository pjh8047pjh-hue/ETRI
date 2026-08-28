`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/07 15:39:38
// Design Name: 
// Module Name: ReLU6
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


module ReLU6 #(
    parameter DIN_W = 16,
    parameter int UPPER = 6
)(
    input  logic                    clk,
    input  logic                    rst,
    input  logic signed [DIN_W-1:0] din,

    output logic [15:0] data_out_relu
    );

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            data_out_relu <= 16'd0;
        end else if(din > UPPER) begin
            data_out_relu <= UPPER[15:0];
        end else if(din < 0) begin
            data_out_relu <= 16'd0;
        end else begin
            data_out_relu <= din[15:0];
        end
    end

endmodule
