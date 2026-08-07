# week7 — MobileNetV2 Layer 8 Depthwise 3×3

작업 기간 2026-08-05 ~ 08-07.
설계 근거 [depthwise/SPEC_depthwise_hw.md](depthwise/SPEC_depthwise_hw.md) ·
방식 비교 [depthwise/NOTE_zero_padding_compare.md](depthwise/NOTE_zero_padding_compare.md) ·
타이밍 [depthwise/timing_dsp_chain.html](depthwise/timing_dsp_chain.html)

---

## 1. 최종 구조

```text
input_data ─▶ line_buf_1(15) ─▶ line_buf_2(15)
                   │                  │
      bot ─────────┼──────────────────┼──── top
      mid ─────────┘                  │
                   ▼                  ▼
             3-mux zero padding (col_zero / top_zero / bot_zero)
                   ▼
   top_in ─▶ DSP ─ACOUT─▶ DSP ─ACOUT─▶ DSP ─▶ top_out ─┐
              └──PCOUT──▶  └──PCOUT──▶                  │
   mid_in ─▶ (동일)                    ─▶ mid_out ──────┼─▶ [+reg] ─▶ data_out
   bot_in ─▶ (동일)                    ─▶ bot_out ──────┘
```

| 항목 | 값 |
|---|---|
| 프레임 | **15 × 15 = 225 clk/채널** (더미 행·열 1개씩) |
| 유효 출력 | 196 / 225 |
| IFM read | 픽셀당 **1회** (후보 B 대비 9배 절감) |
| 라인버퍼 | 2개 × 15 × 16bit, SRL16E |
| DSP | 9개 = 행마다 3탭 systolic 체인 × 3 |
| latency | **7** = A→P 4 + PCIN 홉 2 + 가산 reg 1 |
| throughput | 1 출력 / clk |
| 384채널 전체 | 86,400 clk |

---

## 2. 설계 결정과 근거

| 결정 | 근거 |
|---|---|
| **라인버퍼 2개 스트리밍** | 픽셀 하나가 9번 쓰이는 건 못 없앤다. 기억(32 LUT) / 다시 읽기(BRAM 9배) / 복제(메모리 9배) 중 가장 싼 선택 |
| **프레임 15×15** (16×16 아님) | window는 스트림보다 2칸 뒤에서 완성 → 더미 슬롯 필수. 행 주기를 14로 줄이면 행 인덱스가 대각선으로 어긋나 마스크로 못 고침. 왼쪽 padding은 더미 열이 2clk 뒤 `w[*][0]`으로 밀려오며 겸함 |
| **마스크 상수 `1`/`14`** | 카운터는 padding 칸이 아니라 **window 우하단의 실제 픽셀**을 센다. 출력 `(0,0)`의 우하단은 입력 `(1,1)` |
| **마스크를 window 출력이 아닌 입력에** | mux 9개 → 3개. critical path에서 제거 |
| **라인버퍼에 reset 없음** | SRL16E 추론 유지 (32 LUT vs 480 FF). 초기 X는 마스크·무효 구간과 정확히 겹쳐 새지 않음 |
| **3체인 × 3탭** (9단 단일 체인 아님) | 세 행을 같은 시각에 소비하므로 `0/3/6` skew 지연선 144 FF가 불필요. latency도 `L_AP+8` → `L_AP+3` |
| **`AREG(2)` + `ACASCREG(2)`** | `ACOUT` 2clk / `PCOUT` 1clk → 차이 1clk이 열 오프셋을 만든다. 1clk이면 상쇄되어 3탭이 전부 같은 샘플 |
| **체인 내 weight 역순** (k2→k1→k0) | systolic에서 head가 최종합의 가장 오래된 위치에 대응 |

### 왜 skew가 필요한가

캐스케이드 부분합은 **1clk에 DSP 한 칸씩** 내려간다. 같은 사이클에 9개를 넣으면
`a8(t) + a7(t-1) + ... + a0(t-8)` 이 되어 9탭이 전부 다른 출력에 속한다.

3체인 구조에서는 **열 방향은 캐스케이드가 공짜로 맞춰주고**, 행 방향은 체인을 나눠서 해결했다.

---

## 3. 검증·합성 결과

| 버전 | LUT | LUTRAM | FF | BRAM | DSP | WNS | latency | 범위 |
|---|---:|---:|---:|---:|---:|---:|---:|---|
| v1 추론 (조합 캐스케이드) | 41 | 32 | 89 | 0 | 9 | 미측정 | 2 | `depth_mac` OOC 합성 |
| v2 primitive systolic | 114 | 16 | 167 | 2 | 9 | **7.678** | 7 | `depth_top` 배치·배선 |

**범위가 달라 자원을 직접 빼서 비교하면 안 된다.** v2는 weight ROM + MMCM 포함.

### v2 타이밍 (100MHz)

```text
clk_in              40 MHz (25ns)   MMCM 입력, setup 경로 없음
clk_out1_clk_wiz_0 100 MHz (10ns)   endpoint 1,864

  WNS  7.678    WHS  0.050    WPWS 4.427    failing 전부 0
```

경로 지연 **2.322 ns → Fmax 약 430MHz**. DSP48E1 한계(-1 등급 약 460MHz)에 근접.
`AREG(2)/MREG/PREG`를 다 켜서 **DSP 한 단이 그대로 임계 경로**가 된 결과.

> **WHS 0.050은 문제가 아니다.** hold는 클럭 주기와 무관하고 통과/실패만 의미가 있다.
> Vivado가 배선 지연을 넣어 0을 넘기면 멈추므로 작은 양수가 정상 결과다.
> 봐야 할 건 `THS = 0.000`, `failing = 0`.

### v1의 LUT 41이 말해준 것

fabric에 adder tree가 있었다면 `48bit 가산기 8개 × 48 ≈ 384 LUT`가 나와야 한다.
41이라는 건 **추론만으로 이미 DSP 내부 가산기 + PCIN 캐스케이드를 쓰고 있었다**는 뜻.
`LUTRAM 32`는 라인버퍼 reset을 안 건 결정이 먹힌 증거.

---

## 4. 값비싼 함정 — 합성 에러가 안 나는 것들

| 증상 | 원인 | 교훈 |
|---|---|---|
| `col_cnt`가 start 후 0에 고정 | `end else begin`이 안쪽 `if`가 아니라 `if(run)`에 붙음 | `else`는 **직전 `end`가 열어둔 `if`** 에 붙는다. 들여쓰기는 구속력이 없다 |
| 음수 weight가 깨짐 | part-select는 부모가 signed여도 **항상 unsigned** | `$signed()` 필수. 입력이 ReLU6 출력(0~6)이라 양수 테스트로는 안 잡힌다 |
| 출력이 `16` (기대 `32`) | TB가 `input_data = n`(blocking)을 posedge에 대입 → 레이스 | **TB 자극은 논블로킹으로.** 클럭 엣지와 같은 시각에 값을 바꾸면 안 된다 |
| `data_out` 미구동 | generate `for(i<8)` 안의 `else if(i==8)`이 **죽은 분기** | 루프 조건과 분기 조건이 같으면 한쪽은 생성되지 않는다 |
| weight가 0 | ROM `ena`를 1clk 펄스로 줌 | 출력 레지스터도 `ena`로 갱신된다. 펄스면 데이터가 `douta`까지 못 온다 |
| `ACIN`에 `ZZZZ` | `ACOUT`→`ACIN` 중간 wire를 16bit로 선언 | **포트 폭과 정확히 같게.** `ACOUT`/`ACIN` 30bit, `PCOUT`/`PCIN` 48bit |
| `Place 30-119` | `ACOUT`을 일반 `A` 포트에 연결 | `ACOUT`은 **fabric으로 아예 못 나간다.** `ACIN` 전용 |
| `Place 30-58` (IO 162 > 82) | `depth_mac`을 top으로 Implementation | 블록 단위는 **OOC 합성**(`-mode out_of_context`) |
| 시뮬은 통과 배치는 실패 | 동작 모델과 물리 제약은 다르다 | 캐스케이드는 반드시 Implementation까지 돌려봐야 한다 |

### IP 파라미터에 없다고 기능이 없는 게 아니다

`has_acin` 체크박스가 없어서 "DSP48 Macro로 A 캐스케이드 불가"라고 결론냈는데 틀렸다.
**명령어에 `ACIN`이라고 쓰면 포트가 생긴다.** `PCIN`과 같은 방식.

```text
dsp48_mul      : A*B           → CLK, A, B          → ACOUT, PCOUT, P
dsp48_mac      : ACIN*B+PCIN   → CLK, ACIN, B, PCIN → ACOUT, PCOUT, P
dsp48_mac_last : ACIN*B+PCIN   → CLK, ACIN, B, PCIN → P
```

### `DSP48E1` primitive 기본값 주의

UNISIM(`C:\Xilinx\Vivado\2020.2\data\verilog\src\unisims\DSP48E1.v`)의 기본값은
우리가 원하는 값이 **아니다.** 특히:

```verilog
ACASCREG = 1     // ← 2 여야 함.  1이면 배치는 되는데 값만 틀림
OPMODEREG = 1    // ← 0.  1이면 CECTRL 을 안 켤 때 OPMODE 가 0 에 고정 → P 가 영원히 0
```

`AREG(2)`면 **`CEA1`, `CEA2` 둘 다** 켜야 한다.

---

## 5. 미해결 / 다음

- [ ] **기능 검증 미완료** — `errors = 0`, `checked = 392`를 아직 못 봤다. 배치가 통과했다고 기능이 맞는 건 아니다
- [ ] `mem_depth_weight` 정리 — `ena` 상수 1, `addra`에 채널 카운터(0~383), 프레임 카운터와 분리
- [ ] `LUT as Memory`가 32 → 16으로 줄었다. 라인버퍼 한쪽이 SRL로 안 잡혔을 가능성. `report_utilization -hierarchical`로 확인
- [ ] v1/v2를 **같은 범위·같은 주파수**로 다시 측정
- [ ] `max|K'|` 실측 → 고정소수점 Q 포맷 확정 → ReLU6 + 출력 포맷
- [ ] `PAR_CH` 채널 병렬화 — 서로 다른 데이터로 슬라이싱 검증
- [ ] pointwise 직결 불가 (NOTE §8). pixel-major ↔ channel-major transpose + 레이트 불일치. 루프 순서 교체 + 196워드 ping-pong 필요
- [ ] 정리 대상: `depth_FSM.v`(등록됐는데 디스크에 없음), `depth_weight_bram.sv`(디스크에 있는데 미등록), `depthwise_pkg.sv`(인코딩 깨짐 + pointwise 값)

---

## 6. 파일

```text
week7/
├ DAILY_LOG.md
└ depthwise/
  ├ SPEC_depthwise_hw.md              설계 문서
  ├ NOTE_zero_padding_compare.md      방식 1/2 비교 + pointwise 연결
  ├ timing_dsp_chain.csv / .html      DSP 체인 타이밍
  ├ coe/
  │ ├ weight_144x384_all1.coe         전부 1        ← TB 와 동일
  │ ├ weight_144x384_1to9.coe         1~9          커널 반전 검출
  │ └ weight_144x384_signed.coe       1,-2,...,9   signed 검출
  └ depthwise.srcs/
    ├ sources_1/new/  depth_top.sv  depth_mac.sv  mem_depth_weight.sv
    └ sim_1/          tb_depth_top.sv  tb_depth_mac.sv
```

IP: `blk_mem_gen_0`(weight ROM 144×384) · `clk_wiz_0`(40→100MHz) ·
`dsp48_mul` / `dsp48_mac` / `dsp48_mac_last`
