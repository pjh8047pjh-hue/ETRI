`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/13 16:56:34
// Design Name: 
// Module Name: top_pointwise_after_depth
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


module top_pointwise_after_depth #(
    parameter int RELU_UPPER = 6  // legacy compatibility only
)(
    // input  logic         clk_in,
    input  logic                clk,
    input  logic                rst,
    input  logic                start,
    input  logic        [ 15:0] depth_relu_data,
    input  logic                depth_relu_valid,
    input  logic signed [1023:0] input_rd_data,

    output logic        [ 10:0] input_rd_addr,
    output logic                input_rd_en,
    output logic                done,
    output logic                output_valid,
    output logic signed [ 15:0] pointwise_after_depth_out
    );

    /*
    wire clk;

    clk_wiz_0 clk_gen(.clk_in1(clk_in),
                  .locked(),
                  .clk_out1(clk)
                  );
                  */

    //------------------------- point count logic -----------------------------
    logic [2:0] chunk_cnt;   // 0~5, 384채널을 64 lane씩 6번 나눠 읽는 카운트
    logic [7:0] pixel_cnt;  // 196개의 픽셀의 완료를 카운트 하는 로직
    logic [5:0] channel_cnt;   // channel의 개수가 다 카운트 되었는지 확인하는 로직
    logic       run;
    logic       run_d1;
    logic       last_input;

    localparam PIXEL  = 196;
    localparam CHUNK  = 6;
    localparam OUT_CH = 64;
    localparam BRAM_LATENCY = 2;

    // 마지막 read 뒤에도 BRAM output register가 갱신되도록 enable만 1클록 유지한다.
    wire mem_en = run || run_d1;
    assign input_rd_en = mem_en;
    assign last_input  = run && (chunk_cnt == CHUNK-1)
                             && (pixel_cnt == PIXEL-1)
                             && (channel_cnt == OUT_CH-1);

    always_ff @(posedge clk) begin
        if(rst)        run <= 0;
        else if(start) run <= 1;
        else if(last_input) run <= 0;
    end

    always_ff @(posedge clk) begin
        if (rst) run_d1 <= 1'b0;
        else     run_d1 <= run;
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            chunk_cnt  <= 0;
            pixel_cnt <= 0;
            channel_cnt <= 0;
        end
        else if(run) begin
            if(chunk_cnt == CHUNK-1) begin
                chunk_cnt <= 0;
                if(pixel_cnt == PIXEL-1) begin
                    pixel_cnt <= 0;
                    if(channel_cnt == OUT_CH-1) channel_cnt <= 0;
                    else channel_cnt <= channel_cnt + 1'b1;
                end
                else pixel_cnt <= pixel_cnt + 1'b1;
            end
            else chunk_cnt <= chunk_cnt + 1'b1;
        end
    end
    //-------------------------- BRAM Latency Logic ---------------------------
    logic [BRAM_LATENCY-1:0] first_d;
    logic [BRAM_LATENCY-1:0] last_d;
    logic [BRAM_LATENCY-1:0] done_d;
    logic signed [ 31:0] bias_data_d [14:0];

    wire  signed [ 31:0] bias_data;

    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < 15; i++)
                bias_data_d[i] <= '0;
        end else begin
            bias_data_d <= {bias_data_d[13:0], bias_data};
        end
    end

    always_ff @(posedge clk) begin
        if(rst) begin
            first_d <= '0;
            last_d  <= '0;
            done_d  <= '0;
        end
        else begin
            first_d <= {first_d[BRAM_LATENCY-2:0], run && (chunk_cnt == 0)};
            last_d  <= {last_d [BRAM_LATENCY-2:0], run && (chunk_cnt == CHUNK-1)};
            done_d  <= {done_d [BRAM_LATENCY-2:0], last_input};
        end
    end
    //------------------------- index count logic -----------------------------
    logic [  8:0] weight_addr;
    logic [  5:0] bias_addr;

    wire  signed [1023:0] weight_data;
    wire  signed [1023:0] skip_bram_data;
    wire  signed [  15:0] pw_raw;
    wire                       pw_valid;
    wire                       pw_done;
    logic signed [  15:0] pw_hold;
    logic [  7:0] skip_pixel_cnt;
    logic [  5:0] skip_channel_cnt;
    logic [  5:0] skip_channel_hold;
    logic [BRAM_LATENCY-1:0] skip_valid_d;
    logic [BRAM_LATENCY-1:0] skip_done_d;
    wire signed [15:0] skip_lane =
        $signed(skip_bram_data[skip_channel_hold*16 +: 16]);
    
    // 상수이기 때문에 shift로 구현 됨
    assign input_rd_addr  = pixel_cnt   * CHUNK + chunk_cnt; 
    assign weight_addr    = channel_cnt * CHUNK + chunk_cnt;
    assign bias_addr      = channel_cnt;

    pointwise_after_depth_weight u_weight(
        .clka(clk),                     
        .ena(mem_en),
        .douta(weight_data),
        .addra(weight_addr)
        );

    pointwise_after_depth_bias u_bias(
        .clka(clk),                     
        .ena(mem_en),
        .douta(bias_data),
        .addra(bias_addr)
    );

    mem_layer08_input_bram u_skip_input (
        .clk      (clk),
        .rst      (rst),
        .start_w  (1'b0),
        .dina     ('0),
        .done_w   (),
        .start_r  (pw_valid || skip_valid_d[0]),
        .pix_addr (skip_pixel_cnt),
        .data_out (skip_bram_data)
    );

    always_ff @(posedge clk) begin
        if (rst || start) begin
            pw_hold          <= '0;
            skip_pixel_cnt   <= '0;
            skip_channel_cnt <= '0;
            skip_channel_hold <= '0;
            skip_valid_d     <= '0;
            skip_done_d      <= '0;
        end else begin
            skip_valid_d <= {skip_valid_d[BRAM_LATENCY-2:0], pw_valid};
            skip_done_d  <= {skip_done_d [BRAM_LATENCY-2:0], pw_done};
            if (pw_valid) begin
                pw_hold            <= pw_raw;
                skip_channel_hold  <= skip_channel_cnt;
                if (skip_pixel_cnt == PIXEL-1) begin
                    skip_pixel_cnt <= '0;
                    if (skip_channel_cnt == OUT_CH-1) skip_channel_cnt <= '0;
                    else skip_channel_cnt <= skip_channel_cnt + 1'b1;
                end else skip_pixel_cnt <= skip_pixel_cnt + 1'b1;
            end
        end
    end

    assign pointwise_after_depth_out = pw_hold + skip_lane;
    assign output_valid = skip_valid_d[BRAM_LATENCY-1];
    assign done         = skip_done_d [BRAM_LATENCY-1];

    //-------------------------------------------------------------------------
      
    pointwise_after_depth #(
        .RELU_UPPER(RELU_UPPER)
    ) pad1(
        .clk(clk),
        .rst(rst),
        .first(first_d[BRAM_LATENCY-1]),
        .last(last_d[BRAM_LATENCY-1]),
        .last_all(done_d[BRAM_LATENCY-1]),
        .input_data(input_rd_data),
        .weight_data(weight_data),
        .bias_data(bias_data_d[14]),
        .done(pw_done),
        .output_valid(pw_valid),
        .pointwise_after_depth_out(pw_raw)
        );
    //-------------------------------------------------------------------------


endmodule
