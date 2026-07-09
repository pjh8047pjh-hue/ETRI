module gpio_apb #(
    parameter GPIO_WIDTH = 32
)(
    input  wire                  PRESETn,
    input  wire                  PCLK,
    input  wire                  PSEL,
    input  wire                  PENABLE,
    input  wire [31:0]           PADDR,
    input  wire                  PWRITE,
    input  wire [31:0]           PWDATA,
    output reg  [31:0]           PRDATA,
    input  wire [GPIO_WIDTH-1:0] GPIO_I,
    output wire [GPIO_WIDTH-1:0] GPIO_O,
    output wire [GPIO_WIDTH-1:0] GPIO_T,
    output wire                  IRQ
);

// | 신호       | 역할
// | --------- | ------------------------
// | `PADDR`   | 어느 register에 접근할지 고르는 주소
// | `PWRITE`  | write인지 read인지 결정
// | `PSEL`    | 이 slave가 선택됐는지 표시
// | `PENABLE` | access phase 표시
// | `PWDATA`  | write할 데이터
// | `PRDATA`  | read된 데이터

// APB 레지스터 <-> GPIO 신호 상관관계
// | APB 접근                  | 관련 GPIO 신호            | 관계 설명                                                      |
// | ------------------------ | ------------------------  | -------------------------------------------------------------- |
// | write REG_CTRL           | r_ctrl -> GPIO_T          | 비트=1(output)이면 GPIO_T deassert(출력 인에이블), 0(input)이면 tristate |
// | write REG_LINE           | r_line -> GPIO_O          | r_ctrl이 output인 비트만 r_line 값이 GPIO_O로 나감                |
// | read  REG_LINE           | GPIO_I, r_line -> PRDATA  | r_ctrl=input 비트는 GPIO_I 값을, output 비트는 r_line 값을 반환   |
// | write REG_MASK           | r_mask -> IRQ             | mask=0인 비트만 해당 GPIO의 인터럽트가 IRQ에 반영됨               |
// | read  REG_FLAG           | r_flag -> PRDATA          | 어느 GPIO_I 비트에서 인터럽트가 발생했는지 소프트웨어가 확인       |
// | write REG_FLAG           | r_flag 클리어 -> IRQ 하강  | write-1-to-clear로 처리 완료 비트를 지움                         |
// | write REG_EDGE           | r_edge -> GPIO_I 감지 로직 | level(0)/edge(1) 감지 방식 결정                                 |
// | write REG_POL            | r_pol  -> GPIO_I 감지 로직 | level: low/high, edge: falling/rising 기준 결정                 |
// | (자동, APB 접근 아님)     | GPIO_I -> r_flag -> IRQ   | 감지 로직이 조건 성립 시 r_flag를 세팅하고, mask 통과 시 IRQ assert |

    localparam REG_LINE = 6'h04; // Line Register: 현재 GPIO 핀 level 또는 출력값 제어.
    localparam REG_CTRL = 6'h00; // Line Control Registor: 0이면 input, 1이면 output.
    localparam REG_MASK = 6'h08; // Interrupt Mask Register: interrupt 발생 여부.
    localparam REG_FLAG = 6'h0C; // Interrupt Flag: interrupt 발생 여부.
    localparam REG_EDGE = 6'h10; // Edge/Level Register: 0이면 level, 1이면 edge.
    localparam REG_POL  = 6'h14; // Polarity Register: level이면 low/high 선택, edge면 falling/rising 선택.

    reg [GPIO_WIDTH-1:0] r_line;
    reg [GPIO_WIDTH-1:0] r_ctrl;
    reg [GPIO_WIDTH-1:0] r_mask;
    reg [GPIO_WIDTH-1:0] r_flag;
    reg [GPIO_WIDTH-1:0] r_edge;
    reg [GPIO_WIDTH-1:0]  r_pol;

    assign GPIO_T = ~r_ctrl;
    assign GPIO_O =  r_line;

    wire write = PSEL & PWRITE  & PENABLE;
    wire read  = PSEL & ~PWRITE;

    always @(posedge PCLK or negedge PRESETn) begin
        if(!PRESETn) begin
            PRDATA <= 0;
            r_ctrl <= 0;   // 전부 input
            r_line <= 0;   // 출력값 0
            r_mask <= 1;   // interrupt 전부 disable
            r_flag <= 0;   // interrupt 발생 없음
            r_edge <= 0;   // level mode
            r_pol  <= 0;   // low-level 또는 falling 기준
        end

        else if (write) begin
            case (PADDR[5:0])
                REG_LINE: r_line <= PWDATA[GPIO_WIDTH-1:0];
                REG_CTRL: r_ctrl <= PWDATA[GPIO_WIDTH-1:0];
                REG_MASK: r_mask <= PWDATA[GPIO_WIDTH-1:0];
                REG_FLAG: r_flag <= PWDATA[GPIO_WIDTH-1:0];
                REG_EDGE: r_edge <= PWDATA[GPIO_WIDTH-1:0];
                REG_POL : r_pol  <= PWDATA[GPIO_WIDTH-1:0];
            endcase
        end

        else if(read) begin
            case (PADDR[5:0])
                REG_LINE: PRDATA[GPIO_WIDTH-1:0] <= (r_ctrl & r_line) | (~r_ctrl & GPIO_I);
                REG_CTRL: PRDATA[GPIO_WIDTH-1:0] <= r_ctrl;
                REG_MASK: PRDATA[GPIO_WIDTH-1:0] <= r_mask;
                REG_FLAG: PRDATA[GPIO_WIDTH-1:0] <= r_flag;
                REG_EDGE: PRDATA[GPIO_WIDTH-1:0] <= r_edge;
                REG_POL : PRDATA[GPIO_WIDTH-1:0] <=  r_pol;
            endcase
        end 
    end
endmodule