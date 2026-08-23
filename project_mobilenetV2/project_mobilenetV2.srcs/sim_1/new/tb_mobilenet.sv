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
    logic [13:0] result_addr;
    wire done;
    wire [15:0] result;

    mobilenetV2 dut(.clk_in(clk_in),
                    .rst(rst),
                    .start(start),
                    .result_addr(result_addr)
    );

    assign done   = dut.done;
    assign result = dut.result;


    always #5 clk_in = ~clk_in; // 100 MHz PS PL clock

    initial begin
        clk_in = 1'b0;
        rst    = 1'b1;
        start  = 1'b0;
        result_addr = '0;

        // 40 MHz 입력 기준 50클럭 = 1.25 us
        // 이 시간 동안 Clock Wizard가 안정화됨
        wait(dut.clk_locked === 1'b1);
        repeat (2) @(posedge clk_in);

        // 내부 450 MHz 클럭에 맞춰 reset 해제
        @(posedge clk_in);
        rst <= 1'b0;

        repeat (4) @(posedge clk_in);

        // start는 내부 클럭 기준 정확히 1클럭
        @(posedge clk_in);
        start <= 1'b1;
        repeat (2) @(posedge clk_in);
        start <= 1'b0;

        wait (done === 1'b1);
        repeat (20) @(posedge dut.clk);
        $finish;
    end


endmodule
