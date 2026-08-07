# 프로젝트 컨텍스트

마지막 갱신: 2026-07-15

## 목적

이 저장소는 FPGA, SoC 및 임베디드 시스템 학습과 실습 결과를 주차별로 관리한다. Verilog/SystemVerilog, APB/AXI 계열 버스, 메모리 및 주변장치, Vivado 프로젝트, 보드 실습과 관련된 자료가 포함되어 있다.

## 주요 구성

- `week1/` ~ `week4/`: 날짜 및 주제별 교육·실습 자료
- `assignment/`: 과제용 Vivado 프로젝트와 소스
- `scripts/`: 반복 작업을 돕는 PowerShell 스크립트
- `DAILY_LOG_GUIDE.md`: 일일 학습 기록 작성 지침
- `ultra96_training_kit.xdc`: Ultra96 보드 제약 파일
- `GoogleDrive/`: Google Drive 공유 폴더 `2026_07_ETRI_AI_RTL`을 가리키는 로컬 연결 폴더

하위 실습 폴더에는 더 구체적인 `AGENTS.md`가 있을 수 있으며, 해당 범위에서는 그 지침을 함께 적용한다.

## 현재 작업 환경

- 운영체제/셸: Windows, PowerShell
- 프로젝트 경로: `C:\Users\user\Documents\JH`
- 시간대: Asia/Seoul
- Git 저장소이며, 도구 생성물을 포함한 기존 미커밋 변경이 다수 존재할 수 있다.
- `GoogleDrive/`의 실제 대상은 `H:\.shortcut-targets-by-id\1C9Jjy9MKioAWd643Ymi_4Rg1rcUANcoE\2026_07_ETRI_AI_RTL`이다.
- 현재 Codex 샌드박스에서는 연결 폴더를 따라 `H:`를 읽을 때 추가 권한 승인이 필요할 수 있다.

## 사용자 선호 및 협업 방식

- 다른 OpenAI 계정으로 전환해도 동일한 로컬 프로젝트를 열어 작업 맥락을 이어가고자 한다.
- 대화 기억보다는 저장소의 인수인계 문서를 지속 가능한 기준으로 사용한다.
- 향후 Google Drive 공유 자료를 로컬에 자동 동기화하고, 질문 시 그 자료를 우선 근거로 활용하고자 한다.
- 자료에 없는 내용이나 모델의 추론은 확인된 사실과 구분해서 설명한다.

## 새 계정에서 시작할 때 사용할 요청

> 이 프로젝트의 `AGENTS.md`, `CONTEXT.md`, `DECISIONS.md`, `TODO.md`를 먼저 읽고 기존 맥락을 이어서 작업해 줘. 관련 질문에는 로컬 파일과 `GoogleDrive/` 자료를 우선 근거로 사용하고, 확인한 파일 경로를 밝혀 줘.
