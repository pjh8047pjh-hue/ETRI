`timescale 1ns / 1ps

module tb_top_pointwise_before_depth;

    localparam int PIXEL  = 196;
    localparam int OUT_CH = 384;
    localparam int TOTAL  = PIXEL * OUT_CH;

    logic clk = 1'b0;
    logic rst;
    logic start;
    logic signed [1023:0] input_rd_data;
    logic signed [1023:0] input_rd_data_d1;
    logic [7:0] input_rd_addr;
    logic input_rd_en;
    logic done;
    logic output_valid;
    logic signed [15:0] pointwise_before_depth_out;

    int expected_pixel;
    int expected_channel;
    int request_count;
    int output_count;
    int error_count;

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

    // 외부 input BRAM의 read latency 2를 흉내 낸다.
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
        if (!rst && dut.run) begin
            if (input_rd_addr !== expected_pixel[7:0]) begin
                $error("input address got=%0d expected=%0d",
                       input_rd_addr, expected_pixel);
                error_count++;
            end
            if (dut.weight_addr !== expected_channel[8:0] ||
                dut.bias_addr !== expected_channel[8:0]) begin
                $error("channel address weight=%0d bias=%0d expected=%0d",
                       dut.weight_addr, dut.bias_addr, expected_channel);
                error_count++;
            end

            request_count++;
            if (expected_pixel == PIXEL-1) begin
                expected_pixel = 0;
                expected_channel++;
            end else begin
                expected_pixel++;
            end
        end
    end

    always @(negedge clk) begin
        if (output_valid)
            output_count++;

        if (done) begin
            if (!output_valid) begin
                $error("done is not aligned with final output_valid");
                error_count++;
            end
            if (request_count != TOTAL) begin
                $error("request count=%0d expected=%0d", request_count, TOTAL);
                error_count++;
            end
            if (output_count != TOTAL) begin
                $error("output count=%0d expected=%0d", output_count, TOTAL);
                error_count++;
            end
            if (expected_channel != OUT_CH) begin
                $error("completed channels=%0d expected=%0d",
                       expected_channel, OUT_CH);
                error_count++;
            end

            if (error_count == 0)
                $display("PASS: address order, request/output count and done alignment");
            else
                $display("FAIL: %0d error(s)", error_count);
            $finish;
        end
    end

    initial begin
        rst              = 1'b1;
        start            = 1'b0;
        input_rd_data    = '0;
        input_rd_data_d1 = '0;
        expected_pixel   = 0;
        expected_channel = 0;
        request_count    = 0;
        output_count     = 0;
        error_count      = 0;

        repeat (4) @(negedge clk);
        rst = 1'b0;

        @(negedge clk);
        start = 1'b1;
        @(negedge clk);
        start = 1'b0;

        repeat (TOTAL + 200) @(negedge clk);
        $fatal(1, "timeout waiting for done");
    end

endmodule
