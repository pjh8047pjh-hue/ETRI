`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: baudrate_gen
// Description: clk_in을 나눠서 지정한 BAUD_RATE 주기로 1클럭짜리 baud_tick 펄스를 생성
//              CLK_FREQ / BAUD_RATE 값이 실제 보드/목표 통신속도와 다르면
//              파라미터를 바꿔서 재사용하면 됨
//////////////////////////////////////////////////////////////////////////////////

module baudrate_gen #(
    parameter CLK_FREQ  = 100_000_000,
    parameter BAUD_RATE = 115_200
)(
    input      clk_in,
    input      rst_n,
    input      en,          // 0이면 분주 카운터 정지(저전력) - 항상 켜진 wake 감지기가 이 신호를 만들어줌
    output reg baud_tick
);

    localparam integer DIVISOR = CLK_FREQ / BAUD_RATE;

    reg [$clog2(DIVISOR)-1:0] cnt;

    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            cnt       <= 0;
            baud_tick <= 1'b0;
        end else if (!en) begin
            // 꺼져있는 동안 카운트를 0으로 유지 -> 다음에 켜질 때 항상 같은 위상에서 재시작
            cnt       <= 0;
            baud_tick <= 1'b0;
        end else if (cnt == DIVISOR - 1) begin
            cnt       <= 0;
            baud_tick <= 1'b1;
        end else begin
            cnt       <= cnt + 1'b1;
            baud_tick <= 1'b0;
        end
    end

endmodule
