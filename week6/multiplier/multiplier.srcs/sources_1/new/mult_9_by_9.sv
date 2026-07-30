`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/29 14:19:43
// Design Name: 
// Module Name: mult_9_by_9
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


module mult_9_by_9(
    input  logic clk,
    input  logic rst,
    input  logic start,

    output logic        done_w,
    output logic        done_r,
    output logic [ 3:0] step,
    output logic [15:0] data_out
    );

    logic [ 7:0] A;
    logic [ 7:0] B;
    logic [15:0] P;

    logic start_w;
    logic [1:0] write_delay;

    assign step = A;

    //----------------- module instance -----------------
    mul_mem mem(.clk(clk),
                .rst(rst),
                .start_w(start_w),
                .start_r(done_w),
                .dina(P),
                .data_out(data_out),
                .done_w(done_w),
                .done_r(done_r)
                );

    mult_gen_0 dut(.CLK(clk),
                   .A(A),
                   .B(B),
                   .P(P)
                   );

    //-------------------multiply logic---------------
    logic en_mul;

    always_ff @(posedge clk or posedge rst) begin 
        if(rst) begin
            write_delay <= 1;
            start_w     <= 0;
        end else begin
            start_w <= 1'b0;
            if(en_mul) begin
                if(write_delay != 0 && write_delay != 2'd2) begin
                    write_delay <= write_delay + 2'd1;
                end else if (write_delay != 0) begin
                    start_w     <= 1'b1;
                    write_delay <= 0;
                end
            end
        end
    end

    always_ff @(posedge clk or posedge rst) begin 
        if(rst) begin
            en_mul  <= 0;
        end else if(start) begin
            en_mul <= 1;
        end else if(step == 8'd10) en_mul <= 0;
    end

    always_ff @(posedge clk or posedge rst) begin 
        if(rst) begin
            A <= 8'd2;
            B <= 8'd1;
        end else if(en_mul) begin
            if(A <= 8'd9) begin
                if(B != 8'd9) begin 
                    B <= B + 1'd1;
                end else if(B == 8'd9) begin
                    A <= A + 8'd1;
                    B <= 1'd1;  
                end
            end else if(A == 8'd10) begin // reset
                A <= 8'd2;
                B <= 8'd1;
            end
        end
    end
    //------------------------------------------------

endmodule
