# 상담 평가 섹션 AI 종합 코멘트 추가

## Context
상담 평가 섹션에서 레이다 그래프 상하단에 빈 공간이 생겨 휑해 보이는 문제를 해결한다.
상단에 AI 종합 평가 코멘트 한 줄을 추가해 빈 공간을 채우고 정보 밀도를 높인다.

## 작업 파일
- `D:\Claude Code\poc\ipo\advisor\tobe_advisor_20260413_6_re.html`

## 구현 계획

### 1. CSS 추가 (`.eval-comment`)
```css
.eval-comment {
  font-size: 11.5px; color: #444; line-height: 1.5;
  background: #f5f7fb; border-radius: 4px;
  padding: 6px 10px; margin-bottom: 8px;
  border-left: 3px solid #2c4a7c;
  width: 100%;
}
.eval-comment .comment-label {
  font-size: 10px; font-weight: bold; color: #2c4a7c; margin-bottom: 2px;
}
```

### 2. HTML 수정
`.eval-body` 안, `.radar-layout` 위에 코멘트 요소 추가:
```html
<div class="eval-comment">
  <div class="comment-label">AI 종합 평가</div>
  전반적으로 양호한 상담 수준이나, 공감 대응 영역에서 고객 우려에 대한 추가 설명이 다소 부족하였습니다.
</div>
```

### 3. eval-body 정렬 수정
코멘트가 상단에 붙도록 `justify-content: center` → `justify-content: flex-start`로 변경.
레이다 레이아웃은 남은 공간에서 수직 중앙 배치(`margin: auto`).

## 검증
브라우저에서 파일을 열어 다음 확인:
- 코멘트가 상담 평가 섹션 상단에 표시됨
- 레이다 그래프가 코멘트 아래 중앙에 배치됨
- 상하단 빈 공간이 자연스럽게 줄어듦
