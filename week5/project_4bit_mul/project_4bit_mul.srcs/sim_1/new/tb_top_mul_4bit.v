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

    reg clk;
    reg rst_n;
    reg start;
    reg [WIDTH-1:0] a;
    reg [WIDTH-1:0] b;

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
        .done(done)
    );

    // 클럭 생성 (주기 10ns)
    always #5 clk = ~clk;

    // 곱셈 1건 수행 + 결과 확인
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

    initial begin
        clk   = 0;
        rst_n = 0;
        start = 0;
        a     = 0;
        b     = 0;

        #12 rst_n = 1; // 리셋 해제

        run_test(8'd13, 8'd7);
        run_test(8'd255, 8'd255);
        run_test(8'd0, 8'd9);

        $finish;
    end

endmodule
