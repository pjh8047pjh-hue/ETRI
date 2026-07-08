`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/02 14:52:44
// Design Name: 
// Module Name: bcd2ssd
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

module bcd2ssd(
    input [3:0] bcd,
    output reg [6:0] ssd 
    );
    
    always @(*) begin
        case (bcd)
            0: ssd = 7'b1111110;
            1: ssd = 7'b0110000;
            2: ssd = 7'b1101101;
            3: ssd = 7'b1111001;
            4: ssd = 7'b0110011;
            5: ssd = 7'b1011011;
            6: ssd = 7'b1011111;
            7: ssd = 7'b1110000;
            8: ssd = 7'b1111111;
            9: ssd = 7'b1110011;
            default: ssd = 7'b1111110;
        endcase
    end    
endmodule
