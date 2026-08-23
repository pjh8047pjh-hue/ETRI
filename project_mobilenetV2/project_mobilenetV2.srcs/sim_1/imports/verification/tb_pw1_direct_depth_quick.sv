`timescale 1ns / 1ps

module tb_pw1_direct_depth_quick;
    logic clk = 1'b0;
    logic rst = 1'b1;
    logic start = 1'b0;

    logic signed [1023:0] input_rd_data;
    logic signed [1023:0] input_rd_data_d1;
    wire [7:0] input_rd_addr;
    wire input_rd_en;
    wire pw_done;
    wire pw_valid;
    wire signed [31:0] pw_data;

    logic pw_valid_d;
    wire start_depth = pw_valid && !pw_valid_d;
    wire depth_valid;
    wire signed [31:0] depth_data;

    integer error_count;
    integer stream_count;
    integer depth_count;
    integer start_depth_count;
    integer previous_pair;
    integer previous_slot;
    logic schedule_seen;
    logic stream_seen;

    always #5 clk = ~clk;

    top_pointwise_before_depth u_pw1 (
        .clk (clk), .rst (rst), .start (start),
        .input_rd_data (input_rd_data),
        .input_rd_addr (input_rd_addr),
        .input_rd_en (input_rd_en),
        .done (pw_done),
        .output_valid (pw_valid),
        .pointwise_before_depth_out (pw_data)
    );

    depth_top #(.SP(16), .DW(16)) u_depth (
        .clk (clk), .rst (rst), .start (start_depth),
        .input_data (pw_data),
        .depth_output_valid (depth_valid),
        .data_out (depth_data)
    );

    // Two-cycle input BRAM model. Every lane is +1.0 Q3.12, so the expected
    // PW1 pair 0 interior word is always {3072, 2048}.
    always_ff @(posedge clk) begin
        if (rst) begin
            input_rd_data_d1 <= '0;
            input_rd_data <= '0;
            pw_valid_d <= 1'b0;
        end else begin
            if (input_rd_en) begin
                input_rd_data_d1 <= {64{16'sh1000}};
                input_rd_data <= input_rd_data_d1;
            end
            pw_valid_d <= pw_valid;
        end
    end

    task automatic check(input logic condition, input string message);
        if (!condition) begin
            error_count++;
            if (error_count <= 20)
                $display("QUICK_ERROR time=%0t stream=%0d depth=%0d : %s",
                         $time, stream_count, depth_count, message);
        end
    endtask

    function automatic integer neighbor_count(input integer pixel);
        integer row, col, rows, cols;
        begin
            row = pixel / 14;
            col = pixel % 14;
            rows = ((row == 0) || (row == 13)) ? 2 : 3;
            cols = ((col == 0) || (col == 13)) ? 2 : 3;
            neighbor_count = rows * cols;
        end
    endfunction

    function automatic integer clamp_q312(input integer value);
        if (value <= 0)          clamp_q312 = 0;
        else if (value >= 24576) clamp_q312 = 24576;
        else                     clamp_q312 = value;
    endfunction

    // Scheduler/address checks are sampled away from the active edge.
    always @(negedge clk) begin
        if (!rst && u_pw1.run) begin
            if (schedule_seen && (previous_slot == 255)) begin
                check(u_pw1.slot_cnt == 0, "slot did not wrap after 255");
                check(u_pw1.channel_pair_cnt == previous_pair + 1,
                      "pair did not increment after slot 255");
            end
            if (u_pw1.slot_cnt == 17)
                check(input_rd_addr == 0, "slot 17 did not map to pixel 0");
            if (u_pw1.slot_cnt == 238)
                check(input_rd_addr == 195, "slot 238 did not map to pixel 195");
            previous_pair = u_pw1.channel_pair_cnt;
            previous_slot = u_pw1.slot_cnt;
            schedule_seen = 1'b1;
        end
    end

    always @(negedge clk) begin
        integer slot, row, col, pixel, taps;
        integer expected_even, expected_odd;

        if (!rst) begin
            if (start_depth)
                start_depth_count++;

            if (stream_seen && (stream_count < 257))
                check(pw_valid === 1'b1, "padded stream contains a gap");

            if (pw_valid && (stream_count < 257)) begin
                stream_seen = 1'b1;
                slot = stream_count % 256;
                row = slot / 16;
                col = slot % 16;
                check(!$isunknown(pw_data), "PW1 output contains X/Z");
                if ((row >= 1) && (row <= 14) && (col >= 1) && (col <= 14)) begin
                    check(u_pw1.core_valid, "core_valid missing on interior");
                    if (stream_count < 256)
                        check(pw_data == 32'h0c00_0800,
                              "pair 0 interior result is not {3072,2048}");
                end else begin
                    check(!u_pw1.core_valid, "core_valid asserted on padding");
                    check(pw_data == 0, "padding output is not zero");
                end
                stream_count++;
            end

            if (depth_valid && (depth_count < 196)) begin
                pixel = depth_count;
                taps = neighbor_count(pixel);
                expected_even = clamp_q312(taps * 2048);
                expected_odd = clamp_q312(taps * 3072 + 4096);
                check(!$isunknown(depth_data), "Depth output contains X/Z");
                check($signed(depth_data[15:0]) == expected_even,
                      "Depth even output mismatch");
                check($signed(depth_data[31:16]) == expected_odd,
                      "Depth odd output mismatch");
                if (depth_count < 4)
                    $display("QUICK_DEPTH n=%0d got=%h expected={%0d,%0d}",
                             depth_count, depth_data, expected_odd, expected_even);
                depth_count++;
            end

            if ((stream_count >= 257) && (depth_count >= 196)) begin
                check(start_depth_count == 1, "start_depth pulse count is not one");
                if (error_count == 0)
                    $display("QUICK_PASS: pair0 256-slot stream and 196 Depth outputs match");
                else
                    $display("QUICK_FAIL: %0d error(s)", error_count);
                $finish;
            end
        end
    end

    initial begin
        error_count = 0;
        stream_count = 0;
        depth_count = 0;
        start_depth_count = 0;
        previous_pair = 0;
        previous_slot = 0;
        schedule_seen = 1'b0;
        stream_seen = 1'b0;
        repeat (4) @(negedge clk);
        rst = 1'b0;
        @(negedge clk); start = 1'b1;
        @(negedge clk); start = 1'b0;
        repeat (1000) @(negedge clk);
        $fatal(1, "QUICK_TIMEOUT");
    end
endmodule

