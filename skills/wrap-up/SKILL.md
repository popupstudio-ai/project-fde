---
name: wrap-up
description: 프로젝트 세션 끝에 문서를 정리하고 다음 세션이 깨끗이 시작되게 한다. "마무리", "정리하자", "오늘 여기까지", "지금까지 한 거 기반으로 문서 업데이트", "다음 세션 오류 없게" 류 요청에 사용. active·session-log·dashboard·roadmap을 갱신하고 끝난 phase는 archive로 옮긴다.
---

# wrap-up (세션 끝)

이번 세션에 한 일을 문서에 반영하고, 다음 세션이 맥락을 잃지 않게 정리한다.
**기록 척도**: 복구 불가능한 것만 적는다 — 왜 그 결정 / 왜 실패 / 함정. 과정 서술(파일 고침·테스트 돌림)은 적지 마라(git이 함).

## 순서대로 실행

1. **active 갱신** — `active/현재phase.md`에 이번 세션 실행기록 정리
   - 한 것 / 결과(✅성공·❌실패·△부분) / 판단(채택·폐기·보류) / **이유** / 다음 액션
   - 실패·함정은 꼭 남길 것 (안 적으면 반복함)

2. **session-log append** — `sessions/<오늘날짜>.md`에 한 항목 추가
   - 한 일(요점) / 결정·발견(복구 불가) / 막힌 것 / **다음 세션 진입점**
   - 파일 없으면 `${CLAUDE_PLUGIN_ROOT}/templates/session-log.md` 형식으로 새로 만든다

3. **dashboard 갱신** — `dashboard.md`의 한줄요약·다음 할 일·최근 결정·열린 이슈
   - ⚠️ **짧게 유지**. 부풀면 6번으로 내려보낸다

4. **roadmap 갱신** — `roadmap.md`의 현재 phase 상태 한 줄

5. **phase 완료 시** — `active/phase-N-이름`(파일이면 .md, 문서 여러 개면 **폴더째**) → `archive/`로 **이동**(지우지 않음, 이름 그대로)
   - roadmap에 ✅ + 결과 한 줄, dashboard의 "현재 phase"를 다음 것으로
   - 큰 분기면 git tag + roadmap 마일스톤

6. **부풀면 내려보내기** — dashboard/active가 길어졌으면 오래된 상세를 `sessions/`나 `archive/`로 이동 (삭제 아님)

## 끝에 보고

```
✅ 마무리 완료 — 갱신: [건드린 문서들] / 다음 진입점: [한 줄]
```

> 다음 세션은 SessionStart 훅 + `briefing` 스킬이 dashboard를 자동으로 읽으니, 여기서 **"다음 할 일"을 명확히 남기는 것**이 가장 중요하다.
