`timescale 1ns/1ps
`default_nettype none

// -----------------------------------------------------------------------------
// MobileNetV2 Layer 8 depthwise 3x3 structural core
//
// Current architecture: fixed-routing baseline (candidate B in the spec)
//   - One channel is processed per start command.
//   - Output order is row-major: (0,0) -> (0,1) -> ... -> (13,13).
//   - Every output consumes exactly nine tap tokens.
//   - Padding taps do not read IFM memory; a zero operand is sent to the MAC.
//   - IFM BRAM is assumed to have one clock of synchronous read latency.
//   - Nine channel weights are loaded once and reused for all 196 outputs.
//   - BN and ReLU6 are intentionally outside this module.
//
// Addressing:
//   center_addr = channel_base + row*14 + col
//   tap offsets = {-15,-14,-13,-1,0,+1,+13,+14,+15}
//
// This module intentionally has no moving 3x3 register network. Its datapath is
// always IFM BRAM -> zero mask -> DSP MAC, which keeps physical routing regular.
// -----------------------------------------------------------------------------
module depthwise_3x3_core #(
    parameter int DATA_W = 16,
    parameter int WEIGHT_W = 16,
    parameter int ACC_W = 48,
    parameter int ADDR_W = 17,
    parameter int IMAGE_H = 14,
    parameter int IMAGE_W = 14
) (
    input  wire logic                       clk,
    input  wire logic                       rst,

    // Load the nine weights for the channel before asserting start.
    input  wire logic                       weight_we,
    input  wire logic [3:0]                 weight_waddr,
    input  wire logic signed [WEIGHT_W-1:0] weight_wdata,

    // Start one channel. Bases point to the first sample of that channel in
    // CHW-formatted IFM and OFM memories.
    input  wire logic                       start,
    input  wire logic [ADDR_W-1:0]          ifm_channel_base,
    input  wire logic [ADDR_W-1:0]          ofm_channel_base,

    output logic                            busy,
    output logic                            done,

    // One-cycle synchronous IFM BRAM interface.
    output logic                            ifm_rd_en,
    output logic [ADDR_W-1:0]               ifm_addr,
    input  wire logic signed [DATA_W-1:0]   ifm_rdata,

    // Convolution-only output. BN/ReLU6 must be applied downstream.
    output logic                            ofm_we,
    output logic [ADDR_W-1:0]               ofm_addr,
    output logic signed [ACC_W-1:0]         ofm_wdata
);

    localparam int ROW_W = (IMAGE_H <= 2) ? 1 : $clog2(IMAGE_H);
    localparam int COL_W = (IMAGE_W <= 2) ? 1 : $clog2(IMAGE_W);
    localparam int CHANNEL_SIZE = IMAGE_H * IMAGE_W;

    logic signed [WEIGHT_W-1:0] weight_reg [0:8];

    logic                       running_q;
    logic [ROW_W-1:0]           row_q;
    logic [COL_W-1:0]           col_q;
    logic [3:0]                 tap_q;
    logic [ADDR_W-1:0]          center_addr_q;
    logic [ADDR_W-1:0]          output_addr_q;

    // Metadata aligned with the one-cycle IFM BRAM response.
    logic                       token_valid_q;
    logic                       token_padding_q;
    logic                       token_first_q;
    logic                       token_last_q;
    logic signed [WEIGHT_W-1:0] token_weight_q;

    // Address tag for the result produced by the ninth MAC token.
    logic [ADDR_W-1:0]          result_addr_q;
    logic                       result_final_q;

    logic                       issue_top_tap;
    logic                       issue_bottom_tap;
    logic                       issue_left_tap;
    logic                       issue_right_tap;
    logic                       issue_in_bounds;

    logic signed [DATA_W-1:0]   mac_pixel;
    logic signed [ACC_W-1:0]    mac_result;
    logic                       mac_result_valid;

    // Tap layout:
    //     0 1 2
    //     3 4 5
    //     6 7 8
    always_comb begin
        issue_top_tap    = (tap_q <= 4'd2);
        issue_bottom_tap = (tap_q >= 4'd6);
        issue_left_tap   = (tap_q == 4'd0) || (tap_q == 4'd3) || (tap_q == 4'd6);
        issue_right_tap  = (tap_q == 4'd2) || (tap_q == 4'd5) || (tap_q == 4'd8);

        issue_in_bounds = !(
            ((row_q == '0)        && issue_top_tap)    ||
            ((row_q == IMAGE_H-1) && issue_bottom_tap) ||
            ((col_q == '0)        && issue_left_tap)   ||
            ((col_q == IMAGE_W-1) && issue_right_tap)
        );
    end

    // The center address advances once per output. Each tap therefore needs
    // only a small constant offset, not a row*14 multiplication in the hot path.
    always_comb begin
        ifm_rd_en = running_q && issue_in_bounds;
        ifm_addr  = center_addr_q; // Safe held address for a padding token.

        if (running_q && issue_in_bounds) begin
            case (tap_q)
                4'd0: ifm_addr = center_addr_q - 15;
                4'd1: ifm_addr = center_addr_q - 14;
                4'd2: ifm_addr = center_addr_q - 13;
                4'd3: ifm_addr = center_addr_q - 1;
                4'd4: ifm_addr = center_addr_q;
                4'd5: ifm_addr = center_addr_q + 1;
                4'd6: ifm_addr = center_addr_q + 13;
                4'd7: ifm_addr = center_addr_q + 14;
                4'd8: ifm_addr = center_addr_q + 15;
                default: ifm_addr = center_addr_q;
            endcase
        end
    end

    // Padding still occupies one of the fixed nine token positions. Masking the
    // returned BRAM bus keeps the controller timing constant and prevents an old
    // held BRAM value from entering the MAC when ifm_rd_en=0.
    assign mac_pixel = token_padding_q ? '0 : ifm_rdata;

    depthwise_mac_dsp48 #(
        .A_W   (DATA_W),
        .B_W   (WEIGHT_W),
        .ACC_W (ACC_W)
    ) u_mac (
        .clk       (clk),
        .rst       (rst),
        .in_valid  (token_valid_q),
        .in_first  (token_first_q),
        .in_last   (token_last_q),
        .a_data    (mac_pixel),
        .b_data    (token_weight_q),
        .acc_data  (mac_result),
        .acc_valid (mac_result_valid)
    );

    assign ofm_we    = mac_result_valid;
    assign ofm_addr  = result_addr_q;
    assign ofm_wdata = mac_result;
    assign done      = mac_result_valid && result_final_q;
    assign busy      = running_q || token_valid_q || mac_result_valid;

    always_ff @(posedge clk) begin
        if (rst) begin
            running_q       <= 1'b0;
            row_q           <= '0;
            col_q           <= '0;
            tap_q           <= '0;
            center_addr_q   <= '0;
            output_addr_q   <= '0;

            token_valid_q   <= 1'b0;
            token_padding_q <= 1'b1;
            token_first_q   <= 1'b0;
            token_last_q    <= 1'b0;
            token_weight_q  <= '0;

            result_addr_q   <= '0;
            result_final_q  <= 1'b0;
        end
        else begin
            // Weight loading is intentionally independent of compute control.
            // The parent controller must not overwrite a weight while busy=1.
            if (weight_we && (weight_waddr < 9))
                weight_reg[weight_waddr] <= weight_wdata;

            // Default: no memory-response token will be consumed next cycle.
            token_valid_q <= 1'b0;

            if (start && !busy) begin
                running_q       <= 1'b1;
                row_q           <= '0;
                col_q           <= '0;
                tap_q           <= '0;
                center_addr_q   <= ifm_channel_base;
                output_addr_q   <= ofm_channel_base;
                result_final_q  <= 1'b0;
            end
            else if (running_q) begin
                // Capture metadata for the IFM response that arrives one cycle
                // after the address currently driven on ifm_addr.
                token_valid_q   <= 1'b1;
                token_padding_q <= !issue_in_bounds;
                token_first_q   <= (tap_q == 4'd0);
                token_last_q    <= (tap_q == 4'd8);
                token_weight_q  <= weight_reg[tap_q];

                if (tap_q == 4'd8) begin
                    tap_q          <= '0;
                    result_addr_q  <= output_addr_q;
                    result_final_q <= (row_q == IMAGE_H-1) && (col_q == IMAGE_W-1);

                    if ((row_q == IMAGE_H-1) && (col_q == IMAGE_W-1)) begin
                        running_q <= 1'b0;
                    end
                    else begin
                        center_addr_q <= center_addr_q + 1'b1;
                        output_addr_q <= output_addr_q + 1'b1;

                        if (col_q == IMAGE_W-1) begin
                            col_q <= '0;
                            row_q <= row_q + 1'b1;
                        end
                        else begin
                            col_q <= col_q + 1'b1;
                        end
                    end
                end
                else begin
                    tap_q <= tap_q + 1'b1;
                end
            end
        end
    end

`ifndef SYNTHESIS
    initial begin
        if ((IMAGE_H != 14) || (IMAGE_W != 14))
            $warning("Tap offsets are specialized for a 14x14 feature map.");
        if (CHANNEL_SIZE > (1 << ADDR_W))
            $error("ADDR_W is too small for one channel.");
    end
`endif

endmodule

`default_nettype wire
