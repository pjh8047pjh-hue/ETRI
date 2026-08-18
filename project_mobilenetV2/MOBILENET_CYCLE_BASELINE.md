# MobileNetV2 Layer-08 사이클 베이스라인

현재 RTL(작업 트리) 실측 기준. 최적화 전/후 비교의 기준선.

- 대상: `14×14×64` → PW1 → `14×14×384` → DW 3×3 s1 p1 → PW2 → `14×14×64`
- 클럭 100 MHz (`clk_wiz_0`: 40 MHz in → 100 MHz)
- Top: [mobilenetV2.sv](project_mobilenetV2.srcs/sources_1/new/mobilenetV2.sv)

---

## 1. 전체 사이클

| 구간 | cycle | 비고 |
|---|---:|---|
| PW1 MAC | 75,264 | `196 px × 384 oc × ⌈64/64⌉` |
| **배리어 1** | — | `start_r = done_w` |
| PW1 readout ∥ DW | 98,304 | `16×16 × 384ch`, DW 완전 중첩 |
| **배리어 2** | — | `start = write_done` |
| PW2 | 75,264 | `196 px × 64 oc × 6 chunk` |
| **합계** | **248,832** | 고정 drain 약 30 cycle 별도 |

**2.488 ms @ 100 MHz**

---

## 2. 스테이지별 상세

| 스테이지 | 모듈 | DSP | 루프 순서 (안→밖) | 처리량 | cycle |
|---|---|---:|---|---|---:|
| PW1 | `pointwise` | 64 | ic → **oc → pix** | 1 out/clk | 75,264 |
| PW1 out | `mem_layer08_out` | — | col → row → ch | 1 slot/clk | 98,304 |
| DW | `depth_top` | 9 | col → row → ch | 1 out/clk | (중첩) |
| D2P | `interconnect_bram_d2p` | — | pix → ch | 1 lane/clk | (중첩) |
| PW2 | `top_pointwise_after_depth` | 64 | chunk → pix → **oc** | 1 out/6clk | 75,264 |

### 유효 데이터 비율

| 스테이지 | 발행 | 유효 | 비율 |
|---|---:|---:|---:|
| PW1 readout | 98,304 slot | 75,264 | 76.6% |
| DW 출력 | 98,304 slot | 75,264 | 76.6% |
| PW2 입력 read | 75,264 | 12,544 out | 6:1 |

### 고정 지연 (총량 대비 무시 가능)

| 위치 | clk | 근거 |
|---|---:|---|
| PW1 MAC | 2 | mult 1 + accum 1 |
| PW1 out valid | 3 | `reading_d2` |
| ReLU6 | 1 | |
| DW | 6 | `OUTPUT_LATENCY` |
| PW2 | 17 | `BRAM_LATENCY 2` + `TOTAL_LATENCY 14` + sum 1 |

---

## 3. 엔진 가동률 — 핵심 문제

세 엔진 모두 **약 30%만 일하고 70%는 논다.**

| 엔진 | 실제 연산 | 전체 | 가동률 |
|---|---:|---:|---:|
| PW1 (64 DSP) | 75,264 | 248,832 | 30.2% |
| DW (9 DSP) | 75,264 | 248,832 | 30.2% |
| PW2 (64 DSP) | 75,264 | 248,832 | 30.2% |

DSP는 137개(38.1% of 360)가 상시 배치되어 있으나 동시에 도는 구간이 없다.

---

## 4. 낭비 분석

| # | 낭비 | cycle | 원인 |
|---|---|---:|---|
| 1 | PW1↔DW 직렬화 | 75,264 | PW1이 pixel-major → channel-major 전치 필요 → 전 프레임 대기 |
| 2 | zero-pad 슬롯 | 23,040 | 채널당 256슬롯 중 60개가 pad (`60 × 384`) |
| 3 | DW↔PW2 직렬화 | 75,264 | CHW→HWC 레이아웃 전환, byte-lane scatter |
| 4 | PW2 read 증폭 | 0* | 입력맵 64회 재독 (\*연산 bound라 cycle 손해는 없음) |

**이론 하한**: 세 스테이지 완전 중첩 시 `max(75,264, 75,264, 75,264)` = **75,264 cycle (0.753 ms, 3.3배)**
pad 슬롯을 좌표 마스킹으로 줄이면 DW가 `211 × 384 = 81,024`로 바닥 → 현실적 하한 **81,024 cycle (3.07배)**

---

## 5. 메모리 레이아웃 (전환 지점 = 배리어 원인)

| 메모리 | 크기 | 인덱스 | 레이아웃 |
|---|---|---|---|
| PW1 입력 | 1024b × 196 | `addr = pix` | HWC |
| PW1 weight | 1024b × 384 | `addr = oc` | oc-major |
| **PW1 출력** | 16b × 75,264 | `addr = oc*196 + pix` | **HWC→CHW 전치** |
| DW weight | 144b × 384 | `addr = ch` | 채널당 3×3 |
| **D2P** | 1024b × 1176 | `addr = pix*6 + ch[8:6]`, `lane = ch[5:0]` | **CHW→HWC 전치** |
| PW2 weight | 1024b × 384 | `addr = oc*6 + chunk` | oc-major |

두 번의 전치가 곧 두 개의 배리어다. **PW1 출력 BRAM 35.5 tile + D2P BRAM 약 35.5 tile ≈ 71 tile**이 중간 feature map에만 쓰인다.

---

## 6. 최적화 후보 (비교용)

| 안 | 방법 | cycle | 배속 | BRAM | 난이도 |
|---|---|---:|---:|---:|---|
| **A. 현재** | — | 248,832 | 1.00× | 기준 | — |
| **B. PW1 루프 재정렬** | `oc` outer/`pix` inner → 전치 소멸, `start_r` 조기 기동 | 173,764 | 1.43× | 동일 | 인덱스만 |
| **C. B + 출력 BRAM 제거** | PW1이 16×16 raster 직접 생성 | 173,568 | 1.43× | **−35.5 tile** | 인덱스만 |
| **D. C + pad 슬롯 제거** | DW가 좌표 마스킹으로 padding 생성 (256→211) | 156,288 | 1.59× | −35.5 tile | `depth_mac` 수정 |
| **E. D + PW2 chunk credit** | PW2 chunk-outer 재정렬 + partial-sum BRAM | 93,568 | 2.66× | −35.5, +10 | 누산기 BRAM 신규 |
| **F. 완전 streaming** | output-stationary PW2 + 2-row line buffer | 81,024 | 3.07× | **−71, +6** | 전면 재작성 |

B~C는 DW/interconnect/PW2/COE를 **한 줄도 안 건드린다** (DW가 보는 스트림 포맷 불변).

---

## 7. 검증 기준값

[verification/tb_mobilenet_verify.sv](verification/tb_mobilenet_verify.sv) 카운트 기대값 — 최적화 후에도 유지되어야 함.

| 신호 | 기대값 |
|---|---:|
| `pw_mac` | 75,264 |
| `pw_stream` | 98,304 |
| `start_depth` | 1 |
| `depth_valid` | 75,264 |
| `write_done` | 1 |
| `p2_issue` | 75,264 |
| `p2_output` | 12,544 |

주의: PW1 루프를 재정렬하면 [tb:242-244](verification/tb_mobilenet_verify.sv#L242-L244)의 MAC golden 인덱스 식(`n/384 = pix` 전제)을 함께 바꿔야 한다. 카운트는 불변.

---

## 8. 확인된 파라미터

| 항목 | 값 | 위치 |
|---|---|---|
| `PARALLEL_CH` / `IN_CH` | 64 / 64 | `pointwise_pkg.sv` |
| `WEIGHT_WIDTH` / `CHANNEL_WIDTH` | 384 / 196 | `pointwise_pkg.sv` |
| DW `SP` / `ROW_LEN` | 16 / 16 | `depth_mac.sv:4,35` |
| DW `window_valid` | `row≥2 && col≥2` → 196/ch | `depth_mac.sv:208` |
| DW weight 채널 주기 | 256 clk | `mem_depth_weight.sv:55` |
| PW2 `CHUNK` / `OUT_CH` | 6 / 64 | `top_pointwise_after_depth.sv:59-60` |
| 데이터 폭 | 전 구간 Q3.12 16-bit | |

`mem_layer08_out`(256 slot/ch) · `mem_depth_weight`(256 clk/ch) · `depth_mac`(SP=ROW_LEN=16) 세 모듈의 행 길이 계약은 현재 일치한다.
