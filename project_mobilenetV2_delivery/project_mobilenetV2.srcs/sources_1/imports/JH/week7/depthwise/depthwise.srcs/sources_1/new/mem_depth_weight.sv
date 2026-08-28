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

    always_ff @(posedge clk) begin
        if (rst) begin
            in_cnt  <= '0;
            channel <= '0;
            run     <= 1'b0;
        end
        else if (start_r) begin
            in_cnt  <= '0;
            channel <= '0;
            run     <= 1'b1;
        end
        else if (run) begin
            // 한 depthwise 채널 = 16 × 16 = 256클록
            if (in_cnt == 9'd255) begin
                in_cnt <= '0;

                if (channel == 9'd383) begin
                    channel <= '0;
                    run     <= 1'b0;
                end
                else begin
                    channel <= channel + 1'b1;
                end
            end
            else begin
                in_cnt <= in_cnt + 1'b1;
            end
        end
    end
endmodule
