`timescale 1ns / 1ps

module tb_pointwise;

    import pointwise_pkg::*;

    localparam integer CLK_PERIOD_NS      = 10;
    localparam integer TOTAL_OUTPUTS      = WEIGHT_WIDTH * CHANNEL_WIDTH;
    localparam integer TOTAL_MAC_CYCLES   = IN_CH * TOTAL_OUTPUTS / PARALLEL_CH;
    localparam integer TIMEOUT_CYCLES     = TOTAL_MAC_CYCLES
                                              + (2 * TOTAL_OUTPUTS)
                                              + 10_000;
    localparam string  OUTPUT_FILE        = "pointwise_output.hex";

    logic                   clk;
    logic                   rst;
    logic                   start;
    logic                   done_w;
    logic                   done_r;
    logic [15:0]            data_out;

    wire                    output_data_valid;

    integer output_fd;
    integer read_count;
    integer done_w_count;
    integer done_r_count;
    integer unknown_count;

    pointwise dut (
        .clk          (clk),
        .rst          (rst),
        .start        (start),
        .done_w       (done_w),
        .done_r       (done_r),
        .data_out     (data_out),
        .output_data_valid(output_data_valid)
    );

    always #(CLK_PERIOD_NS/2) clk = ~clk;

    // 합성 후에도 보존되는 DUT 출력 포트로 전체 read 개수를 자동 집계한다.
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            read_count    = 0;
            done_w_count  = 0;
            done_r_count  = 0;
            unknown_count = 0;
        end else begin
            if (output_data_valid) begin
                read_count = read_count + 1;
                $fdisplay(output_fd, "%04h", data_out);

                if ($isunknown(data_out)) begin
                    unknown_count = unknown_count + 1;
                    if (unknown_count <= 10)
                        $error("[%0t] output[%0d] contains X/Z: %h",
                               $time, read_count - 1, data_out);
                end
            end

            if (done_w) begin
                done_w_count = done_w_count + 1;
                $display("[%0t] output BRAM write complete", $time);
            end

            if (done_r)
                done_r_count = done_r_count + 1;

        end
    end

    initial begin
        clk           = 1'b0;
        rst           = 1'b0;
        start         = 1'b0;


        repeat(50) @(posedge clk);
        rst           = 1'b1;
        @(posedge clk); rst = 1'b0;


        // DUT 내부 Input BRAM은 blk_mem_gen_input에 설정한 COE 초기값을 사용한다.

        output_fd = $fopen(OUTPUT_FILE, "w");
        if (output_fd == 0)
            $fatal(1, "cannot open %s", OUTPUT_FILE);

        repeat (5) @(posedge clk);
        @(negedge clk);
        rst = 1'b0;

        repeat (5) @(posedge clk);

        // start는 정확히 한 clock pulse만 인가한다.
        @(negedge clk);
        start = 1'b1;
        @(negedge clk);
        start = 1'b0;
        $display("[%0t] pointwise start", $time);

        // 정상 완료를 기다리되 DUT가 멈추면 무한 시뮬레이션이 되지 않도록
        // 예상 연산량보다 여유 있는 watchdog을 함께 실행한다.
        fork
            begin : wait_for_completion
                wait (done_r === 1'b1);
            end
            begin : watchdog
                repeat (TIMEOUT_CYCLES) @(posedge clk);
                $fatal(1,
                       "timeout: reads=%0d done_w=%0d done_r=%0d",
                       read_count, done_w_count, done_r_count);
            end
        join_any
        disable fork;

        // done_r이 올라온 edge 다음 edge에서 마지막 synchronous BRAM
        // read data가 monitor에 집계된다.
        @(posedge clk);
        @(negedge clk);
        $fclose(output_fd);

        $display("--------------------------------------------------");
        $display("reads        : %0d / %0d", read_count, TOTAL_OUTPUTS);
        $display("done_w pulses: %0d", done_w_count);
        $display("done_r pulses: %0d", done_r_count);
        $display("X/Z outputs  : %0d", unknown_count);
        $display("result file  : %s", OUTPUT_FILE);
        $display("--------------------------------------------------");

        if ((read_count        != TOTAL_OUTPUTS) ||
            (done_w_count      != 1)             ||
            (done_r_count      != 1)             ||
            (unknown_count     != 0)) begin
            $fatal(1, "[FAIL] pointwise automatic test failed");
        end

        $display("[PASS] pointwise automatic test passed");
        $finish;
    end

endmodule
