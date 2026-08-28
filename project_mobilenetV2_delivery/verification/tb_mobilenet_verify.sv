`timescale 1ns / 1ps

module tb_mobilenet_verify;
    logic        clk_in = 1'b0;
    logic        rst    = 1'b1;
    logic        start  = 1'b0;
    logic        done;
    logic [15:0] result;

    mobilenetV2 dut (
        .clk_in (clk_in),
        .rst    (rst),
        .start  (start),
        .done   (done),
        .result (result)
    );

    always #12.5 clk_in = ~clk_in;

    integer cycle_count;
    integer error_count;
    integer pw_mac_count;
    integer pw_stream_count;
    integer start_depth_count;
    integer depth_valid_count;
    integer write_done_count;
    integer p2_issue_count;
    integer p2_output_count;
    integer done_count;
    integer p2_zero_count;
    integer p2_six_count;
    integer p2_other_count;
    integer pw_mac_value_errors;
    integer depth_q34_zero_count;
    integer depth_q34_nonzero_count;
    integer depth_q312_min;
    integer depth_q312_max;
    integer p2_sum_nonzero_count;
    integer p2_bias_value_errors;
    integer depth_value_errors;
    integer p2_value_errors;
    integer golden_value;

    logic signed [37:0] expected_pw_result;
    logic signed [15:0] expected_depth_result;
    logic        [ 2:0] p2_read_valid_d;
    logic               report_finished;

    function automatic logic signed [15:0] clamp_depth_q312(
        input logic signed [47:0] value
    );
        begin
            if (value <= 0)
                clamp_depth_q312 = 16'sh0000;
            else if (value >= 48'sh000000006000)
                clamp_depth_q312 = 16'sh6000;
            else
                clamp_depth_q312 = value[15:0];
        end
    endfunction

    function automatic logic signed [50:0] clamp_p2(
        input logic signed [50:0] value
    );
        begin
            if (value <= 0)
                clamp_p2 = '0;
            else if (value >= 51'sh60)
                clamp_p2 = 51'sh60;
            else
                clamp_p2 = value;
        end
    endfunction

    function automatic integer golden_depth_q312(input integer output_index);
        integer ch;
        integer pix;
        integer row;
        integer col;
        integer rr;
        integer cc;
        integer acc;
        integer bias_real;
        begin
            ch  = output_index / 196;
            pix = output_index % 196;
            row = pix / 14;
            col = pix % 14;
            acc = 0;

            for (integer dr = -1; dr <= 1; dr = dr + 1) begin
                for (integer dc = -1; dc <= 1; dc = dc + 1) begin
                    rr = row + dr;
                    cc = col + dc;
                    if ((rr >= 0) && (rr < 14) && (cc >= 0) && (cc < 14))
                        acc = acc + ((rr * 14 + cc) * 64 + (ch % 64));
                end
            end

            bias_real = ch % 8;
            if (bias_real == 7)
                bias_real = -1;
            acc = acc + bias_real * 4096;

            if (acc <= 0)
                golden_depth_q312 = 0;
            else if (acc >= 24576)
                golden_depth_q312 = 24576;
            else
                golden_depth_q312 = acc;
        end
    endfunction

    function automatic integer golden_p2_q34(input integer output_index);
        integer oc;
        integer pix;
        integer value;
        integer bias_real;
        begin
            oc  = output_index / 196;
            pix = output_index % 196;
            value = golden_depth_q312((6 * oc) * 196 + pix) >>> 8;

            bias_real = oc % 8;
            if (bias_real == 7)
                bias_real = -1;
            value = value + bias_real * 16;

            if (value <= 0)
                golden_p2_q34 = 0;
            else if (value >= 96)
                golden_p2_q34 = 96;
            else
                golden_p2_q34 = value;
        end
    endfunction

    task automatic check_condition(input logic condition, input string message);
        begin
            if (!condition) begin
                error_count = error_count + 1;
                if (error_count <= 40)
                    $display("VERIFY_ERROR cycle=%0d time=%0t : %s", cycle_count, $time, message);
            end
        end
    endtask

    task automatic print_summary;
        begin
            if (!report_finished) begin
                report_finished = 1'b1;
                $display("VERIFY_SUMMARY cycles=%0d errors=%0d", cycle_count, error_count);
                $display("VERIFY_COUNT pw_mac=%0d expected=75264", pw_mac_count);
                $display("VERIFY_COUNT pw_stream=%0d expected=98304", pw_stream_count);
                $display("VERIFY_COUNT start_depth=%0d expected=1", start_depth_count);
                $display("VERIFY_COUNT depth_valid=%0d expected=75264", depth_valid_count);
                $display("VERIFY_COUNT write_done=%0d expected=1", write_done_count);
                $display("VERIFY_COUNT p2_issue=%0d expected=75264", p2_issue_count);
                $display("VERIFY_COUNT p2_output=%0d expected=12544", p2_output_count);
                $display("VERIFY_COUNT done=%0d expected=1", done_count);
                $display("VERIFY_P2_VALUES zero=%0d six=%0d other=%0d", p2_zero_count, p2_six_count, p2_other_count);
                $display("VERIFY_VALUE_ERRORS pw_mac=%0d p2_bias=%0d",
                         pw_mac_value_errors, p2_bias_value_errors);
                $display("VERIFY_GOLDEN_ERRORS depth=%0d p2=%0d",
                         depth_value_errors, p2_value_errors);
                $display("VERIFY_DEPTH_VALUES q34_zero=%0d q34_nonzero=%0d q312_min=%0d q312_max=%0d",
                         depth_q34_zero_count, depth_q34_nonzero_count,
                         depth_q312_min, depth_q312_max);
                $display("VERIFY_P2_SUM nonzero=%0d", p2_sum_nonzero_count);

                check_condition(pw_mac_count       == 75264, "PW1 MAC output count mismatch");
                check_condition(pw_stream_count    == 98304, "PW1 padded stream count mismatch");
                check_condition(start_depth_count  == 1,     "depth start pulse count mismatch");
                check_condition(depth_valid_count  == 75264, "depth output count mismatch");
                check_condition(write_done_count   == 1,     "interconnect write_done count mismatch");
                check_condition(p2_issue_count     == 75264, "PW2 BRAM issue count mismatch");
                check_condition(p2_output_count    == 12544, "PW2 output count mismatch");
                check_condition(done_count         == 1,     "top done count mismatch");
                check_condition(pw_mac_value_errors    == 0, "PW1 MAC values do not match debug COE golden");
                check_condition(p2_bias_value_errors    == 0, "PW2 bias channel alignment mismatch");
                check_condition(depth_value_errors     == 0, "Depth values do not match Q3.12 golden");
                check_condition(p2_value_errors        == 0, "PW2 values do not match Q3.4 golden");
                $display("VERIFY_FINAL errors=%0d", error_count);
            end
        end
    endtask

    // DUT와 같은 edge에서 계산되는 등록 출력의 기대값을 보존한다.
    always @(posedge dut.clk) begin
        if (rst) begin
            expected_pw_result    <= '0;
            expected_depth_result <= '0;
            p2_read_valid_d       <= '0;
        end else begin
            expected_pw_result <= dut.pointwise.pointwise_mac.final_sum >>> 12;
            expected_depth_result <= clamp_depth_q312(
                dut.depthwise.depth_mac.relu_input
            );
            p2_read_valid_d <= {p2_read_valid_d[1:0], dut.input_rd_en};
        end
    end

    always @(posedge dut.clk) begin
        #1ps;

        if (rst) begin
            cycle_count       = 0;
            error_count       = 0;
            pw_mac_count      = 0;
            pw_stream_count   = 0;
            start_depth_count = 0;
            depth_valid_count = 0;
            write_done_count  = 0;
            p2_issue_count    = 0;
            p2_output_count   = 0;
            done_count        = 0;
            p2_zero_count     = 0;
            p2_six_count      = 0;
            p2_other_count    = 0;
            pw_mac_value_errors     = 0;
            depth_q34_zero_count    = 0;
            depth_q34_nonzero_count = 0;
            depth_q312_min          = 32'h7fffffff;
            depth_q312_max          = -32'h7fffffff;
            p2_sum_nonzero_count    = 0;
            p2_bias_value_errors    = 0;
            depth_value_errors      = 0;
            p2_value_errors         = 0;
            report_finished   = 1'b0;
        end else begin
            cycle_count = cycle_count + 1;

            if (dut.pointwise.mac_result_valid === 1'b1) begin
                pw_mac_count = pw_mac_count + 1;
                check_condition(!$isunknown(dut.pointwise.mac_result), "PW1 MAC result contains X/Z");
                check_condition(dut.pointwise.mac_result === expected_pw_result,
                                "PW1 registered quantization result mismatch");
                if (pw_mac_count <= 4)
                    $display("VERIFY_SAMPLE PW1_MAC n=%0d value=%0d", pw_mac_count,
                             $signed(dut.pointwise.mac_result));

                // gen_coe.ps1 golden: out[p][oc] = p*64 + (oc mod 64)
                golden_value = ((pw_mac_count - 1) / 384) * 64
                             + ((pw_mac_count - 1) % 384) % 64;
                if ($signed(dut.pointwise.mac_result) != golden_value) begin
                    pw_mac_value_errors = pw_mac_value_errors + 1;
                    if (pw_mac_value_errors <= 8)
                        $display("VERIFY_VALUE_ERROR PW1_MAC n=%0d got=%0d expected=%0d",
                                 pw_mac_count, $signed(dut.pointwise.mac_result), golden_value);
                end
            end

            if (dut.output_data_valid === 1'b1) begin
                pw_stream_count = pw_stream_count + 1;
                check_condition(!$isunknown(dut.pointwise_data_out), "PW1 output stream contains X/Z");
                if (pw_stream_count <= 4)
                    $display("VERIFY_SAMPLE PW1_STREAM n=%0d value=%0d", pw_stream_count,
                             $signed(dut.pointwise_data_out));
            end

            if (dut.start_depth === 1'b1)
                start_depth_count = start_depth_count + 1;

            if (dut.depthwise_output_valid === 1'b1) begin
                depth_valid_count = depth_valid_count + 1;
                check_condition(!$isunknown(dut.depthwise.data_out), "depth output contains X/Z while valid");
                check_condition(dut.depthwise.data_out === expected_depth_result,
                                "depth ReLU registered result mismatch");
                check_condition(($signed(dut.depthwise.data_out) >= 0)
                             && ($signed(dut.depthwise.data_out) <= 16'sh6000),
                                "depth ReLU output is outside 0..6.0 Q3.12");
                check_condition(dut.bram_d2p.wr_data === dut.depthwise.data_out[15:8],
                                "Q3.12 to Q3.4 BRAM input mismatch");
                check_condition(!$isunknown(dut.depthwise.weight), "depth weight contains X/Z while valid");
                check_condition(!$isunknown(dut.depthwise.depth_mac.bias_data),
                                "depth bias contains X/Z while valid");
                if (depth_valid_count <= 4)
                    $display("VERIFY_SAMPLE DEPTH n=%0d q312=%0d q34=%0d bias=%0d",
                             depth_valid_count, $signed(dut.depthwise.data_out),
                             $signed(dut.bram_d2p.wr_data),
                             $signed(dut.depthwise.depth_mac.bias_data));
                if ($signed(dut.depthwise.data_out) < depth_q312_min)
                    depth_q312_min = $signed(dut.depthwise.data_out);
                if ($signed(dut.depthwise.data_out) > depth_q312_max)
                    depth_q312_max = $signed(dut.depthwise.data_out);
                if (dut.bram_d2p.wr_data == 0)
                    depth_q34_zero_count = depth_q34_zero_count + 1;
                else
                    depth_q34_nonzero_count = depth_q34_nonzero_count + 1;

                golden_value = golden_depth_q312(depth_valid_count - 1);
                if ($signed(dut.depthwise.data_out) != golden_value) begin
                    depth_value_errors = depth_value_errors + 1;
                    if (depth_value_errors <= 8)
                        $display("VERIFY_VALUE_ERROR DEPTH n=%0d got=%0d expected=%0d",
                                 depth_valid_count, $signed(dut.depthwise.data_out), golden_value);
                end
            end

            if (dut.bram_d2p.wr_valid === 1'b1) begin
                check_condition(dut.bram_d2p.wr_addr <= 11'd1175,
                                "interconnect write address out of range");
                check_condition(dut.bram_d2p.wr_lane <= 6'd63,
                                "interconnect write lane out of range");
                check_condition(!$isunknown(dut.bram_d2p.wr_data),
                                "interconnect write data contains X/Z");
            end

            if (dut.write_done === 1'b1) begin
                write_done_count = write_done_count + 1;
                $display("VERIFY_EVENT WRITE_DONE cycle=%0d depth_count=%0d", cycle_count,
                         depth_valid_count);
            end

            if (dut.pad.run === 1'b1) begin
                p2_issue_count = p2_issue_count + 1;
                check_condition(dut.input_rd_addr <= 11'd1175,
                                "PW2 input read address out of range");
                check_condition(dut.pad.weight_addr <= 9'd383,
                                "PW2 weight address out of range");
                check_condition(dut.pad.bias_addr <= 6'd63,
                                "PW2 bias address out of range");
            end

            if (p2_read_valid_d[2] === 1'b1)
                check_condition(!$isunknown(dut.input_rd_data),
                                "PW2 BRAM read data contains X/Z after read latency");

            if (dut.pointwise_after_depth_valid === 1'b1) begin
                p2_output_count = p2_output_count + 1;
                check_condition(!$isunknown(dut.pad.pointwise_after_depth_out),
                                "PW2 output contains X/Z while valid");
                check_condition(dut.pad.pointwise_after_depth_out
                             === clamp_p2(dut.pad.pad1.biased_sum),
                                "PW2 ReLU result mismatch");

                if (dut.pad.pointwise_after_depth_out == 0)
                    p2_zero_count = p2_zero_count + 1;
                else if (dut.pad.pointwise_after_depth_out == 16'h0060)
                    p2_six_count = p2_six_count + 1;
                else
                    p2_other_count = p2_other_count + 1;

                if ($signed(dut.pad.pad1.sum) != 0)
                    p2_sum_nonzero_count = p2_sum_nonzero_count + 1;

                golden_value = ((p2_output_count - 1) / 196) % 8;
                if (golden_value == 7)
                    golden_value = -1;
                golden_value = golden_value * 16;
                if ($signed(dut.pad.pad1.bias_data) != golden_value) begin
                    p2_bias_value_errors = p2_bias_value_errors + 1;
                    if (p2_bias_value_errors <= 8)
                        $display("VERIFY_VALUE_ERROR PW2_BIAS n=%0d got=%0d expected=%0d",
                                 p2_output_count, $signed(dut.pad.pad1.bias_data), golden_value);
                end

                golden_value = golden_p2_q34(p2_output_count - 1);
                if ($signed(dut.pad.pointwise_after_depth_out) != golden_value) begin
                    p2_value_errors = p2_value_errors + 1;
                    if (p2_value_errors <= 8)
                        $display("VERIFY_VALUE_ERROR PW2 n=%0d got=%0d expected=%0d",
                                 p2_output_count,
                                 $signed(dut.pad.pointwise_after_depth_out), golden_value);
                end

                if (p2_output_count <= 4)
                    $display("VERIFY_SAMPLE PW2 n=%0d sum=%0d bias=%0d output=%0d",
                             p2_output_count, $signed(dut.pad.pad1.sum),
                             $signed(dut.pad.pad1.bias_data),
                             $signed(dut.pad.pointwise_after_depth_out));
            end

            if (done === 1'b1) begin
                done_count = done_count + 1;
                $display("VERIFY_EVENT DONE cycle=%0d p2_outputs=%0d", cycle_count,
                         p2_output_count);
            end
        end
    end

    initial begin
        repeat (5) @(posedge dut.clk);
        @(posedge dut.clk); rst <= 1'b0;
        repeat (2) @(posedge dut.clk);
        @(posedge dut.clk); start <= 1'b1;
        @(posedge dut.clk); start <= 1'b0;

        fork
            begin
                wait(done === 1'b1);
                repeat (20) @(posedge dut.clk);
                print_summary();
                $finish;
            end
            begin
                repeat (300_000) @(posedge dut.clk);
                $display("VERIFY_TIMEOUT done was not asserted");
                print_summary();
                $finish;
            end
        join_any
        disable fork;
    end
endmodule
