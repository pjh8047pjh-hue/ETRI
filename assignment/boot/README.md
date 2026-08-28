# boot — assignment 비트스트림

Vivado 생성물(assignment.runs 등)은 용량 정리로 삭제했지만,
**이 비트스트림만은 재합성 없이 보드에 올릴 수 있도록 남겨 둡니다.**

| 항목 | 값 |
|---|---|
| 파일 | `top.bit` (5.4 MB) |
| 빌드 | 2026-07-02 |
| 대상 | Ultra96-v2 `xczu3eg-sbva484-1-e` |
| 내용 | 과제 top 디자인 |

## 올리는 법

```
hw_server                       # 별도 터미널
```

Vivado Hardware Manager에서 보드를 연결하고 이 `.bit`을 Program Device로 올리거나,
XSCT에서 `fpga -file boot/top.bit`를 실행합니다.

## 다시 합성하려면

`assignment.xpr`을 Vivado 2020.2에서 열고 Generate Output Products 후
Generate Bitstream을 돌리면 `.runs/impl_1/` 아래에 다시 만들어집니다.
