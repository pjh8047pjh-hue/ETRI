# MobileNetV2 Layer 8 — Depthwise 3×3 하드웨어 설계 비교안

> **목적**: MobileNetV2 Layer 8의 depthwise 3×3 연산을 이해하고,
> **재사용·switching 감소 관점**과 **고정 연결·routing 관점**을 함께 비교하여
> RTL 데이터플로를 결정할 수 있도록 연산식, 주소 이동, zero padding, 버퍼 구조 및
> 기준 클럭 수를 정리한다.
>
> **현재 범위**: Depthwise 3×3, stride 1, padding 1, 384채널, 14×14
>
> **후속 연산**: Depthwise 결과에 BN + ReLU6 적용
>
> **설계 상태**: serpentine + circular window는 재사용을 우선한 **후보 A**이며 확정안이 아니다.
> 매 출력마다 3×3을 다시 읽는 단순 구조와 고정 방향 shift 구조를 함께 합성·비교한다.

---

## §0. 설계 후보 요약

모든 후보는 MAC 1개를 재사용하여 출력 하나를 9 tap에 계산하는 조건을 공유한다.
차이는 IFM 값을 어떻게 공급하고 window를 어떻게 유지하는지에 있다.

| 후보 | 핵심 구조 | 우선하는 목표 |
|---|---|---|
| **A. Circular serpentine** | 인접 방향으로만 이동하며 기존 6개 유지, 새 값 3개 write | IFM read와 register switching 감소 |
| **B. 매번 3×3 재계산** | 출력마다 IFM BRAM에서 9개 tap을 순서대로 읽음 | 가장 단순하고 고정된 routing |
| **C. 고정 방향 shift** | 모든 행을 왼쪽→오른쪽으로 처리하고 행 안에서만 6개 재사용 | 재사용과 규칙적인 routing의 절충 |

후보 A의 세부 구조는 다음과 같다.

| 항목 | 후보 A: circular serpentine |
|---|---|
| 연산기 | MAC 1개 재사용 |
| 출력 하나의 연산 시간 | 9 MAC cycle |
| 출력 순회 | 행마다 방향이 바뀌는 serpentine 방식 |
| Window 저장 | 3×3 register 9개 |
| Window 이동 | 데이터를 복사하지 않는 circular row/column pointer |
| 다음 데이터 준비 | 현재 9 MAC cycle 동안 새 행 또는 열 3개 prefetch |
| Zero padding | 전체 주소 범위 검사가 아니라 이동 방향과 행·열 counter로 3개 입력만 제어 |
| 재사용 데이터 | 이동할 때 겹치는 6개 값은 write하지 않음 |
| 출력 저장 순서 | CHW 유지, 홀수 행은 주소가 감소하는 방향으로 write |

후보 A의 핵심 데이터패스는 다음과 같다.

```text
IFM BRAM ── 새 값 최대 3개 ──▶ incoming[0:2]
                                  │
                                  ▼
                 ┌───────────────────────────────┐
                 │ circular 3×3 window           │
                 │                               │
                 │ 기존 6개: 유지, write 없음    │
                 │ 새 3개: expired 행/열에 write │
                 └──────────────┬────────────────┘
                                │ tap_cnt로 1개 선택
                                ▼
                       weight × window
                                │
                                ▼
                            accumulator
                                │
                                ▼
                         BN fold + ReLU6
                                │
                                ▼
                            OFM BRAM
```

---

## §1. Layer 8에서의 위치와 크기

MobileNetV2 Layer 8의 전체 흐름은 다음과 같다.

```text
입력 [64][14][14]
    ↓
Expand pointwise 1×1: 64 → 384
    ↓
BN + ReLU6
    ↓
Depthwise 3×3: 384 → 384, stride=1, padding=1  ← 이 문서의 범위
    ↓
BN + ReLU6
    ↓
Project pointwise 1×1: 384 → 64
    ↓
BN + Residual add
```

프로젝트의 참조 구현은 [../layer8.c](../layer8.c)의 `layer8_reference`와
`layer8_optimized`에 있다.

| 항목 | 값 |
|---|---:|
| 입력 채널 | 384 |
| 출력 채널 | 384 |
| 입력 공간 크기 | 14×14 |
| 출력 공간 크기 | 14×14 |
| Kernel | 3×3 |
| Stride | 1 |
| Padding | 1 |
| 채널별 weight | 9개 |
| 전체 weight | 384×9 = 3,456개 |
| 전체 출력 | 384×14×14 = 75,264개 |

사용되는 파라미터 배열은 다음과 같다.

```c
features_8_conv_1_0_weight[3456]       // Depthwise 3×3 weight
features_8_conv_1_1_weight[384]        // BN gamma
features_8_conv_1_1_bias[384]          // BN beta
features_8_conv_1_1_running_mean[384]  // BN mean
features_8_conv_1_1_running_var[384]   // BN variance
```

Depthwise weight 주소는 다음과 같다.

```text
weight_addr = channel × 9 + kh × 3 + kw
```

---

## §2. Depthwise 연산식

입력을 `X`, weight를 `K`, depthwise convolution 결과를 `D`라고 하면:

\[
D[ch,r,x]
=
\sum_{i=0}^{2}\sum_{j=0}^{2}
X_{pad}[ch,r+i,x+j]\cdot K[ch,i,j]
\]

여기서 `Xpad`는 입력 `X`의 바깥쪽 한 줄을 0으로 본 논리적인 padded 입력이다.

원본 좌표로 표현하면:

\[
D[ch,r,x]
=
\sum_{i=0}^{2}\sum_{j=0}^{2}
X[ch,r+i-1,x+j-1]\cdot K[ch,i,j]
\]

입력 좌표가 `0~13` 범위를 벗어나면 해당 값은 0이다.

### 2.1 일반 convolution과 차이

Depthwise convolution에는 입력 채널 방향 합산이 없다.

```text
입력 channel 0 ── kernel 0 ── 출력 channel 0
입력 channel 1 ── kernel 1 ── 출력 channel 1
...
입력 channel 383 ─ kernel 383 ─ 출력 channel 383
```

따라서 채널마다 완전히 독립적으로 처리할 수 있다.

### 2.2 Kernel 방향

딥러닝 프레임워크의 convolution은 일반적으로 kernel을 뒤집지 않는
cross-correlation 방식이다. RTL에서도 참조 C 코드와 동일하게 다음 순서로 곱한다.

```text
window[0] × weight[0]
window[1] × weight[1]
...
window[8] × weight[8]
```

Kernel을 상하 또는 좌우로 뒤집으면 golden과 일치하지 않는다.

---

## §3. 연산량과 기준 클럭 수

한 출력 픽셀은 3×3 내적이므로 9 MAC이 필요하다.

\[
MAC_{output}=3\times3=9
\]

채널 하나의 출력은 14×14이므로:

\[
MAC_{channel}=14\times14\times9=1,764
\]

전체 384채널은:

\[
MAC_{total}=384\times14\times14\times9=677,376
\]

MAC 하나가 매 cycle 한 tap을 처리한다고 가정하면:

| 범위 | 기준 클럭 |
|---|---:|
| 출력 1개 | 9 clk |
| 출력 한 행 | 14×9 = 126 clk |
| 채널 1개 | 14×126 = 1,764 clk |
| 384채널 | 677,376 clk |

위 수치는 순수 MAC cycle이다. 다음 항목은 별도 초기 또는 pipeline 지연이 될 수 있다.

- 첫 3×3 window load
- 채널별 weight 9개 load
- 동기식 BRAM read latency
- multiplier/adder pipeline latency
- BN/ReLU6 및 OFM write latency

정상상태에서 다음 window를 현재 9 MAC cycle 동안 prefetch하면 window 이동 때문에
추가되는 stall은 제거할 수 있다.

---

## §4. 후보 A에서 serpentine 순회를 사용하는 이유

일반적인 row-major 순서는 한 행이 끝날 때 다음과 같이 큰 위치 이동이 발생한다.

```text
(0,0) → ... → (0,13)
                  ↓ 왼쪽 끝으로 복귀
(1,0) → ...
```

`(0,13) → (1,0)`은 3×3 window가 인접한 한 칸 이동이 아니므로 3×3 register만으로
겹치는 6개 값을 바로 재사용하기 어렵다.

재사용을 우선하는 후보 A에서는 행마다 방향을 반대로 바꾸는 serpentine 순회를 사용한다.

```text
row 0 : (0,0) → (0,1) → ... → (0,13)
                                      ↓
row 1 : (1,0) ← (1,1) ← ... ← (1,13)
          ↓
row 2 : (2,0) → (2,1) → ... → (2,13)
                                      ↓
row 3 :                         ← ...
```

따라서 모든 window 이동은 다음 세 종류뿐이다.

```text
RIGHT : 오른쪽 한 칸
LEFT  : 왼쪽 한 칸
DOWN  : 아래 한 칸
```

어떤 이동에서도 이전 window와 다음 window는 6개 값을 공유하고, 새 값은 3개뿐이다.

### 4.1 이동 제어

```text
짝수 출력 행: col 0 → 13
홀수 출력 행: col 13 → 0
```

개념적인 next-position 제어는 다음과 같다.

```verilog
if (direction == RIGHT) begin
    if (col_cnt < 13) begin
        move = RIGHT;
        next_row = row_cnt;
        next_col = col_cnt + 1;
    end
    else begin
        move = DOWN;
        next_row = row_cnt + 1;
        next_col = col_cnt;
        next_direction = LEFT;
    end
end
else begin
    if (col_cnt > 0) begin
        move = LEFT;
        next_row = row_cnt;
        next_col = col_cnt - 1;
    end
    else begin
        move = DOWN;
        next_row = row_cnt + 1;
        next_col = col_cnt;
        next_direction = RIGHT;
    end
end
```

마지막 출력은 `(13,0)`이다. 마지막 행은 홀수 행이므로 오른쪽에서 왼쪽으로 처리된다.

---

## §5. 논리적인 padded 주소 수식

Padding을 포함한 논리적 공간은 16×16이다. 실제 16×16 buffer를 만들 필요는 없으며,
주소 관계를 설명하기 위한 좌표계로만 사용한다.

현재 출력 위치를 `(r,x)`라고 하면 3×3 window의 padded top-left 주소는:

\[
A=16r+x
\]

Window의 논리 주소는:

\[
P(i,j)=A+16i+j
\]

즉:

```text
[ A       A+1     A+2  ]
[ A+16    A+17    A+18 ]
[ A+32    A+33    A+34 ]
```

예를 들어 `A=13`이면:

```text
[13 14 15]
[29 30 31]
[45 46 47]
```

아래로 한 칸 이동하면:

\[
A_{next}=A+16=29
\]

```text
[29 30 31]
[45 46 47]
[61 62 63]
```

이동 방향에 따른 논리 주소 수식은 다음 세 개로 고정된다.

\[
A_{next}=
\begin{cases}
A+1  & RIGHT\\
A-1  & LEFT\\
A+16 & DOWN
\end{cases}
\]

---

## §6. Circular 3×3 window

### 6.1 물리 저장소

Window 값은 다음 9개 register에 저장한다.

```text
Physical row 0: P00 P01 P02
Physical row 1: P10 P11 P12
Physical row 2: P20 P21 P22
```

데이터를 실제로 shift하지 않고 다음 pointer를 둔다.

```text
row_base: 논리적인 top 행이 들어 있는 physical row
col_base: 논리적인 left 열이 들어 있는 physical column
```

논리 window 위치 `(i,j)`의 물리 위치는:

\[
physical\_row=(row\_base+i)\bmod3
\]

\[
physical\_col=(col\_base+j)\bmod3
\]

RTL에서는 `% 3` 연산기를 만들지 않고 다음 wrap 함수를 사용한다.

```verilog
function automatic [1:0] inc3(input [1:0] value);
    inc3 = (value == 2) ? 0 : value + 1;
endfunction

function automatic [1:0] dec3(input [1:0] value);
    dec3 = (value == 0) ? 2 : value - 1;
endfunction
```

논리→물리 매핑은 세 상태뿐이다.

| base | 논리 0 | 논리 1 | 논리 2 |
|---:|---:|---:|---:|
| 0 | physical 0 | physical 1 | physical 2 |
| 1 | physical 1 | physical 2 | physical 0 |
| 2 | physical 2 | physical 0 | physical 1 |

### 6.2 오른쪽 이동

```text
현재                     다음

a b c                    b c j
d e f        →           e f k
g h i                    h i l
```

기존 논리 left column의 물리 위치는 `col_base`다. 이 위치는 다음 window에서
필요 없으므로 새 right column을 덮어쓴다.

```text
write physical column = col_base
col_base_next          = inc3(col_base)
```

새 column의 세 값을 쓰는 정확한 물리 위치는 다음과 같다.

\[
window\_phys[add3(row\_base,i)][col\_base]\leftarrow incoming[i],
\quad i=0,1,2
\]

여기서 `add3(base,i)`는 §6.1의 3상태 논리→물리 매핑이다. Commit이 끝난 뒤에만
`col_base`를 `inc3(col_base)`로 변경한다.

### 6.3 왼쪽 이동

```text
현재                     다음

a b c                    j a b
d e f        →           k d e
g h i                    l g h
```

기존 논리 right column의 물리 위치에 새 left column을 쓴다.

```text
write physical column = dec3(col_base)
col_base_next          = dec3(col_base)
```

`new_col = dec3(col_base)`라고 하면 물리 write 위치는 다음과 같다.

\[
window\_phys[add3(row\_base,i)][new\_col]\leftarrow incoming[i],
\quad i=0,1,2
\]

Commit 후 `col_base`에 `new_col`을 저장하면 이 물리 column이 새로운 logical left가 된다.

### 6.4 아래 이동

```text
현재                     다음

a b c                    d e f
d e f        →           g h i
g h i                    j k l
```

기존 논리 top row의 물리 위치는 `row_base`다. 이 위치에 새 bottom row를 쓴다.

```text
write physical row = row_base
row_base_next       = inc3(row_base)
```

새 row의 세 값을 쓰는 물리 위치는 다음과 같다.

\[
window\_phys[row\_base][add3(col\_base,j)]\leftarrow incoming[j],
\quad j=0,1,2
\]

Commit이 끝난 뒤 `row_base`를 `inc3(row_base)`로 변경하면 기존 middle과 bottom은
logical top과 middle이 되고, 방금 쓴 physical row는 logical bottom이 된다.

### 6.5 이동별 write 위치 요약

| 이동 | 폐기되는 물리 영역 | 새 값 write 위치 | Pointer 갱신 |
|---|---|---|---|
| RIGHT | 기존 logical left column | `[add3(row_base,i)][col_base]` | `col_base=inc3(col_base)` |
| LEFT | 기존 logical right column | `[add3(row_base,i)][dec3(col_base)]` | `col_base=dec3(col_base)` |
| DOWN | 기존 logical top row | `[row_base][add3(col_base,j)]` | `row_base=inc3(row_base)` |

### 6.6 사용자 예시를 물리 bank로 표현

이동 전:

```text
Bank 0 = [13 14 15]  ← row_base
Bank 1 = [29 30 31]
Bank 2 = [45 46 47]
```

새 bottom 값만 기존 Bank 0에 쓴다.

```text
Bank 0 = [61 62 63]
Bank 1 = [29 30 31]
Bank 2 = [45 46 47]
```

`row_base`를 0에서 1로 바꾸면 논리적인 순서는 다음과 같다.

```text
Bank 1 = [29 30 31]  ← logical top
Bank 2 = [45 46 47]  ← logical middle
Bank 0 = [61 62 63]  ← logical bottom
```

6개 값을 복사하지 않고 새 값 3개와 작은 pointer만 변경된다.

---

## §7. Shift-count 기반 zero padding

### 7.1 기본 방침

다음 방식은 사용하지 않는다.

```text
9개 tap 각각에 대해:
    입력 행 계산
    입력 열 계산
    범위 비교
    주소 생성
    0/data 선택
```

현재 구조에서는 이동할 때 새로 들어오는 값이 항상 3개이므로, `row_cnt`, `col_cnt`,
`move`로 이 3개만 zero 또는 BRAM 데이터로 결정한다.

```text
기존 6개: write enable = 0
새 3개:   zero mask에 따라 0 또는 BRAM 데이터 write
```

### 7.2 초기 window

첫 출력 `(0,0)`의 window는 다음과 같다.

```text
0    0    0
0   X00  X01
0   X10  X11
```

Window index를 다음처럼 정의하면:

```text
0 1 2
3 4 5
6 7 8
```

초기 zero 위치는 `0, 1, 2, 3, 6`이다. 실제 IFM에서 읽을 값은 4개뿐이다.

### 7.3 RIGHT 이동의 zero 수식

현재 출력 위치 `(r,x)`에서 오른쪽으로 움직이면 새로 들어오는 padded column은
`x+3`이다.

```text
incoming[0] = Xpad[r    ][x+3]
incoming[1] = Xpad[r+1  ][x+3]
incoming[2] = Xpad[r+2  ][x+3]
```

`i=0,1,2`에 대해:

\[
Z_R(i)=
[x=12]
\lor([r=0]\land[i=0])
\lor([r=13]\land[i=2])
\]

RTL 형태는 다음과 같다.

```verilog
right_pad = (col_cnt == 12);

zero_new[0] = right_pad || (row_cnt == 0);
zero_new[1] = right_pad;
zero_new[2] = right_pad || (row_cnt == 13);
```

`col_cnt=12`에서 오른쪽으로 이동하면 다음 출력은 13번 열이며, 새로 들어오는
오른쪽 column은 padding이므로 세 값이 모두 0이다.

### 7.4 LEFT 이동의 zero 수식

왼쪽으로 움직이면 새로 들어오는 padded column은 `x-1`이다.

```text
incoming[0] = Xpad[r    ][x-1]
incoming[1] = Xpad[r+1  ][x-1]
incoming[2] = Xpad[r+2  ][x-1]
```

\[
Z_L(i)=
[x=1]
\lor([r=0]\land[i=0])
\lor([r=13]\land[i=2])
\]

```verilog
left_pad = (col_cnt == 1);

zero_new[0] = left_pad || (row_cnt == 0);
zero_new[1] = left_pad;
zero_new[2] = left_pad || (row_cnt == 13);
```

### 7.5 DOWN 이동의 zero 수식

아래로 움직이면 새로 들어오는 padded row는 `r+3`이다.

```text
incoming[0] = Xpad[r+3][x    ]
incoming[1] = Xpad[r+3][x+1  ]
incoming[2] = Xpad[r+3][x+2  ]
```

`j=0,1,2`에 대해:

\[
Z_D(j)=
[r=12]
\lor([x=0]\land[j=0])
\lor([x=13]\land[j=2])
\]

```verilog
bottom_pad = (row_cnt == 12);

zero_new[0] = bottom_pad || (col_cnt == 0);
zero_new[1] = bottom_pad;
zero_new[2] = bottom_pad || (col_cnt == 13);
```

### 7.6 조건문과 실제 하드웨어

Verilog의 `if` 또는 `case`는 소프트웨어 branch가 아니라 comparator와 mux로 합성된다.
따라서 조건문을 전혀 없애는 것이 목적은 아니다.

현재 구조의 목적은 다음과 같다.

```text
기존 방식: 9개 데이터 경로마다 주소 계산 + 경계 비교 + zero mux
현재 방식: 4-bit counter 비교 + 새 데이터 3개에만 zero mux
```

`row_cnt`, `col_cnt`는 4비트이고 비교 상수도 `0, 1, 12, 13`으로 고정되어 있으므로
제어 로직이 작다. Pointer는 3상태 one-hot으로 구현할 수도 있다.

---

## §8. MAC과 prefetch의 동시 동작

현재 window를 MAC이 사용하는 동안 기존 값을 덮어쓰면 안 된다. 따라서 새 데이터는
먼저 작은 staging register에 저장한다.

```verilog
logic signed [DATA_W-1:0] incoming [0:2];
```

개념적인 타이밍은 다음과 같다.

```text
tap cycle 0: current window[0] MAC, incoming read 0 요청
tap cycle 1: current window[1] MAC, incoming read 0 저장, read 1 요청
tap cycle 2: current window[2] MAC, incoming read 1 저장, read 2 요청
tap cycle 3: current window[3] MAC, incoming read 2 저장
...
tap cycle 8: current window[8] MAC 완료
             expired physical row/column에 incoming 3개 commit
             row_base 또는 col_base 회전
             output 위치 counter 갱신
```

Padding 값은 BRAM read를 요청하지 않고 `incoming`에 0을 기록한다. 동기식 BRAM의
read latency가 1 cycle보다 크면 요청 시점과 `incoming` destination을 같은 latency만큼
지연해야 한다.

Window register가 9개뿐이므로 expired 행 또는 열의 3개 register를 같은 edge에서
동시에 갱신하는 구조가 단순하다.

### 8.1 Tap 선택

MAC 하나는 매 cycle 논리적인 tap 하나를 읽는다.

```text
tap_cnt 0 → logical (0,0)
tap_cnt 1 → logical (0,1)
tap_cnt 2 → logical (0,2)
tap_cnt 3 → logical (1,0)
...
tap_cnt 8 → logical (2,2)
```

물리 위치는 `row_base`, `col_base`와 §6의 3상태 매핑으로 선택한다. MAC이 하나이므로
매 cycle 필요한 데이터는 하나이며, 9개 병렬 MAC 입력을 모두 라우팅할 필요가 없다.

---

## §9. 제어 counter와 상태

### 9.1 필요한 주요 register

| 이름 | 범위/폭 | 의미 |
|---|---:|---|
| `channel_cnt` | 0~383, 9 bit | 현재 depthwise 채널 |
| `row_cnt` | 0~13, 4 bit | 현재 출력 행 |
| `col_cnt` | 0~13, 4 bit | 현재 출력 열 |
| `tap_cnt` | 0~8, 4 bit | 현재 3×3 MAC tap |
| `direction` | 1 bit | RIGHT 또는 LEFT |
| `row_base` | 0~2, 2 bit/one-hot | logical top의 physical row |
| `col_base` | 0~2, 2 bit/one-hot | logical left의 physical column |
| `acc` | 설계 포맷에 따라 결정 | 9 MAC 누산 결과 |

### 9.2 Counter 갱신 조건

Counter는 전체 clock 수에 따라 자유롭게 증가하면 안 된다. BRAM stall 또는 pipeline
stall이 발생해도 window 위치가 어긋나지 않도록 실제 연산 진행 enable에만 반응해야 한다.

```verilog
if (compute_enable) begin
    if (tap_cnt == 8) begin
        tap_cnt <= 0;
        // window commit + 출력 위치 이동
    end
    else begin
        tap_cnt <= tap_cnt + 1;
    end
end
```

즉 이 문서에서 말하는 shift count는 전체 `clk` 수가 아니라 실제 window 이동 횟수다.

### 9.3 권장 FSM 초안

| 상태 | 동작 |
|---|---|
| `IDLE` | start 대기, counter 초기화 |
| `LOAD_WEIGHT` | 현재 채널 weight 9개 register에 load |
| `INIT_WINDOW` | `(0,0)` window의 4개 IFM 값과 5개 zero 준비 |
| `MAC_PREFETCH` | 9 tap MAC과 다음 incoming 3개 prefetch 병행 |
| `COMMIT_WRITE` | 결과 write, incoming commit, circular pointer 회전 |
| `NEXT_CHANNEL` | 다음 채널 준비 또는 DONE |
| `DONE` | 전체 384채널 완료 알림 |

`COMMIT_WRITE`는 타이밍이 허용되면 `tap_cnt=8` cycle과 합칠 수 있다.

---

## §10. 출력 주소

출력 메모리 포맷은 기존 C 골든과 동일한 CHW 순서를 유지한다.

\[
ofm\_addr=channel\times196+row\times14+col
\]

Serpentine 순회 때문에 홀수 출력 행에서는 write 주소가 감소한다.

```text
row 0:  0, 1, 2, ..., 13
row 1: 27, 26, 25, ..., 14
row 2: 28, 29, 30, ..., 41
...
```

연산 순서만 바뀌며 최종 메모리 배열은 여전히 CHW이므로 C 골든과 그대로 비교할 수 있다.

---

## §11. BN folding과 ReLU6

Depthwise convolution 다음에는 채널별 BN과 ReLU6가 있다.

\[
y=\gamma\frac{x-\mu}{\sqrt{var+\epsilon}}+\beta
\]

추론에서는 다음 상수를 미리 계산할 수 있다.

\[
scale[ch]=\frac{\gamma[ch]}{\sqrt{var[ch]+\epsilon}}
\]

\[
shift[ch]=\beta[ch]-\mu[ch]\cdot scale[ch]
\]

실행 중 BN은 다음 affine 연산이 된다.

\[
y=acc\cdot scale[ch]+shift[ch]
\]

더 나아가 scale을 depthwise weight에 미리 반영할 수 있다.

\[
K'[ch,i,j]=K[ch,i,j]\cdot scale[ch]
\]

\[
y=\sum X\cdot K'+shift[ch]
\]

이 방식을 사용하면 accumulator를 `shift[ch]`에 해당하는 bias로 초기화하거나 마지막에
bias를 더한 후 ReLU6만 적용할 수 있다.

```text
y < 0 → 0
y > 6 → 6
그 외 → y
```

고정소수점 포맷과 rounding/saturation 위치는 실제 weight와 중간값 범위를 측정한 후
별도로 확정해야 한다.

---

## §12. 전력 및 라우팅 관점

동일한 연산이라도 데이터 재사용만 많이 한다고 항상 더 좋은 하드웨어가 되는 것은 아니다.
재사용 구조는 switching을 줄일 수 있지만, 논리 위치가 바뀌는 구조는 mux와 배선을 늘릴 수
있다. 두 측면을 함께 비교해야 한다.

### 12.1 측면 1 — 재사용과 switching 감소

동적 전력은 대략 다음 관계를 가진다.

\[
P_{dynamic}\approx\alpha C V^2 f
\]

후보 A의 circular window에서 switching을 줄이는 부분은 다음과 같다.

- 겹치는 6개 window 값을 다른 register로 복사하지 않음
- 기존 6개 register의 write enable을 끔
- 새로 들어오는 행 또는 열 3개만 write
- Padding 위치에서는 IFM BRAM read enable을 끄고 0 생성
- 동일 채널의 weight 9개를 register에 유지하여 196개 출력에서 재사용
- 일반 주소 범위 계산 대신 작은 counter equality 비교 사용

Window가 오른쪽으로 이동하는 예는 다음과 같다.

```text
현재                     다음

a b c                    b c j
d e f        →           e f k
g h i                    h i l
```

Circular 구조는 `b,c,e,f,h,i`를 다른 register로 복사하지 않는다. 기존 논리 left가
사용하던 물리 column에 `j,k,l`만 쓰고 `col_base`를 회전한다.

```text
Window register write: 3개
새 IFM 값:              최대 3개
재사용 값:              6개, write enable=0
```

따라서 register data switching과 IFM BRAM read 수를 줄일 가능성이 있다. Padding 위치는
BRAM을 읽지 않고 0을 발생시킬 수 있다.

### 12.2 측면 2 — 고정 연결과 routing

FPGA의 물리 배선은 실행 중에 변경되지 않는다. RTL에서 `row_base`, `col_base`를 바꾸어
logical 위치를 회전시키더라도 실제 FPGA가 register 사이 배선을 다시 연결하는 것은 아니다.
합성기는 가능한 연결을 모두 만든 뒤 mux와 decoder로 하나를 선택한다.

Circular 구조의 논리식은 간단하다.

\[
physical\_row=(row\_base+i)\bmod3
\]

\[
physical\_col=(col\_base+j)\bmod3
\]

그러나 실제 회로에는 다음 선택망이 생긴다.

```text
P00 ─┐
P01 ─┼──────▶ logical-to-physical mux ──▶ MAC
P02 ─┤                     ▲
P10 ─┤                     │
...  │              row_base, col_base
P22 ─┘

incoming[0:2] ──▶ write decoder ──▶ 선택된 physical row/column
```

발생할 수 있는 비용은 다음과 같다.

- Logical tap을 physical register에 매핑하는 read mux
- 새 값 3개를 9개 physical register 중 선택된 위치로 보내는 write routing
- RIGHT, LEFT, DOWN 세 동작을 지원하는 write enable decoder
- `row_base`, `col_base`, 이동 제어 신호의 fan-out
- 데이터 폭만큼 반복되는 mux와 긴 배선

특히 병렬 MAC 수가 늘어나면 logical-to-physical 선택망도 여러 개 필요해져 routing과 timing
문제가 커질 수 있다. MAC 하나만 사용할 때는 mux 하나를 공유할 수 있으므로 영향이 작을 수
있지만, 합성 결과를 확인하지 않고 circular 구조가 더 낫다고 단정할 수 없다.

### 12.3 후보 B — 매 출력마다 3×3을 처음부터 읽는 구조

후보 B는 window register 사이의 연결 자체를 제거하고, 각 출력에서 9개 tap을 IFM BRAM에서
다시 읽는다.

```text
IFM BRAM ──▶ padding zero 선택 ──▶ multiplier ──▶ accumulator
WROM      ───────────────────────▶ multiplier
```

```text
tap 0: IFM 주소 0 읽기 × weight 0
tap 1: IFM 주소 1 읽기 × weight 1
...
tap 8: IFM 주소 8 읽기 × weight 8
```

장점:

- Register 간 window 이동 routing이 없음
- BRAM→MAC 데이터 경로가 한 개로 고정
- `tap_cnt`와 주소 발생기만 필요
- 기능 검증과 timing closure가 가장 단순

단점:

- 출력마다 최대 9회 IFM read
- 겹치는 입력을 이웃 출력에서 다시 읽음
- BRAM switching과 read energy가 증가할 수 있음

MAC 하나가 한 cycle에 한 tap을 처리하는 현재 조건에서는 BRAM read를 MAC cycle과 직접
맞출 수 있으므로 재사용하지 않아도 순수 연산 시간은 여전히 출력당 9 MAC cycle이다.
실제 cycle은 BRAM 및 MAC pipeline latency에 따라 결정한다.

### 12.4 후보 C — 고정 방향 shift 절충안

후보 C는 모든 출력 행을 왼쪽에서 오른쪽으로만 처리한다.

```text
row 0: (0,0) → ... → (0,13)
row 1: (1,0) → ... → (1,13)
...
```

행 내부의 window 연결은 항상 동일하다.

```text
W00 ← W01 ← W02 ← new_top
W10 ← W11 ← W12 ← new_middle
W20 ← W21 ← W22 ← new_bottom
```

각 register의 source가 고정되므로 합성기는 짧고 규칙적인 이웃 연결을 만들 수 있다.

```text
W01.Q ──▶ W00.D
W02.Q ──▶ W01.D
new0  ──▶ W02.D
```

행이 끝난 뒤 `(r,13) → (r+1,0)`에서는 다음 행의 첫 window를 다시 구성한다. 이 구간에서
추가 load cycle이 생길 수 있지만, 행 안에서는 새 오른쪽 열 3개만 읽으며 6개를 재사용한다.

장점:

- 행 내부 IFM 재사용
- RIGHT 한 방향만 지원하므로 연결이 규칙적
- Circular pointer와 양방향 data mux가 불필요
- Place-and-route 및 timing 예측이 비교적 쉬움

단점:

- 행이 바뀔 때 첫 window 재구성 필요
- Window를 물리적으로 shift하므로 겹치는 6개 register도 clock/write activity가 발생
- 재구성을 현재 연산과 겹치지 못하면 추가 cycle 발생

### 12.5 세 후보 비교

| 비교 항목 | A. Circular serpentine | B. 매번 3×3 재계산 | C. 고정 방향 shift |
|---|---|---|---|
| 출력당 기본 MAC | 9 | 9 | 9 |
| 정상상태 새 IFM read | 최대 3개 | 최대 9개 | 최대 3개 |
| 겹치는 6개 register write | 없음 | Window register 없음 | 있음 |
| Register 간 연결 | 동적 논리 매핑 | 거의 없음 | 고정 이웃 연결 |
| Read mux/write decoder | 가장 복잡 | 가장 단순 | 단순 |
| 행 전환 | DOWN으로 연속 처리 | 주소만 변경 | 첫 window 재구성 |
| 출력 순서 | 홀수 행 역방향 | 자유롭게 선택 가능 | 모든 행 정방향 |
| Routing 위험 | 상대적으로 큼 | 가장 작음 | 작음 |
| 예상 용도 | 재사용·저전력 실험 | 첫 기능 검증 RTL | 현실적인 절충안 |

### 12.6 전력식으로 본 trade-off

\[
P_{dynamic}\approx\alpha C V^2 f
\]

두 측면은 다음처럼 서로 반대 방향으로 작용할 수 있다.

```text
Circular reuse:
  switching activity α 감소 가능
  mux와 긴 routing 때문에 capacitance C 증가 가능

고정 연결/재계산:
  BRAM read 또는 register shift로 α 증가 가능
  단순하고 짧은 routing으로 C 감소 가능
```

따라서 register write 개수만 세어서 전력을 판단하면 안 된다. Clock frequency, 배치 결과,
fan-out, BRAM enable activity 및 실제 입력 데이터의 toggle까지 포함해야 한다.

### 12.7 구현 및 비교 권장 순서

현재 단계에서는 다음 순서가 안전하다.

1. 후보 B로 depthwise 연산과 golden을 먼저 검증한다.
2. 후보 C를 구현하여 고정 shift 재사용 효과와 추가 행 전환 cycle을 측정한다.
3. 전력 또는 BRAM bandwidth가 실제 병목일 때 후보 A를 추가 비교한다.
4. 동일한 clock constraint와 동일한 switching activity로 세 구조를 비교한다.

비교할 Vivado 지표:

| 종류 | 지표 |
|---|---|
| 자원 | LUT, FF, BRAM, DSP |
| Timing | WNS, Fmax, critical path |
| 성능 | 채널당 cycle, 전체 latency |
| 전력 | Dynamic power, BRAM power, signal/logic power |
| 배선 | High-fanout net, routing congestion |

현재의 잠정 권장은 **후보 B로 기능을 먼저 확정한 뒤 후보 C를 구현하는 것**이다.
후보 A는 재사용 우선 비교안으로 유지하며, 합성·배치 결과가 개선될 때만 채택한다.

FPGA에서는 fabric logic으로 clock을 직접 gating하지 않고 register/BRAM의 clock enable 또는
write enable을 사용한다.

```verilog
if (window_commit && write_this_slot)
    window_phys[write_index] <= incoming_data;
```

`else window_phys <= window_phys`와 같은 명시적인 self-assignment는 필요 없다.

어떤 후보를 선택하더라도 조건문의 개수만으로 결과를 판단하지 않는다. 실제 절감량은 구현 후
SAIF/VCD switching activity를 사용한 Vivado power report로 확인해야 한다.

---

## §13. 구현 시 주의사항

아래 1~4번은 후보 A의 circular serpentine 구조를 선택할 때 적용한다. 후보 B 또는 C를
선택하면 해당 데이터플로에 맞게 FSM과 window load 규칙을 다시 정의한다.

1. **Serpentine 방향**
   - 짝수 행은 RIGHT, 홀수 행은 LEFT다.
   - DOWN 후 반드시 방향을 반전한다.

2. **마지막 출력 위치**
   - 마지막 행 `row=13`은 홀수이므로 마지막 위치는 `(13,0)`이다.

3. **Pointer update 순서**
   - 현재 MAC이 끝나기 전에 expired 물리 행/열을 덮어쓰면 안 된다.
   - `incoming` staging register에 먼저 받은 후 commit과 pointer 회전을 수행한다.

4. **동기식 BRAM latency**
   - read 요청의 valid, zero 여부, incoming destination을 BRAM latency만큼 지연한다.

5. **Padding에서 BRAM 주소**
   - Padding이면 BRAM enable을 끄거나 안전한 주소를 제시하고 반환 데이터는 사용하지 않는다.

6. **Weight 순서**
   - `weight[ch*9 + i*3 + j]` 순서를 유지한다.
   - Kernel을 뒤집지 않는다.

7. **출력 순서**
   - 홀수 행의 연산은 역방향이지만 OFM 주소는 `row*14+col`에 저장한다.

8. **Accumulator 초기화**
   - 출력 위치가 바뀔 때 정확히 한 번 초기화한다.
   - BN-fold bias를 accumulator 초기값으로 사용할지 별도로 확정한다.

---

## §14. 검증 계획

### 14.1 단계별 검증

1. 채널 1개, 5×5 또는 14×14 작은 입력으로 window 순서 확인
2. Serpentine 좌표가 196개 위치를 중복·누락 없이 방문하는지 확인
3. RIGHT 이동 후 논리 window가 예상값과 같은지 확인
4. LEFT 이동 후 논리 window가 예상값과 같은지 확인
5. DOWN 이동 후 circular row mapping이 예상값과 같은지 확인
6. 네 모서리와 네 가장자리의 zero mask 확인
7. Depthwise convolution 결과를 float C reference와 비교
8. 고정소수점 bit-accurate C model과 RTL을 비교
9. BN + ReLU6까지 포함한 중간 골든과 비교

### 14.2 필수 테스트 패턴

| 패턴 | 확인 목적 |
|---|---|
| 모든 입력 1 | Padding과 3×3 유효 tap 수 확인 |
| impulse 1개 | Kernel 순서와 위치 확인 |
| `input[r][x]=r*16+x` | Window 이동과 주소 확인 |
| 비대칭 kernel `1~9` | Kernel 반전 여부 확인 |
| 음수/양수 혼합 | signed MAC, BN, ReLU6 확인 |

모든 입력과 weight가 1이면 convolution 전 출력은 위치별로 다음 값이 되어야 한다.

```text
corner   : 4
edge     : 6
interior : 9
```

### 14.3 Golden 주의사항

`mobilenetv2_result_layer08.bin`은 다음 연산까지 모두 끝난 블록 최종 결과다.

```text
Depthwise → BN/ReLU6 → Project PW → BN → Residual add
```

따라서 depthwise RTL을 이 파일과 직접 비교하면 안 된다. [../layer8.c](../layer8.c)의
depthwise 단계와 BN/ReLU6 단계만 분리해 별도 중간 golden을 생성해야 한다.

---

## §15. 아직 확정해야 할 항목

| 항목 | 후보/확인 내용 |
|---|---|
| 데이터플로 | 후보 A circular / 후보 B 재계산 / 후보 C 고정 shift |
| 데이터 포맷 | FP32 또는 fixed-point 비트폭/Q 포맷 |
| MAC latency | multiplier/adder IP latency와 feedback 처리 |
| BRAM latency | 1 cycle인지, output register 포함 여부 |
| Window 저장 | 일반 register 또는 distributed RAM |
| Pointer 표현 | 2-bit binary 또는 3-bit one-hot |
| BN 구현 | scale/shift 별도 연산 또는 weight+bias 완전 fold |
| Saturation 위치 | MAC 후, BN 후, ReLU6 후의 rounding 규칙 |
| 채널 전환 | 다음 채널 weight/window preload를 이전 채널과 겹칠지 여부 |

RTL을 작성하기 전에 데이터플로 후보, 데이터 포맷, MAC latency, BRAM latency를 먼저
확정해야 정확한 FSM cycle과 routing 구조를 결정할 수 있다.
