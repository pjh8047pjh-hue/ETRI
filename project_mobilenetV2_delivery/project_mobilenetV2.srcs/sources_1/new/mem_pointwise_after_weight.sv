`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/13 17:17:27
// Design Name: 
// Module Name: mem_pointwise_after_weight
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

module mem_pointwise_after_weight(
    input  logic        clk,
    input  logic        start_r,
    input  logic        rst,
    input  logic [5:0]  ch_cnt,    // 0~63, 상위가 알려주는 현재 출력 채널

    output logic [511:0] data_out
    );

    logic [2:0] in_cnt;   // 0~5, 384채널을 64 lane씩 6번 나눠 읽는 카운트
    logic [8:0] addr;     // channel*6 + in_cnt
    logic       run;

    assign addr = ch_cnt * 6 + in_cnt;

    pointwise_after_depth_weight m1(.clka(clk),
                                    .ena(run),
                                    .douta(data_out),
                                    .addra(addr)
                                    );

    always_ff @(posedge clk) begin
        if(rst)          run <= 0;
        else if(start_r) run <= 1;
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            in_cnt  <= 0;
            pix_cnt <= 0;
            ch_cnt <= 0;
        end
        else if(run) begin
            if(in_cnt == 3'd5) begin
                in_cnt <= 0;
                if(pix_cnt == 8'd195) begin
                    pix_cnt <= 0;
                    if(ch_cnt == 6'd63) ch_cnt <= 0;
                    else ch_cnt <= ch_cnt + 1'b1;
                end
                else pix_cnt <= pix_cnt + 1'b1;
            end
            else in_cnt <= in_cnt + 1'b1;
        end
    end

endmodule