`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/30 14:53:45
// Design Name: 
// Module Name: tb_counter_8bit
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

module tb_counter_8bit();

    reg clk, reset;
    reg [1:0] func;
    reg [7:0] d;
    wire [7:0] q;

    counter_8bit uut(
        .clk(clk), .reset(reset),
        .func(func), .d(d), .q(q)
    );

    initial begin clk = 0; forever #10 clk = ~clk; end

    initial begin
        reset = 1; func = 2'b00; d = 8'd0;
        #20 reset = 0;

        func = 2'b00; d = 8'd2; #20;
        func = 2'b01; #20; 
        func = 2'b10; #20;
        func = 2'b00; #20;

        #100 $stop;
    end

endmodule

