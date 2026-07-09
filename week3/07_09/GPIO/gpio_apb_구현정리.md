# gpio_apb 구현 정리

## 모듈 개요

APB 슬레이브로 동작하는 범용 GPIO 컨트롤러. `GPIO_WIDTH`(=32)개의 GPIO 라인을 갖고,
각 라인은 레지스터 설정에 따라 입력(버튼)/출력(LED)으로 독립적으로 동작한다.

전체 흐름: 버튼 → FPGA 핀 → IOBUF → `GPIO_I` → (추후 구현) 입력 감지 로직 → interrupt flag
→ IRQ → ARM ISR → APB read/write → `GPIO_O`/`GPIO_T` → LED

## 레지스터 맵

| 이름       | 주소   | 역할                                            |
| ---------- | ------ | ----------------------------------------------- |
| `REG_CTRL` | 0x00   | 방향 제어. 비트=0 input, 1 output                |
| `REG_LINE` | 0x04   | 값 레지스터. write=output 값, read=핀 현재 상태  |
| `REG_MASK` | 0x08   | 인터럽트 마스크 (미구현)                         |
| `REG_FLAG` | 0x0C   | 인터럽트 플래그 (미구현)                         |
| `REG_EDGE` | 0x10   | edge/level 선택 (미구현)                         |
| `REG_POL`  | 0x14   | polarity 선택 (미구현)                           |

`PADDR[5:0]`으로 위 6개 레지스터 중 하나를 고른다. 상위 비트(`PADDR[31:6]`)는 이 모듈이 보지
않고, 버스 상위의 주소 디코더가 `PSEL`을 만들 때 이미 사용한다.

각 레지스터는 32비트 폭이며, 비트 인덱스가 GPIO 라인 번호와 1:1로 대응한다
(`r_ctrl[3]` = GPIO 3번 라인의 방향, 등).

## APB write/read 판단

```verilog
wire write = PSEL & PWRITE  & PENABLE;   // ACCESS phase에서 커밋
wire read  = PSEL & ~PWRITE;             // PENABLE 없이 SETUP phase부터 미리 디코드
```

- `write`는 `PENABLE`까지 포함해서 ACCESS phase에만 커밋되면 충분하다(늦게 반영돼도 문제 없음).
- `read`는 `PENABLE`을 빼서 SETUP phase(전 사이클)부터 주소를 미리 디코드한다. 이 모듈에는
  `PREADY`가 없는 zero-wait-state 슬레이브라서, `PRDATA`가 ACCESS phase가 시작되는 순간
  이미 유효해야 마스터가 정상적으로 값을 샘플링할 수 있다. `PENABLE`을 조건에 넣으면
  레지스터 값이 한 사이클 늦게 나와 read 결과가 틀어진다.

## write 시 레지스터 저장

```verilog
case (PADDR[5:0])
    REG_LINE: r_line <= PWDATA[GPIO_WIDTH-1:0];
    REG_CTRL: r_ctrl <= PWDATA[GPIO_WIDTH-1:0];
    REG_MASK: r_mask <= PWDATA[GPIO_WIDTH-1:0];
    REG_FLAG: r_flag <= PWDATA[GPIO_WIDTH-1:0];   // TODO: write-1-to-clear로 변경 필요
    REG_EDGE: r_edge <= PWDATA[GPIO_WIDTH-1:0];
    REG_POL : r_pol  <= PWDATA[GPIO_WIDTH-1:0];
endcase
```

모든 레지스터는 `PWDATA`를 그대로 저장. 단, `REG_FLAG`는 인터럽트 플래그라서 나중에
"1을 쓴 비트만 클리어"하는 방식으로 바뀌어야 한다(지금은 단순 덮어쓰기).

## read 시 PRDATA 생성

```verilog
case (PADDR[5:0])
    REG_LINE: PRDATA[GPIO_WIDTH-1:0] <= (r_ctrl & r_line) | (~r_ctrl & GPIO_I);
    REG_CTRL: PRDATA[GPIO_WIDTH-1:0] <= r_ctrl;
    REG_MASK: PRDATA[GPIO_WIDTH-1:0] <= r_mask;
    REG_FLAG: PRDATA[GPIO_WIDTH-1:0] <= r_flag;
    REG_EDGE: PRDATA[GPIO_WIDTH-1:0] <= r_edge;
    REG_POL : PRDATA[GPIO_WIDTH-1:0] <=  r_pol;
endcase
```

`REG_LINE`만 특별하다: 같은 32비트 레지스터 안에서도 라인마다 방향이 다를 수 있어서,
`r_ctrl` 비트가 1(output)이면 `r_line` 값을, 0(input)이면 실제 핀 값인 `GPIO_I`를
비트별로 골라서 돌려줘야 한다. `(r_ctrl & r_line) | (~r_ctrl & GPIO_I)`가 그 비트단위 mux.

나머지 레지스터는 저장된 값을 그대로 `PRDATA`에 반환.

## GPIO 출력/방향 생성

```verilog
assign GPIO_T = ~r_ctrl;   // r_ctrl=1(output) -> GPIO_T=0(드라이버 켜짐)
assign GPIO_O =  r_line;   // 출력값은 r_line을 그대로 내보냄
```

- `GPIO_O`/`GPIO_T`는 APB read/write와 무관하게 **항상** `r_line`/`r_ctrl`로부터 조합 로직으로
  나온다(always block 안에 넣지 않음).
- `GPIO_T`는 방향 제어 신호로, IOBUF 기준 0이면 출력 드라이버 활성화, 1이면 Hi-Z(입력 모드).
  `r_ctrl`=1(output 의도)일 때 `GPIO_T`=0이 되도록 반전해서 연결.

## 아직 구현 안 된 부분 (인터럽트)

- **입력 감시**: `GPIO_I`의 이전 값을 저장하는 레지스터, edge 감지를 위해 필요
- **interrupt flag 생성**: `r_edge`/`r_pol`/현재·이전 `GPIO_I`를 보고 조건 성립 시 `r_flag` set
- **IRQ 생성**: `r_flag`와 `r_mask`를 결합해 `assign IRQ = ...` (현재 `IRQ`는 미할당 상태로 floating)
- **flag clear**: `REG_FLAG` write를 write-1-to-clear로 변경, 하드웨어 set과 동시 발생 시 처리
