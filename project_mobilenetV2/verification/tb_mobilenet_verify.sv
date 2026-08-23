`timescale 1ns / 1ps

module tb_mobilenet_verify;
    localparam int PW_REAL_COUNT   = 37632;
    localparam int PW_STREAM_COUNT = 49152;
    localparam int DEPTH_COUNT     = 37632;
    localparam int P2_ISSUE_COUNT  = 37632;
    localparam int P2_OUTPUT_COUNT = 12544;

    logic clk_in = 1'b0;
    logic rst    = 1'b1;
    logic start  = 1'b0;
    logic [13:0] result_addr = '0;
    wire done;
    wire [15:0] result;

    mobilenetV2 dut (
        .clk_in (clk_in), .rst (rst), .start (start),
        .result_addr (result_addr),
        .done (done), .result (result)
    );

    // The project Clock Wizard is configured for a 100 MHz primary input.
    always #5 clk_in = ~clk_in;

    integer cycle_count, error_count;
    integer pw_real_count, pw_stream_count, pw_done_count;
    integer start_depth_count, depth_valid_count, write_done_count;
    integer p2_issue_count, p2_output_count, done_count;
    integer stream_pair, stream_slot, stream_row, stream_col, stream_pixel;
    integer depth_pair, depth_pixel, expected_even, expected_odd, golden_value;
    integer previous_sched_pair, previous_sched_slot;
    logic schedule_seen, stream_seen, report_finished, done_seen;

    function automatic integer golden_pw_q312(
        input integer channel, input integer pixel
    );
        integer value, bias_index, bias_q312;
        begin
            bias_index = channel % 8;
            case (bias_index)
                0: bias_q312 = 0;
                1: bias_q312 = 1024;
                2: bias_q312 = 2048;
                3: bias_q312 = 3072;
                4: bias_q312 = 4096;
                5: bias_q312 = -1024;
                6: bias_q312 = -2048;
                default: bias_q312 = -4096;
            endcase
            value = pixel * 64 + (channel % 64) + bias_q312;
            if (value <= 0)           golden_pw_q312 = 0;
            else if (value >= 24576)  golden_pw_q312 = 24576;
            else                      golden_pw_q312 = value;
        end
    endfunction

    function automatic integer golden_depth_q312(
        input integer channel, input integer pixel
    );
        integer row, col, rr, cc, acc, bias_real;
        begin
            row = pixel / 14;
            col = pixel % 14;
            acc = 0;
            for (integer dr = -1; dr <= 1; dr = dr + 1) begin
                for (integer dc = -1; dc <= 1; dc = dc + 1) begin
                    rr = row + dr;
                    cc = col + dc;
                    if ((rr >= 0) && (rr < 14) && (cc >= 0) && (cc < 14))
                        acc = acc + golden_pw_q312(channel, rr * 14 + cc);
                end
            end
            bias_real = channel % 8;
            if (bias_real == 7) bias_real = -1;
            acc = acc + bias_real * 4096;
            if (acc <= 0)           golden_depth_q312 = 0;
            else if (acc >= 24576)  golden_depth_q312 = 24576;
            else                    golden_depth_q312 = acc;
        end
    endfunction

    function automatic integer golden_p2_q34(input integer output_index);
        integer output_channel, pixel, value, bias_q312, skip_q312;
        begin
            output_channel = output_index / 196;
            pixel = output_index % 196;
            bias_q312 = (output_channel + 1) * 64;
            if ((output_channel % 2) == 1) bias_q312 = -bias_q312;
            skip_q312 = 2 * (pixel * 64 + output_channel);
            value = golden_depth_q312(6 * output_channel, pixel)
                  + bias_q312 + skip_q312;
            value = value & 16'hffff;
            if (value >= 32768) value = value - 65536;
            golden_p2_q34 = value;
        end
    endfunction

    task automatic check_condition(input logic condition, input string message);
        if (!condition) begin
            error_count = error_count + 1;
            if (error_count <= 40)
                $display("VERIFY_ERROR cycle=%0d time=%0t : %s",
                         cycle_count, $time, message);
        end
    endtask

    task automatic print_summary;
        if (!report_finished) begin
            report_finished = 1'b1;
            $display("VERIFY_SUMMARY cycles=%0d errors=%0d", cycle_count, error_count);
            $display("VERIFY_COUNT pw_real=%0d expected=%0d", pw_real_count, PW_REAL_COUNT);
            $display("VERIFY_COUNT pw_stream=%0d expected=%0d", pw_stream_count, PW_STREAM_COUNT);
            $display("VERIFY_COUNT pw_done=%0d expected=1", pw_done_count);
            $display("VERIFY_COUNT start_depth=%0d expected=1", start_depth_count);
            $display("VERIFY_COUNT depth_valid=%0d expected=%0d", depth_valid_count, DEPTH_COUNT);
            $display("VERIFY_COUNT write_done=%0d expected=1", write_done_count);
            $display("VERIFY_COUNT p2_issue=%0d expected=%0d", p2_issue_count, P2_ISSUE_COUNT);
            $display("VERIFY_COUNT p2_output=%0d expected=%0d", p2_output_count, P2_OUTPUT_COUNT);
            $display("VERIFY_COUNT done=%0d expected=1", done_count);
            check_condition(pw_real_count == PW_REAL_COUNT, "PW1 real-result count mismatch");
            check_condition(pw_stream_count == PW_STREAM_COUNT, "PW1 padded-stream count mismatch");
            check_condition(pw_done_count == 1, "PW1 padded done count mismatch");
            check_condition(start_depth_count == 1, "Depth start pulse count mismatch");
            check_condition(depth_valid_count == DEPTH_COUNT, "Depth pair-result count mismatch");
            check_condition(write_done_count == 1, "D2P write_done count mismatch");
            check_condition(p2_issue_count == P2_ISSUE_COUNT, "PW2 issue count mismatch");
            check_condition(p2_output_count == P2_OUTPUT_COUNT, "PW2 output count mismatch");
            check_condition(done_count == 1, "Top done count mismatch");
            $display("VERIFY_FINAL errors=%0d", error_count);
        end
    endtask

    // Sample the scheduler before its counters advance.
    always @(posedge dut.clk) begin
        if (!rst && dut.u_pointwise_before_depth.run) begin
            if (schedule_seen && (previous_sched_slot == 255)) begin
                check_condition(dut.u_pointwise_before_depth.slot_cnt == 0,
                                "PW1 slot did not wrap after slot 255");
                check_condition(dut.u_pointwise_before_depth.channel_pair_cnt
                                == previous_sched_pair + 1,
                                "PW1 pair did not advance after slot 255");
            end
            if (dut.u_pointwise_before_depth.inside_slot)
                check_condition(dut.pointwise_input_rd_addr
                                == ((dut.u_pointwise_before_depth.slot_cnt[7:4] - 1) * 14
                                  + (dut.u_pointwise_before_depth.slot_cnt[3:0] - 1)),
                                "PW1 interior address mismatch");
            else
                check_condition(dut.pointwise_input_rd_addr == 0,
                                "PW1 padding address must be zero");
            if (dut.u_pointwise_before_depth.slot_cnt == 8'd17)
                check_condition(dut.pointwise_input_rd_addr == 8'd0,
                                "slot 17 must map to pixel 0");
            if (dut.u_pointwise_before_depth.slot_cnt == 8'd238)
                check_condition(dut.pointwise_input_rd_addr == 8'd195,
                                "slot 238 must map to pixel 195");
            previous_sched_pair = dut.u_pointwise_before_depth.channel_pair_cnt;
            previous_sched_slot = dut.u_pointwise_before_depth.slot_cnt;
            schedule_seen = 1'b1;
        end
    end

    always @(posedge dut.clk) begin
        #1ps;
        if (rst) begin
            cycle_count = 0;
            error_count = 0;
            pw_real_count = 0;
            pw_stream_count = 0;
            pw_done_count = 0;
            start_depth_count = 0;
            depth_valid_count = 0;
            write_done_count = 0;
            p2_issue_count = 0;
            p2_output_count = 0;
            done_count = 0;
            previous_sched_pair = 0;
            previous_sched_slot = 0;
            schedule_seen = 1'b0;
            stream_seen = 1'b0;
            report_finished = 1'b0;
            done_seen = 1'b0;
        end else begin
            cycle_count = cycle_count + 1;

            if (stream_seen && (pw_stream_count < PW_STREAM_COUNT))
                check_condition(dut.pointwise_before_depth_valid === 1'b1,
                                "PW1 padded stream contains a valid gap");

            if (dut.pointwise_before_depth_valid === 1'b1) begin
                stream_seen = 1'b1;
                stream_pair = pw_stream_count / 256;
                stream_slot = pw_stream_count % 256;
                stream_row = stream_slot / 16;
                stream_col = stream_slot % 16;
                stream_pixel = (stream_row - 1) * 14 + (stream_col - 1);
                check_condition(!$isunknown(dut.pointwise_before_depth_out),
                                "PW1 stream contains X/Z");
                if ((stream_row >= 1) && (stream_row <= 14)
                 && (stream_col >= 1) && (stream_col <= 14)) begin
                    expected_even = golden_pw_q312(2 * stream_pair, stream_pixel);
                    expected_odd = golden_pw_q312(2 * stream_pair + 1, stream_pixel);
                    check_condition(dut.u_pointwise_before_depth.core_valid === 1'b1,
                                    "PW1 core valid missing on interior slot");
                    check_condition($signed(dut.pointwise_before_depth_out[15:0]) == expected_even,
                                    "PW1 even-lane golden mismatch");
                    check_condition($signed(dut.pointwise_before_depth_out[31:16]) == expected_odd,
                                    "PW1 odd-lane golden mismatch");
                end else begin
                    check_condition(dut.u_pointwise_before_depth.core_valid === 1'b0,
                                    "PW1 core valid asserted on padding");
                    check_condition(dut.pointwise_before_depth_out === 32'sd0,
                                    "PW1 padding is not a zero pair");
                end
                check_condition(dut.pointwise_before_depth_done
                                === (pw_stream_count == PW_STREAM_COUNT-1),
                                "PW1 done is not aligned to final slot");
                pw_stream_count = pw_stream_count + 1;
            end

            if (dut.u_pointwise_before_depth.core_valid === 1'b1)
                pw_real_count = pw_real_count + 1;
            if (dut.pointwise_before_depth_done === 1'b1)
                pw_done_count = pw_done_count + 1;

            if (dut.start_depth === 1'b1) begin
                start_depth_count = start_depth_count + 1;
                check_condition(pw_stream_count == 1,
                                "Depth start must match first PW1 stream slot");
            end

            if (dut.depthwise_output_valid === 1'b1) begin
                depth_pair = depth_valid_count / 196;
                depth_pixel = depth_valid_count % 196;
                expected_even = golden_depth_q312(2 * depth_pair, depth_pixel);
                expected_odd = golden_depth_q312(2 * depth_pair + 1, depth_pixel);
                check_condition(!$isunknown(dut.depthwise_data_out),
                                "Depth output contains X/Z");
                check_condition($signed(dut.depthwise_data_out[15:0]) == expected_even,
                                "Depth even-channel golden mismatch");
                check_condition($signed(dut.depthwise_data_out[31:16]) == expected_odd,
                                "Depth odd-channel golden mismatch");
                if (depth_valid_count < 8)
                    $display("VERIFY_SAMPLE DEPTH n=%0d got={%0d,%0d} expected={%0d,%0d}",
                             depth_valid_count,
                             $signed(dut.depthwise_data_out[31:16]),
                             $signed(dut.depthwise_data_out[15:0]),
                             expected_odd, expected_even);
                depth_valid_count = depth_valid_count + 1;
            end

            if (dut.write_done === 1'b1)
                write_done_count = write_done_count + 1;

            if (dut.pad.run === 1'b1) begin
                p2_issue_count = p2_issue_count + 1;
                check_condition(dut.input_rd_addr_a <= 11'd1175,
                                "PW2 address A is out of range");
                check_condition(dut.input_rd_addr_b <= 11'd1175,
                                "PW2 address B is out of range");
            end

            if (dut.pointwise_after_depth_valid === 1'b1) begin
                check_condition(!$isunknown(dut.pointwise_after_depth_out_full),
                                "Final output contains X/Z");
                golden_value = golden_p2_q34(p2_output_count);
                check_condition($signed(dut.pointwise_after_depth_out_full) == golden_value,
                                "Final output does not match golden");
                p2_output_count = p2_output_count + 1;
            end

            if ((done === 1'b1) && !done_seen) begin
                done_seen = 1'b1;
                done_count = done_count + 1;
                check_condition(p2_output_count == P2_OUTPUT_COUNT,
                                "Top done preceded final output completion");
            end
        end
    end

    initial begin
        wait(dut.clk_locked === 1'b1);
        repeat (2) @(posedge clk_in);
        rst <= 1'b0;
        repeat (4) @(posedge clk_in);
        @(posedge clk_in); start <= 1'b1;
        repeat (2) @(posedge clk_in);
        start <= 1'b0;
        fork
            begin
                wait(done === 1'b1);
                // Read back all locations through the software-visible port.
                // Five core clocks cover the 2-FF address CDC, address mux
                // sampling, and the registered BRAM output.
                for (integer read_index = 0;
                     read_index < P2_OUTPUT_COUNT; read_index = read_index + 1) begin
                    @(negedge dut.clk);
                    result_addr = read_index[13:0];
                    repeat (5) @(posedge dut.clk);
                    #1ps;
                    golden_value = golden_p2_q34(read_index);
                    if (read_index < 8)
                        $display("VERIFY_RAM n=%0d sync_addr=%0d got=%0d expected=%0d",
                                 read_index, dut.result_addr_core,
                                 $signed(result), golden_value);
                    check_condition(!$isunknown(result),
                                    "Stored final output contains X/Z");
                    check_condition($signed(result) == golden_value,
                                    "Stored final output does not match golden");
                end
                print_summary();
                $finish;
            end
            begin
                repeat (150000) @(posedge dut.clk);
                check_condition(1'b0, "timeout waiting for top done");
                print_summary();
                $finish;
            end
        join_any
        disable fork;
    end
endmodule
