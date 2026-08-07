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
    input  logic clk,
    input  logic rst,
    input  logic start,
    input  logic 

    output logic done
    output logic [15:0] result;

    );

    //--------------- Clock Generator --------------------
    wire   locked, clk_100, clk; // teste용 clk. 실제로 보드에 입력할 때는 입력 포트로 변경
    assign clk = clk_100;

	clk_wiz_0 clk_gen(.clk_out1(clk_100),
					  .locked(locked),
  					  .clk_in1(clk_in)
 					  );
    //----------------------------------------------------

    //------------------- pointwise ----------------------
    wire done_w, done_r;
    wire output_data_valid;

    pointwise pointwise(.clk(clk),
                        .rst(rst),
                        .start(start),
                        .done_w(done_w),
                        .done_r(done_r),
                        .data_out(),
                        .output_data_valid()
                        );

    ReLU6 ReLU6(.clk(clk),
                .rst(rst),
                .din(din),
                .data_out_relu()
                );
    //----------------------------------------------------

    // Interconnect BRAM 필요 - 나중에 pointwise를 채널별로 계산하면 필요 X

    //------------------- depthtwise ---------------------
    depthwise_top depthwise(.clk(clk),
	                        .rst(rst),
                            .start(start),
                            .input_data(),
                            .data_out()
                            );
  
    ReLU6 ReLU6(.clk(clk),
                .rst(rst),
                .din(din),
                .data_out_relu(result)
                );
    //----------------------------------------------------

endmodule
