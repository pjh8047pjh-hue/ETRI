`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/07 11:24:33
// Design Name: 
// Module Name: mem_depth_weight
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


module mem_depth_weight(

    input  logic        clk,
    input  logic        start_r,
    input  logic        rst,

    output logic [143:0] data_out
    );
    
    logic [8:0] in_cnt;
    logic [8:0] channel;
    logic       run;

    blk_mem_gen_0 single_port_rom(.clka(clk),
                                   .ena(run),
                                   .douta(data_out),
                                   .addra(channel)
                                   );

    always_ff @(posedge clk) begin : blockName
        if(start_r) run <= 1;
    end

    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            in_cnt  <= 0;
            channel <= 0;    
        end else if(in_cnt != 9'd383) begin
            in_cnt <= in_cnt + 1'b1;
        end else if(in_cnt == 9'd383) begin
            in_cnt  <= 0;
            channel <= channel + 9'd1;
        end
    end                                   
endmodule
