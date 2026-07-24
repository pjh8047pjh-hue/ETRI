`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/03/2026 10:38:41 PM
// Design Name: 
// Module Name: FSM_mul
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


module FSM_mul(
    input clk, rst_n, start,
    
    output reg clr,
    output reg acc_en,
    output reg [1:0] shift_sel,
    output reg [2:0] cstate,
    output reg sel_a,
    output reg sel_b,
    output reg done   
    );

    localparam IDLE = 3'd0;
    localparam CALC_0 = 3'd1;
    localparam CALC_1 = 3'd2;
    localparam CALC_2 = 3'd3;
    localparam CALC_3 = 3'd4;
    localparam DONE = 3'd5;

    reg [2:0] nstate;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) cstate <= IDLE;
        else cstate <= nstate;
    end

    always @(*) begin
        nstate = cstate;

        case(cstate)
            IDLE : nstate = start ? CALC_0 : IDLE;
            CALC_0 : nstate = CALC_1;
            CALC_1 : nstate = CALC_2;
            CALC_2 : nstate = CALC_3;
            CALC_3 : nstate = DONE;
            DONE : nstate = IDLE;
            default : nstate = IDLE;
        endcase
    end

    always @(*) begin
        sel_a     = 0;
        sel_b     = 0;
        shift_sel = 0;
        acc_en    = 0;
        clr       = 0;
        done      = 0;

        case(cstate)
            IDLE : clr = 1;

            CALC_0 : begin
                sel_a = 0;
                sel_b = 0;
                shift_sel = 2'd0;
                acc_en = 1;
            end

            CALC_1 : begin
                sel_a = 1;
                sel_b = 0;
                shift_sel = 2'd1;
                acc_en = 1;
            end 

            CALC_2 : begin
                sel_a = 0;
                sel_b = 1;
                shift_sel = 2'd1;
                acc_en = 1;
            end

            CALC_3 : begin
                sel_a = 1;
                sel_b = 1;
                shift_sel = 2'd2;
                acc_en = 1;
            end 

            DONE : begin
                done = 1;
            end 
        endcase
    end
endmodule
