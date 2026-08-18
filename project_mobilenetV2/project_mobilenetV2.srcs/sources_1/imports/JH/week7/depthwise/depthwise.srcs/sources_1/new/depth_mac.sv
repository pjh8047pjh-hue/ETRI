`timescale 1ns / 1ps

module depth_mac #(
    parameter SP = 16,
    parameter DW = 16,
    parameter int RELU_UPPER = 6
)(
    input  logic                   clk, rst,
    input  logic                   start,        // 첫 픽셀보다 한 클럭 앞
    input  logic signed [  DW-1:0] input_data,
    input  logic signed [9*DW-1:0] weight,
    
    output logic                   depth_output_valid,
    output logic signed [15:0] data_out
);

    /*  
                j=0      j=1      j=2   ← 열 (왼쪽=옛날, 오른쪽=최신)
            ┌────────┬────────┬────────┐
    i=0 top │  w[0]  │  w[1]  │  w[2]  │ ◀── top_in
            ├────────┼────────┼────────┤
    i=1 mid │  w[3]  │  w[4]  │  w[5]  │ ◀── mid_in
            ├────────┼────────┼────────┤
    i=2 bot │  w[6]  │  w[7]  │  w[8]  │ ◀── bot_in
            └────────┴────────┴────────┘
                                    ▲
                        새 값은 항상 오른쪽(j=2)으로 들어옴
                        → 인덱스 2, 5, 8

    */

    //import depthwise_pkg::*;

    //--------------------- streaming counter ----------------------
    localparam int ROW_LEN = 16;
    
    logic [3:0] col_cnt;
    logic [3:0] row_cnt;
    logic [8:0] input_channel_cnt;
    logic       run;

    wire channel_end = run
                    && (row_cnt == ROW_LEN-1)
                    && (col_cnt == ROW_LEN-1);

    always_ff @(posedge clk) begin
        if(rst) begin   
            col_cnt           <= '0;
            row_cnt           <= '0;
            input_channel_cnt <= '0;
            run               <= 1'b0;
        end else if(start) begin
            col_cnt           <= '0;
            row_cnt           <= '0;
            input_channel_cnt <= '0;
            run               <= 1'b1;
        end else if(run) begin
            // 마지막 입력은 파이프라인에 넣되, 다음 입력 발행은 정지한다.
            // output_valid_d에 남은 valid가 배출되므로 마지막 BRAM write는 유지된다.
            if(channel_end && (input_channel_cnt == 9'd383)) begin
                col_cnt           <= '0;
                row_cnt           <= '0;
                input_channel_cnt <= '0;
                run               <= 1'b0;
            end else begin
                if(col_cnt == ROW_LEN-1) begin
                    col_cnt <= '0;
                    row_cnt <= (row_cnt == ROW_LEN-1) ? 4'd0 : row_cnt + 4'd1;
                end else begin
                    col_cnt <= col_cnt + 4'd1;
                end

                if(channel_end)
                    input_channel_cnt <= input_channel_cnt + 1'b1;
            end
        end 
    end
    //--------------------------------------------------------------

    // data logic
    logic [SP*DW-1:0] line_buf_1;
    logic [SP*DW-1:0] line_buf_2;

    wire signed [DW-1:0] bot = input_data;
    wire signed [DW-1:0] mid = line_buf_1[SP*DW-1 -: DW];
    wire signed [DW-1:0] top = line_buf_2[SP*DW-1 -: DW];

    // 입력 스트림 자체가 16x16 zero-padded 데이터이므로 추가 padding은 필요 없다.
    wire signed [DW-1:0] bot_in = bot;
    wire signed [DW-1:0] mid_in = mid;
    wire signed [DW-1:0] top_in = top;

    //------------------- line_buf_logic------------------------------

    always_ff @(posedge clk) begin
        line_buf_1 <= {line_buf_1[(SP-1)*DW-1:0], bot};
        line_buf_2 <= {line_buf_2[(SP-1)*DW-1:0], mid};
    end
    
    //--------------------------------------------------------------
    localparam PARALLEL_DEPTH = 3;

    wire signed [29:0] a_top_in [0:2];
    wire signed [29:0] a_mid_in [0:2];
    wire signed [29:0] a_bot_in [0:2];

    wire signed [47:0] pc_top [0:1];
    wire signed [47:0] pc_mid [0:1];
    wire signed [47:0] pc_bot [0:1];

    logic signed [47:0] top_out, mid_out, bot_out;

    dsp48_mul mac_top1(
        .CLK  (clk),
        .A    (top_in),
        .B    (weight[32 +: 16]),
        .P    (),
        .ACOUT(a_top_in[1]),
        .PCOUT(pc_top[0])
    );

    dsp48_mac mac_top2(
        .CLK  (clk),
        .ACIN (a_top_in[1]),
        .B    (weight[16 +: 16]),
        .P    (),
        .ACOUT(a_top_in[2]),
        .PCOUT(pc_top[1]),
        .PCIN (pc_top[0])
    );

    dsp48_mac_last mac_top3(
        .CLK (clk),
        .ACIN(a_top_in[2]),
        .B   (weight[0 +: 16]),
        .P   (top_out),
        .PCIN(pc_top[1])
    );

    dsp48_mul mac_mid1(
        .CLK  (clk),
        .A    (mid_in),
        .B    (weight[80 +: 16]),
        .P    (),
        .ACOUT(a_mid_in[1]),
        .PCOUT(pc_mid[0])
    );

    dsp48_mac mac_mid2(
        .CLK  (clk),
        .ACIN (a_mid_in[1]),
        .B    (weight[64 +: 16]),
        .P    (),
        .ACOUT(a_mid_in[2]),
        .PCOUT(pc_mid[1]),
        .PCIN (pc_mid[0])
    );

    dsp48_mac_last mac_mid3(
        .CLK (clk),
        .ACIN(a_mid_in[2]),
        .B   (weight[48 +: 16]),
        .P   (mid_out),
        .PCIN(pc_mid[1])
    );

    dsp48_mul mac_bot1(
        .CLK  (clk),
        .A    (bot_in),
        .B    (weight[128 +: 16]),
        .P    (),
        .ACOUT(a_bot_in[1]),
        .PCOUT(pc_bot[0])
    );

    dsp48_mac mac_bot2(
        .CLK  (clk),
        .ACIN (a_bot_in[1]),
        .B    (weight[112 +: 16]),
        .P    (),
        .ACOUT(a_bot_in[2]),
        .PCOUT(pc_bot[1]),
        .PCIN (pc_bot[0])
    );

    dsp48_mac_last mac_bot3(
        .CLK (clk),
        .ACIN(a_bot_in[2]),
        .B   (weight[96 +: 16]),
        .P   (bot_out),
        .PCIN(pc_bot[1])
    );

    localparam int CHANNEL_COUNT = 384;
    localparam int OUTPUT_LATENCY = 6;

    logic signed [31:0] bias_data;
    logic        [ 8:0] bias_addr;
    logic [OUTPUT_LATENCY-1:0] output_valid_d;
    logic [OUTPUT_LATENCY-1:0] channel_end_d;

    // 16x16 padded 입력에서 3x3 window가 완성되는 row/col 2~15만 출력한다.
    wire window_valid = run && (row_cnt >= 4'd2) && (col_cnt >= 4'd2);

    always_ff @(posedge clk) begin
        if (rst || start) begin
            output_valid_d <= '0;
            channel_end_d  <= '0;
        end else begin
            output_valid_d <= {output_valid_d[OUTPUT_LATENCY-2:0], window_valid};
            channel_end_d  <= {channel_end_d[OUTPUT_LATENCY-2:0], channel_end};
        end
    end

    assign depth_output_valid = output_valid_d[OUTPUT_LATENCY-1];

    //------------ depth bias input --------------
    always_ff @(posedge clk) begin
        if (rst || start) begin
            bias_addr <= '0;
        end else if (channel_end_d[OUTPUT_LATENCY-1]) begin
            bias_addr <= (bias_addr == CHANNEL_COUNT-1) ? '0 : bias_addr + 1'b1;
        end
    end

    depth_bias bias_in(
        .clka (clk),
        .ena  (run),
        .douta(bias_data),
        .addra(bias_addr)
    );
    //---------------------------------------------

    //---------- bias add + ReLU6 output ----------
    // 32비트 bias를 48비트로 부호 확장
    wire signed [3*DW-1:0] bias_extended =
        {{(3*DW-32){bias_data[31]}}, bias_data};

    // MAC은 소수부 24비트이므로 >>>12 후,
    // 소수부 12비트인 32비트 bias를 더함
    wire signed [3*DW-1:0] relu_input =
        ((top_out + mid_out + bot_out) >>> 12)
        + bias_extended;

    logic signed [3*DW-1:0] relu_input_reg;

    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            relu_input_reg <= '0;
        else
            relu_input_reg <= relu_input;
    end

    localparam logic signed [3*DW-1:0] RELU6_Q312 =
        48'sh000000006000;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            data_out <= '0;
        end else if (relu_input_reg <= 0)
            data_out <= '0;
        else if (relu_input_reg >= RELU6_Q312)
            data_out <= RELU6_Q312;
        else
            data_out <= relu_input_reg[15:0];
    end
    
endmodule
