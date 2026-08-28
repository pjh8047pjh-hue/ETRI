`timescale 1ns / 1ps

// Power-comparison version of the original multiplier + reduction +
// accumulator pointwise datapath.  It has the same transaction contract as
// pointwise_after_depth: one 64-lane chunk per clock, "first" starts a dot
// product, and "last" commits the accumulated six-chunk result.
module pw_mac_accum_core (
    input  logic                 clk,
    input  logic                 rst,
    input  logic                 first,
    input  logic                 last_all,
    input  logic                 last,
    input  logic        [1023:0] input_data,
    input  logic        [1023:0] weight_data,
    input  logic signed [  31:0] bias_data,
    output logic                 done,
    output logic                 output_valid,
    output logic signed [  15:0] pointwise_after_depth_out
);
    localparam int LANES     = 64;
    localparam int DATA_W    = 16;
    localparam int FRAC_BITS = 12;

    // One registered DSP multiplier per lane, matching the one-stage
    // mult_gen_0 used by the original pointwise_mac implementation.
    logic signed [31:0] product [0:LANES-1];

    generate
        for (genvar i = 0; i < LANES; i++) begin : g_product
            wire signed [DATA_W-1:0] a =
                $signed(input_data [i*DATA_W +: DATA_W]);
            wire signed [DATA_W-1:0] b =
                $signed(weight_data[i*DATA_W +: DATA_W]);

            (* use_dsp = "yes" *)
            always_ff @(posedge clk) begin
                if (rst)
                    product[i] <= '0;
                else
                    product[i] <= a * b;
            end
        end
    endgenerate

    // 64 products need 38 signed bits.  Keep a wider common datapath so the
    // six-chunk accumulator has the same numeric headroom as the cascade DUT.
    logic signed [50:0] product_sum;
    logic signed [50:0] accumulator;
    logic signed [50:0] next_sum;
    logic               first_d;
    logic               last_d;
    logic               last_all_d;

    always_comb begin
        product_sum = '0;
        for (int i = 0; i < LANES; i++)
            product_sum = product_sum +
                          {{19{product[i][31]}}, product[i]};
    end

    always_comb begin
        if (first_d)
            next_sum = product_sum;
        else
            next_sum = accumulator + product_sum;
    end

    wire signed [50:0] bias_extended =
        {{19{bias_data[31]}}, bias_data};
    wire signed [50:0] shifted_result =
        (next_sum + bias_extended) >>> FRAC_BITS;

    always_ff @(posedge clk) begin
        if (rst) begin
            first_d                   <= 1'b0;
            last_d                    <= 1'b0;
            last_all_d                <= 1'b0;
            accumulator               <= '0;
            pointwise_after_depth_out <= '0;
            output_valid              <= 1'b0;
            done                      <= 1'b0;
        end else begin
            first_d    <= first;
            last_d     <= last;
            last_all_d <= last_all;

            accumulator  <= next_sum;
            output_valid <= last_d;
            done         <= last_all_d;

            if (last_d)
                pointwise_after_depth_out <= shifted_result[15:0];
        end
    end
endmodule
