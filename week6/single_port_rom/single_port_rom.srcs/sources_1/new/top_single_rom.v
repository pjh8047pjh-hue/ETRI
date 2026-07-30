`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/27 15:29:30
// Design Name: 
// Module Name: top_single_rom
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
module top_single_rom(
    input wire clk,
    input wire rst, 
    input wire start_r,

    output wire [15:0] data_out,
    output reg done
    );

    reg ena;
    reg [6:0] addra;

    blk_mem_gen_0 rom(.clka(clk),
                     .ena(ena),
                     .douta(data_out),
                     .addra(addra)
                     );

    always @(posedge clk or posedge rst) begin
        if(rst) begin 
            addra    <= 0;
            ena      <= 0;
            done     <= 0;
        end else if(start_r == 1'b1) begin
            ena  <= 1'd1;
            done <= 0;    
        end else if(ena && addra != 7'd100) begin
            addra    <= addra + 1'd1;
        end else if(addra == 7'd100) begin
            ena      <= 0;
            addra    <= 7'd0;
            done     <= 1;
        end
    end
endmodule