`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/07 11:36:32
// Design Name: 
// Module Name: tb_depth_top
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


module tb_depth_top;

    localparam integer DW = 16;
    localparam integer SP = 15;     // 행 주기 = 라인버퍼 깊이
    localparam integer W  = 14;     // 실제 IFM 폭

    // input_data -> data_out 지연.  DSP 구성 바꾸면 이 값만 고치기
    //   2 : PCOUT->PCIN 홉 2번 (체인 3개)
    //   1 : 최종 가산 레지스터
    localparam integer LAT = 7;

    logic                   clk_in;
    logic                   rst;
    logic                   start;
    logic signed [  DW-1:0] input_data;
    logic signed [9*DW-1:0] weight;
    logic signed [3*DW-1:0] data_out;

    integer exp_p [0:LAT];
    logic   vld_p [0:LAT];
    integer err, chk;

    integer f, n, i;


    depth_top dut(.clk_in(clk_in),
                  .rst(rst),
                  .start(start),
                  .input_data(input_data),
                  .data_out(data_out)
                  );
                  
    always #12.5 clk_in = ~clk_in; // 실제 board의 input


    wire clk = dut.clk;

    //--------------------------------------------------------------------
    // 기대값 : 입력이 프레임 위치 n = r*15+c 이고 weight 가 전부 1 이므로
    //          출력 = 범위 안에 있는 3x3 이웃의 n 값을 그냥 더한 것
    //--------------------------------------------------------------------
    function integer golden(input integer r, input integer c);
        integer acc, ii, jj, rr, cc;
        begin
            acc = 0;
            for (ii = 0; ii < 3; ii = ii + 1)
                for (jj = 0; jj < 3; jj = jj + 1) begin
                    rr = r + ii - 1;
                    cc = c + jj - 1;
                    if (rr >= 0 && rr < W && cc >= 0 && cc < W)
                        acc = acc + (rr*SP + cc);      // 범위 밖 = zero padding
                end
            golden = acc;
        end
    endfunction
    //--------------------------------------------------------------------
    // 기대값을 LAT clk 지연시켜 data_out 과 맞춘다
    //   exp_p[0]   : input_data 를 넣는 시점
    //   exp_p[LAT] : data_out 이 나오는 시점
    //--------------------------------------------------------------------



    always @(posedge clk) begin
        if (vld_p[LAT]) begin
            chk = chk + 1;
            if (data_out !== exp_p[LAT]) err = err + 1;
        end
        for (i = LAT; i > 0; i = i - 1) begin
            exp_p[i] <= exp_p[i-1];
            vld_p[i] <= vld_p[i-1];
        end
    end
    //--------------------------------------------------------------------

    initial begin
        clk_in     = 1'b0;
        rst        = 1'b1;
        start      = 1'b0;
        input_data = 0;
        err        = 0;
        chk        = 0;

        for (i = 0; i <= LAT; i = i + 1) begin
            exp_p[i] = 0;
            vld_p[i] = 1'b0;
        end

        repeat (5) @(posedge clk);
        @(posedge clk); rst <= 1'b0;
        repeat (2) @(posedge clk);

        // start는 첫 픽셀보다 한 clock 앞에 준다
        @(posedge clk); start <= 1'b1;
        @(posedge clk); start <= 1'b0;

        //   n = row_cnt*15 + col_cnt  이므로 window 안의 값이 곧 주소가 된다
        for (f = 0; f < 2; f = f + 1)
            for (n = 0; n < SP*SP; n = n + 1) begin
                input_data <= n;

                if (n/SP >= 1 && n%SP >= 1) begin      // 유효 출력 위치
                    vld_p[0] <= 1'b1;
                    exp_p[0] <= golden(n/SP - 1, n%SP - 1);
                end else begin
                    vld_p[0] <= 1'b0;
                    exp_p[0] <= 0;
                end

                @(posedge clk);
            end

        vld_p[0] <= 1'b0;
        repeat (LAT + 4) @(posedge clk);

        $display("--------------------------------------------------");
        $display(" LAT     : %0d", LAT);
        $display(" checked : %0d / %0d", chk, 2*196);
        $display(" errors  : %0d", err);
        $display("--------------------------------------------------");
        $finish;
    end

endmodule
