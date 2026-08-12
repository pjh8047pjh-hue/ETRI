`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/12 11:55:19
// Design Name: 
// Module Name: readAddress
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


module readAddress(
    input  logic rst, start, clk,
    output logic [4:0] addr
    );
    
    logic [3:0] row_cnt, col_cnt;
    logic [3:0] offset;
    
    always_ff @(posedge clk) begin
        if(rst) begin
            row_cnt <= 0;
            col_cnt <= 0;
            offset  <= 0;
            addr    <= 0;
        end else if(start && offset <= 20) begin
            if(row_cnt <= 10) begin
                if(col_cnt <= 2) begin
                    addr <= col_cnt + row_cnt + offset;
                    col_cnt <= col_cnt + 1'b1;
                end else begin
                    col_cnt <= 0;
                    row_cnt <= row_cnt + 3'd5;
                end
            end else begin
                row_cnt <= 0;
                offset  <= row_cnt + 4'd5;
            end
        end else begin
            col_cnt <= 0;
            row_cnt <= 0;
            offset  <= 0;
        end
    end             
endmodule
