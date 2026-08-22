# boot — Ultra96v2 보드에 바로 올리기

이 폴더에는 **보드에 올리는 데 필요한 산출물만** 들어 있습니다.
Vivado나 Vitis로 다시 빌드할 필요 없이, clone 받은 노트북에서 바로 실행할 수 있습니다.

## 들어 있는 것

| 파일 | 크기 | 무엇 |
|---|---|---|
| `design_1_wrapper.bit` | 5.4 MB | PL 비트스트림 (274 DSP 빌드, 2026-08-20 20:05 impl 런) |
| `psu_init.tcl` | 860 KB | PS 초기화 (MIO/PLL/클럭/peripheral 레지스터 설정) |
| `mobilenetV2_test.elf` | 306 KB | A53에서 도는 검증 프로그램, OCM 링크 |

대상 디바이스는 `xczu3eg-sbva484-1-e` (Ultra96v2)입니다.

## 올리는 법

노트북에 **Vitis(또는 XSCT)** 와 보드 드라이버가 설치되어 있어야 합니다.
Vivado 전체는 필요 없습니다.

1. 보드를 USB-JTAG으로 연결하고 전원을 켭니다.
2. 하드웨어 서버를 띄웁니다 (별도 터미널):

   ```
   hw_server
   ```

3. 저장소 루트에서 스크립트를 실행합니다:

   ```
   xsct project_mobilenetV2/run_ocm.tcl
   ```

`run_ocm.tcl`은 자기 위치를 기준으로 경로를 잡으므로 **어디에 clone하든 그대로 동작합니다.**
시작할 때 실제로 사용하는 세 파일의 경로를 찍어주고, 하나라도 없으면 그 자리에서 멈춥니다.

## 무엇이 출력되면 성공인가

UART(115200)에 다음이 찍히면 통과입니다.

```
PASS: all 12544 results match golden
```

`run_ocm.tcl`은 실행 후 15초를 기다렸다가 PC와 backtrace, 그리고
`0xFFFCB0C0`의 `output_data[0..7]`을 덤프합니다.

12,544 = 64 output channel × 196 pixel (14×14) 이고, 전수 비교합니다.
`main.c`의 `golden_p2_q34()`가 기대값을 계산하는데, 이건 PyTorch 참조 출력이
아니라 **램프 입력 패턴에 대한 해석적 골든 모델**입니다.

## 갱신하는 법

Vivado/Vitis를 다시 돌렸으면 원본 자리에서 이 폴더로 복사한 뒤 커밋하세요.
빌드 산출물 경로는 `.gitignore`에 걸려 있어서 이 폴더만 추적됩니다.

```
cp project_mobilenetV2.runs/impl_1/design_1_wrapper.bit      boot/
cp mobilenetV2_test/_ide/psinit/psu_init.tcl                 boot/
cp mobilenetV2_test/Debug/mobilenetV2_test.elf               boot/
```

## 참고

`../mobilenetV2_hw.xsa`에도 같은 비트스트림과 `psu_init.tcl`이 들어 있습니다
(XSA는 zip입니다). Vitis에서 플랫폼을 새로 만들 때는 그쪽을 쓰고,
그냥 보드에 올리기만 할 때는 이 폴더를 쓰면 됩니다.
