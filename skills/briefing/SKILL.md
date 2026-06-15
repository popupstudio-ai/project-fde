---
name: briefing
description: 프로젝트 세션 시작 시 현황 브리핑. "지금까지 한 것 / 다음 할 일"을 파악할 때, "브리핑", "어디까지 했지", "현황", "status", "이어서 하자" 류 요청에 사용. 현재 프로젝트 폴더의 dashboard·roadmap·현재 phase만 읽고 3줄로 요약한다.
---

# briefing (세션 시작)

현재 프로젝트의 상태를 **최소한만 읽고** 빠르게 파악해 사용자에게 브리핑한다.

## 읽을 것 (이것만 — 토큰 절약)

현재 작업 중인 프로젝트 폴더에서:
1. `concept.md` — 가볍게 (뭐 하는 프로젝트인지만)
2. `dashboard.md` — 현재 상태·다음 할 일·최근 결정
3. `roadmap.md` — 어느 phase까지 왔는지
4. `active/` 안의 현재 진행 phase 파일 1개

## 읽지 말 것 (필요할 때만)

- `archive/` (끝난 phase) · `reference/` (스펙) · `sessions/` (옛 일지)
- dashboard/roadmap이 가리키는 포인터만 인지하고, 실제 작업에 필요해질 때 펼친다.

## 출력 (3줄)

```
지난번까지: [dashboard 최근 결정 + active 최근 실행기록]
현재 phase: [roadmap의 현재 phase]
다음 할 일: [dashboard 다음 할 일]
```

그다음 "이어서 진행할까요?"로 사용자 확인.

> dashboard가 없으면(=아직 project-os 프로젝트가 아니면) 조용히 넘어가고, 일반 대화로 진행한다.
