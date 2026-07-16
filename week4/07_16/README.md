# 07_16 학습 폴더 상세 설명

> 2026-07-16 업데이트: 폴더 구성이 바뀌어 (`S06_uart_axi_lite_zedboard` 제거/이동, `S07_ex_dma_axi_simple_zedboard` 신규 추가) 문서를 현재 상태 기준으로 다시 정리했습니다.

`week4/07_16` 아래에는 두 개의 서브프로젝트가 있습니다. 하나는 IP 코어 자체(RTL+시뮬레이션+SW 드라이버), 다른 하나는 그 IP를 실제 Zedboard(Zynq-7000)에 얹는 보드 통합 프로젝트로, 서로 짝을 이룹니다.

```
07_16/
├── S07_dma_axi_simple/              # AXI4 마스터 DMA (mem-to-mem copy) IP 코어 — RTL+시뮬레이션+SW 드라이버 풀세트
└── S07_ex_dma_axi_simple_zedboard/  # 위 DMA IP를 Zedboard PS(ARM)와 연결하는 보드 통합 예제 (hw+sw)
```

두 폴더 모두 Future Design Systems(FDS)/Ando Ki 계열 실습 코드 스타일(`Clean.bat/.sh/.csh`, 재귀 `Makefile`, `RunXXX.bat` 스크립트)을 따릅니다.

---

## 1. S07_dma_axi_simple (IP 코어)

**목적**: AXI4 마스터로 메모리 간 복사(memory-to-memory DMA)를 수행하고, AXI4-Lite 슬레이브로 CSR(제어/상태 레지스터)을 노출하는 완결된 IP. RTL, 시뮬레이션 벤치, Vivado 합성 결과, C 드라이버, 데이터시트(PDF)까지 전체 세트가 들어있는 자체 완결형 프로젝트입니다.

### 1-1. 전체 계층 구조

[rtl/verilog/INDEX.txt](S07_dma_axi_simple/rtl/verilog/INDEX.txt)에 적힌 계층도는 실제 코드와 약간 다릅니다(오래된 문서로 보임 — `csr_axi.v`/`csr_read.v`/`csr_write.v`는 존재하지 않고, 현재는 `dma_axi_simple_axi_lite_if.v` + `dma_axi_simple_csr.v` 두 파일로 통합되어 있습니다). 실제 `include` 관계 기준 계층은 다음과 같습니다.

```text
dma_axi_simple.v                              (top, AXI4 M + AXI4-Lite S 포트, IRQ)
 ├─ dma_axi_simple_csr.v
 │   ├─ dma_axi_simple_axi_lite_if.v           (AXI4-Lite 슬레이브 FSM → bram 스타일 rd/wr 버스로 변환)
 │   └─ dma_axi_simple_csr_core.v              (csr.v 안에 함께 정의된 실제 레지스터 파일)
 └─ dma_axi_simple_core.v
     ├─ dma_axi_simple_core_read.v             (AXI4 AR/R 채널 — SRC에서 읽어 FIFO에 push)
     ├─ dma_axi_simple_core_write.v            (AXI4 AW/W/B 채널 — FIFO에서 pop해 DST에 씀)
     └─ dma_axi_simple_fifo_sync_small.v        (read↔write 사이 동기 FIFO, 기본 depth=16, width=data+strb)
```

`dma_axi_simple_defines.v`는 `` `AMBA_AXI_MASTER_PORT `` 등 매크로 모음이지만 현재 어느 파일에서도 `` `include ``되지 않는 **미사용(legacy) 파일**입니다.

### 1-2. Top module — [dma_axi_simple.v](S07_dma_axi_simple/rtl/verilog/dma_axi_simple.v)

포트 3개 그룹:
- `m_axi_*` : AXI4 마스터 (DMA가 실제로 메모리를 읽고 쓰는 포트, ID/ADDR/DATA 폭은 파라미터화)
- `s_axi_lite_*` : AXI4-Lite 슬레이브 (CPU가 CSR을 제어하는 포트)
- `IRQ` : DMA 완료 인터럽트

`u_csr`(제어 레지스터)와 `u_core`(실제 DMA 엔진)를 인스턴스화하고, 그 사이를 8개의 `DMA_*` 신호로 연결합니다 ([dma_axi_simple.v:189-198](S07_dma_axi_simple/rtl/verilog/dma_axi_simple.v#L189-L198)):

| 신호 | 방향(csr→core) | 의미 |
| --- | --- | --- |
| `DMA_EN` | csr → core | 전체 enable (CONTROL bit31) |
| `DMA_GO` | csr → core | 전송 시작 트리거 (1클럭 pulse 성격, NUM.GO & EN) |
| `DMA_BUSY` | core → csr | read/write 엔진 중 하나라도 busy면 1 (`DMA_BUSY_R \| DMA_BUSY_W`) |
| `DMA_DONE` | core → csr | read/write 엔진 둘 다 done이어야 1 (`DMA_DONE_R & DMA_DONE_W`) |
| `DMA_SRC` / `DMA_DST` | csr → core | 32비트 소스/목적 주소 |
| `DMA_BNUM` | csr → core | 전송할 총 바이트 수 (16비트) |
| `DMA_CHUNK` | csr → core | 한 버스트 트랜잭션당 바이트 수 (AxLEN 산정용, 8비트) |

같은 클럭 도메인 가정 하에 단순 `assign`으로 연결되며, [dma_axi_simple_core.v:190](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core.v#L190) 주석에 "axi_aclk != axi_lite_aclk일 때는 동기화가 필요하다"는 명시적 경고가 있습니다(현재 구현은 CDC 동기화 없음 — 두 클럭이 다르면 버그).

### 1-3. CSR 레지스터 맵 ([dma_axi_simple_csr.v](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_csr.v))

`T_ADDR_WID=8` → CSR 내부 주소공간은 0x00~0xFF, 실제 시스템에서는 여기에 베이스 주소가 더해짐.

| 오프셋 | 이름 | R/W | 필드 |
| --- | --- | --- | --- |
| 0x00 | NAME0 | RO | `"DMA "` (고정 문자열) |
| 0x04 | NAME1 | RO | `"AXI "` |
| 0x08~0x0C | NAME2/3 | RO | 공백 |
| 0x10 | COMP0 | RO | `"FDS "` |
| 0x14~0x1C | COMP1~3 | RO | 공백 |
| 0x20 | VERSION | RO | `0x2024_0610` |
| 0x30 | CONTROL | RW | bit31=EN, bit1=IP(인터럽트 pending, write 1로 clear), bit0=IE(인터럽트 enable) |
| 0x40 | NUM | RW/RO 혼합 | bit31=GO(write 1로 시작, DMA_DONE시 자동 clear), bit30=BUSY(RO), bit29=DONE(RO), bit23:16=CHUNK, bit15:0=BNUM |
| 0x44 | SOURCE | RW | 소스 주소 32비트 |
| 0x48 | DEST | RW | 목적 주소 32비트 |

핵심 로직 ([dma_axi_simple_csr.v:250-261](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_csr.v#L250-L261)):
```verilog
if (bram_wr && (bram_wr_addr==CSRA_NUM))
    csr_num_go <= csr_ctl_en & bram_wr_data[31];   // EN이 꺼져 있으면 GO를 써도 무시됨
else
    if (DMA_DONE) csr_num_go <= 1'b0;              // 완료 시 자동으로 GO 클리어 (SW는 폴링으로 완료 감지)
```
인터럽트 pending은 `csr_ctl_ie & DMA_GO & DMA_DONE`일 때 set되고, CONTROL의 bit1에 1을 쓰면 clear됩니다([dma_axi_simple_csr.v:264-277](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_csr.v#L264-L277)).

AXI4-Lite ↔ 내부 bram 스타일 버스 변환은 [dma_axi_simple_axi_lite_if.v](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_axi_lite_if.v)의 2개 독립 FSM(쓰기: `STW_READY→ARB→WRITE→RSP`, 읽기: `STR_READY→ARB→READ0→READ1→END`)이 담당합니다. 읽기는 주소 래치 후 2사이클 지연을 두고(`READ0`→`READ1`) `bram_rd_data`를 `s_axi_rdata`로 래치합니다.

### 1-4. DMA 코어 — Read 채널 ([dma_axi_simple_core_read.v](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_read.v))

두 개의 병렬 FSM으로 구성됩니다.

**① 주소/청크 계산 FSM** (`state`, 5-state)

| state | 진입 조건 | 동작 | 다음 state |
| --- | --- | --- | --- |
| `ST_READY` | `DMA_DONE==0 && fifo_empty==1 && DMA_GO==1 && DMA_BNUM!=0` | `R_addr←DMA_SRC`, `R_rem←DMA_BNUM`, `R_chunk` 계산(아래 참고) | `ST_MISALIGN`(주소 하위비트≠0) 또는 `ST_ALIGN` |
| `ST_MISALIGN` | 시작 주소가 버스폭에 안 맞음 | `R_rem`이 나머지 버스폭보다 작으면 1바이트 접근, 아니면 정렬 경계까지 1비트(burst len=1)로 채움 | `ST_READ` |
| `ST_ALIGN` | 정렬된 상태에서 매 라운드 진입 | `R_rem≥R_chunk`면 청크 크기만큼 burst, 아니면 남은 라인 수만큼, 그것도 0이면 1바이트 | `ST_READ` |
| `ST_READ` | `R_go=1`로 하위 FSM에 트랜잭션 요청 | 완료(`R_done`) 대기, 완료되면 `R_addr+=R_inc`, `R_rem-=R_inc` | `ST_READ_DONE` |
| `ST_READ_DONE` | 트랜잭션 1회 종료 | `R_rem`이 남았으면 재정렬 여부 판단 후 재진입, 0이면 `DMA_DONE=1` | `ST_MISALIGN`/`ST_ALIGN` 또는 `ST_READY` |

`R_chunk` 산정 규칙 ([dma_axi_simple_core_read.v:105-115](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_read.v#L105-L115)): `DMA_BNUM ≤ 버스폭`이면 그 값 그대로, `DMA_CHUNK ≤ 버스폭`이면 버스폭 1개(=1비트), 그 외에는 `DMA_CHUNK`를 FIFO 깊이 이내로 클램프.

**② AXI AR/R 채널 FSM** (`state_read`, 4-state: `SR_IDLE→SR_ARB→SR_RD→SR_DONE`)
- `SR_IDLE`: `R_go` 대기 후 `axi_araddr/arlen/arsize` 세팅, `axi_arvalid` assert
- `SR_ARB`: `axi_arready` 대기
- `SR_RD`: `axi_rvalid & axi_rready & fifo_wr_rdy & fifo_wr_vld`마다 `R_cnt` 증가, `R_cnt≥R_len`이면 완료(시뮬레이션에서 `RLAST`/`RID`/`RRESP` 체크, [core_read.v:282-292](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_read.v#L282-L292))
- `SR_DONE`: `R_go=0`이 될 때까지 대기 후 `axi_arid` 증가, `SR_IDLE`로 복귀

조합 로직: `axi_rready = (state_read==SR_RD) && fifo_wr_rdy`, `fifo_wr_vld = (state_read==SR_RD) && axi_rvalid`, `fifo_wr_dat = axi_rdata` ([core_read.v:307-309](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_read.v#L307-L309)).

### 1-5. DMA 코어 — Write 채널 ([dma_axi_simple_core_write.v](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_write.v))

Read와 대칭 구조입니다. 차이점:
- `ST_READY` 진입 조건이 `fifo_rd_vld==1`(FIFO에 데이터가 이미 있어야 시작) — read가 먼저 FIFO를 채워야 write가 따라감
- AXI FSM은 5-state: `SW_IDLE→SW_ARB→SW_WR→SW_BR→SW_DONE` (write는 응답 채널 B가 있어 `SW_BR` 단계 추가)
- `SW_ARB`에서 `axi_wstrb`를 `get_strb(addr, size)` 함수로 계산 — 정렬되지 않은 시작 주소에서 바이트 단위 strobe를 만들어주는 큰 case문 (32/64/128비트 데이터폭 지원, [core_write.v:325-489](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_write.v#L325-L489))
- 조합 로직: `fifo_rd_rdy = (state_write==SW_WR) & fifo_rd_vld & axi_wready`, `axi_wdata=fifo_rd_dat`, `axi_wvalid=(state_write==SW_WR)&fifo_rd_vld`, `axi_wlast=(state_write==SW_WR)&&(W_cnt==W_len)` ([core_write.v:316-323](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_write.v#L316-L323))

`get_strb` 함수 내부에 미러 오타가 하나 있습니다: 64비트 분기의 `7'b1000_100`, `7'b1000_101` 패턴이 [core_write.v:385-386](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_write.v#L385-L386)과 [core_write.v:387-388](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_write.v#L387-L388)에서 **동일한 case 값으로 중복 정의**되어 있습니다(뒤의 항목이 항상 이겨서 duplicate case 경고 발생, 64비트 폭을 실제로 쓰지 않는 한 영향 없음).

### 1-6. FIFO — [dma_axi_simple_fifo_sync_small.v](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_fifo_sync_small.v)

Read/Write 엔진 사이의 동기 FIFO. Ready/Valid 핸드셰이크, First-Word-Fall-Through, lookahead full/empty(`fullN`/`emptyN`) 지원. `rst`(비동기 hard reset)와 `clr`(동기 clear, DMA_EN=0일 때 코어에서 걸어줌)가 분리되어 있어 DMA가 비활성화되면 FIFO 내용도 함께 지워집니다 ([dma_axi_simple_core.v:166-167](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core.v#L166-L167): `clr(~DMA_EN)`).

### 1-7. 시뮬레이션 벤치 ([bench/verilog/top.sv](S07_dma_axi_simple/bench/verilog/top.sv))

```text
   +------+      +-----+       +-------+ 0x4000_0000
   | BFM  | [0]  |     | [2]   |  MEM  |
   |     M|<====>|S   M|<======|S      |
   +------+      |     |       |       |
                 |     |       +-------+
   +------+ [1]  |     | [3]   +------------+ 0x6000_0000
   |DMA  M|<====>|S   M|<=====>|AXI-to-Lite |
   |      |      |     |       +------------+
   +------+      +-----+            /\
      /\                            ||
      ||                            ||
      ++============================++
```
- `u_bfm`(`bfm_axi.sv`): 마스터 0. `bfm_dma_tasks.sv`에 정의된 태스크로 DMA CSR을 AXI4-Lite 경로(마스터0→`amba_axi_m2s2`→`axi4_to_lite`→DMA의 AXI-Lite 슬레이브)로 제어
- `u_dma`(`dma_axi_simple`): 마스터 1, AXI4 마스터로 `u_mem`(슬레이브0, `mem_axi.v` 기반 32KB 스크래치 메모리, 베이스 `0x4000_0000`)에 접근
- `u_axi`(`amba_axi_m2s2`): 2-master/2-slave AXI4 크로스바 (주소 디코딩: `ADDR_BASE0=0x4000_0000`→슬레이브0, `ADDR_BASE1=0x6000_0000`→슬레이브1)
- 종료 조건: `u_bfm.DONE==1`이 되면 5클럭 후 `$finish` ([top.sv:435-442](S07_dma_axi_simple/bench/verilog/top.sv#L435-L442))
- 실행: `sim/xsim/RunSimulation.bat` → `xsim_run.tcl`/`xsim.prj` (Xilinx XSIM), 파형은 `RunGtkwave.bat`로 확인

### 1-8. C 드라이버 — [api/c/dma_axi_api.c](S07_dma_axi_simple/api/c/dma_axi_api.c) / [.h](S07_dma_axi_simple/api/c/dma_axi_api.h)

| 함수 | 역할 |
| --- | --- |
| `dma_axi_enable(en, ie)` | CONTROL 레지스터에 EN/IE 비트 write |
| `dma_axi_go(dst, src, bnum, chunk, time_out)` | DST/SRC 레지스터 write 후 NUM 레지스터에 GO+chunk+bnum write, `time_out==0`이면 GO bit가 꺼질 때까지 블로킹 폴링, 아니면 `time_out`회 폴링 후 타임아웃 시 1 반환 |
| `dma_axi_clear()` | 인터럽트 pending 비트 clear |
| `dma_axi_csr()` | 4개 레지스터 값을 printf로 덤프 |
| `dma_axi_set_addr`/`get_addr` | 베이스 주소 재설정 (이 사본의 기본값 `0x5000_0000`) |

**버그(이 사본에만 존재)**: [S07_dma_axi_simple/api/c/dma_axi_api.c:152](S07_dma_axi_simple/api/c/dma_axi_api.c#L152)
```c
uint32_t dma_axi_get_addr( void ) {
    rreturn ADDR_DMA_AHB_START;   // "rreturn" 오타, "return"이어야 함 — 이대로면 컴파일 에러
}
```
이 파일을 그대로 컴파일하면 실패합니다. **주의**: `S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/dma_axi_api.c`에는 이 오타가 이미 고쳐져 있고 매크로/변수명도 `DMA_AHB_*` 접두어 없이 정리된 최신본입니다(2-3절 참고). 즉 이 폴더의 `api/c` 사본은 조금 더 오래된 버전이므로, 실습 시 최신본(`S07_ex_...zedboard`쪽)을 기준으로 삼는 것이 안전합니다.

### 1-9. 합성 결과물 ([syn/vivado.z7/](S07_dma_axi_simple/syn/vivado.z7/))
Zynq-7000(`z7`) 타겟으로 이미 합성이 한 번 수행된 산출물이 들어있습니다: `dma_axi_simple.dcp`(체크포인트), `work/post_synth_timing*.rpt`, `post_synth_util.rpt`, `post_synth_power.rpt`. `vivado.log`/`vivado.jou`로 이전 실행 기록 확인 가능. 재실행은 `RunSynthesis.bat` → `vivado_syn.tcl`.

### 1-10. 문서
[doc/dma_axi_simple_20140701.pdf](S07_dma_axi_simple/doc/dma_axi_simple_20140701.pdf) — IP 데이터시트(원본 PDF, 이 문서에서는 텍스트 추출하지 않음).

---

## 2. S07_ex_dma_axi_simple_zedboard (보드 통합 예제)

**목적**: 1절의 `dma_axi_simple` IP를 실제로 Zedboard(Zynq-7000, PS7) 위에 얹어 `axi_bram_ctrl`(로컬 BRAM)과 `mem_axi`(별도 AXI 슬레이브 메모리) 사이에서 DMA 복사를 시키고 `helloworld.c`로 검증하는 hw+sw 통합 실습입니다.

### 2-1. 폴더 구성

| 경로 | 내용 |
| --- | --- |
| [HowToRun.txt](S07_ex_dma_axi_simple_zedboard/HowToRun.txt) | Vitis 2024.1 기준 실행 순서 메모 (Vivado로 hw 빌드 → XSA export → Vitis에서 플랫폼/앱 프로젝트 생성) |
| [INDEX.txt](S07_ex_dma_axi_simple_zedboard/INDEX.txt) | 폴더 구조 요약 (`hw/imple.zed/`라는 오탈자 있음 — 실제 폴더명은 `hw/impl.zed/`) |
| [hw/impl.zed/](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/) | Vivado 2020.2 블록 디자인 스크립트(`design_zed.tcl`), 빌드용 `Makefile`, `RunVivado.bat` |
| [sw.arm/hello_world/](S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/) | Vitis 베어메탈 애플리케이션 (`helloworld.c`, `platform.c/h`, `dma_axi_api.c/h`) |

### 2-2. 하드웨어 블록 다이어그램 ([design_zed.tcl](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/design_zed.tcl))

```text
  PS7 (Zynq ARM)
  M_AXI_GP0 ──► smartconnect_0 (1 SI, 3 MI) ─┬─► axi_bram_ctrl_0 ── M00_AXI   @ 0x4000_0000, range 0x8_0000 (512KB)
   (FCLK_CLK0)                               ├─► mem_axi_0        ── M01_AXI  @ 0x6000_0000, range 0x2000_0000
                                              └─► axi4_to_lite_0   ── M02_AXI  @ 0x5000_0000, range 0x2000 → dma_axi_simple_0/s_axi_lite

  dma_axi_simple_0.m_axi (DMA 자신의 AXI4 마스터) ──► smartconnect_0 S01_AXI
      └─ 도달 가능: axi_bram_ctrl_0 (0x4000_0000), mem_axi_0 (0x6000_0000), axi4_to_lite_0(0x5000_0000, 자기 자신의 CSR 슬레이브까지 포함)
```

- IP 체크리스트: `axi_bram_ctrl`, `blk_mem_gen`, `proc_sys_reset`, `processing_system7`, `smartconnect` (S06 대비 `xlconstant` 없음 — UART용 RTS 고정 로직이 없기 때문)
- 참조 모듈: `axi4_to_lite`, `dma_axi_simple`, `mem_axi` — [design_zed.tcl:41-43](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/design_zed.tcl#L41-L43)에 "Please add the sources of those modules before sourcing this Tcl script"라고 명시
- 리셋/클럭: `proc_sys_reset_0`이 `axi4_to_lite_0`/`axi_bram_ctrl_0`/`dma_axi_simple_0`(axi_aresetn **및** axi_lite_aresetn 둘 다)/`mem_axi_0`에 `peripheral_aresetn` 공급, 전부 `FCLK_CLK0` 단일 클럭 도메인이라 1-6절에서 언급한 CDC 미구현 이슈는 이 보드 구성에서는 발생하지 않음
- smartconnect 크로스바: `NUM_SI=2`(PS7 GP0 + DMA 자신의 m_axi), `NUM_MI=3`(BRAM/mem_axi/axi4_to_lite) — [design_zed.tcl:689-703](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/design_zed.tcl#L689-L703)

### 2-3. 주소 맵 ([design_zed.tcl:712-718](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/design_zed.tcl#L712-L718))

| 베이스 | range | 대상 | PS 접근 | DMA(`m_axi`) 접근 |
| --- | --- | --- | --- | --- |
| 0x4000_0000 | 0x8_0000 (512KB) | `axi_bram_ctrl_0` (로컬 BRAM) | O | O |
| 0x6000_0000 | 0x2000_0000 | `mem_axi_0` (별도 AXI 슬레이브 메모리) | O | O |
| 0x5000_0000 | 0x2000 | `axi4_to_lite_0` → `dma_axi_simple_0/s_axi_lite` (DMA CSR) | O | O(자기 CSR에도 접근 가능하지만 실사용 안 함) |

`helloworld.c`의 상수와 정확히 일치합니다: `ADDR_MEM_AXI0=0x40000000`(BRAM), `ADDR_MEM_AXI1=0x60000000`(mem_axi), `ADDR_DMA_AXI=0x50000000`(DMA CSR) — [helloworld.c:53-55](S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/helloworld.c#L53-L55).

### 2-4. 소프트웨어 흐름 ([helloworld.c](S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/helloworld.c))

1. `ADDR_MEM_AXI0`/`ADDR_MEM_AXI1`에 각각 값을 직접 write/read 해 두 메모리 슬레이브가 PS에서 정상 접근되는지 sanity check ([helloworld.c:70-80](S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/helloworld.c#L70-L80))
2. `ADDR_MEM_AXI1`(소스, mem_axi)에 `idx` 패턴(0,4,8,...) 32바이트를 채우고 즉시 재검증 ([helloworld.c:83-103](S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/helloworld.c#L83-L103))
3. `dma_axi_set_addr(0x50000000)` → `dma_axi_csr()`로 초기 레지스터 덤프
4. 무한 루프: 엔터 입력 대기 → `dma_axi_go(dst=BRAM, src=mem_axi, bnum=32, chunk=16, time_out=0)`(블로킹) → BRAM 쪽을 읽어 패턴이 그대로 복사됐는지 검증 후 결과 출력 ([helloworld.c:109-131](S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/helloworld.c#L109-L131))

`dma_axi_go`에서 `chunk=16`, `bnum=32`(0x20)이므로 CSR NUM 레지스터에는 `GO=1, CHUNK=16, BNUM=32`가 써지고, 1-4절의 `R_chunk` 규칙에 따라 32바이트를 한 번에(정렬되어 있으므로 `ST_ALIGN`에서 `R_rem(32) < R_chunk(16*4=64)`... 실제로는 `DMA_CHUNK`가 8비트 단위 카운트가 아니라 [core_read.v:110-114](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_read.v#L110-L114) 로직상 `AXI_WIDTH_STRB`(=4) 단위로 정렬되어 처리됨) 1~2회의 AXI 버스트로 처리됩니다.

### 2-5. C 드라이버 차이점 (1-8절과 비교)

이 폴더의 [dma_axi_api.c](S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/dma_axi_api.c) / [dma_axi_api.h](S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/dma_axi_api.h)는 `S07_dma_axi_simple/api/c`의 더 최신 버전입니다.

| 항목 | `S07_dma_axi_simple/api/c` | `S07_ex_..._zedboard/.../src` |
| --- | --- | --- |
| `dma_axi_get_addr` 오타 | `rreturn` (컴파일 에러) | `return` (정상) |
| 매크로/변수 이름 | `DMA_AHB_ctl_en`, `ADDR_DMA_AHB_START` 등 `_AHB_` 접두어 | `DMA_ctl_en`, `ADDR_DMA_START` 등 접두어 제거 |
| `dma_axi_csr()` 헤더 선언 | 없음(암묵적 선언 경고 가능) | `.h`에 명시적 프로토타입 추가 |
| `#include <stdio.h>` | 없음(그러나 `printf` 사용 — 경고 가능) | 명시적으로 추가됨 |

### 2-6. 빌드 흐름 ([HowToRun.txt](S07_ex_dma_axi_simple_zedboard/HowToRun.txt))
1. `set_vivado 2020.2`
2. `cd hw/impl.zed && make` → Vivado GUI가 열리면 tcl 콘솔에서 `syn_impl` 실행 → XSA(`design_zed_wrapper.xsa`) 생성 확인
3. Vitis IDE 실행 → workspace 지정 → "Create a new platform from hardware (XSA)"로 위 XSA 선택 → 애플리케이션 프로젝트 이름 `mem`, OS `standalone`, 템플릿 `hello world` 선택 → Build

### 2-7. ⚠️ 확인 필요: `DIR_IP` 상대경로가 현재 폴더 배치와 안 맞음

[hw/impl.zed/Makefile:13](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/Makefile#L13)에서 `DIR_IP = ../../..`로 설정되어 있고, [design_zed.tcl:63-65](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/design_zed.tcl#L63-L65)는 이를 이용해 다음 파일들을 추가합니다.

```tcl
add_files ... ${DIR_IP}/mem_axi/rtl/verilog/mem_axi.v
add_files ... ${DIR_IP}/axi4_to_lite/rtl/verilog/axi4_to_lite.v
add_files ... ${DIR_IP}/dma_axi_simple/rtl/verilog/dma_axi_simple.v
```

`hw/impl.zed` 기준 3단계 상위 폴더는 `week4/07_16/` 인데, 여기에는 `mem_axi/`, `axi4_to_lite/`, `dma_axi_simple/`라는 이름의 폴더가 **없습니다**(있는 것은 `S07_dma_axi_simple/`이며, 그 안의 `bench/verilog/mem_axi.v`, `bench/verilog/axi4_to_lite.v`, `rtl/verilog/dma_axi_simple.v`가 각각 대응되는 파일입니다). 즉 지금 이대로 `make`를 돌리면 Vivado가 세 모듈을 찾지 못해 IP 체크·모듈 체크 단계에서 실패합니다([design_zed.tcl:169-198](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/design_zed.tcl#L169-L198)의 `bCheckModules`).

**해결 방법 두 가지 중 하나 필요**:
- (A) `week4/07_16/` 바로 아래에 `mem_axi/`, `axi4_to_lite/`, `dma_axi_simple/` 폴더를 만들고 그 안에 `rtl/verilog/<이름>.v`를 배치(= `S07_dma_axi_simple`의 해당 파일들을 이름 그대로 복사/링크), 또는
- (B) `hw/impl.zed/Makefile`의 `DIR_IP`를 실제 위치에 맞게 수정(예: `mem_axi.v`/`axi4_to_lite.v`는 `../../../S07_dma_axi_simple/bench/verilog`, `dma_axi_simple.v`는 `../../../S07_dma_axi_simple/rtl/verilog`를 가리키도록 tcl의 `add_files` 3줄을 개별 경로로 바꿈)

---

## 3. 두 프로젝트의 관계 및 학습 흐름 제안

- **S07_dma_axi_simple**은 "AXI4 마스터를 직접 설계하고 시뮬레이션으로 검증"하는 IP 개발 실습이고, **S07_ex_dma_axi_simple_zedboard**는 그 결과물을 "실제 보드에 얹어 PS와 함께 동작시키는" 통합 실습입니다.
- 학습 순서 제안: ① `S07_dma_axi_simple`의 RTL(1-2~1-6절)과 `bench/verilog/top.sv` 시뮬레이션으로 DMA read/write FSM과 AXI4 프로토콜을 먼저 이해 → ② `S07_ex_dma_axi_simple_zedboard`의 주소맵(2-3절)과 `helloworld.c`(2-4절)로 동일한 IP가 실보드에서 어떻게 쓰이는지 확인 → ③ 2-7절의 `DIR_IP` 경로 문제를 직접 해결해보며 Vivado 프로젝트 구조에 대한 이해를 굳힘.
- 두 곳의 `dma_axi_api.c`는 내용이 달라졌으므로(2-5절), 실습에서는 항상 `S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src` 쪽을 기준으로 삼는 것을 권장합니다.
- CSR을 AXI4-Lite로 감싸는 패턴(`bram_wr/bram_wr_addr/bram_wr_data`, `bram_rd/bram_rd_addr/bram_rd_data` 스타일의 내부 버스)은 이후 다른 IP(UART 등)에도 반복되므로, `dma_axi_simple_axi_lite_if.v`(1-3절)를 잘 이해해두면 재사용성이 높습니다.

## 4. 알려진 이슈 요약

| 위치 | 이슈 |
| --- | --- |
| [hw/impl.zed/Makefile:13](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/Makefile#L13) + [design_zed.tcl:63-65](S07_ex_dma_axi_simple_zedboard/hw/impl.zed/design_zed.tcl#L63-L65) | `DIR_IP=../../..` 경로에 `mem_axi/`, `axi4_to_lite/`, `dma_axi_simple/` 폴더가 실제로 없어 현재 상태로는 Vivado 빌드가 실패함 (2-7절 참고) |
| [S07_dma_axi_simple/api/c/dma_axi_api.c:152](S07_dma_axi_simple/api/c/dma_axi_api.c#L152) | `rreturn` 오타로 컴파일 불가. 최신본은 `S07_ex_dma_axi_simple_zedboard/sw.arm/hello_world/src/dma_axi_api.c`에 있음 |
| [dma_axi_simple_core_write.v:385-388](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core_write.v#L385-L388) | `get_strb` 64비트 분기에 case 값 중복(`7'b1000_100`/`101`) |
| [dma_axi_simple_core.v:190](S07_dma_axi_simple/rtl/verilog/dma_axi_simple_core.v#L190) | `axi_aclk`와 `axi_lite_aclk`가 다르면 CDC 동기화 미구현 (주석으로만 경고). 단, 2-2절의 실제 보드 구성은 두 클럭이 같은 `FCLK_CLK0`라 문제없음 |
| [rtl/verilog/INDEX.txt](S07_dma_axi_simple/rtl/verilog/INDEX.txt) | 실제 파일 구성과 다른 오래된 계층도 (csr_read/csr_write는 존재하지 않음) |
| [S07_ex_dma_axi_simple_zedboard/INDEX.txt](S07_ex_dma_axi_simple_zedboard/INDEX.txt) | `hw/imple.zed/`로 오탈자(실제 폴더명은 `hw/impl.zed/`) |
