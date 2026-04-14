# Plan: Disable Skills for wooricapital Project

## Context
이 프로젝트(wooricapital)는 순수 HTML/CSS/JS 프로토타입으로, cn-create-base-web, cn-ntfy-hooks, cn-web-verify 등 커스텀 스킬이 불필요하다. 매 대화마다 system-reminder에 스킬 목록이 로드되어 불필요한 토큰이 소비되고 있다.

## Token Savings

| | 값 |
|--|--|
| **ASIS** | ~600 tokens/대화 (12개 스킬 설명 system-reminder) |
| **TOBE** | 0 tokens |
| **개선율** | **100%** (스킬 관련 토큰 완전 제거) |

## Changes

### 1. `.claude/settings.local.json` 수정
**파일:** `D:\Claude Code\poc\wooricapital\.claude\settings.local.json`

기존 permissions에 `enabledPlugins` 추가:
```json
{
  "permissions": {
    "allow": [
      "Bash(python3)",
      "Bash(python3 -c ':*)",
      "Bash(node -c common.js)",
      "Bash(node -c member.js)"
    ]
  },
  "enabledPlugins": {
    "superpowers@claude-plugins-official": false
  }
}
```

### 2. `CLAUDE.md` 끝에 섹션 추가
**파일:** `D:\Claude Code\poc\wooricapital\CLAUDE.md`

```markdown
## 스킬(Skills) 비활성화

이 프로젝트는 Claude Code 스킬을 사용하지 않습니다.
`.claude/settings.local.json`의 `enabledPlugins: false` 설정으로 비활성화되어 있습니다.
불필요한 스킬 토큰 소비를 방지하기 위한 의도적 설정입니다.
```

## Verification
- Claude Code 재시작 후 system-reminder에서 스킬 목록이 사라지는지 확인
- `settings.local.json` 파일이 올바르게 저장되었는지 확인
