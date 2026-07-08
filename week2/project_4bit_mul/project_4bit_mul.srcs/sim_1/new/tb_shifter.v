`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/06/30 15:10:26
// Design Name: 
// Module Name: tb_shifter
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


module tb_shifter();
    reg [7:0] inp;
    reg [1:0] shift_cntrl;
    wire [15:0] shift_out;
    
    shifter dut(.inp(inp), .shift_cntrl(shift_cntrl), .shift_out(shift_out));

    initial begin

        shift_cntrl = 2'b00; inp = 8'd0; #20;
        $display("%d %d", shift_cntrl, inp, shift_out);
        inp = 8'd4; #20;
        $display("%d %d", shift_cntrl, inp, shift_out);
        shift_cntrl = 2'b01; inp = 8'd4; #20;
        $display("%d %d", shift_cntrl, inp, shift_out);
        shift_cntrl = 2'b01; #20;
        $display("%d %d", shift_cntrl, inp, shift_out);
        shift_cntrl = 2'b10; #20;
        $display("%d %d", shift_cntrl, inp, shift_out);
        shift_cntrl = 2'b00;
        $display("%d %d", shift_cntrl, inp, shift_out);

        #100 $stop;
    end

    
endmodule
