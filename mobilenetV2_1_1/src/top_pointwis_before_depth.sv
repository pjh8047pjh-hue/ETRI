`timescale 1ns / 1ps

module top_pointwise_before_depth (
    input  logic                  clk,
    input  logic                  rst,
    input  logic                  start,

    input  logic signed [1023:0] input_rd_data,
    output logic        [   7:0] input_rd_addr,
    output logic                  input_rd_en,

    output logic                  done,
    output logic                  output_valid,
    output logic signed [  31:0] pointwise_before_depth_out
);

    localparam int OUT_CH_PAIR          = 192;
    localparam int BRAM_TO_CORE_LATENCY = 2;
    // pointwise_before_depth registers its final clamp result.
    localparam int PW_CORE_LATENCY      = 16;
    localparam int STREAM_LATENCY       = BRAM_TO_CORE_LATENCY + PW_CORE_LATENCY;

    logic [7:0] slot_cnt;
    logic [7:0] channel_pair_cnt;
    logic       busy;
    logic       run;
    logic       run_d1;

    wire accept_start = start && !busy;
    wire [3:0] slot_row = slot_cnt[7:4];
    wire [3:0] slot_col = slot_cnt[3:0];
    wire inside_slot = run
                     && (slot_row >= 4'd1) && (slot_row <= 4'd14)
                     && (slot_col >= 4'd1) && (slot_col <= 4'd14);
    wire [7:0] pixel_addr = ((slot_row - 4'd1) * 8'd14)
                          +  (slot_col - 4'd1);
    wire last_real_slot = inside_slot
                        && (slot_cnt == 8'd238)
                        && (channel_pair_cnt == OUT_CH_PAIR-1);
    wire last_stream_slot = run
                          && (slot_cnt == 8'd255)
                          && (channel_pair_cnt == OUT_CH_PAIR-1);

    always_ff @(posedge clk) begin
        if (rst) begin
            busy <= 1'b0;
            run  <= 1'b0;
        end else begin
            if (accept_start) begin
                busy <= 1'b1;
                run  <= 1'b1;
            end else if (last_stream_slot) begin
                run <= 1'b0;
            end

            if (done)
                busy <= 1'b0;
        end
    end

    always_ff @(posedge clk) begin
        if (rst)
            run_d1 <= 1'b0;
        else
            run_d1 <= run;
    end

    // One channel pair consumes a complete 16x16 padded raster. PW1 is
    // issued only for the 14x14 interior; border slots become zero tokens.
    always_ff @(posedge clk) begin
        if (rst || accept_start) begin
            slot_cnt         <= '0;
            channel_pair_cnt <= '0;
        end else if (run) begin
            if (slot_cnt == 8'd255) begin
                slot_cnt <= '0;
                if (channel_pair_cnt == OUT_CH_PAIR-1)
                    channel_pair_cnt <= '0;
                else
                    channel_pair_cnt <= channel_pair_cnt + 1'b1;
            end else begin
                slot_cnt <= slot_cnt + 1'b1;
            end
        end
    end

    // Keep synchronous BRAM pipelines running through padding slots.
    // Address zero is harmless because request_valid is low on the border.
    wire mem_en = run || run_d1;
    assign input_rd_en   = mem_en;
    assign input_rd_addr = inside_slot ? pixel_addr : 8'd0;

    wire [8:0] weight_addr_even = {channel_pair_cnt, 1'b0};
    wire [8:0] weight_addr_odd  = weight_addr_even + 1'b1;
    wire [8:0] bias_addr_even   = weight_addr_even;
    wire [8:0] bias_addr_odd    = weight_addr_odd;

    wire signed [1023:0] weight_data_even, weight_data_odd;
    wire signed [  31:0] bias_data_even, bias_data_odd;

    pointwise_before_depth_weight u_weight (
        .clka  (clk),
        .ena   (mem_en),
        .addra (weight_addr_even),
        .douta (weight_data_even),
        .clkb  (clk),
        .enb   (mem_en),
        .addrb (weight_addr_odd),
        .doutb (weight_data_odd)
    );

    pointwise_before_depth_bias u_bias (
        .clka  (clk),
        .ena   (mem_en),
        .addra (bias_addr_even),
        .douta (bias_data_even),
        .clkb  (clk),
        .enb   (mem_en),
        .addrb (bias_addr_odd),
        .doutb (bias_data_odd)
    );

    logic [BRAM_TO_CORE_LATENCY-1:0] request_valid_d;
    logic [BRAM_TO_CORE_LATENCY-1:0] last_real_d;

    always_ff @(posedge clk) begin
        if (rst || accept_start) begin
            request_valid_d <= '0;
            last_real_d     <= '0;
        end else begin
            request_valid_d[0] <= inside_slot;
            last_real_d[0]     <= last_real_slot;
            for (int d = 1; d < BRAM_TO_CORE_LATENCY; d++) begin
                request_valid_d[d] <= request_valid_d[d-1];
                last_real_d[d]     <= last_real_d[d-1];
            end
        end
    end

    wire signed [15:0] pointwise_even, pointwise_odd;
    wire               core_done, core_valid;

    pointwise_before_depth u_core_even (
        .clk                        (clk),
        .rst                        (rst),
        .input_valid                (request_valid_d[BRAM_TO_CORE_LATENCY-1]),
        .last_all                   (last_real_d     [BRAM_TO_CORE_LATENCY-1]),
        .input_data                 (input_rd_data),
        .weight_data                (weight_data_even),
        .bias_data                  (bias_data_even),
        .done                       (core_done),
        .output_valid               (core_valid),
        .pointwise_before_depth_out (pointwise_even)
    );

    pointwise_before_depth u_core_odd (
        .clk                        (clk),
        .rst                        (rst),
        .input_valid                (request_valid_d[BRAM_TO_CORE_LATENCY-1]),
        .last_all                   (last_real_d     [BRAM_TO_CORE_LATENCY-1]),
        .input_data                 (input_rd_data),
        .weight_data                (weight_data_odd),
        .bias_data                  (bias_data_odd),
        .done                       (),
        .output_valid               (),
        .pointwise_before_depth_out (pointwise_odd)
    );

    // Delay the complete slot schedule by the same fixed latency as PW1.
    logic [STREAM_LATENCY:0] stream_valid_d;
    logic [STREAM_LATENCY:0] stream_inside_d;
    logic [STREAM_LATENCY:0] stream_last_d;

    always_ff @(posedge clk) begin
        if (rst || accept_start) begin
            stream_valid_d  <= '0;
            stream_inside_d <= '0;
            stream_last_d   <= '0;
        end else begin
            stream_valid_d[0]  <= run;
            stream_inside_d[0] <= inside_slot;
            stream_last_d[0]   <= last_stream_slot;
            for (int d = 1; d <= STREAM_LATENCY; d++) begin
                stream_valid_d[d]  <= stream_valid_d[d-1];
                stream_inside_d[d] <= stream_inside_d[d-1];
                stream_last_d[d]   <= stream_last_d[d-1];
            end
        end
    end

    assign output_valid = stream_valid_d[STREAM_LATENCY];
    assign done         = stream_last_d [STREAM_LATENCY];
    assign pointwise_before_depth_out = stream_inside_d[STREAM_LATENCY]
                                        ? {pointwise_odd, pointwise_even}
                                        : 32'sd0;

endmodule
