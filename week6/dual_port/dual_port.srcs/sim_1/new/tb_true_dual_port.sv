`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/28 18:00:50
// Design Name: 
// Module Name: tb_true_dual_port
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

module tb_true_dual_port();

    reg clk;
    reg rst;
    reg start_w;
    reg start_r;
    wire [15:0] data_out;
    wire        done_w;
    wire        done_r;

    always #5 clk = ~clk;

    true_dual_port dut(.clk(clk),
                        .rst(rst),
                        .start_w(start_w),
                        .start_r(start_r),
                        .data_out1(data_out1),
                        .data_out2(data_out2),
                        .done_w(done_w),
                        .done_r(done_r)
                        );
       initial begin
        clk     = 0;
        rst     = 0;
        start_w = 0;
        start_r = 0;

        repeat(5) @(posedge clk);
        rst <= 1;
        @(posedge clk);
        rst <= 0;

        repeat(5) @(posedge clk);

        @(posedge clk);
        start_w <= 1;
        @(posedge clk);
        start_w <= 0;

        repeat(100) @(posedge clk);

        @(posedge clk);
        start_r <= 1;
        @(posedge clk);
        start_r <= 0;


        repeat(150) @(posedge clk);
        
        $finish;
    end

endmodule