`timescale 1ns/1ps
`default_nettype none

// -----------------------------------------------------------------------------
// DSP48E1-facing MAC wrapper
//
// Early implementation:
//   - Let Vivado infer one DSP48E1 from the signed multiply-accumulate pattern.
//
// Final implementation option:
//   - Replace only this module body with a DSP48 Macro IP instance.
//   - Keep the ports and first/last token behavior unchanged so that the
//     depthwise controller does not depend on generated IP port names.
//
// One output is a sequence of exactly nine valid tokens, including padding
// tokens whose operand a_data is already forced to zero by the caller.
//   in_first=1 : P <- A*B
//   otherwise  : P <- P + A*B
//   in_last=1  : acc_valid is asserted with the updated P value.
// -----------------------------------------------------------------------------
module depthwise_mac_dsp48 #(
    parameter int A_W   = 16,
    parameter int B_W   = 16,
    parameter int ACC_W = 48
) (
    input  wire logic                   clk,
    input  wire logic                   rst,

    input  wire logic                   in_valid,
    input  wire logic                   in_first,
    input  wire logic                   in_last,
    input  wire logic signed [A_W-1:0]  a_data,
    input  wire logic signed [B_W-1:0]  b_data,

    output logic signed [ACC_W-1:0]     acc_data,
    output logic                        acc_valid
);

    localparam int PRODUCT_W = A_W + B_W;

    logic signed [PRODUCT_W-1:0] product;
    logic signed [ACC_W-1:0]     product_ext;

    // Applying USE_DSP to the accumulator encourages Vivado to keep the
    // multiplier and accumulator together in a DSP resource. Always verify the
    // synthesized schematic and DSP48E1 utilization report.
    (* use_dsp = "yes" *) logic signed [ACC_W-1:0] acc_q;

    assign product = $signed(a_data) * $signed(b_data);
    assign product_ext = {{(ACC_W-PRODUCT_W){product[PRODUCT_W-1]}}, product};
    assign acc_data = acc_q;

    always_ff @(posedge clk) begin
        if (rst) begin
            acc_q     <= '0;
            acc_valid <= 1'b0;
        end
        else begin
            acc_valid <= 1'b0;

            if (in_valid) begin
                if (in_first)
                    acc_q <= product_ext;
                else
                    acc_q <= acc_q + product_ext;

                if (in_last)
                    acc_valid <= 1'b1;
            end
        end
    end

`ifndef SYNTHESIS
    initial begin
        if (ACC_W < PRODUCT_W)
            $error("ACC_W (%0d) must be >= A_W+B_W (%0d)", ACC_W, PRODUCT_W);
    end
`endif

endmodule

`default_nettype wire
