# MobileNetV2 Vivado 전달본

이 폴더는 `project_mobilenetV2`의 소스 및 프로젝트 재현에 필요한 파일만 모은 전달용 복사본입니다.
원본 프로젝트는 변경하지 않았습니다.

## 시작 방법

1. Vivado 2020.2에서 `project_mobilenetV2.xpr`를 엽니다.
2. IP 출력물이 없다는 메시지가 나오면 Vivado의 **Generate Output Products**를 실행합니다.
3. 기본 시뮬레이션 소스는 `tb_mobilenet.sv`이며, 별도 검증 테스트벤치는 `verification/tb_mobilenet_verify.sv`입니다.

프로젝트 파일이 정상적으로 열리는지만 일괄 확인하려면 다음 명령을 사용할 수 있습니다.

```powershell
vivado -mode batch -source verification/check_project.tcl -nolog -nojournal
```

## 포함한 항목

- RTL/SystemVerilog 소스와 테스트벤치
- Vivado IP 설정 파일(`.xci`)
- 메모리 초기화 파일(`.coe`, `.mem`)과 생성 스크립트
- Vivado 프로젝트 파일(`.xpr`)과 파형 설정(`.wcfg`)
- 검증·프로젝트 점검 Tcl 및 테스트벤치
- 설계 사양, 구조 검토 문서, 아키텍처 그림

## 제외한 항목

다음은 Vivado가 다시 만들 수 있거나 실행 기록이므로 전달본에서 제외했습니다.

- `project_mobilenetV2.cache/`
- `project_mobilenetV2.gen/`
- `project_mobilenetV2.hw/`
- `project_mobilenetV2.ip_user_files/`
- `project_mobilenetV2.runs/`
- `project_mobilenetV2.sim/`
- `.Xil/`
- `*.log`, `*.jou`, `*.pb`, `*.wdb`, `*.dcp`

프로젝트를 실행하면 위 폴더와 로그가 다시 생성될 수 있습니다.
