# 통합 프로젝트 시스템 — 설계

> 이 문서는 **시스템 자체의 설계 근거**다. 실제 사용법 요약은 `README.md`(또는 `index.html`), 기록 방법은 `skills/wrap-up/SKILL.md` + `templates/CLAUDE.md` 참조.
> 출발점: `프로젝트-시스템`(검증·포트폴리오 관리) + `hwpx_mcp`(깊은 실행 + AI 세션 연속성) 의 장점만 합침.

최종 수정: 2026-06-15

---

## 목표 (4축)

1. **복구 불가능한 정보의 유실 0** — 코드·git·최종문서에서 다시 만들 수 있는 건 안 적는다. *왜 그 결정을 했는지 / 왜 실패했는지 / 함정* 처럼 한 번 안 적으면 영영 못 되살리는 것만 "유실 0"의 대상.
2. **AI 이해** — AI가 "지금까지 한 것 / 앞으로 할 것"을 즉시 파악.
3. **토큰 효율** — AI가 매번 통째로 안 읽는다. **현재 세션 노드 → 연결된 상위 노드 → 루트** 까지만 읽는다.
4. **재현 가능** — 템플릿 복사로 새 프로젝트/phase 시작.

---

## 핵심 모델 — 노드 트리 + 3계층 lazy-load

AI는 트리 전체를 읽지 않는다. **현재 작업 노드에서 루트까지 연결된 노드만** 읽고, 형제(다른 phase)·완료분·참고자료는 *포인터(한 줄)로만* 알고 필요할 때 펼친다.

```
L1 (항상 읽음, 짧게 유지)  ── concept · dashboard · roadmap
L2 (현재 phase일 때만)     ── active/phase-N
L3 (포인터로만, 필요시)    ── archive/ · reference/ · sessions/
```

평소 읽는 양 = L1(짧음) + 현재 phase 1개. **히스토리 전체를 절대 안 읽음.**

---

## 폴더 구조

**플러그인 본체** (설치되면 Claude Code가 관리하는 위치):

```
project-fde/   ← 이 폴더 자체가 Claude Code 플러그인 + 로컬 마켓플레이스
├── .claude-plugin/
│   ├── plugin.json       매니페스트
│   └── marketplace.json  로컬 설치용
├── skills/              슬래시 명령 (자동 발견)
│   ├── briefing/SKILL.md
│   ├── wrap-up/SKILL.md
│   └── new-project/SKILL.md
├── hooks/hooks.json     SessionStart 자동 브리핑
├── scripts/briefing.sh  dashboard 주입 스크립트
├── index.html           시각 안내 + 사용법
├── README.md            이 시스템 사용법
├── design.md            이 문서 (설계 근거)
├── principles.md        작업 원칙 (전 프로젝트 공통 상수, 거의 고정)
├── ideas.md             프로젝트 전 단계 인박스 (신규/보류/드롭)
└── templates/           새 프로젝트·phase 복사용 빈 양식
    ├── concept.md
    ├── dashboard.md
    ├── roadmap.md
    ├── improvements.md
    ├── recurring-issues.md
    ├── phase.md
    ├── session-log.md
    └── CLAUDE.md          (new-project가 각 프로젝트에 설치)
```

**실제 프로젝트** = `new-project`가 만들면 사용자의 작업 폴더 안에 독립 폴더로 생긴다 (자기 완결):

```
{프로젝트명}/
├── CLAUDE.md        이 프로젝트 상시 규칙 (매 세션 자동 로드)
├── concept.md       L1 "뭐고 왜 하나" (거의 안 변함)
├── dashboard.md     L1 "지금 상태 + 다음 할 일" (경계 有, 표 중심)
├── roadmap.md       L1 phase 목록 + 각 한 줄 상태 (= L2/L3 인덱스)
├── improvements.md  앞으로의 개선 아이디어
├── recurring-issues.md  이 프로젝트의 반복 실수·교훈 (프로젝트별로 자기 것만)
├── active/      L2 진행 중 phase 상세 (실행기록·결정)
│   └── phase-N-xxx.md
├── archive/     L3 완료 phase (유실0, 평소 안 읽음)
│   └── phase-M-xxx.md
├── reference/   L3 스펙·자료·SSoT 수치
└── sessions/    L3 세션 일지 (원장, append-only)
    └── YYYY-MM-DD.md
```

> **루트에 관리층을 두지 않는다**: ⓐ 전체 프로젝트를 묶는 포트폴리오 뷰(전체로드맵) 없음 — 프로젝트 폴더에 직접 들어가서 본다. ⓑ 프로젝트 간 공통 교훈 모음(recurring-issues)도 루트에 두지 않고 **각 프로젝트 폴더 안**에 둔다 — 새 프로젝트에서 같은 문제가 생기면 "예전 프로젝트의 recurring-issues 보고 와"라고 지시. 루트에 남는 건 *모든 프로젝트 공통 상수*(principles)와 *프로젝트 전 단계*(ideas)뿐.

### phase = 파일 또는 폴더

- phase는 기본 **파일 1개**(`active/phase-N-이름.md`). 끝나면 `archive/`로 이동.
- 한 phase에 **문서가 2개 이상**(중간에 다른 방향 설계 등) 생기면 **폴더로 승격**: `active/phase-N-이름/` + 메인 `phase.md` + 곁가지. 완료 시 폴더째 이동.
- `active`/`archive`/`reference`/`sessions`는 **프로젝트 레벨에 하나씩**(phase 안에 두지 않음). 이유: active↔archive는 phase가 오가는 두 칸이고, sessions는 프로젝트 하나의 시간선이라 쪼개면 타임라인이 찢어진다.

### 명명 규칙 = SSoT는 `templates/CLAUDE.md`

파일·폴더 이름 규칙(날짜 형식·phase 번호·곁가지 문서명 등)은 각 프로젝트에 설치되는 **`CLAUDE.md`의 "명명 규칙" 섹션이 단일 출처**다. AI가 매 세션 자동 로드하므로 거기 두고, 여기엔 복붙하지 않는다(중복 방지).

---

## 각 문서 = 질문 하나

| 문서 | 답하는 질문 | 계층 | 변동성 |
|---|---|---|---|
| concept | 이게 뭐고 왜 하나? | L1 | 거의 고정 |
| dashboard | 지금 상태 / 다음 할 일? | L1 | 매 세션 갱신, **항상 짧게** |
| roadmap | 전체 phase 그림 / 어디까지 왔나? | L1 | phase 전환 시 |
| active/phase-N | 이 phase에서 뭘 하고 있나? | L2 | 작업 중 수시 |
| archive/phase-M | (끝난 phase) 그때 뭘 했나? | L3 | 동결 |
| reference | 스펙·수치·자료 (SSoT) | L3 | 가끔 |
| sessions/날짜 | 그날 무슨 일이 있었나? | L3 | append-only |

---

## 읽기 규칙 (토큰 핵심)

- **세션 시작**: concept(가볍게) + dashboard + roadmap + `active/현재phase` **만**. 끝.
- archive·reference·다른 phase = dashboard/roadmap의 **포인터(한 줄)** 로만 인지 → 필요할 때만 펼침.
- → 평소 읽는 양 = L1 + 현재 phase 1개.

---

## 기록 척도 — 남길까 버릴까

목표①을 "다 적는다"로 오해하면 토큰 효율과 충돌한다. 정보를 두 종류로 나눈다.

- **복구 가능** (git·코드·최종문서에서 재생성 가능) → **안 적어도 유실 아님.**
- **복구 불가능** (한 번 안 적으면 영영 못 되살림) → **이것만 유실 0의 대상.**

### 한 줄 테스트 두 개 (애매할 때)

1. **복원 테스트** — "나중에 코드·git·최종문서에서 다시 만들 수 있나?" → **YES면 버림** (중복)
2. **손해 테스트** — "안 적으면 미래의 나/AI가 같은 실수를 반복하거나, 이미 내린 결정을 모르고 다시 헤매나?" → **YES면 남김**

| 남김 (복구 불가 + 미래 가치) | 버림 (복구 가능 or 일회성) |
|---|---|
| 결정 + **그 이유** | 과정 서술 ("그다음 ~했다") |
| 실패한 시도 + **왜 실패했나** | git diff로 보이는 변경 내역 |
| 비자명한 발견·함정 | 코드 구조 (코드 보면 됨) |
| 피봇 + 트리거 | 최종 상태가 덮어쓴 중간 상태 |
| 제약조건 | 이번 대화에서만 의미 있는 것 |

### 척도는 *계층마다 다르다* (우아한 해법)

3계층 구조 덕분에 "남기는 비용"이 계층마다 다르다. L3는 평소 안 읽으니 쌓아둬도 토큰을 안 먹는다.

| 계층 | 필터 강도 | 이유 |
|---|---|---|
| **L1** (dashboard/roadmap/concept) | **잔인하게** — 현재 상태 + 포인터만 | 매번 읽음 = 토큰 직격 |
| **L2** (active/phase) | 중간 — 작업 결정·실패·이유 | 그 phase 동안만 읽음 |
| **L3** (archive/sessions/reference) | **관대하게** — 가치 조금이라도 있으면 남김 | 안 읽힘 = 토큰 공짜, 안전망 |

→ **"유실 0"은 L3(아카이브)가 책임지는 안전망**, L1/L2는 짧게 유지. *애매하면 L3로 내려서 남긴다* — 버리는 게 아니라 안 읽는 곳에 보관. 이러면 ①과 ③이 안 싸운다.

---

## 운영 규칙 — "부풀면 내려보내기"

유실 0 × 토큰 효율을 동시에 충족하는 핵심 규칙. **옮기는 거지 지우는 게 아님.**

- **dashboard**: 경계 초과(화면 한 장 넘김) → 오래된 결정/논의를 그 phase의 active 또는 sessions로 이동. dashboard엔 *현재 상태*만.
- **phase 완료**: `active/phase-N` → `archive/`로 이동 + roadmap에 ✅ + dashboard에서 제거.
- → 읽기 경로에서 빠져 토큰 절약, 그러나 기록은 남아 유실 0.

---

## ⭐ 기록 가이드 요약 (상세 = `skills/wrap-up/SKILL.md` + `templates/CLAUDE.md`)

> 사용자가 매번 손으로 기록하지 않는다. **트리거만** 주면 AI가 체크리스트대로 갱신한다.

- **세션 중** (AI 자동): 결정·시도·발견 생기면 `active/현재phase`에 한 줄씩 즉시.
- **세션 끝 — "wrap-up"**: ① active 갱신 → ② sessions/날짜 append → ③ dashboard 갱신 → ④ roadmap 갱신 → ⑤ phase 완료면 archive 이동 → ⑥ 부풀면 내려보내기. (각 단계에서 기록 척도 적용.)
- **세션 시작 — "briefing"**: L1 + active 읽고 "지난번까지 X, 다음은 Y" 3줄.

→ 이 트리거들은 플러그인 스킬(`/project-fde:briefing` · `/project-fde:wrap-up` · `/project-fde:new-project`)로 구현됨. 새 phase 생성은 스킬이 아니라 각 프로젝트 `CLAUDE.md`의 자동 행동. 세션 시작 자동 브리핑은 `hooks/hooks.json`(SessionStart).

---

## 출처 — 무엇을 어디서 가져왔나

- **프로젝트-시스템 → 가져옴**: 역할별 문서 분리 · 경계 있는 dashboard(표) · principles · recurring-issues(단, 프로젝트별로 내림) · ideas 인박스로 통합 · 템플릿
- **hwpx_mcp → 가져옴**: active/archive/reference/sessions 계층 · NOW식 부트스트랩(→ dashboard+roadmap으로 분리) · git tag 마일스톤 · SSoT 수치규율 · 한줄포인터 인덱스 패턴
