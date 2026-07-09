# Daily Log Guide

## 목적

GitHub는 코드와 실행 가능한 프로젝트 이력을 남기는 원본 저장소로 사용한다.
Notion은 하루 단위로 무엇을 했는지 빠르게 복습하는 작업 일지로 사용한다.

같은 내용을 두 번 길게 쓰지 않는다. GitHub에는 증거를 남기고, Notion에는 요약과 링크만 남긴다.

## 역할 분리

### GitHub에 남길 것

- RTL, testbench, simulation script, source file
- 프로젝트 설명과 실행 방법이 들어간 `README.md`
- 날짜별 작업이 드러나는 commit history
- 코드와 함께 보관해야 하는 자세한 로그가 있으면 `logs/` 아래 markdown 파일

좋은 commit message 예시:

```text
Add APB memory slave module
Connect APB memory to testbench
Guard APB4 strobe handling in BFM tasks
Fix APB ready timing for delayed transfers
```

### Notion에 남길 것

- 날짜와 주제
- 오늘 한 일
- 수정한 파일
- 실행한 명령
- 에러와 해결 방법
- 배운 점
- 다음 할 일
- GitHub repository 또는 commit link

Notion은 짧게 쓴다. 자세한 내용이 코드나 commit에 이미 있으면 복사하지 말고 링크만 단다.

## 하루 작업 흐름

1. 프로젝트 폴더에서 작업한다.
2. 컴파일 또는 시뮬레이션을 실행한다.
3. `git status`로 변경 목록을 확인하고, 아래 "Git 커밋 범위 판단" 기준으로 노이즈를 거른 뒤 동작 확인이 끝난 결과를 GitHub에 commit/push 한다.
4. Notion에 하루 요약을 작성한다.
5. Notion 마지막에 GitHub commit 또는 repository link를 붙인다.

기본 Git 명령:

```bash
git status
git add .
git commit -m "Connect APB memory module to testbench"
git push
```

`git add .`는 노이즈가 없을 때만 쓴다. Vivado 프로젝트를 만졌다면 먼저 아래 체크리스트를 본다.

## Git 커밋 범위 판단

Vivado/Eclipse는 빌드할 때마다 수백~수천 개 파일을 재생성한다. `git status`가 100개 이상의
변경을 보여주면 바로 `git add .`를 하지 말고 다음을 확인한다.

- **재생성되는 산출물은 커밋하지 않는다**: `*.gen/`, `*.cache/`, `*.hw/`, `*.sim/`, `*.runs/`,
  `*.Xil/`, `*.jou`, `*.log`, `*.wdb`, synth report(`.rpt`), netlist(`_sim_netlist.*`,
  `_stub.*`), `wave.vcd`, Eclipse `workspace.zed/.metadata/` 등. 이미 커밋되어 있던 것이라도
  발견하면 지우고 `.gitignore`에 패턴을 추가한다 (예: `**/project_zed.gen/`).
- **대용량 참조/복사 프로젝트는 커밋하지 않는다**: 실습 예제를 통째로 복사해 둔 폴더
  (`week3/codes/`, `week3/test/` 같은 것)는 수백 MB가 될 수 있다. `du -sh <dir>`로 크기를
  확인하고, 100MB를 넘으면 `.gitignore`에 추가하거나 별도로 보관한다.
- **실제 소스만 골라서 add 한다**: RTL/testbench/sim script/README처럼 손으로 수정한 파일만
  경로를 지정해서 `git add <path> <path> ...` 한다.
- **논리 단위로 커밋을 쪼갠다**: "빌드 산출물 정리", "기능 구현", "버그 수정"처럼 성격이 다른
  변경은 별도 커밋으로 나눈다. 커밋 메시지 스타일은 위 예시를 따른다.
- **변경 규모가 크거나 애매하면 커밋 전에 확인을 받는다**: 수백 개 파일 삭제/추가처럼 되돌리기
  어려운 작업은 무엇을 올리고 무엇을 뺄지 먼저 물어본다.

## Notion 템플릿

````md
## YYYY-MM-DD 주제

### 한 일
- 

### 수정한 파일
- 

### 실행한 명령
```bash

```

### 결과
- 

### 에러 / 해결
- 

### 배운 점
- 

### 다음 할 일
- 

### GitHub 링크
- 
````

## 작성 예시

````md
## 2026-07-08 APB Memory

### 한 일
- `rtl/verilog/mem_apb.v` 생성
- `bench/verilog/top.v`에서 `mem_apb4` 대신 `mem_apb` 연결
- `bench/verilog/bfm_apb_tasks.v`의 `PSTRB` assignment를 `AMBA4` 조건부 처리

### 수정한 파일
- `rtl/verilog/mem_apb.v`
- `bench/verilog/top.v`
- `bench/verilog/bfm_apb_tasks.v`

### 실행한 명령
```bash
xvlog -prj xsim.prj
xelab -prj xsim.prj -debug typical top -s top
xsim top -tclbatch xsim_run.tcl
```

### 결과
- compile 통과
- elaboration 통과
- slave 0~3 RAW / RAAWA test OK

### 에러 / 해결
- `top.v`가 아직 `mem_apb4`를 instantiate하고 있었음
- DUT를 `mem_apb`로 바꾸고 port map을 `S_APB_*` 이름으로 수정

### 배운 점
- APB transfer는 access phase에서 완료된다: `PSEL && PENABLE && PREADY`
- `PSTRB`는 AMBA4 build에서만 다루는 것이 안전하다

### 다음 할 일
- `DELAY > 0`인 경우의 `PREADY` wait state 테스트 추가

### GitHub 링크
- https://github.com/USER/REPO/commit/COMMIT_HASH
````

## Notion 자동화 세부 정보

Daily Log 페이지는 "ETRI RTL" 페이지 아래 "Daily Log" 데이터베이스에 들어간다.

속성(스키마):

| 속성 이름 | 타입 | 비고 |
| --------- | ---- | ---- |
| `Name` | title | `"YYYY-MM-DD 주제"` 형식 |
| `Date` | date | `YYYY-MM-DD` |
| `Topic` | text | `Name`에서 날짜를 뺀 부분과 동일하게 |
| `GitHub` | url | 그날 commit(들)의 compare 링크 또는 최신 commit 링크 |
| `Tags` | multi_select | 아래 고정 옵션만 사용 (새 값을 넣으면 실패할 수 있음) |

기존 `Tags` 옵션: `APB`, `Memory`, `Testbench`, `ZedBoard`, `Automation`, `C`, `BMP`,
`MobileNet`, `Verilog`, `Combinational`, `Counter`, `Ultra96`, `BCD`, `UART`.
새 주제가 생기면(GPIO 등) Notion에서 옵션을 먼저 만들거나, 가장 가까운 기존 태그로 대체한다.

페이지 생성 방법은 두 가지다:

1. **Notion MCP 연동(권장)** - Claude가 Notion에 직접 연결되어 있으면 `notion-search`로
   `collection://...` 데이터소스 URL을 찾고 `notion-create-pages`로 위 스키마에 맞춰 생성한다.
   한글 인코딩 문제가 없고 스키마를 실시간으로 확인할 수 있어 가장 안정적이다.
2. **PowerShell 스크립트** - `scripts/New-DailyLogPage.ps1`. `.env`(git에 안 올라감)에
   `NOTION_TOKEN`, `NOTION_DAILY_LOG_DB_ID`가 있어야 한다. Notion MCP 연동이 없는 환경에서
   백업으로 쓴다.

## 주간 정리

매주 마지막에는 Notion에 주간 요약 페이지를 하나 만든다.

- 완료한 실습
- 통과한 simulation
- 해결한 bug
- 새로 이해한 개념
- 대표 GitHub commit link

이 주간 정리는 나중에 포트폴리오, 면접 준비, 복습 자료로 바로 쓸 수 있다.
