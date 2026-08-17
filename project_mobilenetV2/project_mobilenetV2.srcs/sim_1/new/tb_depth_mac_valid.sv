`timescale 1ns / 1ps

module tb_depth_mac_valid;

    localparam int CLK_PERIOD_NS = 10;
    localparam int DW            = 16;
    localparam int SP            = 15;
    localparam int W             = 14;
    localparam int LAT           = 7;

    logic                     clk;
    logic                     rst;
    logic                     start;
    logic signed [DW-1:0]      input_data;
    logic signed [9*DW-1:0]    weight;
    logic                     depth_output_valid;
    logic signed [3*DW-1:0]    data_out;

    integer expected_pipe [0:LAT];
    logic   valid_pipe    [0:LAT];
    integer frame_idx;
    integer stream_idx;
    integer pipe_idx;
    integer error_count;
    integer valid_count;

    depth_mac #(.SP(SP), .DW(DW)) dut (
        .clk                (clk),
        .rst                (rst),
        .start              (start),
        .input_data         (input_data),
        .weight             (weight),
        .depth_output_valid (depth_output_valid),
        .data_out           (data_out)
    );

    always #(CLK_PERIOD_NS/2) clk = ~clk;

    function automatic integer golden(
        input integer frame,
        input integer row,
        input integer col
    );
        integer acc;
        integer kernel_row;
        integer kernel_col;
        integer input_row;
        integer input_col;
        integer sample;
        begin
            acc = 0;
            for (kernel_row = 0; kernel_row < 3; kernel_row = kernel_row + 1) begin
                for (kernel_col = 0; kernel_col < 3; kernel_col = kernel_col + 1) begin
                    input_row = row + kernel_row - 1;
                    input_col = col + kernel_col - 1;
                    if ((input_row >= 0) && (input_row < W) &&
                        (input_col >= 0) && (input_col < W)) begin
                        sample = input_row*SP + input_col;
                        acc = acc + ((frame == 0) ? sample : -sample);
                    end
                end
            end

            if (acc <= 0)
                golden = 0;
            else if (acc >= 6)
                golden = 6;
            else
                golden = acc;
        end
    endfunction

    always @(posedge clk) begin
        if (!rst) begin
            if (depth_output_valid !== valid_pipe[LAT]) begin
                $display("[%0t] valid mismatch: got=%b expected=%b",
                         $time, depth_output_valid, valid_pipe[LAT]);
                error_count = error_count + 1;
            end

            if (valid_pipe[LAT]) begin
                valid_count = valid_count + 1;
                if (data_out !== expected_pipe[LAT]) begin
                    $display("[%0t] data mismatch: got=%0d expected=%0d",
                             $time, data_out, expected_pipe[LAT]);
                    error_count = error_count + 1;
                end
            end
        end

        for (pipe_idx = LAT; pipe_idx > 0; pipe_idx = pipe_idx - 1) begin
            expected_pipe[pipe_idx] <= expected_pipe[pipe_idx-1];
            valid_pipe[pipe_idx]    <= valid_pipe[pipe_idx-1];
        end
    end

    initial begin
        clk                = 1'b0;
        rst                = 1'b1;
        start              = 1'b0;
        input_data         = '0;
        weight             = {9{16'sd1}};
        error_count        = 0;
        valid_count        = 0;

        for (pipe_idx = 0; pipe_idx <= LAT; pipe_idx = pipe_idx + 1) begin
            expected_pipe[pipe_idx] = 0;
            valid_pipe[pipe_idx]    = 1'b0;
        end

        repeat (5) @(posedge clk);
        @(posedge clk); rst <= 1'b0;
        repeat (2) @(posedge clk);

        // start is asserted one clock before the first stream slot.
        @(posedge clk); start <= 1'b1;
        @(posedge clk); start <= 1'b0;

        for (frame_idx = 0; frame_idx < 2; frame_idx = frame_idx + 1) begin
            for (stream_idx = 0; stream_idx < SP*SP; stream_idx = stream_idx + 1) begin
                // Frame 0 checks the upper ReLU6 clamp; frame 1 checks zeroing
                // of negative convolution results.
                input_data <= (frame_idx == 0) ? stream_idx : -stream_idx;

                // row/col 1..14 generate output row/col 0..13.
                if ((stream_idx/SP >= 1) && (stream_idx%SP >= 1)) begin
                    valid_pipe[0]    <= 1'b1;
                    expected_pipe[0] <= golden(frame_idx,
                                               stream_idx/SP - 1,
                                               stream_idx%SP - 1);
                end else begin
                    valid_pipe[0]    <= 1'b0;
                    expected_pipe[0] <= 0;
                end

                @(posedge clk);
            end
        end

        valid_pipe[0] <= 1'b0;
        repeat (LAT + 4) @(posedge clk);

        $display("valid outputs: %0d / %0d", valid_count, 2*W*W);
        $display("errors       : %0d", error_count);
        if ((error_count != 0) || (valid_count != 2*W*W)) begin
            $fatal(1, "tb_depth_mac_valid FAILED");
        end

        $display("tb_depth_mac_valid PASSED");
        $finish;
    end

endmodule
