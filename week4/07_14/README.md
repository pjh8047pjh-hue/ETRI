# 07_14 : AXI4-Lite ↔ UART 예제 코드 관계 정리

이 폴더에는 두 개의 프로젝트가 들어있습니다.

- `axi4_to_lite` : AXI4(Full) → AXI4-Lite **프로토콜 변환 브리지**
- `uart_axi_lite` : AXI4-Lite 슬레이브 포트를 가진 **UART 주변장치(peripheral)**

먼저 결론부터: **이 두 프로젝트는 코드상으로 서로를 직접 인스턴스화하지 않습니다.** 즉 `axi4_to_lite`와 `uart_axi_lite`를 함께 연결한 top 파일은 어디에도 없습니다. 대신 둘은 **AXI4-Lite라는 공통 포트 규격으로 이어붙일 수 있게 설계**되어 있습니다. 이 문서는 각 프로젝트 내부 구조와, 왜 이 둘이 "짝"으로 존재하는지를 설명합니다.

AXI-Lite 프로토콜 자체(AWADDR/AWVALID/AWREADY 핸드셰이크, single-beat 트랜잭션이라는 것 등)와 UART 통신 자체(start/data/parity/stop bit, baud rate)의 기초는 이미 알고 있다고 가정하고, "이 코드에서 그 지식이 실제로 어떻게 쓰였는가"에 집중합니다.

---

## 1. 전체 그림 (Big Picture)

CPU(또는 AXI4 Full 마스터, 예: Zynq PS)가 UART를 제어하려는 상황을 생각해봅시다.

```
[AXI4 Full 마스터]                      [UART 주변장치]
   (버스트, ID, QoS 지원)                (레지스터 몇 개면 충분)
        |                                      ^
        |  AXI4 (Full)                         |  AXI4-Lite
        v                                      |
  +-----------------+   AXI4-Lite   +----------------------+
  |  axi4_to_lite   | ------------> |   uart_axi_lite      |
  |  (m_axil_*)     |               |   (s_axi_*)          |
  +-----------------+               +----------------------+
```

- **왜 브리지가 필요한가?** UART 같은 단순 주변장치는 레지스터 몇 개(제어/상태/송신/수신)만 있으면 되므로 굳이 버스트, ID, QoS 같은 AXI4 Full의 기능이 필요 없습니다. 그래서 `uart_axi_lite`는 **처음부터 AXI4-Lite 슬레이브 포트만** 갖도록 설계되어 있습니다.
- 하지만 SoC의 마스터(CPU, DMA 등)는 보통 AXI4 Full로 나가는 경우가 많습니다. 이럴 때 `axi4_to_lite`가 중간에서 "Full 버스트 → Lite 단일 트랜잭션 여러 개"로 변환해주는 어댑터 역할을 합니다.
- 두 모듈의 포트가 **이름/폭이 동일하게 맞춰져 있어서**, 실제로 SoC에 넣을 때는 `axi4_to_lite.m_axil_*`를 `uart_axi_lite.s_axi_*`에 그대로 와이어링하면 됩니다. (실습 관점에서 보면, "이 두 개를 실제로 잇는 top.sv를 만들어보라"는 것이 자연스러운 다음 과제입니다 — 5장 참고)

---

## 2. `axi4_to_lite` 상세

폴더 구성: `rtl/verilog/axi4_to_lite.v`, `axi4_to_lite_fifo_sync.v` 뿐입니다. (테스트벤치/시뮬레이션/합성 스크립트 없음 — RTL만 제공되는 순수 브리지 IP)

### 포트 비교

📍 `axi4_to_lite/rtl/verilog/axi4_to_lite.v`

| 구분 | AXI4 Full 슬레이브 포트 (`s_axi_*`) | AXI4-Lite 마스터 포트 (`m_axil_*`) |
|---|---|---|
| 주소 | `AWADDR/ARADDR` | `AWADDR/ARADDR` (동일) |
| 버스트 관련 | `AWLEN/AWSIZE/AWBURST`, `ARLEN/ARSIZE/ARBURST` | 없음 (항상 1비트 전송) |
| ID | `AWID/ARID/RID/BID` | 없음 |
| 데이터 | `WDATA/WSTRB/WLAST`, `RDATA/RLAST` | `WDATA/WSTRB`, `RDATA` (LAST 없음) |
| 응답 | `BRESP/RRESP` | `BRESP/RRESP` (동일) |

- `s_axi_*` 포트 선언: `axi4_to_lite.v` 32~61행
- `m_axil_*` 포트 선언: `axi4_to_lite.v` 66~81행

즉 `axi4_to_lite`가 하는 일은 **"버스트/ID 정보를 없애면서, 여러 개의 단일 전송으로 쪼개는 것"**입니다.

### write 경로

📍 `axi4_to_lite.v`의 `axi4_to_lite_write` 모듈 (163~550행), 인스턴스화는 top(`axi4_to_lite` 모듈)의 84~116행

**핸드셰이크 신호 읽는 법** (이 문서에 나오는 모든 `*VALID`/`*READY` 쌍에 공통 적용): `VALID`는 보내는 쪽이 "데이터/주소가 준비됐다"고 세우는 신호, `READY`는 받는 쪽이 "지금 받을 수 있다"고 세우는 신호입니다. **둘 다 1인 바로 그 클럭에만** 실제 전송이 일어나고, 그때의 값이 다음 클럭에 레지스터로 캡처됩니다. 예를 들어 `s_axi_awvalid & s_axi_awready`가 1이 되는 순간 `s_axi_awaddr`가 유효한 값으로 캡처됩니다.

두 개의 독립적인 FSM이 FIFO로 분리(decouple)되어 동작합니다.

1. **AXI4 쪽 FSM (`state`)**: `AWLEN`만큼의 write beat를 받아서, 매 beat의 `{wstrb, wdata}`를 `axi4_to_lite_fifo_sync`(FIFO)에 밀어넣습니다.
   - FSM 상태 정의: 223~226행 / 동작 always 블록: 242~301행
2. **AXI4-Lite 쪽 FSM (`state_lite`)**: `STL_ADDR`에서 **AXI-Lite 주소 채널을 버스트당 딱 한 번만** 핸드셰이크하고, 그 뒤 `STL_DATA`에서 FIFO에 쌓인 데이터를 **주소 재전송 없이** 한 워드씩 연속으로 흘려보냅니다. 마지막 beat까지 다 보내면 `STL_RESP`에서 **BRESP를 한 번만** 받고 끝냅니다. 다음 내부 주소는 `get_next_addr()`로 계산해두지만(INCR 버스트만 정식 지원, WRAP은 제한적 지원), 그 값이 버스에 다시 실리지는 않습니다 — 그래서 이 브리지는 **같은 주소에 데이터를 연속으로 쓰는 슬레이브(예: UART TX 레지스터 같은 FIFO형 레지스터)** 를 겨냥한 설계로 보이며, 매 beat마다 실제 주소가 바뀌어야 하는 일반 RAM류 슬레이브에는 그대로 맞지 않을 수 있습니다.
   - FSM 상태 정의: 355~359행 / 동작 always 블록: 376~426행
   - `get_next_addr()` 함수: 491~529행 (내부 카운터 계산용 — 버스 재전송에는 쓰이지 않음)

#### 신호 흐름표: AXI4 쪽 `state` FSM

| 상태 | 기다리는 입력 신호 | 이 상태에서 내보내는 신호 | 다음 상태로 넘어가는 조건 |
| --- | --- | --- | --- |
| `ST_READY` | `s_axi_awvalid` | `s_axi_awready=1` (항상 받을 준비) | 핸드셰이크 성립 → `regAwaddr/regAwlen` 등 캡처 후 `ST_DATA` |
| `ST_DATA` | `s_axi_wvalid` (매 beat) | `s_axi_wready = fifo_wr_rdy` (FIFO에 자리 있을 때만) | 핸드셰이크마다 `cntWlen` 증가하며 FIFO에 push; `cntWlen==regAwlen`(마지막 beat)이면 `ST_WAIT` |
| `ST_WAIT` | 없음 (내부 `fifo_empty`만 확인) | 아무 신호도 안 냄 | `fifo_empty==1` (Lite 쪽이 FIFO를 다 비웠음) → `ST_RESP` |
| `ST_RESP` | `s_axi_bready` | `s_axi_bvalid=1`, `s_axi_bresp=OKAY`, `s_axi_bid=regAwid` | 핸드셰이크 성립 → `ST_READY`로 복귀 |

#### 신호 흐름표: AXI-Lite 쪽 `state_lite` FSM

| 상태 | 기다리는 입력 신호 | 이 상태에서 내보내는 신호 | 다음 상태로 넘어가는 조건 |
| --- | --- | --- | --- |
| `STL_READY` | 없음 — `state==ST_READY`이면서 `s_axi_awvalid&awready`가 발생하는 순간을 그대로 감지 | `cntLawaddr` 초기화만 | 감지 즉시 `STL_ADDR` (AXI4 쪽과 동시 출발) |
| `STL_ADDR` | `m_axil_awready` | `m_axil_awaddr=cntLawaddr`, `m_axil_awvalid=1` | 핸드셰이크 성립 → `STL_DATA` (이 버스트에서 주소는 여기서 딱 한 번만 나감) |
| `STL_DATA` | `m_axil_wready` + 내부 `fifo_rd_vld`(꺼낼 데이터 있음) | `fifo_rd_rdy=m_axil_wready`, `m_axil_wdata=fifo_rd_dout`, `m_axil_wvalid=fifo_rd_vld` | 핸드셰이크마다 `cntLawlen` 증가; `cntLawlen==regAwlen`이면 `STL_RESP`, 아니면 이 상태에 머물며 다음 beat 계속 스트리밍 |
| `STL_RESP` | `m_axil_bvalid` | `m_axil_bready=1` | 핸드셰이크 성립 → `STL_WAIT` |
| `STL_WAIT` | 없음 (내부 `fifo_empty`만 확인) | `fifo_clr=1` (FIFO 리셋) | `fifo_empty==1` → `STL_READY`로 복귀 |

#### 2-beat 버스트(`AWLEN=1`)가 흘러가는 순서

정확한 클럭 사이클 수보다 "신호가 어떤 순서로 오가는지"에 집중한 논리적 흐름입니다 (Lite 슬레이브가 즉시 응답한다고 가정).

1. `s_axi_awvalid & s_axi_awready` 핸드셰이크 → `regAwaddr`/`regAwlen(=1)` 캡처. AXI4 쪽 `state`는 `ST_READY→ST_DATA`로, **동시에** Lite 쪽 `state_lite`도 `STL_READY→STL_ADDR`로 같이 출발합니다.
2. `s_axi_wvalid & s_axi_wready`(beat0) 핸드셰이크 → `{wstrb,wdata}`가 FIFO에 push, `cntWlen: 0→1`. 비슷한 시점에 `m_axil_awvalid & m_axil_awready` 핸드셰이크 → Lite 쪽 주소 전송 완료, `state_lite: STL_ADDR→STL_DATA`.
3. `s_axi_wvalid & s_axi_wready`(beat1) 핸드셰이크 → FIFO에 두 번째 push, `cntWlen: 1→2`(=`regAwlen`이므로) → AXI4 쪽 `state: ST_DATA→ST_WAIT`(더 이상 beat를 받지 않음).
4. 그 사이 Lite 쪽은 FIFO에서 beat0을 꺼내 `m_axil_wvalid & m_axil_wready` 핸드셰이크로 내보내고(`cntLawlen: 0→1`), 이어서 beat1도 같은 방식으로 내보냅니다(`cntLawlen: 1→2`=`regAwlen`) → `state_lite: STL_DATA→STL_RESP`. **AXI4 쪽은 이미 beat 2개를 다 받아 `ST_WAIT`에 멈춰있는 동안, Lite 쪽은 그걸 하나씩 순서대로 내보내는 중**입니다 — 이게 FIFO가 만들어주는 "속도 차이 흡수"입니다.
5. FIFO가 완전히 비면(`fifo_empty=1`) AXI4 쪽 `state: ST_WAIT→ST_RESP`.
6. `m_axil_bvalid & m_axil_bready` 핸드셰이크 → `state_lite: STL_RESP→STL_WAIT→(fifo_clr 이후)→STL_READY`.
7. `s_axi_bvalid & s_axi_bready` 핸드셰이크 → `state: ST_RESP→ST_READY`로 복귀, 마스터는 `BRESP=OKAY` 응답을 받고 write 완료를 인지합니다.

즉 "버스트 하나 = AXI-Lite 주소 핸드셰이크 1번 + 데이터 핸드셰이크 N번 + 응답 핸드셰이크 1번"으로 변환되는 구조이며, FIFO 덕분에 AXI4 쪽에서 beat를 받는 속도와 AXI-Lite 쪽에서 데이터를 내보내는 속도가 달라도 문제없습니다.

### read 경로

📍 `axi4_to_lite.v`의 `axi4_to_lite_read` 모듈 (559~920행), 인스턴스화는 top의 118~144행

write의 대칭 구조입니다. `ARADDR`는 버스트당 한 번만 요청하고, 그 뒤 `ARLEN`만큼의 RDATA를 FIFO를 통해 순서대로 받아 AXI4 마스터에게 beat 단위로 돌려주며 마지막 beat에서만 `RLAST`를 세팅합니다.

- AXI4 쪽 FSM (`state`): 613~684행
- AXI4-Lite 쪽 FSM (`state_lite`): 739~828행

#### 신호 흐름표: AXI4 쪽 `state` FSM (read)

| 상태 | 기다리는 입력 신호 | 이 상태에서 내보내는 신호 | 다음 상태로 넘어가는 조건 |
| --- | --- | --- | --- |
| `ST_READY` | `s_axi_arvalid` | `s_axi_arready=1` | 핸드셰이크 성립 → `regAraddr/regArlen` 캡처 후 `ST_DATA` |
| `ST_DATA` | `s_axi_rready` + 내부 `fifo_rd_vld` | `s_axi_rvalid=fifo_rd_vld`, `s_axi_rdata/rresp=fifo_rd_dout`, `s_axi_rlast=(regArlen==cntRlen)` | 핸드셰이크마다 `cntRlen` 증가; `cntRlen==regArlen`(마지막 beat)이면 `ST_WAIT` |
| `ST_WAIT` | 없음 (내부 `fifo_empty`만 확인) | `fifo_clr=1` | `fifo_empty==1` → `ST_READY`로 복귀 |

#### 신호 흐름표: AXI-Lite 쪽 `state_lite` FSM (read)

| 상태 | 기다리는 입력 신호 | 이 상태에서 내보내는 신호 | 다음 상태로 넘어가는 조건 |
| --- | --- | --- | --- |
| `STL_READY` | 없음 — `state==ST_READY`이면서 `arvalid&arready` 발생을 그대로 감지 | `cntLaraddr` 초기화만 | 감지 즉시 `STL_ADDR` |
| `STL_ADDR` | `m_axil_arready` | `m_axil_araddr=cntLaraddr`, `m_axil_arvalid=1` | 핸드셰이크 성립 → `STL_DATA` (주소는 버스트당 딱 한 번만) |
| `STL_DATA` | `m_axil_rvalid` | `fifo_wr_vld=m_axil_rvalid`, `fifo_wr_din={rresp,rdata}`, `m_axil_rready=fifo_wr_rdy` | 핸드셰이크마다 `cntLarlen` 증가; `cntLarlen==regArlen`이면 `STL_WAIT`, 아니면 이 상태에 머물며 다음 beat 계속 수신 |
| `STL_WAIT` | 없음 (내부 `fifo_empty`만 확인) | 없음 | `fifo_empty==1` → `STL_READY`로 복귀 |

write와 마찬가지로 `m_axil_araddr`도 버스트당 딱 한 번만 나가고, 이후 beat들은 같은 주소를 그대로 다시 읽는 형태로 스트리밍됩니다. AXI4 쪽에서 마스터에게 돌려주는 `s_axi_rlast`는 `regArlen==cntRlen` 조건으로만 계산되므로, FIFO에서 순서대로 꺼내는 beat 중 **마지막 beat에서만** 1이 됩니다.

### 제약사항

- WRAP 버스트는 기본적으로 미지원 (`BURST_TYPE_WRAPP_ENABLED`로만 제한적 지원)
- AXI와 AXI-Lite 쪽 데이터 폭이 동일해야 함 (둘 다 32비트 고정)
- partial-size access, WLAST/RLAST 불일치, 비정상 BRESP/RRESP 등은 시뮬레이션에서 `$display`로 에러 표시만 함 (synthesis에서는 빠짐)

---

## 3. `uart_axi_lite` 계층 구조

이 프로젝트는 RTL + 테스트벤치(`bench/`) + 시뮬레이션 스크립트(`sim/`) + 합성 스크립트(`syn/`) + C 드라이버(`api/c/`) + 설계 문서(`doc/`)까지 갖춘 완결된 프로젝트입니다.

```
uart_axi_lite.v          (top: AXI-Lite 슬레이브 포트 + uart_tx/rx 핀 + interrupt)
 └─ uart_axi_lite_if.v   (AXI4-Lite 프로토콜 FSM → 단순 bram 스타일 버스로 변환)
 └─ uart_core.v          (글루 모듈: csr/tx/rx를 서로 연결만 함)
     ├─ uart_csr.v        (CSR 레지스터 파일 — AXI와 UART 데이터패스를 잇는 핵심)
     ├─ uart_tx.v          (UART 송신 FSM + baud 타이밍 카운터)
     └─ uart_rx.v          (UART 수신 FSM + 오버샘플링 동기화 + RX FIFO)
          └─ uart_fifo_sync_wt.v  (동기 FIFO, RX 버퍼링용)
```

모든 파일은 `uart_axi_lite/rtl/verilog/` 아래에 있습니다.

### `uart_axi_lite.v` (top)

📍 `rtl/verilog/uart_axi_lite.v`

SoC/블록 디자인에 직접 꽂는 모듈입니다. 표준 AXI4-Lite 슬레이브 32비트 포트(`s_axi_awaddr/wdata/araddr/rdata` 등, Vivado IP 패키저가 인식하도록 `X_INTERFACE_INFO` 속성이 붙어 있음) + `uart_tx`/`uart_rx` 시리얼 핀 + `interrupt` 한 개로 이루어져 있습니다.

- 포트 선언: 25~55행
- `uart_axi_lite_if` 인스턴스화: 78~103행
- `uart_core` 인스턴스화: 105~117행

### `uart_axi_lite_if.v` — "AXI-Lite를 몰라도 되게 만들어주는" 어댑터

📍 `rtl/verilog/uart_axi_lite_if.v`

AXI-Lite의 4-채널 핸드셰이크(AW/W/B, AR/R)를 그대로 처리하는 부분이 여기 다 들어있습니다. 뒷단(`uart_core`)은 AXI를 전혀 몰라도 되고, 대신 아주 단순한 "BRAM 스타일" 버스만 알면 됩니다.

- **write FSM** (73~151행): `STW_READY → STW_ARB → STW_WRITE → STW_RSP` — `AWADDR` 캡처 → `WVALID` 대기 → 내부 `bram_wr` 1클럭 pulse → `BRESP=OKAY` 응답
- **read FSM** (168~245행): `STR_READY → STR_ARB → STR_READ0 → STR_READ1 → STR_END` — `ARADDR` 캡처 → `bram_rd` pulse → `RDATA`/`RRESP=OKAY` 응답
- write와 read가 동시에 들어오면 **write가 우선순위**를 가지도록 중재(arbitration)합니다.
- `bram_addr/bram_wr_data/bram_rd/bram_wr` assign문: 61~65행

변환된 내부 버스 (뒷단 `uart_core`가 보는 인터페이스):

```verilog
bram_addr     [7:0]   // 레지스터 주소
bram_wr_data  [31:0]  // write 데이터
bram_rd_data  [31:0]  // read 데이터
bram_wr               // write 1클럭 pulse
bram_rd               // read 1클럭 pulse
```

이 타이밍은 "주소+rden/wren을 한 클럭 펄스로 주면, 다음 클럭에 rdata가 나온다"는 단순 동기 레지스터 버스입니다 (4장 다이어그램 참고).

### `uart_core.v` — 그냥 배선만 하는 글루

📍 `rtl/verilog/uart_core.v`

```verilog
module uart_core #(...)
(
    input wire reset_n, clk,
    input wire [7:0] addr, input wire wren, rden, input wire [31:0] wdata, output wire [31:0] rdata,
    output wire uart_tx, input wire uart_rx, output wire uart_irq
);
```

`uart_csr` ↔ `uart_tx` ↔ `uart_rx`를 연결하는 것 외에 로직이 거의 없습니다. 연결하는 신호는: `txd/tx_vld/tx_done`(송신 핸드셰이크), `rxd/rx_perr/rx_overrun/rx_vld/rx_done`(수신 핸드셰이크), `division/width/parity/even/stop/fifo_clr`(설정 값 — tx/rx 양쪽에 동일하게 팬아웃).

- 포트 선언: 26~40행
- `uart_csr` 인스턴스화: 58~82행
- `uart_tx` 인스턴스화: 84~97행
- `uart_rx` 인스턴스화: 99~115행

### `uart_tx.v` / `uart_rx.v` — 진짜 시리얼 통신 담당

📍 `rtl/verilog/uart_tx.v`, `rtl/verilog/uart_rx.v`

- **`uart_tx`**: `ST_READY → ST_START → ST_DATA → ST_PARITY(옵션) → ST_STOP → ST_WAIT` FSM. `division` 값으로 결정된 baud 주기마다 비트를 하나씩 LSB부터 내보냅니다. 다 보내면 `tx_done` 펄스.
  - 상태 정의: `uart_tx.v` 54~59행 / FSM 본체: 63~167행
- **`uart_rx`**: 2단 플립플롭 동기화로 메타스테이블 방지 → edge 검출로 start bit 인식 → 비트 중앙(`division_half`)에서 샘플링 → 다 받으면 `uart_fifo_sync_wt`(9비트 폭: parity error 1비트 + 데이터 8비트, 깊이 8)에 push. FIFO가 가득 차면 자동으로 가장 오래된 데이터를 pop해서 영구 lock을 방지합니다.
  - 동기화 플립플롭: `uart_rx.v` 35~49행 / FSM 본체: 92~189행 / FIFO 인스턴스화: 210~226행

이 두 모듈은 **AXI를 전혀 몰라도 되는, 순수한 시리얼 통신 로직**입니다. `uart_csr`를 통해서만 바깥세상(레지스터)과 연결됩니다.

---

## 4. `uart_csr.v` 집중 해설 — AXI와 UART를 잇는 진짜 "번역 계층"

지금 열어보신 `uart_csr.v`가 이 프로젝트의 핵심입니다. AXI 프로토콜도, 시리얼 비트 타이밍도 몰라도 되고, 오직 **"레지스터 읽기/쓰기"와 "TX/RX 핸드셰이크 신호"**만 다룹니다.

📍 `uart_axi_lite/rtl/verilog/uart_csr.v` (포트 선언: 28~58행)

```verilog
module uart_csr #(...)
(
      input  wire         reset_n, clk
    , input  wire  [ 7:0] addr
    , input  wire         wren, rden
    , input  wire  [31:0] wdata
    , output reg   [31:0] rdata
    , output wire         irq
    //-- uart_tx 쪽 --
    , output wire  [ 7:0] txd
    , output wire         tx_vld   // txd가 유효함을 알림
    , input  wire         tx_done  // 송신 완료 pulse
    //-- uart_rx 쪽 --
    , input  wire  [ 7:0] rxd
    , input  wire         rx_perr, rx_overrun, rx_vld
    , output reg          rx_done  // 수신 확인(FIFO pop) pulse
    //-- 공용 설정 --
    , output wire [15:0]  division
    , output wire         width, parity, even, stop, fifo_clr
);
```

### 레지스터 맵 (offset은 `uart_axi_lite`의 `s_axi_awaddr`/`araddr` 하위 비트로 접근)

📍 offset 정의: `uart_csr.v` 61~67행 (`localparam CSRA_*`) / 비트필드는 read case문 94~121행, write case문 137~148행

| Offset | 이름 | R/W | 내용 |
|---|---|---|---|
| `0x00` | VERSION | R | 버전 값 (파라미터) |
| `0x04` | NAME | R | "UART" 문자열 (ASCII) |
| `0x10` | CONTROL | R/W | `[22]fifo_clr [21]ie_rx [20]ie_tx [19]stop [18]even [17]parity [16]width [15:0]division` |
| `0x14` | STATUS | R/W1C | `[4]rx_perr [3]rx_vld [2]tx_vld [1]ip_rx [0]ip_tx` (0/1비트는 0을 써서 클리어 가능) |
| `0x18` | TX | R/W | write: `[7:0]`에 보낼 바이트 → 송신 트리거 / read: `{tx_vld, csr_tx}` |
| `0x1C` | RX | R | read하면 `{rx_vld, rx_perr, rxd}` 반환 + 동시에 `rx_done` pulse (FIFO pop) |
| `0x20` | CLK_FREQ | R | 클럭 주파수 파라미터 |

(테스트벤치 기준으로 이 주변장치는 `0x9000_0000` 베이스 주소에 매핑되어 있습니다.)

### TX 경로: "AXI write → 시리얼 송신"

📍 `uart_csr.v` 156~174행 (TX 관련 always 블록), 199~200행 (txd/tx_vld assign)

```verilog
if ((wren==1'b1)&&(addr==CSRA_TX)) begin
    csr_tx     <= wdata[7:0];   // CPU가 보낼 바이트를 write
    csr_tx_vld <= 1'b1;         // "보낼 데이터 있음" 플래그 세팅
end else begin
    if (tx_done) begin          // uart_tx가 다 보내면
        csr_tx_vld <= 1'b0;     // 플래그 클리어
        csr_ip_tx  <= csr_ie_tx;// (인터럽트 활성화 시) pending 세팅
    end
end
...
assign txd    = csr_tx;
assign tx_vld = csr_tx_vld;
```

**흐름**: CPU가 `0x18`(TX)에 write → `csr_tx_vld=1` → 이 값이 그대로 `uart_tx` 모듈의 `tx_vld` 입력으로 나감 → `uart_tx`가 비트 단위로 전송 시작 → 다 보내면 `uart_tx`가 `tx_done` 1클럭 pulse를 돌려줌 → `uart_csr`가 이를 받아 `csr_tx_vld`를 내리고 인터럽트 pending 세팅.

### RX 경로: "시리얼 수신 → AXI read"

📍 `uart_csr.v` 115~118행 (CSRA_RX read case), 201~203행 (csr_rx* assign)

```verilog
CSRA_RX: begin
    rdata   <= {csr_rx_vld, csr_rx_perr, 22'h0, csr_rx};
    rx_done <= csr_rx_vld;   // read하는 순간 FIFO pop 신호를 쏨
end
...
assign csr_rx      = rxd;      // uart_rx의 FIFO 출력이 그대로 들어옴
assign csr_rx_perr = rx_perr;
assign csr_rx_vld  = rx_vld;
```

**흐름**: `uart_rx`가 한 바이트를 다 받으면 내부 FIFO에 저장 + `rx_vld=1` → 이 값이 `uart_csr`의 `csr_rx_vld`로 그대로 전달됨 → CPU가 `0x1C`(RX)를 read → 그 순간 `rx_done` pulse가 나가서 `uart_rx`의 FIFO에서 해당 바이트를 pop → 다음 바이트를 받을 준비.

### 설정 경로: CONTROL 레지스터 하나로 tx/rx 둘 다 제어

📍 `uart_csr.v` 189~194행

```verilog
assign division = csr_division;  // baud rate 분주값
assign width    = csr_width;     // 8bit/7bit
assign parity   = csr_parity;    // parity 사용 여부
assign even     = csr_even;      // odd/even parity
assign stop     = csr_stop;      // stop bit 1개/2개
assign fifo_clr = csr_fifo_clr;
```

`CONTROL`(`0x10`) 한 번 write로 이 값들이 모두 갱신되고, `uart_tx`와 `uart_rx` **양쪽에 동일하게** 팬아웃되어 두 모듈이 항상 같은 프레임 포맷/baud로 동작하도록 보장합니다.

### 인터럽트

📍 `uart_csr.v` 196~197행 → `uart_core.v` 67행(`irq(uart_irq)` 연결) → `uart_axi_lite.v` 116행(`uart_irq(interrupt)` 연결)

```verilog
assign irq = (csr_ie_tx & csr_ip_tx) | (csr_ie_rx & csr_ip_rx);
```

`uart_csr.irq` → `uart_core.uart_irq` → `uart_axi_lite.interrupt`로 그대로 올라가서 top의 `interrupt` 출력 핀이 됩니다. CPU는 폴링 대신 이 인터럽트를 받고 STATUS 레지스터를 확인해 TX 여유/RX 도착을 알 수 있습니다.

---

## 5. 두 프로젝트를 실제로 잇는다면? (연습 문제)

현재 `uart_axi_lite`의 테스트벤치(`bench/verilog/top.sv`)는 `tester.sv`라는 **AXI-Lite 마스터 BFM(Bus Functional Model)**이 `uart_axi_lite`를 직접 구동합니다. BFM 자체가 이미 AXI-Lite로 말하기 때문에 `axi4_to_lite` 브리지가 필요 없는 것이고, 그래서 시뮬레이션 어디에도 `axi4_to_lite`가 등장하지 않는 것입니다.

📍 `bench/verilog/top.sv` 37~60행(`uart_axi_lite` 인스턴스화), 62~85행(`tester` 인스턴스화)

만약 실제 SoC 환경(예: Zynq PS의 AXI4 Full 마스터 포트)에서 이 UART를 쓰고 싶다면, 새 top 파일에서 아래처럼 두 모듈을 이어야 합니다.

📍 좌측 열: `axi4_to_lite.v` 66~81행 / 우측 열: `uart_axi_lite.v` 35~50행

| `axi4_to_lite` (마스터 출력) | → | `uart_axi_lite` (슬레이브 입력) |
|---|---|---|
| `m_axil_awaddr/awvalid` | → | `s_axi_awaddr/awvalid` |
| `m_axil_awready` | ← | `s_axi_awready` |
| `m_axil_wdata/wvalid` | → | `s_axi_wdata/wvalid` |
| `m_axil_wready` | ← | `s_axi_wready` |
| `m_axil_bresp/bvalid` | ← | `s_axi_bresp/bvalid` |
| `m_axil_bready` | → | `s_axi_bready` |
| `m_axil_araddr/arvalid` | → | `s_axi_araddr/arvalid` |
| `m_axil_arready` | ← | `s_axi_arready` |
| `m_axil_rdata/rresp/rvalid` | ← | `s_axi_rdata/rresp/rvalid` |
| `m_axil_rready` | → | `s_axi_rready` |

이름 규칙(`m_axil_*` ↔ `s_axi_*`)만 다를 뿐 신호 의미와 폭이 동일하므로, 이 표대로 와이어링하는 top 모듈 하나만 새로 만들면 두 프로젝트가 연결됩니다.

---

## 6. 전체 신호 흐름 요약

📍 각 박스에 대응하는 파일: `axi4_to_lite.v` → `uart_axi_lite_if.v` → `uart_csr.v` → `uart_tx.v`/`uart_rx.v` (모두 위 2~4장에서 다룬 파일과 동일)

```
AXI4 Full 마스터
     │  (AWID/AWLEN/... 포함 버스트)
     ▼
┌─────────────────────┐
│   axi4_to_lite      │  버스트 1개 → Lite 트랜잭션 N개로 분해 (FIFO로 디커플)
└─────────────────────┘
     │  AXI4-Lite (m_axil_* → s_axi_*)
     ▼
┌─────────────────────┐
│  uart_axi_lite_if   │  AXI-Lite 핸드셰이크 → 단순 addr/wren/rden 버스로 변환
└─────────────────────┘
     │  bram_addr / bram_wr_data / bram_rd_data / bram_wr / bram_rd
     ▼
┌─────────────────────┐
│      uart_csr       │  레지스터맵 해석, TX/RX 핸드셰이크, 인터럽트 생성
└─────────────────────┘
     │  txd/tx_vld/tx_done          │  rxd/rx_perr/rx_vld/rx_done
     ▼                              ▲
┌───────────┐                ┌───────────┐
│  uart_tx  │                │  uart_rx  │
└───────────┘                └───────────┘
     │                              ▲
     ▼ uart_tx 핀 (시리얼 출력)      │ uart_rx 핀 (시리얼 입력)
```

이 한 줄로 요약하면: **`axi4_to_lite`는 "버스 프로토콜"만 변환하고, `uart_csr`는 "레지스터 세계"와 "시리얼 비트 세계"를 잇는 진짜 번역 계층**입니다.
