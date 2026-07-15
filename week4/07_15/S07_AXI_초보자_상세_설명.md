# S07 AMBA AXI 초보자용 상세 설명

> 대상: Verilog/SystemVerilog의 기본 문법과 클록 동기식 회로를 막 배운 학습자  
> 범위: S07의 AXI 소개, 상세 규칙, BFM/메모리 실습, 2-master/2-slave AXI 설계  
> 읽는 방법: 처음에는 1~7장을 순서대로 읽고, 실습할 때 8~12장을 다시 참고한다.

## 0. 이 자료에서 무엇을 배우는가

S07의 핵심은 한 문장으로 다음과 같다.

> **AXI는 주소, 데이터, 응답을 서로 독립된 채널로 옮기고, 각 채널은 `VALID && READY`가 참인 클록 에지에서 한 번의 전송을 완료한다.**

처음 AXI 신호 목록을 보면 선이 너무 많아 보인다. 그러나 모든 신호를 한꺼번에 외울 필요는 없다. 먼저 다음 세 층으로 나누면 된다.

1. **채널**: 읽기 주소 `AR`, 읽기 데이터 `R`, 쓰기 주소 `AW`, 쓰기 데이터 `W`, 쓰기 응답 `B`
2. **핸드셰이크**: 각 채널의 `VALID`와 `READY`
3. **부가 정보**: 주소, 데이터, burst 길이, ID, 응답 코드, 보호·캐시 속성 등

S07의 네 파일은 다음 순서로 이어진다.

| 원본 | 역할 | 이 문서에서 다루는 장 |
|---|---|---|
| [S07_01_amba_axi_intro.pdf](../../GoogleDrive/slides/S07_01_amba_axi_intro.pdf) | AXI의 큰 그림, 5채널, 핸드셰이크, 주요 신호 | 1~5장 |
| [S07_02_amba_axi_details.pdf](../../GoogleDrive/slides/S07_02_amba_axi_details.pdf) | burst, byte lane, 응답, ID, atomic, 채널 의존성 | 6~7장 |
| [S07_03_mem_axi_bfm_task.pdf](../../GoogleDrive/slides/S07_03_mem_axi_bfm_task.pdf) | task 기반 BFM과 AXI 메모리 검증 | 8~9장 |
| [S07_04_amba_axi_design.pdf](../../GoogleDrive/slides/S07_04_amba_axi_design.pdf) | 여러 master/slave를 연결하는 AXI switch | 10장 |

PDF는 한 페이지에 강의 슬라이드 두 장이 배치된 형태다. 이 문서에서 “슬라이드 7”이라고 하면 PDF 뷰어의 페이지 번호가 아니라 슬라이드 안에 인쇄된 번호를 뜻한다.

### 학습을 마친 뒤 할 수 있어야 하는 것

- AXI의 다섯 채널 방향과 각 채널의 역할을 설명한다.
- 파형에서 실제 전송이 일어난 클록을 찾는다.
- `AxLEN`, `AxSIZE`, `AxBURST`, `WSTRB`, `xLAST`의 의미를 계산한다.
- 읽기·쓰기 transaction이 어떤 transfer들로 구성되는지 구분한다.
- stall이 걸려도 `VALID`와 payload를 올바르게 유지하는 RTL을 작성한다.
- BFM task가 주소·데이터·응답 채널을 왜 `fork/join`으로 동시에 실행하는지 설명한다.
- 2-master/2-slave switch에 주소 decode, arbitration, ID routing이 왜 필요한지 설명한다.

---

## 1. AXI가 필요한 이유와 AMBA 계열의 위치

### 1.1 SoC 안에도 통신 규칙이 필요하다

SoC에는 CPU, DMA, 메모리 컨트롤러, UART, GPIO, 가속기처럼 서로 다른 블록이 들어 있다. 각 블록이 임의의 신호 규칙을 사용하면 블록을 연결할 때마다 별도의 변환 회로를 만들어야 한다. AMBA는 이 블록들이 주소와 데이터를 주고받는 공통 규칙이다.

택배에 비유하면 다음과 같다.

- **주소 채널**: 배송지와 배송 조건이 적힌 송장
- **데이터 채널**: 실제 상자
- **응답 채널**: 배달 성공 또는 실패 확인
- **VALID**: “지금 송장/상자가 유효합니다.”
- **READY**: “지금 받을 공간이 있습니다.”

중요한 점은 송장, 상자, 확인서가 서로 다른 통로로 움직인다는 것이다. 이것이 AXI가 높은 처리량을 얻는 핵심이다.

### 1.2 APB, AHB, AXI를 어떻게 구분할까

| 버스 | 적합한 곳 | 특징 |
|---|---|---|
| APB | UART/GPIO 같은 저속 제어 레지스터 | 구조가 단순하고 면적이 작음 |
| AHB/AHB-Lite | 마이크로컨트롤러의 비교적 단순한 시스템 버스 | 주소와 데이터가 pipeline으로 이어짐 |
| AXI4-Lite | 제어·상태 레지스터 | AXI 핸드셰이크를 쓰지만 burst와 ID가 없음 |
| AXI3/AXI4 | DDR, DMA, 고성능 가속기 | 독립 채널, burst, 여러 outstanding transaction, ID 지원 |
| ACE/CHI | 여러 캐시가 있는 고성능 시스템 | coherency와 더 높은 확장성 지원 |

AXI4-Lite를 이미 배웠다면 full AXI는 “동일한 5채널에 burst와 ID, 여러 outstanding 기능을 추가한 것”으로 이해하면 좋다.

### 1.3 master와 slave라는 용어

원본 슬라이드는 AXI 사양의 전통적 용어인 **master**와 **slave**를 사용한다.

- **master**: transaction을 시작한다. 읽기·쓰기 주소를 보낸다.
- **slave**: 주소에 해당하는 장치다. 읽기 데이터를 돌려주거나 쓰기 데이터를 저장한다.

단, 채널별로 “보내는 쪽(source)”은 달라진다. 예를 들어 `R` 채널에서는 slave가 데이터를 보내므로 slave가 source이고 master가 destination이다. 핸드셰이크 규칙을 이해할 때는 master/slave보다 **source/destination**이라는 관점이 더 안전하다.

---

## 2. 먼저 정확히 구분해야 할 용어

S07_01 슬라이드 5의 용어는 이후 모든 설명의 기초다.

| 용어 | 뜻 | 예 |
|---|---|---|
| Bus | 여러 비트로 된 하나의 신호 묶음 | `WDATA[31:0]` |
| Channel | 하나의 `VALID/READY` 쌍으로 함께 전달되는 신호 묶음 | `AWADDR`, `AWLEN`, `AWVALID`, `AWREADY` |
| Interface | 한 IP가 외부에 노출하는 여러 채널의 집합 | AXI master interface |
| Transfer | 한 채널에서 한 번의 `VALID && READY`로 정보가 전달되는 사건 | AW 주소 한 번, R 데이터 한 beat |
| Beat | burst의 데이터 transfer 한 번 | 32-bit 데이터 한 덩어리 |
| Transaction | 주소부터 데이터와 필요한 응답까지 포함한 전체 작업 | 한 번의 read burst 또는 write burst |
| Burst | 데이터 beat가 둘 이상인 transaction | 주소 1개 + 데이터 8개 |
| Outstanding | 주소 요청은 받아들여졌지만 아직 모든 데이터/응답이 끝나지 않은 상태 | read 요청 3개가 진행 중 |

### 2.1 transfer와 transaction을 혼동하지 말자

4-beat read burst를 예로 들면 다음과 같다.

- `AR` 채널 transfer 1번
- `R` 채널 transfer 4번
- 합쳐서 read transaction 1개

4-beat write burst는 다음과 같다.

- `AW` 채널 transfer 1번
- `W` 채널 transfer 4번
- `B` 채널 transfer 1번
- 합쳐서 write transaction 1개

따라서 “전송 한 번”이라는 한국어 표현만 쓰면 beat인지 transaction인지 모호하다. 파형을 설명할 때는 “AW transfer”, “세 번째 W beat”, “write transaction 완료”처럼 정확히 말하는 습관이 좋다.

---

## 3. AXI의 다섯 독립 채널

S07_01 슬라이드 9~21의 그림은 AXI 전체를 다섯 통로로 나누어 보여 준다.

| 채널 | 접두사 | 정보 방향 | source → destination | 주요 내용 |
|---|---|---|---|---|
| Write Address | `AW` | master → slave | master → slave | 쓸 주소, 길이, beat 크기, burst 종류, ID |
| Write Data | `W` | master → slave | master → slave | 쓸 데이터, 유효 byte 표시, 마지막 beat 표시 |
| Write Response | `B` | slave → master | slave → master | 쓰기 성공/실패, ID |
| Read Address | `AR` | master → slave | master → slave | 읽을 주소, 길이, beat 크기, burst 종류, ID |
| Read Data | `R` | slave → master | slave → master | 읽은 데이터, beat별 응답, 마지막 beat, ID |

읽기는 `AR + R`, 쓰기는 `AW + W + B`다.

### 3.1 “독립”의 정확한 뜻

채널이 독립이라는 말은 다음을 뜻한다.

- 채널마다 별도의 `VALID/READY`가 있다.
- 한 채널이 stall되어도 다른 채널은 진행할 수 있다.
- 쓰기 주소와 쓰기 데이터는 같은 클록에 도착할 필요가 없다.
- 파이프라인 register slice를 채널마다 다르게 넣을 수 있다.

독립이라고 해서 transaction 관계가 사라지는 것은 아니다.

- 읽기 데이터는 관련 읽기 주소가 handshake된 뒤에만 나올 수 있다.
- 쓰기 응답은 관련 주소와 마지막 쓰기 데이터가 받아들여진 뒤에만 나올 수 있다.
- ID와 순서 규칙을 통해 어느 응답이 어느 요청에 속하는지 보존해야 한다.

### 3.2 왜 쓰기 채널이 세 개인가

주소, 데이터, 완료 응답을 분리하면 다음 장점이 있다.

- 주소 decode와 데이터 이동을 pipeline할 수 있다.
- slave가 내부 buffer에 데이터를 받은 뒤 실제 처리 결과를 별도로 응답할 수 있다.
- interconnect가 주소로 목적지를 결정하고, 데이터와 응답을 적절한 경로로 보낼 수 있다.

하지만 설계자는 AW와 W의 도착 순서가 다를 수 있다는 점을 반드시 처리해야 한다. “항상 주소가 먼저 올 것”이라고 가정하는 slave는 정상 AXI traffic에서도 실패할 수 있다.

### 3.3 신호 이름을 읽는 방법

AXI 신호는 대체로 **채널 접두사 + 기능 이름**으로 되어 있다.

- `AR` + `BURST` = `ARBURST`: Read Address 채널에서 읽기 burst 종류를 지정
- `AW` + `LEN` = `AWLEN`: Write Address 채널에서 쓰기 burst의 beat 수를 지정
- `R` + `LAST` = `RLAST`: Read Data 채널에서 현재 beat가 마지막임을 표시
- `B` + `RESP` = `BRESP`: Write Response 채널에서 쓰기 결과를 표시

문서에 나오는 `AxLEN`, `AxSIZE`, `AxBURST`의 `x`는 실제 신호 이름이 아니다. 읽기와 쓰기에 공통으로 적용되는 설명을 줄여 쓴 것이다.

| 축약 표기 | 실제 읽기 신호 | 실제 쓰기 신호 |
|---|---|---|
| `AxADDR` | `ARADDR` | `AWADDR` |
| `AxLEN` | `ARLEN` | `AWLEN` |
| `AxSIZE` | `ARSIZE` | `AWSIZE` |
| `AxBURST` | `ARBURST` | `AWBURST` |
| `AxLOCK` | `ARLOCK` | `AWLOCK` |
| `AxCACHE` | `ARCACHE` | `AWCACHE` |
| `AxPROT` | `ARPROT` | `AWPROT` |
| `AxQOS` | `ARQOS` | `AWQOS` |
| `AxREGION` | `ARREGION` | `AWREGION` |

이하 표의 방향은 master를 기준으로 표시한다.

- `M → S`: master가 출력하고 slave가 입력한다.
- `S → M`: slave가 출력하고 master가 입력한다.
- 폭이 “설정값”인 신호는 IP parameter에 따라 달라진다.

### 3.4 Global 신호

| 신호 | 일반 폭 | 방향 | 의미 | 초보자 확인 사항 |
|---|---:|---|---|---|
| `ACLK` | 1 | system → M/S | 모든 AXI 채널이 기준으로 삼는 clock | transfer는 `ACLK` 상승 에지에서 판정한다. |
| `ARESETn` | 1 | system → M/S | active-low reset | `0`이면 reset이다. reset 중 모든 `xVALID`은 0이어야 한다. |

`ARESETn`의 `n`은 active-low라는 뜻이다. 즉 이름에 `n`이 붙은 신호는 보통 0일 때 기능이 활성화된다. reset을 비동기로 assert할 수 있는 구현이라도 deassert는 `ACLK`에 동기화해야 한다.

### 3.5 Write Address 채널: `AW*`

AW 채널은 “어디에, 어떤 형태의 burst로 쓸 것인가?”를 전달한다. 아래 payload는 `AWVALID=1`일 때 의미가 있으며, `AWVALID=1 && AWREADY=0`인 동안 변하면 안 된다.

| 신호 | 일반 폭 | 방향 | 의미 | 값 읽는 법 |
|---|---:|---|---|---|
| `AWID` | 설정값 | M → S | 쓰기 transaction 식별자 | 나중에 돌아오는 `BID`와 대응한다. |
| `AWADDR` | 설정값, 흔히 32/64 | M → S | burst의 첫 byte 주소 | 주소 하위 bit는 정렬 및 byte lane 선택과 관계있다. |
| `AWLEN` | AXI3 4, AXI4 8 | M → S | 쓰기 burst 길이 | 실제 beat 수는 `AWLEN+1`이다. |
| `AWSIZE` | 3 | M → S | 한 W beat가 전송하는 byte 수 | `bytes_per_beat = 2^AWSIZE` |
| `AWBURST` | 2 | M → S | 다음 W beat의 주소 진행 방식 | `00` FIXED, `01` INCR, `10` WRAP, `11` reserved |
| `AWLOCK` | AXI3 2, AXI4 1 | M → S | normal/exclusive/locked 속성 | AXI4는 `0` normal, `1` exclusive이며 locked는 제거되었다. |
| `AWCACHE` | 4 | M → S | buffer/cache 처리 속성 | memory와 interconnect가 transaction을 어떻게 처리할지 알려 준다. |
| `AWPROT` | 3 | M → S | 권한·보안·명령/데이터 속성 | bit별 의미는 아래 별도 표를 참고한다. |
| `AWQOS` | 4, AXI4 | M → S | 쓰기 요청의 QoS 힌트 | arbitration 우선순위 등에 사용할 수 있으며 정확한 정책은 구현 의존이다. |
| `AWREGION` | 4, AXI4 | M → S | 논리 region 식별자 | 동일한 물리 interface 안의 여러 논리 영역을 구분할 때 사용한다. |
| `AWUSER` | 설정값, 선택 | M → S | 사용자 정의 sideband 정보 | 표준 의미가 없으며 연결된 IP끼리 별도로 약속한다. |
| `AWVALID` | 1 | M → S | AW payload가 유효함 | master는 `AWREADY`를 기다리지 말고 요청이 준비되면 올린다. |
| `AWREADY` | 1 | S → M | slave가 AW payload를 받을 수 있음 | `AWVALID && AWREADY`인 상승 에지에서 주소가 전달된다. |

#### `AWLEN` 예

| `AWLEN` | 실제 W beat 수 |
|---:|---:|
| `8'd0` | 1 |
| `8'd3` | 4 |
| `8'd15` | 16 |
| `8'd255` | 256, AXI4 INCR burst에서 가능 |

#### `AWSIZE` 예

| `AWSIZE` | 한 beat의 크기 |
|---:|---:|
| `3'b000` | 1 byte, 8 bit |
| `3'b001` | 2 byte, 16 bit |
| `3'b010` | 4 byte, 32 bit |
| `3'b011` | 8 byte, 64 bit |
| `3'b100` | 16 byte, 128 bit |

예를 들어 `AWADDR=32'h0000_0100`, `AWLEN=3`, `AWSIZE=2`, `AWBURST=2'b01`이면 `0x100`부터 4 byte씩 4 beat를 쓰라는 뜻이다. 주소는 `0x100`, `0x104`, `0x108`, `0x10C`가 된다.

### 3.6 Write Data 채널: `W*`

W 채널은 실제 쓰기 데이터와 유효 byte 위치를 전달한다. 주소는 W 채널에 없으므로 slave/interconnect는 앞서 받은 AW 정보와 연결해야 한다.

| 신호 | 일반 폭 | 방향 | 의미 | 값 읽는 법 |
|---|---:|---|---|---|
| `WID` | 설정값, AXI3 전용 | M → S | W data가 어느 AW transaction에 속하는지 표시 | AXI4에는 없으며 AXI4 write data는 AW 발행 순서에 맞춰야 한다. |
| `WDATA` | 설정값, 예: 32/64/128 | M → S | slave에 쓸 실제 데이터 | `WSTRB`가 1인 byte lane만 유효하다. |
| `WSTRB` | `WDATA_WIDTH/8` | M → S | byte lane별 write enable | `WSTRB[n]`은 `WDATA[8n+7:8n]`에 대응한다. |
| `WLAST` | 1 | M → S | 현재 W beat가 burst의 마지막임 | 마지막 beat에서만 1이어야 한다. |
| `WUSER` | 설정값, 선택 | M → S | 사용자 정의 sideband 정보 | 표준 의미는 없고 시스템에서 정의한다. |
| `WVALID` | 1 | M → S | W payload가 유효함 | stall 중 `WDATA/WSTRB/WLAST`를 유지한다. |
| `WREADY` | 1 | S → M | slave가 W payload를 받을 수 있음 | `WVALID && WREADY`인 상승 에지마다 W beat 하나가 전달된다. |

32-bit `WDATA`의 `WSTRB` 대응은 다음과 같다.

| `WSTRB` | 유효한 `WDATA` 부분 | 의미 예 |
|---|---|---|
| `4'b0001` | `[7:0]` | 주소 offset 0의 byte만 쓰기 |
| `4'b0010` | `[15:8]` | 주소 offset 1의 byte만 쓰기 |
| `4'b0100` | `[23:16]` | 주소 offset 2의 byte만 쓰기 |
| `4'b1000` | `[31:24]` | 주소 offset 3의 byte만 쓰기 |
| `4'b1111` | `[31:0]` 전체 | 4 byte 모두 쓰기 |

`WVALID=1`, `WREADY=0`인 동안 `WDATA`가 다음 beat 값으로 바뀌면 protocol 위반이다. beat counter와 `WLAST`도 W handshake가 실제로 일어났을 때만 진행해야 한다.

### 3.7 Write Response 채널: `B*`

B 채널은 write burst 전체의 완료 결과를 slave가 master에게 한 번 돌려주는 채널이다.

| 신호 | 일반 폭 | 방향 | 의미 | 값 읽는 법 |
|---|---:|---|---|---|
| `BID` | 설정값 | S → M | 완료된 쓰기 transaction의 ID | 관련 `AWID`와 같아야 한다. |
| `BRESP` | 2 | S → M | write burst 전체의 결과 | `00` OKAY, `01` EXOKAY, `10` SLVERR, `11` DECERR |
| `BUSER` | 설정값, 선택 | S → M | 사용자 정의 response 정보 | IP 간 별도 약속이 있을 때만 사용한다. |
| `BVALID` | 1 | S → M | `BID/BRESP`가 유효함 | AXI4에서는 AW와 마지막 W handshake가 모두 끝난 뒤 올린다. |
| `BREADY` | 1 | M → S | master가 write response를 받을 수 있음 | `BVALID && BREADY`인 상승 에지에서 response가 전달된다. |

`BRESP`는 W beat마다 오는 것이 아니라 **burst 전체에 한 번** 온다. `BVALID=1 && BREADY=0`이면 slave는 `BID`와 `BRESP`를 유지해야 한다.

### 3.8 Read Address 채널: `AR*`

AR 채널은 “어디에서, 어떤 형태의 burst로 읽을 것인가?”를 전달한다. `ARBURST`는 WDATA의 종류가 아니라 **읽기 주소가 beat마다 어떻게 변하는지** 지정하는 신호다.

| 신호 | 일반 폭 | 방향 | 의미 | 값 읽는 법 |
|---|---:|---|---|---|
| `ARID` | 설정값 | M → S | 읽기 transaction 식별자 | 돌아오는 모든 `RID`와 대응한다. |
| `ARADDR` | 설정값, 흔히 32/64 | M → S | read burst의 첫 byte 주소 | slave는 이후 beat 주소를 `ARSIZE/ARBURST`로 계산한다. |
| `ARLEN` | AXI3 4, AXI4 8 | M → S | read burst 길이 | 실제 R beat 수는 `ARLEN+1`이다. |
| `ARSIZE` | 3 | M → S | 한 R beat의 byte 수 | `bytes_per_beat = 2^ARSIZE` |
| `ARBURST` | 2 | M → S | R beat별 주소 진행 방식 | `00` FIXED, `01` INCR, `10` WRAP, `11` reserved |
| `ARLOCK` | AXI3 2, AXI4 1 | M → S | normal/exclusive/locked 읽기 속성 | AXI4는 `0` normal, `1` exclusive다. |
| `ARCACHE` | 4 | M → S | read의 buffer/cache 처리 속성 | prefetch/cache allocation 가능 여부 등에 영향을 준다. |
| `ARPROT` | 3 | M → S | 권한·보안·명령/데이터 속성 | bit별 의미는 아래 공통 표와 같다. |
| `ARQOS` | 4, AXI4 | M → S | 읽기 요청의 QoS 힌트 | interconnect가 우선순위 결정에 사용할 수 있다. |
| `ARREGION` | 4, AXI4 | M → S | 읽기 대상 논리 region | 정확한 해석은 시스템 구성에 따른다. |
| `ARUSER` | 설정값, 선택 | M → S | 사용자 정의 sideband 정보 | 표준 의미가 없다. |
| `ARVALID` | 1 | M → S | AR payload가 유효함 | `ARREADY`와 무관하게 요청이 준비되면 올린다. |
| `ARREADY` | 1 | S → M | slave가 AR payload를 받을 수 있음 | `ARVALID && ARREADY`인 상승 에지에서 읽기 요청이 전달된다. |

#### `ARBURST`를 실제 값으로 해석하기

| `ARBURST` | 이름 | 읽기 주소 변화 | 대표 사용처 |
|---|---|---|---|
| `2'b00` | FIXED | 모든 R beat가 같은 주소 | FIFO data register를 연속으로 읽기 |
| `2'b01` | INCR | beat마다 `2^ARSIZE` byte 증가 | 일반적인 memory block 읽기 |
| `2'b10` | WRAP | 정해진 block 경계에서 처음 주소로 되감김 | cache line의 critical-word-first 읽기 |
| `2'b11` | Reserved | 정의되지 않음 | 사용하면 안 됨 |

예 1:

```text
ARADDR  = 0x0000_0200
ARLEN   = 3          // 4 beat
ARSIZE  = 2          // beat당 4 byte
ARBURST = 2'b01      // INCR

읽을 beat 주소 = 0x200, 0x204, 0x208, 0x20C
```

예 2:

```text
ARADDR  = FIFO_DATA_REGISTER
ARLEN   = 7          // 8 beat
ARSIZE  = 2          // beat당 4 byte
ARBURST = 2'b00      // FIXED

8 beat 모두 같은 FIFO register 주소에서 읽음
```

### 3.9 Read Data 채널: `R*`

R 채널은 slave가 실제 read data를 master에게 돌려준다. read에는 B 채널 같은 별도 완료 채널이 없으므로 각 R beat에 `RRESP`가 붙는다.

| 신호 | 일반 폭 | 방향 | 의미 | 값 읽는 법 |
|---|---:|---|---|---|
| `RID` | 설정값 | S → M | 현재 R beat가 속한 read transaction ID | 관련 `ARID`와 같아야 한다. |
| `RDATA` | 설정값, 예: 32/64/128 | S → M | slave가 읽어 돌려주는 데이터 | narrow transfer에서는 일부 byte lane만 의미 있을 수 있다. |
| `RRESP` | 2 | S → M | 현재 R beat의 결과 | `00` OKAY, `01` EXOKAY, `10` SLVERR, `11` DECERR |
| `RLAST` | 1 | S → M | 현재 R beat가 burst의 마지막임 | `ARLEN+1`번째 handshake에서 1이어야 한다. |
| `RUSER` | 설정값, 선택 | S → M | 사용자 정의 read sideband 정보 | 표준 의미는 없다. |
| `RVALID` | 1 | S → M | R payload가 유효함 | stall 중 `RID/RDATA/RRESP/RLAST`를 유지한다. |
| `RREADY` | 1 | M → S | master가 R beat를 받을 수 있음 | `RVALID && RREADY`인 상승 에지마다 beat 하나를 받는다. |

read data 채널에는 `RSTRB`가 없다. 어떤 byte를 쓸지 선택하는 strobe는 write 전용 `WSTRB`다. read에서 필요한 byte는 주소, `ARSIZE`, bus의 byte lane 규칙을 이용해 master가 해석한다.

### 3.10 주소 채널 공통 속성의 세부 인코딩

#### `AxBURST[1:0]`

| 값 | 의미 | 다음 주소 |
|---|---|---|
| `00` | FIXED | 현재 주소 유지 |
| `01` | INCR | beat 크기만큼 증가 |
| `10` | WRAP | 증가하다 wrap 경계에서 되감김 |
| `11` | Reserved | 사용 금지 |

#### `AxPROT[2:0]`

각 bit는 독립된 속성이다.

| bit | 0일 때 | 1일 때 |
|---:|---|---|
| `AxPROT[0]` | unprivileged | privileged |
| `AxPROT[1]` | secure | non-secure |
| `AxPROT[2]` | data access | instruction access |

따라서 `ARPROT=3'b000`은 일반적으로 unprivileged, secure, data read를 뜻한다. 단순 교육용 memory BFM은 보통 0으로 고정하지만, 실제 secure system에서는 주소 접근 허용 여부에 영향을 준다.

#### `AxLOCK`

| 버전 | 값 | 의미 |
|---|---|---|
| AXI3, 2 bit | `00` | normal |
| AXI3, 2 bit | `01` | exclusive |
| AXI3, 2 bit | `10` | locked |
| AXI3, 2 bit | `11` | reserved |
| AXI4, 1 bit | `0` | normal |
| AXI4, 1 bit | `1` | exclusive |

#### `AxCACHE[3:0]`

S07에서는 네 bit를 bufferable, cacheable/modifiable, read allocate, write allocate 성격으로 소개한다. 핵심 목적은 “이 접근을 interconnect와 cache가 어느 정도 변형·buffer·allocate해도 되는가?”를 알려 주는 것이다.

| 개념 | 초보자 관점의 의미 |
|---|---|
| Bufferable | write 응답이나 실제 memory 반영을 buffer를 통해 지연할 수 있는가 |
| Cacheable/Modifiable | cache 사용, prefetch, transaction 결합·분할 같은 처리를 허용하는가 |
| Read Allocate | read miss 때 cache line을 할당하는 정책을 허용/권고하는가 |
| Write Allocate | write miss 때 cache line을 할당하는 정책을 허용/권고하는가 |

`AxCACHE`의 정확한 bit 조합은 AXI 버전과 memory type 규칙을 함께 봐야 한다. 실습에서 0으로 고정했다고 해서 모든 실제 설계에서 0을 사용해야 한다는 뜻은 아니다. CPU, DDR controller, cache-coherent interconnect를 연결할 때는 해당 IP 문서의 권장값을 따라야 한다.

### 3.11 응답 코드 공통표

| `RRESP/BRESP` | 이름 | 뜻 | 흔한 원인 |
|---|---|---|---|
| `2'b00` | OKAY | 정상 접근 성공, 또는 exclusive write 실패 의미로 사용 가능 | 정상 memory/register 접근 |
| `2'b01` | EXOKAY | exclusive 접근 성공 | exclusive monitor 조건 만족 |
| `2'b10` | SLVERR | 대상 slave에는 도착했지만 slave가 오류 반환 | read-only register write, 지원하지 않는 크기, FIFO 오류 |
| `2'b11` | DECERR | 주소에 해당하는 slave를 찾지 못함 | unmapped address, address decoder 실패 |

`SLVERR`는 “장치는 찾았지만 장치가 처리하지 못함”, `DECERR`는 “애초에 주소에 맞는 장치를 찾지 못함”으로 구분하면 쉽다.

### 3.12 선택적인 low-power 신호와 BFM 전용 신호

이 신호들은 다섯 AXI transaction 채널의 `VALID/READY` payload는 아니지만 S07 예제 port에 함께 나온다.

| 신호 | 방향 | 의미 |
|---|---|---|
| `CSYSREQ` | system clock controller → peripheral | low-power 진입 또는 정상 동작 복귀를 요청 |
| `CSYSACK` | peripheral → system clock controller | `CSYSREQ` 상태를 받아들였음을 응답 |
| `CACTIVE` | peripheral → system clock controller | peripheral이 현재 clock을 필요로 하는지 표시 |
| `MID` | BFM → testbench/interconnect | 예제 BFM의 master 번호. 표준 AXI 채널 신호가 아니라 예제용 식별 신호 |

정상 동작에서는 보통 `CSYSREQ=1`, `CSYSACK=1`이다. controller가 `CSYSREQ`를 0으로 내려 저전력 진입을 요청하고 peripheral이 준비된 뒤 `CSYSACK`를 0으로 내려 응답한다. `CACTIVE=1`이면 peripheral이 clock이 필요하다고 알리는 것이다.

### 3.13 한눈에 보는 VALID/READY 방향

| 채널 | payload source | `VALID` 방향 | `READY` 방향 | handshake 식 |
|---|---|---|---|---|
| AW | master | `AWVALID`: M → S | `AWREADY`: S → M | `AWVALID && AWREADY` |
| W | master | `WVALID`: M → S | `WREADY`: S → M | `WVALID && WREADY` |
| B | slave | `BVALID`: S → M | `BREADY`: M → S | `BVALID && BREADY` |
| AR | master | `ARVALID`: M → S | `ARREADY`: S → M | `ARVALID && ARREADY` |
| R | slave | `RVALID`: S → M | `RREADY`: M → S | `RVALID && RREADY` |

`VALID`은 항상 payload를 보내는 source가 만들고, `READY`는 payload를 받는 destination이 만든다. 이 원칙을 알면 master 입력인지 출력인지 외우지 않아도 방향을 다시 유도할 수 있다.

### 3.14 `S07_mem_axi` 코드의 `s_axi_*` 이름과 대응

실습 코드 [mem_axi_trainee.v](./S07_mem_axi/rtl/verilog/mem_axi_trainee.v)는 AXI 신호 앞에 `s_axi_`를 붙이고 소문자로 쓴다. `s_axi`는 이 module이 **AXI slave interface**를 가진다는 뜻이다. 접두사를 제외하면 표준 신호 이름과 동일하다.

| 실습 코드 신호 | 표준 표기 | 이 `mem_axi` module에서의 방향 | 의미 |
|---|---|---|---|
| `axi_aclk` | `ACLK` | input | AXI clock |
| `axi_aresetn` | `ARESETn` | input | active-low AXI reset |
| `s_axi_awid` | `AWID` | input | write transaction ID |
| `s_axi_awaddr` | `AWADDR` | input | write burst 시작 주소 |
| `s_axi_awlen` | `AWLEN` | input | W beat 수 - 1 |
| `s_axi_awsize` | `AWSIZE` | input | W beat당 byte 수의 log2 |
| `s_axi_awburst` | `AWBURST` | input | 쓰기 주소 진행 방식 |
| `s_axi_awvalid/ready` | `AWVALID/AWREADY` | input/output | write address handshake |
| `s_axi_wid` | `WID` | input | AXI3 방식 write data ID |
| `s_axi_wdata` | `WDATA` | input | 쓸 데이터 |
| `s_axi_wstrb` | `WSTRB` | input | byte lane write enable |
| `s_axi_wlast` | `WLAST` | input | 마지막 W beat 표시 |
| `s_axi_wvalid/ready` | `WVALID/WREADY` | input/output | write data handshake |
| `s_axi_bid` | `BID` | output | 완료된 write transaction ID |
| `s_axi_bresp` | `BRESP` | output | write 결과 |
| `s_axi_bvalid/ready` | `BVALID/BREADY` | output/input | write response handshake |
| `s_axi_arid` | `ARID` | input | read transaction ID |
| `s_axi_araddr` | `ARADDR` | input | read burst 시작 주소 |
| `s_axi_arlen` | `ARLEN` | input | R beat 수 - 1 |
| `s_axi_arsize` | `ARSIZE` | input | R beat당 byte 수의 log2 |
| `s_axi_arburst` | `ARBURST` | input | 읽기 주소 진행 방식 |
| `s_axi_arvalid/ready` | `ARVALID/ARREADY` | input/output | read address handshake |
| `s_axi_rid` | `RID` | output | 반환하는 read transaction ID |
| `s_axi_rdata` | `RDATA` | output | 읽은 데이터 |
| `s_axi_rresp` | `RRESP` | output | 현재 R beat의 결과 |
| `s_axi_rlast` | `RLAST` | output | 마지막 R beat 표시 |
| `s_axi_rvalid/ready` | `RVALID/RREADY` | output/input | read data handshake |

이 module은 slave이므로 AW/W/AR 요청 신호는 대부분 input이고, B/R 반환 신호는 대부분 output이다. 단, `READY`는 payload를 받는 쪽이 만들고 `VALID`은 payload를 보내는 쪽이 만든다는 원칙 때문에 방향이 채널마다 달라진다.

실습 port는 8-bit `AWLEN/ARLEN`을 사용하면서 `WID`도 포함한다. 즉 교육용 예제가 AXI4 길이 형식과 AXI3 호환 신호를 함께 보이는 형태다. 과제를 풀 때는 제공된 BFM과 port를 그대로 맞추되, 실제 AXI4 IP를 새로 설계할 때는 `WID`가 AXI4 표준 신호가 아니라는 점을 구분해야 한다.

---

## 4. VALID/READY 핸드셰이크: AXI의 가장 중요한 규칙

S07_01 슬라이드 7~8과 S07_02 슬라이드 22~28의 모든 파형은 같은 원리로 읽는다.

```text
transfer = VALID && READY   // ACLK 상승 에지에서 둘 다 1일 때
```

`VALID`만 1이면 “보낼 것은 있지만 아직 받지 않았다.”  
`READY`만 1이면 “받을 준비는 됐지만 아직 보낼 것이 없다.”  
둘 다 1인 상승 에지에서만 transfer가 성립한다.

### 4.1 source가 지켜야 할 규칙

1. 전달할 정보가 준비되면 payload와 `VALID`를 제시한다.
2. `READY`를 기다린 뒤에 `VALID`를 올리면 안 된다.
3. `VALID=1, READY=0`으로 stall된 동안에는 `VALID`와 payload를 그대로 유지한다.
4. `VALID && READY`인 상승 에지가 지난 뒤에야 현재 항목을 내리거나 다음 항목으로 바꾼다.

payload는 채널별로 다음과 같다.

- AW: `AWADDR`, `AWLEN`, `AWSIZE`, `AWBURST`, `AWID`, 속성 신호
- W: `WDATA`, `WSTRB`, `WLAST`
- B: `BRESP`, `BID`
- AR: `ARADDR`, `ARLEN`, `ARSIZE`, `ARBURST`, `ARID`, 속성 신호
- R: `RDATA`, `RRESP`, `RLAST`, `RID`

### 4.2 destination이 지켜야 할 규칙

1. 받을 공간이 있으면 `READY`를 올린다.
2. destination은 필요하면 `VALID`를 본 뒤 `READY`를 올려도 된다.
3. 지연을 줄이려면 받을 수 있는 동안 `READY=1`을 미리 유지하는 편이 좋다.
4. `VALID && READY`인 상승 에지에서 payload를 캡처한다.

### 4.3 세 가지 합법적인 경우

| 경우 | 시간 순서 | 특징 |
|---|---|---|
| READY 먼저 | destination이 미리 준비 | VALID이 올라온 첫 에지에 즉시 전송 가능 |
| VALID 먼저 | source가 먼저 정보 제시 | source는 payload를 고정하고 기다림 |
| 동시에 | 같은 cycle에 둘 다 올라옴 | 상승 에지에서 바로 전송 |

### 4.4 deadlock을 막는 핵심 비대칭 규칙

source는 `READY`를 기다렸다가 `VALID`를 올려서는 안 된다. destination은 `VALID`를 기다렸다가 `READY`를 올려도 된다.

양쪽이 서로 기다리는 잘못된 예는 다음과 같다.

```text
source:      READY가 1이 되면 VALID를 올릴게.
destination: VALID가 1이 되면 READY를 올릴게.
결과:        둘 다 영원히 0 → deadlock
```

### 4.5 초보자가 가장 많이 만드는 RTL 오류

잘못된 동작:

- `VALID`를 무조건 한 cycle만 pulse로 만들기
- stall 중 주소나 데이터를 다음 값으로 변경하기
- beat counter를 `VALID`만 보고 증가시키기
- `READY`가 0인데 FIFO에서 데이터를 pop하기

올바른 상태 갱신 조건은 거의 항상 다음과 같다.

```verilog
wire fire = valid && ready;
```

counter, 주소, FIFO 포인터, `LAST` 진행은 `fire`가 참일 때만 바뀌어야 한다.

### 4.6 reset과 register slice

- 모든 AXI 입력은 `ACLK` 상승 에지에서 샘플된다.
- `ARESETn`은 active-low다.
- reset assertion은 비동기로 허용될 수 있지만 deassertion은 `ACLK`에 동기화해야 한다.
- reset 동안 `ARVALID`, `AWVALID`, `WVALID`, `RVALID`, `BVALID`는 0이어야 한다.
- AXI 인터페이스 입력에서 출력으로 이어지는 조합 경로를 만들지 않는 것이 규칙이다. 긴 timing 경로를 끊을 때 채널별 register slice를 넣기 쉬운 이유도 여기에 있다.

---

## 5. 읽기와 쓰기 transaction을 파형으로 읽는 법

### 5.1 읽기 transaction: `AR` 다음 `R`

예: 주소 `0x1000`부터 4-byte씩 4 beat를 읽는다.

1. master가 `ARADDR=0x1000`, `ARLEN=3`, `ARSIZE=2`, `ARBURST=INCR`, `ARVALID=1`을 제시한다.
2. `ARVALID && ARREADY`인 상승 에지에서 slave가 요청을 받는다.
3. slave가 첫 데이터와 `RVALID=1`을 제시한다.
4. `RVALID && RREADY`인 상승 에지마다 데이터 beat 하나가 전달된다.
5. 네 번째 beat에서 slave가 `RLAST=1`을 함께 제시한다.
6. 각 beat에는 `RRESP`가 붙는다.

```text
AR: [주소 요청 1번]  -------------------------->
R :              <--- beat0, beat1, beat2, beat3+RLAST
```

읽기에는 별도의 최종 응답 채널이 없다. `RRESP`가 각 `RDATA` beat에 붙는다.

### 5.2 쓰기 transaction: `AW`, `W`, 마지막에 `B`

같은 조건으로 4 beat를 쓴다고 하자.

1. master가 AW 채널로 시작 주소와 burst 조건을 보낸다.
2. master가 W 채널로 데이터 네 개를 보낸다.
3. 마지막 W beat에 `WLAST=1`을 붙인다.
4. slave가 주소와 모든 쓰기 데이터를 받은 뒤 B 채널로 결과를 한 번 보낸다.

```text
AW: [주소 요청 1번] -------------------------->
W : [beat0] [beat1] [beat2] [beat3+WLAST] ---->
B :                                          <--- [응답 1번]
```

한 write burst에는 `BRESP`가 한 번만 온다. 반면 read burst의 `RRESP`는 beat마다 온다.

### 5.3 AW와 W의 실제 의존 관계

개념적으로는 “어디에 쓸지 정하고 데이터를 보낸다”고 설명하기 쉽지만, 인터페이스 관찰 시 AW와 W의 순서는 고정되어 있지 않다.

- W data가 AW address보다 먼저 보일 수 있다.
- 같은 cycle에 보일 수 있다.
- AW가 먼저 보일 수 있다.

예를 들어 AW 경로에 register가 두 단계 있고 W 경로에 한 단계만 있으면 W가 먼저 slave 쪽에 도착한다. 따라서 slave 또는 interconnect는 두 채널을 독립적으로 받아 보관하고 나중에 결합해야 한다.

AXI4에서 `BVALID`는 관련 AW handshake와 마지막 W handshake가 모두 끝난 뒤에만 올라갈 수 있다.

### 5.4 backpressure가 보일 때 파형 읽기

`RVALID=1`, `RREADY=0`이 세 cycle 유지되었다면 데이터가 세 번 전달된 것이 아니다. 같은 beat가 기다린 것이다. 다음을 확인한다.

- 그동안 `RDATA`, `RRESP`, `RID`, `RLAST`가 변하지 않았는가?
- 실제 beat count는 `RVALID && RREADY`인 에지만 세었는가?

W 채널도 동일하다. `WVALID=1`, `WREADY=0` 동안 `WDATA`, `WSTRB`, `WLAST`가 고정되어야 한다.

---

## 6. 주소, burst, byte lane을 계산하는 법

S07_02 슬라이드 3~13의 핵심이다. 신호 값을 외우기보다 수식으로 해석하면 쉽다.

### 6.1 `AxLEN`: beat 수에서 1을 뺀 값

`Ax`는 `AW` 또는 `AR`를 뜻한다.

```text
beats = AxLEN + 1
```

| 원하는 beat 수 | `AxLEN` |
|---:|---:|
| 1 | 0 |
| 2 | 1 |
| 4 | 3 |
| 16 | 15 |
| 256 | 255, AXI4의 INCR에서 가능 |

BFM task의 인자 `leng`가 사람이 세는 실제 beat 수라면 RTL 신호에는 `ARLEN <= leng-1`, `AWLEN <= leng-1`을 넣어야 한다. 이 `-1`을 빼먹는 오류가 매우 흔하다.

AXI3는 모든 burst 종류에서 1~16 beat다. AXI4는 INCR burst를 최대 256 beat까지 확장했으며 FIXED/WRAP은 최대 16 beat다.

### 6.2 `AxSIZE`: beat당 byte 수의 log2

```text
bytes_per_beat = 2 ** AxSIZE
AxSIZE = log2(bytes_per_beat)
```

| `AxSIZE` | 한 beat의 byte 수 | bit 수 |
|---:|---:|---:|
| 0 | 1 | 8 |
| 1 | 2 | 16 |
| 2 | 4 | 32 |
| 3 | 8 | 64 |
| 4 | 16 | 128 |

`AxSIZE`는 전체 bus 폭보다 클 수 없다. 32-bit bus는 한 번에 최대 4 byte이므로 최대 `AxSIZE=2`다.

### 6.3 `AxBURST`: 다음 beat 주소를 만드는 방법

| 값 | 이름 | 주소 변화 | 대표 용도 |
|---|---|---|---|
| `2'b00` | FIXED | 모든 beat가 같은 주소 | FIFO data port |
| `2'b01` | INCR | beat마다 `bytes_per_beat`만큼 증가 | 일반 메모리 block 전송 |
| `2'b10` | WRAP | 일정 경계에서 처음으로 되감김 | cache line 채우기 |
| `2'b11` | Reserved | 사용 금지 | - |

### 6.4 계산 예 1: 32-bit bus에서 4-word INCR

조건:

- `AxADDR = 0x100`
- `AxLEN = 3` → 4 beat
- `AxSIZE = 2` → beat당 4 byte
- `AxBURST = INCR`

주소는 다음과 같다.

```text
beat 0: 0x100
beat 1: 0x104
beat 2: 0x108
beat 3: 0x10C, LAST=1
```

총 논리 데이터 양은 `4 beat × 4 byte = 16 byte`다.

### 6.5 FIXED burst가 FIFO에 맞는 이유

메모리는 주소가 증가해야 다음 위치를 가리킨다. 하지만 FIFO의 data register는 같은 주소를 읽을 때마다 내부 read pointer가 이동할 수 있다. 그러므로 같은 주소에서 여러 항목을 읽고 쓸 때 FIXED burst가 적합하다.

주의: FIFO처럼 읽기에 부작용이 있는 장치의 read 데이터를 master가 버리면, 이미 FIFO 항목이 빠져나가 복구할 수 없다. 필요한 beat 수를 정확히 요청해야 한다.

### 6.6 WRAP burst를 직관적으로 이해하기

4-byte beat 4개라면 wrap block 크기는 다음과 같다.

```text
block_size = 4 byte × 4 beat = 16 byte
```

start가 `0x10C`라면 16-byte 경계 `0x100~0x10F` 안에서 다음처럼 움직인다.

```text
0x10C → 0x100 → 0x104 → 0x108
```

cache miss가 line 중간에서 발생했을 때 필요한 word부터 먼저 받아오고 나머지를 채우는 데 유용하다. WRAP의 beat 수는 2, 4, 8, 16 중 하나여야 하고 시작 주소는 beat 크기에 정렬되어야 한다.

### 6.7 4KB 경계를 넘으면 안 된다

burst 전체가 하나의 4KB 영역 안에 있어야 한다.

정렬된 단순 INCR burst라면 다음 검사로 생각할 수 있다.

```text
last_byte = start + beats * bytes_per_beat - 1
(start >> 12) == (last_byte >> 12)
```

예를 들어 `0x0FF0`에서 4-byte beat 8개를 보내면 마지막 byte는 `0x100F`이므로 4KB 경계를 넘는다. 하나의 burst로는 불법이며 두 transaction으로 나누어야 한다. 이 규칙은 한 burst가 서로 다른 slave 주소 영역으로 넘어가는 것을 막는다.

### 6.8 burst는 중간 종료할 수 없다

한 번 길이를 선언한 burst는 약속한 beat 수를 모두 handshake해야 한다.

- 쓰기를 사실상 취소하려면 남은 beat의 `WSTRB`를 모두 0으로 만들 수 있지만 beat 자체는 끝까지 보낸다.
- 읽기 데이터가 더 필요 없더라도 master는 남은 beat를 모두 받아 transaction을 완료해야 한다.

---

## 7. 데이터 bus, `WSTRB`, unaligned, ID와 부가 속성

### 7.1 byte lane과 `WSTRB`

`WSTRB`는 WDATA의 어느 byte가 실제로 유효한지 표시한다. 데이터 폭이 32 bit면 byte lane이 4개이므로 `WSTRB[3:0]`이다.

| `WSTRB` bit | 대응 WDATA |
|---|---|
| `WSTRB[0]` | `WDATA[7:0]` |
| `WSTRB[1]` | `WDATA[15:8]` |
| `WSTRB[2]` | `WDATA[23:16]` |
| `WSTRB[3]` | `WDATA[31:24]` |

예:

- `WSTRB=4'b1111`: 네 byte 모두 갱신
- `WSTRB=4'b0010`: lane 1, 즉 `WDATA[15:8]`만 갱신
- `WSTRB=4'b0000`: 어떤 byte도 갱신하지 않음

slave memory를 만들 때는 `WSTRB[i]`가 1인 byte만 써야 한다.

```verilog
if (WSTRB[0]) mem_byte[addr + 0] <= WDATA[ 7: 0];
if (WSTRB[1]) mem_byte[addr + 1] <= WDATA[15: 8];
if (WSTRB[2]) mem_byte[addr + 2] <= WDATA[23:16];
if (WSTRB[3]) mem_byte[addr + 3] <= WDATA[31:24];
```

### 7.2 narrow transfer

bus는 32 bit지만 `AxSIZE=0`이면 한 beat에 1 byte만 전달한다. 이때 주소 하위 비트가 어느 byte lane을 쓸지 결정한다.

32-bit bus에서 1-byte INCR 예:

| 주소 | 사용 lane | 쓰기 `WSTRB` |
|---:|---:|---:|
| `0x00` | lane 0 | `0001` |
| `0x01` | lane 1 | `0010` |
| `0x02` | lane 2 | `0100` |
| `0x03` | lane 3 | `1000` |
| `0x04` | lane 0 | `0001` |

### 7.3 unaligned transfer

[S07_02_amba_axi_details.pdf](../../GoogleDrive/slides/S07_02_amba_axi_details.pdf)의 슬라이드 9~10은 aligned와 unaligned transfer를 비교한다. 핵심은 **시작 주소가 한 beat의 전송 크기 경계에 맞는가**이다.

#### 7.3.1 aligned와 unaligned의 정의

```text
bytes_per_beat = 2^AxSIZE

AxADDR % bytes_per_beat == 0 → aligned
AxADDR % bytes_per_beat != 0 → unaligned
```

예를 들어 `AxSIZE=2`이면 한 beat가 4 byte다. 이때 시작 주소가 4의 배수면 aligned다.

| 시작 주소 | `AxSIZE` | 전송 크기 | 판정 | 이유 |
|---:|---:|---:|---|---|
| `0x1000` | 2 | 4 byte | aligned | `0x1000`은 4의 배수 |
| `0x1004` | 2 | 4 byte | aligned | `0x1004`는 4의 배수 |
| `0x1001` | 2 | 4 byte | unaligned | 4-byte 경계에서 1 byte 벗어남 |
| `0x1002` | 2 | 4 byte | unaligned | 4-byte 경계에서 2 byte 벗어남 |
| `0x1001` | 1 | 2 byte | unaligned | 홀수 주소이므로 2-byte 경계가 아님 |
| `0x1002` | 1 | 2 byte | aligned | 짝수 주소이므로 2-byte 경계에 맞음 |

전송 크기별 정렬 조건은 다음처럼 기억할 수 있다.

| 한 beat 크기 | aligned 주소 조건 |
|---:|---|
| 1 byte | 모든 주소 가능 |
| 2 byte | 주소가 2의 배수 |
| 4 byte | 주소가 4의 배수 |
| 8 byte | 주소가 8의 배수 |
| 16 byte | 주소가 16의 배수 |

#### 7.3.2 unaligned는 별도의 burst 종류가 아니다

unaligned를 나타내는 전용 신호나 `AxBURST` 값은 없다.

- `AxADDR`: 시작 byte 주소
- `AxSIZE`: 한 beat의 byte 수
- `AxBURST`: beat가 여러 개일 때 다음 주소를 만드는 방식

slave는 `AxADDR`과 `AxSIZE`를 비교해 첫 주소가 unaligned인지 판단한다. 예를 들어 `ARADDR=0x1001`, `ARSIZE=1`이면 2-byte read가 홀수 주소에서 시작하므로 unaligned다. `ARBURST`는 이 사실과 별개로 FIXED, INCR, WRAP 중 주소 진행 방법을 나타낸다.

WRAP burst의 시작 주소는 beat 크기에 정렬되어야 하므로 unaligned 시작을 사용할 수 없다. unaligned 시작은 일반적으로 INCR transfer에서 볼 수 있다.

#### 7.3.3 byte lane으로 이해하기

32-bit data bus는 4개의 byte lane으로 나뉜다.

```text
byte lane       3           2           1           0
WDATA bit     [31:24]     [23:16]     [15:8]      [7:0]
주소 offset      +3          +2          +1          +0
```

bus word가 `0x1000`에서 시작한다면 다음과 같이 대응한다.

| 주소 | byte lane | WDATA bit | WSTRB bit |
|---:|---:|---|---|
| `0x1000` | 0 | `[7:0]` | `WSTRB[0]` |
| `0x1001` | 1 | `[15:8]` | `WSTRB[1]` |
| `0x1002` | 2 | `[23:16]` | `WSTRB[2]` |
| `0x1003` | 3 | `[31:24]` | `WSTRB[3]` |

unaligned transfer에서는 첫 byte가 lane 0이 아닌 중간 lane에서 시작할 수 있다.

#### 7.3.4 32-bit bus에서 2-byte aligned write

주소 `0x1000`부터 2 byte를 쓴다고 하자.

```text
AWADDR = 0x1000
AWSIZE = 1          // 2^1 = 2 byte
WSTRB  = 4'b0011
```

사용하는 byte lane은 0과 1이다.

```text
주소 0x1000 → WDATA[7:0],   WSTRB[0]
주소 0x1001 → WDATA[15:8],  WSTRB[1]
```

시작 주소 `0x1000`이 2의 배수이므로 aligned transfer다.

#### 7.3.5 32-bit bus에서 2-byte unaligned write

이번에는 주소 `0x1001`부터 2 byte를 쓴다고 하자.

```text
AWADDR = 0x1001
AWSIZE = 1          // 2 byte
WSTRB  = 4'b0110
```

사용하는 byte lane은 1과 2다.

```text
주소 0x1001 → WDATA[15:8],  WSTRB[1]
주소 0x1002 → WDATA[23:16], WSTRB[2]
```

2-byte 데이터가 홀수 주소 `0x1001`에서 시작하므로 unaligned지만, 두 byte 모두 현재 32-bit bus word 안에 들어가므로 한 beat에서 표현할 수 있다.

쓰기에서 master는 주소 하위 bit와 `WSTRB`가 일치하도록 만들어야 한다. `AWADDR=0x1001`, `AWSIZE=1`인데 `WSTRB=4'b0011`을 보내면 시작 주소와 유효 byte lane이 서로 맞지 않는다.

#### 7.3.6 data bus 경계를 넘는 unaligned 접근

32-bit bus에서 주소 `0x1002`부터 4 byte를 쓴다고 하자.

```text
쓰려는 byte 주소 = 0x1002, 0x1003, 0x1004, 0x1005
```

하지만 하나의 32-bit bus word가 표현하는 주소 범위는 다음과 같이 나뉜다.

```text
첫 bus word  = 0x1000 ~ 0x1003
다음 bus word = 0x1004 ~ 0x1007
```

따라서 논리적인 4-byte 데이터가 두 bus word에 걸친다.

```text
첫 부분:  0x1002, 0x1003 → 상위 두 lane, WSTRB=4'b1100
다음 부분: 0x1004, 0x1005 → 하위 두 lane, WSTRB=4'b0011
```

이 경우 master 또는 interconnect는 접근을 여러 legal beat나 transaction으로 나누어 처리해야 할 수 있다. slave는 하나의 memory word만 갱신해 놓고 나머지 byte를 버리면 안 된다. 어느 계층이 분할과 결합을 담당하는지는 시스템 설계와 IP 지원 범위에 따라 달라진다.

64-bit bus라면 한 bus word에 byte lane이 8개이므로 동일한 4-byte unaligned 접근이 한 beat 안에 들어가는 경우가 더 많다. 이것이 S07_02 슬라이드 10에서 64-bit bus의 여러 byte lane을 보여 주는 이유다.

#### 7.3.7 unaligned read에는 `RSTRB`가 없다

write는 `WSTRB`로 유효 byte lane을 직접 표시한다. read data 채널에는 `RSTRB`가 없다.

예를 들어 32-bit bus에서 다음 read를 생각하자.

```text
ARADDR = 0x1001
ARSIZE = 1          // 2 byte
```

master와 slave는 주소 하위 bit와 `ARSIZE`를 이용해 유효 lane을 안다.

```text
주소 0x1001의 byte → RDATA[15:8]
주소 0x1002의 byte → RDATA[23:16]
```

master는 해당 lane에서 필요한 byte를 꺼내 조합한다. 접근이 bus word 경계를 넘으면 master 또는 interconnect가 여러 read 결과를 받아 필요한 byte만 선택하고 하나의 논리 값으로 조합할 수 있다.

#### 7.3.8 narrow transfer와 unaligned transfer의 차이

두 개념은 서로 다르다.

- **narrow transfer**: 한 beat 크기가 data bus 폭보다 작음
- **unaligned transfer**: 시작 주소가 beat 크기의 배수에 맞지 않음

32-bit bus의 예:

| 주소 | `AxSIZE` | 전송 크기 | narrow 여부 | unaligned 여부 |
|---:|---:|---:|---|---|
| `0x1000` | 2 | 4 byte | 아니오 | 아니오 |
| `0x1000` | 1 | 2 byte | 예 | 아니오 |
| `0x1001` | 1 | 2 byte | 예 | 예 |
| `0x1002` | 2 | 4 byte | 아니오 | 예 |

즉, narrow이면서 unaligned일 수도 있고, narrow이지만 aligned일 수도 있다.

#### 7.3.9 unaligned 접근이 필요한 이유

software의 데이터가 항상 자연스러운 주소 경계에 배치되는 것은 아니다.

- packed structure
- network packet header
- byte array 중간에서 시작하는 값
- file 또는 압축 데이터
- `memcpy` 대상

예를 들어 byte 배열이 `0x1000`에서 시작하고 32-bit field가 `0x1001`부터 저장되어 있다면 해당 field는 4-byte 경계에 맞지 않는다. CPU 또는 DMA가 이 데이터를 읽으려면 unaligned 접근을 지원하거나 여러 aligned 접근으로 나누어 조합해야 한다.

unaligned 지원은 일반적으로 성능을 높이기 위한 기능이 아니라 **정렬되지 않은 데이터도 정확히 처리하기 위한 호환 기능**이다. aligned 접근보다 더 많은 beat, 주소 계산, byte 선택 또는 변환이 필요해 느려질 수 있다.

#### 7.3.10 slave 설계 시 선택

slave는 설계 사양에 따라 다음 중 하나를 선택한다.

1. **unaligned 지원**
   - 주소 하위 bit에서 시작 byte lane 계산
   - `AxSIZE`로 beat 크기 계산
   - write에서 `WSTRB`가 1인 byte만 갱신
   - bus word 경계를 넘는 경우의 분할 정책 처리
   - INCR burst의 다음 주소 정확히 계산

2. **unaligned 미지원**
   - 지원하지 않는 주소와 size 조합을 검출
   - system contract에 따라 `SLVERR` 등 명확한 error response 반환
   - 데이터를 조용히 잘못된 주소에 쓰지 않음

정렬 검사는 다음처럼 생각할 수 있다.

```verilog
beat_bytes = 1 << axsize;
unaligned  = (axaddr & (beat_bytes - 1)) != 0;
```

data bus의 현재 byte lane은 다음 개념으로 계산한다. bus byte 수가 2의 거듭제곱이라고 가정한다.

```verilog
bus_bytes   = AXI_WIDTH_DATA / 8;
lane_offset = axaddr & (bus_bytes - 1);
```

현재 `S07_mem_axi` 과제처럼 처음 slave memory를 구현할 때는 aligned INCR transfer를 먼저 정상 동작시킨 뒤 narrow와 unaligned를 확장하는 편이 안전하다. BFM에서는 aligned, unaligned, bus 경계 통과, `WSTRB`, backpressure를 각각 별도 test로 나누어 검증해야 한다.

한 문장으로 정리하면 다음과 같다.

> **Unaligned transfer는 시작 주소가 beat 크기의 경계에 맞지 않는 접근이며, AXI는 주소 하위 bit와 byte lane을 이용해 이를 표현한다.**

### 7.4 endian과 byte invariance

endianness는 여러 byte로 된 값을 어느 byte 순서로 해석하는지를 말한다.

- little-endian: 가장 덜 중요한 byte(LSB)가 낮은 주소
- big-endian: 가장 중요한 byte(MSB)가 낮은 주소

AXI의 byte-invariant 관점에서는 특정 byte 주소가 특정 byte lane과 일관되게 연결된다. big-endian 전용 블록을 little-endian 중심 AXI 시스템에 연결할 때는 byte lane swap 같은 변환이 필요할 수 있다.

초보자는 다음 두 질문을 분리해야 한다.

1. 메모리 주소 `0x101`에 저장된 **그 byte**는 무엇인가?
2. `0x100`부터 4 byte를 읽어 **32-bit 값**으로 조합하면 얼마인가?

첫 질문은 주소 보존의 문제이고, 두 번째 질문은 endian 해석의 문제다.

### 7.5 응답 코드

`BRESP[1:0]`은 write transaction 전체에 한 번, `RRESP[1:0]`은 read beat마다 붙는다.

| 값 | 이름 | 의미 |
|---|---|---|
| `00` | OKAY | 정상 접근 성공. exclusive 실패를 나타낼 때도 사용됨 |
| `01` | EXOKAY | exclusive 접근 성공 |
| `10` | SLVERR | 주소는 slave에 도착했지만 slave 내부에서 오류 |
| `11` | DECERR | 주소 decode 결과 대응 slave가 없음 |

구분 예:

- 존재하지 않는 주소 영역 → 보통 interconnect/default slave가 `DECERR`
- read-only register에 write → 대상 slave가 `SLVERR`
- FIFO overflow, 지원하지 않는 크기, powered-down 장치 접근 → `SLVERR` 후보

오류가 발생해도 선언한 burst 길이를 protocol상 끝까지 완료해야 한다.

### 7.6 ID, outstanding, out-of-order

ID는 요청과 돌아오는 데이터/응답을 연결하는 꼬리표다.

- write: `AWID` ↔ `BID`
- read: `ARID` ↔ `RID`
- `WID`는 **AXI3에만** 있고 AXI4에서는 제거되었다.

같은 ID와 같은 목적지에 대한 응답은 요청 순서를 보존한다. 서로 다른 ID의 transaction은 먼저 요청한 것이 항상 먼저 끝날 필요가 없다.

예:

1. ID 1로 느린 DDR read 요청
2. ID 2로 빠른 SRAM read 요청
3. SRAM의 ID 2 응답이 먼저 도착
4. DDR의 ID 1 응답이 나중에 도착

이것이 out-of-order completion이다. 한 ID 안의 data beat 순서는 여전히 지켜야 한다.

여러 master를 연결하는 interconnect는 보통 slave 쪽 ID 앞에 master port 번호를 붙인다.

```text
slave_side_ID = {master_port_ID, master's_transaction_ID}
```

응답의 `RID/BID` 상위 비트를 보면 어느 master로 되돌릴지 알 수 있고, master에게 전달할 때 추가한 비트는 제거한다.

### 7.7 atomic access: locked와 exclusive

두 processor가 같은 counter를 동시에 `read → +1 → write`하면 증가 한 번이 사라질 수 있다. atomic access는 이 경쟁을 막기 위한 기능이다.

- **locked access**: AXI3의 오래된 방식. interconnect가 일련의 접근 동안 다른 접근을 막는다.
- **exclusive access**: AXI3/AXI4 방식. exclusive read 이후 같은 위치에 다른 write가 없었을 때만 exclusive write가 성공한다.

exclusive increment의 개념:

```text
반복:
  old = exclusive_read(addr)
  status = exclusive_write(addr, old + 1)
  status가 실패면 다시 반복
```

exclusive write 성공은 `EXOKAY`, 다른 write가 끼어 실패한 경우에는 메모리를 갱신하지 않고 `OKAY`로 알릴 수 있다. `OKAY`가 무조건 “원하던 갱신 성공”을 뜻하지 않는 이유다.

AXI4는 locked transaction 지원을 제거하고 `AxLOCK`을 1 bit exclusive 표시로 사용한다.

### 7.8 cache, protection, QoS, low-power 신호

초보 단계에서는 기능의 목적을 아는 정도면 충분하다.

- `AxCACHE`: bufferable/cacheable, read allocate, write allocate 같은 memory 속성
- `AxPROT[2:0]`: privileged/unprivileged, secure/non-secure, instruction/data 접근 구분
- `AxQOS`: interconnect arbitration에 사용할 QoS 힌트
- `AxREGION`: 하나의 물리 interface 안의 논리 region 식별
- `CSYSREQ`, `CSYSACK`, `CACTIVE`: 저전력 진입·복귀와 clock 필요 상태를 전달하는 별도 low-power interface

이 속성은 단순 memory BFM에서 0으로 고정할 수 있지만, 실제 SoC interconnect에서는 보안, cache 일관성, 성능 정책에 영향을 줄 수 있다.

### 7.9 AXI4-Lite와 full AXI의 차이

| 항목 | AXI4-Lite | full AXI4 |
|---|---|---|
| burst | 길이 1만 지원 | INCR 최대 256 beat |
| ID | 기본적으로 없음 | 있음 |
| out-of-order | ID 기반 reorder 없음 | 서로 다른 ID 사이에서 가능 |
| 데이터 폭 | 32 또는 64 bit | 구현에 따라 폭넓게 선택 |
| `AxLEN/AxSIZE/AxBURST/xLAST` | 고정값이라 포트에서 생략 | 사용 |
| exclusive | 미지원 | 지원 가능 |

“AXI4-Lite는 항상 bus 전체 폭 접근”이라는 말은 `AxSIZE`가 없고 transaction 크기를 bus 폭으로 정의한다는 뜻이다. 그러나 write에는 `WSTRB`가 존재한다. 따라서 8/16-bit register나 byte별 갱신을 표현할 수 있으며, slave는 strobe를 완전히 지원하거나, 무시하고 full-width로 처리하거나, 지원하지 않는 조합에 error를 돌려주는 정책을 택할 수 있다. memory 성격의 slave는 `WSTRB`를 제대로 지원해야 한다.

### 7.10 AXI4-Lite에 비해 full AXI에 추가된 신호는 왜 필요한가

정확히 표현하면, 이 절은 “AXI4-Lite에서 full AXI로 확장할 때 추가되는 신호”를 설명한다.

두 interface의 가장 큰 차이는 다음과 같다.

- **AXI4-Lite**: 주소 요청 하나당 data beat 하나를 전송하며 주로 제어·상태 register에 사용한다.
- **full AXI**: 주소 요청 하나로 여러 data beat를 전송하고, 여러 transaction을 동시에 진행할 수 있으며 주로 memory와 DMA에 사용한다.

따라서 full AXI에는 다음 질문에 답하기 위한 신호가 더 필요하다.

```text
몇 beat를 전송하는가?              → AxLEN
한 beat는 몇 byte인가?             → AxSIZE
다음 beat 주소는 어떻게 변하는가?  → AxBURST
현재 beat가 마지막인가?            → WLAST/RLAST
이 응답은 어느 요청의 것인가?      → AxID, RID, BID
특별한 atomic 접근인가?             → AxLOCK
cache/buffer에서 처리해도 되는가?   → AxCACHE
어떤 요청을 먼저 처리해야 하는가?   → AxQOS
어느 논리 영역의 요청인가?          → AxREGION
```

#### 7.10.1 `ARLEN/AWLEN`: 몇 beat를 전송할지 알리기 위해 필요하다

full AXI에서는 주소 한 번으로 여러 data beat를 전송할 수 있다. slave가 몇 개를 보내거나 받아야 하는지 알려면 길이 정보가 필요하다.

```text
실제 beat 수 = AxLEN + 1
```

| 값 | 실제 beat 수 |
|---:|---:|
| `AxLEN=0` | 1 |
| `AxLEN=3` | 4 |
| `AxLEN=15` | 16 |

`ARLEN`은 R beat 수, `AWLEN`은 W beat 수를 지정한다. AXI4-Lite는 항상 한 beat이므로 `AxLEN=0`으로 고정된 것과 같고 별도 port가 필요 없다.

#### 7.10.2 `ARSIZE/AWSIZE`: 한 beat의 byte 수를 알리기 위해 필요하다

full AXI는 bus 폭보다 작은 narrow transfer를 지원할 수 있다. 예를 들어 64-bit bus에서도 한 beat에 1, 2, 4 또는 8 byte를 전송할 수 있다.

```text
한 beat의 byte 수 = 2^AxSIZE
```

| `AxSIZE` | 한 beat 크기 |
|---:|---:|
| `0` | 1 byte |
| `1` | 2 byte |
| `2` | 4 byte |
| `3` | 8 byte |

slave는 `AxSIZE`를 이용해 유효 byte lane과 다음 주소 증가량을 계산한다. AXI4-Lite는 모든 transaction 크기를 bus 폭으로 정의하므로 `AxSIZE` port가 없다. 단, AXI4-Lite write도 `WSTRB`를 이용해 실제로 갱신할 byte를 선택할 수 있다.

#### 7.10.3 `ARBURST/AWBURST`: 다음 beat 주소를 계산하기 위해 필요하다

data beat가 여러 개라면 slave는 두 번째 beat부터 어느 주소를 접근할지 알아야 한다.

| `AxBURST` | 주소 동작 | 필요한 경우 |
|---|---|---|
| `00` FIXED | 같은 주소 유지 | FIFO data port 반복 접근 |
| `01` INCR | beat 크기만큼 증가 | 일반 memory 연속 접근 |
| `10` WRAP | block 경계에서 되감김 | cache line 채우기 |

예를 들어 다음 read 요청은 4-byte data 4개를 연속 주소에서 읽으라는 뜻이다.

```text
ARADDR  = 0x0000_1000
ARLEN   = 3          // 4 beat
ARSIZE  = 2          // beat당 4 byte
ARBURST = 2'b01      // INCR

주소 = 0x1000, 0x1004, 0x1008, 0x100C
```

AXI4-Lite는 한 beat만 전송하므로 두 번째 주소가 존재하지 않는다. 따라서 `AxBURST`도 필요 없다.

#### 7.10.4 `WLAST/RLAST`: burst의 마지막 beat를 확인하기 위해 필요하다

`WLAST`는 마지막 write data beat, `RLAST`는 마지막 read data beat에서 1이다.

```text
4-beat read:
beat 0 → RLAST=0
beat 1 → RLAST=0
beat 2 → RLAST=0
beat 3 → RLAST=1
```

길이는 이미 `AxLEN`으로 알 수 있지만, `xLAST`를 함께 보내면 송신자와 수신자가 burst 종료 지점을 직접 확인할 수 있다. 길이 count와 `xLAST`가 맞지 않으면 protocol 오류를 검출할 수도 있다. AXI4-Lite는 유일한 beat가 항상 마지막이므로 `xLAST=1`로 고정된 것과 같고 port에서 생략한다.

#### 7.10.5 `ARID/RID`, `AWID/BID`: 여러 transaction의 응답을 구분하기 위해 필요하다

full AXI master는 이전 요청이 끝나기 전에 다음 요청을 보낼 수 있다. 이렇게 아직 완료되지 않은 여러 요청을 outstanding transaction이라고 한다.

예를 들어 다음 두 read 요청이 동시에 진행될 수 있다.

```text
ARID=1 → 느린 DDR read
ARID=2 → 빠른 SRAM read
```

SRAM data가 먼저 돌아와도 `RID=2`를 보면 어느 요청의 응답인지 알 수 있다.

```text
RID=2 → SRAM 요청의 응답
RID=1 → DDR 요청의 응답
```

write도 `AWID`와 `BID`를 이용해 요청과 response를 연결한다.

| 요청 신호 | 대응 응답 신호 |
|---|---|
| `ARID` | `RID` |
| `AWID` | `BID` |

ID가 있으므로 서로 다른 ID의 transaction은 먼저 요청한 순서와 다르게 완료될 수 있다. AXI4-Lite는 ID가 없으므로 응답을 요청 순서대로 처리해야 한다. AXI4-Lite도 구현에 따라 여러 요청을 받아 둘 수 있지만, ID 기반 out-of-order 완료는 할 수 없다.

#### 7.10.6 `WID`: AXI3에서 write data를 구분하기 위해 필요했다

AXI3는 서로 다른 write transaction의 data beat를 섞어 보내는 write data interleaving을 허용했다. 이때 각 W beat가 어느 AW 요청에 속하는지 `WID`로 표시했다.

AXI4에서는 write data interleaving을 제거했으므로 `WID`도 제거되었다. AXI4 master는 AW 요청을 발행한 순서에 맞춰 W data를 보내야 한다.

S07의 `mem_axi` 실습 port에는 교육용 호환을 위해 `s_axi_wid`가 남아 있다. 과제에서는 제공된 BFM과 port에 맞추되, 실제 AXI4 표준에서는 `WID`가 없다는 점을 구분해야 한다.

#### 7.10.7 `ARLOCK/AWLOCK`: atomic 갱신을 지원하기 위해 필요하다

여러 processor가 같은 memory 값을 동시에 읽고 수정하면 갱신이 사라질 수 있다.

```text
초깃값 = 10

CPU 0: 10을 읽음
CPU 1: 10을 읽음
CPU 0: 11을 씀
CPU 1: 11을 씀

두 번 증가했지만 최종값은 11
```

exclusive access는 exclusive read와 exclusive write 사이에 다른 master가 해당 위치를 변경했는지 검사한다. 다른 write가 끼었다면 exclusive write를 실패시켜 software가 다시 시도하게 한다.

AXI4-Lite는 exclusive access를 지원하지 않으므로 `AxLOCK`이 필요 없다. AXI3의 locked access와 AXI4의 exclusive access 차이는 7.7절을 참고한다.

#### 7.10.8 `ARCACHE/AWCACHE`: memory 접근을 cache나 buffer에서 어떻게 처리할지 알리기 위해 필요하다

일반 DDR memory와 UART 같은 device register는 같은 방식으로 처리하면 안 된다.

- 일반 memory: cache 저장, prefetch, write buffer 사용이 가능할 수 있음
- device register: 읽기·쓰기에 부작용이 있을 수 있으므로 함부로 cache하거나 결합하면 안 됨

`AxCACHE`는 interconnect와 memory system에 해당 transaction을 buffer, cache, merge 또는 prefetch해도 되는지에 관한 속성을 전달한다.

AXI4-Lite 접근은 단순한 control register 접근을 목표로 하며 Non-modifiable, Non-bufferable 속성으로 정의된다. 따라서 `AxCACHE` 값이 고정되어 port에서 생략된다.

#### 7.10.9 `ARQOS/AWQOS`: 중요한 traffic을 우선 처리하기 위해 필요하다

여러 master가 동시에 같은 memory controller를 요청하면 arbitration이 필요하다.

```text
영상 DMA 요청 → 너무 늦으면 화면이 끊길 수 있음
일반 CPU 요청 → 약간 늦어져도 동작 가능
```

`AxQOS`는 interconnect가 어떤 요청을 먼저 처리할지 판단할 때 사용할 수 있는 4-bit 힌트다. 실제 우선순위와 공정성 정책은 interconnect 구현에 따라 달라진다.

#### 7.10.10 `ARREGION/AWREGION`: 하나의 물리 interface에서 논리 영역을 구분하기 위해 필요하다

복잡한 SoC에서는 하나의 물리 slave interface를 여러 논리 region처럼 사용할 수 있다. `AxREGION`은 해당 transaction이 어느 논리 영역에 속하는지를 추가로 표시한다.

단순 memory slave에서는 보통 사용하지 않는다. 여러 memory region, interconnect 최적화 또는 복잡한 endpoint가 있을 때 의미가 있다.

#### 7.10.11 `AxUSER`, `WUSER`, `RUSER`, `BUSER`: 시스템 전용 정보를 추가하기 위해 사용한다

USER 신호의 의미는 AXI 표준이 정하지 않는다. 연결되는 IP들이 합의하여 다음과 같은 정보를 전달할 수 있다.

- debug transaction 표시
- 가속기 작업 번호
- 추가 보안 tag
- parity 또는 오류 검사 정보

사용하지 않으면 폭을 0으로 두거나 port를 생략할 수 있다.

#### 7.10.12 `AWPROT/ARPROT`, `WSTRB`, response와 handshake는 AXI4-Lite에도 있다

다음 신호는 full AXI에서 새로 추가된 것이 아니라 AXI4-Lite에도 필요하다.

| 신호 | AXI4-Lite에도 필요한 이유 |
|---|---|
| `AWADDR/ARADDR` | 접근할 register 주소를 전달해야 함 |
| `WDATA/RDATA` | 실제 write/read data를 전달해야 함 |
| `WSTRB` | write할 byte lane을 선택해야 함 |
| `BRESP/RRESP` | 정상 또는 오류 결과를 전달해야 함 |
| `AWPROT/ARPROT` | 권한, secure/non-secure, instruction/data 속성을 전달해야 함 |
| 모든 `VALID/READY` | 채널별 backpressure와 handshake가 필요함 |

#### 7.10.13 하나의 full AXI read 요청으로 전체 신호를 이해하기

다음 요청을 보자.

```text
ARID    = 5
ARADDR  = 0x0000_8000
ARLEN   = 15
ARSIZE  = 2
ARBURST = 2'b01
```

각 신호의 뜻을 문장으로 합치면 다음과 같다.

> ID 5번 요청으로 주소 `0x8000`부터, 한 번에 4 byte씩, 주소를 4 byte씩 증가시키면서 총 16개 data beat를 읽어라.

slave가 접근할 주소는 다음과 같다.

```text
0x8000, 0x8004, 0x8008, ... , 0x803C
```

slave는 반환하는 각 beat에 `RID=5`를 붙이고 마지막인 16번째 beat에서 `RLAST=1`을 보낸다. `RVALID && RREADY`인 상승 에지마다 실제 beat 하나가 전달된다.

추가 신호의 목적을 다시 세 묶음으로 정리하면 다음과 같다.

1. `AxLEN/AxSIZE/AxBURST/xLAST`: 주소 한 번으로 여러 data beat를 전송하기 위해 필요
2. `AxID/RID/BID`: 여러 transaction을 동시에 진행하고 응답을 구분하기 위해 필요
3. `AxLOCK/AxCACHE/AxQOS/AxREGION`: 복잡한 SoC에서 atomic, cache, 우선순위, routing 정책을 전달하기 위해 필요

---

## 8. S07_03: task 기반 BFM과 simple AXI memory

### 8.1 BFM이란 무엇인가

BFM(Bus Functional Model)은 실제 CPU 대신 bus transaction을 만들어 DUT를 시험하는 simulation용 모델이다.

S07_03의 구성은 다음과 같다.

```text
test scenario
    |
    v
bfm_axi (master 역할)  --->  AXI DUT/switch  --->  mem_axi (slave 역할)
    |                                               |
    +-- 요청 생성, 응답 검사                         +-- 데이터 저장/반환
```

- DUT/DUV: 시험 대상 설계
- BFM: 정상·오류·경계 조건 traffic 생성
- memory model: slave 역할과 기대 데이터 제공
- testbench top: clock, reset, 연결, 종료, waveform dump

BFM은 검증용이므로 일반적으로 합성을 목표로 하지 않는다. task, `fork/join`, delay `#1`, `$display` 같은 구문을 자유롭게 사용할 수 있다.

### 8.2 `bfm_axi` parameter 해설

슬라이드 4~6의 module parameter는 다음 의미다.

| parameter | 의미 |
|---|---|
| `MST_ID` | 이 BFM master의 번호 |
| `WIDTH_CID` | interconnect가 master를 구분하는 channel ID 폭 |
| `WIDTH_ID` | master가 transaction을 구분하는 ID 폭 |
| `WIDTH_AD` | 주소 폭, 보통 32 |
| `WIDTH_DA` | 데이터 폭, 예제는 보통 32 |
| `WIDTH_DS` | strobe 폭, `WIDTH_DA/8` |
| `WIDTH_DSB` | byte lane 선택에 필요한 bit 수 |
| `EN` | 해당 BFM 시나리오 실행 여부 |
| `ADDR_LENGTH` | 실제 시험할 주소 범위의 유효 bit 수 |

`AMBA_AXI4`, `AMBA_AXI_CACHE`, `AMBA_AXI_PROT` 같은 macro는 버전이나 선택 기능에 따라 포트를 조건부로 포함한다.

### 8.3 test scenario의 흐름

슬라이드의 `initial` block은 다음 순서다.

1. reset이 assert되기를 기다린다.
2. reset이 deassert되기를 기다린다.
3. 안정화를 위해 clock 몇 번을 기다린다.
4. `EN`이면 여러 크기와 주소에 대해 `test_raw` 또는 `test_raw_all`을 호출한다.
5. 모든 시험 뒤 `DONE=1`로 완료를 알린다.

예를 들어 다음 호출은 start `0x0`, 총 범위 `0x10` byte, beat 크기 4 byte, burst 길이 1로 해석된다.

```verilog
test_raw(32'h1, 32'h0, 32'h10, 32'h4, 32'h1);
```

실제 `test_raw` 내부 정의는 현재 슬라이드 폴더와 동기화된 `codes` 최상위에서 확인되지 않았다. 따라서 “write 후 read-back 비교” 같은 구체적 내부 순서는 이름과 일반적인 BFM 구조에서 추론할 수 있지만, 실제 파일이 제공되면 task 본문을 기준으로 다시 확인해야 한다.

### 8.4 read task가 `fork/join`을 쓰는 이유

슬라이드 7의 구조:

```verilog
task read_task;
  ...
  fork
    read_address_channel(...);
    read_data_channel(...);
  join
endtask
```

AR과 R은 독립 채널이다. 주소를 보내는 절차와 데이터를 받을 준비를 하는 절차를 동시에 실행해야 실제 AXI 동작을 자연스럽게 모델링할 수 있다. 순차 호출로 만들면 불필요한 지연이 생기며, 잘못 작성하면 상대가 기다리는 조건과 맞물려 deadlock을 만들 수 있다.

`join`은 두 작업이 모두 끝날 때까지 `read_task`가 끝나지 않게 한다.

### 8.5 `read_address_channel` 한 줄씩 읽기

핵심 코드는 다음 의미다.

```verilog
ARID    <= id;          // 되돌아올 RID와 연결할 tag
ARADDR  <= addr;        // 첫 byte 주소
ARLEN   <= leng-1;      // 실제 beat 수 - 1
ARLOCK  <= 'b0;         // normal access
ARSIZE  <= get_size(size); // byte 수를 log2 encoding으로 변환
ARBURST <= type[1:0];   // FIXED/INCR/WRAP
ARVALID <= 1'b1;        // 요청 유효
```

이후 `ARREADY`가 1인 상승 에지까지 기다리며 `ARVALID`와 모든 AR payload를 유지해야 한다. handshake 뒤 `ARVALID`를 내린다.

### 8.6 `read_data_channel`이 검사하는 것

1. `RREADY=1`로 데이터를 받을 준비를 한다.
2. 각 beat마다 `RVALID`을 기다린다.
3. 주소와 size로 이번 beat의 유효 byte lane을 계산한다.
4. `RDATA`에서 유효 byte를 모은다.
5. `RID`가 요청 ID와 같은지 검사한다.
6. 마지막 beat에서 `RLAST=1`인지 검사한다.
7. INCR/WRAP/FIXED 규칙으로 다음 주소를 계산한다.

추가로 확인하면 좋은 항목:

- 모든 beat의 `RRESP`가 OKAY/EXOKAY인지
- 마지막 beat가 아닌데 `RLAST=1`이 일찍 나오지 않는지
- stall 동안 R payload가 안정적인지
- 정확히 `leng`번의 handshake가 있었는지

### 8.7 write task도 세 채널을 동시에 실행한다

```verilog
fork
  write_address_channel(...);
  write_data_channel(...);
  write_resp_channel(id);
join
```

AW, W, B는 서로 독립된 채널이므로 세 task를 병렬로 시작한다.

- address task: AW payload를 제시하고 AW handshake를 기다림
- data task: 각 W beat와 `WSTRB`, `WLAST`를 제시하고 W handshake를 기다림
- response task: `BREADY`를 제시하고 `BVALID`, `BID`, `BRESP` 검사

response task를 일찍 시작해 `BREADY=1`로 두는 것은 합법이다. slave는 주소와 마지막 데이터를 받기 전에는 `BVALID`을 내보내지 않아야 한다.

### 8.8 write data task에서 꼭 볼 부분

```verilog
WVALID <= 1'b1;
for (idx=0; idx<leng; idx=idx+1) begin
  WDATA <= get_data(...);
  WSTRB <= get_strb(naddr, size);
  WLAST <= (idx == leng-1);
  ...
  while (WREADY==1'b0) @(posedge ACLK);
end
```

각 loop가 beat 하나다. `WREADY=0`이면 같은 `WDATA/WSTRB/WLAST`를 유지한다. `WLAST` 비교식에서 `leng-1`을 쓰는 이유도 index가 0부터 시작하기 때문이다.

`get_data`, `get_strb`, `get_next_addr`는 각각 다음 책임을 가진 helper다.

- 시험용 데이터 pattern 생성
- 주소와 beat 크기에 맞는 byte strobe 생성
- burst 종류에 맞는 다음 주소 계산

### 8.9 write response 검사

`BVALID && BREADY` handshake가 일어나면 다음을 확인한다.

- `BID == 요청 id`
- `BRESP == OKAY`가 예상되는가?
- `SLVERR/DECERR`이면 어느 계층에서 왜 발생했는가?

한 burst에 응답은 한 번뿐이므로 W beat 수만큼 B response를 기대하면 안 된다.

---

## 9. `mem_axi`: AXI slave memory의 내부 구조

S07_03 슬라이드 13~14의 memory는 크게 두 경로로 나뉜다.

```text
AW + W + B handler ---> write enable/address/data ---> dual-port memory
AR + R handler     <--- read enable/address/data  <--- dual-port memory
```

### 9.1 write handler가 해야 할 일

1. AW와 W를 각각 handshake한다.
2. AW가 먼저든 W가 먼저든 필요한 정보를 buffer한다.
3. `WSTRB`가 1인 byte만 memory에 쓴다.
4. burst 주소와 beat count를 갱신한다.
5. `WLAST`와 예상 마지막 beat가 맞는지 확인한다.
6. AW와 마지막 W가 모두 완료되면 `BVALID/BRESP/BID`를 만든다.
7. `BREADY`가 올 때까지 B payload를 유지한다.

### 9.2 read handler가 해야 할 일

1. AR handshake에서 주소·길이·크기·burst·ID를 저장한다.
2. memory read latency에 맞춰 데이터를 얻는다.
3. `RDATA/RRESP/RID/RLAST`와 `RVALID`을 제시한다.
4. `RREADY=0`이면 현재 R beat를 그대로 유지한다.
5. R handshake 때만 beat count와 주소를 갱신한다.
6. 마지막 handshake 후 transaction 상태를 비운다.

### 9.3 synchronous memory latency 주의

동기식 memory는 read address를 넣은 같은 순간에 데이터가 바로 나오지 않고 보통 다음 clock에 나온다. AR handshake, memory read 요청, RVALID 생성 사이에 최소 한 단계의 상태가 필요할 수 있다.

잘못된 구현은 memory 데이터가 준비되지 않았는데 `RVALID=1`을 먼저 올리거나, `RREADY=0` stall 중 memory 출력을 다음 주소 데이터로 바꾸어 버린다. R 채널 앞에 holding register 또는 skid buffer를 두면 처리하기 쉽다.

### 9.4 slave-side ID 폭

여러 master를 합치는 interconnect 뒤의 slave는 원래 transaction ID뿐 아니라 master 번호까지 포함한 더 넓은 ID를 볼 수 있다.

```text
AXI_WIDTH_SID = AXI_WIDTH_CID + AXI_WIDTH_ID
```

memory slave는 받은 `AWID`를 해당 `BID`로, 받은 `ARID`를 해당 `RID`로 정확히 돌려줘야 한다.

---

## 10. S07_04: 여러 master와 slave를 연결하는 AXI switch

### 10.1 2-master/2-slave 문제

master 0과 master 1이 memory 0과 memory 1에 접근한다고 하자. switch는 다음을 해결해야 한다.

- 주소를 보고 어느 slave로 보낼지 결정
- 두 master가 같은 slave를 동시에 요청하면 하나를 선택
- 선택되지 않은 master에는 backpressure 제공
- W data를 앞서 선택된 AW의 slave로 전달
- R data와 B response를 원래 master로 되돌림
- 여러 outstanding transaction의 ID와 순서 추적
- 어떤 slave에도 속하지 않는 주소에 error 응답

### 10.2 forward 채널

S07_04 슬라이드 6에서 forward 채널은 master에서 slave 방향으로 가는 다음 세 채널이다.

- AW
- W
- AR

AW와 AR에는 주소가 있으므로 address decoder가 목적 slave를 고를 수 있다. 여러 master가 같은 slave를 원하면 arbiter가 하나를 선택하고 mux가 해당 master의 payload를 전달한다.

W 채널에는 주소가 없다. 특히 AXI4에는 WID도 없다. 따라서 switch는 AW에서 결정한 routing과 write transaction 순서를 기억해 각 W burst를 올바른 slave로 보내야 한다.

### 10.3 backward 채널

slave에서 master 방향으로 돌아오는 채널은 다음 두 개다.

- B
- R

`BID`와 `RID`에 포함된 master 식별 정보를 보고 selector/mux가 대상 master를 선택한다. 여러 slave가 동시에 같은 master로 응답하려 하면 arbitration이 필요하다.

### 10.4 read 경로를 단계별로 추적

1. M0가 AR 주소를 제시한다.
2. decoder가 주소를 S1 영역으로 판정한다.
3. S1용 arbiter가 경쟁 master 중 M0를 선택한다.
4. switch가 master 번호를 ARID에 붙여 S1에 전달한다.
5. S1이 RID와 함께 RDATA를 반환한다.
6. switch가 RID의 master 번호를 보고 M0로 보낸다.
7. M0에 보낼 때 추가 ID bit를 제거해 원래 RID를 복원한다.

### 10.5 write 경로를 단계별로 추적

1. M1의 AW 주소를 decode해 S0를 선택한다.
2. AW handshake 결과를 write-route queue에 기록한다.
3. 이후 M1의 W beat를 queue의 맨 앞 목적지 S0로 보낸다.
4. `WLAST` handshake에서 해당 write data routing 항목을 완료한다.
5. S0의 B response ID를 보고 M1로 되돌린다.

AW와 W를 단순히 같은 cycle 신호끼리 묶으면 안 된다. 둘은 서로 다른 register delay와 stall을 겪을 수 있기 때문이다.

### 10.6 default slave가 필요한 이유

주소 decode 결과 어떤 실제 slave도 선택되지 않았다고 해서 `READY`를 영원히 0으로 두면 master가 멈춘다. default slave가 요청을 받아 `DECERR` 응답을 돌려주면 transaction이 protocol에 맞게 종료되고 software도 잘못된 주소 접근을 감지할 수 있다.

### 10.7 arbitration 정책

가장 단순한 선택은 fixed priority지만, 우선순위가 낮은 master가 계속 굶을 수 있다. round-robin은 grant를 번갈아 주어 공정성을 높인다.

arbiter를 설계할 때 확인할 점:

- grant를 transaction 중간에 바꾸지 않는가?
- AW 또는 AR handshake 전에는 선택 payload가 안정적인가?
- burst의 W data가 끝날 때까지 routing이 유지되는가?
- stall 시 선택 master와 payload를 유지하는가?
- 동시에 여러 slave로 갈 수 있는 요청은 병렬로 진행 가능한가?

### 10.8 ordering과 outstanding 추적

switch가 단순 mux보다 어려운 이유는 요청과 응답 사이에 시간이 길고 여러 요청이 동시에 살아 있기 때문이다.

- 같은 ID의 응답 순서 보장
- 서로 다른 ID의 out-of-order 허용
- AXI4 write data는 AW 발행 순서대로 전달
- 각 slave의 수용 가능한 outstanding 수 제한
- route queue/FIFO가 가득 차면 AW/AR에 backpressure
- reset이나 error에서도 추적 상태가 꼬이지 않도록 처리

초기 실습은 각 master당 outstanding 1개, burst 1개부터 구현한 뒤 확장하는 것이 좋다.

---

## 11. ModelSim/파형 실습을 읽는 순서

S07_03과 S07_04는 `Makefile`, `modelsim.args`, `sim_define.v`, `top.v`를 이용하는 흐름을 보여 준다.

### 11.1 파일 역할

| 파일 | 역할 |
|---|---|
| `Makefile` / `RunMe.bat` | library 생성, compile, simulation 실행 |
| `modelsim.args` | compile할 source와 include directory 목록 |
| `sim_define.v` | `SIM`, `VCD`, `DEBUG`, `RIGOR`, `LOW_POWER` 등 macro 설정 |
| `top.v` | clock/reset, BFM, DUT, memory 연결 |
| `bfm_axi.v` | AXI master traffic 생성 |
| `bfm_axi_tasks.v` | 채널별 task와 helper |
| `mem_axi.v` | AXI memory slave |
| `axi_switch_m2s2.v` | 2-master/2-slave interconnect DUT |
| `wave.vcd` | GTKWave에서 여는 파형 파일 |

원본 슬라이드의 경로에는 `desing/verilog`라는 표기가 있는데 일반적으로 `design/verilog`의 오탈자로 보인다. 실제 폴더가 제공되면 실제 이름을 우선한다.

### 11.2 파형 검토 순서: read

1. `ARESETn`이 정상적으로 해제되었는가?
2. `ARVALID && ARREADY`가 된 에지를 표시한다.
3. 그때 `ARADDR/ARLEN/ARSIZE/ARBURST/ARID`를 기록한다.
4. 기대 beat 수 `ARLEN+1`을 계산한다.
5. 이후 `RVALID && RREADY` 에지만 세어 beat 수와 맞는지 본다.
6. 각 beat의 `RID/RRESP/RDATA`를 본다.
7. 마지막 handshake에만 `RLAST=1`인지 본다.
8. stall 동안 R payload가 고정되는지 본다.

### 11.3 파형 검토 순서: write

1. AW handshake 에지와 AW payload를 기록한다.
2. 기대 beat 수 `AWLEN+1`을 계산한다.
3. W handshake 에지만 세고 `WDATA/WSTRB`를 확인한다.
4. 마지막 W handshake에 `WLAST=1`인지 본다.
5. AW와 W 중 어느 쪽이 먼저 완료되었는지 본다. 순서가 달라도 정상일 수 있다.
6. 주소와 마지막 데이터가 모두 받아들여진 뒤 B response가 나오는지 본다.
7. `BID/BRESP`를 확인한다.
8. stall 동안 AW/W/B payload가 고정되는지 본다.

### 11.4 switch 파형에서 추가로 볼 것

- master 쪽 handshake와 선택된 slave 쪽 handshake가 같은 transaction을 나타내는가?
- 다른 slave로 가는 두 요청이 불필요하게 서로 막히지 않는가?
- arbiter grant가 stall 중 흔들리지 않는가?
- slave 쪽 확장 ID와 master 쪽 원래 ID가 올바르게 변환되는가?
- unmapped 주소가 `DECERR`로 끝나는가?

---

## 12. 구현·검증 체크리스트와 자주 나는 버그

### 12.1 공통 핸드셰이크

- [ ] source는 `READY`와 무관하게 `VALID`을 올릴 수 있다.
- [ ] `VALID=1 && READY=0` 동안 payload가 안정적이다.
- [ ] 상태, counter, 주소는 handshake 때만 진행한다.
- [ ] reset 동안 모든 `xVALID`이 0이다.
- [ ] reset deassertion이 `ACLK`에 동기화되어 있다.
- [ ] interface 입력에서 출력으로 긴 조합 경로가 생기지 않았다.

### 12.2 burst와 데이터

- [ ] beat 수를 `AxLEN+1`로 해석한다.
- [ ] `AxSIZE`가 bus 폭을 넘지 않는다.
- [ ] `AxBURST=2'b11`을 사용하지 않는다.
- [ ] WRAP 길이는 2/4/8/16 중 하나다.
- [ ] burst가 4KB 경계를 넘지 않는다.
- [ ] burst를 중간에 종료하지 않는다.
- [ ] 마지막 handshake에서만 `WLAST/RLAST`가 1이다.
- [ ] `WSTRB`와 주소 하위 bit가 일치한다.

### 12.3 응답과 ID

- [ ] write response는 burst당 한 번이다.
- [ ] read response는 beat마다 존재한다.
- [ ] AW와 마지막 W를 모두 받은 뒤 B response를 만든다.
- [ ] `AWID→BID`, `ARID→RID`가 맞다.
- [ ] 같은 ID에 필요한 ordering을 보존한다.
- [ ] unmapped 주소는 hang 대신 `DECERR`로 끝난다.

### 12.4 대표적인 증상 → 원인

| 증상 | 먼저 의심할 원인 |
|---|---|
| 첫 beat는 맞고 이후 주소가 틀림 | `AxSIZE`, next address, handshake 조건 오류 |
| stall이 생길 때만 데이터가 틀림 | payload를 유지하지 않음, counter를 VALID만 보고 증가 |
| beat 수가 하나 많거나 적음 | `AxLEN=beats-1` 해석 오류 |
| byte write가 다른 byte를 망침 | `WSTRB` 무시 또는 lane 계산 오류 |
| write가 가끔 영원히 멈춤 | AW/W 순서를 고정 가정, VALID이 READY를 기다림 |
| response ID가 섞임 | route queue 또는 ID 확장/축소 오류 |
| 미할당 주소 접근에서 시스템 정지 | default slave/DECERR 경로 없음 |
| 마지막 beat에서만 실패 | `LAST` off-by-one, counter update 시점 오류 |

---

## 13. 원본 슬라이드를 읽을 때 주의할 버전·표기 차이

S07은 AXI3와 AXI4 내용을 함께 설명하므로 다음을 구분해야 한다.

1. **`WID`는 AXI3 전용이다.** AXI4 write data에는 WID가 없고 write data interleaving도 제거되었다.
2. **read data 채널에는 `RSTRB`가 없다.** S07_01의 signal 표에서 `RSTRB`처럼 보이는 항목은 표기 오류로 보아야 한다. 유효 byte 표시용 strobe는 write의 `WSTRB`다.
3. **burst 길이**는 AXI3에서 최대 16이고, AXI4의 INCR만 최대 256이다. AXI4의 FIXED/WRAP은 최대 16이다.
4. **locked access**는 AXI3 기능이다. AXI4는 locked transaction을 제거하고 exclusive access를 지원한다.
5. **AW와 W는 독립이다.** 설명 순서상 주소를 먼저 소개하더라도 실제 인터페이스에서 W가 AW보다 먼저 도착할 수 있다.
6. **AXI4 write response**는 관련 AW handshake와 마지막 W handshake가 모두 끝난 뒤 생성되어야 한다.
7. S07_02 read data 설명의 “final write transfer”는 문맥상 “final read transfer”의 오탈자다.
8. AXI4-Lite는 `AxSIZE` 없이 full bus width transaction으로 정의되지만 `WSTRB`를 지원하므로 byte 단위 write 갱신을 구현할 수 있다.

이 차이들은 원본을 틀렸다고 단순화하기보다, 여러 AXI 세대의 공통 개념을 한 강의에서 다루면서 생긴 혼합 표기로 이해하면 된다. 구현할 때는 목표 interface가 AXI3, AXI4, AXI4-Lite 중 무엇인지 먼저 고정해야 한다.

---

## 14. 자가 점검 문제

### 문제

1. `ARVALID=1`, `ARREADY=0`인 상승 에지에서 read address transfer가 일어나는가?
2. 8-beat burst의 `AxLEN` 값은 얼마인가?
3. `AxSIZE=3`은 beat당 몇 byte인가?
4. 32-bit WDATA에서 `WSTRB=4'b0100`이면 어느 bit가 유효한가?
5. read burst와 write burst의 response 횟수 차이는 무엇인가?
6. AW와 W 중 반드시 AW가 먼저 handshake해야 하는가?
7. `AWADDR=0xFF8`, 4-byte beat, 4-beat INCR burst는 합법인가?
8. AXI4에서 `WID`를 찾을 수 없는 이유는 무엇인가?
9. `RVALID=1`, `RREADY=0` 동안 `RDATA`가 바뀌면 왜 문제인가?
10. 2-master/2-slave switch에서 W 채널을 주소 decode할 수 없는 이유는 무엇인가?

### 정답

1. 아니다. 같은 상승 에지에서 VALID과 READY가 모두 1이어야 한다.
2. 7이다. `beats=AxLEN+1`이다.
3. 8 byte다. `2^3=8`이다.
4. `WDATA[23:16]`이다.
5. write는 burst 전체에 B response 한 번, read는 R beat마다 RRESP가 붙는다.
6. 아니다. 두 채널은 독립이며 W가 먼저 인터페이스에 도착할 수도 있다.
7. 불법이다. byte 범위가 `0xFF8~0x1007`이 되어 4KB 경계를 넘는다.
8. WID는 AXI3 전용이고 AXI4에서는 write data interleaving과 함께 제거되었다.
9. 아직 transfer되지 않은 동일 beat의 payload를 source가 바꾼 것이므로 handshake 규칙 위반이다.
10. W 채널에는 주소가 없으므로 앞서 handshake한 AW의 routing 상태를 기억해야 한다.

---

## 15. 한 장 요약

```text
READ  = AR 1회 + R (ARLEN+1)회
WRITE = AW 1회 + W (AWLEN+1)회 + B 1회

각 채널 transfer = xVALID && xREADY 인 ACLK 상승 에지
stall             = xVALID && !xREADY, 이때 payload 유지

beats             = AxLEN + 1
bytes per beat    = 2^AxSIZE
burst type        = FIXED(00), INCR(01), WRAP(10)
마지막 beat       = WLAST 또는 RLAST
write byte enable = WSTRB, 1 bit당 WDATA 1 byte

응답 = OKAY(00), EXOKAY(01), SLVERR(10), DECERR(11)
ID   = AWID↔BID, ARID↔RID, WID는 AXI3 전용

절대 잊지 말 것:
1. source는 READY를 기다렸다가 VALID을 올리면 안 된다.
2. stall 동안 VALID과 payload를 유지한다.
3. counter와 주소는 handshake 때만 진행한다.
4. AW와 W의 도착 순서를 가정하지 않는다.
5. burst는 4KB 경계를 넘거나 중간 종료할 수 없다.
```

---

## 16. 근거 자료와 추가 읽기

### 로컬 원본

- [S07_01_amba_axi_intro.pdf](../../GoogleDrive/slides/S07_01_amba_axi_intro.pdf)
- [S07_02_amba_axi_details.pdf](../../GoogleDrive/slides/S07_02_amba_axi_details.pdf)
- [S07_03_mem_axi_bfm_task.pdf](../../GoogleDrive/slides/S07_03_mem_axi_bfm_task.pdf)
- [S07_04_amba_axi_design.pdf](../../GoogleDrive/slides/S07_04_amba_axi_design.pdf)

### 공식 보충 자료

- [Arm, Introduction to AMBA AXI4](https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/Learn%20the%20Architecture/102202_0100_01_Introduction_to_AMBA_AXI.pdf)
- [Arm, AMBA AXI and ACE Protocol Specification, IHI 0022H](https://developer.arm.com/-/media/Arm%20Developer%20Community/PDF/IHI0022H_amba_axi_protocol_spec.pdf)

이 문서는 로컬 S07 슬라이드의 교육 흐름을 기준으로 작성하고, AXI3/AXI4 버전 차이와 핸드셰이크·burst·AXI4-Lite의 세부 규칙은 Arm 공식 문서로 교차 확인했다. 실제 구현에서는 사용하는 IP의 AXI 버전, 지원 burst 종류, outstanding 깊이, unaligned 지원 여부를 해당 IP 문서에서 추가로 확인해야 한다.
