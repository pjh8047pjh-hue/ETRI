# MobileNetV2 2배 병렬화 최적화 계획

## 1. 목적

현재 MobileNetV2 데이터 경로의 연산 자원 여유를 사용하여 처리량을 약 2배로 높인다.
기존 DSP cascade와 연산 결과 순서는 유지하고, 병렬화에 필요한 인덱스·메모리 포트·입출력 폭만 최소한으로 변경한다.

적용할 병렬화 축은 다음과 같다.

| 구간 | 병렬화 방식 | 이유 |
|---|---|---|
| Pointwise before Depthwise | 인접 출력 채널 2개 | 동일 입력 픽셀을 공유하고 Depthwise에 채널 pair를 바로 공급할 수 있음 |
| Depthwise | 인접 채널 2개 | 채널 간 누적 의존성이 없고 동일 BRAM 주소의 인접 lane에 결과를 쓸 수 있음 |
| Pointwise after Depthwise | 동일 출력 채널의 픽셀 2개 | 두 픽셀이 동일 weight와 bias를 공유하고 6 chunk를 병렬 처리할 수 있음 |

전체 데이터 흐름은 다음과 같다.

```text
PW-before  : channel (2k, 2k+1) 동시 계산
             ↓ 32-bit {odd[15:0], even[15:0]}
Depthwise  : 기존 9-DSP depth_mac 2개 동시 실행
             ↓ 32-bit {odd[15:0], even[15:0]}
D2P BRAM   : 동일 주소의 인접 두 channel lane에 동시 저장
             ↓ 두 픽셀 주소 동시 read
PW-after   : pixel (2p, 2p+1) 동시 계산 후 기존 순서로 직렬 출력
```

## 2. 변경 금지 및 최소 수정 원칙

- 기존 DSP primitive 연결과 cascade 내부 구조는 수정하지 않는다.
- Q3.12 형식, bias 연산 위치, ReLU/ReLU6 동작, saturation 및 rounding 정책은 변경하지 않는다.
- 외부 `mobilenetV2` 포트와 최종 channel-major 출력 순서를 유지한다.
- 새로운 연산 구조를 작성하지 않고 기존 MAC 모듈을 복제해 사용한다.
- 관련 없는 코드, 주석, 서식과 Vivado 생성 파일은 수정하지 않는다.
- BRAM latency는 현재 확인된 2클럭을 유지하고 valid/done도 동일하게 정렬한다.
- DSP/MAC 내부 구조를 바꿔야 하는 상황이 발견되면 구현을 중단하고 먼저 사용자 승인을 받는다.

## 3. 기준 구조와 예상 자원

현재 계산 경로의 DSP 사용 구조는 다음과 같다.

| 모듈 | 현재 | 2병렬 적용 후 |
|---|---:|---:|
| PW-before | 64 DSP | 128 DSP |
| Depthwise | 9 DSP | 18 DSP |
| PW-after | 64 DSP | 128 DSP |
| 합계 | 137 DSP | 274 DSP |

대상 FPGA의 DSP 360개를 기준으로 예상 사용률은 약 76%이며 약 86개가 남는다. 실제 수치는 합성 보고서에서 다시 확인한다.

## 4. 1단계: PW-before 인접 채널 2병렬

### 4.1 연산 순서

기존의 출력 채널 하나 대신 같은 픽셀에 대해 인접 출력 채널 두 개를 동시에 계산한다.

```text
pair 0   = channel 0,   1
pair 1   = channel 2,   3
...
pair 191 = channel 382, 383
```

카운터 순서는 `channel_pair → pixel`이며, 각 pair 내부 결과는 `{odd, even}` 32비트로 묶는다.

```sv
even_channel = channel_pair << 1;
odd_channel  = (channel_pair << 1) + 1'b1;
```

### 4.2 메모리

- 입력 feature 1024비트는 두 PW MAC이 공유한다.
- Weight ROM은 두 read port로 짝수/홀수 출력 채널 weight를 동시에 읽는다.
- Bias ROM도 같은 방식으로 짝수/홀수 bias를 동시에 읽는다.
- MAC 결과는 32비트 pair로 PW→Depth 중간 BRAM에 저장한다.

중간 BRAM의 총 저장 비트 수는 유지한다.

```text
기존: 16-bit × 75,264
변경: 32-bit × 37,632
```

중간 BRAM은 한 포트로 pair write, 다른 포트로 pair read를 수행하므로 조기 Depth 시작을 유지할 수 있다.

### 4.3 조기 Depth 시작

현재 `pw_prefill_cnt` 방식은 pair-valid를 계수하도록 유지한다. 9번째 PW pair가 저장되는 클럭에 `pw_depth_start`를 한 번 발생시킨다.

```text
PW pair-valid 9번째 → pw_depth_start 1클럭 pulse
```

Depth reader가 첫 실제 데이터를 소비하기 전 zero-padding 구간과 BRAM latency가 있으므로 PW writer가 앞서가는지 waveform에서 다시 확인한다.

## 5. 2단계: Depthwise 인접 채널 2병렬

### 5.1 MAC 재사용

`depth_mac.sv`의 DSP 9개, line buffer, ReLU 파이프라인은 그대로 유지한다. `depth_top.sv`에서 기존 `depth_mac`을 두 번 인스턴스한다.

```text
even depth_mac ← input_pair[15:0]
odd  depth_mac ← input_pair[31:16]
```

두 MAC은 동일한 row/column 진행을 사용하며 각각 독립된 line buffer를 가진다.

### 5.2 최소 카운터 변경

`depth_mac.sv`에는 연산 구조 대신 다음 제어 파라미터만 추가한다.

```text
처리 채널 수 : 192 pair
even bias    : 0, 2, 4, ..., 382
odd bias     : 1, 3, 5, ..., 383
```

필요한 파라미터는 채널 개수, bias 시작 주소, bias 주소 증가값으로 제한한다. 채널 종료 비교는 383에서 191로 변경한다.

### 5.3 Weight/Bias

- Depth weight ROM은 두 read port로 `2k`, `2k+1` weight를 동시에 공급한다.
- Bias ROM은 `depth_top`에서 한 번만 인스턴스하고 두 read port로 even/odd bias를 공급한다.
- 기존 `depth_mac`의 bias 적용 시점은 `channel_step`으로 유지하고 DSP, line buffer, ReLU 구조는 변경하지 않는다.

### 5.4 예상 처리량

```text
기존 입력 스트림 : 384 × 256 = 98,304클럭
pair 입력 스트림 : 192 × 256 = 49,152클럭

기존 유효 출력   : 384 × 196 = 75,264개
pair 유효 출력   : 192 × 196 = 37,632쌍
```

## 6. 3단계: Depth→PW 저장 로직 2-lane write

Depth pair의 두 결과는 인접 채널이므로 동일 BRAM 주소의 인접 lane에 저장한다.

```sv
wr_addr = wr_pixel_cnt * 6 + wr_pair_cnt[7:5];
wr_lane = {wr_pair_cnt[4:0], 1'b0};
```

16비트 lane 두 개를 쓰기 위해 연속된 4개의 byte-enable을 활성화한다.

```sv
wr_wea[2*wr_lane +: 4] = 4'b1111;
wr_dina = {32{wr_data_pair}};
```

완료 조건은 다음과 같다.

```text
wr_pixel_cnt == 195 && wr_pair_cnt == 191
```

기존 주소 배치 `pixel × 6 + chunk`와 1024비트 출력 형식은 유지한다.

## 7. 4단계: PW-after 픽셀 2병렬

### 7.1 주소 생성

같은 출력 채널에서 짝수/홀수 픽셀을 동시에 처리한다.

```sv
input_addr_a = (pixel_pair_cnt * 2)     * 6 + chunk_cnt;
input_addr_b = (pixel_pair_cnt * 2 + 1) * 6 + chunk_cnt;
weight_addr  = channel_cnt * 6 + chunk_cnt;
bias_addr    = channel_cnt;
```

카운터 범위는 다음과 같다.

```text
channel_cnt    : 0~63
pixel_pair_cnt : 0~97
chunk_cnt      : 0~5
```

### 7.2 메모리 포트

- D2P 입력 BRAM은 두 read port로 두 픽셀 주소를 동시에 읽는다.
- 두 픽셀은 동일 출력 채널이므로 weight와 bias를 공유한다.
- Depth write와 PW-after read가 충돌하지 않도록 기존처럼 `write_done` 이후 PW-after를 시작한다.
- Skip BRAM도 동일한 두 픽셀을 읽을 수 있도록 두 read port를 사용한다.
- 모든 read 데이터와 주소/valid는 BRAM latency 2클럭에 맞춘다.

### 7.3 출력 순서 유지

두 PW MAC 결과는 동시에 계산하지만 외부 16비트 출력은 다음 두 클럭에 직렬화한다.

```text
1클럭: pixel 2p
2클럭: pixel 2p+1
```

한 pair 계산에는 6 chunk가 필요하므로 두 결과를 출력할 2클럭의 여유가 있다. 최종 출력은 기존과 동일하게 다음 순서를 유지한다.

```text
channel 0: pixel 0, 1, 2, ..., 195
channel 1: pixel 0, 1, 2, ..., 195
...
channel 63: pixel 0, 1, 2, ..., 195
```

`done`은 마지막 채널의 마지막 홀수 픽셀 출력과 정렬한다.

## 8. 예상 수정 파일

| 파일 | 최소 변경 내용 |
|---|---|
| `sources_1/new/top_pointwis_before_depth.sv` | 두 PW-before MAC 연결, pair 카운터 및 두 weight/bias 주소 |
| `sources_1/new/pointwise_before_depth.sv` | DSP 내부 수정 없이 기존 인스턴스 재사용 |
| `sources_1/.../mem_layer08_out.sv` | 32비트 pair write/read, depth 37,632, pair reader |
| `sources_1/.../depth_top.sv` | 32비트 입출력과 even/odd `depth_mac` 두 개 |
| `sources_1/.../depth_mac.sv` | 채널 수와 bias 시작/증가 파라미터만 추가 |
| `sources_1/.../mem_depth_weight.sv` | 두 채널 weight 주소 지원 |
| `sources_1/new/interconnect_bram_d2p.sv` | 32비트 pair 입력과 인접 두 lane write |
| `sources_1/new/top_pointwise_after_depth.sv` | 두 픽셀 주소, 두 MAC 결과, skip 정렬 및 직렬 출력 |
| `sources_1/new/mobilenetV2.sv` | 중간 pair wire 폭과 start/valid/done 연결 |
| 관련 `.xci` | 필요한 RAM/ROM 포트 및 폭 변경 |

정확한 경로는 구현 전에 Vivado Sources의 실제 사용 파일과 대조한다. 동일 이름의 import 파일과 복사본 중 합성에 사용되는 파일만 수정한다.

## 9. 단계별 구현 및 검증 순서

한 번에 전체를 변경하지 않고 다음 순서로 적용한다. 각 단계 검증이 통과한 뒤 다음 단계로 진행한다.

### 9.1 기준 상태 고정

- 현재 Behavioral Simulation 결과와 golden error 수를 저장한다.
- 현재 합성 DSP/BRAM/LUT/FF 사용량을 저장한다.
- 현재 구현 WNS/TNS와 critical path를 저장한다.

### 9.2 PW-before pair 검증

- even/odd 결과를 기존 scalar golden과 각각 비교한다.
- pair-valid 개수가 37,632인지 확인한다.
- 9번째 pair-valid와 `pw_depth_start`가 같은 클럭에 한 번만 발생하는지 확인한다.
- 중간 BRAM의 `{odd, even}` lane 순서를 확인한다.

### 9.3 Depth pair 검증

- 두 입력 lane과 weight/bias 채널이 `2k`, `2k+1`로 일치하는지 확인한다.
- even/odd 출력 각각을 기존 Depth golden과 비교한다.
- pair-valid 개수가 37,632인지 확인한다.
- ReLU 입력, 출력 및 valid의 latency가 두 MAC에서 동일한지 확인한다.

### 9.4 D2P BRAM 검증

- 같은 write 주소에서 인접 두 lane만 갱신되는지 확인한다.
- WEA가 정확히 연속 4비트만 활성화되는지 확인한다.
- `write_done`이 마지막 pair write에서 한 번만 발생하는지 확인한다.
- 전체 384×196 값이 기존 채널/lane 배치와 일치하는지 확인한다.

### 9.5 PW-after 픽셀 pair 검증

- 두 BRAM 주소가 동일 chunk의 연속 픽셀인지 확인한다.
- 두 MAC이 같은 weight/bias를 사용하는지 확인한다.
- skip lane과 PW 결과가 동일 픽셀/채널로 정렬되는지 확인한다.
- 직렬 출력이 even pixel 다음 odd pixel 순서인지 확인한다.
- 최종 출력 개수가 12,544인지 확인한다.

### 9.6 전체 검증

- 전체 Behavioral Simulation에서 X/Z가 valid 구간에 없는지 확인한다.
- 최종 12,544개 결과를 scalar golden과 순서대로 비교한다.
- `done`이 한 번만 발생하고 마지막 출력과 정렬되는지 확인한다.
- Synthesis에서 DSP 예상치 약 274개를 확인한다.
- Implementation은 현재 적용된 클럭 제약에서 WNS ≥ 0, TNS = 0을 목표로 한다.
- ILA는 기능과 timing 검증이 끝난 뒤 필요한 신호만 최소 폭으로 추가한다.

## 10. 주요 waveform 신호

### PW-before

```text
channel_pair_cnt
pixel_cnt
weight_addr_even / weight_addr_odd
pw_even / pw_odd
pw_pair_valid
pw_depth_start
```

### Depthwise

```text
input_pair[31:0]
pair_channel_cnt
row_cnt / col_cnt
weight_even / weight_odd
bias_addr_even / bias_addr_odd
depth_even / depth_odd
depth_pair_valid
```

### D2P BRAM

```text
wr_pair_cnt
wr_pixel_cnt
wr_addr
wr_lane
wr_wea
wr_data_pair
write_done
```

### PW-after

```text
pixel_pair_cnt
chunk_cnt
input_addr_a / input_addr_b
input_data_a / input_data_b
pw_raw_a / pw_raw_b
skip_a / skip_b
serialize_sel
output_valid
pointwise_after_depth_out
done
```

## 11. 중단 조건

다음 상황에서는 임의로 구조를 확장하지 않고 작업을 중단한 뒤 사용자에게 확인한다.

- 기존 DSP cascade 내부 수정이 필요한 경우
- Q3.12, bias, ReLU 또는 saturation 정책 변경이 필요한 경우
- 출력 순서를 바꿔야만 병렬화할 수 있는 경우
- BRAM read/write 포트 충돌로 추가 메모리 복제가 필요한 경우
- 합성 DSP 사용량이 예상 274개를 크게 초과하는 경우
- 기존 클럭 제약에서 timing을 만족시키기 위해 추가 파이프라인이 필요한 경우

## 12. 현재 상태

- 2병렬화 RTL 연결과 카운터 변경을 적용했다.
- 기존 `pointwise_before_depth`, `pointwise_after_depth` MAC은 수정 없이 각각 두 번 재사용한다.
- `depth_mac`은 DSP/line buffer/ReLU 구조를 유지하고 외부 bias 입력과 채널 수 파라미터만 추가했다.
- RTL 대상 `xvlog -sv` 문법 검증은 통과했다.
- IP 설정과 `.xci`는 사용자가 다시 생성하기로 했으므로 수정하지 않았다.
- 새 IP 생성 전에는 포트 구성이 맞지 않으므로 elaboration, simulation, synthesis, implementation을 실행하지 않는다.

## 13. 사용자가 다시 생성할 IP 설정

모든 A/B read port는 기존 설계와 동일하게 실제 데이터 latency 2클럭으로 설정한다. Vivado에서는 두 포트 모두 `Register Port Output of Memory Primitives`를 체크한다.

| IP | Memory type | Width × Depth | 추가 설정 |
|---|---|---:|---|
| `pointwise_before_depth_weight` | Dual Port ROM | 1024 × 384 | 기존 COE 유지, ENA/ENB 사용 |
| `pointwise_before_depth_bias` | Dual Port ROM | 32 × 384 | 기존 COE 유지, ENA/ENB 사용 |
| `output_bram_ip` | True Dual Port RAM | 32 × 37,632 | byte write 비활성화 |
| `blk_mem_gen_0` | Dual Port ROM | 144 × 384 | 기존 Depth weight COE 유지, ENA/ENB 사용 |
| `depth_bias` | Dual Port ROM | 32 × 384 | 기존 COE 유지, ENA/ENB 사용 |
| `pointwise_after_depth_input` | True Dual Port RAM | 1024 × 1,176 | byte write 활성화, byte size 8, WEA/WEB 128비트 |
| `input_bram_ip` | True Dual Port RAM | 1024 × 196 | 기존 입력 COE 유지, byte write 비활성화 |

다음 IP는 두 픽셀이 같은 값을 공유하므로 기존 Single Port ROM 설정을 유지한다.

- `pointwise_after_depth_weight`
- `pointwise_after_depth_bias`

RTL이 사용하는 True Dual Port RAM 포트 이름은 다음과 같다.

```text
Port A: clka, ena, wea, addra, dina, douta
Port B: clkb, enb, web, addrb, dinb, doutb
```

Dual Port ROM 포트 이름은 다음과 같다.

```text
Port A: clka, ena, addra, douta
Port B: clkb, enb, addrb, doutb
```
