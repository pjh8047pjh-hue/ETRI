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
