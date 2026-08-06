`timescale 1ns / 1ps

module depth_mac #(parameter int SP=15, DW=16) (
    input  logic                   clk, rst,
    input  logic                   start,        // 첫 픽셀보다 한 클럭 앞
    input  logic signed [  DW-1:0] input_data,
    input  logic signed [9*DW-1:0] weight,
    
    output logic signed [3*DW-1:0] data_out
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
    localparam int ROW_LEN = 15;
    
    logic [3:0] col_cnt;
    logic [3:0] row_cnt;
    logic       run;

    always_ff @(posedge clk) begin
        if(rst) begin   
            col_cnt <= 0;
            row_cnt <= 0;
            run     <= 0;
        end else if(start) begin
            col_cnt <= 0;
            row_cnt <= 0;
            run     <= 1'b1;
        end else if(run) begin
            if(col_cnt == ROW_LEN-1) begin
                col_cnt <= 0;
                row_cnt <= (row_cnt == ROW_LEN-1) ? 4'd0 : row_cnt + 4'd1;
            end else begin
                col_cnt <= col_cnt + 4'd1;
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

    wire col_zero = (col_cnt == 14);   // 더미 열    → 좌·우 padding 겸용
    wire top_zero = (row_cnt ==  1);   // 출력 행 0  → top 행 0
    wire bot_zero = (row_cnt == 14);   // 출력 행 13 → bot 행 0

    wire signed [DW-1:0] bot_in = (col_zero | bot_zero) ? '0 : bot;
    wire signed [DW-1:0] mid_in = (col_zero           ) ? '0 : mid;
    wire signed [DW-1:0] top_in = (col_zero | top_zero) ? '0 : top;


    //------------------- line_buf_logic------------------------------

    always_ff @(posedge clk) begin
        line_buf_1 <= {line_buf_1[(SP-1)*DW-1:0], bot};
        line_buf_2 <= {line_buf_2[(SP-1)*DW-1:0], mid};
    end

    /*
    //------------- 3*3 Convolution kernel logic ---------------------
    // index 곱셈 변경
    logic signed [DW-1:0] w [0:8];
    logic 

    always_ff @(posedge clk) begin
        for(int i = 0; i < 3; i++) begin
            w[i*3+0] <= w[i*3+1]; // 각 row의 0번 자리에 1번 내용으로 옮김
            w[i*3+1] <= w[i*3+2]; // 각 row의 1번 자리에 2번 내용으로 옮김
        end

        w[2] <= top_in; // 오른쪽으로 shift
        w[5] <= mid_in; 
        w[8] <= bot_in;
    end
    */
    
    //--------------------------------------------------------------
    localparam   PARALLEL_DEPTH = 3;

    wire  signed [DW-1:0] a_top_in [0:2];
    wire  signed [DW-1:0] a_mid_in [0:2];
    wire  signed [DW-1:0] a_bot_in [0:2];

    wire  signed [  47:0] pc_top   [0:1];
    wire  signed [  47:0] pc_mid   [0:1];
    wire  signed [  47:0] pc_bot   [0:1];

    /*
    logic        run_dsp;
    logic        line_buf_valid;
    */

    logic signed [47:0] top_out, mid_out, bot_out;

    assign a_top_in[0] = top_in;
    assign a_mid_in[0] = mid_in;
    assign a_bot_in[0] = bot_in;

    dsp48_mul mac_top1(.CLK(clk),
                   .A(a_top_in[0]),
                   .B(weight[32 +: 16]), //weight
                   .P(),
                   .ACOUT(a_top_in[1]),
                   .PCOUT(pc_top[0])
                   );

    dsp48_mac mac_top2(.CLK(clk),
                   .A(a_top_in[1]),
                   .B(weight[16 +: 16]), //weight
                   .P(),
                   .ACOUT(a_top_in[2]),
                   .PCOUT(pc_top[1]),
                   .PCIN(pc_top[0])
                   );

    dsp48_mac mac_top3(.CLK(clk),
                   .A(a_top_in[2]),
                   .B(weight[0 +: 16]), //weight
                   .P(top_out),
                   .ACOUT(),
                   .PCOUT(),
                   .PCIN(pc_top[1])
                   );
    //---------------------------------------------------------------

    dsp48_mul mac_mid1(.CLK(clk),
                   .A(a_mid_in[0]),
                   .B(weight[80 +: 16]), //weight
                   .P(),
                   .ACOUT(a_mid_in[1]),
                   .PCOUT(pc_mid[0])
                   );

    dsp48_mac mac_mid2(.CLK(clk),
                   .A(a_mid_in[1]),
                   .B(weight[64 +: 16]), //weight
                   .P(),
                   .ACOUT(a_mid_in[2]),
                   .PCOUT(pc_mid[1]),
                   .PCIN(pc_mid[0])
                   );

    dsp48_mac mac_mid3(.CLK(clk),
                   .A(a_mid_in[2]),
                   .B(weight[48 +: 16]), //weight
                   .P(mid_out),
                   .ACOUT(),
                   .PCOUT(),
                   .PCIN(pc_mid[1])
                   );

    //---------------------------------------------------------------

    dsp48_mul mac_bot1(.CLK(clk),
                   .A(a_bot_in[0]),
                   .B(weight[128 +: 16]), //weight
                   .P(),
                   .ACOUT(a_bot_in[1]),
                   .PCOUT(pc_bot[0])
                   );

    dsp48_mac mac_bot2(.CLK(clk),
                   .A(a_bot_in[1]),
                   .B(weight[112 +: 16]), //weight
                   .P(),
                   .ACOUT(a_bot_in[2]),
                   .PCOUT(pc_bot[1]),
                   .PCIN(pc_bot[0])
                   );

    dsp48_mac mac_bot3(.CLK(clk),
                   .A(a_bot_in[2]),
                   .B(weight[96 +: 16]), //weight
                   .P(bot_out),
                   .ACOUT(),
                   .PCOUT(),
                   .PCIN(pc_bot[1])
                   );

    always_ff @(posedge clk) begin 
        data_out <= top_out + mid_out + bot_out;
    end
    
    /*
    //------------------------- Multiply ---------------------------
    // 추후에 DSP 9개로 교체하여 한 번에 accumulation까지 진행할 예정
    logic signed [3*DW-1:0] sum;

    always_comb begin
        sum = 0;
        for(int i = 0; i < 9; i++) begin
            sum = sum + w[i] * $signed(weight[i*DW +: DW]);
        end
    end

    always_ff @(posedge clk) begin
        data_out <= sum;
    end
    //--------------------------------------------------------------
    */

    
endmodule