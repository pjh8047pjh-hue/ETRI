`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/28 10:01:34
// Design Name: 
// Module Name: tb_single_port_ram
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


module tb_single_port_ram();
    
    reg clk;
    reg rst;
    reg start_w;
    reg start_r;
    reg [6:0]addra;
    reg [6:0]addrb;

    always #5 clk = ~clk;
    
    single_dual_ram dut(.clk(clk),
                        .rst(rst),
                        .start_w(start_w)
                        .start_r(start_r),
                        .addra(addra),
                        .addrb(addrb)
                        );
    
    initial begin
        clk     = 0;
        rst     = 0;
        start   = 0;
        addra   = 0;
        addrb   = 0;
        
        repeat(5) @(posedge clk); rst <= 1;
        @(posedge clk); rst <= 0;

        repeat(5) @(posedge clk);

        @(posedge clk); start <= 1; 
        @(posedge clk); start <= 0; 
        
        if(start_w) addra <= 0;
        else if(addra != 7'd99) @(posedge clk) addra <= addra + 7'd1;
        else if(addra == 7'd99) @(posedge clk) addra <= 7'd0;

        repeat(5) @(posedge clk);
        
        if(start_r) addrb <= 0;
        else if(addrb != 7'd99) @(posedge clk) addrb <= addrb + 7'd1;
        else if(addrb == 7'd99) @(posedge clk) addrb <= 7'd0;

        repeat(100) @(posedge clk);
    
        $finish;
    end

endmodule
