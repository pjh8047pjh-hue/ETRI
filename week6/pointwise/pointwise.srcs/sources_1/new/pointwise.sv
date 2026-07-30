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
// 
//////////////////////////////////////////////////////////////////////////////////


module pointwise(
    input  logic clk,
    input  logic rst,
    input  logic start,
    //----------test
    input  logic [15:0] din_weight,
    input  logic [15:0] din,
    //----------
    output logic        done_w,
    output logic        done_r,
    output logic [ 3:0] step,
    output logic [15:0] data_out
    );

    import pointwise_pkg::*;

    logic [15:0] B;
    logic [31:0] P;

    logic start_r;
    logic start_w;
    logic [3:0] write_delay;

    assign step = A;

    //----------------- module instance -----------------
    // width 16bit, depth 75,264
    mem_layer08_out mem_layer08_out(.clk(clk),
                                    .rst(rst),
                                    .start_w(start_w),
                                    .start_r(done_w),
                                    .dina(P),
                                    .data_out(data_out),
                                    .done_w(done_w),
                                    .done_r(done_r)
                                    );

    // width 16bit, depth 24,576
    mem_weight_in  mem_weight_in (.clk(clk),
                                  .rst(rst),
                                  .start_r(start_r),
                                  .data_out(din_weight)
                                 );
 
    // width 16bit, signed
    mult_gen_0 multiply(.CLK(clk),
                        .A(din_weight),
                        .B(B),
                        .P(P)
                        )
 

    logic en_mul;

    //----------- read weight ------------------------
    // TODO: 미완성. start_r 를 세울 조건을 채운 뒤 주석 해제할 것.
    //       (지금은 syntax error 라 프로젝트 전체 compile order 생성이 실패한다)
    /*
    always_ff @(posedge clk or posedge rst) begin
       if(rst) start_r <= 0;
       else if ()
    end
    */


    //------------ wait 3 clock -----------------------
    always_ff @(posedge clk or posedge rst) begin 
        if(rst) begin
            write_delay <= 1;
            start_w     <= 0;
        end else begin
            start_w <= 1'b0;
            if(en_mul) begin
                if(write_delay != 0 && write_delay != MUL_DELAY) begin
                    write_delay <= write_delay + 2'd1;
                end else if (write_delay != 0) begin
                    start_w     <= 1'b1;
                    write_delay <= 0;
                end
            end
        end
    end

    //-------------------pointwise logic---------------

    logic [15:0] weight;
    logic [ 8:0] weight_cnt; // count 384
    logic [ 7:0] input_cnt;  // count 196

    always_ff @(posedge clk or posedge rst) begin 
        if(rst) begin
            en_mul  <= 0;
        end else if(start) begin
            en_mul <= 1;
        end else if(step == 8'd10) en_mul <= 0;
    end

    // index calculation
    always_ff @(posedge clk or posedge rst) begin
        if(rst) begin
            weight_cnt <= 0;
            input_cnt  <= 0;
        end else if(input_cnt != CHANNEL_WIDTH-1) begin
                if(weight_cnt !=  WEIGHT_WIDTH-1) begin
                    weight_cnt <= weight_cnt + 8'd1;
                end else if(weight_cnt == WEIGHT_WIDTH-1) begin
                    input_cnt  <= input_cnt + 9'd1;
                    weight_cnt <= 0;
                end     
        end else if(input_cnt == CHANNEL_WIDTH-1) begin
            input_cnt <= 0;
        end
    end
    //------------------------------------------------

    //------------pointwise data out logic------------

    // TODO: 미완성. 폭을 정한 뒤 선언할 것.
    // logic [:]

    //------------------------------------------------

endmodule
