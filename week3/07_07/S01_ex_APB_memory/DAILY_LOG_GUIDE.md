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
3. 동작 확인이 끝난 결과를 GitHub에 commit/push 한다.
4. Notion에 하루 요약을 작성한다.
5. Notion 마지막에 GitHub commit 또는 repository link를 붙인다.

기본 Git 명령:

```bash
git status
git add .
git commit -m "Connect APB memory module to testbench"
git push
```

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

## 주간 정리

매주 마지막에는 Notion에 주간 요약 페이지를 하나 만든다.

- 완료한 실습
- 통과한 simulation
- 해결한 bug
- 새로 이해한 개념
- 대표 GitHub commit link

이 주간 정리는 나중에 포트폴리오, 면접 준비, 복습 자료로 바로 쓸 수 있다.

## 자동화 (GitHub + Notion)

이 repo는 `JH` 폴더(week1, week2, week3 전체 포함) 루트에서 git으로 관리하고, GitHub `pjh8047pjh-hue/ETRI`에 연결되어 있다. Notion 쪽에는 이 가이드 템플릿과 같은 구조의 "Daily Log" 데이터베이스가 연결되어 있다. 두 곳 다 사람이 직접 처음 한 번 설정해야 하는 부분과, 그 이후 매번 반복하는 부분이 나뉜다.

### 사전 준비물 (한 번만 하면 됨)

1. **git** — 이미 설치되어 있어야 함
2. **GitHub CLI (`gh`)** — `winget install --id GitHub.cli -e` 로 설치 후 `gh auth login` 으로 브라우저 인증
   - 새로 설치한 직후에는 새 터미널 창을 열어야 `gh` 명령이 PATH에서 인식됨
   - `gh auth status` 로 로그인 상태 확인 가능
3. **Notion Integration** — <https://www.notion.so/my-integrations> 에서 생성, "Internal Integration Secret" 토큰 발급
4. **Notion Daily Log 데이터베이스** — Integration을 공유(Connections)해 둔 페이지 아래에 아래 속성으로 생성:
   - `Name` (title), `Date` (date), `Topic` (rich_text), `GitHub` (url), `Tags` (multi_select)
   - 본문은 이 가이드의 템플릿(한 일 / 수정한 파일 / 실행한 명령 / 결과 / 에러·해결 / 배운 점 / 다음 할 일 / GitHub 링크) 구조를 heading + bullet로 그대로 사용
5. **`JH/.env` 파일** (git에 커밋되지 않음, `.gitignore`에 등록되어 있음):

   ```text
   NOTION_TOKEN=ntn_...
   NOTION_DAILY_LOG_DB_ID=xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
   ```

6. **`JH/scripts/New-DailyLogPage.ps1`** — `.env`를 읽어서 Notion Daily Log 페이지 하나를 만들어주는 PowerShell 스크립트

이 5가지가 이미 되어 있다면, 다른 사람이 이 repo를 이어받아도 아래 "매번 하는 일"만 반복하면 된다.

### 매번 하는 일 (하루 작업 끝날 때)

1. **GitHub**

   ```powershell
   cd C:\Users\user\Documents\JH
   git status
   git add <수정한 파일들>
   git commit -m "Add APB memory slave module"
   git push
   ```

2. **Notion** — PowerShell에서 스크립트 실행 (한글 인코딩 문제를 피하려면 스크립트 파일이 UTF-8 with BOM으로 저장되어 있어야 함):

   ```powershell
   & "C:\Users\user\Documents\JH\scripts\New-DailyLogPage.ps1" `
     -Date "YYYY-MM-DD" `
     -Topic "오늘 주제" `
     -DidToday @("한 일 1", "한 일 2") `
     -FilesChanged @("rtl/verilog/mem_apb.v") `
     -Commands "xvlog -prj xsim.prj`nxelab ... -s top`nxsim top -tclbatch xsim_run.tcl" `
     -Result @("compile 통과", "slave 0~3 test OK") `
     -ErrorsFixed @("에러 상황 -> 해결 방법") `
     -Learned @("배운 점") `
     -NextTodo @("다음 할 일") `
     -GithubUrl "https://github.com/pjh8047pjh-hue/ETRI/commit/<COMMIT_HASH>" `
     -Tags @("APB")
   ```

   실행하면 콘솔에 생성된 Notion 페이지 URL이 출력된다.

### 자동 실행 여부

이 automation은 정해진 시간에 저절로 도는 cron이 아니라 **사람이(또는 Claude Code에게 "오늘 로그 정리해줘"라고 시켜서) 원할 때 실행하는 방식**이다. "한 일 / 에러 / 배운 점" 같은 항목은 그날 맥락을 이해해야 의미 있게 채울 수 있어서, 완전 자동화보다는 하루를 마무리하며 직접(혹은 Claude Code와 함께) 정리하는 쪽을 택했다.
