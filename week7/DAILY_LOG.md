# week7 작업 로그 — MobileNetV2 Layer 8 Depthwise 3×3

> 날짜별로 한 일과 막힌 지점을 남긴다.
> 설계 근거는 [depthwise/SPEC_depthwise_hw.md](depthwise/SPEC_depthwise_hw.md),
> 방식 1/2 비교는 [depthwise/NOTE_zero_padding_compare.md](depthwise/NOTE_zero_padding_compare.md).

---

## 2026-08-05

### 한 일

| | 내용 |
|---|---|
| 구조 확정 | 라인버퍼 2개 스트리밍(후보 D). 15×15 프레임, 채널당 225clk, IFM read 196회(픽셀당 1회) |
| zero padding | 방식 2(마스크) 채택. 라인버퍼 출력단 **mux 3개**로 상하좌우 4방향 전부 처리 |
| `depth_mac.sv` | 라인버퍼 2개 → 3-mux → window 9개 → 곱셈 9 + 누산 → 스트림 카운터 |
| TB | 프레임 인덱스 입력 + `golden()` 비교로 error 개수 집계 |
| 문서 | `NOTE_zero_padding_compare.md` 작성 |
| Git | week7 8개 파일 커밋·푸시 (`1dc73b1`) |

### 문제와 해결

**1. 더미 행·열이 왜 1개씩 필요한가**

window는 스트림보다 2칸 뒤에서 완성된다. 데이터 14개를 다 넣어도 마지막 출력이 안 나온다.

```text
col=13 → [X11|X12|X13]  → 출력 열 12
col=14 → [X12|X13| ?  ] → 출력 열 13   ★ 슬롯 하나 더 필요
```

행 주기를 14로 줄이면 다음 행 첫 픽셀이 섞이면서 **행 인덱스가 대각선으로 어긋난다.** 마스크로 못 고치는 구조적 오류 → **행 주기 15 확정**.
왼쪽 padding은 더미 열이 2클럭 뒤 `w[*][0]`으로 밀려오며 겸한다. 그래서 더미는 1개면 충분.

**2. 마스크 상수가 `0`/`15`인가 `1`/`14`인가**

16×16 padded 좌표(방식 1)와 15×15 스트림 좌표(방식 2)를 섞어 생각해서 헷갈렸다.
카운터는 padding 칸을 세는 게 아니라 **window 우하단에 지금 들어온 실제 픽셀**을 센다.
출력 `(0,0)`의 window 우하단은 입력 `(1,1)` → 상수는 `1`/`14`.

**3. `col_cnt`가 start 이후 0에서 멈춤**

```systemverilog
end else if(run) begin
    if(col_cnt == ROW_LEN-1) begin ... end
end else begin                      // ← if(run) 의 else 가 되어버림
    col_cnt <= col_cnt + 4'd1;      //   run 이 0 일 때만 증가
end
```

`else`는 **직전 `end`가 열어둔 `if`** 에 붙는다. 들여쓰기는 구속력이 없다.
`end`를 안쪽으로 옮겨 해결. **합성 에러가 안 나서 파형에서만 드러나는 부류.**

**4. 합성 실패 — 조합 루프**

`always_comb` 안에서 `sum = sum + ...`을 초기화 없이 씀 → 자기 피드백.
첫 줄에 `sum = 0` 추가.

**5. 음수 weight가 깨질 위험**

`weight[i*DW +: DW]` 같은 **part-select는 부모가 signed여도 항상 unsigned**(IEEE 1800).
한쪽이 unsigned면 곱셈 전체가 unsigned가 되고 48bit 확장도 zero-extend가 된다.
`$signed(...)`로 감싸 해결. 입력이 ReLU6 출력(항상 0~6)이라 **양수 테스트만으로는 안 잡힌다.**

**6. TB 파일이 2개로 갈라짐**

Vivado가 add source 시 `sim_1/imports/new/`로 복사하는데, 원본 경로에 계속 수정해서 분기됨.
`imports` 쪽으로 통합하고 원본 삭제. 이후 수정은 `imports` 쪽에만.

**7. 출력이 `16`으로 나옴 (기대 `32`)**

TB에서 `input_data = n`(blocking)을 posedge에 대입 → 값이 **클럭 엣지와 같은 시각**에 바뀜.
DUT가 옛 값을 볼지 새 값을 볼지 미정인 레이스. 결과적으로 한 칸 밀려서 `(1,1)` 대신 `(1,0)` 자리를 보고 있었다.
**`<=`(논블로킹)로 변경**하여 해결. `rst`, `start`도 동일.

**8. window 값이 `16 17`로 나옴 (기대 `15 16`)**

입력을 `r*16+c`로 넣고 있었다. `15 16`이 나오려면 15칸 주기여야 하므로
**프레임 위치 `n = r*15 + c`** 를 그대로 입력으로 사용하도록 변경.
이렇게 하면 window 안의 값이 곧 주소가 되어 파형에서 바로 읽힌다.

**9. `simulate.log` 삭제 불가**

Vivado 인스턴스 2개가 같은 프로젝트를 열고 있어 파일이 잠김. 오래된 쪽 종료.

**10. Implementation 실패 — IO 162 > 82**

`depth_mac`을 top으로 두고 돌림. `weight` 144비트는 BRAM에서 오는 내부 신호라 핀으로 나갈 게 아니다.
**OOC 합성**(`-mode out_of_context`)으로 전환.

**11. pointwise 출력을 직결할 수 있는가 → 불가**

pointwise는 **pixel-major**(pix 외곽 / oc 중간), depthwise는 **channel-major**가 필요.
완전한 transpose 관계라 라인버퍼가 성립하지 않는다.
+ 레이트도 불일치(75,264 vs 86,400 clk).
→ pointwise 루프 순서 교체 + 196워드 ping-pong 필요. 상세는 NOTE §8.

---

## 2026-08-06

### 한 일

| | 내용 |
|---|---|
| OOC 합성 | **DSP 9 / LUTRAM 32 / LUT 41 / FF 89** 확인 |
| DSP IP | DSP48 Macro(`xbip_dsp48_macro`) `dsp48_mul`, `dsp48_mac` 생성 |
| 캐스케이드 | `PCOUT→PCIN` 9단 체인 설계 + 입력 skew 도출 → **3체인×3탭으로 변경** |
| DSP 구현 | 3체인 systolic (`ACOUT` 연결) 완성, latency 7 확인 |
| 병렬화 | `PAR_CH` 파라미터로 채널 병렬화하는 generate 구조 설계 |

### 합성 결과 — v1 기준선

조건: `depth_mac` 단독, OOC 합성, XDC 없음(타이밍 미측정), `PAR_CH=1`,
곱셈/누산은 `always_comb`의 `sum = sum + w[i]*$signed(weight[...])` 추론.

| Resource | 사용 | 가용 | % | 해석 |
|---|---:|---:|---:|---|
| LUT | **41** | 70,560 | 0.06 | 마스크 3 + 카운터. **fabric 가산 트리 없음** |
| LUTRAM | **32** | 28,800 | 0.11 | 라인버퍼 2개가 **SRL16E로 추론됨** (2 × 16bit) |
| FF | **89** | 141,120 | 0.06 | window 상당수가 DSP 입력 레지스터로 흡수 |
| DSP | **9** | 360 | 2.50 | 곱셈 9개 전부 DSP |
| BUFG | 1 | 196 | 0.51 | — |
| IO | 211 | 82 | 257 | OOC가 아닐 때의 값. 무시 |

**LUT 41이 핵심 지표다.** fabric에 adder tree가 있었다면 `48bit 가산기 8개 × 48 ≈ 384 LUT`가
나와야 한다. 41이라는 건 **추론만으로 이미 DSP 내부 가산기 + PCIN 캐스케이드를 쓰고 있었다**는 뜻.

**LUTRAM 32**는 라인버퍼에 reset을 안 건 결정이 먹혔다는 증거 (걸었으면 480 FF).

### 버전별 비교 (추가해 나갈 것)

| 버전 | LUT | LUTRAM | FF | DSP | WNS | latency | 비고 |
|---|---:|---:|---:|---:|---:|---:|---|
| v1 추론 (조합 캐스케이드) | 41 | 32 | 89 | 9 | 미측정 | 2 | 기준선 |
| v2 IP 3체인 systolic | | | | 9 | 미측정 | **7** | 구현 완료, 합성 미실시 |
| v3 `PAR_CH=2` | | | | | | | 예정 |

> **WNS를 먼저 채워야 한다.** XDC에 `create_clock -period 10.000 -name clk [get_ports clk]`을
> 넣고 `report_timing_summary`. 이 숫자 없이는 v1과 v2 중 어느 쪽이 나은지 판단할 수 없다.
> v1은 DSP 9개를 조합으로 직렬 관통하므로 Fmax가 낮을 가능성이 크다.

### 문제와 해결

**12. `P`와 `PCOUT`이 왜 둘 다 있나**

같은 48bit 값인데 **나가는 길이 다르다.**

```text
PCOUT : 옆 DSP 의 PCIN 으로만.  타일 내부 전용 배선, fabric 접근 불가
P     : fabric 어디든.          일반 라우팅
```

우리 설계에서는 인스턴스마다 **하나만** 쓴다.

```text
DSP0~7 : PCOUT 사용, P 는 .P() 로 비움
DSP8   : P 사용 (data_out), PCOUT 은 비움   ← PCOUT 으로는 fabric 에 못 꺼냄
```

**13. `dsp48_mul`과 `dsp48_mac`을 왜 나누나**

`PCIN`은 물리적으로 **옆 DSP의 `PCOUT`에서만** 배선이 들어온다. fabric에서 상수 0을 물릴 수 없다.
따라서 체인 맨 앞은 `PCIN`을 아예 쓰지 않는 명령어(`A*B`)여야 한다.
→ head 1개 `A*B`, 나머지 8개 `A*B+PCIN`.
head를 `A*B+C`로 만들면 나중에 BN bias 가산기가 공짜로 생긴다 (`C`는 fabric 포트).

**14. IP 심볼에 `PCOUT`이 안 보임**

`PCIN`은 명령어에 쓰면 자동 생성되지만, **`PCOUT`은 Implementation 탭에서 수동으로 켜야 한다**(기본 꺼짐).
`Additional ports → Use PCOUT` 체크.

**15. ★ 캐스케이드 부분합은 1클럭에 한 칸씩 내려간다 → 입력 skew 필요**

이번 작업에서 가장 중요한 이해.

각 DSP의 `PREG` 때문에 부분합이 `DSP d → DSP d+1`로 가는 데 **1클럭**이 걸린다.
9개 DSP에 같은 사이클에 값을 넣으면:

```text
DSP8 최종합 = a8(t) + a7(t-1) + a6(t-2) + ... + a0(t-8)
              └──── 9개가 전부 다른 시각의 픽셀 = 다른 출력의 탭 ────┘
```

부분합이 체인을 타고 내려오는 8클럭 동안 입력이 계속 흐르기 때문에,
**같은 출력에 속한 9탭이 각자 자기 차례에 도착하도록 미리 어긋나게 넣어야 한다.**

**16. 왜 skew가 `0/3/6`인가 (`0~8`이 아니라)**

필요한 9탭이 이미 시간축에 흩어져 있다는 게 핵심.

```text
같은 행 안 : 열이 1칸 다르면 시각도 1클럭 다름  →  top(T-2), top(T-1), top(T)
             캐스케이드의 1클럭/단과 정확히 일치  →  추가 지연 불필요

행 사이   : top/mid/bot 은 라인버퍼에서 같은 시각에 나오는데
             DSP 를 3칸 건너뛰므로 3클럭씩 어긋남  →  지연 필요

DSP :  0     1     2  │  3     4     5  │  6     7     8
행  : ─── top ────────│──── mid ────────│──── bot ────────
지연:  0     0     0  │  3     3     3  │  6     6     6
       └─ 열은 공짜 ─┘   └─ 행만 3씩 ─┘
```

**열 방향 shift는 캐스케이드가 공짜로 해주고, 행 방향만 손으로 맞춘다.**

부수 효과로 **`w[0:8]` window 레지스터가 사라진다.** 지연선 `0+3+6 = 9` × 16bit로
FF 개수는 같지만, fabric 가산 트리 ~250 LUT이 통째로 없어진다.

`L_AP`(IP의 `A*B` latency)가 3이든 4든 **skew는 항상 0/3/6**이고,
전체 latency만 `L_AP + 6`으로 바뀐다. TB의 `LAT`도 이 값.

**17. generate 코드 버그 4개**

| 버그 | 내용 |
|---|---|
| `B`에 `line_buf_1` 연속 슬라이스 | 슬롯 0~8은 **같은 행의 1×9 띠**이지 3×3 window가 아니다. 세 행은 각각 line_buf_2 출력 / line_buf_1 출력 / input_data 에서 와야 함 |
| `pc[i-1]`에서 `i=0` | `pc[-1]` 범위 밖. 게다가 `pc[0]`을 head와 중복 구동. 루프를 `i=1~8`로 바꾸면 `pc[i-1]`/`pc[i]`가 자연스럽게 맞음 |
| `else if`가 죽은 분기 | 루프 조건 `i < 8`, 분기 조건도 `i < 8` → `.P(data_out)` 쪽이 **생성되지 않아 `data_out` 미구동** |
| 배열 크기 `PARALLEL_CH` | 탭 인덱스(0~8)를 담으므로 `PARALLEL_DEPTH`여야 함 |

**18. 채널 병렬화 구조**

depthwise는 채널이 완전 독립(SPEC §2.1)이라 채널 방향이 자연스러운 병렬 축.

```text
공유 (1벌)                복제 (PAR_CH 벌)
col_cnt / row_cnt         라인버퍼 2개
col_zero / top_zero       skew 지연선
bot_zero / run            DSP 체인 9개
```

모든 채널이 같은 공간 위치를 같은 사이클에 처리하므로 **카운터와 마스크는 하나면 된다**(41 LUT 고정).
DSP가 한계: 보유 360개 → `PAR_CH ≤ 40`, 384의 약수 중 **32가 상한**(288 DSP).

전제: IFM이 매 사이클 `PAR_CH × 16bit`를 줘야 하므로 **같은 공간 위치의 여러 채널이 한 워드**에
들어있는 레이아웃이 필요하다. → NOTE §8의 pointwise 연결 논의와 직결.

---

### DSP 구현 — 확정 구조 (3체인 × 3탭 systolic)

9단 단일 체인(항목 15/16) 대신 **행마다 3탭 체인**으로 바꿨다.

```text
top_in ─▶ mac_top1 ─ACOUT─▶ mac_top2 ─ACOUT─▶ mac_top3 ─▶ top_out ─┐
             └─────PCOUT────▶  └─────PCOUT────▶                     │
mid_in ─▶ (동일 구조)                          ─▶ mid_out ──────────┼─▶ [+reg] ─▶ data_out
bot_in ─▶ (동일 구조)                          ─▶ bot_out ──────────┘
```

| 항목 | 값 |
|---|---|
| 코어 | `dsp48_mul`(`A*B`) ×3 head + `dsp48_mac`(`A*B+PCIN`) ×6 |
| A 전달 | `ACOUT` → 다음 `A` (fabric 경유) |
| `ACOUT` 지연 | **2clk** (`areg_3` + `areg_4`) |
| 체인 내 weight | **역순** `k2 → k1 → k0` |
| skew 지연선 | **불필요** |
| window 레지스터 | **불필요** |
| latency | **7** |

**바꾼 이유**: 세 행을 같은 시각에 소비하므로 `0/3/6` skew 지연선 144 FF가 통째로 사라지고,
latency도 `L_AP+8` → `L_AP+3`으로 줄어든다. 대신 48bit 3입력 fabric 가산기(~100 LUT)가 생긴다.

### 문제와 해결 (이어서)

**19. IP에 `ACIN`이 없다 → 전용 배선 systolic 불가**

생성된 스텁과 IP 파라미터를 확인한 결과:

```text
dsp48_mac : CLK, PCIN[47:0], A[15:0], B[15:0] → ACOUT[29:0], PCOUT[47:0], P[47:0]
사용자 파라미터 : has_acout / has_bcout / has_pcout ... (has_acin 없음)
```

`C_HAS_ACIN`은 내부 파생값이라 켤 수 없다. `PCIN`이 생긴 건 명령어에 썼기 때문이고
A 쪽은 명령어 문법에 `ACIN`이 없다. **`ACOUT`→`ACIN` 전용 경로는 `DSP48E1` primitive로만 가능.**

차선책으로 `ACOUT[15:0]`을 다음 인스턴스의 일반 `A`에 연결했다. fabric을 거치므로 전용 배선의
이점은 없지만 **데이터플로우와 타이밍은 systolic 그대로**다.

**20. `ACOUT` 비트 폭은 바꿀 수 없다**

`A` 포트 전체 폭(30bit)에 대응하는 실리콘 고정 배선. IP 설정에 없다.
16bit wire로 받으면 잘리지만 **상위 14bit는 sign extension이라 값은 보존**된다(경고만 발생).

**21. `PCOUT`이 왜 2가 아니라 3인가**

`1*1 + 1 = 2`로 생각했는데 실제로는 `2*1 + 1 = 3`이었다.
**A와 PCIN이 서로 다른 파이프라인 깊이에서 온다.**

```text
A ─▶[areg×2]─▶[MREG]─▶[PREG]─▶ P      A → P = 4clk
                          ▲
PCIN ─────────────────────┘            PCIN → P = 1clk
```

그 순간 곱셈기에 도달한 A는 이미 `2`였다. 파형 검산:

```text
top2 PCOUT = x(t-6) + x(t-5)        t=6: 0+1=1,  t=7: 1+2=3   ✓
top_out    = x(t-8)+x(t-7)+x(t-6)   t=7: 0+0+1=1              ✓
```

**연속한 세 샘플**이 모였으므로 3×3의 한 행이 정상적으로 누산된 것.
동시에 `A: 1 2 3 4 5` vs `ACOUT: _ _ 1 2 3`으로 **`ACOUT` 2clk도 확인**됐다.

**22. latency 7의 구성**

```text
input_data ─▶ [IP A→P : 4] ─▶ [PCIN 홉 ×2] ─▶ [최종 가산 reg : 1] ─▶ data_out

                4      +          2         +          1          = 7
```

`areg`를 줄이면 latency도 줄지만 **`ACOUT` 지연이 2→1이 되어 결과가 틀린다.** 건드리면 안 됨.
그리고 latency 7만으로는 `ACOUT` 지연이 맞는지 알 수 없다(1clk이어도 7). 값으로 확인해야 한다.

**23. TB에 `LAT`이 없었다**

설명에서만 쓰고 파일에는 2단 고정(`exp0/exp1/exp2`)으로 남아 있었다.
`localparam LAT` + 배열 `[0:LAT]`로 파라미터화. 이제 DSP 구성을 바꿔도 숫자 하나만 고치면 된다.

---

## 다음 할 일

1. **v2 시뮬 통과 확인** — `LAT=7`로 `errors=0`, `checked=392` 나오는지
2. XDC(`create_clock -period 10`) 추가 후 v1/v2 **WNS 측정** — 비교표의 빈칸
3. v2 합성 → LUT/FF 기록. fabric 가산기(~100 LUT)가 늘고 skew FF는 없어야 정상
4. `PAR_CH=2`로 **서로 다른 데이터**를 넣어 슬라이싱 검증
5. `max|K'|` 실측 → 고정소수점 Q 포맷 확정 → ReLU6 + 출력 포맷 구현

## 교훈

- **제어 카운터부터 확인한다.** "출력이 안 나온다"는 증상은 데이터패스보다 카운터 문제인 경우가 많다.
- **합성 에러가 안 나는 버그가 제일 비싸다.** `else` 결합, part-select signedness, 죽은 generate 분기 모두 문법상 정상이다.
- **TB의 자극은 논블로킹으로.** 클럭 엣지와 같은 시각에 값을 바꾸면 레이스가 된다.
- **파형에서 값만 보고 좌표를 알 수 있게** 입력 패턴을 고른다(프레임 인덱스 `n`).
- **latency와 throughput을 구분한다.** 파이프라인이 깊어져도 처리량은 1출력/클럭 그대로다.
