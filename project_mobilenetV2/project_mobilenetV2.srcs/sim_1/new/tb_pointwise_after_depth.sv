`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2026/08/13 00:37:32
// Design Name:
// Module Name: tb_pointwise_after_depth
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
// input/weight BRAM이 top 안에 있으므로 TB는 clk/rst/start만 준다.
//////////////////////////////////////////////////////////////////////////////////


module tb_pointwise_after_depth();
    logic clk_in;
    logic rst;
    logic start;

    logic        done;
    logic        output_valid;
    logic signed [50:0] pointwise_after_depth_out;

    always #12.5 clk_in = ~clk_in; // 실제 board의 input (40MHz)

    wire clk = dut.clk; // clk_wiz_0가 만든 내부 100MHz 클럭

    top_pointwise_after_depth dut(.clk_in(clk_in),
                            .rst(rst),
                            .start(start),
                            .done(done),
                            .output_valid(output_valid),
                            .pointwise_after_depth_out(pointwise_after_depth_out)
    );

    //------------------- checker -------------------
    // 출력 순서는 (ch0,p0)...(ch0,p195), (ch1,p0)... 이므로 픽셀은 k % 196.
    // all-1 weight라 채널이 달라도 값은 같다.
    localparam int TOTAL_OUT = 196 * 64;

    int p, err;

    function automatic int exp_of(int k);
        return 768 + 384*((k % 196) % 8);
    endfunction


    always_ff @(posedge clk) begin
        if (rst) begin
            p   <= 0;
            err <= 0;
        end
        else if (output_valid) begin
            if (pointwise_after_depth_out !== exp_of(p)) begin
                $display("[%0t] k=%0d ch=%0d pix=%0d  got=%0d  exp=%0d  MISMATCH",
                         $time, p, p/196, p%196, pointwise_after_depth_out, exp_of(p));
                err <= err + 1;
            end
            p <= p + 1;
        end
    end


    initial begin
        clk_in     = 1'b0;
        rst        = 1'b1;
        start      = 1'b0;

        repeat (50) @(posedge clk);
        @(posedge clk); rst <= 1'b0;
        repeat (10) @(posedge clk);

        @(posedge clk); start <= 1'b1;
        @(posedge clk); start <= 1'b0;

        fork
            begin
                wait(done);
                @(posedge clk);
                $display("DONE : %0d / %0d outputs, %0d errors", p, TOTAL_OUT, err);
            end
            begin
                // 64채널 x 1176clk = 75,264clk + latency
                repeat (80_000) @(posedge clk);
                $display("TIMEOUT : %0d / %0d outputs, %0d errors", p, TOTAL_OUT, err);
            end
        join_any

        $finish;
    end


endmodule
