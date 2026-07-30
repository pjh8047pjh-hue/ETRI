`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/29 15:40:36
// Design Name: 
// Module Name: tb_mul_9_by_9
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


module tb_mul_9_by_9();

    reg clk;
    reg rst;
    reg start;
    wire [15:0] data_out;
    wire        done_w;
    wire        done_r;
    wire [ 3:0] step;

    always #5 clk = ~clk;

    mult_9_by_9 dut(.clk(clk),
                    .rst(rst),
                    .start(start),
                    .data_out(data_out),
                    .done_w(done_w),
                    .done_r(done_r),
					.step(step)
                    );

       initial begin
        clk     = 0;
        rst     = 0;
        start   = 0;

        repeat(5) @(posedge clk);
        rst <= 1;
        @(posedge clk);
        rst <= 0;

        repeat(5) @(posedge clk);

        @(posedge clk);
        start <= 1;
        @(posedge clk);
        start <= 0;

        repeat(5) @(posedge clk);

        repeat(500) @(posedge clk);
        
        $finish;
    end

endmodule
