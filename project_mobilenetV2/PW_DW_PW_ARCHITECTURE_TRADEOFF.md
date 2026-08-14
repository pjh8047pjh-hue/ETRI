# MobileNetV2 PW-DW-PW 데이터플로 구조 비교

## 1. 문서 목적

이 문서는 `project_mobilenetV2` 폴더에 현재 존재하는 RTL, 테스트벤치, COE 생성 스크립트, Vivado IP 합성 보고서만을 근거로 다음 두 구조를 비교한다.

1. 각 layer가 끝날 때 전체 feature map을 BRAM에 저장하고 다음 layer가 읽는 순차 구조
2. 첫 번째 pointwise(PW1), depthwise(DW), 두 번째 pointwise(PW2)를 동시에 동작시키고 full feature-map BRAM을 작은 line buffer로 대체하는 streaming 구조

이 문서는 설계 방향을 결정하기 위한 자료이며 RTL 구현 방법이나 코드 패치를 제공하지 않는다. 특히 현재 RTL, Vivado 프로젝트, COE 파일과 Vivado 생성물은 이 문서를 작성하면서 변경하지 않았다.

---

## 2. 검토 기준

| 항목 | 기준 |
|---|---:|
| 입력 feature map | `14 × 14 × 64` |
| PW1 출력 | `14 × 14 × 384` |
| DW 출력 | `14 × 14 × 384`, 3×3, stride 1, padding 1 |
| PW2 출력 | `14 × 14 × 64` |
| 동작 클록 | 100 MHz |
| FPGA | `xczu3eg-sbva484-1-e` |
| PW1/DW activation 경로 | 현재 16-bit 경로 유지 |
| PW2 입력/weight | 현재 `pointwise_after_depth`의 signed int8 경로 유지 |

100 MHz와 FPGA part는 [project_mobilenetV2.xpr](project_mobilenetV2.xpr#L10) 및 [clk_wiz_0.xci](project_mobilenetV2.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0.xci#L419)에서 확인된다. PW2의 출력 채널 수 64는 [gen_coe_after_depth.ps1](coe/gen_coe_after_depth.ps1#L42)의 `$OUT_CH = 64`를 기준으로 한다.

### 사실과 추정의 구분

- **확인된 사실**: 현재 소스나 기존 IP 합성 보고서에 직접 나타나는 내용
- **계산값**: loop 크기, parallel lane 수 및 메모리 용량으로 계산한 값
- **예상값**: 아직 완성되지 않은 end-to-end 회로의 합성·배치 결과를 가정한 값

현재 end-to-end 합성이 완료되지 않았기 때문에 전체 cycle과 일부 BRAM 수치는 합성 실측값이 아니라 계산값 또는 예상값이다.

---

## 3. 현재 구현 상태

### 3.1 전체 top은 아직 PW-DW-PW로 완성되지 않았다

[mobilenetV2.sv](project_mobilenetV2.srcs/sources_1/new/mobilenetV2.sv#L45)는 PW1과 DW만 인스턴스화한다. PW2인 `pointwise_after_depth`는 연결되어 있지 않으며, 최종 `result`도 DW ReLU 출력에 직접 연결된다. `depth_top`에 완료 신호가 없어 `done`은 항상 0으로 고정돼 있다.

Vivado source set의 현재 synthesis top은 [project_mobilenetV2.xpr](project_mobilenetV2.xpr#L270)에서 `pointwise_after_depth`로 설정돼 있다. 따라서 현재 프로젝트 설정 역시 완성된 MobileNetV2 block이 아니라 PW2 단독 회로를 대상으로 한다.

`top_pointwise_after_depth.sv` 파일도 존재하지만 현재 내용은 port와 instance가 없는 빈 module이며 active synthesis top이 아니다.

### 3.2 PW1은 전체 결과를 BRAM에 저장한 뒤 읽는다

PW1은 다음 구조로 되어 있다.

- 입력 BRAM: 1 pixel의 64개 16-bit channel을 1,024-bit word로 읽음
- weight ROM: 한 output channel의 64개 16-bit weight를 1,024-bit word로 읽음
- MAC: 64개 multiplier를 사용하므로 64 input channel dot product를 한 번에 수행
- 출력 순서: `pixel`이 outer loop, `output channel`이 inner loop
- 출력 BRAM: 16-bit × 75,264개 결과를 저장한 뒤 channel-major 순서로 다시 읽음

출력 메모리의 깊이는 [mem_layer08_out.sv](project_mobilenetV2.srcs/sources_1/imports/JH/week6/pointwise_conv/pointwise_conv.srcs/sources_1/new/mem_layer08_out.sv#L27)의 `384 × 196 = 75,264`이다. 쓰기 주소는 같은 파일의 line 111에서 `CHANNEL_WIDTH=196`만큼 증가시켜 pixel-major 출력 스트림을 channel-major 메모리 배치로 전치한다.

이 전치가 필요한 이유는 현재 DW가 한 channel의 공간 데이터를 연속으로 받는 구조이기 때문이다. 결과적으로 DW는 PW1이 전체 75,264개 출력을 다 쓴 뒤에야 정상적으로 읽기를 시작한다.

### 3.3 현재 DW는 channel-major 15×15 스트림을 가정한다

[depth_mac.sv](project_mobilenetV2.srcs/sources_1/imports/JH/week7/depthwise/depthwise.srcs/sources_1/new/depth_mac.sv#L33)는 `ROW_LEN=15`인 스트림과 두 개의 15-word line buffer를 사용한다. 14×14 실제 값에 padding용 행과 열을 포함하여 channel당 225 cycle을 사용하는 의도다.

다만 현재 연결에는 다음 불일치가 남아 있다.

- `mobilenetV2.sv`는 `output_data_valid`의 첫 rising edge에서만 DW를 시작한다.
- DW에는 명확한 input/output valid와 done이 없다.
- [mem_depth_weight.sv](project_mobilenetV2.srcs/sources_1/imports/JH/week7/depthwise/depthwise.srcs/sources_1/new/mem_depth_weight.sv#L50)는 weight channel을 384 cycle마다 증가시키지만, 현재 15×15 channel stream은 channel당 225 cycle이다.
- padding 좌표, BRAM read latency, DSP latency를 하나의 valid pipeline으로 끝까지 추적하지 않는다.

따라서 86,400 cycle은 현재 RTL이 이미 bit-accurate하게 완성했다는 뜻이 아니라, `15 × 15 × 384`라는 현재 의도에서 계산한 처리량이다.

### 3.4 현재 PW2는 64-input reduction 방식이다

[pointwise_after_depth.sv](project_mobilenetV2.srcs/sources_1/new/pointwise_after_depth.sv#L35)는 64개의 signed int8 input과 weight를 512-bit bus로 받는다. 384 input channel을 64개씩 여섯 번 처리하므로 output 하나당 6 cycle이 필요하다.

64 DSP는 다음과 같이 사용된다.

- 8개 DSP를 cascade한 group 8개 구성
- 각 group이 8개 product를 더함
- group sum 8개를 3-stage adder tree로 reduction
- 6개 input-channel chunk의 결과를 추가로 누적

현재 module에는 `ic_cnt`와 `pix_cnt`만 있고 64개 output channel을 순회하는 `oc_cnt`가 없다. 즉 현재 테스트 대상은 한 output channel에 대한 196 pixel 처리이며, 전체 64 output channel의 cycle은 COE의 weight 구조와 `$OUT_CH=64`를 바탕으로 환산해야 한다.

### 3.5 전체 합성 결과는 아직 없다

[synth_1/runme.log](project_mobilenetV2.runs/synth_1/runme.log)는 다음 COE 경로를 찾지 못해 전체 합성이 종료됐음을 기록한다.

```text
C:/Users/user/Documents/JH/project_mobilenetV2/ip_from_lib/coe/weight_144x384_all1.coe
```

또한 해당 합성 기록은 이후 변경된 PW2 소스와 현재 active top보다 오래된 기록이다. 그러므로 기존 report 중 신뢰할 수 있는 것은 개별 IP에 대한 자원 사용량이며, 3개 layer 전체의 timing, power, utilization은 아직 실측되지 않았다.

---

## 4. 방식 A: full feature-map BRAM을 사용하는 순차 구조

### 4.1 데이터 흐름

```text
입력 BRAM
   ↓
PW1 64-MAC
   ↓ 전체 14×14×384 저장
PW1 출력 BRAM
   ↓ channel-major로 전체 read
DW 9-MAC
   ↓ 전체 14×14×384 저장
DW 출력 BRAM
   ↓ pixel별 384 channel read
PW2 64-MAC
   ↓
최종 출력
```

각 layer가 끝난 뒤 다음 layer를 시작한다. 중간 BRAM이 loop order 변환과 layer 처리율 차이를 모두 흡수하기 때문에 control이 단순하다.

### 4.2 예상 cycle

#### PW1

PW1은 64 input channel을 64 DSP로 한 번에 계산하므로 output scalar 한 개를 매 cycle 생성할 수 있다.

```text
196 pixels × 384 output channels × ceil(64 / 64)
= 75,264 cycles
```

#### DW

현재 15×15 padded stream을 channel별로 실행한다.

```text
15 × 15 slots × 384 channels
= 86,400 cycles
```

#### PW2

한 output은 384 input channel을 64개씩 여섯 번 나눠 계산한다.

```text
196 pixels × 64 output channels × ceil(384 / 64)
= 75,264 cycles
```

#### 합계

```text
75,264 + 86,400 + 75,264
= 236,928 cycles
```

100 MHz에서는 fixed IP latency를 제외하고 약 `2.369 ms`다. BRAM read latency와 각 DSP pipeline drain을 더해도 총량에 비해 작은 고정 overhead다.

### 4.3 DSP 사용량

순차 실행의 장점을 살려 두 PW가 하나의 64-DSP engine을 시간 공유하면 다음과 같다.

```text
공유 PW engine 64 DSP + DW 9 DSP = 73 DSP
73 / 360 = 20.3%
```

반대로 현재처럼 PW1과 PW2를 별도 회로로 유지하면 실제로 동시에 계산하지 않더라도 137 DSP가 배치된다.

```text
PW1 64 + DW 9 + PW2 64 = 137 DSP
137 / 360 = 38.1%
```

따라서 full-BRAM 순차 방식은 **두 PW가 DSP를 실제로 공유할 때** 자원 측면의 의미가 크다. 별도 137-DSP 회로를 두고 순차 실행하면 DSP utilization과 latency 양쪽에서 불리하다.

### 4.4 중간 BRAM 사용량

PW1 출력 BRAM은 기존 개별 IP 합성 보고서에서 실제로 35.5 BRAM tile을 사용한다.

- [output_bram_ip utilization](project_mobilenetV2.runs/output_bram_ip_synth_1/output_bram_ip_utilization_synth.rpt#L73): 35.5 / 216 tile
- 데이터 용량: `75,264 × 16 = 1,204,224 bit`

DW 출력은 현재 PW2가 int8 input을 사용하므로 8-bit로 저장한다고 가정할 수 있다.

```text
75,264 × 8 = 602,112 bit
이론적 최소 = 602,112 / 36,864 = 16.34 BRAM tile
실제 packing을 고려한 예상 = 약 18 tile
```

따라서 중간 feature map에만 약 53.5 tile이 필요하다. DW 출력을 16-bit로 보존하면 PW1 출력과 유사하게 약 35.5 tile이 추가되어 총 약 71 tile이 된다.

이 수치는 입력 BRAM, PW1 weight ROM, DW weight ROM, PW2 weight ROM을 제외한 값이다. 입력과 weight memory는 두 비교안 모두에 필요하므로 중간 buffering trade-off에서 제외한다.

### 4.5 장점과 단점

장점:

- layer별 동작과 결과를 독립적으로 검사하기 쉽다.
- 서로 다른 loop order와 데이터 폭을 BRAM에서 정리할 수 있다.
- downstream의 일시 정지나 pipeline latency가 upstream으로 전파되지 않는다.
- PW DSP 공유가 가능해 peak DSP를 73개 수준으로 낮출 수 있다.
- 동시에 활성화되는 DSP가 적어 순간 전력과 placement 부담이 낮다.

단점:

- 세 layer latency가 그대로 합산된다.
- 모든 intermediate activation을 한 번 쓰고 다시 읽어 BRAM switching과 에너지 소비가 증가한다.
- 최소 약 53.5 tile의 중간 BRAM이 필요하다.
- 별도 PW engine을 유지하면 DSP 137개를 배치하면서도 대부분의 시간 한쪽 PW가 유휴 상태다.
- 다음 layer는 전체 feature map이 완성될 때까지 시작하지 못한다.

---

## 5. 방식 B: 최소 line buffer를 사용하는 1-lane streaming 구조

### 5.1 권고 데이터 흐름

```text
PW1: 64 input-channel MAC
  │  매 cycle (pixel, expanded_channel) scalar 한 개
  ▼
2-row delay + horizontal history
  │  같은 channel의 3×3 window 한 개/clk
  ▼
DW: 9-MAC
  │  depthwise scalar 한 개/clk
  ▼
PW2: 64 output-stationary MAC
  │  384 cycle 뒤 output channel 64개 완성
  ▼
64-entry output register/serializer
```

핵심은 세 stage의 속도를 모두 **expanded channel 한 개/clk**로 맞추는 것이다.

- PW1: 64 input channel을 한 번에 reduction하여 expanded scalar 한 개/clk 생성
- DW: 3×3의 9개 spatial value를 9 DSP로 계산하여 scalar 한 개/clk 생성
- PW2: DW scalar 한 개를 64 output-channel MAC에 broadcast하여 scalar 한 개/clk 소비

이렇게 하면 별도의 full feature-map 전치와 DW 출력 저장이 필요 없다.

### 5.2 PW1 처리 순서

PW1의 loop 순서는 다음과 같이 유지한다.

```text
pixel 0
  expanded channel 0, 1, ... 383
pixel 1
  expanded channel 0, 1, ... 383
...
pixel 195
```

현재 PW1이 이미 이 순서로 MAC 결과를 생성하므로 MAC datapath 자체를 넓힐 필요는 없다. 차이는 `mem_layer08_out`으로 결과를 보내지 않고 `valid/ready` stream으로 line buffer에 전달한다는 점이다.

권고 stream 정보는 다음과 같다.

| 신호 의미 | 폭 | 설명 |
|---|---:|---|
| activation | 16 | PW1 결과/ReLU 결과 |
| valid | 1 | 현재 activation과 index가 유효함 |
| ready | 1 | downstream이 값을 받을 수 있음 |
| pixel index | 8 | 0..195 |
| expanded channel | 9 | 0..383 |
| frame last | 1 | 마지막 pixel, 마지막 channel 표시 |

실제 index는 각 stage 내부 counter로 재생성할 수도 있지만, 최초 통합 검증에서는 명시적인 tag를 함께 이동시키는 편이 latency 정렬 오류를 찾기 쉽다.

### 5.3 line buffer 구조

pixel-major/channel-inner 스트림에서는 같은 channel의 다음 열 값이 384 cycle 뒤, 다음 행 값이 `14×384=5,376` cycle 뒤 들어온다. 이에 맞춰 다음 storage가 필요하다.

#### Vertical row delay

```text
2 rows × 14 columns × 384 channels × 16 bit
= 172,032 bit
```

5,376×16 memory 두 개로 구성한다. 5,376×16 memory 하나는 실제 BRAM packing에서 약 3 tile이 필요하므로 두 row delay는 약 6 tile로 예상한다.

#### Horizontal history

3개 row 각각에서 같은 channel의 이전 두 column을 유지한다.

```text
3 rows × 2 columns × 384 channels × 16 bit
= 36,864 bit
```

이 부분은 384-depth LUTRAM 또는 SRL로 구현하는 것이 효율적이다. 전체 activation history는 208,896bit지만 BRAM에는 긴 vertical delay만 배치하므로 약 6 tile로 제한된다.

### 5.4 padding과 flush schedule

padding zero를 실제 BRAM 데이터로 모두 삽입하면 현재처럼 channel당 15×15=225 slot이 필요하다. 권고 구조는 좌표를 이용해 top/left/right/bottom zero를 선택하여 불필요한 padding cycle을 줄인다.

- top/left padding: 좌표 mask로 zero를 선택하며 별도 입력 slot을 만들지 않는다.
- 일반 output `(r,c)`: 필요한 다음 행과 다음 열 값이 도착한 시점에 계산한다.
- 각 행의 right-edge output: 다음 실제 행의 `col=0` 384-cycle 구간에 계산한다.
- 마지막 행: 다음 실제 행이 없으므로 frame 끝에 15개의 virtual pixel slot을 실행한다.
- virtual slot 동안 PW1에는 `ready=0`을 보내 정지시키고 line buffer에는 새 실제 데이터를 쓰지 않는다.

따라서 frame drain 시간은 다음과 같이 계산된다.

```text
(196 real pixel slots + 15 final flush slots) × 384 channels
= 81,024 cycles
```

초기 3×3 window fill은 PW1 계산과 겹치며 별도의 전체-frame 대기 시간이 되지 않는다.

### 5.5 DW 연산 구조

DW는 한 cycle에 같은 channel의 3×3 window 9개를 받는다.

```text
9 input values × 9 weights
→ 9 DSP products
→ pipelined reduction
→ depthwise scalar 한 개/clk
```

weight ROM은 `weight[channel][0..8]` 형식의 144-bit word ×384 depth로 둔다. 주소는 stream의 `expanded_channel` 0..383을 매 cycle 따라가고, 다음 pixel에서 다시 0으로 돌아온다.

이는 현재 `mem_depth_weight`가 weight channel을 384 cycle 동안 고정하는 방식과 다르다. pixel-major stream에서 같은 weight를 384 cycle 동안 고정하면 서로 다른 channel에 잘못된 weight가 적용된다.

### 5.6 PW2는 output-stationary 구조가 효율적이다

현재 PW2는 64 input을 동시에 받고 output 하나를 reduction한다. 이 구조를 DW와 직접 연결하려면 DW 결과 64개를 먼저 모으는 buffer가 필요하고, 64-wide input을 만들기 위한 별도 packing 단계도 필요하다.

streaming에서는 반대로 64 DSP를 64개 output channel에 하나씩 고정한다.

```text
매 cycle:
    dw_value[channel]을 DSP 64개에 broadcast
    DSP[oc] += dw_value[channel] × weight[channel][oc]

channel 0..383 처리 후:
    output channel 0..63이 동시에 완성
```

이 구조의 장점은 다음과 같다.

- DW scalar를 받는 즉시 사용하므로 DW 출력 BRAM이 필요 없다.
- 64개 input reduction용 cascade와 8→4→2→1 adder tree가 사라진다.
- 64개 독립 accumulator가 DSP의 MAC 경로에 자연스럽게 대응한다.
- DW와 PW2가 모두 한 expanded channel/clk로 정확히 균형을 이룬다.

PW2 weight ROM은 다음 배치가 적합하다.

```text
depth: 384 input channels
width: 64 output channels × 8 bit = 512 bit
address: input channel
lane: output channel
```

현재 COE 생성기는 `chunk × output channel` 주소마다 64 input lane weight를 저장한다. output-stationary 구조에서는 같은 input channel에 대한 64 output weight가 한 word에 오도록 논리적 전치가 필요하다.

64개 output은 한 pixel의 마지막 input channel이 누적된 뒤 register bank에 옮긴다. 다음 pixel을 384 cycle 동안 누적하는 사이 이전 결과를 64 cycle 동안 직렬 출력할 수 있으므로 output serializer는 병목이 되지 않는다.

### 5.7 예상 cycle과 DSP

세 stage가 정상 구간에서 한 expanded channel/clk로 맞춰지므로 순차 합이 아니라 가장 긴 streaming schedule로 전체 시간이 결정된다.

```text
예상 frame drain = 81,024 cycles
100 MHz 처리시간 = 약 0.810 ms
```

DSP 수는 다음과 같다.

```text
PW1 64 + DW 9 + PW2 64
= 137 DSP
= 38.1% of 360 DSP
```

고정 DSP/BRAM pipeline latency는 수십 cycle 수준으로 예상되며 81,024-cycle 본체와 별도로 합성 후 측정해야 한다.

---

## 6. 두 방식의 정량 비교

| 항목 | Full-BRAM 순차 구조 | 1-lane streaming 구조 |
|---|---:|---:|
| PW1 계산 | 75,264 cycle | DW/PW2와 중첩 |
| DW 계산 | 86,400 cycle | PW1/PW2와 중첩 |
| PW2 계산 | 75,264 cycle | PW1/DW와 중첩 |
| 예상 전체 | 236,928 cycle | 81,024 cycle |
| 100 MHz 시간 | 약 2.369 ms | 약 0.810 ms |
| 예상 속도 향상 | 1.0× | 약 2.92× |
| DSP | 공유 시 73, 분리 시 137 | 137 |
| PW1→DW full map | 35.5 BRAM tile | 없음 |
| DW→PW2 full map | 약 18 tile(int8) | 없음 |
| streaming history | 없음 | 약 6 BRAM tile + LUTRAM |
| 제어 복잡도 | 낮음 | 높음 |
| 결과 관찰·debug | 쉬움 | valid/tag 기반 검증 필요 |
| 순간 DSP switching | 낮음, 공유 시 최대 73 DSP | 높음, 최대 137 DSP |
| frame당 BRAM traffic | 큼 | 작음 |
| timing 위험 | 비교적 낮음 | 512-bit weight bus와 64-lane broadcast 관리 필요 |

속도 향상 계산은 다음과 같다.

```text
236,928 / 81,024 = 2.924
```

### 전력에 대한 판단

합성·배치 후 power report가 없으므로 어느 쪽이 절대적으로 저전력이라고 단정할 수 없다.

- 순차 공유 구조는 동시에 활성화되는 DSP가 적어 순간 동적 전력이 낮을 가능성이 크다.
- streaming 구조는 137 DSP가 겹쳐서 동작하므로 순간 전력은 증가할 수 있다.
- 반면 streaming은 실행 시간이 약 1/2.9이고 대형 intermediate BRAM read/write를 제거하므로 frame당 에너지는 감소할 가능성이 있다.

정확한 비교는 같은 100 MHz, 같은 입력 toggle 조건에서 implementation 후 `report_power`로 해야 한다.

### timing에 대한 판단

streaming 구조에서 주의할 경로는 다음과 같다.

- DW scalar의 64개 PW2 DSP fan-out
- 512-bit PW2 weight ROM 출력 배선
- channel/pixel tag와 DSP pipeline valid 정렬
- line-buffer read/write와 3×3 window 선택 mux

하지만 현재 PW2의 8-DSP cascade와 큰 adder tree가 제거되므로 PW2 arithmetic 자체의 timing은 오히려 단순해질 수 있다. DSP 입력과 weight ROM 출력에 register stage를 두고 `valid/channel/pixel`을 같은 latency만큼 이동시키는 것이 필요하다.

---

## 7. 완전 BRAM-free가 최선이 아닌 이유

3×3 DW는 현재 pixel을 계산할 때 앞선 두 행과 좌측 두 열의 같은 channel 값을 필요로 한다. 따라서 layer 사이에 full feature map BRAM을 두지 않더라도 **공간 이력을 저장하는 메모리 자체는 제거할 수 없다**.

권고 line buffer의 activation history는 총 208,896bit다. 이를 전부 LUTRAM/SRL로 옮기면 다음 문제가 생긴다.

- 메모리 bit 수만 기준으로도 수천 개의 LUT가 필요하다.
- 긴 shift 경로와 높은 fan-out으로 placement/routing이 복잡해진다.
- 제어·MAC에 쓸 LUT와 register를 소비한다.
- BRAM이 원래 잘 처리하는 깊고 좁은 5,376×16 delay를 비효율적으로 구현하게 된다.

따라서 목표를 “BRAM을 하나도 쓰지 않는 것”으로 두기보다 “75,264-entry full feature-map BRAM을 없애고 약 6개 BRAM tile의 line delay만 남기는 것”으로 두는 것이 효율적이다.

---

## 8. 권고안

### 최종 권고: 1-lane hybrid streaming

이 프로젝트에는 다음 구조가 가장 적합하다.

```text
PW1 64-MAC
→ 약 6 BRAM tile의 2-row line buffer
→ DW 9-MAC
→ PW2 64개 output-stationary MAC
```

선택 이유:

1. 137 DSP는 target device의 360개 중 38.1%여서 충분히 수용 가능한 범위다.
2. 현재 PW1의 pixel-major 출력 순서를 그대로 활용할 수 있다.
3. 가장 큰 35.5-tile PW1 출력 BRAM을 제거할 수 있다.
4. DW 출력도 PW2가 즉시 소비하므로 두 번째 full-map BRAM이 필요 없다.
5. PW1, DW, PW2가 모두 expanded channel 한 개/clk로 균형을 이룬다.
6. 순차 구조 대비 약 2.9배의 frame latency 개선을 기대할 수 있다.
7. 완전 BRAM-free보다 LUT와 routing 부담이 작다.

### 순차 full-BRAM 구조가 더 적합한 경우

다음 조건이 우선이라면 순차 구조도 합리적이다.

- DSP를 73개 수준으로 반드시 제한해야 하는 경우
- 먼저 각 layer 결과를 BRAM에서 관찰하며 bit-accurate 검증해야 하는 경우
- 최종 quantization이나 layer shape이 아직 자주 바뀌는 경우
- throughput보다 구현 일정과 debug 단순성이 더 중요한 경우

단, 이 경우에는 PW1/PW2가 하나의 64-DSP engine을 실제로 공유해야 한다. 별도 137-DSP 회로를 유지하면서 full-BRAM 순차 실행을 선택하는 것은 효율이 낮다.

---

## 9. 향후 검증 항목

이 문서의 계산을 실제 수치로 확정하려면 다음 검증이 필요하다.

1. 동일한 입력과 weight로 순차 reference와 streaming 모델의 모든 `pixel/channel` 결과를 bit-exact 비교한다.
2. corner, edge, interior pixel의 zero padding을 각각 확인한다.
3. DW output valid 개수가 정확히 `196×384`인지 확인한다.
4. PW2 output valid 개수가 정확히 `196×64`인지 확인한다.
5. channel 383에서 accumulator 종료와 다음 pixel 초기화가 DSP latency에 맞게 정렬되는지 확인한다.
6. frame 끝의 15 virtual pixel slot에서 중복·누락 output이 없는지 확인한다.
7. target part와 100 MHz 조건에서 DSP, BRAM, LUT, FF, WNS를 비교한다.
8. 같은 switching 조건의 power report로 순간 전력과 frame당 에너지를 함께 비교한다.

비교 시 목표값은 다음과 같다.

| 검증 항목 | 목표 |
|---|---:|
| Streaming DSP | 137개 이하 |
| Intermediate line-buffer BRAM | 약 6 tile |
| Full feature-map BRAM | 0개 |
| Core frame cycle | 약 81,024 + 고정 pipeline latency |
| Timing | 100 MHz에서 WNS ≥ 0 |
| 기능 | 순차 reference와 bit-exact |

---

## 10. 분석의 제한 사항

- 전체 PW-DW-PW top이 아직 연결되지 않아 두 방식 모두 end-to-end 합성 실측값이 없다.
- 기존 전체 synthesis run은 COE 경로 오류로 실패했다.
- DW 출력용 int8 BRAM 약 18 tile은 데이터 용량과 일반적인 packing에 기반한 예상이며 실제 IP 합성값이 아니다.
- 81,024 cycle은 효율적인 padding schedule을 적용한 계산값이며 DSP/BRAM의 고정 pipeline latency는 포함하지 않는다.
- 현재 DW ReLU6의 정수 clamp와 PW1의 Q-format 사이 수치 의미는 별도 검토 대상이다. 본 비교에서는 현재 폭과 clamp 동작을 변경하지 않는다.
- batch 간 연속 입력까지 완전히 겹치려면 frame 끝 flush와 다음 frame 입력을 분리할 추가 context 또는 작은 FIFO가 필요하다. 본 비교는 한 frame의 latency를 기준으로 한다.

이 제한을 고려해도, 현재 자원 규모와 layer 처리율 기준에서는 **full feature-map BRAM 순차 구조보다 최소 BRAM line-buffer를 사용한 1-lane streaming 구조가 가장 좋은 균형점**이라는 결론은 유지된다.
