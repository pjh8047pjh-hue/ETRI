`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2026 10:35:13 PM
// Design Name: 
// Module Name: top_mul_4bit
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


module top_mul_4bit #(
    parameter WIDTH = 8,
    parameter CHUNK = 4
)(
    input  clk,
    input  rx_data,
    output tx_data
    );

    // a/b/start/result/done은 아직 실제 핀(스위치/LED)에 안 물릴 거라 top 포트에서 빼고
    // uart_mul_ctrl이 전적으로 곱셈기를 구동하는 내부 신호로만 둠 (picocom으로 먼저 검증)
    wire done;
    wire [2*WIDTH-1:0] result;

    // Pmod96 온보드 오실레이터(40MHz) -> clk_wiz_0 -> 100MHz 내부 시스템 클럭
    wire sys_clk;
    wire clk_locked;

    clk_wiz_0 clk_wiz_0_inst (
                .clk_in1  (clk),
                .reset    (1'b0),
                .clk_out1 (sys_clk),
                .locked   (clk_locked)
                );

    reg [3:0] por_cnt = 4'd0;
    reg       rst_n   = 1'b0;
    always @(posedge sys_clk) begin
        if (!clk_locked) begin
            por_cnt <= 4'd0;
            rst_n   <= 1'b0;
        end else if (por_cnt != 4'hF) begin
            por_cnt <= por_cnt + 1'b1;
        end else begin
            rst_n <= 1'b1;
        end
    end

    wire sel_a;
    wire sel_b;
    wire clr;
    wire acc_en;
    wire [1:0] shift_sel;
    wire [2:0] cstate;
    wire [CHUNK-1:0] data_a;
    wire [CHUNK-1:0] data_b;
    wire [2*WIDTH-1:0] mul;
    wire [2*CHUNK-1:0] mul_init;

    wire baud_tick;
    wire rx_done;
    wire [7:0] rx_dout;
    wire tx_busy;
    wire rx_busy;

    wire ctrl_busy;
    wire ctrl_mul_start;
    wire [WIDTH-1:0] ctrl_mul_a, ctrl_mul_b;
    wire ctrl_tx_start;
    wire [7:0] ctrl_tx_din;

    FSM_mul FSM_mul(.clk(sys_clk),
                    .rst_n(rst_n),
                    .start(ctrl_mul_start),
                    .clr(clr),
                    .acc_en(acc_en),
                    .shift_sel(shift_sel),
                    .cstate(cstate),
                    .sel_a(sel_a),
                    .sel_b(sel_b),
                    .done(done)
                    );

    selector selector(.a(ctrl_mul_a),
                    .b(ctrl_mul_b),
                    .sel_a(sel_a),
                    .sel_b(sel_b),
                    .data_a(data_a),
                    .data_b(data_b)
                    );

    mul_4bit mul_4bit(.data_a(data_a),
                    .data_b(data_b),
                    .mul_init(mul_init)
                    );

    shifter shifter(.mul_init(mul_init),
                    .shift_sel(shift_sel),
                    .mul(mul)
                    );

    adder adder(.clk(sys_clk),
                .rst_n(rst_n),
                .acc_en(acc_en),
                .clr(clr),
                .mul(mul),
                .result(result)
                );

    // baud 카운터는 항상 동작시킨다. 이전의 active 게이팅은 start bit를
    // 감지한 다음 clk에 바로 꺼져 baud_tick이 전혀 나오지 않았다.
    baudrate_gen baudrate_gen (.clk_in(sys_clk),
                            .rst_n(rst_n),
                            .en(1'b1),
                            .baud_tick(baud_tick));

    uart_rx uart_rx(.clk(sys_clk),
                .rst_n(rst_n),
                .baud_tick(baud_tick),
                .rx_data(rx_data),
                .rx_done(rx_done),
                .dout(rx_dout),
                .busy(rx_busy)
                );

    uart_mul_ctrl #(.WIDTH(WIDTH)) uart_mul_ctrl (
                .clk(sys_clk),
                .rst_n(rst_n),
                .rx_done(rx_done),
                .rx_dout(rx_dout),
                .mul_start(ctrl_mul_start),
                .mul_done(done),
                .mul_result(result),
                .mul_a(ctrl_mul_a),
                .mul_b(ctrl_mul_b),
                .busy(ctrl_busy),
                .tx_start(ctrl_tx_start),
                .tx_din(ctrl_tx_din),
                .tx_busy(tx_busy)
                );

    // picocom 1자리 hex 입력 2개 -> 곱셈 -> 2자리 hex 결과 -> picocom
    uart_tx uart_tx(.clk(sys_clk),
                .rst_n(rst_n),
                .baud_tick(baud_tick),
                .start(ctrl_tx_start),
                .din(ctrl_tx_din),
                .tx_data(tx_data),
                .busy(tx_busy)
                );

endmodule
