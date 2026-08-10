`timescale 1ns / 1ps

module uart_rx #(
    parameter CLK_FREQ  = 100_000_000,
    parameter BAUD_RATE = 115_200
)(
    input      clk, rst_n,
    input      baud_tick, // 기존 top과의 인터페이스 호환용
    input      rx_data,
    output reg rx_done,
    output reg [7:0] dout,
    output     busy
);

    localparam integer CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    localparam integer HALF_BIT     = CLKS_PER_BIT / 2;
    localparam ST_IDLE  = 2'd0,
               ST_START = 2'd1,
               ST_DATA  = 2'd2,
               ST_STOP  = 2'd3;

    reg [1:0] state;
    reg [$clog2(CLKS_PER_BIT)-1:0] clk_cnt;
    reg [2:0] bit_idx;
    reg rx_meta;
    reg rx_sync;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rx_meta <= 1'b1;
            rx_sync <= 1'b1;
        end else begin
            rx_meta <= rx_data;
            rx_sync <= rx_meta;
        end
    end

    assign busy = (state != ST_IDLE);

    // start bit 중앙에서 위상을 맞추고 각 data bit 중앙을 샘플한다.
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state   <= ST_IDLE;
            clk_cnt <= 0;
            bit_idx <= 0;
            rx_done <= 1'b0;
            dout    <= 8'd0;
        end else begin
            rx_done <= 1'b0;
            case (state)
                ST_IDLE: begin
                    clk_cnt <= 0;
                    bit_idx <= 0;
                    if (!rx_sync)
                        state <= ST_START;
                end

                ST_START: begin
                    if (clk_cnt == HALF_BIT - 1) begin
                        clk_cnt <= 0;
                        state   <= rx_sync ? ST_IDLE : ST_DATA;
                    end else begin
                        clk_cnt <= clk_cnt + 1'b1;
                    end
                end

                ST_DATA: begin
                    if (clk_cnt == CLKS_PER_BIT - 1) begin
                        clk_cnt       <= 0;
                        dout[bit_idx] <= rx_sync;
                        if (bit_idx == 3'd7) begin
                            bit_idx <= 0;
                            state   <= ST_STOP;
                        end else begin
                            bit_idx <= bit_idx + 1'b1;
                        end
                    end else begin
                        clk_cnt <= clk_cnt + 1'b1;
                    end
                end

                ST_STOP: begin
                    if (clk_cnt == CLKS_PER_BIT - 1) begin
                        clk_cnt <= 0;
                        state   <= ST_IDLE;
                        if (rx_sync)
                            rx_done <= 1'b1;
                    end else begin
                        clk_cnt <= clk_cnt + 1'b1;
                    end
                end

                default: state <= ST_IDLE;
            endcase
        end
    end

    wire unused_baud_tick = baud_tick;

endmodule
