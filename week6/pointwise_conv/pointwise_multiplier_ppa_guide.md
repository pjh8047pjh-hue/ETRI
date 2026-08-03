# Pointwise Convolution 곱셈기 개수별 PPA 비교 가이드

## 1. 설계 조건

Pointwise Convolution의 조건은 다음과 같다.

| 항목 | 값 |
|---|---:|
| 입력 Feature Map | `[64][14][14]` |
| Weight | `[384][64][1][1]` |
| 출력 Feature Map | `[384][14][14]` |
| Kernel | `1×1` |
| 입력 데이터 폭 | Signed Fixed-point 16bit |
| Weight 데이터 폭 | Signed Fixed-point 16bit |

전체 MAC 연산량은 다음과 같다.

$$
N_{\mathrm{MAC}}
=14\times14\times64\times384
=4,816,896\ \mathrm{MAC}
$$

곱셈기 $P$개가 매 클럭 모두 동작한다고 가정하면 이상적인 연산 사이클은 다음과 같다.

$$
Cycles_{\mathrm{ideal}}=
\left\lceil\frac{4,816,896}{P}\right\rceil
$$

---

## 2. 자율주행 기준 Layer08 목표 처리시간

자율주행 object detection은 실시간 처리 기준으로 보통 `20Hz`, 즉 `50ms/frame`을 목표로 잡을 수 있다. MobileNetV2 전체 backbone이 이 시간 안에 처리되어야 한다고 보면, 특정 layer의 목표 처리시간은 전체 연산량 중 해당 layer가 차지하는 비율로 1차 배분할 수 있다.

본 프로젝트의 MobileNetV2 224×224 기준 연산량은 다음과 같이 볼 수 있다.

| 항목 | 값 |
|---|---:|
| MobileNetV2 계산 layer | Conv 52개 + Classifier 1개 |
| 전체 연산량 | 약 `300.8M MAC` |
| Layer08 pointwise 연산량 | `4,816,896 MAC` |
| 전체 대비 Layer08 비율 | 약 `1.6%` |

따라서 `20Hz = 50ms/frame` 기준에서 Layer08의 목표 처리시간은 다음과 같다.

$$
T_{\mathrm{Layer08,target}}
=50ms\times\frac{4.816M}{300.8M}
\approx0.8ms
$$

30FPS camera 기준으로 더 엄격하게 잡으면 `33.3ms/frame × 1.6% ≈ 0.53ms`가 된다. 본 PPA 비교에서는 우선 자율주행 실시간 처리의 기본 기준을 `20Hz`로 두고, **Layer08 목표 처리시간을 약 `0.8ms`**로 설정한다.

이 목표는 최종 선택의 절대 기준이 아니라, 곱셈기 병렬도를 늘릴 때 어느 지점부터 성능 향상 대비 리소스 증가가 커지는지 판단하기 위한 기준선이다.

---

## 3. 곱셈기 개수별 이론값

아래 표는 Fixed16 입력과 Weight를 곱셈기마다 한 쌍씩 직접 공급하는 구조를 가정한다.

| 곱셈기 `P` | 예상 DSP | Input 읽기 폭 | Weight 읽기 폭 | 이상적 사이클 | 100MHz 처리시간 | 0.8ms 목표 만족 | 이전 구성 대비 감소 | 1개 대비 누적 감소 |
|---:|---:|---:|---:|---:|---:|:---:|---:|---:|
| 1 | 1 | 16bit | 16bit | 4,816,896 | 48.169ms | X | - | 0% |
| 2 | 2 | 32bit | 32bit | 2,408,448 | 24.084ms | X | 50% | 50% |
| 4 | 4 | 64bit | 64bit | 1,204,224 | 12.042ms | X | 50% | 75% |
| 8 | 8 | 128bit | 128bit | 602,112 | 6.021ms | X | 50% | 87.5% |
| 16 | 16 | 256bit | 256bit | 301,056 | 3.011ms | X | 50% | 93.75% |
| 32 | 32 | 512bit | 512bit | 150,528 | 1.505ms | X | 50% | 96.875% |
| 64 | 64 | 1024bit | 1024bit | 75,264 | 0.753ms | O | 50% | 98.4375% |

100MHz에서의 처리시간은 다음 식으로 계산하였다.

$$
T=\frac{Cycles}{100\times10^6}
$$

이 값은 BRAM latency, 곱셈기 pipeline latency, 주소 제어, Weight preload, 출력 저장 및 stall을 제외한 이상적인 값이다.

`P=64`는 하나의 `(pix, oc)` dot product에 필요한 64개 channel을 한 cycle에 모두 계산하는 구조이다. 따라서 `P>64`로 더 줄이려면 단일 dot product 내부 병렬화가 아니라 여러 output channel 또는 여러 pixel을 동시에 처리하는 상위 병렬화가 필요하다.

---

## 4. 추가 곱셈기 한 개당 얻는 시간 이득

곱셈기를 두 배로 늘릴 때 처리시간은 이상적으로 매번 50% 감소한다. 하지만 추가되는 곱셈기 한 개당 얻는 절대 시간 이득은 계속 작아진다.

| 변경 | 추가 곱셈기 | 전체 절약 시간 | 추가 곱셈기 1개당 절약 시간 |
|---|---:|---:|---:|
| 1 → 2 | 1개 | 24.084ms | 24.084ms |
| 2 → 4 | 2개 | 12.042ms | 6.021ms |
| 4 → 8 | 4개 | 6.021ms | 1.505ms |
| 8 → 16 | 8개 | 3.011ms | 0.376ms |
| 16 → 32 | 16개 | 1.505ms | 0.094ms |
| 32 → 64 | 32개 | 0.752ms | 0.0235ms |

곱셈기 수를 늘릴수록 성능은 증가하지만 DSP, BRAM 대역폭, 배선 복잡도 및 Dynamic Power도 함께 증가한다. 따라서 사이클 감소율만으로 최적 구성을 결정하면 안 된다.

---

## 5. 실제 측정 항목

| 분류 | 측정 항목 | 측정 또는 계산 방법 |
|---|---|---|
| 성능 | 실제 Cycle | 시뮬레이션에서 `start`부터 `done`까지 카운트 |
| 성능 | Post-route Fmax | Implementation 이후 Timing Report 확인 |
| 성능 | 실제 처리시간 | `실제 Cycle / Fmax` |
| 성능 | Layer08 target 만족 여부 | `실제 처리시간 ≤ 0.8ms` |
| 성능 | Target margin | `0.8ms - 실제 처리시간` |
| 성능 | Speedup | `T1 / Tp` |
| 병렬 효율 | Parallel Efficiency | `Speedup / P × 100` |
| 연산 효율 | Multiplier Utilization | `전체 MAC / (P × 실제 Cycle) × 100` |
| 면적 | DSP | Report Utilization의 DSP 사용량 |
| 면적 | LUT | Report Utilization의 LUT 사용량 |
| 면적 | FF | Report Utilization의 FF 사용량 |
| 메모리 | BRAM·LUTRAM | Report Utilization의 메모리 사용량 |
| 타이밍 | WNS·TNS | Report Timing Summary |
| 전력 | Dynamic Power | Report Power |
| 전력 | Static Power | Report Power |
| 에너지 | Energy/Inference | `Power × 실제 처리시간` |
| 전력 효율 | Performance/Watt | `Throughput / Power` |

### 5.1 실제 처리시간

곱셈기를 늘리면 사이클은 감소하지만 배선 복잡도로 인해 Fmax가 낮아질 수 있다. 따라서 사이클 수만 비교하지 않고 Post-route Fmax를 반영해야 한다.

$$
T_P=\frac{Cycles_P}{Fmax_P}
$$

### 5.2 Speedup

곱셈기 한 개 설계를 기준으로 실제 성능 향상 배수를 계산한다.

$$
Speedup_P=\frac{T_1}{T_P}
$$

### 5.3 병렬 효율

병렬 효율은 곱셈기를 늘린 만큼 실제 성능이 증가했는지를 보여준다.

$$
Efficiency_P=
\frac{Speedup_P}{P}\times100
$$

예를 들어 곱셈기 8개를 사용했지만 실제 Speedup이 6배라면 다음과 같다.

$$
Efficiency_8=\frac{6}{8}\times100=75\%
$$

나머지 25%의 손실은 BRAM 대역폭, 메모리 stall, 파이프라인 대기, 주소 제어, 누산기 또는 배선 지연에서 발생했을 가능성이 있다.

### 5.4 곱셈기 활용률

$$
Utilization_P=
\frac{4,816,896}{P\times Cycles_{\mathrm{actual}}}
\times100
$$

Weight preload와 출력 저장 사이클을 포함하면 end-to-end 활용률을 확인할 수 있고, 순수 연산 구간만 사용하면 MAC 데이터패스 자체의 활용률을 확인할 수 있다.

---

## 6. 면적 증가율

FPGA에서는 DSP, LUT, FF, BRAM을 하나의 면적 숫자로 단순히 더하지 않는다. 각 자원의 사용량과 증가율을 따로 비교하고, 가장 먼저 부족해지는 자원을 Area Bottleneck으로 판단한다.

$$
DSP\ 증가율=
\frac{DSP_P-DSP_1}{DSP_1}\times100
$$

$$
LUT\ 증가율=
\frac{LUT_P-LUT_1}{LUT_1}\times100
$$

$$
BRAM\ 증가율=
\frac{BRAM_P-BRAM_1}{BRAM_1}\times100
$$

단순 Fixed16 곱셈은 일반적으로 곱셈기 하나당 DSP48 하나를 예상할 수 있지만, 실제 DSP 사용량은 DSP IP 구성, pipeline, accumulator 구조와 합성 결과로 확인해야 한다.

---

## 7. 전력 및 에너지 비교

전력 증가율은 다음과 같이 계산한다.

$$
Power\ 증가율=
\frac{Power_P-Power_1}{Power_1}\times100
$$

처리시간 감소율은 다음과 같다.

$$
처리시간\ 감소율=
\frac{T_1-T_P}{T_1}\times100
$$

곱셈기를 늘리면 순간 전력은 증가할 수 있지만 처리시간이 짧아지므로 추론 한 번에 소비되는 에너지는 감소할 수 있다.

$$
Energy_P=Power_P\times T_P
$$

성능과 에너지를 함께 비교하려면 Energy-Delay Product를 사용할 수 있다.

$$
EDP_P=Energy_P\times T_P
$$

Vivado Power Report의 기본 Vectorless 추정만으로는 정확한 비교가 어렵다. 동일한 입력 데이터와 동작 구간에서 생성한 VCD 또는 SAIF switching activity를 각 설계에 동일하게 적용해야 한다.

---

## 8. 구현 결과

### 8.1 측정 조건

`2026-08-03`에 다음과 같은 공통 조건으로 `P=1, 2, 4, 8, 16, 32, 64`를
각각 합성하고 배치·배선하였다. 원본 집계 결과는
[`ppa_results/summary.csv`](ppa_results/summary.csv)에 있다.

| 항목 | 조건 |
|---|---|
| FPGA | `xczu3eg-sbva484-1-e` |
| Tool | Vivado `2020.2` |
| Timing constraint | `10ns`, 100MHz |
| Implementation | OOC `opt_design → place_design → phys_opt_design → route_design` |
| OOC clock root | `BUFGCE_X0Y0` |
| Timing 범위 | 내부 accelerator path, top input/output path는 false path |
| Cycle 범위 | `start`가 입력된 edge부터 output BRAM의 `done_w`까지 |
| Cycle 산출 | RTL FSM·MAC valid·output write 제어의 cycle-accurate model |
| Fmax | `1000 / (10ns - WNS)`로 계산한 post-route 추정값 |
| Power | Vivado vectorless activity 기반 post-route 추정값 |
| Energy | `Total Power × 처리시간` |

설치된 Vivado 2020.2의 XSim 실행 커널이 현재 Ubuntu 24 환경에서
segmentation fault를 발생시켜, cycle은 값 연산을 생략하고 현재 RTL의 순차
제어를 clock edge 단위로 재현한 모델에서 산출하였다. 모델 결과는 다음
구조식과 전 지점에서 일치한다.

$$
Cycles_{RTL}
=75,264\times\left(\frac{64}{P}+1\right)+2
$$

여기서 출력 하나마다 `64/P`개의 MAC cycle 외에 BRAM load cycle 1개가
추가되며, 마지막 MAC valid와 `done_w` 생성에 2 cycle이 더 필요하다.

### 8.2 성능 및 타이밍 결과

| P | RTL Cycle | WNS (ns) | TNS (ns) | 추정 Fmax (MHz) | 처리시간 (ms) | 0.8ms 만족 | Margin (ms) | Speedup | 병렬효율 | 곱셈기 활용률 |
|---:|---:|---:|---:|---:|---:|:---:|---:|---:|---:|---:|
| 1 | 4,892,162 | 4.517 | 0.000 | 182.38 | 26.824 | X | -26.024 | 1.000× | 100.00% | 98.46% |
| 2 | 2,483,714 | 4.612 | 0.000 | 185.60 | 13.382 | X | -12.582 | 2.004× | 100.22% | 96.97% |
| 4 | 1,279,490 | 5.046 | 0.000 | 201.86 | 6.339 | X | -5.539 | 4.232× | 105.80% | 94.12% |
| 8 | 677,378 | 4.705 | 0.000 | 188.86 | 3.587 | X | -2.787 | 7.479× | 93.48% | 88.89% |
| 16 | 376,322 | 4.002 | 0.000 | 166.72 | 2.257 | X | -1.457 | 11.884× | 74.27% | 80.00% |
| 32 | 225,794 | 3.669 | 0.000 | 157.95 | 1.430 | X | -0.630 | 18.764× | 58.64% | 66.67% |
| 64 | 150,530 | 2.642 | 0.000 | 135.91 | 1.108 | X | -0.308 | 24.218× | 37.84% | 50.00% |

모든 지점은 failed net 0으로 routing을 완료했고, 100MHz constraint에서
`WNS ≥ 0`, `TNS = 0`으로 timing을 만족하였다. Methodology violation도 모든
지점에서 0이다. `P=4`까지는 배치 결과 차이로 Fmax도 함께 증가하여
병렬효율이 100%를 약간 넘지만, `P≥8`에서는 adder tree와 배선 복잡도가
커지면서 Fmax와 병렬효율이 감소한다. `P=64`의 Fmax는 `135.91MHz`,
병렬효율은 `37.84%`이다.

DRC error는 없지만 multiplier 하나마다 DSP input pipeline 경고 `DPIP-2` 2개와
MREG output pipeline 경고 `DPOP-4` 1개가 발생한다. 또한 OOC top output 중
사용되지 않는 부하에 대한 `RTSTAT-10` 경고가 지점별로 1개 발생한다. 이 DSP
pipeline 경고는 고병렬 지점의 Fmax를 더 높이려면 multiplier와 adder tree의
pipeline 구조를 개선해야 한다는 근거로 볼 수 있다.

### 8.3 면적, 전력 및 에너지 결과

| P | DSP | LUT | FF | LUTRAM | BRAM tile | Dynamic (W) | Static (W) | Total (W) | Energy (mJ) | EDP (mJ·ms) |
|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 1 | 828 | 147 | 0 | 64.5 | 0.111 | 0.222 | 0.333 | 8.932 | 239.598 |
| 2 | 2 | 881 | 146 | 0 | 64.5 | 0.124 | 0.222 | 0.346 | 4.630 | 61.963 |
| 4 | 4 | 846 | 144 | 0 | 64.5 | 0.119 | 0.222 | 0.341 | 2.161 | 13.701 |
| 8 | 8 | 900 | 137 | 0 | 64.5 | 0.142 | 0.222 | 0.363 | 1.302 | 4.670 |
| 16 | 16 | 1,024 | 135 | 0 | 64.5 | 0.158 | 0.222 | 0.379 | 0.855 | 1.931 |
| 32 | 32 | 1,274 | 133 | 0 | 64.5 | 0.203 | 0.222 | 0.425 | 0.608 | 0.868 |
| 64 | 64 | 1,319 | 130 | 0 | 64.5 | 0.216 | 0.222 | 0.438 | 0.485 | 0.537 |

DSP는 의도대로 `P`와 동일하게 증가한다. 입력·weight·출력 memory 구성이
같으므로 BRAM은 모든 지점에서 `64.5 tile`로 일정하다. 병렬도를 높일수록
dynamic power는 대체로 증가하지만 처리시간 감소 폭이 더 커서 energy와 EDP는
계속 감소한다. 다만 power 값은 vectorless 추정이므로 절대값보다 동일 조건의
상대 추세로 해석해야 한다.

### 8.4 결과 해석

- 현재 구조에서 가장 빠르고 energy가 낮은 지점은 `P=64`이지만 처리시간은
  `1.108ms`로 목표보다 `0.308ms` 느리다.
- `P=64`가 `0.8ms`를 만족하려면 현재 `150,530 cycle` 기준 약
  `188.16MHz`가 필요하며, post-route 추정 Fmax `135.91MHz`보다 높다.
- 이상적 MAC cycle만 사용하면 `P=64`의 처리시간은 `0.554ms`이지만, 실제
  RTL에서는 출력마다 load cycle이 추가되어 cycle이 거의 두 배가 된다.
- `P=32 → 64`에서 DSP는 2배가 되지만 처리시간 감소는 `22.52%`, energy
  감소는 `20.15%`이고 병렬효율은 `58.64% → 37.84%`로 낮아진다. 따라서
  현 구조의 resource-performance knee는 `P=32`로 볼 수 있다.
- `P=32`도 목표를 만족하지 않으므로 strict 0.8ms 기준의 최종 후보는 없다.
  목표 달성을 위해서는 load와 MAC을 겹치는 구조, 여러 output channel/pixel의
  동시 처리, 또는 adder tree pipeline을 통한 Fmax 개선이 필요하다.

---

## 9. 공정한 비교를 위한 조건

곱셈기 개수별 설계를 비교할 때 다음 조건을 동일하게 유지해야 한다.

- 동일한 FPGA 디바이스와 speed grade
- 동일한 입력·Weight Fixed-point 비트폭
- 동일한 accumulator 비트폭과 rounding·saturation 방식
- 동일한 Vivado 합성 및 Implementation strategy
- 동일한 타이밍 제약 조건
- 동일한 입력 데이터와 switching activity
- 동일한 Weight preload 및 출력 저장 포함 여부
- 동일한 BRAM 구조와 데이터 배치 방식

곱셈기 IP 종류와 곱셈기 개수를 동시에 변경하면 원인을 분리하기 어렵다. 먼저 동일한 곱셈기 구현 방식에서 `P=1, 2, 4, 8, 16, 32, 64`만 변경하여 비교하는 것이 적절하다.

---

## 10. 최종 선택 기준

최적 구성은 단순히 가장 빠른 설계가 아니다. 본 설계에서는 Layer08 목표 처리시간 `0.8ms`를 기준으로, 요구 성능을 만족하면서 성능 향상 대비 리소스 증가가 커지는 지점에서 병렬도 증가를 멈추는 것을 목표로 한다.

다음 조건을 만족하는 설계를 선택한다.

1. 목표 처리시간 또는 Throughput을 만족한다.
2. WNS가 0 이상이며 타이밍을 만족한다.
3. DSP, LUT, FF, BRAM 사용량이 디바이스 한도 이내이다.
4. Energy/Inference가 낮다.
5. 곱셈기를 추가했을 때 얻는 성능 향상이 면적과 전력 증가를 정당화한다.

다른 설계보다 처리시간, 면적, 에너지가 모두 나쁘지 않은 구성을 Pareto 후보로 선정하고, 그중 요구 성능을 만족하면서 에너지가 가장 낮은 구성을 PPA 최적점으로 선택한다.

실제 구현 결과에서는 모든 후보가 `0.8ms` 목표를 만족하지 못했다. 현재 후보
중 `P=64`가 `1.108ms`로 가장 빠르고 energy도 가장 낮지만 strict target의
PPA 최적점으로 선택할 수는 없다. 성능 향상 대비 resource 증가가 꺾이는
knee는 `P=32`이며, 실제 자율주행 full-system target을 위해서는 output
channel/pixel 병렬화, load-MAC overlap 또는 adder tree pipeline이 필요하다.
