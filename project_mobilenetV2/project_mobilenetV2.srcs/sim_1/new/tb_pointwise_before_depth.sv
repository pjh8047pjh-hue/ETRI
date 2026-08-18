`timescale 1ns / 1ps

module tb_pointwise_before_depth;

    logic clk = 1'b0;
    logic rst;
    logic input_valid;
    logic last_all;
    logic [1023:0] input_data;
    logic [1023:0] weight_data;
    logic signed [31:0] bias_data;
    logic done;
    logic output_valid;
    logic signed [15:0] pointwise_before_depth_out;

    int cycle;
    int first_launch_cycle;
    int launch_count;
    int result_count;
    int error_count;

    always #5 clk = ~clk;

    pointwise_before_depth dut (
        .clk                        (clk),
        .rst                        (rst),
        .input_valid                (input_valid),
        .last_all                   (last_all),
        .input_data                 (input_data),
        .weight_data                (weight_data),
        .bias_data                  (bias_data),
        .done                       (done),
        .output_valid               (output_valid),
        .pointwise_before_depth_out (pointwise_before_depth_out)
    );

    task automatic set_lanes(
        input logic signed [15:0] input_value,
        input logic signed [15:0] weight_value
    );
        for (int i = 0; i < 64; i++) begin
            input_data [i*16 +: 16] = input_value;
            weight_data[i*16 +: 16] = weight_value;
        end
    endtask

    task automatic check_result(input logic signed [15:0] expected);
        if (pointwise_before_depth_out !== expected) begin
            $error("result[%0d] got=%0d (0x%04h), expected=%0d (0x%04h)",
                   result_count,
                   $signed(pointwise_before_depth_out), pointwise_before_depth_out,
                   $signed(expected), expected);
            error_count++;
        end
    endtask

    always @(posedge clk) begin
        cycle++;
        if (input_valid) begin
            if (launch_count == 0)
                first_launch_cycle = cycle;
            launch_count++;
        end
    end

    // NBA로 갱신된 DUT 출력을 negedge에서 검사한다.
    always @(negedge clk) begin
        if (output_valid) begin
            if (result_count == 0 && cycle - first_launch_cycle != 14) begin
                $error("first output latency=%0d, expected=14",
                       cycle - first_launch_cycle);
                error_count++;
            end

            case (result_count)
                0: check_result(16'sh1800); // 64*(1.0*1/64)+0.5 = 1.5
                1: check_result(16'sh0000); // negative -> ReLU lower clamp
                2: check_result(16'sh6000); // 64.0 -> ReLU6 upper clamp
                default: begin
                    $error("unexpected extra output");
                    error_count++;
                end
            endcase
            result_count++;
        end

        if (done) begin
            if (!output_valid) begin
                $error("done is not aligned with the final output");
                error_count++;
            end
            if (result_count != 3) begin
                $error("result count=%0d, expected=3", result_count);
                error_count++;
            end

            if (error_count == 0)
                $display("PASS: Q3.12 arithmetic, ReLU6, latency and done alignment");
            else
                $display("FAIL: %0d error(s)", error_count);
            $finish;
        end
    end

    initial begin
        rst                = 1'b1;
        input_valid        = 1'b0;
        last_all           = 1'b0;
        input_data         = '0;
        weight_data        = '0;
        bias_data          = '0;
        cycle              = 0;
        first_launch_cycle = 0;
        launch_count       = 0;
        result_count       = 0;
        error_count        = 0;

        repeat (4) @(negedge clk);
        rst = 1'b0;

        // Transaction 0: input=1.0, weight=1/64, bias=0.5(Q24).
        @(negedge clk);
        set_lanes(16'sh1000, 16'sh0040);
        bias_data   = 32'sh00800000;
        input_valid = 1'b1;

        // Transaction 1: input=1.0, weight=-1/64, bias=0.
        @(negedge clk);
        set_lanes(16'sh1000, -16'sh0040);
        bias_data = 32'sd0;

        // Transaction 2: input=1.0, weight=1.0 -> ReLU6 saturation.
        @(negedge clk);
        set_lanes(16'sh1000, 16'sh1000);
        bias_data = 32'sd0;
        last_all  = 1'b1;

        @(negedge clk);
        input_valid = 1'b0;
        last_all    = 1'b0;
        input_data  = '0;
        weight_data = '0;
        bias_data   = '0;

        repeat (100) @(negedge clk);
        $fatal(1, "timeout waiting for done");
    end

endmodule
