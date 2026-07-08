`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/30 11:27:31
// Design Name: 
// Module Name: tb_mux_2input
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

`timescale 1ns / 1ps

module tb_mux_2input;
    reg [3:0] a, b, c;
    reg       sela, selb;
    wire [3:0] q1, q2;

    mux_2input dut1(
        .a(a),
        .b(b),
        .sel(selb),
        .q(q1)
    );

    initial begin
        a = 4'b0001; b = 4'b0010; c = 4'b0011;
        sela = 1; #10;
        selb = 0; #10;  // q2 = a = 1
        sela = 0; #10;
        selb = 1; #10;  // q2 = b = 2
        sela = 1; #10;
        selb = 0; #10;  // q2 = c = 3
        sela = 1; #10;
        selb = 1; #10;  // q2 = c = 3
        $finish;
    end
    
endmodule

