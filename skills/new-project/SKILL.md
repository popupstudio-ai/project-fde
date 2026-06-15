---
name: new-project
description: 새 프로젝트 폴더와 관리 문서를 만든다. 사용자와 설계·검증 대화를 어느 정도 마친 뒤 "새 프로젝트 시작", "이걸로 가자", "프로젝트 만들자" 류 요청에 사용. 빈 문서가 아니라 직전 대화 내용으로 concept·roadmap 초안까지 채우고 CLAUDE.md를 설치한다.
---

# new-project (새 프로젝트 시작)

설계 대화가 끝난 시점에 그 내용을 문서로 굳히는 **전환점**. 빈 템플릿만 만들지 말고 **직전 대화에서 나온 설계를 초안으로 채운다.**

## 1. 확인

- 프로젝트 이름(폴더명) 확정
- **어디에 만들지** 물어본다 — 기본은 현재 작업 폴더. CLAUDE.md·훅이 제대로 작동하려면 *실제로 작업할 그 폴더*에 만든다.

## 2. 폴더 + 문서 생성

`{프로젝트명}/` 폴더를 만들고, `${CLAUDE_PLUGIN_ROOT}/templates/`에서 복사:
- `concept.md` `dashboard.md` `roadmap.md` `improvements.md` `recurring-issues.md`
- `CLAUDE.md` ← 이 프로젝트의 상시 운영 지침 (매 세션 자동 로드)
- 빈 하위 폴더: `active/` `archive/` `reference/` `sessions/`

## 3. 초안 채우기 (핵심)

직전 대화 내용을 바탕으로:
- **concept.md** — 문제·솔루션·요구사항·범위·핵심 제약을 대화에서 추려 채운다
- **roadmap.md** — 합의된 phase들을 표에 적고, 첫 phase를 🟢 진행중으로
- **dashboard.md** — 한줄요약 + "다음 할 일"(보통 = 첫 phase 착수)
- (첫 phase를 바로 시작한다면 `active/phase-1-*.md`도 함께 생성 — 템플릿 `phase.md` 복사 후 채움)

## 4. 아이디어 인박스 정리

이 건이 `project-fde/ideas.md`에 있었으면 거기서 제거(또는 "▶ 프로젝트화" 표시).

## 5. 안내

```
✅ {프로젝트명} 생성 완료
   - concept·roadmap 초안 채움 / CLAUDE.md 설치됨
   - 다음: [첫 phase] 착수할까요?  ("이제 X 만들자"라고 하면 phase 자동 생성)
```

> 기록 척도·읽기 규칙은 설치된 `CLAUDE.md`에 들어가 매 세션 자동 로드된다. 전체 설계는 `${CLAUDE_PLUGIN_ROOT}/design.md`.
