# Re:Camp Art Production MCP Guide

이 문서는 Re:Camp의 2D 콘셉트 아트, 캐릭터 제작 시트, 3D 모델, Unity 통합을 반복 가능하게 만드는 MCP·AI 도구 운영 기준이다.

## 1. 기본 원칙

- MCP는 제작 속도와 반복성을 높이는 도구이며 최종 미감과 캐릭터 매력 판단은 사람이 담당한다.
- 한 번의 프롬프트로 만든 이미지를 최종 디자인으로 확정하지 않는다.
- 캐릭터별 승인된 기준 이미지와 디자인 시트를 먼저 만든 뒤 3D 작업으로 이동한다.
- 도구별 역할을 분리하고 동일한 작업을 여러 MCP가 중복 수정하지 않도록 한다.
- 모든 최종 산출물은 Git에 저장하며 소스 파일과 Export 파일을 구분한다.

## 2. 권장 도구 구성

| 도구 | 주 역할 | Re:Camp에서의 사용 범위 |
|---|---|---|
| ComfyUI MCP | 2D 이미지 생성과 반복 워크플로 | 전신 시안, 표정, 포즈, 장비, 배경, 몬스터, VFX 콘셉트 |
| Figma MCP | 디자인 시트와 UI 문서 구성 | 캐릭터 시트, 컬러 팔레트, 장비 주석, UI 시스템, 진행 보드 |
| Blender MCP | 3D Blockout과 반복 모델링 | 캐릭터 베이스 검증, 무기, 드론, 시설, 배경 소품, 몬스터 초안 |
| Coplay/Aura MCP | Unity Editor 통합 | Import, Prefab, Material, Animator, Collider, Scene, UI 연결 |
| GitHub MCP | 형상·문서·작업 관리 | Issue, 브랜치, PR, 아트 문서, 레퍼런스 버전 관리 |
| 코드 에이전트 | Unity 코드와 자동화 | Importer, ScriptableObject, 셰이더 설정, 에셋 검증 도구 |

## 3. 도입 우선순위

```text
1. ComfyUI MCP
2. Figma MCP
3. Blender MCP
4. Coplay/Aura MCP
5. GitHub MCP와 CI 자동화
```

현재 단계에서는 캐릭터의 2D 기준 디자인과 제작 시트 확정이 우선이므로 ComfyUI와 Figma의 효율이 가장 높다. 디자인이 확정되기 전에 Blender 작업을 시작하면 모델을 반복 제작할 가능성이 크다.

## 4. ComfyUI MCP

### 담당 작업

- 캐릭터 단독 전신 시안
- 동일 캐릭터의 얼굴·의상 변형
- 표정 시트 초안
- 대표 포즈와 전투 포즈
- 무기·장비 디자인 변형
- 폐허와 캠프 배경 콘셉트
- 몬스터와 보스 실루엣
- 스킬 VFX 콘셉트

### 권장 작업 방식

```text
캐릭터 바이블 확정
→ 캐릭터 단독 기준 이미지 생성
→ 얼굴과 의상 후보 비교
→ 승인된 기준 이미지 고정
→ 표정·포즈·장비 변형 생성
→ Figma에서 제작 시트 구성
```

### 캐릭터 일관성 규칙

- 다섯 캐릭터를 한 번에 새로 생성하지 않는다.
- 캐릭터별 승인된 기준 이미지를 입력 레퍼런스로 사용한다.
- 헤어, 눈, 의상, 무기 색상은 프롬프트와 워크플로 변수로 고정한다.
- 시드와 모델, LoRA, ControlNet, 해상도, 후처리 설정을 기록한다.
- 새로운 결과가 기준 이미지를 임의로 대체하지 않도록 버전을 분리한다.

### 출력 규격 예시

| 용도 | 권장 비율 | 배경 |
|---|---|---|
| 전신 콘셉트 | 2:3 세로 | 단색 또는 투명 |
| 얼굴·표정 | 1:1 | 단색 |
| Turnaround 참고 | 16:9 또는 넓은 가로 | 흰색 |
| 무기·장비 시트 | 16:9 | 흰색 |
| 배경 콘셉트 | 16:9 | 완성 배경 |

### 주의사항

AI 이미지의 측면·후면은 구조적으로 일치하지 않을 수 있다. Turnaround는 생성 결과를 그대로 사용하지 않고 사람이 구조를 정리한 제작 시트로 확정해야 한다.

## 5. Figma MCP

### 담당 작업

- 5인 캐릭터 라인업 보드
- 캐릭터별 디자인 시트
- 얼굴과 표정 시트
- 색상·재질 팔레트
- 의상·장비 분해 주석
- UI 디자인 시스템
- 스킬 아이콘과 VFX 보드
- 아트 리뷰 상태 관리

### 캐릭터 시트 기본 레이아웃

```text
좌측: 대표 전신 이미지
우측 상단: 얼굴 확대와 표정
우측 중앙: 정면·측면·후면 참고
우측 하단: 무기, 장비, 소품 상세
하단: 컬러 팔레트, 재질, 3D 제작 주의사항
```

### Figma 운영 규칙

- 캐릭터별 페이지를 분리한다.
- 공통 컴포넌트로 제목, 팔레트, 승인 상태, 주석 영역을 관리한다.
- WIP, Review, Approved 상태를 명확히 표시한다.
- 최종 승인 프레임만 PNG/PDF로 Export하여 Git에 저장한다.
- Figma 원본만 존재하고 Git에 기준 Export가 없는 상태를 허용하지 않는다.

## 6. Blender MCP

### 우선 적용 대상

- 에너지 단검과 에너지 라이플
- 미유의 드론과 제어 장치
- 코코의 의료 장비
- 노아의 방패
- 발전기, 작업대, 식량 창고, 통신탑
- 자원 상자, 고철, 바리케이드, 폐허 건물 모듈
- 일반 몬스터와 보스 Blockout

### 캐릭터 작업 범위

Blender MCP는 다음 작업에 활용한다.

- 신체 비율 Blockout
- 의상과 헤어의 큰 형태
- 장비 크기와 장착 위치
- 공용 Humanoid Rig 적용
- 기본 Material 슬롯 구성
- Unity Export 규칙 적용

다음 항목은 사람의 최종 검수가 필수다.

- 얼굴 조형
- 헤어카드와 머리카락 흐름
- Retopology
- UV와 Texture 품질
- Weight Painting
- 관절 변형
- 의상 관통
- 표정 BlendShape
- 헤어·의상 물리 본

### 3D 검증 순서

```text
캐릭터 시트 Approved
→ 저해상도 Blockout
→ Unity 쿼터뷰 카메라 검증
→ 실루엣과 무기 크기 수정
→ 고해상도 모델링
→ Retopology/UV/Texture
→ Rig/Weight/표정
→ Unity 최종 검증
```

## 7. Coplay/Aura MCP

### 담당 작업

- FBX와 Texture Import
- Material과 툰 셰이더 연결
- 캐릭터 Prefab 생성
- Animator Controller 구성
- Collider와 Hitbox 배치
- 머리카락·의상 물리 연결
- 캐릭터 선택·로비·전투 Scene 배치
- VFX와 사운드 연결
- 누락된 참조와 컴파일 오류 확인

### Unity 통합 원칙

- Blender 파일을 Unity에서 직접 참조하기보다 승인된 FBX Export를 사용한다.
- 캐릭터 Prefab의 공통 구조를 먼저 확정한다.
- 캐릭터별 스크립트에 게임 규칙을 중복 구현하지 않는다.
- Unity Adapter와 Presentation 계층만 캐릭터 Prefab에 연결한다.
- 실제 기기에서 쿼터뷰 가독성과 성능을 검증한다.

## 8. GitHub MCP

### 담당 작업

- 캐릭터·배경·UI Issue 관리
- 레퍼런스와 문서 버전 관리
- 브랜치와 PR 관리
- 승인된 이미지 변경 추적
- 파일명과 디렉터리 규칙 검토

### 브랜치 예시

```text
art/luna-concept
art/miyu-concept
art/environment-ruined-street
art/ui-battle-hud
```

### 커밋 예시

```text
art: add Luna approved concept sheet
art: update unified character lineup
art: add ruined street environment references
docs: add art production MCP guide
```

## 9. 권장 전체 파이프라인

```text
CHARACTER_BIBLE.md
→ ComfyUI MCP로 캐릭터 단독 시안 생성
→ 사람이 얼굴·의상·무기 후보 선택
→ Figma MCP로 제작 시트 구성
→ 디자인 리뷰와 Approved 처리
→ Blender MCP로 3D Blockout
→ Unity 쿼터뷰 실루엣 테스트
→ 사람 또는 전문 작업자의 최종 모델 수정
→ Coplay/Aura MCP로 Unity 통합
→ 실제 기기 테스트
→ GitHub에 승인 산출물과 메타데이터 반영
```

## 10. 인간 승인 게이트

다음 단계는 자동으로 통과시키지 않는다.

### Gate A: 캐릭터 매력

- 첫인상이 매력적인가
- 얼굴과 실루엣이 기억에 남는가
- 다섯 캐릭터가 서로 구분되는가
- 성격과 전투 역할이 외형에서 느껴지는가

### Gate B: 제작 가능성

- 의상 구조가 3D로 구현 가능한가
- 무기와 장비가 애니메이션에 적합한가
- 쿼터뷰에서 얼굴과 무기가 보이는가
- 물리 본과 관통 문제를 감당할 수 있는가

### Gate C: 게임 통합

- 일러스트와 3D가 같은 캐릭터로 보이는가
- 실제 기기에서 가독성과 성능이 확보되는가
- 공격과 스킬이 캐릭터 정체성을 전달하는가

## 11. 프롬프트 템플릿

### 캐릭터 콘셉트 생성

```text
Re:Camp의 [캐릭터명] 단독 전신 콘셉트를 제작한다.
CHARACTER_BIBLE의 역할, 색상, 성격, 무기 설정을 유지한다.
2D 일반 등신 서브컬쳐 일러스트이며 가벼운 택티컬 스트리트 패션을 사용한다.
흰색 배경, 정면 중심, 손과 무기 구조가 명확해야 한다.
기존 승인 이미지와 얼굴·헤어·의상 색을 바꾸지 않는다.
```

### Blender Blockout

```text
Approved 캐릭터 시트를 기준으로 5~6등신 스타일라이즈드 Blockout을 만든다.
공용 Humanoid 골격을 사용하고 쿼터뷰에서 머리, 상체, 무기가 식별되도록 한다.
세부 장식보다 실루엣과 장비 크기를 우선한다.
각 의상 파츠와 무기를 별도 Object로 분리하고 Pivot과 이름을 규칙에 맞춘다.
```

### Unity 통합

```text
승인된 FBX를 Import하고 ReCamp 공통 캐릭터 Prefab 구조를 사용한다.
Material, Animator, Collider, Hitbox, 물리 본을 연결한다.
게임 규칙을 MonoBehaviour에 중복 구현하지 말고 기존 Core Adapter를 사용한다.
쿼터뷰 카메라에서 실루엣과 공격 가독성을 확인한다.
```

## 12. 출시 품질에 대한 원칙

- MCP 결과물을 그대로 출시 자산으로 간주하지 않는다.
- 캐릭터 얼굴, 헤어, 의상, 애니메이션은 최종 리터칭 단계를 거친다.
- 배경과 소품은 자동화 비율을 높이되 캐릭터 관련 자산에는 더 높은 검수 비용을 배정한다.
- 콘텐츠 수보다 다섯 캐릭터의 매력과 일관성을 우선한다.
