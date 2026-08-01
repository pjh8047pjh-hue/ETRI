`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 07/05/2026 06:22:18 PM
// Design Name:
// Module Name: tb_top_mul_4bit
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


module tb_top_mul_4bit();

    localparam WIDTH = 8;
    localparam CHUNK = 4;

    // DUT의 baudrate_gen이 기본 파라미터(CLK_FREQ=100_000_000, BAUD_RATE=1_152_000)로
    // 인스턴스화되어 있으므로, tb의 클럭(10ns = 100MHz)과 짝을 맞춰 비트 주기를 계산함
    localparam CLK_PERIOD_NS = 10;
    localparam BAUD_DIV      = 100_000_000 / 1_152_000; // baudrate_gen의 DIVISOR와 동일
    localparam BIT_TIME_NS   = BAUD_DIV * CLK_PERIOD_NS; // UART 비트 1개 구간(ns)

    reg clk;
    reg rst_n;
    reg start;
    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;

    reg  rx_data; // tb -> DUT (피코콤이 보내는 것을 흉내)
    wire tx_data; // DUT -> tb (피코콤이 받는 것을 흉내)

    wire [2*WIDTH-1:0] result;
    wire done;

    // DUT (Device Under Test)
    top_mul_4bit #(
        .WIDTH(WIDTH),
        .CHUNK(CHUNK)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .a(a),
        .b(b),
        .result(result),
        .done(done),
        .rx_data(rx_data),
        .tx_data(tx_data)
    );

    // 클럭 생성 (주기 10ns)
    always #5 clk = ~clk;

    // ------------------------------------------------------------------
    // 곱셈 1건 수행 + 결과 확인 (top 포트 a/b/start 직접 구동 경로)
    // ------------------------------------------------------------------
    task run_test(input [WIDTH-1:0] a_in, input [WIDTH-1:0] b_in);
        begin
            a = a_in;
            b = b_in;

            @(posedge clk);
            start = 1;
            @(posedge clk);
            start = 0;

            wait (done);
            #1;
            if (result == a_in * b_in)
                $display("PASS : %0d x %0d = %0d", a_in, b_in, result);
            else
                $display("FAIL : %0d x %0d = %0d (expected %0d)", a_in, b_in, result, a_in * b_in);

            @(posedge clk); // done -> IDLE 로 돌아갈 시간
        end
    endtask

    // ------------------------------------------------------------------
    // UART 1바이트 송신 (tb -> DUT rx_data) : start(0) - data[0..7] LSB first - stop(1)
    // uart_rx가 매 baud_tick마다 그대로 샘플링하므로, 비트 구간 내내 값만 유지하면 됨
    // ------------------------------------------------------------------
    task uart_send_byte(input [7:0] data);
        integer i;
        begin
            rx_data = 1'b0;               // start bit
            #BIT_TIME_NS;
            for (i = 0; i < 8; i = i + 1) begin
                rx_data = data[i];         // data bit (LSB first)
                #BIT_TIME_NS;
            end
            rx_data = 1'b1;                // stop bit
            #BIT_TIME_NS;
        end
    endtask

    // ------------------------------------------------------------------
    // UART 1바이트 수신 (DUT tx_data -> tb) : 표준 UART 수신처럼 비트 중앙에서 샘플링
    // ------------------------------------------------------------------
    task uart_recv_byte(output [7:0] data);
        integer i;
        begin
            @(negedge tx_data);            // start bit 시작 엣지
            #(BIT_TIME_NS + BIT_TIME_NS/2); // start bit 건너뛰고 data[0] 비트 중앙으로 이동
            for (i = 0; i < 8; i = i + 1) begin
                data[i] = tx_data;
                if (i < 7) #BIT_TIME_NS;
            end
        end
    endtask

    // ------------------------------------------------------------------
    // UART 경로로 곱셈 1건 수행 + 결과 확인 (a, b 순서로 전송 -> hi byte, lo byte 수신)
    // ------------------------------------------------------------------
    task run_uart_test(input [7:0] a_in, input [7:0] b_in);
        reg [7:0]  hi, lo;
        reg [15:0] result_uart;
        begin
            uart_send_byte(a_in);
            uart_send_byte(b_in);

            uart_recv_byte(hi);
            uart_recv_byte(lo);
            result_uart = {hi, lo};

            if (result_uart == a_in * b_in)
                $display("UART PASS : %0d x %0d = %0d", a_in, b_in, result_uart);
            else
                $display("UART FAIL : %0d x %0d = %0d (expected %0d)", a_in, b_in, result_uart, a_in * b_in);

            wait (dut.ctrl_busy == 1'b0); // uart_mul_ctrl이 S_WAIT_A로 돌아올 때까지 대기
        end
    endtask

    initial begin
        clk    = 0;
        rst_n  = 0;
        start  = 0;
        a      = 0;
        b      = 0;
        rx_data = 1'b1; // UART idle == high

        #12 rst_n = 1; // 리셋 해제

        // top 포트 a/b/start 직접 구동 경로
        run_test(8'd13, 8'd7);
        run_test(8'd255, 8'd255);
        run_test(8'd0, 8'd9);

        // UART(rx/tx) 경로 : 벡터 1~2개만 간단히 점검
        run_uart_test(8'd3, 8'd4);
        run_uart_test(8'd15, 8'd15);

        $finish;
    end

endmodule
