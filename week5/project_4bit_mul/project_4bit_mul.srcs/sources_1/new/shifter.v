`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/04/2026 11:09:06 PM
// Design Name: 
// Module Name: shifter
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


module shifter #(
    parameter WIDTH = 8,
    parameter CHUNK = 4
)(
    input [2*CHUNK-1:0] mul_init,
    input [1:0] shift_sel,
    output reg [2*WIDTH-1:0] mul
    );

    wire [2*WIDTH-1:0] mul_ext;
    
    assign mul_ext = {{(2*WIDTH-2*CHUNK){1'b0}}, mul_init};

    always @(*) begin
        case(shift_sel)
            2'd0 : mul = mul_ext;
            2'd1 : mul = mul_ext << CHUNK;
            2'd2 : mul = mul_ext << WIDTH;
            default : mul = 0;
        endcase
    end

endmodule
