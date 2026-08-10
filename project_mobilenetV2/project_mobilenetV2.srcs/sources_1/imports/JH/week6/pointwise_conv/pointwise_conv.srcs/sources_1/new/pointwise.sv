`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/29 14:19:43
// Design Name: 
// Module Name: mult_9_by_9
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

/*  1. mem layer 08 out 저장하는 로직 완성
    2. accumulator 
*/
//////////////////////////////////////////////////////////////////////////////////


module pointwise(
    input  logic clk,
    input  logic rst,
    input  logic start,

    output logic        done_w,
    output logic        done_r,
    output logic [15:0] data_out,
    output logic        output_data_valid
    );

    import pointwise_pkg::*;

    logic [IN_CH*16-1:0] weight_data;
    logic [IN_CH*16-1:0] input_bram_data;
    logic signed [37:0]  mac_result;

    logic mem_read_req;
    logic en_mul;
    logic mac_result_valid;

    logic [5:0] ic_cnt;   // 0~63   inner  (IN_CH        = 64)
    logic [8:0] oc_cnt;   // 0~383  middle (WEIGHT_WIDTH = 384)
    logic [7:0] pix_cnt;  // 0~195  outer  (CHANNEL_WIDTH= 196)

    // BRAM 주소는 counter 가 아니라 FSM 이 만든 prefetch 주소를 쓴다.
    logic [8:0] oc_addr;
    logic [7:0] pix_addr;

    //----------------- module instance -----------------


    // width 1024bit, depth 196: 이전 layer의 pixel vector 저장
    mem_layer08_input_bram mem_layer08_input_bram(
                                  .clk(clk),
                                  .rst(rst),
                                  .start_w(1'b0),
                                  .dina('0),
                                  .done_w(),
                                  .start_r(mem_read_req),
                                  .pix_addr(pix_addr),
                                  .data_out(input_bram_data)
                                  );

    // width 1024bit, depth 384: output channel별 weight vector
    mem_weight_in  mem_weight_in (.clk(clk),
                                  .start_r(mem_read_req),
                                  .oc_cnt(oc_addr),
                                  .data_out(weight_data)
                                 );

    FSM_pointwise FSM(.clk(clk),
                      .rst(rst),
                      .start(start),
                      .mem_read_req(mem_read_req),
                      .en_mul(en_mul),
                      .ic_cnt(ic_cnt),
                      .oc_cnt(oc_cnt),
                      .pix_cnt(pix_cnt),
                      .oc_addr(oc_addr),
                      .pix_addr(pix_addr)
                      );

    pointwise_mac pointwise_mac(.clk(clk),
                                .rst(rst),
                                .en_mul(en_mul),
                                .ic_cnt(ic_cnt),
                                .weight_data(weight_data),
                                .input_data(input_bram_data),
                                .result(mac_result),
                                .result_valid(mac_result_valid)
                                );

    // width 16bit, depth 75,264
    mem_layer08_out mem_layer08_out(.clk(clk),
                                    .rst(rst),
                                    .start_w(mac_result_valid),
                                    .start_r(done_w),
                                    .dina(mac_result),
                                    .data_out(data_out),
                                    .data_valid(output_data_valid),
                                    .done_w(done_w),
                                    .done_r(done_r)
                                    );

    // ReLU6는 이 모듈 밖(mobilenetV2 top)에서 적용한다.
    // 예전에는 여기서 ReLU6를 바로 붙였는데, data_out을
    // mem_layer08_out과 동시에 두 번 구동하게 되어 제거함.
endmodule
