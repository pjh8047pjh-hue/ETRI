`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/27 15:51:36
// Design Name: 
// Module Name: tb_top_single_rom
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


module tb_top_single_rom();
    
    reg clk;
    reg rst;
    reg start_r;

    always #5 clk = ~clk;
    
    top_single_rom dut(.clk(clk),
                       .rst(rst),
                       .start_r(start_r)
                       );
    
    initial begin
        clk     = 0;
        rst     = 0;
        start_r = 0;
        
        repeat(100) @(posedge clk); rst <= 1;
        @(posedge clk); rst <= 0;

        @(posedge clk); start_r <= 1; 
        @(posedge clk); start_r <= 0; 
        
        repeat(100) @(posedge clk);
    
        $finish;
    end
    
endmodule