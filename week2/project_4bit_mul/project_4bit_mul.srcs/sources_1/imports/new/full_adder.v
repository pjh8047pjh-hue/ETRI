`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/29 16:47:30
// Design Name: 
// Module Name: full_adder
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


module full_adder(

    output cout, sum,
    input a, b, cin
    
    );
    
        half_adder dut1 (
        .a(a),
        .b(b),
        .sum(s1),
        .carry(c1)
    );

        half_adder dut2 (
        .a(cin),
        .b(s1),
        .sum(sum),
        .carry(c2)
    );

    wire s1, c1, c2;
    
    assign cout = c1 | c2;    
    
endmodule
