`timescale 1ns / 1ps

module tb_top_pointwise_before_depth;

    localparam int PIXELS_PER_PAIR = 196;
    localparam int SLOTS_PER_PAIR  = 256;
    localparam int PAIRS           = 192;
    localparam int REAL_TOTAL      = PIXELS_PER_PAIR * PAIRS;
    localparam int STREAM_TOTAL    = SLOTS_PER_PAIR  * PAIRS;

    logic clk = 1'b0;
    logic rst;
    logic start;
    logic signed [1023:0] input_rd_data;
    logic signed [1023:0] input_rd_data_d1;
    logic [7:0] input_rd_addr;
    logic input_rd_en;
    logic done;
    logic output_valid;
    logic signed [31:0] pointwise_before_depth_out;

    int real_request_count;
    int core_output_count;
    int stream_output_count;
    int error_count;
    bit stream_started;

    always #5 clk = ~clk;

    top_pointwise_before_depth dut (
        .clk                        (clk),
        .rst                        (rst),
        .start                      (start),
        .input_rd_data              (input_rd_data),
        .input_rd_addr              (input_rd_addr),
        .input_rd_en                (input_rd_en),
        .done                       (done),
        .output_valid               (output_valid),
        .pointwise_before_depth_out (pointwise_before_depth_out)
    );

    // Model the input BRAM's two-cycle registered read path.
    always_ff @(posedge clk) begin
        if (rst) begin
            input_rd_data_d1 <= '0;
            input_rd_data    <= '0;
        end else if (input_rd_en) begin
            input_rd_data_d1 <= {64{16'sh1000}};
            input_rd_data    <= input_rd_data_d1;
        end
    end

    always @(posedge clk) begin
        int expected_pair;
        int expected_pixel;

        if (!rst && dut.inside_slot) begin
            expected_pair  = real_request_count / PIXELS_PER_PAIR;
            expected_pixel = real_request_count % PIXELS_PER_PAIR;

            if (input_rd_addr !== expected_pixel[7:0]) begin
                $error("input address got=%0d expected=%0d",
                       input_rd_addr, expected_pixel);
                error_count++;
            end
            if (dut.weight_addr_even !== (expected_pair * 2)) begin
                $error("weight address got=%0d expected=%0d",
                       dut.weight_addr_even, expected_pair * 2);
                error_count++;
            end
            real_request_count++;
        end
    end

    always @(negedge clk) begin
        int stream_pair;
        int stream_slot;
        int stream_row;
        int stream_col;
        bit expected_inside;

        if (!rst && dut.core_valid)
            core_output_count++;

        if (!rst && output_valid) begin
            stream_started = 1'b1;
            stream_pair = stream_output_count / SLOTS_PER_PAIR;
            stream_slot = stream_output_count % SLOTS_PER_PAIR;
            stream_row  = stream_slot / 16;
            stream_col  = stream_slot % 16;
            expected_inside = (stream_row >= 1) && (stream_row <= 14)
                           && (stream_col >= 1) && (stream_col <= 14);

            if (dut.core_valid !== expected_inside) begin
                $error("core valid mismatch pair=%0d slot=%0d got=%0b expected=%0b",
                       stream_pair, stream_slot, dut.core_valid, expected_inside);
                error_count++;
            end
            if (!expected_inside && pointwise_before_depth_out !== 32'sd0) begin
                $error("padding is nonzero pair=%0d slot=%0d value=%0h",
                       stream_pair, stream_slot, pointwise_before_depth_out);
                error_count++;
            end
            stream_output_count++;
        end else if (!rst && stream_started && stream_output_count < STREAM_TOTAL) begin
            $error("padded stream contains a gap at output=%0d", stream_output_count);
            error_count++;
        end

        if (done) begin
            if (!output_valid) begin
                $error("done is not aligned with final output_valid");
                error_count++;
            end
            if (real_request_count != REAL_TOTAL) begin
                $error("real request count=%0d expected=%0d",
                       real_request_count, REAL_TOTAL);
                error_count++;
            end
            if (core_output_count != REAL_TOTAL) begin
                $error("core output count=%0d expected=%0d",
                       core_output_count, REAL_TOTAL);
                error_count++;
            end
            if (stream_output_count != STREAM_TOTAL) begin
                $error("stream output count=%0d expected=%0d",
                       stream_output_count, STREAM_TOTAL);
                error_count++;
            end

            if (error_count == 0)
                $display("PASS: 37632 real results mapped into 49152 padded slots");
            else
                $display("FAIL: %0d error(s)", error_count);
            $finish;
        end
    end

    initial begin
        rst                 = 1'b1;
        start               = 1'b0;
        real_request_count  = 0;
        core_output_count   = 0;
        stream_output_count = 0;
        error_count         = 0;
        stream_started      = 1'b0;

        repeat (4) @(negedge clk);
        rst = 1'b0;

        @(negedge clk);
        start = 1'b1;
        @(negedge clk);
        start = 1'b0;

        repeat (STREAM_TOTAL + 500) @(negedge clk);
        $fatal(1, "timeout waiting for done");
    end

endmodule
