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

    output logic [143:0] data_out_even,
    output logic [143:0] data_out_odd,
    output logic [  8:0] channel_even_addr,
    output logic [  8:0] channel_odd_addr
    );
    
    logic [8:0] in_cnt;
    logic [7:0] channel_pair;
    logic       run;

    assign channel_even_addr = {channel_pair, 1'b0};
    assign channel_odd_addr  = channel_even_addr + 1'b1;

    blk_mem_gen_0 dual_port_rom(
        .clka (clk),
        .ena  (run),
        .douta(data_out_even),
        .addra(channel_even_addr),
        .clkb (clk),
        .enb  (run),
        .doutb(data_out_odd),
        .addrb(channel_odd_addr)
    );

    always_ff @(posedge clk) begin
        if (rst) begin
            in_cnt  <= '0;
            channel_pair <= '0;
            run     <= 1'b0;
        end
        else if (start_r) begin
            in_cnt  <= '0;
            channel_pair <= '0;
            run     <= 1'b1;
        end
        else if (run) begin
            // 한 depthwise 채널 = 16 × 16 = 256클록
            if (in_cnt == 9'd255) begin
                in_cnt <= '0;

                if (channel_pair == 8'd191) begin
                    channel_pair <= '0;
                    run     <= 1'b0;
                end
                else begin
                    channel_pair <= channel_pair + 1'b1;
                end
            end
            else begin
                in_cnt <= in_cnt + 1'b1;
            end
        end
    end
endmodule
