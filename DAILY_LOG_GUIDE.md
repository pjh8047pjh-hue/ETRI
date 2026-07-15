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

- 날짜와 주제, 그날 배운 개념을 설명하는 글 (아래 "Notion 형식" 참고)
- 핵심 코드 스니펫과 그 코드가 신호/로직 관점에서 어떻게 동작하는지
- **Claude와의 대화에서 배운 것** — 질문했더니 명확해진 개념, 오해하고 있던 걸 고친 부분, 코드
  리뷰 중 Claude가 짚어준 문제(예: "이 FSM은 사실 이렇게 동작한다"). 이건 커밋 diff나
  슬라이드만 봐서는 재구성이 안 되는, 그날 실제로 이해가 넓어진 지점이라 가장 중요하게 남긴다.
- 검증 방법과 결과
- 다음 할 일
- GitHub commit(또는 compare) link

Notion은 자세한 내용이 코드나 commit에 이미 있으면 복사하지 말고 링크만 단다. 다만 "무엇을 했는지" 나열이 아니라 "무엇을 새로 이해했는지"를 설명하는 글이어야 한다 — 특히 대화 중에 배운 것 중심으로. 아래 "Notion 형식" 참고.

## 하루 작업 흐름

1. 프로젝트 폴더에서 작업한다.
2. 컴파일 또는 시뮬레이션을 실행한다.
3. `git status`로 변경 목록을 확인하고, 아래 "Git 커밋 범위 판단" 기준으로 노이즈를 거른 뒤 동작 확인이 끝난 결과를 GitHub에 commit/push 한다.
4. Notion은 기본적으로 **매일 밤 11시(KST) 자동화가 그날 GitHub 커밋 + 관련 슬라이드(Google Drive)를 보고 채운다** — 아래 "Notion 구조"의 자동화 항목 참고. 당일 바로 정리해두고 싶을 때만 4~5번을 수동으로 한다.
5. 수동으로 쓸 경우 "Notion 형식"에 맞춰 해당 주차 페이지 끝에 오늘 날짜 섹션을 추가하고, 커밋(또는 compare) link를 callout에 붙인다.

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

## Notion 형식

2026-07-13부터 Daily Log는 데이터베이스 항목이 아니라, 해당 주차 페이지 끝에 덧붙이는
**날짜 섹션(H1)** 이다. 항목 나열이 아니라 "무엇을 새로 이해했는지"를 설명하는 글로 쓴다.

````md
---
> weekN · 그날의 핵심 주제(1~3단어)

# YYYY-MM-DD · 제목

<callout icon="🔗" color="gray_bg">
커밋 [`HASH`](커밋 또는 compare URL) · 코드 `weekN/MM_DD/...`
</callout>

오늘 다룬 것이 무엇이고 왜 하는지 2~3문장.

## 소제목 (개념/모듈 단위)
설명 + 필요하면 짧은 code snippet.

## Claude와의 대화에서 배운 것
그날 세션에서 물어봤다가 명확해진 것, Claude가 고쳐준 오해, 코드에서 짚어준 문제를
Q&A 형태로. 코드를 그냥 읽어서 아는 게 아니라 "왜 그런지 물어봐서 알게 된 것"에 집중한다.

**Q.** 코드를 보다가, 또는 대화 중에 든 질문.
**A.** Claude가 설명해준 답 또는 그걸 코드로 직접 확인한 결과. (아직 모르면 "확인 필요"라고
쓰고 다음 할 일에 남긴다.)

## 검증
- 무엇을 어떻게 돌려서 확인했는지 (compile/sim/synth/보드 테스트 등)

## 다음 할 일
- 

**결론: 오늘 배운 것을 1~2문장으로 요약.**
````

작성 예시는 "4주차" 페이지의 `2026-07-13 · S05 AXI4-Lite 이중포트 메모리`,
`2026-07-14 · AXI4-Lite UART 주변장치 + AXI4-to-Lite 브리지 + ZedBoard 통합` 항목을 참고한다.

## Notion 구조

페이지 계층: **"ETRI RTL" → "데일리 학습 정리 (주차별·날짜별)" → `N주차` 페이지 → 그 안의 날짜 섹션(H1)**.
`N주차`는 저장소 폴더 `weekN/` 기준으로 매칭한다 (예: `week4/07_14/` 작업 → "4주차" 페이지에 추가).

예전에는 "ETRI RTL" 아래 "Daily Log" 데이터베이스(Name/Date/Topic/GitHub/Tags 속성)에 항목을
만들었지만, 이 방식은 **2026-07-13부로 폐지**되었다. 기존 DB 항목은 새 구조로 옮겨졌고, 그
자리에는 새 위치로 링크하는 콜아웃만 남아 있다. 새 Daily Log는 만들지 않는다.

**자동화**: 매일 밤 11시(KST)에 그날 GitHub 커밋 + 관련 슬라이드(Google Drive)를 참고해서
해당 주차·날짜 섹션이 자동으로 채워진다. 그래서 보통 4~5번(Notion 수동 작성)은 생략해도 된다 —
당일 바로 정리해두고 싶을 때만 수동으로 쓴다. 수동으로 썼는데 그날 밤 자동화가 다시 돌면
같은 날짜 섹션이 중복될 수 있으니, 수동으로 쓴 날은 자동화 결과를 다음날 한 번 확인한다.

**자동화의 한계**: 이 자동화는 GitHub 커밋과 슬라이드만 보고, **그날 Claude와 나눈 대화는
못 본다.** 그래서 "위 Notion에 남길 것"의 "Claude와의 대화에서 배운 것"은 자동화가 절대
채워주지 못한다 — 대화 중에 뭔가 명확해졌거나 오해가 고쳐졌으면, 그 세션이 끝나기 전에
Claude에게 직접 "오늘 대화 내용 Notion에 정리해줘"라고 요청해서 남긴다. 미루면 그 내용은
사라진다.

수동으로 쓸 때는 Notion MCP를 쓴다:

1. `notion-fetch`로 "데일리 학습 정리 (주차별·날짜별)" 페이지를 열어 이번 주 `N주차` 페이지
   URL을 찾는다 (또는 이미 알고 있으면 바로 fetch).
2. `notion-update-page`를 `command: "insert_content"`, `position: {"type":"end"}`로 호출해서
   위 "Notion 형식" 템플릿에 맞춘 내용을 그 주차 페이지 맨 끝에 추가한다. 새 페이지를
   만드는 게 아니라 기존 주차 페이지에 이어 붙이는 것이 핵심이다.

`scripts/New-DailyLogPage.ps1`은 옛 "Daily Log" DB 스키마를 전제로 하므로 지금 구조와 맞지
않는다 — 이 구조에 맞게 다시 만들기 전까지는 쓰지 않는다.

## 주간 정리

매주 마지막에는 Notion에 주간 요약 페이지를 하나 만든다.

- 완료한 실습
- 통과한 simulation
- 해결한 bug
- 새로 이해한 개념
- 대표 GitHub commit link

이 주간 정리는 나중에 포트폴리오, 면접 준비, 복습 자료로 바로 쓸 수 있다.
