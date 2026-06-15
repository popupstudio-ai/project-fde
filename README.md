# project-fde

고객사 작업을 **하나씩** 문서로 관리하는 Claude Code 플러그인. 세션이 끊기거나 담당자가 바뀌어도 **다음 세션이 5초 만에 이어받게** 한다.

## 설치

```bash
# 1) 마켓플레이스 등록
claude plugin marketplace add https://github.com/popup-jacob/project-fde
# 2) 설치 (user 스코프 = 모든 프로젝트에서 사용)
claude plugin install project-fde@project-fde
```

> 훅·스킬 갱신 후엔 `/reload-plugins`.
> ⚠️ Windows: 세션 시작 자동 브리핑 훅은 `bash`(Git Bash) 경유 — PATH에 bash가 있어야 뜬다. 안 떠도 각 프로젝트 `CLAUDE.md`가 같은 일을 지시하므로 동작엔 지장 없다.

## 스킬 3종 (슬래시 또는 자연어로 트리거)

| 스킬 | 언제 | 자연어 예시 |
|---|---|---|
| `/project-fde:briefing` | 세션 시작 | "지금까지 뭐했고 다음은?" |
| `/project-fde:new-project` | 설계 대화 후 | "새 프로젝트 시작" |
| `/project-fde:wrap-up` | 세션 끝 | "문서 업데이트하고 끝내자" |

새 단계(phase)는 명령어 없이 자동 — "이제 X 만들자"라고 하면 생성된다.

## 더 보기

- 설계 근거 → `design.md`
- 작업 원칙 → `principles.md`
- 사용 매뉴얼(세션 운전법·commit 빈도 등)은 별도 제공 예정.
