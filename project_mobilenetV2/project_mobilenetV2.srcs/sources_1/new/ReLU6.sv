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


module ReLU6(
    input  logic clk,
    input  logic rst,
    input  logic din,

    output logic [15:0] data_out_relu
    );

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            data_out_relu <= 0;
        end else if(din <= 16'd6 && din >= 16'd0) begin
            data_out_relu <= din;
        end else if(din > 16d'6) begin
            data_out_relu <= 16'd6;
        end else if(din < 16'd0) begin
            data_out_relu <= 16'd0;
        end
    end

endmodule
