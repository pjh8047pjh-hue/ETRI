`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/30 13:57:12
// Design Name: 
// Module Name: tb_mem
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


module tb_mem_weight_in();

    // 선언이 인스턴스보다 먼저 와야 한다.
    // 아니면 clk/rst/start_r 이 암묵적 wire 로 먼저 잡혀서,
    // initial 블록이 구동하는 logic 변수와 다른 객체가 되어 DUT 에 전달되지 않는다.
    logic clk;
    logic rst;
    logic start_r;

    logic [15:0] data_out;
    logic        done_r;

    mem_weight_in dut1(.clk(clk),
                    .rst(rst),
                    .start_r(start_r),
                    .data_out(data_out),
                    .done_r(done_r)
                    );

    always #5 clk = ~clk;

       initial begin
        clk     = 0;
        rst     = 0;
        start_r = 0;

        repeat(5) @(posedge clk);
        rst <= 1;
        @(posedge clk);
        rst <= 0;

        repeat(5) @(posedge clk);

        @(posedge clk);
        start_r <= 1;
        @(posedge clk);
        start_r <= 0;

        repeat(500) @(posedge clk);
        
        $finish;
    end

endmodule
