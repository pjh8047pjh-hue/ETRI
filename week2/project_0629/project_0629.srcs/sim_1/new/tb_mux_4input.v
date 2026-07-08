`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/30 13:07:24
// Design Name: 
// Module Name: tb_mux_4input
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

module tb_mux_4input;
    reg [3:0] a, b, c, d;
    reg [1:0] sel;
    wire [3:0] q;

    mux_4bit dut(
        .a(a),
        .b(b),
        .c(c),
        .d(d),
        .sel(sel),
        .q(q)
    );

    initial begin
        a = 4'b0001; b = 4'b0010; c = 4'b0011; d = 4'b0100;
        sel = 2'b00; #10;
        sel = 2'b01; #10;
        sel = 2'b10; #10;
        sel = 2'b11; #10;  // q2 = a = 1
        $finish;
    end
    
endmodule
