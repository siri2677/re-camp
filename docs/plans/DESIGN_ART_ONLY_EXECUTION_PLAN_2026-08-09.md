# Re:Camp 기획·아트 전용 실행 계획

> 작성일: 2026-08-09
> 상태: Active
> 범위: 전체 게임 기획과 아트 제작
> 기술 코드·Unity 통합: 이 작업 범위에서 제외

## 1. 목표

Re:Camp 전체 게임의 플레이 경험을 먼저 기획하고, 그 기획을 기준으로 캐릭터·환경·UI·VFX의 시각 자산을 제작·검토한다. 이 문서는 기획 결과와 아트 결과를 사람 승인까지 추적하는 실행 기준이다.

최종 게임 코드나 Unity 통합을 완료했다고 주장하지 않는다. 승인된 아트와 명세를 별도 기술 작업으로 넘길 수 있는 상태를 만드는 것이 이 범위의 완료점이다.

## 2. 작업 경계

### 이 문서에서 진행하는 것

- 핵심 게임 루프와 MVP 범위
- 전투·탐험·귀환·정산·캠프 성장 기획
- 캐릭터 역할·능력·성격·한 문장 훅
- 스테이지·적·보스·자원·캠프 시설의 콘텐츠 기획
- UI/UX 정보 구조와 화면별 아트 방향
- 캐릭터 Key Art·제작 시트·표정·실루엣·팔레트·장비 디자인
- 2D→3D 변환표와 3D Character Proof용 시각 기준
- 환경·몬스터·소품·UI·VFX 아트 방향과 리뷰 자산
- Gate A/B 승인 기록, metadata, Export·handoff 패키지

### 이 문서에서 진행하지 않는 것

- Unity C# 코드 작성·수정
- Unity Scene·Prefab·Animator·Material 연결
- Android APK/AAB 빌드와 실기기 테스트
- Unity Gate C 실행
- 코드 테스트·CI·성능 프로파일링

Gate C에 필요한 Unity 증거는 기술 작업자가 승인된 아트 패키지를 받은 뒤 별도 진행한다.

## 3. 기준 문서

| 영역 | 기준 문서 |
|---|---|
| 제품·MVP | `docs/00_project/PROJECT_OVERVIEW.md`, `docs/01_game_design/MVP_SCOPE.md` |
| 핵심 루프 | `docs/01_game_design/CORE_LOOP.md` |
| 시스템 | `docs/02_system_design/MVP_SYSTEM_ARCHITECTURE.md` |
| 캐릭터·아트 | `docs/05_art_concept/ART_DIRECTION.md`, `CHARACTER_BIBLE.md`, `CHARACTER_ANCHOR_SPEC.md` |
| 리뷰 판정 | `docs/05_art_concept/ART_REVIEW_CHECKLIST.md` v2.2 |
| 자산·metadata | `ART_ASSET_STRUCTURE.md`, `ASSET_NAMING_GUIDE.md`, `AI_ASSET_METADATA_TEMPLATE.md` |
| 실행 상태 | `planning/DESIGN_DIRECTION_2026-08-09.md`, `planning/sprint_backlog.md`, `planning/DESIGN_PROGRESS_2026-08-07.md` |

## 4. 현재 아트 완료 판정

### 판정: `REVIEW / NOT COMPLETE`

새 기준의 5인 2D 제작 패키지는 일본 모바일 서브컬처 얼굴·헤어·셀 색면·성인 여성 체형·개별 역할 훅을 반영한 REVIEW 단계까지 작성됐다. 그러나 사람 Gate A 승인이 없으므로 공식적으로 완료되거나 `APPROVED`로 승격되지 않았다.

| 항목 | 현재 상태 | 근거 |
|---|---|---|
| 5인 전신 후보 3안 | 5/5, Review evidence complete | `DESIGN_PROGRESS_2026-08-07.md` |
| 선택 Key Art | 5/5, Review | 동일 |
| Front/Side/Back Turnaround | 5/5, Review | 후면·장비 연속성 재확인 필요 |
| 표정 8종 | 5/5, Review evidence complete | 동일 |
| 장비·팔레트·재질 | 5/5, Review evidence complete | 동일 |
| 128px 얼굴·실루엣·저채도 비교 | 5/5 근거 작성 | Gate C 런타임 판독은 별도 |
| 2D→3D 변환표 | 5/5 이미지 근거 | Blender·Unity 검증 전 |
| 사람 Gate A | 0/5 | 사용자 판정 대기 |
| 3D Blockout | 0/5 | Gate A 이후 루나부터 진행 |
| 최종 Unity 아트 | 0/5 | Gate B/C 이후 진행 |

따라서 현재 자산은 **새 기준에 맞춘 검토용 제작 패키지까지 완료**되었으며, **최종 아트 작업 완료는 아니다**.

## 5. 사람 승인 절차

### 5.1 승인 상태

- `WIP`: 제작 중. 제작 기준과 최종 게임 사용 금지
- `REVIEW`: 비교·수정·방향 검토 가능. 최종 모델링 기준 금지
- `APPROVED`: 사람 리뷰어가 해당 Scope와 Gate를 명시해 승인한 제작 기준
- `CONDITIONAL`: 방향은 유효하지만 지정 수정 후 재검토 필요. 승인 아님
- `REJECTED`: 제작 기준으로 사용 금지
- `SUPERSEDED`: 새 버전으로 대체됨
- `ARCHIVE`: 이력 보관

### 5.2 Gate A: 2D 방향 승인

Gate A는 “무엇을 만들 것인가”를 승인한다. Unity Import나 최종 3D 완성을 의미하지 않는다.

1. 캐릭터별 REVIEW 자산과 companion metadata를 준비한다.
2. `ART_REVIEW_CHECKLIST.md`의 PRE-01~PRE-08을 확인한다.
3. `CHA-A01~CHA-A19`를 적용한다.
4. 전신·얼굴·128px·장비 포함/제거 실루엣·저채도·표정·5인 교차 보드를 함께 검토한다.
5. 매력성·성인 여성 가독성·한 문장 훅·역할 가독성·원작성에 대해 사람 리뷰어가 판정한다.
6. `PASS`인 항목만 Gate A 통과로 계산한다. `FAIL`, `CONDITIONAL`, `NOT TESTED`가 있으면 승인하지 않는다.
7. 수정이 필요하면 기존 파일을 덮어쓰지 않고 새 버전으로 만들며, metadata에 변경 사유와 이전 판정을 남긴다.
8. 모든 필수 조건과 사람 결정이 기록된 뒤에만 해당 캐릭터를 `APPROVED`로 승격한다.

사용자는 캐릭터별로 다음 형식으로 결정하면 된다.

```text
[Gate A 결정]
캐릭터: 루나
자산 버전: Luna_KeyArt_REVIEW_v002 / Luna_CharacterSheet_REVIEW_v002
범위: Character 2D
결정: APPROVED / CONDITIONAL / REJECTED
필수 수정: 없음 또는 항목 목록
리뷰어: 이름 또는 사용자
날짜: YYYY-MM-DD
```

5인 전체 방향은 루나·미유·코코·이리스·노아를 각각 검토하며, 공식 A2 완료는 5명 모두 `APPROVED`일 때만 인정한다.

### 5.3 Gate B: 2D→3D 제작 가능성

Gate A 승인 후에만 진행한다.

- 승인된 2D 시트와 Turnaround 일치
- 캐릭터별 2D→3D 확대·삭제·결합 규칙
- 5~6등신 목표와 성인 여성 가독성
- 얼굴·헤어·의상·장비 구조
- 포즈·관절·관통·물리 위험
- 공용 Rig·Material·Animation으로 제작 가능한 구조
- 루나 3D Character Proof와 비용·품질 기준

Gate B는 Blender 또는 시각 Blockout 증거로 검토한다. Unity 적용은 이 문서의 범위가 아니다.

### 5.4 Gate C handoff

Unity 통합은 별도 기술 트랙으로 넘긴다. 넘길 때 다음을 포함한다.

- 승인된 Source·Export 파일
- 버전·GUID·이름 manifest
- companion metadata와 라이선스 근거
- 색상·Material·Socket·Animation·VFX 요구사항
- 2D/3D 비율과 카메라 기준
- 알려진 관통·가독성·성능 위험
- 기술팀이 실행할 Gate C 체크리스트

## 6. 전체 기획 실행 순서

### Phase 0 — 기준선 잠금

- MVP 핵심 루프를 한 문장과 단계별 행동으로 고정한다.
- 플레이어 목표·위험/보상·실패/성공·반복 이유를 확정한다.
- 캐릭터·스테이지·적·자원·캠프의 범위를 MVP와 이후 확장으로 나눈다.
- 각 기획 항목에 ID·완료 조건·필요 아트 산출물을 붙인다.

### Phase 1 — 콘텐츠별 세부 기획

각 콘텐츠에 다음 양식으로 작성한다.

```text
Content ID:
Player goal:
Player action:
Runtime rule / balance intent:
Reward or failure:
Required art assets:
Required review evidence:
Dependencies:
Completion gate:
Status:
```

대상은 다음 순서다.

1. 루나와 5인 전투 역할
2. 전투·탐험·귀환·정산
3. 캠프 시설·자원·성장
4. 스테이지·일반 몬스터·보스
5. 로비·캐릭터 선택·전투 HUD·결과
6. 튜토리얼·대화·장기 콘텐츠

### Phase 2 — 5인 2D 아트 Gate A

- 기존 REVIEW 패키지는 유지하고 승인본으로 간주하지 않는다.
- `ART-1510` 기준으로 새 레퍼런스 품질 매트릭스와 v2.2 checklist를 재검토한다.
- 필요한 캐릭터만 새 버전으로 교정한다.
- 루나 → 미유 → 코코 → 이리스 → 노아 순서로 사람 결정을 받는다.
- Gate A 이전에는 최종 3D 대량 제작을 시작하지 않는다.

### Phase 3 — 루나 Character Proof

- 승인된 루나 Key Art·제작 시트 확정
- 2D 6.9~7.1등신과 3D 5.3~5.4등신 변환표 확정
- 센서 고양이 후드·쌍 에너지 단검·손목 스캐너 구조 확정
- Blender 3D Blockout과 대표 포즈·장비·얼굴 식별성 검토
- Gate B 판정과 수정 이력 기록

### Phase 4 — 공용 3D와 나머지 캐릭터 아트

- 루나에서 검증한 공용 Base Mesh·Rig·Shader·Animation 규칙을 문서화한다.
- 미유 → 코코 → 이리스 → 노아 순으로 3D Proof를 확장한다.
- 환경·몬스터·캠프·UI·VFX의 방향 시트를 작성한다.
- 캐릭터별 Portrait·Icon·VFX·Animation 요구사항을 시각 패키지로 정리한다.

### Phase 5 — 기술팀 handoff

- 승인 자산만 Export한다.
- REVIEW·REJECTED·SUPERSEDED 자산을 기술팀의 제작 기준에서 제외한다.
- manifest·metadata·라이선스·변경 이력과 함께 전달한다.
- Unity Import·Prefab·Animator·VFX·Android Gate는 기술팀에서 별도 수행한다.

## 7. 완료 조건

이 기획·아트 전용 작업은 다음을 만족할 때 완료로 판정한다.

- 전체 게임 MVP와 확장 범위가 문서로 고정됨
- 각 핵심 콘텐츠에 플레이 목적·규칙·보상·아트 요구사항·완료 Gate가 있음
- 5인 2D 디자인이 새 기준으로 검토되고 사람 Gate A 결정을 받음
- 루나 3D Character Proof가 Gate B를 통과함
- 나머지 콘텐츠의 아트 요구사항과 우선순위가 정리됨
- 모든 전달 자산에 이름·버전·metadata·라이선스·Scope가 있음
- 기술팀이 별도 해석 없이 Unity 통합을 시작할 수 있음

## 8. 현재 즉시 다음 작업

1. 기존 5인 REVIEW 패키지는 역사·비교 자료로만 보존하고 새 컨셉의 후보로 사용하지 않는다.
2. 기존 외형을 참고하지 않은 원작 후보를 캐릭터별 최소 3안 만든다.
3. 사용자 지정 레퍼런스의 품질 축, 전체 게임 역할, Re:Camp 세계 기능을 기준으로 신규 후보를 비교한다.
4. 사용자가 신규 후보를 Gate A에서 선택·승인한다.
5. 승인된 신규 후보만 제작 시트·2D→3D Proof로 확장하며, 이 문서 범위에서는 코드 작업을 추가하지 않는다.


## 9. 현재 Gate A 검토 이미지 위치

저장소 기준 루트는 `art_refs/characters/`다. 아래 파일은 현재 각 캐릭터의 대표 REVIEW 자산이다.

| 캐릭터 | 대표 Key Art | 통합 제작 시트 | 추가 검토 자료 |
|---|---|---|---|
| 루나 | `art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v002.png` | `art_refs/characters/luna/Luna_CharacterSheet_REVIEW_v002.png` | `turnaround/Luna_Turnaround_REVIEW_v004.png`, `expressions/Luna_ExpressionSheet_REVIEW_v002.png`, `equipment/Luna_EquipmentSheet_REVIEW_v002.png`, `3d_reference/Luna_2DTo3DTranslation_REVIEW_v004.png` |
| 미유 | `art_refs/characters/miyu/concept/Miyu_KeyArt_REVIEW_v002.png` | `art_refs/characters/miyu/Miyu_CharacterSheet_REVIEW_v002.png` | `turnaround/Miyu_Turnaround_REVIEW_v002.png`, `expressions/Miyu_ExpressionSheet_REVIEW_v002.png`, `equipment/Miyu_EquipmentSheet_REVIEW_v002.png`, `3d_reference/Miyu_2DTo3DTranslation_REVIEW_v002.png` |
| 코코 | `art_refs/characters/coco/concept/Coco_KeyArt_REVIEW_v005.png` | `art_refs/characters/coco/Coco_CharacterSheet_REVIEW_v002.png` | `turnaround/Coco_Turnaround_REVIEW_v002.png`, `expressions/Coco_ExpressionSheet_REVIEW_v002.png`, `equipment/Coco_EquipmentSheet_REVIEW_v002.png`, `3d_reference/Coco_2DTo3DTranslation_REVIEW_v002.png` |
| 이리스 | `art_refs/characters/iris/concept/Iris_KeyArt_REVIEW_v006.png` | `art_refs/characters/iris/Iris_CharacterSheet_REVIEW_v002.png` | `turnaround/Iris_Turnaround_REVIEW_v003.png`, `expressions/Iris_ExpressionSheet_REVIEW_v002.png`, `equipment/Iris_EquipmentSheet_REVIEW_v002.png`, `3d_reference/Iris_2DTo3DTranslation_REVIEW_v002.png` |
| 노아 | `art_refs/characters/noah/concept/Noah_KeyArt_REVIEW_v003.png` | `art_refs/characters/noah/Noah_CharacterSheet_REVIEW_v002.png` | `turnaround/Noah_Turnaround_REVIEW_v003.png`, `expressions/Noah_ExpressionSheet_REVIEW_v002.png`, `equipment/Noah_EquipmentSheet_REVIEW_v002.png`, `3d_reference/Noah_2DTo3DTranslation_REVIEW_v002.png` |

전체 비교는 다음 두 파일을 먼저 본다.

- `art_refs/characters/lineup/ReCamp_FiveCharacterLineup_REVIEW_v002.png`
- `art_refs/characters/lineup/ReCamp_FiveCharacterCrossReview_REVIEW_v002.png`

`REVIEW`는 승인 전 검토본이다. 사용자가 Gate A를 명시적으로 승인하기 전까지 이 파일들을 `APPROVED`로 변경하지 않는다.
## 10. 컨셉 리셋 결정

기존 캐릭터의 이름·훅·얼굴·헤어·의상·장비는 강제하지 않는다. 현재 REVIEW 자산은 신규 컨셉의
기준선이 아니라 역사·비교 자료다. 새 후보가 승인되면 기존 자산은 `SUPERSEDED` 또는 `ARCHIVE`로 기록한다.

새 후보는 프리미엄 모바일 애니메이션 마감, 성인 여성의 매력과 자신감, 세련된 레이어드 패션,
비대칭 기능 장비, 읽기 쉬운 전투 실루엣, 정제된 감정 연출을 목표로 한다. 특정 작품의 고유
캐릭터·얼굴·의상·무기·포즈·UI·로고는 복제하지 않는다.

상세 브리프는 `planning/ART_DIRECTION_RESET_BRIEF_2026-08-09.md`에서 관리한다.
