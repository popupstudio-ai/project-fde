#!/usr/bin/env bash
# project-fde — SessionStart 자동 브리핑
# 현재 프로젝트 폴더에 dashboard.md 가 있으면(=project-fde 프로젝트면) 그 내용을 세션 시작 컨텍스트에 주입.
# 없으면 조용히 통과(일반 폴더에서는 아무것도 안 함).

DIR="${CLAUDE_PROJECT_DIR:-$PWD}"
DASH="$DIR/dashboard.md"

if [ -f "$DASH" ]; then
  echo "=== [project-fde] 세션 시작 자동 브리핑 — 현재 dashboard ==="
  cat "$DASH"
  echo ""
  echo "↑ 이 프로젝트는 project-fde로 관리됨. 위 dashboard + roadmap.md + active/ 현재 phase 를 바탕으로"
  echo "  '지난번까지 / 현재 phase / 다음 할 일' 3줄 브리핑하고 이어서 진행할지 물어라."
  echo "  archive·reference·sessions 는 필요할 때만 펼친다. (자세한 규칙 = 이 폴더의 CLAUDE.md)"
fi
