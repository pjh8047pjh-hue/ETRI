`timescale 1ns/1ns

// tester는 시뮬레이션에서만 사용하는 테스트벤치 모듈입니다.
// memory에 read/write 시나리오를 넣고 결과가 맞는지 확인합니다.
module tester #(
    parameter ADD_WIDTH = 10,
    parameter DAT_WIDTH = 8
)(
    input wire clk,
    // dataR은 memory에서 읽혀 나온 데이터입니다.
    input wire [DAT_WIDTH-1:0] dataR,
    
    // en, we, add, dataW는 tester가 memory로 보내는 입력 자극입니다.
    output reg en, we, 
    output reg [ADD_WIDTH-1:0] add,
    output reg [DAT_WIDTH-1:0] dataW
);
    
    // 테스트벤치에서 신호 변경 타이밍을 조금 뒤로 밀기 위한 지연값입니다.
    localparam DELAY = 1;
    localparam DEPTH = 1<<ADD_WIDTH;

    // top 모듈이 이 done 신호를 보고 시뮬레이션 종료 시점을 결정합니다.
    reg done;
    // 테스트에 사용할 임시 데이터 저장용 레지스터입니다.
    reg [DAT_WIDTH-1:0] data;

    // task는 반복되는 테스트 절차를 묶어둔 Verilog 문법입니다.
    // 이 task는 먼저 write를 하고, 그 다음 같은 주소를 read합니다.
    task read_after_write;
        input [ADD_WIDTH-1:0] A;
        // inout은 task 안에서 값을 읽고 다시 바꿔서 호출한 쪽에 돌려줄 수 있습니다.
        inout reg [DAT_WIDTH-1:0] D;
        begin
            // write 구간
            begin
                we = 1'b0;
                // @(posedge clk)는 다음 클럭 상승 에지까지 기다린다는 뜻입니다.
                @(posedge clk);
                    add <= #(DELAY) A;
                    dataW <= #(DELAY) D;
                    en <= #(DELAY) 1'b1;
                    we <= #(DELAY) 1'b1;
                @(posedge clk);
                    en <= #(DELAY) 1'b0;
                    we <= #(DELAY) 1'b0;
                @(posedge clk);
            end

            // read 구간: 같은 주소 A에서 데이터를 읽어 D에 저장합니다.
            begin
                we = 1'b0;
                @ (posedge clk);
                    add <= #(DELAY) A;
                    en <= #(DELAY) 1'b1;
                @ (posedge clk);
                    en <= #(DELAY) 1'b0;
                @ (posedge clk);
                    D = dataR;
            end
        end
    endtask

    
    // 이 task는 read를 먼저 한 뒤, 그 값을 다시 write하고 다시 read합니다.
    // 기존 메모리 값과 write 이후 값을 비교하는 흐름을 연습하기 좋습니다.
    task write_after_read;
        input [ADD_WIDTH-1:0] A;
        inout reg [DAT_WIDTH-1:0] D;
        begin
            
            // 첫 번째 read 구간
            begin
                we = 1'b0;
                @ (posedge clk);
                    add <= #(DELAY) A;
                    en <= #(DELAY) 1'b1;
                @ (posedge clk);
                    en <= #(DELAY) 1'b0;
                @ (posedge clk);
                    D = dataR;
            end
            
            // write 구간
            begin
                we = 1'b0;
                @(posedge clk);
                    add <= #(DELAY) A;
                    dataW <= #(DELAY) D;
                    en <= #(DELAY) 1'b1;
                    we <= #(DELAY) 1'b1;
                @(posedge clk);
                    en <= #(DELAY) 1'b0;
                    we <= #(DELAY) 1'b0;
                @(posedge clk);
            end

            // 두 번째 read 구간: write한 값이 다시 읽히는지 확인합니다.
            begin
                we = 1'b0;
                @ (posedge clk);
                    add <= #(DELAY) A;
                    en <= #(DELAY) 1'b1;
                @ (posedge clk);
                    en <= #(DELAY) 1'b0;
                @ (posedge clk);
                    D = dataR;
            end
        end
    endtask

    initial begin
        // 테스트 시작 전에는 done을 0으로 둡니다.
        done = 1'b0;

        // 8'hA5는 8bit 16진수 값 A5입니다.
        data = 8'hA5;
        // 주소 10에 A5를 쓰고 다시 읽습니다.
        read_after_write(10'd10, data);
        // 주소 15에서 read -> write -> read 순서로 동작을 확인합니다.
        write_after_read(10'd15, data);

        // ===는 X/Z 같은 미정 값까지 엄격하게 비교합니다.
        if (data === 8'hA5) $display("[PASS] addr=%0d data=%0h", 10'h000, data);
        else                $display("[FAIL] addr=%0d data=%0h", 10'h000, data);

        // top.v가 이 신호를 보고 시뮬레이션을 끝냅니다.
        done = 1'b1;
    end
endmodule
