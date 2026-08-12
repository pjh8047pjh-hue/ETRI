`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/12 11:40:14
// Design Name: 
// Module Name: patterDetecter
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


module patternDetecter(
    input  logic clk, rstn, data,
    output logic flag
    );
    
    logic data_buf;
    
    always_ff @(posedge clk) data_buf <= data;
    
    logic [4:0] din;
    logic [4:0] pwd;
    
    assign pwd = 5'b11001;
    
    always_ff @(posedge clk or negedge rstn) begin
        if(!rstn) din <= 0;
        else if(!flag) din <= {din[3:0], data_buf};
        else if(flag) din <= {4'd0, data_buf};
    end 
    
    always_comb begin
        if(din == pwd) flag = 1;
        else flag = 0;
    end
endmodule
