`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: uart_mul_ctrl
// Description: UART RX로 a, b(각 1바이트)를 순서대로 받아 곱셈기를 한 번 구동하고,
//              결과(2*WIDTH비트)를 상위 바이트 -> 하위 바이트 순으로 UART TX로 내보냄.
//              rx_done/tx_busy는 baud_tick 도메인에서 만들어지지만 baud_tick 자체가
//              clk을 나눈 등록 신호라 값이 한 baud 구간(수천 clk) 동안 안정적으로
//              유지되므로, clk 도메인에서 그대로 샘플링해도 안전함.
//////////////////////////////////////////////////////////////////////////////////

module uart_mul_ctrl #(
    parameter WIDTH = 8
)(
    input  clk, rst_n,

    // uart_rx
    input                   rx_done,
    input      [WIDTH-1:0]  rx_dout,

    // multiplier (FSM_mul + adder)
    output reg              mul_start,
    input                   mul_done,
    input      [2*WIDTH-1:0] mul_result,
    output reg [WIDTH-1:0]  mul_a,
    output reg [WIDTH-1:0]  mul_b,
    output                  busy,

    // uart_tx
    output reg              tx_start,
    output reg [7:0]        tx_din,
    input                   tx_busy
);

    localparam S_WAIT_A    = 4'd0,
               S_WAIT_B    = 4'd1,
               S_START_MUL = 4'd2,
               S_WAIT_MUL  = 4'd3,
               S_SEND_HI   = 4'd4,
               S_ASSERT_HI = 4'd5,
               S_WAIT_HI   = 4'd6,
               S_SEND_LO   = 4'd7,
               S_ASSERT_LO = 4'd8,
               S_WAIT_LO   = 4'd9;

    reg [3:0] state;
    reg [2*WIDTH-1:0] result_latched;

    // rx_done은 한 baud 구간 내내 1로 유지되는 레벨 신호라, 상승엣지만 잡아서
    // 정확히 한 번씩만 바이트를 캡처한다.
    reg rx_done_d;
    wire rx_done_rise = rx_done & ~rx_done_d;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) rx_done_d <= 1'b0;
        else        rx_done_d <= rx_done;
    end

    assign busy = (state != S_WAIT_A);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state          <= S_WAIT_A;
            mul_a          <= {WIDTH{1'b0}};
            mul_b          <= {WIDTH{1'b0}};
            mul_start      <= 1'b0;
            result_latched <= {2*WIDTH{1'b0}};
            tx_start       <= 1'b0;
            tx_din         <= 8'd0;
        end else begin
            case (state)
                S_WAIT_A: begin
                    if (rx_done_rise) begin
                        mul_a <= rx_dout;
                        state <= S_WAIT_B;
                    end
                end

                S_WAIT_B: begin
                    if (rx_done_rise) begin
                        mul_b <= rx_dout;
                        state <= S_START_MUL;
                    end
                end

                S_START_MUL: begin
                    mul_start <= 1'b1;
                    state     <= S_WAIT_MUL;
                end

                S_WAIT_MUL: begin
                    mul_start <= 1'b0;
                    if (mul_done) begin
                        result_latched <= mul_result;
                        state          <= S_SEND_HI;
                    end
                end

                S_SEND_HI: begin
                    if (!tx_busy) begin
                        tx_din   <= result_latched[2*WIDTH-1:WIDTH];
                        tx_start <= 1'b1;
                        state    <= S_ASSERT_HI;
                    end
                end

                S_ASSERT_HI: begin
                    if (tx_busy) begin
                        tx_start <= 1'b0;
                        state    <= S_WAIT_HI;
                    end
                end

                S_WAIT_HI: begin
                    if (!tx_busy) state <= S_SEND_LO;
                end

                S_SEND_LO: begin
                    if (!tx_busy) begin
                        tx_din   <= result_latched[WIDTH-1:0];
                        tx_start <= 1'b1;
                        state    <= S_ASSERT_LO;
                    end
                end

                S_ASSERT_LO: begin
                    if (tx_busy) begin
                        tx_start <= 1'b0;
                        state    <= S_WAIT_LO;
                    end
                end

                S_WAIT_LO: begin
                    if (!tx_busy) state <= S_WAIT_A;
                end

                default: state <= S_WAIT_A;
            endcase
        end
    end

endmodule
