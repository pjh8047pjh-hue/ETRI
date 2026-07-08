`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/02 14:44:17
// Design Name: 
// Module Name: FSM
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


module FSM(
    input rst,clk,hold,start,
    output reg cstate
);

localparam START=1'b1,HOLD=1'b0;
reg nstate;
always @(posedge clk or negedge  rst) begin
    if (rst==1'b0) cstate<=START;
    else begin
    cstate<=nstate;

    end
end
always @(*)begin
    case(cstate)
        START:if (hold==1'b1)nstate=HOLD;
              else nstate=START;
        HOLD:if (start==1'b1)nstate=START;
              else nstate=HOLD;
        default: nstate=START;
    endcase
end
endmodule
