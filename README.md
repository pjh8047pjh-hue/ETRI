# ETRI 반도체 설계 교육 아카이브

2026-06-25 ~ 2026-08-28, ETRI 반도체 설계 교육 과정에서 진행한 실습과 최종 프로젝트를 모은 저장소입니다.
Verilog/SystemVerilog RTL 기초부터 AMBA 버스, Vivado/Vitis 흐름을 거쳐,
**MobileNetV2 Layer-08(PW → DW → PW) 가속기를 Ultra96-v2 보드에서 동작시키는 것**까지가 한 줄기로 이어집니다.

- 대상 보드: **Ultra96-v2** (Zynq UltraScale+ `xczu3eg-sbva484-1-e`) / 일부 초반 실습은 ZedBoard
- 툴체인: **Vivado 2020.2**, **Vitis 2020.2**, Python 3.12(uv)
- 커밋 55개, 2026-07-08 ~ 2026-08-28

---

## 1. 바로 보고 싶다면

목적별 진입점입니다.

| 하고 싶은 것 | 가는 곳 |
|---|---|
| 최종 결과물이 뭔지 한눈에 보기 | 이 문서 [3. 최종 프로젝트](#3-최종-프로젝트--mobilenetv2-layer-08-가속기) |
| **보드에 바로 올려보기** (재빌드 없이) | [project_mobilenetV2/boot/README.md](project_mobilenetV2/boot/README.md) |
| Vivado로 설계 열어보기 | [project_mobilenetV2_delivery/README_TRANSFER.md](project_mobilenetV2_delivery/README_TRANSFER.md) |
| 다른 PC에서 Vitis 환경 다시 만들기 | [project_mobilenetV2/VITIS_SETUP.md](project_mobilenetV2/VITIS_SETUP.md) |
| 설계 사양과 수치 근거 | [project_mobilenetV2_delivery/SPEC_full_ptq_hw.md](project_mobilenetV2_delivery/SPEC_full_ptq_hw.md) |
| 성능 기준선 (사이클 수) | [project_mobilenetV2/MOBILENET_CYCLE_BASELINE.md](project_mobilenetV2/MOBILENET_CYCLE_BASELINE.md) |
| 구조 선택의 이유 | [project_mobilenetV2/PW_DW_PW_ARCHITECTURE_TRADEOFF.md](project_mobilenetV2/PW_DW_PW_ARCHITECTURE_TRADEOFF.md) |
| DSP cascade가 왜 이득인지 (전력 실측 비교) | [project_mobilenetV2/power_compare/README.md](project_mobilenetV2/power_compare/README.md) |
| 날짜별 작업 기록 | [JH_daily_log.md](JH_daily_log.md), [week7/DAILY_LOG.md](week7/DAILY_LOG.md) |

---

## 2. 학습 경로 (주차별)

| 주차 | 폴더 | 주제 | 남아 있는 핵심 산출물 |
|---|---|---|---|
| 1주차 | [week1/](week1/) | C로 영상처리 · MobileNetV2 레이어 분석 · PTQ 양자화 | [2D_conv_padding.c](week1/06_25/2D_conv/2D_conv_padding.c), [layer8.c](week1/06_25/MobileNet/layer8.c), [layer07 BN folding·INT8 양자화](week1/06_26/MobileNet/layer07/), [layer08 Q3.12 HW 데이터셋](week1/06_26/MobileNet/layer08/q312_hw/) |
| 2주차 | [week2/](week2/) | Vivado 입문 — 카운터, BCD-to-7seg, 4bit 곱셈기, PMOD UART | [project_top_counter/](week2/project_top_counter/), [project_bcd2ssd/](week2/project_bcd2ssd/), [project_pmoduart/](week2/project_pmoduart/) |
| 3주차 | [week3/](week3/) | 메모리 인터페이스 → **APB** → AXI4-to-APB 브리지 → GPIO | [07_08/axi4_to_apb](week3/07_08/axi4_to_apb/), [07_09/S04_ex_gpio_apb](week3/07_09/S04_ex_gpio_apb/) |
| 4주차 | [week4/](week4/) | **AXI4-Lite** 슬레이브, UART CSR, 간이 **DMA** | [07_15/S07_AXI_초보자_상세_설명.md](week4/07_15/S07_AXI_초보자_상세_설명.md), [07_16/S07_dma_axi_simple](week4/07_16/S07_dma_axi_simple/) |
| 5주차 | [week5/](week5/) | 4bit 곱셈기 + UART 통합 (보드 실동작) | [mul_4bit_uart/](week5/mul_4bit_uart/) |
| 6주차 | [week6/](week6/) | BRAM(single/dual port), ROM, 곱셈기, **pointwise conv** PPA 스윕 | [pointwise_conv/PPA_SWEEP_README.md](week6/pointwise_conv/PPA_SWEEP_README.md) |
| 7주차 | [week7/](week7/) | **Depthwise 3×3** DSP 시스톨릭 구조 · zero padding 검증 | [DAILY_LOG.md](week7/DAILY_LOG.md), [depthwise/SPEC_depthwise_hw.md](week7/depthwise/SPEC_depthwise_hw.md), [NOTE_zero_padding_compare.md](week7/depthwise/NOTE_zero_padding_compare.md) |
| 8주차~ | [project_mobilenetV2/](project_mobilenetV2/) | 전체 통합, PS 연동, 보드 bring-up | 아래 3절 |

기타 폴더

- [assignment/](assignment/) — 과제용 Vivado 프로젝트
- [ip_lib/](ip_lib/) — 재사용 IP 설정 모음 (`dsp48_mac`, `dsp48_mul`, `blk_mem_gen_0`, `clk_wiz_0`) 및 재생성 Tcl
- [test0812/](test0812/), [test_0814/](test_0814/) — 통합 중 만든 실험용 프로젝트
- [mobilenetV2_1_1/](mobilenetV2_1_1/) — MobileNetV2 데이터패스를 **패키지드 IP**로 묶은 버전 (`component.xml`)
- [scripts/](scripts/) — Notion 일지 자동화 (`New-DailyLogPage.ps1`)

---

## 3. 최종 프로젝트 — MobileNetV2 Layer-08 가속기

`14×14×64` → **PW1** → `14×14×384` → **DW 3×3 s1 p1** → **PW2** → `14×14×64`
전 구간 고정소수점 Q3.12, 100 MHz, Ultra96-v2 PL에서 동작하고 PS(A53)가 결과를 읽어 검증합니다.

### 3.1 측정된 결과

| 항목 | 값 | 근거 |
|---|---:|---|
| 전체 지연 | **248,832 cycle = 2.488 ms @ 100 MHz** | [MOBILENET_CYCLE_BASELINE.md](project_mobilenetV2/MOBILENET_CYCLE_BASELINE.md) |
| DSP 사용 | 137 → **274** (2배 병렬화 후) | [OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md) |
| 출력 개수 | 12,544 (`14×14×64`) | [main.c](project_mobilenetV2/mobilenetV2_test/src/main.c) |
| 비트스트림 | `design_1_wrapper.bit` 5.4 MB | [boot/README.md](project_mobilenetV2/boot/README.md) |

DSP cascade vs. MAC+가산트리 (PW2 데이터패스만, OOC 400 MHz P&R):

| 지표 | MAC + accumulator | DSP cascade |
|---|---:|---:|
| Total on-chip power | 0.519 W | **0.481 W** (-7.3%) |
| Logic LUT | 926 | **254** (-72.6%) |
| Register | 1,841 | 4,228 |
| 400 MHz WNS | -3.122 ns (실패) | **+0.836 ns (통과)** |

> cascade는 파이프라인 레지스터가 늘어 클럭 전력은 증가하지만, 팹릭 리덕션 트리를 없애서
> 신호·CLB·DSP 전력 감소가 이를 상쇄합니다. 상세: [power_compare/README.md](project_mobilenetV2/power_compare/README.md)

### 3.2 RTL 구성

[project_mobilenetV2/project_mobilenetV2.srcs/sources_1/new/](project_mobilenetV2/project_mobilenetV2.srcs/sources_1/new/)

| 파일 | 역할 |
|---|---|
| `mobilenetV2.sv` | 최상위. PW1 → DW → PW2 시퀀싱과 배리어 제어 |
| `pointwise_before_depth.sv`, `top_pointwis_before_depth.sv` | PW1 (64 DSP) |
| `pointwise_after_depth.sv`, `top_pointwise_after_depth.sv` | PW2 (8 그룹 × 8단 DSP cascade) |
| `interconnect_bram_d2p.sv` | DW → PW2 채널 레인 정렬 BRAM |
| `ReLU6.sv`, `ReLU6_pw.sv` | BN folding 후 ReLU6 + saturation |
| `mem_pointwise_after_weight.sv` | PW2 weight 메모리 |
| `skip_connection.sv` | inverted residual skip 경로 |

Depthwise MAC 본체는 [week7/depthwise/](week7/depthwise/)와 [mobilenetV2_1_1/src/](mobilenetV2_1_1/src/)에 있습니다.

### 3.3 테스트벤치

[project_mobilenetV2.srcs/sim_1/new/](project_mobilenetV2/project_mobilenetV2.srcs/sim_1/new/) —
`tb_mobilenet.sv`(전체), `tb_pointwise_before_depth.sv`, `tb_pointwise_after_depth.sv`, `tb_depth_mac_valid.sv`

골든 데이터는 [week1/06_26/MobileNet/layer08/q312_hw/](week1/06_26/MobileNet/layer08/q312_hw/)의
PyTorch 기준 출력에서 나왔고, `.coe` 변환은 [project_mobilenetV2/coe/](project_mobilenetV2/coe/)의
`gen_coe.ps1` / `gen_coe_after_depth.ps1`가 담당합니다.

### 3.4 하드웨어 검증 스크립트

[project_mobilenetV2/verification/](project_mobilenetV2/verification/) — 래퍼 레벨 GPIO/done 핸드셰이크 검증

```powershell
vivado -mode batch -source verification/run_wrapper_gpio_done_verify.tcl -nolog -nojournal
```

보드 bring-up 중 사용한 XSCT 디버그 스크립트는
[week1/06_26/MobileNet/layer08/vitis_temp/](week1/06_26/MobileNet/layer08/vitis_temp/)에 있습니다
(`read_regs.tcl`, `read_ocm_probe.tcl`, `read_gpio_diag.tcl` 등).

---

## 4. 실행 방법

### 4.1 보드에 올리기 (가장 빠름 — Vivado 불필요)

Vitis(또는 XSCT)와 보드 드라이버만 있으면 됩니다.

```bash
hw_server                                   # 별도 터미널
xsct project_mobilenetV2/run_ocm.tcl        # 저장소 루트에서
```

UART 115200으로 결과가 출력됩니다. 상세: [boot/README.md](project_mobilenetV2/boot/README.md)

### 4.2 Vivado로 설계 열기

전달본을 쓰는 쪽이 가볍고 확실합니다.

```
Vivado 2020.2 → project_mobilenetV2_delivery/project_mobilenetV2.xpr
→ (IP 출력물 없다는 메시지 시) Generate Output Products
```

일괄 점검: `vivado -mode batch -source verification/check_project.tcl -nolog -nojournal`

### 4.3 Vitis 앱 다시 빌드

XSA와 앱 소스만 추적하고 플랫폼 트리는 추적하지 않습니다(절대경로 문제).
[VITIS_SETUP.md](project_mobilenetV2/VITIS_SETUP.md)의 순서를 그대로 따라가면 됩니다.

---

## 5. 저장소 규칙

- **추적하는 것**: RTL/C/Python 소스, 테스트벤치, `.xci` IP 설정, `.coe`/`.mem`, `.xpr`, Tcl 스크립트,
  설계 문서, 그리고 보드에 바로 올릴 수 있는 `boot/` 산출물
- **추적하지 않는 것**: Vivado `.cache`/`.gen`/`.runs`(일부 예외)/`.sim`, Vitis 플랫폼 트리와 워크스페이스
  메타데이터, `.venv`, 로그 — 모두 툴이 재생성합니다. 규칙은 [.gitignore](.gitignore) 참고
- 작업 지침과 인수인계 규칙은 [AGENTS.md](AGENTS.md), 일지 작성 규칙은 [DAILY_LOG_GUIDE.md](DAILY_LOG_GUIDE.md)

## 6. 남은 과제

[OPTIMIZATION_PLAN.md](OPTIMIZATION_PLAN.md)에 정리한 2배 병렬화(274 DSP, 예상 사용률 76%)가
설계·구현까지 진행된 상태이며, end-to-end 실측 재검증이 다음 단계입니다.
[week7/DAILY_LOG.md](week7/DAILY_LOG.md)의 "5. 미해결 / 다음" 절도 함께 보세요.
