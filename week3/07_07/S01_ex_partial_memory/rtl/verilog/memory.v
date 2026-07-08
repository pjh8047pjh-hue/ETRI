// 간단한 동기식 메모리 모듈입니다.
// - clk의 상승 에지(posedge)에서만 읽기/쓰기가 일어납니다.
// - en이 1일 때만 메모리가 동작합니다.
// - we가 1이면 write, 0이면 read입니다.
module memory #(
    // 주소 폭이 10bit이면 2^10 = 1024개의 주소를 사용할 수 있습니다.
    parameter ADD_WIDTH = 10,
    // 데이터 폭이 8bit이면 한 주소에 8bit 데이터를 저장합니다.
    parameter DAT_WIDTH = 8
)(
    // clk: 동작 기준 클럭, en: enable, we: write enable
    input wire clk, en, we,
    // add: 접근할 메모리 주소
    input wire [ADD_WIDTH-1:0] add,
    // din: 메모리에 쓸 데이터
    input wire [DAT_WIDTH-1:0] din,
    // dout: 메모리에서 읽은 데이터
    output reg [DAT_WIDTH-1:0] dout
);

    // 시뮬레이션에서 출력이 1 time unit 뒤에 바뀌는 것처럼 보이게 하는 지연값입니다.
    localparam DELAY = 1;
    // 전체 메모리 깊이입니다. ADD_WIDTH가 10이면 1024입니다.
    localparam DEPTH = 1<<ADD_WIDTH;

    // 실제 저장 공간입니다. DAT_WIDTH 크기의 데이터를 DEPTH개 저장합니다.
    reg [DAT_WIDTH-1:0] mem[0:DEPTH-1];

    // 순차 논리: clk 상승 에지마다 실행됩니다.
    always @(posedge clk) begin
        if(en == 1'b1) begin
            if (we == 1'b1) begin
                // write 동작: 주소 add에 din을 저장합니다.
                mem[add] <= din;
                // write-through처럼 방금 쓴 값을 dout으로도 내보냅니다.
                dout <= #(DELAY) din;
            end else begin
                // read 동작: 주소 add에 저장된 값을 dout으로 내보냅니다.
                dout <= #(DELAY) mem[add];
            end
        end
    end
endmodule
