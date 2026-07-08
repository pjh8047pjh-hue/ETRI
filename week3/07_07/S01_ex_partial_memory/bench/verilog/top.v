`timescale 1ns/1ns

// CLK_FREQ가 외부에서 정의되지 않았으면 기본값 50MHz를 사용합니다.
`ifndef CLK_FREQ
`define CLK_FREQ 50000000 // 50Mhz
`endif

// top은 시뮬레이션용 최상위 모듈입니다.
// 실제 하드웨어 모듈(memory)과 테스트 모듈(tester)을 연결합니다.
module top;

    // localparam은 이 모듈 안에서만 사용하는 상수입니다.
    localparam CLK_FREQ=`CLK_FREQ;
    // 클럭을 반 주기마다 뒤집기 위해 half period를 계산합니다.
    localparam CLK_PERIOD_HALF=1000000000/(CLK_FREQ*2);
    localparam ADD_WIDTH=10, DAT_WIDTH=8;

    // reg는 always/initial 블록 안에서 값을 바꿀 수 있는 신호 타입입니다.
    reg clk = 1'b0;

    // 지정한 반 주기마다 clk를 반전시켜 클럭을 만듭니다.
    always #CLK_PERIOD_HALF clk <= ~clk;

    // wire는 모듈과 모듈 사이를 연결하는 선입니다.
    wire [ADD_WIDTH-1:0] add;
    wire [DAT_WIDTH-1:0] dataW;
    wire [DAT_WIDTH-1:0] dataR;
    wire en, we;

    // DUT(Device Under Test): 검증하려는 memory 모듈입니다.
    memory
    // 게이트 레벨 시뮬레이션(GATESIM)이 아닐 때만 파라미터를 넘깁니다.
    `ifndef GATESIM
        #(.ADD_WIDTH(ADD_WIDTH),.DAT_WIDTH(DAT_WIDTH))
    `endif
    u_memory (
        .clk (clk )
        , .add (add )
        , .dout (dataR)
        , .din (dataW)
        , .en (en )
        , .we (we )
    );

    // tester는 memory에 주소/데이터/제어신호를 보내고 결과를 확인합니다.
    tester #(.ADD_WIDTH(ADD_WIDTH),.DAT_WIDTH(DAT_WIDTH))
        u_tester (
            .clk (clk )
            , .add (add )
            , .dataR(dataR)
            , .dataW(dataW)
            , .en (en )
            , .we (we )
        );


    initial begin
        // GTKWave 등에서 볼 수 있는 VCD 파형 파일을 생성합니다.
        $dumpfile("wave.vcd");
        // top 아래의 모든 신호를 파형에 기록합니다.
        $dumpvars(0);
        // tester가 done을 1로 만들 때까지 기다립니다.
        wait (u_tester.done==1'b1);
        // 시뮬레이션을 종료합니다.
        $finish(2);
    end
endmodule
