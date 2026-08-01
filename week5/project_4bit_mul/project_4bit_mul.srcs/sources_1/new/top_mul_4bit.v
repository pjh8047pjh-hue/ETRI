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
    input clk, rst_n, start,
    input [WIDTH-1:0] a,
    input [WIDTH-1:0] b,
    output [2*WIDTH-1:0] result,
    output done,
    input  rx_data,
    output tx_data
    );

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

    wire ctrl_busy;
    wire ctrl_mul_start;
    wire [WIDTH-1:0] ctrl_mul_a, ctrl_mul_b;
    wire ctrl_tx_start;
    wire [7:0] ctrl_tx_din;

    // ctrl(uart_mul_ctrl)가 동작 중일 때만 UART로 받은 a/b/start가 곱셈기를 구동하고,
    // 그 외에는 top-level a/b/start 포트(테스트벤치/스위치)가 그대로 곱셈기를 구동함
    wire [WIDTH-1:0] mux_a     = ctrl_busy ? ctrl_mul_a     : a;
    wire [WIDTH-1:0] mux_b     = ctrl_busy ? ctrl_mul_b     : b;
    wire             mux_start = ctrl_busy ? ctrl_mul_start : start;

    FSM_mul FSM_mul(.clk(clk),
                    .rst_n(rst_n),
                    .start(mux_start),
                    .clr(clr),
                    .acc_en(acc_en),
                    .shift_sel(shift_sel),
                    .cstate(cstate),
                    .sel_a(sel_a),
                    .sel_b(sel_b),
                    .done(done)
                    );

    selector selector(.a(mux_a),
                    .b(mux_b),
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

    adder adder(.clk(clk),
                .rst_n(rst_n),
                .acc_en(acc_en),
                .clr(clr),
                .mul(mul),
                .result(result)
                );

    baudrate_gen baudrate_gen (.clk_in(clk),
                            .rst_n(rst_n),
                            .baud_tick(baud_tick));

    uart_rx uart_rx(.baud_clk(baud_tick),
                .rst_n(rst_n),
                .rx_data(rx_data),
                .rx_done(rx_done),
                .dout(rx_dout)
                );

    uart_mul_ctrl #(.WIDTH(WIDTH)) uart_mul_ctrl (
                .clk(clk),
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

    // picocom -> rx -> a,b 캡처 -> 곱셈 -> result 상/하위 바이트 -> tx -> picocom
    uart_tx uart_tx(.baud_tick(baud_tick),
                .rst_n(rst_n),
                .start(ctrl_tx_start),
                .din(ctrl_tx_din),
                .tx_data(tx_data),
                .busy(tx_busy)
                );

endmodule
