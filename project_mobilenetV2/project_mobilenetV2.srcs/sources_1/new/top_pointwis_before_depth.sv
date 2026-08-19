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

    localparam int PIXEL                = 196;
    localparam int OUT_CH_PAIR          = 192;
    localparam int BRAM_TO_CORE_LATENCY = 2;

    logic [7:0] pixel_cnt;
    logic [7:0] channel_pair_cnt;
    logic       busy;
    logic       run;
    logic       run_d1;

    wire accept_start = start && !busy;
    wire last_request = run
                      && (pixel_cnt == PIXEL-1)
                      && (channel_pair_cnt == OUT_CH_PAIR-1);

    always_ff @(posedge clk) begin
        if (rst) begin
            busy <= 1'b0;
            run  <= 1'b0;
        end else begin
            if (accept_start) begin
                busy <= 1'b1;
                run  <= 1'b1;
            end else if (last_request) begin
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

    // output_channel 바깥 루프, pixel 안쪽 루프.
    always_ff @(posedge clk) begin
        if (rst || accept_start) begin
            pixel_cnt   <= '0;
            channel_pair_cnt <= '0;
        end else if (run) begin
            if (pixel_cnt == PIXEL-1) begin
                pixel_cnt <= '0;
                if (channel_pair_cnt == OUT_CH_PAIR-1)
                    channel_pair_cnt <= '0;
                else
                    channel_pair_cnt <= channel_pair_cnt + 1'b1;
            end else begin
                pixel_cnt <= pixel_cnt + 1'b1;
            end
        end
    end

    // 마지막 read의 synchronous BRAM 출력이 갱신되도록 enable을 한 cycle 유지한다.
    wire mem_en = run || run_d1;
    assign input_rd_en   = mem_en;
    assign input_rd_addr = pixel_cnt;

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

    // 사용자가 생성할 32-bit x 384, read-latency 1의 Q24 bias ROM.
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
    logic [BRAM_TO_CORE_LATENCY-1:0] last_request_d;

    always_ff @(posedge clk) begin
        if (rst || accept_start) begin
            request_valid_d <= '0;
            last_request_d  <= '0;
        end else begin
            request_valid_d[0] <= run;
            last_request_d[0]  <= last_request;
            for (int d = 1; d < BRAM_TO_CORE_LATENCY; d++) begin
                request_valid_d[d] <= request_valid_d[d-1];
                last_request_d[d]  <= last_request_d[d-1];
            end
        end
    end

    wire signed [15:0] pointwise_even, pointwise_odd;

    pointwise_before_depth u_core_even (
        .clk                        (clk),
        .rst                        (rst),
        .input_valid                (request_valid_d[BRAM_TO_CORE_LATENCY-1]),
        .last_all                   (last_request_d [BRAM_TO_CORE_LATENCY-1]),
        .input_data                 (input_rd_data),
        .weight_data                (weight_data_even),
        .bias_data                  (bias_data_even),
        .done                       (done),
        .output_valid               (output_valid),
        .pointwise_before_depth_out (pointwise_even)
    );

    pointwise_before_depth u_core_odd (
        .clk                        (clk),
        .rst                        (rst),
        .input_valid                (request_valid_d[BRAM_TO_CORE_LATENCY-1]),
        .last_all                   (last_request_d [BRAM_TO_CORE_LATENCY-1]),
        .input_data                 (input_rd_data),
        .weight_data                (weight_data_odd),
        .bias_data                  (bias_data_odd),
        .done                       (),
        .output_valid               (),
        .pointwise_before_depth_out (pointwise_odd)
    );

    assign pointwise_before_depth_out = {pointwise_odd, pointwise_even};

endmodule
