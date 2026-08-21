# 다른 PC에서 Vitis 바로 시작하기

이 저장소에는 **비트스트림이 포함된 XSA**와 **애플리케이션 소스**만 들어 있습니다.
Vitis 플랫폼 트리(`mobilenetV2_platform/`)와 빌드 산출물은 절대경로가 박혀 있어
추적하지 않습니다 — 아래 순서대로 새로 만들면 됩니다.

| 파일 | 내용 |
|---|---|
| `mobilenetV2_hw.xsa` | 하드웨어 핸드오프. `mobilenetV2_hw.bit`(5,568,788 B) 포함 |
| `mobilenetV2_test/src/main.c` | PS쪽 테스트 프로그램 (AXI GPIO로 start/reset, 결과 검증) |
| `mobilenetV2_test/src/lscript.ld` | OCM 링커 스크립트 |
| `mobilenetV2_test/src/lscript_ddr.ld` | DDR 링커 스크립트 (12,544개 결과 버퍼용) |

대상 보드: **Ultra96-v2 (Zynq UltraScale+ ZU3EG)**

## 순서

1. **플랫폼 생성**
   Vitis > File > New > Platform Project
   - Name: `mobilenetV2_platform`
   - "Create from hardware specification (XSA)" 선택
   - Browse → `project_mobilenetV2/mobilenetV2_hw.xsa`
   - OS: `standalone`, Processor: `psu_cortexa53_0`
   - 생성 후 플랫폼을 한 번 **Build** (BSP 컴파일)

2. **애플리케이션 생성**
   File > New > Application Project
   - 위에서 만든 `mobilenetV2_platform` 선택
   - Name: `mobilenetV2_test`
   - Template: `Empty Application (C)`

3. **소스 넣기**
   생성된 `mobilenetV2_test/src/`의 기본 파일을 지우고,
   이 저장소의 `mobilenetV2_test/src/main.c`를 복사해 넣습니다.

4. **링커 스크립트 선택**
   결과 버퍼가 `s16 output_data[12544]` = 약 24KB라 OCM으로도 되지만,
   DDR로 돌리려면 `lscript_ddr.ld`를 프로젝트 링커 스크립트로 지정합니다.

5. **보드에 올리기**
   - Ultra96-v2를 JTAG로 연결
   - Xilinx > Program Device → XSA 안의 비트스트림이 자동으로 잡힙니다
   - Run As > Launch Hardware
   - UART 115200 8N1로 결과 출력 확인

## Vivado를 다시 열어야 한다면

`project_mobilenetV2.xpr`을 열면 됩니다. `.runs/`와 `.cache/`는 추적하지 않으므로
합성·구현 결과는 없습니다. 비트스트림만 필요하면 XSA에서 꺼내 쓰세요:

```
unzip -o mobilenetV2_hw.xsa mobilenetV2_hw.bit
```

RTL을 고쳐 다시 만들 때는 Generate Bitstream 후
`File > Export > Export Hardware`에서 **Include bitstream**을 반드시 체크하고
같은 이름(`mobilenetV2_hw.xsa`)으로 덮어써야 이 문서의 순서가 그대로 유효합니다.
