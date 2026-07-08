`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 07/01/2026 11:46:41 PM
// Design Name:
// Module Name: tb_clock_down_counter
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


module tb_clock_down_counter();

    wire dout, done;
    reg  clk, rst, start;
    reg  [3:0] num;
    integer i;

    clock_down_counter dut (
        .clk   (clk),
        .rst   (rst),
        .start (start),
        .dout  (dout),
        .done  (done),
        .num   (num)
    );

    initial begin
        clk = 0;
        forever #25 clk = ~clk;
    end

    initial begin
        rst   = 1; #30;
        rst   = 0; #20;
        num   = 5; #10;
        start = 1; #25;
        start = 0; #50;

        for (i = 0; i < 30; i = i + 1) begin
            @(posedge clk) $display("%d %d", dout, done);
        end

        #100;

        num   = 2; #25;
        start = 1; #50;
        start = 0; #25;

        for (i = 0; i < 8; i = i + 1) begin
            @(posedge clk) $display("%d %d", dout, done);
            #25;
        end

        #250;

        $finish;
    end

endmodule
