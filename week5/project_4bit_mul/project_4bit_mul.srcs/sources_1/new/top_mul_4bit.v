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
    output done
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

    FSM_mul FSM_mul(.clk(clk), 
                    .rst_n(rst_n), 
                    .start(start), 
                    .clr(clr),
                    .acc_en(acc_en),
                    .shift_sel(shift_sel),
                    .cstate(cstate),
                    .sel_a(sel_a),
                    .sel_b(sel_b),
                    .done(done)
                    );

    selector selector(.a(a), 
                    .b(b), 
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

    uart_rx uart_rx();

endmodule
