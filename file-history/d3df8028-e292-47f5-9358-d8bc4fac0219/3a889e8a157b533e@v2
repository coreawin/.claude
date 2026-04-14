---
name: renewal-page 프로젝트 구조 및 워크플로우
description: 이미지→HTML 변환 자동화 프로젝트의 폴더 구조 및 작업 방식
type: project
---

## 프로젝트 개요
Vanilla HTML + CSS + JavaScript로 이미지를 HTML로 변환하는 자동화 프로젝트.

## 폴더 구조 원칙

각 변환 요청마다 **독립된 폴더**를 생성하며, 폴더명은 요청의 목적/이름을 반영합니다.

```
renewal-page/
├── CLAUDE.md (프로젝트 지침 및 작업 원칙)
├── projects/
│   ├── [프로젝트명1]/
│   │   ├── input/
│   │   │   └── (원본 스크린샷 이미지)
│   │   ├── output/
│   │   │   └── (생성된 HTML 파일)
│   │   └── spec.md (변환 사양/요구사항)
│   ├── [프로젝트명2]/
│   │   ├── input/
│   │   ├── output/
│   │   └── spec.md
│   └── ...
├── scripts/
│   └── (공통 생성/변환 스크립트)
└── docs/
    └── process.md (작업 프로세스 문서)
```

## 작업 워크플로우

1. **요청 시점**: 사용자가 스크린샷 + 요구사항 제공
   - 폴더명: `[목적]-[구분명]` (예: `login-page-redesign`, `dashboard-v2`)
   - 함께 제공할 정보:
     - 이미지 파일 (input/)
     - 목적/설명 (spec.md)
     - 특정 요구사항 (색상, 폰트, 인터랙션 등)

2. **생성 단계**: HTML + CSS 자동 생성 또는 수동 작성
   - output/ 폴더에 index.html 저장
   - 필요시 CSS/JS 별도 파일 분리

3. **반복 수정**: 요구사항 변경 시
   - spec.md 업데이트
   - HTML/CSS 수정
   - output/에 새 버전 저장 (또는 versioning)

## 요구사항 제공 형식

사용자가 변환 요청 시 다음 정보를 함께 제공:
- **폴더명**: 프로젝트 구분명
- **이미지**: input/ 폴더에 저장할 스크린샷
- **spec.md**: 요구사항 (레이아웃, 색상, 폰트, 인터랙션 등)
