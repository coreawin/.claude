# 플랜: 비교 사용자 뷰 + 검색결과 UI 완성도 개선

## Context

이전 작업으로 단일 페이지 통합(member + non_member), 채팅 시나리오 수정이 완료된 상태.
현재 `apply()` 함수에는 비교 사용자 기능이 placeholder(alert)로만 남아 있고, 검색결과 UI가 미완성이다.

신규 수정 요구사항:
1. **비교 사용자 검색결과**: 기준+비교 사용자가 모두 선택된 경우 demo_member.html 방식의 좌우 비교 레이아웃 구현
2. **비교 사용자 검색 데이터 분리**: `compare_search_data.js` 신규 파일로 B 사용자 관점의 검색결과 데이터 제공
3. **검색결과 없음 UI**: 서식 있는 no-result 화면 + 추천 검색어 뱃지 형태 (클릭 시 검색 연동)
4. **검색결과 있음 UI**: 총 건수 표시 + 추천 이유 레이블 서식 개선

---

## 수정 대상 파일

| 파일 | 수정 내용 |
|------|-----------|
| `src/compare_search_data.js` | **신규 생성** — B 사용자 관점 검색결과 데이터 |
| `src/common.js` | `displaySearchResults`, `createSearchResultSection`, `showNoResults` UI 개선 |
| `src/member.js` | `apply()` 비교 모드 분기, `renderMain()` 비교 레이아웃 추가 |
| `src/member.html` | 비교/검색결과 관련 CSS 추가, `compare_search_data.js` script 태그 추가 |

---

## 1. compare_search_data.js 신규 생성

B사용자(수진, 20대, 연비·실용성 중시)의 검색결과 데이터. 쿼리 ID는 A와 동일(result_01~05)하나 차량 순서·강조 포인트가 다름.

```javascript
// B사용자 관점의 검색결과 (연비·실용성 우선)
var COMPARE_SEARCH_RESULTS = {
  "result_01": {
    queryId: "result_01",
    title: "수진님 추천 · 연비 특화 하이브리드 SUV",
    description: "연비·실용성 우선으로 재정렬된 결과",
    cars: [
      { img:"tucson",  brand:"HYUNDAI", name:"투싼<br>하이브리드", spec:"1.6T HEV 4WD", price:"3,247만원~", sub:"월 할부 약 67만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"연비 15.6km/L · 소형 SUV 1위" },
      { img:"sorento", brand:"KIA",     name:"쏘렌토<br>하이브리드", spec:"1.6T HEV 7인승", price:"3,890만원~", sub:"월 할부 약 78만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"패밀리 SUV · 7인승 실용성" },
      { img:"santafe", brand:"HYUNDAI", name:"싼타페<br>하이브리드", spec:"1.6T HEV 7인승", price:"4,110만원~", sub:"월 할부 약 83만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"대형 패밀리카 · 넓은 공간" },
      { img:"nx350h",  brand:"LEXUS",   name:"NX 350h<br>F SPORT",  spec:"2.5 HEV AWD",   price:"6,530만원~", sub:"월 할부 약 127만원 (60개월)", tag:"수입HEV", tagC:"tag-i", highlight:"프리미엄 HEV · 정숙성" }
    ]
  },
  "result_02": {
    queryId: "result_02",
    title: "수진님 추천 · 고성능 세단",
    description: "가성비 높은 고성능 세단 중심",
    cars: [
      { img:"k8",       brand:"KIA",     name:"K8<br>3.5 GDI",        spec:"3.5 GDI 시그니처",    price:"4,302만원~", sub:"월 할부 약 86만원 (60개월)", tag:"국산", tagC:"tag-k", highlight:"국산 대형 세단 가성비 1위" },
      { img:"grandeur", brand:"HYUNDAI", name:"그랜저<br>캘리그래피",  spec:"3.5 GDI 캘리그래피", price:"4,750만원~", sub:"월 할부 약 95만원 (60개월)", tag:"국산", tagC:"tag-k", highlight:"국민 세단 · 편의사양 풍부" },
      { img:"bmw5",     brand:"BMW",     name:"5시리즈<br>530i",       spec:"530i xDrive M스포츠", price:"7,260만원~", sub:"월 할부 약 142만원 (60개월)", tag:"수입", tagC:"tag-i", highlight:"수입 세단 엔트리 · 승차감" },
      { img:"g80",      brand:"GENESIS", name:"G80<br>3.5T AWD",      spec:"3.5T AWD 스포츠",     price:"8,190만원~", sub:"월 할부 약 162만원 (60개월)", tag:"국산", tagC:"tag-k", highlight:"국산 프리미엄 플래그십" }
    ]
  },
  "result_03": {
    queryId: "result_03",
    title: "수진님 추천 · 패밀리카 7인승",
    description: "실용적인 패밀리카 우선 추천",
    cars: [
      { img:"tucson",  brand:"HYUNDAI", name:"투싼<br>하이브리드", spec:"1.6T HEV 4WD", price:"3,247만원~", sub:"월 할부 약 67만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"소형 패밀리 SUV · 연비 우수" },
      { img:"santafe", brand:"HYUNDAI", name:"싼타페<br>하이브리드", spec:"1.6T HEV 7인승", price:"4,110만원~", sub:"월 할부 약 83만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"넓은 공간 · 7인승 패밀리카" },
      { img:"sorento", brand:"KIA",     name:"쏘렌토<br>하이브리드", spec:"1.6T HEV 7인승", price:"3,890만원~", sub:"월 할부 약 78만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"KIA 대표 패밀리카 · 7인승" }
    ]
  },
  "result_04": {
    queryId: "result_04",
    title: "수진님 추천 · 수입차",
    description: "실용성 높은 수입 SUV 중심",
    cars: [
      { img:"nx350h", brand:"LEXUS", name:"NX 350h<br>F SPORT", spec:"2.5 HEV AWD",    price:"6,530만원~", sub:"월 할부 약 127만원 (60개월)", tag:"수입HEV", tagC:"tag-i", highlight:"렉서스 입문 · 연비+프리미엄" },
      { img:"bmw5",   brand:"BMW",   name:"5시리즈<br>530i",    spec:"530i xDrive M스포츠", price:"7,260만원~", sub:"월 할부 약 142만원 (60개월)", tag:"수입", tagC:"tag-i", highlight:"수입 세단 대표 · 주행 편의" }
    ]
  },
  "result_05": {
    queryId: "result_05",
    title: "수진님 추천 · 3천만원대 국산차",
    description: "합리적 가격 + 연비 중심 국산차",
    cars: [
      { img:"tucson",  brand:"HYUNDAI", name:"투싼<br>하이브리드", spec:"1.6T HEV 4WD",  price:"3,247만원~", sub:"월 할부 약 67만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"가성비 최강 HEV SUV" },
      { img:"sorento", brand:"KIA",     name:"쏘렌토<br>하이브리드", spec:"1.6T HEV",     price:"3,890만원~", sub:"월 할부 약 78만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"3천만원대 7인승 최강" },
      { img:"k8",      brand:"KIA",     name:"K8<br>3.5 GDI",       spec:"3.5 GDI",      price:"4,302만원~", sub:"월 할부 약 86만원 (60개월)", tag:"국산", tagC:"tag-k", highlight:"대형 세단 가성비 No.1" },
      { img:"santafe", brand:"HYUNDAI", name:"싼타페<br>하이브리드", spec:"1.6T HEV 7인승", price:"4,110만원~", sub:"월 할부 약 83만원 (60개월)", tag:"HEV", tagC:"tag-h", highlight:"대형 SUV 국산 대표" }
    ]
  }
};
```

---

## 2. member.js 수정

### apply() — 비교 모드 분기 추가

```javascript
function apply() {
  if (currentUser === 'C') {
    showGuestView();
    return;
  }
  if (compareUser !== 'none' && compareUser !== currentUser) {
    showMemberView();
    renderCompareMain();   // ← 신규: 좌우 비교 뷰
  } else {
    showMemberView();
    renderMain();
  }
}
```

### renderCompareMain() — 신규 함수

demo_member.html의 `renderBlock()` 패턴을 그대로 적용. `sec-row` 2열 레이아웃.

```javascript
function renderCompareMain() {
  const section = document.getElementById('recommended-section');
  const dA = DATA[currentUser];   // 기준 사용자
  const dB = DATA[compareUser];   // 비교 사용자

  const bannerGrad = currentUser === 'A'
    ? 'linear-gradient(130deg,#0d1b4b,#1a3278 45%,#2563eb 80%,#5a8dee 100%)'
    : 'linear-gradient(130deg,#064e3b,#065f46 45%,#10b981 80%,#6ee7b7 100%)';

  section.innerHTML = `
    <div class="banner" style="background:${bannerGrad}">
      <div class="banner-txt">
        <h2>${dA.bannerText.title}</h2>
        <p>${dA.bannerText.subtitle}</p>
        <span class="banner-badge">${dA.bannerText.badge}</span>
      </div>
      <div class="banner-deco">🚗</div>
    </div>
    <div class="sec-row">
      ${renderUserBlock(currentUser)}
      ${renderUserBlock(compareUser)}
    </div>
  `;
}

function renderUserBlock(userKey) {
  const d = DATA[userKey];
  const badgeC = userKey === 'A' ? 'badge-a' : 'badge-b';
  const nameC  = userKey === 'A' ? 'name-a'  : 'name-b';
  const priceColor = userKey === 'A' ? '#1a56db' : '#28c76f';

  const cards = d.recommendedCars.map(carKey => {
    const car = getCarFromAllResults(carKey);
    if (!car) return '';
    return `
      <div class="car-card" onclick="viewDetails('${carKey}')">
        <div class="car-img">
          <img src="${CAR_IMGS[carKey]}" alt="${car.brand}">
          <span class="img-tag ${car.tagC}">${car.tag}</span>
          <div class="img-btns">
            <button class="ib" onclick="viewDetails('${carKey}');event.stopPropagation();">상세</button>
            <button class="ib" onclick="selectProduct('${carKey}');event.stopPropagation();">선택</button>
          </div>
        </div>
        <div class="car-info">
          <div class="car-brand">${car.brand}</div>
          <div class="car-name">${car.name}</div>
          <div class="car-spec">${car.spec}</div>
          <div class="price-row"><span class="price" style="color:${priceColor}">${car.price}</span></div>
          <div class="price-sub">${car.sub}</div>
        </div>
      </div>`;
  }).join('');

  return `<div>
    <div class="sec-label">
      <span class="badge ${badgeC}">딥러닝 추천</span>
      <span style="font-size:15px">✨</span>
      <span class="sec-title"><span class="${nameC}">${d.name}</span>님을 위한 AI 추천 신차</span>
    </div>
    <div class="car-grid">${cards}</div>
  </div>`;
}
```

---

## 3. common.js 수정

### displaySearchResults() — 비교 모드 분기 추가

```javascript
function displaySearchResults(matches) {
  const resultsContainer = document.getElementById('search-results-container');
  if (!resultsContainer) return;

  const recommendedSection = document.getElementById('recommended-section');
  if (recommendedSection) recommendedSection.style.display = 'none';

  // 비교 모드 판별 (member.js의 전역변수 참조)
  const isCompare = (typeof compareUser !== 'undefined' && compareUser !== 'none'
                     && typeof currentUser !== 'undefined' && currentUser !== 'C'
                     && compareUser !== currentUser);

  resultsContainer.innerHTML = '';
  resultsContainer.style.display = 'block';

  // 총 결과 건수 헤더
  const totalCars = matches.reduce((sum, m) => {
    const rd = (typeof SEARCH_RESULTS !== 'undefined') && SEARCH_RESULTS[m.id];
    return sum + (rd ? rd.cars.length : 0);
  }, 0);

  resultsContainer.insertAdjacentHTML('beforeend', `
    <div class="sr-count-bar">
      <span class="sr-count-badge">${totalCars}건</span>
      <span class="sr-count-label">검색 결과</span>
      ${isCompare ? `<span class="sr-compare-badge">비교 모드</span>` : ''}
    </div>
  `);

  for (const match of matches) {
    if (isCompare) {
      // 비교 모드: 좌우 2열 비교 섹션
      const sectionA = SEARCH_RESULTS && SEARCH_RESULTS[match.id];
      const sectionB = (typeof COMPARE_SEARCH_RESULTS !== 'undefined') && COMPARE_SEARCH_RESULTS[match.id];
      if (sectionA || sectionB) {
        resultsContainer.appendChild(createCompareSearchSection(sectionA, sectionB, match.score));
      }
    } else {
      // 단일 사용자 모드
      const resultData = SEARCH_RESULTS && SEARCH_RESULTS[match.id];
      if (resultData) {
        resultsContainer.appendChild(createSearchResultSection(resultData, match.score));
      }
    }
  }
}
```

### createSearchResultSection() — 추천 이유 레이블 추가

기존 `search-result-header`에 `sec-label` 스타일 적용:

```javascript
function createSearchResultSection(resultData, score) {
  const section = document.createElement('div');
  section.className = 'search-result-section';
  section.innerHTML = `
    <div class="sr-section-header">
      <span class="badge badge-search">AI 추천</span>
      <span class="sr-section-title">${resultData.title}</span>
      <span class="sr-section-desc">${resultData.description}</span>
    </div>
    <div class="car-grid" id="search-grid-${resultData.queryId}">
      ${resultData.cars.map(car => `...car-card HTML...`).join('')}
    </div>
  `;
  return section;
}
```

### createCompareSearchSection() — 신규

```javascript
function createCompareSearchSection(dataA, dataB, score) {
  const section = document.createElement('div');
  section.className = 'search-result-section';

  const blockA = dataA ? renderSearchBlock(dataA, 'A') : '<div class="sr-empty">결과 없음</div>';
  const blockB = dataB ? renderSearchBlock(dataB, 'B') : '<div class="sr-empty">결과 없음</div>';

  section.innerHTML = `<div class="sec-row">${blockA}${blockB}</div>`;
  return section;
}

function renderSearchBlock(resultData, userKey) {
  const badgeC = userKey === 'A' ? 'badge-a' : 'badge-b';
  const nameC  = userKey === 'A' ? 'name-a'  : 'name-b';
  const userName = (typeof DATA !== 'undefined' && DATA[userKey]) ? DATA[userKey].name : userKey+'사용자';

  const cards = resultData.cars.map(car => `
    <div class="car-card" onclick="viewDetails('${car.img}')">
      ... (기존 car-card HTML과 동일) ...
    </div>
  `).join('');

  return `<div>
    <div class="sec-label">
      <span class="badge ${badgeC}">AI 추천</span>
      <span class="sec-title"><span class="${nameC}">${userName}</span>님 · ${resultData.description}</span>
    </div>
    <div class="car-grid">${cards}</div>
  </div>`;
}
```

### showNoResults() — 서식 개선

```javascript
function showNoResults(keywords) {
  // ...컨테이너 처리...
  resultsContainer.innerHTML = `
    <div class="sr-no-result">
      <div class="sr-no-result-icon">🔍</div>
      <div class="sr-no-result-title">"${keywords.join(' ')}"</div>
      <div class="sr-no-result-sub">검색 결과를 찾지 못했어요.<br>아래 추천 검색어를 시도해보세요.</div>
      <div class="sr-suggestions">
        ${searchQueries.map(q => `
          <button class="sr-chip" onclick="document.getElementById('search-input').value='${q.label}';handleSearchInput('${q.label}')">
            ${q.description}
          </button>
        `).join('')}
      </div>
    </div>
  `;
}
```

---

## 4. member.html CSS 추가

```css
/* 검색결과 건수 바 */
.sr-count-bar { display:flex; align-items:center; gap:8px; padding:10px 4px 14px; border-bottom:1px solid #f0f0f0; margin-bottom:14px; }
.sr-count-badge { background:#1a56db; color:#fff; font-size:11px; font-weight:700; border-radius:4px; padding:2px 9px; }
.sr-count-label { font-size:12px; color:#555; font-weight:600; }
.sr-compare-badge { background:linear-gradient(90deg,#1a56db,#28c76f); color:#fff; font-size:10px; font-weight:700; border-radius:10px; padding:2px 10px; margin-left:auto; }

/* 검색결과 섹션 헤더 */
.sr-section-header { display:flex; align-items:center; gap:7px; margin-bottom:10px; }
.sr-section-title { font-size:13px; font-weight:700; color:#0a1628; }
.sr-section-desc { font-size:11px; color:#94a3b8; margin-left:4px; }
.badge-search { background:linear-gradient(90deg,#7b2ff7,#b44cff); }

/* 검색 결과 없음 */
.sr-no-result { text-align:center; padding:40px 20px; }
.sr-no-result-icon { font-size:40px; margin-bottom:12px; opacity:.5; }
.sr-no-result-title { font-size:16px; font-weight:700; color:#374151; margin-bottom:6px; }
.sr-no-result-sub { font-size:12px; color:#94a3b8; line-height:1.7; margin-bottom:20px; }
.sr-suggestions { display:flex; flex-wrap:wrap; gap:8px; justify-content:center; }
.sr-chip { background:#eef2ff; color:#1a56db; border:1px solid #c7d2fe; border-radius:20px; padding:6px 14px; font-size:11px; font-weight:600; cursor:pointer; font-family:inherit; transition:background .15s; }
.sr-chip:hover { background:#dbeafe; }

/* 비교 레이아웃 공통 */
.sec-row { display:grid; grid-template-columns:1fr 1fr; gap:14px; }
.sec-label { display:flex; align-items:center; gap:7px; margin-bottom:10px; }
.badge { color:#fff; font-size:10px; font-weight:700; border-radius:4px; padding:2px 8px; }
.badge-a { background:linear-gradient(90deg,#1a56db,#5a8dee); }
.badge-b { background:linear-gradient(90deg,#28c76f,#48d98a); }
.sec-title { font-size:13px; font-weight:700; }
.name-a { color:#1a56db; }
.name-b { color:#28c76f; }
```

`compare_search_data.js` script 태그 추가:
```html
<script src="compare_search_data.js"></script>
<script src="search_data.js"></script>
<script src="common.js"></script>
<script src="member.js"></script>
<script src="non_member.js"></script>
```

---

## 5. 뷰 전환 로직 (최종)

| selA | selB | Apply 결과 |
|------|------|-----------|
| A/B | 없음 | 단일 회원 뷰 |
| A | B | 비교 뷰 (A좌 / B우) |
| B | A | 비교 뷰 (B좌 / A우) |
| C (비회원) | - | 비회원 배너+인기차 |

검색 시:
| 모드 | 결과 |
|------|------|
| 단일 | SEARCH_RESULTS (현재 데이터) 기반 car-grid |
| 비교 | SEARCH_RESULTS(A) + COMPARE_SEARCH_RESULTS(B) 좌우 sec-row |

---

## 6. 검증 방법

1. selA=A, selB=없음 → 단일 A 추천 뷰, 검색 결과 단일 그리드
2. selA=A, selB=B → 비교 뷰 (좌:준호/우:수진), 검색 시 좌우 분리 표시
3. selA=B, selB=A → 비교 뷰 (좌:수진/우:준호)
4. selA=C → 비회원 뷰, 채팅 FAB 동작
5. 검색 "연비 SUV" → 건수 바 표시, 섹션 헤더에 AI추천 뱃지
6. 검색 "없는검색어xyz" → 서식있는 no-result 화면 + 추천 검색어 뱃지 클릭 시 검색 동작
