`timescale 1ns / 1ps

// 입력: 1바이트씩 hex 2자리 두 번 (예: "1234" -> a=0x12, b=0x34)
// 출력: "=" + 4자리 hex 결과 + CRLF (예: "=03A8\r\n")
module uart_mul_ctrl #(
    parameter WIDTH = 8
)(
    input                     clk,
    input                     rst_n,
    input                     rx_done,
    input      [7:0]          rx_dout,
    output reg                mul_start,
    input                     mul_done,
    input      [2*WIDTH-1:0]  mul_result,
    output reg [WIDTH-1:0]    mul_a,
    output reg [WIDTH-1:0]    mul_b,
    output                    busy,
    output reg                tx_start,
    output reg [7:0]          tx_din,
    input                     tx_busy
);

    localparam S_WAIT_A_HI = 4'd0,
               S_WAIT_A_LO = 4'd1,
               S_WAIT_B_HI = 4'd2,
               S_WAIT_B_LO = 4'd3,
               S_MUL_START = 4'd4,
               S_MUL_WAIT  = 4'd5,
               S_TX_LOAD   = 4'd6,
               S_TX_START  = 4'd7,
               S_TX_WAIT   = 4'd8;

    reg [3:0]  state;
    reg [2:0]  tx_index;
    reg [3:0]  a_hi_nibble;
    reg [3:0]  b_hi_nibble;
    reg [15:0] result_latched;

    wire rx_is_hex = ((rx_dout >= "0") && (rx_dout <= "9")) ||
                     ((rx_dout >= "A") && (rx_dout <= "F")) ||
                     ((rx_dout >= "a") && (rx_dout <= "f"));

    function [3:0] ascii_to_hex;
        input [7:0] ascii;
        begin
            if (ascii <= "9")
                ascii_to_hex = ascii - "0";
            else if (ascii <= "F")
                ascii_to_hex = ascii - "A" + 4'd10;
            else
                ascii_to_hex = ascii - "a" + 4'd10;
        end
    endfunction

    function [7:0] hex_to_ascii;
        input [3:0] value;
        begin
            hex_to_ascii = (value < 10) ? ("0" + value)
                                         : ("A" + value - 10);
        end
    endfunction

    // tx_index: 0='=', 1..4 = 결과 4자리(hi->lo), 5=CR, 6=LF
    function [7:0] tx_char;
        input [2:0]  index;
        input [15:0] value;
        begin
            case (index)
                3'd0: tx_char = "=";
                3'd1: tx_char = hex_to_ascii(value[15:12]);
                3'd2: tx_char = hex_to_ascii(value[11:8]);
                3'd3: tx_char = hex_to_ascii(value[7:4]);
                3'd4: tx_char = hex_to_ascii(value[3:0]);
                3'd5: tx_char = 8'h0d;
                3'd6: tx_char = 8'h0a;
                default: tx_char = " ";
            endcase
        end
    endfunction

    assign busy = (state != S_WAIT_A_HI);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state          <= S_WAIT_A_HI;
            tx_index       <= 3'd0;
            a_hi_nibble    <= 4'd0;
            b_hi_nibble    <= 4'd0;
            result_latched <= 16'd0;
            mul_a          <= 0;
            mul_b          <= 0;
            mul_start      <= 1'b0;
            tx_start       <= 1'b0;
            tx_din         <= 8'd0;
        end else begin
            case (state)
                S_WAIT_A_HI: begin
                    if (rx_done && rx_is_hex) begin
                        a_hi_nibble <= ascii_to_hex(rx_dout);
                        state       <= S_WAIT_A_LO;
                    end
                end

                S_WAIT_A_LO: begin
                    if (rx_done && rx_is_hex) begin
                        mul_a <= {a_hi_nibble, ascii_to_hex(rx_dout)};
                        state <= S_WAIT_B_HI;
                    end
                end

                S_WAIT_B_HI: begin
                    if (rx_done && rx_is_hex) begin
                        b_hi_nibble <= ascii_to_hex(rx_dout);
                        state       <= S_WAIT_B_LO;
                    end
                end

                S_WAIT_B_LO: begin
                    if (rx_done && rx_is_hex) begin
                        mul_b <= {b_hi_nibble, ascii_to_hex(rx_dout)};
                        state <= S_MUL_START;
                    end
                end

                S_MUL_START: begin
                    mul_start <= 1'b1;
                    state     <= S_MUL_WAIT;
                end

                S_MUL_WAIT: begin
                    mul_start <= 1'b0;
                    if (mul_done) begin
                        result_latched <= mul_result;
                        tx_index       <= 0;
                        state          <= S_TX_LOAD;
                    end
                end

                S_TX_LOAD: begin
                    if (!tx_busy) begin
                        tx_din   <= tx_char(tx_index, result_latched);
                        tx_start <= 1'b1;
                        state    <= S_TX_START;
                    end
                end

                S_TX_START: begin
                    if (tx_busy) begin
                        tx_start <= 1'b0;
                        state    <= S_TX_WAIT;
                    end
                end

                S_TX_WAIT: begin
                    if (!tx_busy) begin
                        if (tx_index == 3'd6) begin
                            state <= S_WAIT_A_HI;
                        end else begin
                            tx_index <= tx_index + 1'b1;
                            state    <= S_TX_LOAD;
                        end
                    end
                end

                default: state <= S_WAIT_A_HI;
            endcase
        end
    end

endmodule
