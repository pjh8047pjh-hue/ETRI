`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/07 14:56:23
// Design Name: 
// Module Name: mobilenetV2
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


module mobilenetV2(
    input  logic        clk_in,
    input  logic        rst,
    input  logic        start,

    output logic        done,
    output logic [15:0] result
    );

    wire        done_w, done_r;
    wire        output_data_valid;
    wire [15:0] pointwise_data_out;
    wire [15:0] pointwise_relu_out;
    wire        start_depth;

    wire clk;

    clk_wiz_0 clk_gen(.clk_in1(clk_in),
                  .locked(),
                  .clk_out1(clk)
                  );

    //------------------- pointwise ----------------------
    pointwise pointwise(.clk(clk),
                        .rst(rst),
                        .start(start),
                        .done_w(done_w),
                        .done_r(done_r),
                        .data_out(pointwise_data_out),
                        .output_data_valid(output_data_valid)
                        );

    ReLU6 #(.UPPER(16'h6000)) ReLU6_pw(.clk(clk),
                .rst(rst),
                .din(pointwise_data_out),
                .data_out_relu(pointwise_relu_out)
                );
    //----------------------------------------------------

    // Interconnect BRAM 필요 - 나중에 pointwise를 채널별로 계산하면 필요 X
    // 지금은 pointwise 출력 1개를 바로 depthwise에 흘려보내는 직결 구조.

    logic output_data_valid_d;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            output_data_valid_d <= 1'b0;
        else
            output_data_valid_d <= output_data_valid;
    end

    assign start_depth = output_data_valid && !output_data_valid_d;

    //------------------- depthwise ---------------------
    // depth_mac에서 bias add와 ReLU6까지 처리된 결과가 출력된다.
    wire signed [15:0] depthwise_data_out;
    wire               depthwise_output_valid;
    wire               pointwise_after_depth_valid;

    depth_top #(
        .SP         (16),
        .DW         (16)
    ) depthwise(
        .clk          (clk),
        .rst          (rst),
        .start        (start_depth),
        .input_data   (pointwise_relu_out),
        .depth_output_valid (depthwise_output_valid),
        .data_out     (depthwise_data_out)
    );
 //------------------- interconnect bram ---------------------
    wire  [ 10:0] input_rd_addr;
    wire  [511:0] input_rd_data;
    wire          input_rd_en;
    wire          write_done;
    wire signed [50:0] pointwise_after_depth_out_full;
    
    // BRAM의 write, read를 비대칭으로 설정. byte lane을 사용
    interconnect_bram_d2p bram_d2p(
        .clk(clk),
        .rst(rst),
        .start(start),
        .wr_data(depthwise_data_out[15:8]),
        .wr_valid(depthwise_output_valid),
        .input_rd_addr(input_rd_addr),
        .input_rd_en(input_rd_en),
        .input_rd_data(input_rd_data),
        .write_done(write_done)
    );
    //------------------- pointwise after depthwise ---------------------

    top_pointwise_after_depth pad(
    // input  logic         clk_in,
        .clk(clk),
        .rst(rst),
        .start(write_done),
        .depth_relu_data(depthwise_data_out[7:0]),
        .depth_relu_valid(depthwise_output_valid),
        .input_rd_data(input_rd_data),
        .input_rd_addr(input_rd_addr),
        .input_rd_en(input_rd_en),
        .done(done),
        .output_valid(pointwise_after_depth_valid),
        .pointwise_after_depth_out(pointwise_after_depth_out_full)
    );

    assign result = pointwise_after_depth_out_full[15:0];

    //-----------------------------------------------------------------

endmodule
