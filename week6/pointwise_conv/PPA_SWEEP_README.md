# Pointwise `PARALLEL_CH` PPA sweep 자동화

원본 `pointwise_conv.xpr`와 `pointwise_pkg.sv`를 변경하지 않고 다음 지점을
자동으로 비교한다.

```text
PARALLEL_CH = 1, 2, 4, 8, 16, 32, 64
```

각 지점에서 다음 작업을 수행한다.

1. 지점 전용 `pointwise_pkg.sv` 생성
2. Vivado out-of-context 합성
3. multiplier/BRAM IP의 OOC DCP 연결
4. `opt_design`, `place_design`, `phys_opt_design`, `route_design`
5. utilization, timing, clock, power, DRC, methodology 리포트 생성
6. 현재 RTL의 FSM·valid·write-counter 상태 전이를 재현하는 cycle-accurate
   모델로 `start`부터 `done_w`까지 cycle 계산
7. 모든 지점의 PPA 파생 지표를 `summary.csv`로 집계

## 실행

프로젝트 디렉터리에서 다음 명령을 실행한다.

```bash
./scripts/run_ppa_sweep.sh
```

빠르게 합성 자동화만 확인하려면 일부 지점과 `--synth-only`를 사용한다.

```bash
./scripts/run_ppa_sweep.sh --points 1,4,64 --synth-only --force
```

두 지점을 동시에 실행하려면 다음과 같이 지정한다. Vivado 프로세스 하나당
수 GB의 메모리를 사용할 수 있으므로 기본값은 안전하게 `--jobs 1`이다.

```bash
./scripts/run_ppa_sweep.sh --jobs 2 --threads 4
```

주요 옵션은 `./scripts/run_ppa_sweep.sh --help`에서 확인할 수 있다.

## 결과

기본 결과 디렉터리는 `ppa_results`이다.

```text
ppa_results/
├── summary.csv
├── p1/
│   ├── utilization.rpt
│   ├── timing_summary.rpt
│   ├── power.rpt
│   ├── drc.rpt
│   ├── methodology.rpt
│   ├── cycles/cycle_count.txt
│   └── vivado.log
└── p2/ ... p64/
```

`summary.csv`에는 cycle, WNS/TNS, 추정 Fmax, 처리시간, speedup, 병렬 효율,
multiplier 활용률, DSP/LUT/FF/BRAM/LUTRAM, 전력, inference당 energy, EDP가
포함된다.

## 비교 조건과 제한

- top-level의 `input_data`가 1024-bit라 대상 디바이스의 물리 I/O 핀 수를
  초과한다. 따라서 이 자동화는 핀 배치를 제외한 코어 PPA 비교를 위해 모든
  지점을 동일한 out-of-context 조건으로 구현한다. OOC clock root는
  `BUFGCE_X0Y0`로 고정하고 top input/output 경로는 false path로 두어 내부
  accelerator Fmax를 비교한다. parent interface timing은 full-system 통합 후
  별도로 확인해야 한다.
- 현재 RTL은 마지막 묶음의 남는 channel을 mask하지 않으므로
  `PARALLEL_CH`가 `IN_CH=64`의 약수여야 한다. 기본 일곱 지점 이외의 값은
  스크립트가 거부한다.
- `report_power`는 기본 vectorless activity를 사용한다. 상대 비교에는 쓸 수
  있지만 정확한 dynamic power 비교에는 동일 입력에서 얻은 SAIF/VCD를 모든
  지점에 적용해야 한다.
- `Fmax`는 설정 period와 post-route WNS로부터 `1000 / (period - WNS)`로
  계산한다.
- cycle 값의 `cycle_source`는 `rtl_control_model`이다. 모델은 현재 RTL의
  `FSM_pointwise`, MAC valid pipeline, output write/done 제어를 clock edge
  단위로 재현하며 결과는 `75264 × (64/P + 1) + 2`와 교차 검증한다. 설치된
  Vivado 2020.2의 XSim 커널은 현재 Ubuntu 24에서 실행 시 segmentation fault가
  발생하므로 기본 sweep에서 XSim을 사용하지 않는다.
