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
    logic                   input_start_w;
    logic [IN_CH*16-1:0]     input_data;
    logic                   input_done_w;
    logic                   done_w;
    logic                   done_r;
    logic [15:0]            data_out;

    // Vivado가 simulation top의 신호를 wave에 자동 추가했을 때 주요 DUT
    // 상태도 바로 보이도록 내부 신호를 testbench 레벨로 끌어낸다.
    wire [1:0]              fsm_state;
    wire                    mem_read_req;
    wire                    en_mul;
    wire [5:0]              ic_cnt;
    wire [8:0]              oc_cnt;
    wire [7:0]              pix_cnt;
    wire signed [37:0]      mac_result;
    wire                    mac_result_valid;
    wire                    output_data_valid;

    integer output_fd;
    integer write_count;
    integer read_count;
    integer done_w_count;
    integer done_r_count;
    integer unknown_count;

    pointwise dut (
        .clk          (clk),
        .rst          (rst),
        .start        (start),
        .input_start_w(input_start_w),
        .input_data   (input_data),
        .input_done_w(input_done_w),
        .done_w       (done_w),
        .done_r       (done_r),
        .data_out     (data_out)
    );

    assign fsm_state         = dut.FSM.cstate;
    assign mem_read_req      = dut.mem_read_req;
    assign en_mul            = dut.en_mul;
    assign ic_cnt            = dut.ic_cnt;
    assign oc_cnt            = dut.oc_cnt;
    assign pix_cnt           = dut.pix_cnt;
    assign mac_result        = dut.mac_result;
    assign mac_result_valid  = dut.mac_result_valid;
    assign output_data_valid = dut.output_data_valid;

    always #(CLK_PERIOD_NS/2) clk = ~clk;

    // DUT 내부의 valid 신호를 이용해 전체 write/read 개수를 자동 집계한다.
    // data_valid는 아직 pointwise의 외부 포트가 아니므로 계층 참조한다.
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            write_count   = 0;
            read_count    = 0;
            done_w_count  = 0;
            done_r_count  = 0;
            unknown_count = 0;
        end else begin
            if (mac_result_valid)
                write_count = write_count + 1;

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
                $display("[%0t] output BRAM write complete (%0d/%0d)",
                         $time, write_count, TOTAL_OUTPUTS);
            end

            if (done_r)
                done_r_count = done_r_count + 1;

            // 전체 내부 신호는 waveform에서 볼 수 있고, 콘솔에는 픽셀 단위
            // 진행률만 출력해서 수백만 cycle의 로그 폭주를 막는다.
            if (en_mul && (ic_cnt == 0) && (oc_cnt == 0)) begin
                if ((pix_cnt % 16) == 0 ||
                    (pix_cnt == CHANNEL_WIDTH - 1))
                    $display("[%0t] processing pixel %0d/%0d",
                             $time, pix_cnt, CHANNEL_WIDTH - 1);
            end
        end
    end

    initial begin
        clk           = 1'b0;
        rst           = 1'b1;
        start         = 1'b0;
        input_start_w = 1'b0;
        input_data    = '0;

        // Input BRAM은 blk_mem_gen_input에 설정한 COE 초기값을 사용한다.
        // 테스트벤치에서는 input write 포트를 구동하지 않는다.

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
                       "timeout: ic=%0d oc=%0d pix=%0d writes=%0d reads=%0d",
                       ic_cnt, oc_cnt, pix_cnt,
                       write_count, read_count);
            end
        join_any
        disable fork;

        // done_r이 올라온 edge 다음 edge에서 마지막 synchronous BRAM
        // read data가 monitor에 집계된다.
        @(posedge clk);
        @(negedge clk);
        $fclose(output_fd);

        $display("--------------------------------------------------");
        $display("writes       : %0d / %0d", write_count, TOTAL_OUTPUTS);
        $display("reads        : %0d / %0d", read_count, TOTAL_OUTPUTS);
        $display("done_w pulses: %0d", done_w_count);
        $display("done_r pulses: %0d", done_r_count);
        $display("X/Z outputs  : %0d", unknown_count);
        $display("result file  : %s", OUTPUT_FILE);
        $display("--------------------------------------------------");

        if ((write_count       != TOTAL_OUTPUTS) ||
            (read_count        != TOTAL_OUTPUTS) ||
            (done_w_count      != 1)             ||
            (done_r_count      != 1)             ||
            (unknown_count     != 0)) begin
            $fatal(1, "[FAIL] pointwise automatic test failed");
        end

        $display("[PASS] pointwise automatic test passed");
        $finish;
    end

endmodule
