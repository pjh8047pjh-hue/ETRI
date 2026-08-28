# MobileNetV2 Layer 07 Full PTQ 하드웨어 포맷 명세

## 1. 목적과 범위

이 문서는 Layer 07의 BN-folded convolution을 모두 정수 연산으로 구현하기 위한 데이터 포맷과 연산 규칙을 정의한다.

적용 범위는 다음과 같다.

```text
INT8/UINT8 입력
→ Expand 1x1 Conv + folded BN + ReLU6
→ Depthwise 3x3 Conv + folded BN + ReLU6
→ Project 1x1 Conv + folded BN
→ UINT8 출력
```

BN folding, weight 양자화, bias 보정, requantization 상수 생성은 소프트웨어에서 수행한다. RTL은 BN 나눗셈이나 부동소수점 연산을 수행하지 않는다.

기준 자료:

- `folded/layer07_folded.pt`
- `quantized_int8/layer07_int8.pt`
- `quantized_int8/layer07_int8_manifest.json`
- `quantized_int8/int8_accuracy_summary.md`

## 2. 기준 네트워크 크기

기존 Layer 07 PTQ 산출물의 tensor shape을 기준으로 한다.

| 연산 | Weight shape | 입력 채널 | 출력 채널 |
|---|---:|---:|---:|
| Expand pointwise | `[192, 32, 1, 1]` | 32 | 192 |
| Depthwise | `[192, 1, 3, 3]` | 192 | 192 |
| Project pointwise | `[64, 192, 1, 1]` | 192 | 64 |

Project pointwise에 64개 병렬 MAC을 사용하면 입력 채널 chunk 수는 다음과 같다.

```text
PROJECT_CHUNKS = 192 / 64 = 3
chunk index    = 0, 1, 2
```

현재 `project_mobilenetV2/coe/gen_coe_after_depth.ps1`와 일부 RTL의 `384채널/6 chunk` 설정은 디버깅용 별도 구성이다. 위 Layer 07 PTQ 파일을 실제로 사용할 때는 반드시 `192채널/3 chunk`로 맞춘다. 384채널 레이어를 대상으로 한다면 weight 파일과 scale도 해당 레이어 기준으로 다시 생성해야 한다.

## 3. 공통 양자화 정의

정수값 `q`와 실수값 `r`의 관계는 다음과 같다.

```text
r = S × (q - Z)

S: scale, 양수 실수
Z: zero-point, 정수
```

이 설계는 하나의 고정된 Qm.n binary point를 전체 네트워크에 공통 적용하지 않는다. 레이어 경계마다 `S`와 `Z`가 다르며, 각 activation tensor와 함께 해당 메타데이터가 고정된다.

### 3.1 기준 activation qparam

기존 PyTorch PTQ와 수치적으로 일치시키기 위한 기준값이다.

| Tensor | 저장 형식 | 정수 범위 | Scale `S` | Zero-point `Z` |
|---|---|---:|---:|---:|
| Layer 07 input | UINT8 | `0..127` | `0.05095461755990982` | 64 |
| Expand output | UINT8 | `0..127` | `0.02259720489382744` | 67 |
| Depthwise output | UINT8 | `0..127` | `0.02543833665549755` | 53 |
| Project output | UINT8 | `0..127` | `0.029565492644906044` | 60 |

`0..127`은 기존 x86 PTQ 산출물의 reduced range이다. FPGA에서 `0..255`를 사용하려면 calibration, qparam 생성 및 정확도 평가를 다시 수행해야 하며, 기존 qparam을 그대로 재사용하지 않는다.

### 3.2 Weight 포맷

```text
형식       : signed INT8
범위       : -127..127
zero-point : 0
scale      : per-output-channel symmetric
```

출력 채널 `oc`에 대해:

```text
Sw[oc] = max(abs(W_folded[oc])) / 127

qw[oc][ic] = clamp(
    round_nearest_even(W_folded[oc][ic] / Sw[oc]),
    -127,
    127
)
```

동일한 출력 채널에 속하는 모든 입력 채널과 모든 chunk는 같은 `Sw[oc]`를 사용한다.

### 3.3 Bias 포맷

```text
형식  : signed INT32
단위  : Sx × Sw[oc]
개수  : 출력 채널 수
```

기본 bias 정수값은 다음과 같다.

```text
qb[oc] = round_nearest_even(
    b_folded[oc] / (Sx × Sw[oc])
)
```

## 4. BN folding

BN은 weight와 bias에 오프라인으로 합친 후 weight를 INT8로 양자화한다.

```text
a[oc] = gamma[oc] / sqrt(running_var[oc] + epsilon)

W_folded[oc] = W[oc] × a[oc]
b_folded[oc] = beta[oc] + (b[oc] - running_mean[oc]) × a[oc]
```

처리 순서는 반드시 다음과 같다.

```text
원본 Conv/BN 파라미터
→ BN folding
→ folded weight INT8 양자화
→ folded bias INT32 양자화
```

Weight를 먼저 양자화한 뒤 BN을 적용하지 않는다.

## 5. MAC와 zero-point 보정

Weight zero-point는 0이므로 convolution 정수식은 다음과 같다.

```text
acc[oc] =
    Σ (qx[ic] - Zx) × qw[oc][ic]
    + qb[oc]
```

DSP마다 `Zx`를 빼지 않도록 correction을 bias에 오프라인으로 포함한다.

```text
qb_corrected[oc] =
    qb[oc] - Zx × Σ qw[oc][ic]
```

그러면 RTL MAC은 다음 식만 계산한다.

```text
acc[oc] =
    Σ qx[ic] × qw[oc][ic]
    + qb_corrected[oc]
```

이 방식에서는 activation을 unsigned로 zero-extension하고 weight를 signed로 sign-extension한다.

```systemverilog
logic        [7:0] activation_u8;
logic signed [7:0] weight_s8;

logic signed [15:0] dsp_activation;
logic signed [15:0] dsp_weight;

assign dsp_activation = $signed({1'b0, activation_u8});
assign dsp_weight     = {{8{weight_s8[7]}}, weight_s8};
```

`activation_u8`을 `logic signed [7:0]`으로 선언하지 않는다. Full-range UINT8을 signed 8bit로 연결하면 `128..255`가 음수로 해석된다.

## 6. 내부 비트폭

| 신호 | 최소 권장 포맷 | 비고 |
|---|---|---|
| Activation | UINT8 | PTQ 기준 `0..127` |
| Weight | INT8 | `-127..127` |
| 단일 곱 | signed 16bit | UINT8 × INT8 |
| 64-MAC chunk sum | signed 32bit 이상 | DSP P 48bit 유지 가능 |
| 전체 input-channel 누산 | signed INT32 이상 | 192 또는 384채널 |
| Bias | signed INT32 | corrected bias 권장 |
| Requant 곱 결과 | signed 64bit 권장 | INT32 × multiplier |
| 최종 activation | UINT8 | saturation 후 저장 |

현재 48bit DSP cascade와 51bit adder-tree 출력은 범위상 충분하다. PSUM을 줄일 때는 상위 비트가 정상적인 sign-extension인지 assertion으로 검사하고 단순 절삭으로 overflow를 숨기지 않는다.

## 7. Project pointwise 데이터 스케줄

Layer 07 기준 권장 loop 순서는 다음과 같다.

```text
for oc = 0..63
    for pixel = 0..195
        for chunk = 0..2
            64 activation × 64 weight MAC
        3개 chunk 누적
        bias + requantization
        output_valid 1회
```

주소 규칙:

```text
input_addr  = pixel × PROJECT_CHUNKS + chunk
weight_addr = oc × PROJECT_CHUNKS + chunk
output_addr = pixel × 64 + oc       // layout에 맞춰 변경 가능
```

한 클럭에 공급하는 데이터는 다음과 같다.

```text
input_data  : 512bit = UINT8 activation 64개
weight_data : 512bit = INT8 weight 64개
```

Project Layer 07에서는 `chunk`가 매 클럭 `0→1→2`로 증가한다. 따라서 input과 weight의 512bit 묶음도 매 클럭 다음 입력 채널 chunk로 변경된다. 동일한 `oc`와 `pixel`에 대한 3개 chunk 결과만 하나의 PSUM에 합친다.

Packing 규칙:

```text
lane i = packed_data[i*8 +: 8]
lane 0 = packed word의 LSB byte
```

## 8. 64-MAC 구조

```text
64개 UINT8×INT8 곱
→ 8-DSP cascade × 8그룹
→ group_sum[0..7]
→ 8→4→2→1 registered adder tree
→ chunk_sum
→ PROJECT_CHUNKS회 PSUM
```

DSP cascade에 내부 pipeline register가 있으면 각 stage의 A/B 입력을 `PCIN` 도착 시점에 맞춰 skew해야 한다. 현재 설계 가정은 다음과 같다.

```text
첫 DSP A/B→P latency : 4 clocks
PCIN→P latency       : 1 clock/stage
8-DSP cascade        : 11 clocks
adder tree           : 3 clocks
chunk_sum latency    : 14 clocks
```

실제 DSP IP 설정이 바뀌면 이 latency를 다시 측정하고 valid와 `oc/pixel/chunk` tag를 같은 길이만큼 지연한다.

## 9. PSUM과 bias 적용

PSUM은 같은 `oc`, 같은 `pixel`의 chunk만 누적한다.

Layer 07의 192 입력 채널에서는:

```text
chunk 0: PSUM = chunk_sum
chunk 1: PSUM = PSUM + chunk_sum
chunk 2: ACC  = PSUM + chunk_sum + qb_corrected[oc]
```

마지막 chunk가 아닌 동안에는 출력 valid를 발생시키지 않는다. 마지막 chunk와 연결된 valid가 도착했을 때만 bias와 requantization을 수행한다.

## 10. Requantization

누산 결과를 다음 activation scale로 변환한다.

```text
real_multiplier[oc] = Sx × Sw[oc] / Sy

qout = clamp(
    round_nearest_even(acc × real_multiplier[oc]) + Zy,
    QMIN,
    QMAX
)
```

기존 PTQ bit-exact 기준:

```text
QMIN = 0
QMAX = 127
```

RTL에서는 출력 채널별 정수 multiplier와 shift를 사용한다.

```text
real_multiplier[oc] ≈ multiplier[oc] / 2^shift[oc]
```

```text
scaled  = acc × multiplier[oc]
rounded = round_nearest_even(scaled / 2^shift[oc])
qout    = saturate(rounded + Zy)
```

필요한 per-output-channel ROM:

| 항목 | 포맷 | 개수 |
|---|---|---:|
| Corrected bias | INT32 | OUT_CHANNELS |
| Weight scale | 개발/검증용 float | OUT_CHANNELS |
| Requant multiplier | INT32 권장 | OUT_CHANNELS |
| Requant shift | UINT8 권장 | OUT_CHANNELS |

## 11. ReLU6

Expand와 Depthwise 출력에는 ReLU6를 적용하고 Project 출력에는 적용하지 않는다.

정수 clamp 경계는 다음과 같다.

```text
Q_ZERO = round_nearest_even(0 / Sy) + Zy = Zy
Q_SIX  = round_nearest_even(6 / Sy) + Zy

Q_SIX = min(Q_SIX, QMAX)
```

```text
relu6(q) = clamp(q, Q_ZERO, Q_SIX)
```

ReLU6 이후 값이라고 해도 기존 affine PTQ에서는 실수 0이 정수 0이 아니라 `zero-point`로 표현될 수 있다.

## 12. 제어와 valid

`enable`은 입력을 발행하는 구간만 나타낸다. 출력 유효 시점은 전체 pipeline latency를 통과한 valid로 판단한다.

```text
issue_valid
→ DSP latency
→ adder-tree latency
→ PSUM/bias latency
→ requant latency
→ output_valid
```

최종 출력용 latency는 다음과 같이 관리한다.

```text
TOTAL_OUTPUT_LATENCY =
    DSP_LATENCY
  + ADDER_TREE_LATENCY
  + PSUM_BIAS_LATENCY
  + REQUANT_LATENCY
```

Requantization 단계를 추가한 뒤 기존 `TOTAL_LATENCY=14`를 최종 출력 valid에 그대로 사용하지 않는다. `done`은 마지막 입력을 발행한 시점이 아니라 마지막 requantized 출력이 유효해진 시점에 발생시킨다.

## 13. 네트워크 전체 연결 규칙

레이어 A의 출력이 레이어 B의 입력이면 두 경계는 동일한 정수 표현을 공유해야 한다.

```text
A output dtype/scale/zero-point
=
B input dtype/scale/zero-point
```

다르면 A의 출력에서 B의 입력 qparam으로 requantization을 수행한다.

Residual add가 있는 블록에서는 두 입력 branch를 동일한 scale과 zero-point로 맞춘 뒤 더한다. 서로 다른 정수값을 scale 변환 없이 바로 더하지 않는다.

## 14. 반올림과 saturation

기준 PTQ와 일치시키기 위해 다음 규칙을 고정한다.

```text
Weight quantization : round-to-nearest-even
Bias quantization   : round-to-nearest-even
Requantization      : round-to-nearest-even
Weight saturation   : -127..127
Activation saturation: 0..127
```

RTL에서 더 단순한 반올림을 사용하면 1 LSB 차이가 발생할 수 있다. 이 경우 bit-exact 실패로 기록하고 float-domain 오차를 별도로 평가한다.

## 15. 소프트웨어 생성물

Full PTQ 배포 파일에는 최소한 다음 정보가 필요하다.

```text
weights_int8.bin
bias_corrected_int32.bin
requant_multiplier_int32.bin
requant_shift_uint8.bin
activation_qparams.json
tensor_shape_and_layout.json
```

각 파일에는 shape, dtype, byte order, packing order, SHA-256을 manifest에 기록한다.

## 16. 검증 절차

1. BN-folded float 모델과 원본 float 모델을 비교한다.
2. Python integer reference에서 `qx`, `qw`, corrected bias, acc, requant 결과를 저장한다.
3. DSP 1개에 대해 UINT8×INT8 signedness를 검증한다.
4. 8-DSP cascade의 lane skew와 합을 검증한다.
5. 8개 group sum의 adder tree 결과를 64개 직접 합산과 비교한다.
6. 3개 chunk PSUM을 192개 직접 합산과 비교한다.
7. Bias 적용 전후 INT32 결과를 Python reference와 비교한다.
8. Multiplier, rounding, shift, zero-point, saturation을 bit-exact 비교한다.
9. 전체 Layer 07 출력의 Max/Mean absolute error, RMSE, cosine similarity를 float folded 결과와 비교한다.
10. synthesis 후 DSP, BRAM, LUT 및 timing slack을 기록한다.

필수 assertion:

```text
activation 범위 안에 있음
weight 범위 안에 있음
PSUM overflow 없음
출력 valid일 때 oc/pixel tag 일치
서로 다른 pixel 또는 oc의 chunk가 같은 PSUM에 섞이지 않음
마지막 출력과 done의 위치 일치
```

## 17. 현재 PTQ 기준 정확도

한 샘플 Layer 07 평가 결과:

| 비교 | Max abs error | Mean abs error | RMSE | Cosine similarity |
|---|---:|---:|---:|---:|
| PyTorch PTQ INT8 vs Float folded | `9.452078e-02` | `1.695102e-02` | `2.121780e-02` | `0.9988919043` |

이는 Layer 07 수치 오차이며 ImageNet Top-1 정확도 차이가 아니다. RTL이 동일한 PTQ 포맷을 bit-exact하게 구현하면 RTL 출력은 Python integer reference와 같아야 하고, float 대비 오차는 위 결과와 유사해야 한다.

## 18. 구현 결정 체크리스트

- [ ] 실제 대상이 Layer 07의 192 입력 채널인지 확인
- [ ] `PROJECT_CHUNKS=3`으로 설정
- [ ] Activation은 UINT8, weight는 INT8로 선언
- [ ] BN folding 후 weight를 양자화
- [ ] Input zero-point correction을 bias에 포함
- [ ] Bias를 INT32로 저장
- [ ] Per-output-channel multiplier와 shift 생성
- [ ] Requantization rounding 방식을 고정
- [ ] Activation saturation 범위를 `0..127`로 고정
- [ ] Expand/Depthwise에만 ReLU6 적용
- [ ] Requant latency만큼 valid/tag/done 지연
- [ ] Python integer reference와 bit-exact 검증

