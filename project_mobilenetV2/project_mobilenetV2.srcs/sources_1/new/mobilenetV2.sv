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

    //------------------- pointwise ----------------------
    wire        done_w, done_r;
    wire        output_data_valid;
    wire [15:0] pointwise_data_out;
    wire [15:0] pointwise_relu_out;

    wire clk;

    clk_wiz_0 clk_gen(.clk_in1(clk_in),
                  .locked(),
                  .clk_out1(clk)
                  );

    pointwise pointwise(.clk(clk),
                        .rst(rst),
                        .start(start),
                        .done_w(done_w),
                        .done_r(done_r),
                        .data_out(pointwise_data_out),
                        .output_data_valid(output_data_valid)
                        );

    ReLU6 #(.UPPER(32767)) ReLU6_pw(.clk(clk),
                .rst(rst),
                .din(pointwise_data_out),
                .data_out_relu(pointwise_relu_out)
                );
    //----------------------------------------------------

    // Interconnect BRAM 필요 - 나중에 pointwise를 채널별로 계산하면 필요 X
    // 지금은 pointwise 출력 1개를 바로 depthwise에 흘려보내는 직결 구조.

    //------------------- depthwise ---------------------
    wire signed [47:0] depthwise_data_out;
    wire        [15:0] depthwise_relu_out;

    depth_top depthwise(.clk(clk),
	                        .rst(rst),
                            .start(start),
                            .input_data(pointwise_relu_out),
                            .data_out(depthwise_data_out)
                            );

    ReLU6 #(.DIN_W(48)) ReLU6_dw(.clk(clk),
                .rst(rst),
                .din(depthwise_data_out),
                .data_out_relu(depthwise_relu_out)
                );
    //----------------------------------------------------

    assign result = depthwise_relu_out;
    // depth_top이 아직 완료 신호를 내보내지 않아 done은 임시로 0 고정.
    // depth_top에 done 포트가 추가되면 연결할 것.
    assign done   = 1'b0;

endmodule
