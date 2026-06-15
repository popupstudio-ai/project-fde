# [프로젝트명] — Claude 운영 지침

> 이 프로젝트는 **project-os** 시스템으로 관리됨. 이 파일은 매 세션 자동 로드되는 상시 규칙이다.
> 짧게 유지 — 상세는 가리키기만 한다.

## 세션 시작 시 읽을 것 (이것만 — 토큰 절약)

- `concept.md`(가볍게) · `dashboard.md` · `roadmap.md` · `active/` 의 현재 phase
- `archive/` · `reference/` · `sessions/` 는 **평소 읽지 마라**. dashboard/roadmap의 포인터로만 알고, 필요할 때만 펼친다.

## 기록 척도 (무엇을 적나)

- **복구 불가능한 것만 적는다**: 왜 그 결정 / 왜 실패 / 함정 / 비자명한 발견
- **적지 마라**: 과정 서술("파일 고침·테스트 돌림") — git이 이미 기록함
- dashboard·roadmap(L1)은 **짧게**. 넘치면 `archive/`나 `sessions/`로 내려보낸다(삭제 아님).
- 애매하면 버리지 말고 L3(archive/sessions)로 내린다.

## "마무리" 하면 (세션 끝)

1. `active/현재phase` 갱신 — 한 것·결과·이유·다음 (실패·함정 꼭)
2. `sessions/<오늘날짜>.md` 에 요약 append
3. `dashboard.md` 갱신 (다음 할 일·최근 결정) — 짧게
4. `roadmap.md` phase 상태 갱신
5. phase 끝났으면 `active`→`archive` 이동 + roadmap ✅
6. 부풀면 내려보내기
→ **다음 세션이 깨끗이 시작되게 "다음 할 일"을 명확히 남길 것.**

## 새 단계로 넘어갈 때 (자동 — 명령어 필요 없음)

사용자가 "다음 단계 가자" / "이제 {X} 만들자"처럼 **새 phase로 넘어가면**, 시키지 않아도 알아서:
1. `${본 프로젝트}/active/phase-{N}-{이름}.md` 생성 (아래 명명 규칙) — 목표·작업 항목은 대화/roadmap에서 채움
2. `roadmap.md`에 한 줄 추가 + `dashboard.md`의 "현재 phase" 갱신
3. 이전 phase가 안 끝났으면 먼저 정리(마무리)할지 물어본다

## 명명 규칙 (파일·폴더 — 항상 이대로, 임의로 짓지 마라)

- **날짜**: `YYYY-MM-DD` (예: 2026-06-11). sessions 파일명도 이 형식.
- **고정 문서명**(절대 안 바꿈): `concept.md` · `dashboard.md` · `roadmap.md` · `improvements.md` · `recurring-issues.md` · `CLAUDE.md`
- **phase**:
  - 문서 1개면 **파일**: `active/phase-{N}-{이름}.md` (N=1,2,3… 정수 / 이름=짧은 식별자, 공백 대신 하이픈)
  - 문서 여러 개면 **폴더로 승격**: `active/phase-{N}-{이름}/` 안에 메인 `phase.md` + 곁가지 문서들
  - 번호 N은 한 번 정하면 **안 바꾼다**(완료·보류돼도 유지). 끝나면 파일/폴더째 `archive/`로 이동(이름 그대로).
- **phase 폴더 안 곁가지 문서**: `{종류}-{식별자}.md` — phase명 반복 X(폴더가 이미 말해줌). 예: `design-altB.md`, `research-competitors.md`. **단 파일 첫 줄 제목에 어느 phase인지 적어 자기소개**(예: `# phase-2 검색기능 — 대안B 설계`).
- **sessions**: `sessions/{YYYY-MM-DD}.md` — 하루 한 파일.
- **reference**: `reference/{주제}.md` — 주제 명확하게.
- **프로젝트 폴더**: 짧고 명확하게, 공백 대신 하이픈.

> **phase 폴더 승격 시점**: 한 phase에 설계문서·리서치 등 **문서가 2개 이상** 생기면(예: 중간에 다른 방향이 떠올라 별도 설계가 필요할 때) 파일을 `phase.md`로 두고 폴더로 올린다. briefing·wrap-up은 항상 `phase.md`부터 읽고, 곁가지는 거기서 가리켜 필요할 때만 펼친다(lazy-load 유지).

## 더 필요할 때만

- 의사결정 원칙 → project-os `principles.md`
- 시스템 전체 설계 → project-os `design.md`
- (슬래시 단축키: `/project-os:briefing` · `/project-os:wrap-up`. 새 단계/새 프로젝트는 자연어로 말하면 자동.)
