`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2026 12:18:53 PM
// Design Name: 
// Module Name: tb_mobilenet
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


module tb_mobilenet(

    );

    logic clk_in;
    logic rst;
    logic start;
    logic done;
    logic [15:0] result;

    mobilenetV2 dut(.clk_in(clk_in),
                    .rst(rst),
                    .start(start),
                    .done(done), 
                    .result(result)
    );


    always #12.5 clk_in = ~clk_in; // 실제 board의 input

    wire clk = dut.clk;

    initial begin
        clk_in     = 1'b0;
        rst        = 1'b1;
        start      = 1'b0;


        repeat (5) @(posedge clk);
        @(posedge clk); rst <= 1'b0;
        repeat (2) @(posedge clk);

        @(posedge clk); start <= 1'b1;
        @(posedge clk); start <= 1'b0;

        wait(done === 1'b1);
        repeat (20) @(posedge clk);
        $finish;
    end


endmodule
