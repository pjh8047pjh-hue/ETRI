# S02 AMBA/APB Memory 상세 설명 노트

> 대상 자료
>
> - `S02_01_bus_intro.pdf` — Bus and Protocol
> - `S02_02_bfm_verification.pdf` — BFM-Based Verification Methods
> - `S02_03_amba_apb.pdf` — Introduction to AMBA APB
> - `S02_04_amba_apb_bfm_task.pdf` — AMBA APB BFM
> - `S02_05_amba_apb_mem_zed_project.pdf` — AMBA APB Memory Project

이 문서는 **S02 전체 내용을 AMBA APB Memory 과제 관점**에서 다시 정리한 노트이다. 단순히 슬라이드 문장을 옮긴 것이 아니라, “왜 이 개념이 필요한지”, “Verilog 코드에서 어디에 대응되는지”, “최종적으로 어떤 파일을 만들어야 하는지” 중심으로 설명한다.

---

## 0. S02 전체 흐름 요약

S02는 아래 순서로 이어진다.

```text
S02_01 Bus and Protocol
  ↓
왜 bus/protocol이 필요한지, address/data/control, slave 선택, partial access 이해

S02_02 BFM-Based Verification
  ↓
bus 기반 설계를 어떻게 testbench/BFM으로 검증하는지 이해

S02_03 Introduction to AMBA APB
  ↓
APB protocol의 phase, signal, version(APB2/3/4) 이해

S02_04 AMBA APB BFM
  ↓
APB write/read task, PSTRB, APB memory RTL, testbench 구조 이해

S02_05 AMBA APB Memory Project
  ↓
Vivado/ZedBoard에서 AXI-to-APB bridge와 APB memory를 붙이고 ARM 코드로 테스트
```

최종 과제의 핵심은 다음 한 문장으로 요약할 수 있다.

> **S01에서 배운 simple memory를 APB4 slave interface로 감싸서 `mem_apb4.v`를 만들고, Vivado block design에서 AXI-to-APB bridge 뒤에 붙인 뒤 ARM 코드로 주소 `0x6000_0000` 등에 접근해 read/write를 검증하는 것.**

---

## 1. 최종 구현물 기준 정리

### 1.1 반드시 만들어야 하는 핵심 파일

최종 구현의 중심 파일은 아래 하나이다.

```text
codes/ex_mem_apb_task/rtl/verilog/mem_apb4.v
```

이 파일은 APB4 slave memory이다. 즉, AXI-to-APB bridge가 APB 신호를 만들어 주면, `mem_apb4.v`가 그 신호를 받아 내부 memory에 read/write를 수행한다.

### 1.2 참고해야 하는 슬라이드 매핑

| 목적 | 참고 자료 | 슬라이드 | 봐야 하는 내용 |
|---|---|---:|---|
| 전체 과제 구조 파악 | `S02_05_amba_apb_mem_zed_project.pdf` | 2 | PS/PL, ARM, AXI, AXI-to-APB bridge, APB memory 3개 연결 구조 |
| 디렉토리 구조 파악 | `S02_05_amba_apb_mem_zed_project.pdf` | 4 | `axi4_to_apb`, `ex_mem_apb_task`, `ex_mem_apb_zedboard` 구조 |
| Vivado 실행 흐름 | `S02_05_amba_apb_mem_zed_project.pdf` | 5~7 | block design, `make`, `syn_impl`, Windows `RunVivado.bat` |
| ARM 테스트 코드 | `S02_05_amba_apb_mem_zed_project.pdf` | 8~9 | `0x4000_0000`, `0x6000_0000`에 write/read하는 C 코드 |
| APB 기본 개념 | `S02_03_amba_apb.pdf` | 3~4 | APB 특징, APB2/3/4 차이 |
| APB phase와 signal | `S02_03_amba_apb.pdf` | 5~12 | APB timing, `PREADY`, `PSLVERR`, `PSTRB`, `PPROT` |
| APB BFM 구조 | `S02_04_amba_apb_bfm_task.pdf` | 4~5 | BFM과 APB memory가 어떤 신호로 연결되는지 |
| APB write/read task | `S02_04_amba_apb_bfm_task.pdf` | 6~9 | `apb_write`, `apb_read`, setup/access phase |
| `PSTRB` byte enable | `S02_04_amba_apb_bfm_task.pdf` | 10 | address 하위 2bit와 size로 byte lane 결정 |
| APB memory RTL | `S02_04_amba_apb_bfm_task.pdf` | 17~20 | `mem_apb` 내부 구현: byte memory, FSM, read/write |
| Vivado용 APB4 wrapper | `S02_04_amba_apb_bfm_task.pdf` | 26 | `mem_apb4` module port template, `X_INTERFACE_INFO` |

---

## 2. 디렉토리 구조

`S02_05` slide 4 기준으로 구조를 잡으면 다음과 같다.

```text
codes/
├─ axi4_to_apb/
│  └─ rtl/
│     └─ verilog/
│        └─ axi4_to_apb4_s3.v
│
├─ ex_mem_apb_task/
│  └─ rtl/
│     └─ verilog/
│        └─ mem_apb4.v
│
└─ ex_mem_apb_zedboard/
   ├─ hw/
   │  └─ impl.zed/
   │
   └─ sw.arm/
      └─ hello_world/
         └─ src/
            └─ main.c
```

각 디렉토리의 의미는 아래와 같다.

| 디렉토리/파일 | 의미 |
|---|---|
| `axi4_to_apb/rtl/verilog/axi4_to_apb4_s3.v` | AXI bus transaction을 APB transaction으로 바꿔 주는 bridge RTL. 보통 직접 새로 짜기보다는 제공된 것을 사용한다. |
| `ex_mem_apb_task/rtl/verilog/mem_apb4.v` | 이번 과제에서 직접 구현해야 하는 APB4 memory slave. |
| `ex_mem_apb_zedboard/hw/impl.zed/` | Vivado project/build 관련 파일 위치. block design, synthesis, implementation을 수행한다. |
| `ex_mem_apb_zedboard/sw.arm/hello_world/src/main.c` | ARM에서 memory-mapped address에 접근해 AXI memory와 APB memory를 테스트하는 C 코드 위치. |

---

## 3. S02_01 Bus and Protocol 상세 설명

### 3.1 slide 1~2: 왜 bus/protocol을 배우는가

SoC 안에는 processor, SRAM/DRAM controller, UART, USB, DMA, GPIO, sensor controller 등 다양한 block이 있다. 이 block들을 각각 point-to-point로 연결하면 배선과 제어가 너무 복잡해진다. 그래서 공통 연결 구조인 **bus**가 필요하다.

여기서 중요한 구분은 다음과 같다.

| 용어 | 의미 |
|---|---|
| Bus | 여러 block이 data를 주고받기 위해 공유하는 신호선 묶음 |
| Protocol | bus 위에서 data를 언제, 어떤 신호 조합으로 주고받을지 정한 규칙 |
| Master | bus transaction을 시작하는 쪽. 보통 CPU, DMA 등이 master 역할 |
| Slave | master의 요청을 받아 응답하는 쪽. memory, peripheral 등이 slave 역할 |

AMBA APB Memory 과제에서는 ARM/AXI 쪽이 master 역할을 하고, 우리가 만드는 `mem_apb4`가 slave 역할을 한다.

### 3.2 slide 3~6: data valid, ack, 안정성

단순히 data line만 연결한다고 통신이 되는 것은 아니다. 수신 쪽은 다음을 알아야 한다.

1. 지금 data가 유효한가?
2. 수신자가 data를 받을 준비가 되었는가?
3. 여러 bit가 동시에 도착하지 않을 때, 언제 sampling해야 안전한가?

그래서 bus protocol에는 보통 `valid`, `ready`, `ack` 같은 handshake 신호가 있다. APB에서는 이 역할이 다음과 같이 대응된다.

| 일반 bus 개념 | APB 신호 |
|---|---|
| 요청 대상 선택 | `PSEL` |
| access phase 진입 | `PENABLE` |
| slave가 완료 가능함 | `PREADY` |
| read/write 방향 | `PWRITE` |
| 주소 | `PADDR` |
| write data | `PWDATA` |
| read data | `PRDATA` |

APB는 단순한 bus라서 AXI처럼 복잡한 multi-channel handshake는 없지만, `PSEL`, `PENABLE`, `PREADY` 조합으로 transaction을 제어한다.

### 3.3 slide 7~8: bus 효율 높이기

슬라이드에서는 bus 효율을 높이는 여러 방법을 보여준다.

| 방식 | 의미 | APB와의 관계 |
|---|---|---|
| overlap | 이전 transaction 응답을 기다리면서 다음 transaction 일부를 준비 | APB는 unpipelined라 적극적으로 overlap하지 않음 |
| burst | 한 번의 transaction 묶음으로 여러 beat 전송 | APB 자체는 단순 peripheral bus라 burst 중심 bus가 아님 |
| multiple outstanding | 여러 요청을 동시에 걸어두고 응답을 나중에 받음 | AXI 쪽 개념에 가깝고 APB는 해당 없음 |

이 부분을 배우는 이유는 APB가 왜 단순한지 이해하기 위해서이다. APB는 high-performance bus가 아니라 **low-power peripheral bus**라서 복잡한 성능 기능을 줄이고 구현을 쉽게 만든다.

### 3.4 slide 9: slave 선택, decoder

여러 slave가 하나의 bus에 붙어 있으면 master가 낸 address를 보고 어느 slave가 응답할지 결정해야 한다. 이 역할을 **decoder**가 한다.

APB에서는 address decoding 결과로 `PSEL`이 만들어진다.

예를 들어 `S02_05` 과제의 address map은 다음과 같다.

| Slave | Base address | Size |
|---|---:|---:|
| AXI Memory | `0x4000_0000` | 8 KByte |
| APB Memory 0 | `0x6000_0000` | 1 KByte |
| APB Memory 1 | `0x6000_1000` | 1 KByte |
| APB Memory 2 | `0x6000_2000` | 1 KByte |

ARM이 `0x6000_0000`에 접근하면 AXI-to-APB bridge가 APB memory 0에 해당하는 `PSEL`을 켠다. `0x6000_1000`이면 memory 1, `0x6000_2000`이면 memory 2가 선택된다.

### 3.5 slide 10~15: master 선택, arbitration, starvation/deadlock

여러 master가 하나의 bus를 쓰려고 하면 누가 먼저 사용할지 정해야 한다. 이것이 **arbitration**이다.

| 개념 | 의미 |
|---|---|
| Arbiter | 여러 master 중 bus를 사용할 master를 선택하는 block |
| Fixed priority | 우선순위가 높은 master를 먼저 선택 |
| Round-robin | 순서를 돌려가며 공평하게 선택 |
| Starvation | 낮은 우선순위 master가 계속 선택되지 못하는 상태 |
| Deadlock | 서로 상대가 풀어줘야 진행 가능한 상태로 영원히 멈추는 상황 |
| Live-lock | 계속 움직이는 것처럼 보이지만 실제 진행은 없는 상황 |

이번 APB memory 구현에서는 master가 여러 개인 구조를 직접 만들지는 않는다. 하지만 AXI/SoC 전체 구조에서는 ARM, DMA 같은 여러 master가 존재할 수 있으므로 bus arbitration 개념이 필요하다.

### 3.6 slide 16~17: transfer type과 burst

bus는 단순히 “read/write”만 있는 것이 아니라, 어떤 access인지 알려주는 type이 있을 수 있다. 예를 들어 instruction access인지 data access인지, burst인지 single인지 등을 알려주면 bus system이 더 효율적으로 동작할 수 있다.

Burst transfer는 여러 개의 data beat를 하나의 묶음으로 전송하는 방식이다.

| 용어 | 의미 |
|---|---|
| Burst length | burst 안에 들어 있는 beat 개수 |
| Burst size | 한 beat에서 이동하는 byte 수 |
| Addressing mode | 주소 증가 방식. incremental, wrapping, fixed, stride 등 |

APB는 low-bandwidth peripheral bus라 burst 중심으로 설계된 bus가 아니다. AXI 쪽에서는 burst가 중요하지만, AXI-to-APB bridge 뒤의 APB memory는 보통 단일 read/write transaction을 처리한다.

### 3.7 slide 18~19: endian, data ordering

**Endian**은 multi-byte data가 memory에 어떤 byte 순서로 저장되는지를 의미한다.

예를 들어 32-bit data `0x12345678`을 byte 단위로 보면 다음과 같다.

```text
MSB                                      LSB
0x12             0x34             0x56  0x78
[31:24]          [23:16]          [15:8] [7:0]
```

Little-endian에서는 낮은 주소에 LSB가 저장된다.

```text
address +0 : 0x78
address +1 : 0x56
address +2 : 0x34
address +3 : 0x12
```

Big-endian에서는 낮은 주소에 MSB가 저장된다.

```text
address +0 : 0x12
address +1 : 0x34
address +2 : 0x56
address +3 : 0x78
```

ARM은 일반적으로 little-endian 환경으로 많이 사용된다. 이번 APB memory code도 `PSTRB[0]`이 `PWDATA[7:0]`과 대응되는 구조라서 little-endian 관점으로 이해하면 자연스럽다.

### 3.8 slide 20: justified / non-justified bus

Partial access에서 data가 bus lane의 어느 위치를 타는지가 중요하다.

| 방식 | 설명 |
|---|---|
| Justified bus | size에 따라 data가 항상 오른쪽 또는 왼쪽으로 정렬되어 이동 |
| Non-justified bus | address가 실제 byte lane을 결정. memory bank lane의 연장처럼 동작 |

AMBA 계열은 address 하위 bit와 byte lane의 관계가 중요하다. 이번 과제의 `PSTRB`도 결국 address 하위 2bit가 어떤 byte lane을 쓸지 결정한다.

### 3.9 slide 21: partial/narrow access

32-bit bus에서 항상 4 byte만 접근하는 것은 아니다. byte access, halfword access, word access가 모두 필요하다.

| Access size | 의미 | 예시 |
|---|---|---|
| 1 byte | 8-bit access | `char` 접근 |
| 2 bytes | 16-bit access | `short` 접근 |
| 4 bytes | 32-bit access | `int`, `uint32_t` 접근 |

Read는 보통 32-bit 전체를 읽고 필요한 byte만 사용하면 된다. 하지만 write는 다르다. 1 byte만 바꾸고 싶은데 32-bit 전체를 덮어쓰면 나머지 byte가 깨진다.

그래서 write에는 **byte enable**이 필요하다. APB4에서는 이 역할을 `PSTRB[3:0]`가 한다.

### 3.10 slide 22: alignment

Alignment는 access size와 address 사이의 규칙이다.

| Access | 정렬 조건 |
|---|---|
| 1-byte access | 모든 주소 가능 |
| 2-byte access | 주소가 2의 배수여야 함. 예: `0`, `2`, `4`, `6` |
| 4-byte access | 주소가 4의 배수여야 함. 예: `0`, `4`, `8`, `12` |

예를 들어 32-bit word access를 `0x6000_0001`에서 하면 misaligned access가 된다. APB BFM의 `get_pstrob` 함수도 이런 misaligned case를 error로 처리한다.

### 3.11 slide 23~29: synchronous/asynchronous, CDC

Synchronous는 같은 clock 기준으로 동작하는 것이고, asynchronous는 공통 clock이 없는 것이다. 서로 다른 clock domain 사이에서 signal을 넘기면 **CDC(Clock Domain Crossing)** 문제가 생긴다.

중요 개념은 다음과 같다.

| 개념 | 의미 |
|---|---|
| Setup time | clock edge 전에 data가 안정되어 있어야 하는 시간 |
| Hold time | clock edge 후 data가 유지되어야 하는 시간 |
| Metastability | setup/hold 위반으로 FF 출력이 0/1 사이에서 불안정해지는 현상 |
| Multi-flip-flop synchronization | single-bit CDC 신호를 여러 FF로 동기화하는 기법 |
| Gray code | 여러 bit 중 한 번에 1bit만 바뀌게 하여 multi-bit CDC 위험을 줄이는 코드 |

이번 APB memory 자체는 `PCLK` 하나로 동작하는 synchronous design이다. 따라서 `mem_apb4.v` 내부 로직은 `always @(posedge PCLK or negedge PRESETn)` 형태로 작성한다.

---

## 4. S02_02 BFM-Based Verification 상세 설명

### 4.1 slide 1~4: testbench와 self-checking testbench

Testbench는 DUT/DUV가 specification대로 동작하는지 확인하는 검증 환경이다.

| 용어 | 의미 |
|---|---|
| DUT | Design Under Test. 테스트 대상 설계 |
| DUV | Design Under Verification. 검증 대상 설계 |
| Stimulus generator | 입력 test pattern을 만드는 부분 |
| Golden model | 기대 결과를 만드는 기준 모델 |
| Post-processor | 실제 출력과 기대 출력을 비교하는 부분 |
| Self-checking testbench | 사람이 waveform을 직접 보지 않아도 pass/fail을 출력하는 testbench |

이번 APB memory 검증에서는 BFM이 stimulus generator 역할을 한다. BFM이 `apb_write`, `apb_read` transaction을 만들고, 읽은 값이 기대값과 같은지 비교한다.

### 4.2 slide 5~6: bus-based system에서 test scenario란?

일반 algorithm block은 input vector와 output vector를 비교하면 된다. 하지만 bus-based system은 조금 다르다.

Bus 기반 설계에서 testing scenario는 보통 다음의 조합이다.

```text
write A0 D0
read  A0 expected D0
write A1 D1
read  A1 expected D1
...
```

즉, **read/write transaction의 순서 자체가 test scenario**이다.

이번 APB memory에서는 다음 scenario가 중요하다.

| Scenario | 확인하는 것 |
|---|---|
| Read-after-write | write한 주소를 바로 read했을 때 같은 값이 나오는가 |
| Write-all then read-all | 여러 주소에 먼저 write한 뒤 전체를 다시 read했을 때 값이 유지되는가 |
| Byte/halfword write | `PSTRB`에 따라 일부 byte만 바뀌는가 |
| Wait-state case | `PREADY=0`일 때 master가 기다리는가 |

### 4.3 slide 7~8: BFM이란?

BFM은 **Bus Functional Model**이다. 내부 CPU 동작을 cycle-level로 전부 모델링하지 않고, bus interface에서 보이는 transaction만 만들어 주는 모델이다.

예를 들어 CPU 전체를 Verilog로 구현하지 않아도, BFM이 다음 일을 대신할 수 있다.

```text
apb_write(address, data, size);
apb_read(address, data, size);
```

이러면 testbench 작성자는 복잡한 signal toggle을 직접 다루지 않고, “주소 A에 data D를 써라” 같은 높은 수준의 scenario를 만들 수 있다.

### 4.4 slide 9~15: task-based BFM

Task-based BFM에서는 Verilog `task`를 사용해서 bus transaction을 만든다.

`task`가 중요한 이유는 timing control을 포함할 수 있기 때문이다.

```verilog
@ (posedge PCLK);
PADDR <= addr;
@ (posedge PCLK);
PENABLE <= 1'b1;
```

이런 식으로 clock edge를 기다리면서 signal을 순서대로 바꿀 수 있다. 반면 `function`은 timing control을 가질 수 없으므로 bus transaction 자체를 만들기에는 적합하지 않다.

### 4.5 slide 16~18: file-driven / native-code-driven BFM

Task-based BFM은 scenario가 바뀔 때 Verilog code를 수정해야 한다. 이를 줄이기 위해 file-driven BFM이나 native-code-driven BFM을 사용할 수 있다.

| 방식 | 설명 | 장단점 |
|---|---|---|
| Task-based BFM | Verilog task로 read/write scenario 작성 | 단순하고 수업 과제에 적합. scenario 변경 시 HDL 수정 필요 |
| File-driven BFM | 외부 command file을 읽어서 transaction 수행 | scenario 변경이 쉬움 |
| Native-code-driven BFM | C program, PLI/VPI/DPI 등으로 simulator와 연결 | 동적 검증 가능하지만 복잡함 |

이번 과제에서는 `S02_04`의 APB BFM처럼 task-based BFM을 이해하면 충분하다.

---

## 5. S02_03 Introduction to AMBA APB 상세 설명

### 5.1 slide 1~3: APB의 위치

APB는 **Advanced Peripheral Bus**이다. 이름 그대로 peripheral에 적합한 bus이다.

APB의 특징은 다음과 같다.

| 특징 | 설명 |
|---|---|
| Low bandwidth | 대용량 고속 data 전송보다는 register/peripheral 접근에 적합 |
| Low power | interface가 단순해서 전력 소모가 적음 |
| Reduced complexity | AXI/AHB보다 구현이 쉬움 |
| Unpipelined | address/control이 access 동안 유지됨. pipeline 구조가 아님 |
| Synchronous | 모든 signal transition이 clock edge 기준 |

APB는 보통 AXI/AHB system bus 뒤에 bridge를 통해 붙는다.

```text
ARM / AXI master
   ↓
AXI interconnect
   ↓
AXI-to-APB bridge
   ↓
APB peripheral 또는 APB memory
```

이번 과제의 `mem_apb4.v`는 이 마지막 APB peripheral 위치에 들어간다.

### 5.2 slide 4: APB2, APB3, APB4 차이

| Version | 추가/특징 |
|---|---|
| APB2 | 단순 interface. wait/error/partial write 지원이 약함 |
| APB3 | `PREADY`, `PSLVERR` 추가. wait state와 error response 지원 |
| APB4 | `PSTRB`, `PPROT` 추가. partial write와 protection 정보 지원 |

이번 과제의 `mem_apb4.v`는 이름 그대로 APB4를 기준으로 한다. 따라서 `PSTRB`와 `PPROT`까지 port에 있어야 한다.

### 5.3 slide 5~6: APB2 timing

APB2는 매우 단순하다. 그러나 다음 한계가 있다.

- slave가 늦게 응답하고 싶어도 wait를 넣을 수 없다.
- 일부 byte만 write하는 정보를 표현하기 어렵다.
- slave error를 알릴 방법이 없다.

그래서 APB3와 APB4에서 추가 신호가 생긴다.

### 5.4 slide 7~9: APB3 신호 `PREADY`, `PSLVERR`

APB3에서 추가된 핵심 신호는 다음 두 개다.

| 신호 | 방향 | 의미 |
|---|---|---|
| `PREADY` | slave → master | `1`이면 transfer 완료 가능. `0`이면 wait state 삽입 |
| `PSLVERR` | slave → master | transfer 실패 또는 slave error 표시 |

`PREADY`가 0이면 master는 address/control/data를 유지하면서 기다려야 한다. `PREADY`가 1이 되는 cycle에 transaction이 완료된다.

### 5.5 slide 10~12: APB4 신호 `PSTRB`, `PPROT`

APB4에서 추가된 핵심 신호는 다음과 같다.

| 신호 | 의미 |
|---|---|
| `PSTRB[3:0]` | 32-bit write data 중 어떤 byte lane이 유효한지 표시 |
| `PPROT[2:0]` | 접근 보호 속성. privileged/non-privileged, secure/non-secure, instruction/data 등 |

32-bit data bus에서 `PSTRB` 대응은 다음과 같다.

| Strobe | Data byte lane |
|---|---|
| `PSTRB[0]` | `PWDATA[7:0]` |
| `PSTRB[1]` | `PWDATA[15:8]` |
| `PSTRB[2]` | `PWDATA[23:16]` |
| `PSTRB[3]` | `PWDATA[31:24]` |

이번 memory RTL에서는 `PSTRB`가 1인 byte만 memory에 write해야 한다.

---

## 6. S02_04 AMBA APB BFM 상세 설명

### 6.1 slide 2~3: task/function 복습

APB BFM은 Verilog `task`로 read/write transaction을 만든다. 그래서 slide 초반에서 task와 function의 차이를 다시 설명한다.

| 항목 | task | function |
|---|---|---|
| timing control | 가능. `@`, `#`, `wait` 사용 가능 | 불가능 |
| 반환값 | 직접 return 값 없음. output argument 사용 | 하나의 값을 반환 |
| 용도 | bus transaction, sequence, delay 포함 동작 | 조합 logic 계산, 값 변환 |
| 예시 | `apb_write`, `apb_read` | `get_pstrob`, `clogb2` |

APB write/read는 clock을 기다리며 여러 cycle에 걸쳐 진행되므로 `task`로 작성한다. `PSTRB` 계산이나 address decoding처럼 즉시 값을 계산하는 것은 `function`으로 작성한다.

### 6.2 slide 4~5: APB BFM module 구조

BFM은 APB master처럼 행동한다. BFM이 APB signal을 만들고, memory가 APB slave로 응답한다.

```text
bfm_apb_s3
  ├─ output: PADDR, PWRITE, PENABLE, PWDATA, PSEL, PSTRB, PPROT
  └─ input : PRDATA0/1/2, PREADY, PSLVERR

mem_apb
  ├─ input : PADDR, PWRITE, PENABLE, PWDATA, PSEL, PSTRB, PPROT
  └─ output: PRDATA, PREADY, PSLVERR
```

BFM에는 최대 3개의 APB slave를 선택하기 위한 parameter가 있다.

```verilog
P_NUM = 3
P_ADDR_START0 = 16'h0000
P_ADDR_START1 = 16'h1000
P_ADDR_START2 = 16'h2000
```

즉, address에 따라 `PSEL[0]`, `PSEL[1]`, `PSEL[2]` 중 하나가 켜진다.

### 6.3 slide 6: `apb_write` task

`apb_write(addr, data, size)`는 APB write transaction을 발생시킨다.

동작 순서는 다음과 같다.

1. `posedge PCLK`를 기다린다.
2. setup phase에서 `PADDR`, `PWRITE=1`, `PSEL`, `PWDATA`, `PSTRB`를 세팅한다.
3. 다음 cycle에 `PENABLE=1`로 access phase에 들어간다.
4. `PREADY`가 1이 될 때까지 기다린다.
5. transaction이 끝나면 `PSEL=0`, `PENABLE=0`으로 bus를 idle 상태로 돌린다.
6. `PSLVERR`가 있으면 error를 출력한다.

APB write의 핵심은 다음 조건이다.

```verilog
PSEL == 1 && PENABLE == 1 && PWRITE == 1 && PREADY == 1
```

이 조건이 만족되는 순간 slave는 write를 완료한다.

### 6.4 slide 7: `apb_read` task

`apb_read(addr, data, size)`는 APB read transaction을 발생시킨다.

동작 순서는 write와 비슷하지만 `PWRITE=0`이다.

1. setup phase에서 `PADDR`, `PWRITE=0`, `PSEL`을 세팅한다.
2. access phase에서 `PENABLE=1`을 세팅한다.
3. `PREADY=1`이 될 때까지 기다린다.
4. 완료 시점에 `PRDATA`를 읽어 `data`로 가져온다.
5. `PSEL`, `PENABLE`을 내린다.

중요한 점은 slide 7 코드에 `data = get_prdata(addr);`가 **blocking assignment**로 되어 있다는 것이다. read task가 끝나기 전에 data 값을 바로 확정해야 하므로 blocking assignment가 맞다.

### 6.5 slide 8~9: APB timing의 핵심

APB transaction은 크게 두 phase로 나뉜다.

| Phase | 신호 상태 | 의미 |
|---|---|---|
| Setup phase | `PSEL=1`, `PENABLE=0` | address/control/data를 slave에게 제시 |
| Access phase | `PSEL=1`, `PENABLE=1` | 실제 transfer 수행. `PREADY=1`이면 완료 |

Write timing은 다음과 같이 생각하면 된다.

```text
Cycle 1: PADDR=AW, PWRITE=1, PSEL=1, PWDATA=DW, PENABLE=0
Cycle 2: PENABLE=1
Cycle 2 또는 이후: PREADY=1이면 write 완료
```

Read timing은 다음과 같다.

```text
Cycle 1: PADDR=AR, PWRITE=0, PSEL=1, PENABLE=0
Cycle 2: PENABLE=1
Cycle 2 또는 이후: PREADY=1이면 PRDATA=DR 유효
```

### 6.6 slide 10: `PSTRB` byte enable

`get_pstrob(addr, size)`는 address 하위 2bit와 access size를 보고 `PSTRB`를 만든다.

| `addr[1:0]` | `size=1` | `size=2` | `size=4` |
|---|---|---|---|
| `2'b00` | `4'b0001` | `4'b0011` | `4'b1111` |
| `2'b01` | `4'b0010` | misaligned | misaligned |
| `2'b10` | `4'b0100` | `4'b1100` | misaligned |
| `2'b11` | `4'b1000` | misaligned | misaligned |

예를 들어 `addr[1:0] = 2'b10`, `size=2`이면 `PSTRB=4'b1100`이다. 즉 `PWDATA[23:16]`, `PWDATA[31:24]` 두 byte lane이 유효하다.

### 6.7 slide 11~13: memory test scenario

BFM은 `memory_test(start, finish, size)` task를 통해 memory를 검증한다.

대표적으로 두 가지 검증이 있다.

#### 6.7.1 Read-after-write test

```text
for each address:
  random data write
  same address read
  compare read data with written data
```

write 직후 read했을 때 값이 같아야 한다.

#### 6.7.2 Read-all-after-write-all test

```text
for each address:
  random data write and store expected value in reposit[]

for each address:
  read
  compare with reposit[]
```

여러 주소에 쓴 값이 서로 덮어써지지 않고 유지되는지 확인한다.

### 6.8 slide 14~16: APB testbench top 구조

`top.v`는 BFM과 여러 개의 memory instance를 연결한다.

중요 구조는 다음과 같다.

```text
top
├─ bfm_apb_s3
│  └─ APB master 역할
│
└─ generate loop
   ├─ mem_apb instance 0
   ├─ mem_apb instance 1
   └─ mem_apb instance 2
```

`PSEL[pn]`이 각 memory instance에 하나씩 연결된다.

```verilog
.PSEL(PSEL[pn])
.PRDATA(PRDATA[32*(pn+1)-1:32*pn])
.PREADY(PREADY[pn])
.PSLVERR(PSLVERR[pn])
```

이 구조가 중요한 이유는 최종 project에서도 APB memory가 3개 붙기 때문이다.

### 6.9 slide 17~20: APB Memory RTL

이 부분이 `mem_apb4.v` 구현의 핵심이다.

#### 6.9.1 parameter

```verilog
parameter SIZE_IN_BYTES = 1024;
parameter DELAY = 0;
```

- `SIZE_IN_BYTES=1024`는 memory 크기가 1 KByte라는 뜻이다.
- `DELAY=0`이면 wait state 없이 바로 `PREADY=1`로 응답한다.
- `DELAY>0`이면 일정 cycle 동안 `PREADY=0`으로 기다리게 만들 수 있다.

#### 6.9.2 byte-wise memory

슬라이드 코드는 32-bit word memory를 byte array 4개로 나눠 구현한다.

```verilog
reg [7:0] mem0[0:SIZE_IN_BYTES/4];
reg [7:0] mem1[0:SIZE_IN_BYTES/4];
reg [7:0] mem2[0:SIZE_IN_BYTES/4];
reg [7:0] mem3[0:SIZE_IN_BYTES/4];
```

각 array의 의미는 다음과 같다.

| Memory array | 담당 byte lane | 대응 PSTRB |
|---|---|---|
| `mem0` | `PWDATA[7:0]` / `PRDATA[7:0]` | `PSTRB[0]` |
| `mem1` | `PWDATA[15:8]` / `PRDATA[15:8]` | `PSTRB[1]` |
| `mem2` | `PWDATA[23:16]` / `PRDATA[23:16]` | `PSTRB[2]` |
| `mem3` | `PWDATA[31:24]` / `PRDATA[31:24]` | `PSTRB[3]` |

이렇게 나누면 partial write가 쉽다. `PSTRB[0]`만 1이면 `mem0`만 바꾸면 된다.

#### 6.9.3 address 계산

```verilog
localparam A_WIDTH = clogb2(SIZE_IN_BYTES);
wire [A_WIDTH-1:2] addr = PADDR[A_WIDTH-1:2];
```

`PADDR[1:0]`은 byte 위치를 나타낸다. 32-bit word는 4 byte이므로 word index를 만들 때 하위 2bit는 버린다.

예시:

| byte address | `PADDR[1:0]` | word index 관점 |
|---:|---:|---:|
| `0x0000` | `00` | word 0 |
| `0x0001` | `01` | word 0의 byte 1 |
| `0x0002` | `10` | word 0의 byte 2 |
| `0x0003` | `11` | word 0의 byte 3 |
| `0x0004` | `00` | word 1 |

#### 6.9.4 FSM

APB memory는 간단한 FSM으로 구현된다.

| State | 의미 |
|---|---|
| `ST_IDLE` | 요청 대기. `PSEL=1`이면 transaction 시작 |
| `ST_DELAY` | `DELAY>0`일 때 wait state를 넣는 상태 |
| `ST_DONE` | transaction 완료 후 다시 idle로 돌아가기 위한 상태 |

`DELAY=0`이면 `ST_IDLE → ST_DONE → ST_IDLE`처럼 빠르게 처리된다. `DELAY>0`이면 `ST_IDLE → ST_DELAY → ST_DONE → ST_IDLE` 흐름이 된다.

#### 6.9.5 write logic

write일 때는 `PSTRB`를 보고 필요한 byte만 쓴다.

```verilog
if (PWRITE==1'b1) begin
    if (PSTRB[0]==1'b1) mem0[addr] <= PWDATA[ 7: 0];
    if (PSTRB[1]==1'b1) mem1[addr] <= PWDATA[15: 8];
    if (PSTRB[2]==1'b1) mem2[addr] <= PWDATA[23:16];
    if (PSTRB[3]==1'b1) mem3[addr] <= PWDATA[31:24];
end
```

이 부분이 partial write의 핵심이다.

#### 6.9.6 read logic

read일 때는 네 개 byte memory를 다시 32-bit로 합쳐 `PRDATA`에 넣는다.

```verilog
PRDATA[ 7: 0] <= mem0[addr];
PRDATA[15: 8] <= mem1[addr];
PRDATA[23:16] <= mem2[addr];
PRDATA[31:24] <= mem3[addr];
```

### 6.10 slide 21: state machine 그림

slide 21은 memory FSM을 그림으로 정리한 것이다. 핵심은 `PSEL`이 들어오면 read/write를 수행하고, delay가 있으면 `PREADY=0`으로 기다렸다가 완료할 때 `PREADY=1`로 만드는 것이다.

APB에서 `PREADY=1`은 “이번 access를 완료해도 된다”는 뜻이다. 따라서 slow peripheral을 만들고 싶으면 `PREADY`를 일부 cycle 동안 0으로 유지하면 된다.

### 6.11 slide 22~25: simulation with XSIM

XSIM으로 검증할 때는 다음 파일들이 들어간다.

```text
bench/verilog/top.v
bench/verilog/bfm_apb_s4.v
rtl/verilog/mem_apb.v
```

실행 흐름은 다음과 같다.

```text
cd codes/bfm_apb_task/example/sim/xsim
make
gtkwave wave.vcd &
```

여기서 waveform으로 봐야 하는 신호는 다음과 같다.

```text
PCLK
PRESETn
PSEL
PENABLE
PADDR
PWRITE
PWDATA
PRDATA
PREADY
PSTRB
PSLVERR
```

### 6.12 slide 26: Vivado Block Design 지원용 `mem_apb4`

slide 26은 최종 과제에 매우 중요하다. Vivado block design에서 module을 APB interface로 인식시키려면 `X_INTERFACE_INFO` attribute가 붙은 port 선언이 필요하다.

기존 `mem_apb`와 Vivado용 `mem_apb4`의 차이는 주로 port 이름이다.

| 기존 `mem_apb` | Vivado용 `mem_apb4` |
|---|---|
| `PSEL` | `S_APB_PSEL` |
| `PENABLE` | `S_APB_PENABLE` |
| `PADDR` | `S_APB_PADDR` |
| `PWRITE` | `S_APB_PWRITE` |
| `PWDATA` | `S_APB_PWDATA` |
| `PRDATA` | `S_APB_PRDATA` |
| `PREADY` | `S_APB_PREADY` |
| `PSLVERR` | `S_APB_PSLVERR` |
| `PPROT` | `S_APB_PPROT` |
| `PSTRB` | `S_APB_PSTRB` |

따라서 구현할 때는 slide 26의 port 선언을 쓰고, slide 17~20의 내부 memory logic을 가져와 signal 이름만 `S_APB_` 계열로 바꾸면 된다.

---

## 7. S02_05 AMBA APB Memory Project 상세 설명

### 7.1 slide 1~2: 최종 system 구조

최종 system은 ZedBoard 기준으로 PS와 PL이 나뉜다.

| 영역 | 구성 |
|---|---|
| PS | ARM, DDR3, UART |
| PL | AXI memory, AXI-to-APB bridge, APB memory 3개 |

전체 흐름은 다음과 같다.

```text
PC terminal
  ↕ USB-to-UART
ARM program
  ↕ AXI bus
AXI smart connect
  ├─ AXI BRAM memory at 0x4000_0000
  └─ AXI-to-APB bridge
       ├─ APB memory 0 at 0x6000_0000
       ├─ APB memory 1 at 0x6000_1000
       └─ APB memory 2 at 0x6000_2000
```

### 7.2 slide 4: directory structure

최종 project는 세 부분으로 나뉜다.

1. AXI-to-APB bridge RTL
2. APB memory RTL
3. ZedBoard hardware/software project

실제 작업 기준으로는 `mem_apb4.v`를 먼저 제대로 만드는 것이 가장 중요하다.

### 7.3 slide 5~7: Vivado block design과 synthesis

Linux 기준 흐름은 다음과 같다.

```bash
cd codes/ex_mem_apb_zedboard/hw/impl.zed
make
# Vivado TCL console에서
syn_impl
```

Windows 기준 흐름은 다음과 같다.

```text
codes/ex_mem_apb_zedboard/hw/impl.zed 이동
RunVivado.bat 더블클릭
```

주의할 점은 project 경로가 너무 길면 Vivado에서 error가 날 수 있다는 것이다. slide 7에서는 project directory를 `C:\tmp`처럼 root에 가까운 위치로 복사하라고 설명한다.

### 7.4 slide 8~9: ARM test program

ARM C code는 memory-mapped address에 직접 pointer로 접근한다.

예시는 다음과 같다.

```c
uint32_t dataW, dataR;
uint32_t *addr=(uint32_t*)0x40000000;

dataW = 0x12345678;
*addr = dataW;
dataR = *addr;
printf("A=0x%08X DW=0x%08lX DR=0x%08lX\n\r", (unsigned)addr, dataW, dataR);

addr=(uint32_t*)0x60000000;
dataW = 0x87654321;
*addr = dataW;
dataR = *addr;
printf("A=0x%08X DW=0x%08lX DR=0x%08lX\n\r", (unsigned)addr, dataW, dataR);
```

단, slide에서는 cache effect를 막기 위해 `volatile` keyword를 사용하라고 한다. 따라서 실제로는 다음처럼 쓰는 것이 안전하다.

```c
volatile uint32_t *addr = (volatile uint32_t*)0x60000000;
```

`volatile`이 없으면 compiler가 “방금 쓴 값이니까 다시 memory에서 안 읽어도 된다”고 최적화할 수 있다. 그러면 실제 APB bus transaction이 발생하지 않거나 기대와 다르게 보일 수 있다.

### 7.5 slide 9~13: SW/HW 준비 흐름

1. `sw.arm/hello_world`로 이동한다.
2. `RunCompile.bat`으로 ARM program을 compile한다.
3. ZedBoard power, JTAG-USB, Serial-USB를 연결한다.
4. bitstream을 FPGA에 configuration한다.
5. TeraTerm/PuTTY를 115200 baud, 8-bit, no parity, 1 stop bit로 연다.
6. `RunDownloadElf.bat`으로 ELF를 ARM에 download한다.
7. terminal에서 printf 결과를 확인한다.

### 7.6 slide 14~18: ILA debug

FPGA 내부 signal을 보고 싶을 때는 ILA를 사용한다. debug할 signal은 Vivado에서 `Debug`로 표시하거나 Verilog에 `mark_debug` attribute를 붙인다.

예시는 다음과 같다.

```verilog
`ifdef VIVADO
`define DBG_RING (* mark_debug="true" *)
`else
`define DBG_RING
`endif

`DBG_RING output reg m_axi_awvalid
`DBG_RING input  wire m_axi_awready
```

APB memory debug에서 보면 좋은 signal은 다음과 같다.

```text
S_APB_PSEL
S_APB_PENABLE
S_APB_PADDR
S_APB_PWRITE
S_APB_PWDATA
S_APB_PRDATA
S_APB_PREADY
S_APB_PSLVERR
S_APB_PSTRB
```

---

## 8. `mem_apb4.v` 구현 가이드

### 8.1 구현 방향

`mem_apb4.v`는 다음 구조로 만들면 된다.

```text
module mem_apb4
  ├─ Vivado APB interface port 선언
  ├─ byte-wise memory 선언: mem0, mem1, mem2, mem3
  ├─ address 계산: S_APB_PADDR[A_WIDTH-1:2]
  ├─ FSM state 선언: ST_IDLE, ST_DELAY, ST_DONE
  ├─ always @(posedge PCLK or negedge PRESETn)
  │   ├─ reset 처리
  │   ├─ PSEL 감지
  │   ├─ write이면 PSTRB 기반 byte write
  │   └─ read이면 PRDATA 구성
  └─ clogb2 function
```

### 8.2 signal별 의미

| 신호 | 방향 | 의미 | 구현에서 쓰는 방식 |
|---|---|---|---|
| `PCLK` | input | APB clock | 모든 sequential logic의 기준 clock |
| `PRESETn` | input | active-low reset | 0이면 `S_APB_PREADY`, `S_APB_PSLVERR`, state 초기화 |
| `S_APB_PSEL` | input | 이 slave가 선택됨 | 1이면 transaction 시작 가능 |
| `S_APB_PENABLE` | input | access phase | 엄밀히는 `PSEL=1`이고 `PENABLE=1`일 때 access phase |
| `S_APB_PADDR` | input | address | 내부 word address 계산에 사용 |
| `S_APB_PWRITE` | input | write/read 구분 | 1이면 write, 0이면 read |
| `S_APB_PWDATA` | input | write data | write 시 memory에 저장 |
| `S_APB_PRDATA` | output | read data | read 시 memory에서 꺼내 출력 |
| `S_APB_PREADY` | output | slave ready | 1이면 transaction 완료 가능 |
| `S_APB_PSLVERR` | output | slave error | 기본 구현에서는 0으로 유지 가능 |
| `S_APB_PPROT` | input | protection 정보 | 단순 memory에서는 사용하지 않아도 됨 |
| `S_APB_PSTRB` | input | byte write enable | write 시 어떤 byte를 갱신할지 결정 |

### 8.3 실제 작성 시 주의점

#### 8.3.1 `PENABLE`을 무시해도 되는가?

슬라이드의 `mem_apb` 코드에서는 `ST_IDLE`에서 `PSEL`만 보고 동작하는 형태로 제시된다. 다만 APB protocol을 더 엄밀하게 구현하려면 write/read 동작은 access phase에서 수행하는 것이 안전하다.

즉, 실제 구현에서는 다음 조건을 권장한다.

```verilog
wire apb_access = S_APB_PSEL & S_APB_PENABLE;
wire apb_write  = apb_access & S_APB_PWRITE;
wire apb_read   = apb_access & ~S_APB_PWRITE;
```

하지만 수업 slide code 흐름을 그대로 따라야 한다면 slide 17~20의 구조를 유지하고 signal 이름만 바꾸면 된다.

#### 8.3.2 `PSTRB`는 read 때 의미가 큰가?

`PSTRB`는 write data byte lane의 valid 여부를 나타낸다. read에서는 일반적으로 중요하지 않다. BFM read task에서는 `PSTRB`를 모두 1로 세팅하지만, memory slave는 read 때 `PSTRB`를 무시해도 된다.

#### 8.3.3 `PSLVERR`는 어떻게 처리할까?

단순 memory 과제에서는 정상 address range만 들어온다고 가정하면 `S_APB_PSLVERR <= 1'b0`으로 유지해도 된다. 잘못된 address, misalignment 등을 slave에서 직접 검출하려면 error logic을 추가할 수 있지만, 기본 과제 핵심은 memory read/write와 `PSTRB` 처리이다.

### 8.4 `mem_apb4.v` skeleton

아래 skeleton은 slide 26의 Vivado용 port naming과 slide 17~20의 memory 내부 구조를 결합한 형태이다. 실제 제출 코드에서는 수업에서 제공된 template 형식과 coding convention에 맞춰 정리하면 된다.

```verilog
`timescale 1ns/1ns

module mem_apb4
#(
    parameter SIZE_IN_BYTES = 1024,
    parameter DELAY = 0
)
(
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 PRESETn RST" *)
    input wire PRESETn,

    (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF S_APB,ASSOCIATED_RESET PRESETn" *)
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 PCLK CLK" *)
    input wire PCLK,

    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSEL" *)
    input wire S_APB_PSEL,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PENABLE" *)
    input wire S_APB_PENABLE,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PADDR" *)
    input wire [31:0] S_APB_PADDR,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWRITE" *)
    input wire S_APB_PWRITE,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PWDATA" *)
    input wire [31:0] S_APB_PWDATA,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PRDATA" *)
    output reg [31:0] S_APB_PRDATA,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PREADY" *)
    output reg S_APB_PREADY,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSLVERR" *)
    output reg S_APB_PSLVERR,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PPROT" *)
    input wire [2:0] S_APB_PPROT,
    (* X_INTERFACE_INFO = "xilinx.com:interface:apb:1.0 S_APB PSTRB" *)
    input wire [3:0] S_APB_PSTRB
);

    reg [7:0] mem0 [0:SIZE_IN_BYTES/4-1];
    reg [7:0] mem1 [0:SIZE_IN_BYTES/4-1];
    reg [7:0] mem2 [0:SIZE_IN_BYTES/4-1];
    reg [7:0] mem3 [0:SIZE_IN_BYTES/4-1];

    localparam A_WIDTH = clogb2(SIZE_IN_BYTES);
    wire [A_WIDTH-1:2] addr = S_APB_PADDR[A_WIDTH-1:2];

    localparam ST_IDLE  = 2'h0;
    localparam ST_DELAY = 2'h1;
    localparam ST_DONE  = 2'h2;

    reg [1:0] state = ST_IDLE;
    reg [31:0] dcnt = 32'h1;

    always @(posedge PCLK or negedge PRESETn) begin
        if (PRESETn == 1'b0) begin
            S_APB_PRDATA  <= ~32'h0;
            S_APB_PREADY  <= 1'b1;
            S_APB_PSLVERR <= 1'b0;
            dcnt          <= 32'h1;
            state         <= ST_IDLE;
        end else begin
            case (state)
            ST_IDLE: begin
                if (S_APB_PSEL == 1'b1) begin
                    if (DELAY == 0) begin
                        S_APB_PREADY <= 1'b1;
                        state <= ST_DONE;

                        if (S_APB_PWRITE == 1'b1) begin
                            if (S_APB_PSTRB[0]) mem0[addr] <= S_APB_PWDATA[ 7: 0];
                            if (S_APB_PSTRB[1]) mem1[addr] <= S_APB_PWDATA[15: 8];
                            if (S_APB_PSTRB[2]) mem2[addr] <= S_APB_PWDATA[23:16];
                            if (S_APB_PSTRB[3]) mem3[addr] <= S_APB_PWDATA[31:24];
                        end else begin
                            S_APB_PRDATA[ 7: 0] <= mem0[addr];
                            S_APB_PRDATA[15: 8] <= mem1[addr];
                            S_APB_PRDATA[23:16] <= mem2[addr];
                            S_APB_PRDATA[31:24] <= mem3[addr];
                        end
                    end else begin
                        S_APB_PREADY <= 1'b0;
                        dcnt <= 32'h1;
                        state <= ST_DELAY;
                    end
                end
            end

            ST_DELAY: begin
                dcnt <= dcnt + 1;
                if (dcnt >= DELAY) begin
                    S_APB_PREADY <= 1'b1;
                    state <= ST_DONE;

                    if (S_APB_PWRITE == 1'b1) begin
                        if (S_APB_PSTRB[0]) mem0[addr] <= S_APB_PWDATA[ 7: 0];
                        if (S_APB_PSTRB[1]) mem1[addr] <= S_APB_PWDATA[15: 8];
                        if (S_APB_PSTRB[2]) mem2[addr] <= S_APB_PWDATA[23:16];
                        if (S_APB_PSTRB[3]) mem3[addr] <= S_APB_PWDATA[31:24];
                    end else begin
                        S_APB_PRDATA[ 7: 0] <= mem0[addr];
                        S_APB_PRDATA[15: 8] <= mem1[addr];
                        S_APB_PRDATA[23:16] <= mem2[addr];
                        S_APB_PRDATA[31:24] <= mem3[addr];
                    end
                end
            end

            ST_DONE: begin
                S_APB_PREADY <= 1'b1;
                state <= ST_IDLE;
            end
            endcase
        end
    end

    function integer clogb2;
        input [31:0] value;
        reg [31:0] tmp;
        reg [31:0] rt;
        begin
            tmp = value - 1;
            for (rt = 0; tmp > 0; rt = rt + 1)
                tmp = tmp >> 1;
            clogb2 = rt;
        end
    endfunction

endmodule
```

---

## 9. APB Memory 과제 체크리스트

### 9.1 RTL 체크리스트

| 항목 | 확인 |
|---|---|
| `mem_apb4.v` 파일 위치가 맞는가 | `codes/ex_mem_apb_task/rtl/verilog/mem_apb4.v` |
| module 이름이 `mem_apb4`인가 | Vivado block design에서 이 이름으로 사용 |
| APB port 이름이 `S_APB_*` 형태인가 | slide 26 기준 |
| `X_INTERFACE_INFO` attribute가 붙어 있는가 | Vivado interface 자동 인식을 위해 필요 |
| `PSTRB[0]~[3]` 각각 byte write를 처리하는가 | partial write 핵심 |
| `PADDR[A_WIDTH-1:2]`로 word address를 쓰는가 | 하위 2bit는 byte 위치 |
| reset에서 `PREADY=1`, `PSLVERR=0`으로 초기화하는가 | 기본 응답 상태 |
| `DELAY`가 0일 때 정상 read/write 되는가 | 기본 case |
| `DELAY`가 0보다 클 때 `PREADY` wait가 동작하는가 | wait-state case |

### 9.2 Simulation 체크리스트

| 확인할 waveform | 정상 동작 |
|---|---|
| `PSEL` | transaction 동안 선택된 slave만 1 |
| `PENABLE` | setup phase 다음 access phase에서 1 |
| `PADDR` | setup/access 동안 안정적으로 유지 |
| `PWRITE` | write=1, read=0 |
| `PWDATA` | write data가 access 동안 유지 |
| `PRDATA` | read 완료 시점에 기대값 출력 |
| `PREADY` | delay 없으면 1, delay 있으면 wait 후 1 |
| `PSTRB` | access size/address에 맞게 byte enable 생성 |
| `PSLVERR` | 기본 정상 access에서는 0 |

### 9.3 ARM software 체크리스트

| 항목 | 확인 |
|---|---|
| pointer에 `volatile` 사용 | cache/compiler optimization 방지 |
| `0x4000_0000` 테스트 | AXI memory access 확인 |
| `0x6000_0000` 테스트 | APB memory 0 access 확인 |
| `0x6000_1000` 테스트 | APB memory 1 access 확인 가능 |
| `0x6000_2000` 테스트 | APB memory 2 access 확인 가능 |
| UART terminal 설정 | 115200 baud, 8-bit, no parity, 1 stop bit |

---

## 10. 많이 헷갈리는 포인트 정리

### 10.1 `PENABLE`은 왜 필요한가?

APB는 transaction을 두 phase로 나눈다.

```text
Setup phase : PSEL=1, PENABLE=0
Access phase: PSEL=1, PENABLE=1
```

setup phase는 slave에게 address/control/data를 보여주는 준비 단계이다. access phase는 실제 transfer를 완료하는 단계이다. `PENABLE=1`은 “이제 access phase다”라는 표시이다.

### 10.2 `PREADY`는 누가 만드는가?

`PREADY`는 slave가 만든다. 이번 과제에서는 `mem_apb4.v`가 만든다.

- `PREADY=1`: 지금 transfer 완료 가능
- `PREADY=0`: 아직 준비 안 됨. master는 기다려야 함

`DELAY=0`인 memory는 거의 항상 `PREADY=1`로 응답해도 된다.

### 10.3 `PSTRB`와 `PADDR[1:0]`은 무슨 관계인가?

`PADDR[1:0]`은 32-bit word 안에서 byte 위치를 나타낸다. `PSTRB`는 실제로 어떤 byte lane을 write할지 나타낸다.

예를 들어 address가 `0x0002`이고 2-byte write라면, byte lane 2와 3을 써야 하므로 `PSTRB=4'b1100`이 된다.

### 10.4 왜 memory를 `mem0~mem3`으로 나누는가?

32-bit memory를 `reg [31:0] mem[]` 하나로 만들면 일부 byte만 write할 때 bit slicing을 잘 처리해야 한다. `mem0~mem3`으로 나누면 `PSTRB`에 따라 해당 byte array만 write하면 되므로 partial write가 훨씬 명확하다.

### 10.5 `addr[9:2]`처럼 하위 2bit를 버리는 이유는?

memory가 32-bit word 단위로 구성되어 있기 때문이다. 32-bit word 하나는 4 byte이고, 4 byte 내부 위치는 address 하위 2bit가 나타낸다.

```text
PADDR[1:0]  → word 내부 byte 위치
PADDR[9:2]  → word index
```

1 KByte memory라면 1024 byte / 4 byte = 256 word이다. 따라서 word index는 0~255 범위가 된다.

---

## 11. 최종 작업 순서

### Step 1. 자료 확인

우선 아래 세 slide만 먼저 본다.

```text
S02_05 slide 4  : directory structure
S02_04 slide 26 : mem_apb4 Vivado template
S02_04 slide 17~20 : APB memory internal RTL
```

### Step 2. `mem_apb4.v` 생성

```text
codes/ex_mem_apb_task/rtl/verilog/mem_apb4.v
```

이 위치에 file을 만들고, slide 26의 module port template을 기준으로 시작한다.

### Step 3. 내부 memory logic 이식

`S02_04` slide 17~20의 `mem_apb` 내부 logic을 `mem_apb4`로 가져온다. 이때 signal 이름을 다음처럼 바꾼다.

```text
PSEL    → S_APB_PSEL
PENABLE → S_APB_PENABLE
PADDR   → S_APB_PADDR
PWRITE  → S_APB_PWRITE
PWDATA  → S_APB_PWDATA
PRDATA  → S_APB_PRDATA
PREADY  → S_APB_PREADY
PSLVERR → S_APB_PSLVERR
PPROT   → S_APB_PPROT
PSTRB   → S_APB_PSTRB
```

### Step 4. Simulation으로 검증

가능하면 먼저 APB BFM testbench로 검증한다.

검증해야 할 최소 scenario는 다음과 같다.

```text
write 0x0000 0x12345678
read  0x0000 → 0x12345678

write 0x0004 0x87654321
read  0x0004 → 0x87654321

byte write / halfword write가 가능하면 PSTRB 동작도 확인
```

### Step 5. Vivado block design 연결

`mem_apb4.v`가 Vivado에서 APB slave interface로 잡히는지 확인한다. 이후 AXI-to-APB bridge 뒤에 memory 3개를 붙이고 address map을 설정한다.

### Step 6. ARM software로 테스트

`main.c`에서 아래 주소를 테스트한다.

```c
volatile uint32_t *addr;

addr = (volatile uint32_t*)0x60000000;
*addr = 0x87654321;
printf("read = 0x%08X\n", *addr);
```

정상이라면 write한 값과 read한 값이 같게 나온다.

---

## 12. 한 장 요약

```text
[개념]
Bus = 여러 block이 data를 주고받는 공통 연결선
Protocol = 그 bus를 쓰는 규칙
APB = low-power, low-bandwidth, simple peripheral bus

[APB transaction]
Setup phase : PSEL=1, PENABLE=0
Access phase: PSEL=1, PENABLE=1
Complete    : PREADY=1

[APB4 핵심]
PSTRB[3:0] = byte write enable
PPROT[2:0] = protection attribute

[과제 핵심 파일]
codes/ex_mem_apb_task/rtl/verilog/mem_apb4.v

[구현 핵심]
1. slide 26의 mem_apb4 port template 사용
2. slide 17~20의 mem_apb memory logic 이식
3. PSTRB에 따라 mem0~mem3 byte-wise write
4. PADDR[A_WIDTH-1:2]로 word address 계산
5. Vivado에서 AXI-to-APB bridge 뒤에 APB memory로 연결
6. ARM C code에서 0x6000_0000 주소에 write/read 테스트
```

