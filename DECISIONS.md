# 결정 기록

프로젝트 전반에 영향을 주며 이후 작업자가 알아야 할 결정만 기록한다. 최신 결정을 아래쪽에 추가한다.

## 2026-07-15 — 계정 독립적인 인수인계 방식 사용

- 결정: 대화 기록이나 계정 메모리에 의존하지 않고 `AGENTS.md`, `CONTEXT.md`, `DECISIONS.md`, `TODO.md`를 인수인계 기준으로 사용한다.
- 이유: OpenAI 계정 간에는 대화 기록, 메모리, 설정이 자동으로 합쳐지거나 이전되지 않기 때문이다.
- 영향: 새 계정에서는 같은 로컬 프로젝트를 열고 네 문서를 먼저 읽으면 작업 맥락을 복원할 수 있다.

## 2026-07-15 — Google Drive는 로컬 자동 동기화로 연결

- 결정: 직접 커넥터 대신 Google Drive for desktop으로 자료를 로컬에 동기화한다.
- 권장 위치: `C:\Users\user\Documents\JH\GoogleDrive`
- 이유: 현재 Codex 세션에는 Google Drive 앱/플러그인 연결 기능이 노출되어 있지 않으며, 로컬 동기화는 계정이 바뀌어도 같은 파일을 사용할 수 있다.
- 운영 원칙: 관련 질문에는 동기화된 파일을 우선 참고하되, 온라인 전용 파일이나 Google 전용 문서 형식은 실제 내용 접근 가능 여부를 먼저 확인한다.

## 2026-07-15 — 공유 폴더 연결 생성

- 결정: 저장소의 `GoogleDrive/`를 Google Drive 공유 폴더 `2026_07_ETRI_AI_RTL`의 실제 동기화 경로에 연결하는 Windows junction으로 생성했다.
- 실제 대상: `H:\.shortcut-targets-by-id\1C9Jjy9MKioAWd643Ymi_4Rg1rcUANcoE\2026_07_ETRI_AI_RTL`
- 확인 결과: 대상에서 `slides/`, `codes/`, `etc/` 폴더가 보인다.
- 제약: Codex 재시작 후에도 기본 접근은 `H:`를 외부 경로로 판단해 막히며, 승인된 전체 접근에서는 `slides/`, `codes/`, `etc/`를 읽을 수 있다.

## 결정 추가 형식

```md
## YYYY-MM-DD — 결정 제목

- 결정:
- 이유:
- 영향:
```
