`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/03 16:29:30
// Design Name: 
// Module Name: uart_tx
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


module uart_tx(
    input clk, rst, en,
    input [7:0] din
    output reg [7:0] tx_data
    );
    
    reg start;
    reg [3:0] cnt = 4'd8;

    baudrate_gen baudrate_gen (.clk_in(clk), .rst(rst), .baud_tick(en));

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            din <= 0;
            en <= 0;
            cnt <= 0;
            start <= 0;
        end

        if (en) start == 0;
            if (cnt <= 8) begin
                tx_data[8 - cnt] <= din[8 - cnt];
                cnt <= cnt - 1;
            end
            else if (cnt == 1) cnt <= 4'd8;
        else start <= 1;
    end   
endmodule
