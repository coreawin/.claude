---
name: project_col3_channel_panel
description: 3단 채널 패널 설계 결정사항 — 메인 검색과 독립 동작, B+D 소스, 최신성 가중치
type: project
---

3단 컬럼은 영상 목록이 아니라 **채널 추천 패널**로 구현됨 (메인 검색과 완전 독립).

**채널 소스:**
- B방식(주): `videos.list?chart=mostPopular` — YouTube 자체 알고리즘 기반, 1시간 캐시
- D방식(보조): `search.list?type=channel&q=역사/과학/뉴스` — 6시간 캐시 (search.list 100단가 부담)
- B+D 병합, 최대 20채널 처리

**TOP3 고정 문제 해결:**
- 최근 90일 이내 영상만 조회 (과거 바이럴 차단)
- 최신성 가중치: 7일=×2.0, 30일=×1.5, 90일=×1.0
- 카드 표시는 실제 효율(가중치 미적용)값으로 표기

**AI 난이도 3단계 (어려움 없음):**
- 🟢 쉬움: 카테고리 25/27/28 또는 역사/분석/비교 패턴
- 🟡 보통: 기본값
- 🟠 주의: 카테고리 22/23/26 또는 브이로그/먹방 패턴

**Why:** 구글 트렌드 키워드가 유튜브 알고리즘과 불일치 → 트렌드 키워드 검색 방식 포기, YouTube mostPopular 차트 직접 활용

**How to apply:** 3단 관련 수정 시 메인 검색 로직(runSearch)과 분리된 loadChannelPanel 함수 수정. 캐시 키: CH_B_CACHE_KEY, CH_D_CACHE_KEY
