# Depthwise 3×3 — Zero Padding 구현 비교 노트

> 작업 로그. 생각의 흐름과 결정 근거를 남기는 것이 목적이다.
> 확정된 설계 문서는 [SPEC_depthwise_hw.md](SPEC_depthwise_hw.md)를 참조한다.
>
> **현재 상태**: 방식 1 구현 중

---

## 0. 무엇을 비교하는가

같은 depthwise 3×3 연산을 두 가지로 구현해서 자원·타이밍·전력을 비교한다.

| | 방식 1 | 방식 2 |
|---|---|---|
| 이름 | 일반 zero padding conv | top/bottom 행 연산 생략 |
| 핵심 | zero를 window에 넣고 **9 tap 전부 연산** | zero인 게 확정된 행은 **연산 자체를 건너뜀** |
| 상태 | 구현 중 | 미착수 |

연산 결과는 두 방식이 **완전히 동일해야 한다.** 다른 건 연산량과 스위칭뿐이다.

---

## 1. 공통 전제

두 방식 모두 아래 구조를 공유한다. 이 부분은 비교 대상이 아니다.

### 1.1 라인버퍼 2개 스트리밍

3×3 window는 연속한 3개 행을 동시에 봐야 한다. IFM을 1픽셀/클럭으로 흘리면 현재 행은 입력 스트림 그 자체이고, 나머지 두 행만 지연시키면 된다.

```text
input_data ──▶[ line_buf_1 ]──▶[ line_buf_2 ]
     │              │                │
    bot            mid              top
  (현재 행)     (1행 전)         (2행 전)
```

- 행 지연 소자 = 커널 높이 − 1 = **2개**
- 각 라인버퍼 깊이 = **행 주기 = 15**
- SRL16E로 추론되어 비트당 LUT 1개 (총 32 LUT)

> 라인버퍼에 reset을 걸면 SRL 추론이 깨져 480 FF가 된다. 리셋 없는 블록으로 분리할 것.

### 1.2 15×15 스트림 프레임

실제 IFM은 14×14지만 스트림은 15×15로 돌린다.

```text
             col_cnt →
          0    1    2   ...   13    14
       ┌────┬────┬────┬─────┬─────┬─────┐
  0    │X00 │X01 │X02 │ ... │X0,13│더미 │  출력 없음
  1    │X10 │X11 │X12 │ ... │X1,13│더미 │ → 출력 행 0
  2    │X20 │    │    │     │     │더미 │ → 출력 행 1
  :    │    │    │    │     │     │     │
  13   │X13,0    │    │     │     │더미 │ → 출력 행 12
  14   │더미│더미│더미│ ... │더미 │더미 │ → 출력 행 13
       └────┴────┴────┴─────┴─────┴─────┘
  ↑
row_cnt
```

**더미 행/열이 1개씩 필요한 이유**: window는 지금 들어온 픽셀을 우하단으로 잡으므로 스트림보다 2칸 뒤에서 완성된다. 데이터 14개를 다 넣어도 마지막 출력이 아직 안 나온다.

```text
col_cnt=13 → [X11|X12|X13]  → 출력 열 12
col_cnt=14 → [X12|X13| ?  ] → 출력 열 13   ★ 슬롯이 하나 더 필요
```

행 주기를 14로 줄이면 다음 행 첫 픽셀이 window에 섞이면서 행 인덱스가 대각선으로 어긋난다. 마스크로 고칠 수 없는 구조적 오류라 **행 주기 15는 강제**다.

- 채널당 **225 clk** (유효 출력 196개)
- 384채널 = 86,400 clk
- IFM read = 픽셀당 정확히 1회 (이론적 최소)

### 1.3 좌표와 마스크 상수

| 신호 | 수식 |
|---|---|
| 출력 행 | `row_cnt - 1` |
| 출력 열 | `col_cnt - 1` |
| `win_valid` | `row_cnt >= 1 && col_cnt >= 1` |
| `col_zero` | `col_cnt == 14` — 더미 열 (좌·우 padding 겸용) |
| `top_zero` | `row_cnt == 1` — 출력 행 0 |
| `bot_zero` | `row_cnt == 14` — 출력 행 13 |

> `0`/`15`가 아니라 `1`/`14`인 이유: 이 카운터는 padding 칸을 세는 게 아니라
> **window 우하단에 지금 들어온 실제 픽셀**의 위치를 센다. 16×16 padded 좌표계와
> 헷갈리지 말 것.

### 1.4 마스크가 필요한 9가지 경우

```text
row=1        row=1         row=1          ← top 행 0
col=1        col=2~13      col=14
┌─┬─┬─┐     ┌─┬─┬─┐      ┌─┬─┬─┐
│0│0│0│     │0│0│0│      │0│0│0│
│0│●│●│     │●│●│●│      │●│●│0│
│0│●│●│     │●│●│●│      │●│●│0│
└─┴─┴─┘     └─┴─┴─┘      └─┴─┴─┘
 tap 4       tap 6        tap 4

row=2~13     row=2~13      row=2~13
col=1        col=2~13      col=14
┌─┬─┬─┐     ┌─┬─┬─┐      ┌─┬─┬─┐
│0│●│●│     │●│●│●│      │●│●│0│
│0│●│●│     │●│●│●│      │●│●│0│
│0│●│●│     │●│●│●│      │●│●│0│
└─┴─┴─┘     └─┴─┴─┘      └─┴─┴─┘
 tap 6       tap 9        tap 6

row=14       row=14        row=14         ← bot 행 0
col=1        col=2~13      col=14
┌─┬─┬─┐     ┌─┬─┬─┐      ┌─┬─┬─┐
│0│●│●│     │●│●│●│      │●│●│0│
│0│●│●│     │●│●│●│      │●│●│0│
│0│0│0│     │0│0│0│      │0│0│0│
└─┴─┴─┘     └─┴─┴─┘      └─┴─┴─┘
 tap 4       tap 6        tap 4
```

corner 4 / edge 6 / interior 9 — SPEC §14.2의 검증 기준과 일치한다.

### 1.5 window shift와 weight

```text
        j=0     j=1     j=2   ← 열 (왼쪽=옛날, 오른쪽=최신)
      ┌───────┬───────┬───────┐
i=0   │ w[0]  │ w[1]  │ w[2]  │ ◀── top_in
i=1   │ w[3]  │ w[4]  │ w[5]  │ ◀── mid_in
i=2   │ w[6]  │ w[7]  │ w[8]  │ ◀── bot_in
      └───────┴───────┴───────┘
```

`w[i*3+j] × k[i*3+j]`가 SPEC §1의 `weight_addr = ch*9 + kh*3 + kw`와 그대로 대응한다.
**weight는 고정, 데이터가 흐른다.** 커널을 뒤집거나 회전시키지 않는다.

---

## 2. 방식 1 — 일반 zero padding conv

### 2.1 발상

padding을 **데이터 문제**로 취급한다. window에 0을 채워 넣고, 9개 tap을 항상 그대로 곱한다. 곱셈기 입장에서는 가장자리인지 아닌지를 알 필요가 없다.

```text
IFM ──▶ 라인버퍼 ──▶ [0 채우기] ──▶ window ──▶ 9 곱셈 전부 ──▶ 누산
```

### 2.2 zero 삽입 위치

라인버퍼 출력 3곳에 mux를 둔다.

```systemverilog
wire signed [DW-1:0] top_in = (col_zero | top_zero) ? '0 : top;
wire signed [DW-1:0] mid_in = (col_zero           ) ? '0 : mid;
wire signed [DW-1:0] bot_in = (col_zero | bot_zero) ? '0 : bot;
```

**mux 3개로 좌/우/상/하 4방향이 전부 처리된다.** 9개 tap을 개별 마스킹할 필요가 없다.

좌우가 mux 하나로 처리되는 이유:

```text
col_cnt=14 에서 넣은 0 은
  그 사이클      → w[*][2] 에 있음  → 우측 padding
  2 사이클 뒤    → w[*][0] 로 이동  → 좌측 padding   ★

하나의 0 주입이 양쪽을 겸한다
```

### 2.3 특징

| 항목 | 내용 |
|---|---|
| 곱셈 | 항상 9개 |
| 제어 | mux 3개 + 카운터 2개 |
| 파형 디버깅 | `w[0:8]`에 완성된 window가 그대로 보임 ✅ |
| 위험 | 없음 (가장 단순) |

---

## 3. 방식 2 — top/bottom 행 연산 생략

### 3.1 발상

`top_zero`와 `bot_zero`는 **행 단위 조건**이다. 한 번 켜지면 그 행 15클럭 내내 유지된다.

```text
top_zero / bot_zero : 행 단위 (15clk 고정)   ← 미리 알 수 있다
col_zero            : 매 사이클 변함
```

즉 출력 행 0을 계산하는 15클럭 동안 `w[0], w[1], w[2] × k[0], k[1], k[2]`는 **무조건 0**이다. 곱셈기 3개를 15클럭 동안 놀려도 된다는 뜻이다.

```text
row_cnt = 1  구간 :  DSP 0,1,2 불필요
row_cnt = 14 구간 :  DSP 6,7,8 불필요

채널당 30/225 = 13% 구간에서 데이터패스 1/3 이 유휴
```

### 3.2 예상되는 구현 방향 (미확정)

| 후보 | 방법 | 우려 |
|---|---|---|
| a | weight를 0으로 마스킹 (`k_eff`) | 곱셈은 여전히 수행, 토글만 감소 |
| b | DSP의 CE(clock enable)를 내림 | M 레지스터에 이전 값이 남아 합에 섞임 → **틀림** |
| c | 누산식에서 해당 항을 mux로 제외 | 가산기 앞에 mux 추가, 경로 길어짐 |

**b는 그대로 쓰면 안 된다.** CE를 내리면 값이 0이 아니라 "직전 값"으로 고정된다. 0을 강제해야 한다.

### 3.3 냉정하게 볼 점

- 곱셈 9개가 **병렬**이므로 3개를 빼도 **사이클은 안 줄어든다.** throughput은 1 출력/클럭 그대로.
- 따라서 이득은 오직 **전력**이다. 자원은 오히려 늘 수 있다(제어 mux).
- 방식 1의 3-mux도 이미 `w[0..2]`를 0으로 고정하므로 곱셈 결과가 0이 되고 M/P 레지스터 토글이 줄어든다. **방식 1이 이미 상당 부분 이득을 가져간다.**
- 그래서 방식 2의 순수 추가 이득이 측정 가능한 수준인지가 이 비교의 핵심 질문이다.

---

## 4. 비교 지표

Vivado에서 아래를 뽑아 비교한다. 동일 clock constraint, 동일 입력 데이터로 측정한다.

| 종류 | 지표 |
|---|---|
| 자원 | LUT, FF, DSP, BRAM |
| Timing | WNS, Fmax, critical path |
| 성능 | 채널당 cycle (둘 다 225여야 정상) |
| 전력 | Dynamic power, DSP/signal/logic 분해 |
| 배선 | high-fanout net, congestion |

**전력은 반드시 SAIF/VCD를 뽑아서 측정한다.** 게이트 개수나 조건문 개수로 추정하지 않는다.

---

## 5. 현재 진행 상황

### 5.1 완료

- 15×15 프레임 / 더미 행·열 1개씩 필요성 확인
- 라인버퍼 깊이 = 행 주기 = 15 확정
- 마스크 상수 `1` / `14` 확정
- 마스크 9가지 경우 도출
- `depth_mac.sv`: 라인버퍼 2개, 3-mux, window shift 골격 작성

### 5.2 진행 중 — `depth_mac.sv`

```text
input_data ──▶ line_buf_1 ──▶ line_buf_2          ✅
                  ▼
          3-mux (col/top/bot_zero)                 ✅
                  ▼
          window w[0:8] shift                      ✅
                  ▼
          weight 언팩 + 곱셈 9개                    🚧 작성 중
                  ▼
          누산 → ReLU6 → 출력 포맷                  ⬜
                  ▼
          valid_out                                ⬜
```

### 5.3 다음 할 일

1. `depth_mac.sv` 곱셈/누산 완성 → 컴파일 통과
2. window 파형 확인 (여기서 한 번 끊고 눈으로 검증)
3. 입력·weight 전부 1 → corner 4 / edge 6 / interior 9 확인
4. impulse 커널로 커널 반전 여부 확인
5. float golden과 비교
6. 방식 1 합성 → 자원/타이밍/전력 기준선 확보
7. 방식 2 구현 → 동일 조건으로 비교

---

## 6. 결정 사항과 근거

| 결정 | 근거 |
|---|---|
| 라인버퍼 2개 스트리밍 | IFM read 1회/픽셀 (후보 B 대비 9배 절감), 고정 배선 |
| 15×15 프레임 (16×16 아님) | 왼쪽 padding 열을 더미 열이 겸함 → 채널당 31 clk 절약 |
| 마스크를 window 출력이 아닌 **입력**에 | mux 9개 → 3개, critical path에서 제거 |
| 카운터를 `depth_mac` 내부에 | FSM에서 마스크를 받으면 BRAM latency 정렬 버그 위험 |
| weight 고정, 데이터 이동 | 후보 A의 circular pointer mux/decoder 회피 |
| window 레지스터 9개 유지 | 6개로 줄일 수 있으나 48 FF(0.05%) 차이, 디버깅 편의 우선 |
| 라인버퍼에 reset 없음 | SRL16E 추론 유지 (32 LUT vs 480 FF) |

---

## 7. 디버깅 기록

### 7.1 `col_cnt`가 start 이후 0에서 멈춤 — `else` 결합 위치

**증상**

파형에서 스트림 카운터가 정반대로 동작했다.

```text
start 전  : col_cnt 가 계속 증가       ← 돌면 안 되는데 돎
start 후  : col_cnt 가 0 에 고정       ← 돌아야 하는데 멈춤
            row_cnt 영원히 0
            win_valid 한 번도 안 뜸 → 출력 0개
```

**원인**

```systemverilog
end else if(run) begin              // ← 블록 A 시작
    if(col_cnt == ROW_LEN-1) begin  // ← 블록 B 시작
        col_cnt <= 0;
        row_cnt <= ...;
    end                             // ← 블록 B 닫힘
end else begin                      // ← 이 end 가 블록 A 를 닫아버림
    col_cnt <= col_cnt + 4'd1;      //   그래서 이 else 는 if(run) 의 else
end
```

`col_cnt == ROW_LEN-1`의 else로 쓸 의도였는데, 실제로는 **`if(run)`의 else**가 됐다.

```text
의도 : if (run) { if (끝열) 행바꿈; else 열증가; }
실제 : if (run) { if (끝열) 행바꿈; }  else 열증가;
                                       └─ run 이 0 일 때만 증가
```

`run==1 && col_cnt!=14` 구간에 아무 대입도 없어서 `col_cnt`가 얼어붙었다.

**수정**

`end`를 안쪽으로 옮겨 `else`가 내부 `if`에 붙게 한다.

```systemverilog
end else if(run) begin
    if(col_cnt == ROW_LEN-1) begin
        col_cnt <= 0;
        row_cnt <= (row_cnt == ROW_LEN-1) ? 4'd0 : row_cnt + 4'd1;
    end else begin                  // ← 여기로 이동
        col_cnt <= col_cnt + 4'd1;
    end
end
```

**교훈**

- Verilog의 `else`는 **직전 `end`가 열어둔 `if`**에 붙는다. 들여쓰기는 아무 구속력이 없다.
- 중첩 `if`에서 안쪽 else를 쓸 거면 `end else begin`을 쓰기 전에 **어느 블록이 닫히는지** 먼저 세어야 한다.
- 이 부류는 합성 에러가 안 난다. 문법적으로 완전히 정상이라 **파형에서만 드러난다.**
- 카운터가 안 도는 건 겉으로는 "출력이 안 나온다"로만 보여서 데이터패스를 먼저 의심하기 쉽다. **제어 카운터부터 확인하는 습관이 필요하다.**

> §5.3의 검증 순서에서 1번(카운터 파형만 먼저 보기)을 넣어둔 이유가 이것이다.
> `col_cnt`/`row_cnt`가 225 클럭 주기로 정상 순회하는지부터 확인하면
> 데이터패스를 건드리기 전에 잡힌다.

---

## 8. pointwise 출력을 직결할 수 없다 (확인됨)

앞단 expand pointwise(week6)의 출력을 `depth_mac.input_data`에 바로 물릴 수 있는지
확인한 결과, **직결하면 안 된다.** 문제가 두 가지다.

### 8.1 문제 1 — 출력 순서가 정반대 (치명적)

[FSM_pointwise.sv](../../week6/pointwise_conv/pointwise_conv.srcs/sources_1/new/FSM_pointwise.sv)의
카운터 중첩(L77-82, 주석은 L6-8)이 다음과 같다.

```text
ic_cnt  ← inner    (0~63)
oc_cnt  ← middle   (0~383)
pix_cnt ← outer    (0~195)
```

`PARALLEL_CH == IN_CH == 64`라 `ic_last`가 항상 1이므로, 실질적으로 매 클럭
`oc_cnt`가 증가하고 384클럭마다 `pix_cnt`가 하나 오른다.

```text
pointwise 출력 (pixel-major)          depthwise 가 필요한 순서 (channel-major)
  pix0 : oc0 ... oc383                  ch0 : pix0 pix1 ... pix195   ← raster 연속
  pix1 : oc0 ... oc383                  ch1 : pix0 ...
   :                                     :
```

**완전한 transpose 관계다.** 라인버퍼는 "같은 채널의 15클럭 전 픽셀"을 꺼내는
장치인데, 지금 순서로는 15클럭 전이 *다른 채널의 같은 픽셀*이다.

### 8.2 문제 2 — 레이트 불일치

```text
pointwise : 384 × 196 = 75,264 clk   (1출력/클럭 연속)
depthwise : 384 × 225 = 86,400 clk   (더미 29 포함)   ← 15% 느림, 병목
```

depthwise가 더미 슬롯에서 소비하지 않으므로 pointwise를 세울 방법이 필요하다.

### 8.3 해결책 비교

| 방법 | 내용 | 비용 | 판정 |
|---|---|---|---|
| **A. pointwise 루프 순서 교체** | `pix_cnt`를 middle, `oc_cnt`를 outer로 | 카운터 중첩 한 곳 + `oc_addr`/`pix_addr` prefetch 로직 | **채택** |
| **B. transpose 버퍼** | 출력 전체를 버퍼링 | 384×196×16b = 1.2 Mbit → BRAM36 약 34개 (7020의 24%) | 기각 |
| **C. 채널 단위 ping-pong** | A와 함께. 196워드 ×2 | BRAM18 1개 | **채택** |

B가 불가피해 보이지만 아니다. pixel-major에서는 ch0의 196개를 모으려면 전체
75,264개가 다 나와야 해서 부분 버퍼링이 성립하지 않는다.

A는 오히려 이득이 있다. weight가 196클럭 동안 고정되므로 **weight read가
75,264회 → 384회로 줄어든다.** read 총량은 그대로다.

### 8.4 목표 구성

```text
pointwise (루프 순서 A로 변경)
    │  oc0: pix0..195,  oc1: pix0..195, ...
    ▼
BN + ReLU6                        ← SPEC §1 의 단계. 아직 미구현
    │
    ▼
ping-pong buffer 196 × 2          ← BRAM18 1개, 레이트 차 흡수
    │  1픽셀/클럭. 더미 슬롯에선 읽지 않음
    ▼
depth_mac
```

C를 두면 depthwise가 더미 슬롯에서 쉬어도 pointwise가 막히지 않으므로
`depth_mac`에 `en` 포트가 필요 없다 (§9의 stall 항목과 연결).

### 8.5 지금 할 일은 아니다

`depth_mac` 단독 검증(§5.3)이 먼저다. 다만 **나중에 발견하면 두 모듈을 동시에
고쳐야 하므로** 여기 기록해 둔다.

---

## 9. 열린 질문

- [ ] `max|K'|` 실측 → 고정소수점 Q 포맷과 `F` 확정 (SPEC §11)
- [ ] IFM BRAM latency 1인지 2인지 (output register 사용 여부)
- [ ] 방식 2의 순수 추가 전력 이득이 측정 가능한 수준인가
- [ ] DSP 9개 cascade(PCOUT→PCIN)로 갈지 — 가면 systolic skew 때문에 파형에 완성된 window가 사라짐. golden 통과 후로 미룸
- [ ] 채널 전환 시 weight prefetch를 이전 채널과 겹칠지
- [ ] stall이 생길 가능성 — §8.4의 ping-pong을 두면 불필요. 안 두면 `en` 포트 필요
- [ ] pointwise 루프 순서 교체(§8.3 A) 시 `oc_addr`/`pix_addr` prefetch 로직도 같이 뒤집어야 함 — 회귀 테스트 필요
- [ ] pointwise 출력 포맷과 depthwise 입력 포맷을 같은 Q 포맷으로 맞출 것
- [ ] BN + ReLU6를 pointwise 뒤에 붙일지 depthwise 앞에 붙일지 (같은 자리지만 모듈 소속 결정 필요)

---

## 10. 참고

- 설계 문서: [SPEC_depthwise_hw.md](SPEC_depthwise_hw.md)
- 참조 C 구현: `../../week1/06_26/MobileNet/layer08/layer8.c`
- golden 주의: `mobilenetv2_result_layer08.bin`은 블록 최종 결과다.
  depthwise 단독 비교용 중간 golden을 따로 만들어야 한다 (SPEC §14.3).
