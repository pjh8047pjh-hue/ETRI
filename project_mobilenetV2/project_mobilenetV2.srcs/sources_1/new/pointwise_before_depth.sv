`timescale 1ns / 1ps

module pointwise_before_depth (
    input  logic                 clk,
    input  logic                 rst,
    input  logic                 input_valid,
    input  logic                 last_all,

    input  logic        [1023:0] input_data,
    input  logic        [1023:0] weight_data,
    input  logic signed [  31:0] bias_data,

    output logic                 done,
    output logic                 output_valid,
    output logic signed [  15:0] pointwise_before_depth_out
);

    localparam int PARALLEL_DSP  = 64;
    localparam int DATA_WIDTH    = 16;
    localparam int NUM_GROUPS    = 8;
    localparam int GROUP_SIZE    = 8;
    localparam int TOTAL_LATENCY = 14;

    logic [TOTAL_LATENCY:0] valid_delay;
    logic [TOTAL_LATENCY:0] done_delay;
    logic signed [31:0] bias_delay [0:TOTAL_LATENCY];

    always_ff @(posedge clk) begin
        if (rst) begin
            valid_delay <= '0;
            done_delay  <= '0;
            for (int d = 0; d <= TOTAL_LATENCY; d++)
                bias_delay[d] <= '0;
        end else begin
            valid_delay[0] <= input_valid;
            done_delay[0]  <= last_all;
            bias_delay[0]  <= bias_data;

            for (int d = 1; d <= TOTAL_LATENCY; d++) begin
                valid_delay[d] <= valid_delay[d-1];
                done_delay[d]  <= done_delay[d-1];
                bias_delay[d]  <= bias_delay[d-1];
            end
        end
    end

    assign output_valid = valid_delay[TOTAL_LATENCY];
    assign done         = done_delay[TOTAL_LATENCY];

    // DSP cascade stage j의 A/B를 j cycle 늦춰 같은 transaction의 PCIN과 맞춘다.
    logic signed [DATA_WIDTH-1:0] input_point  [0:PARALLEL_DSP-1];
    logic signed [DATA_WIDTH-1:0] weight_point [0:PARALLEL_DSP-1];

    generate
        for (genvar i = 0; i < PARALLEL_DSP; i++) begin : g_input_skew
            localparam int SKEW = i % GROUP_SIZE;

            wire signed [DATA_WIDTH-1:0] input_slice =
                $signed(input_data[i*DATA_WIDTH +: DATA_WIDTH]);
            wire signed [DATA_WIDTH-1:0] weight_slice =
                $signed(weight_data[i*DATA_WIDTH +: DATA_WIDTH]);

            if (SKEW == 0) begin : g_no_skew
                assign input_point[i]  = input_slice;
                assign weight_point[i] = weight_slice;
            end else begin : g_skew
                logic signed [DATA_WIDTH-1:0] input_sr  [0:SKEW-1];
                logic signed [DATA_WIDTH-1:0] weight_sr [0:SKEW-1];

                always_ff @(posedge clk) begin
                    if (rst) begin
                        for (int k = 0; k < SKEW; k++) begin
                            input_sr[k]  <= '0;
                            weight_sr[k] <= '0;
                        end
                    end else begin
                        input_sr[0]  <= input_slice;
                        weight_sr[0] <= weight_slice;
                        for (int k = 1; k < SKEW; k++) begin
                            input_sr[k]  <= input_sr[k-1];
                            weight_sr[k] <= weight_sr[k-1];
                        end
                    end
                end

                assign input_point[i]  = input_sr[SKEW-1];
                assign weight_point[i] = weight_sr[SKEW-1];
            end
        end
    endgenerate

    logic signed [47:0] pc_chain [0:NUM_GROUPS-1][0:6];
    logic signed [47:0] group_sum[0:NUM_GROUPS-1];

    generate
        for (genvar g = 0; g < NUM_GROUPS; g++) begin : g_dsp_group
            dsp48_first_point u_first (
                .CLK   (clk),
                .A     (input_point [g*GROUP_SIZE]),
                .B     (weight_point[g*GROUP_SIZE]),
                .P     (),
                .PCOUT (pc_chain[g][0])
            );

            for (genvar j = 1; j < GROUP_SIZE-1; j++) begin : g_middle
                dsp48_middle_point u_middle (
                    .CLK   (clk),
                    .A     (input_point [g*GROUP_SIZE+j]),
                    .B     (weight_point[g*GROUP_SIZE+j]),
                    .P     (),
                    .PCIN  (pc_chain[g][j-1]),
                    .PCOUT (pc_chain[g][j])
                );
            end

            dsp48_last_point u_last (
                .CLK  (clk),
                .A    (input_point [g*GROUP_SIZE+GROUP_SIZE-1]),
                .B    (weight_point[g*GROUP_SIZE+GROUP_SIZE-1]),
                .PCIN (pc_chain[g][GROUP_SIZE-2]),
                .P    (group_sum[g])
            );
        end
    endgenerate

    logic signed [48:0] adder_first_tree [0:3];
    logic signed [49:0] adder_second_tree[0:1];
    logic signed [50:0] adder_third_tree;
    logic signed [50:0] dot_sum_q24;

    always_ff @(posedge clk) begin
        if (rst) begin
            for (int i = 0; i < 4; i++)
                adder_first_tree[i] <= '0;
            for (int i = 0; i < 2; i++)
                adder_second_tree[i] <= '0;
            adder_third_tree <= '0;
            dot_sum_q24      <= '0;
        end else begin
            for (int i = 0; i < 4; i++) begin
                adder_first_tree[i] <=
                    $signed({group_sum[2*i][47], group_sum[2*i]}) +
                    $signed({group_sum[2*i+1][47], group_sum[2*i+1]});
            end

            adder_second_tree[0] <=
                $signed({adder_first_tree[0][48], adder_first_tree[0]}) +
                $signed({adder_first_tree[1][48], adder_first_tree[1]});
            adder_second_tree[1] <=
                $signed({adder_first_tree[2][48], adder_first_tree[2]}) +
                $signed({adder_first_tree[3][48], adder_first_tree[3]});

            adder_third_tree <=
                $signed({adder_second_tree[0][49], adder_second_tree[0]}) +
                $signed({adder_second_tree[1][49], adder_second_tree[1]});

            if (valid_delay[TOTAL_LATENCY-1])
                dot_sum_q24 <= adder_third_tree;
        end
    end

    // Q3.12 x Q3.12 = Q24. Q24 bias를 shift 전에 더한다.
    wire signed [50:0] bias_extended =
        {{(51-32){bias_delay[TOTAL_LATENCY][31]}},
          bias_delay[TOTAL_LATENCY]};
    wire signed [50:0] biased_acc_q24 = dot_sum_q24 + bias_extended;
    wire signed [50:0] shifted_q312   = biased_acc_q24 >>> 12;

    localparam logic signed [50:0] RELU6_Q312 = 51'sd24576;

    always_comb begin
        if (!output_valid)
            pointwise_before_depth_out = '0;
        else if (shifted_q312 <= 0)
            pointwise_before_depth_out = 16'sd0;
        else if (shifted_q312 >= RELU6_Q312)
            pointwise_before_depth_out = 16'sh6000;
        else
            pointwise_before_depth_out = shifted_q312[15:0];
    end

endmodule
