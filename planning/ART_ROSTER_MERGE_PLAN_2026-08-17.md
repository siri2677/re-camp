# Current Art Roster Merge Plan — CH102 Selective Integration

> 최종 갱신: 2026-08-17
> 상태: `REVIEW / MERGE NOT EXECUTED`
> 목적: `current/art-roster-gate-a-ch102`의 검증 가능한 CH102 2D 결과를 Current Generation에 안전하게 통합

이 문서는 Git 병합 명령을 실행하지 않는다. 브랜치 간 파일 차이, 문서 소유권, 사람 Gate, 2D/3D 경계를 확인한 뒤 선택 통합을 수행하기 위한 실행 계획이다.

## 1. 결론 요약

`current/art-roster-gate-a-ch102`는 Git 기준으로는 `current/recamp-unified`와 텍스트 충돌 없이 병합할 수 있다. 그러나 이 브랜치는 CH102 전용 브랜치가 아니다.

- `current/recamp-unified`: `7f5d967`
- `current/art-roster-gate-a-ch102`: `b6c9b31`
- 차이: Current 기준 `66`개 커밋, 약 `254`개 변경 경로
- 포함 범위: CH101~CH105 2D 패키지, 5인 교차 리뷰, 공통 문서, CI 변경, Colab/Blender scaffold
- `git merge-tree --write-tree` 결과: textual merge conflict 없음

따라서 전체 브랜치를 한 번에 머지하지 않는다. 우선 CH102의 2D Gate A/Production Sheet 근거만 선별해 통합하고, Gate B·3D·Unity·Android 결과는 별도 작업으로 유지한다.

## 2. 브랜치 역할과 기준 시점

| 브랜치 | 기준 커밋 | 역할 | 머지 판단 |
|---|---|---|---|
| `current/recamp-unified` | `7f5d967` | Current Generation 활성 통합 기준 | 제품·플랫폼·전역 Gate의 기준 |
| `feature/android-safearea-validation` | `c36a33e` | Android preflight·Safe Area·Touch 검증 작업 | Android PR 통합 선행 또는 별도 검토 |
| `current/art-roster-gate-a-ch102` | `b6c9b31` | 5인 아트 패키지와 CH102 Gate A 기록 | CH102 증거 선별 통합 대상 |
| `legacy/recamp-pre-generation` | `fbc802a` | Legacy 동결 참조 | Current에 직접 머지 금지 |

### 최신성 규칙

“가장 최근 커밋”과 “최종 기준”은 같은 의미가 아니다.

1. 제품·플랫폼·전역 로스터·비율·Gate: `docs/00_project/CURRENT_PROJECT_BASELINE.md`가 우선한다.
2. 캐릭터 세부 계약: `CHARACTER_BIBLE.md`, `CHARACTER_ANCHOR_SPEC.md`, `ART_DIRECTION.md`를 대조한다.
3. 아트 산출물의 제작 증거: source branch의 asset metadata/review/manifest를 검토한다.
4. 작업 상태: Current의 `planning/sprint_backlog.md`와 `planning/IMPLEMENTATION_STATUS.md`만 갱신한다.
5. source branch의 `APPROVED` 문구는 증거로 읽되, Current 상태를 자동으로 `Done` 또는 `APPROVED`로 승격하지 않는다.

## 3. CH102 현재 판정

source branch의 CH102 문서가 기록하는 범위는 다음과 같다.

| 항목 | source branch 기록 | Current 통합 판정 |
|---|---|---|
| 전신 후보·A/B/C 통합 시트 | `Done` | CH102 2D 후보 근거로 검토 |
| 얼굴·헤어·Face128 | `Done` | metadata/review와 시각 원본 확인 필요 |
| 장비 ON/OFF·실루엣 | `Done` | 2D Gate A supporting evidence로 검토 |
| 사람 Gate A | `Done` | `CH102_Mao_Production_Sheet_Approval_20260811.md`의 승인 provenance 확인 |
| Approved 2D Production Sheet | `APPROVED` 기록 | CH102 2D 입력으로 선별 통합 가능 |
| Turnaround | `Review` | 3D 비율 cross-check 전에는 최종 완료 아님 |
| 표정 시트 | `Review` | 변형/3D 표정 proof 남음 |
| 장비 상세 | `Review` | socket/collider proof 남음 |
| 컬러·재질 | `Review` | shader/material import proof 남음 |
| 2D→3D 변환표 | `Review` | Gate B 기술 검증 전에는 계약 초안 |
| Blender/FBX/Unity 모델 | 없음 | 이 머지 범위에 포함하지 않음 |

즉, “CH102 작업 완료”는 **2D Gate A와 Approved Production Sheet가 준비된 상태**라는 뜻이며, 캐릭터 제작 전체 완료를 의미하지 않는다.

## 4. 충돌·불일치 지점

### 4.1 Canonical Baseline 상태 충돌

source branch는 Baseline의 디자인 상태를 다음처럼 앞당긴다.

- 캐릭터별 통제 후보 `0/15` → `1/15`
- 사람 Gate A `0/5` → `1/5` (CH101 기준으로 기록)
- Approved 2D 시트 `0/5` → `1/5`
- Character Bible/Anchor/Art Direction `v3.1` → `v3.2`

이 변경은 CH102 머지와 직접 관계가 없는 CH101 및 전역 계약까지 포함한다. CH102만 통합할 때 source branch의 Baseline 전체를 덮어쓰지 않고, 사람 승인된 범위만 Current Canonical 문서에 수동 반영한다.

### 4.2 5인 전체 승인 상태 충돌

source branch의 `planning/art_production_backlog.md`는 CH101~CH105의 후보·Face128·실루엣·Gate A를 대부분 `Done`으로 기록한다. Current 기준 문서는 아직 CH102~CH105를 `Ready/Todo`로 관리한다.

5인 상태를 한 번에 승격하려면 각 캐릭터별 승인 provenance와 사람 Gate 기록을 별도로 확인해야 한다. CH102 선택 통합에서는 CH103~CH105 상태를 변경하지 않는다.

### 4.3 전역 아트 계약 변경

source branch에는 다음 내용이 추가되어 있다.

- 밝은 아이보리·포슬린 계열 피부와 애니 셀 표현
- 성인 여성의 가슴·허리·골반 곡선 유지
- 캐릭터별 얼굴 분리 WIP

이 내용은 사용자 방향과 관련된 후보 계약이지만, CH102 파일만 머지한다고 자동으로 전역 Art Direction에 반영하면 다른 캐릭터와의 전역 검토 범위가 섞인다. 먼저 Current Art Direction/Character Bible diff를 별도 검토하고, 승인 시 별도 문서 커밋으로 반영한다.

### 4.4 Planning/Implementation 상태 충돌

source branch의 구현 상태는 CH101~CH105 2D 승인, 5인 교차 PASS, Gate B preflight 준비를 기록한다. Current에는 Android 검증과 2D WIP 기준이 최신 상태다.

source branch의 `IMPLEMENTATION_STATUS.md`, `sprint_backlog.md`를 통째로 가져오지 않고 다음만 Current 문서에 수동 정산한다.

- CH102의 실제 승인된 2D 범위
- CH102의 Gate B pending 상태
- CH103~CH105는 변경하지 않음
- Android·Unity 테스트 수치는 Current 최신 증거를 유지

### 4.5 CI·Blender·Notebook 범위 확장

source branch는 CI workflow, `.gitignore`, Colab Notebook, Blender validation scaffold까지 포함한다. 이는 CH102 2D 머지의 필수 파일이 아니다.

- `.github/workflows/*`: 별도 CI 리뷰
- `notebooks/*`, `scripts/blender/*`, `scripts/validate_colab_package.py`: Blender/Colab proof 작업으로 별도 유지
- `.blend`, `.fbx`, `.obj`, `.glb`, `.gltf`: source branch에서도 CH102 실물 모델이 확인되지 않음

## 5. 통합 대상과 제외 대상

### 1차 CH102 선택 통합 대상

- `art_refs/characters/mao/`의 CH102 2D 원본·metadata·review
- `art_source/manifests/CH102_Mao_GateA_Candidates_v002.md`
- `art_source/manifests/CH102_Mao_GateA_Validation_A_v001.md`
- `art_source/manifests/CH102_Mao_Production_Sheet_Approval_20260811.md`
- `art_source/manifests/CH102_Mao_StateReference_v001.md`
- `art_source/manifests/CH102_Mao_Production_Handoff_REVIEW_v001.md`
- `art_source/manifests/CH102_Mao_2DTo3D_Translation_REVIEW_v001.md`
- CH102 상태를 반영하는 최소 metadata/review 연결 문서

### 1차 통합에서 제외

- CH101·CH103·CH104·CH105의 상태 승격
- source branch의 전체 `CURRENT_PROJECT_BASELINE.md` 덮어쓰기
- source branch의 전체 `CHARACTER_BIBLE.md`/`CHARACTER_ANCHOR_SPEC.md` 덮어쓰기
- Gate B 승인, 3D Blockout, Rig, Shader, Animator, Prefab
- Blender/FBX/Unity import/Runtime roster 교체
- Android Character Proof
- CI workflow와 Colab/Notebook scaffold
- Legacy 브랜치 파일

## 6. 머지 전 확인 Gate

### Gate M0 — 범위 승인

- [ ] CH102의 2D Production Sheet만 1차 Current 통합 대상으로 확정
- [ ] CH103~CH105 상태를 이번 머지에서 변경하지 않음
- [ ] Gate B/3D/Unity/Android를 별도 후속 작업으로 유지

### Gate M1 — 출처·파일 무결성

- [ ] source SHA `b6c9b31` 고정
- [ ] CH102 PNG/PDF가 Git LFS pointer와 실제 원본 경로를 모두 만족
- [ ] 모든 CH102 `.metadata.md`와 `.review.md` 존재
- [ ] manifest가 실제 파일명과 일치
- [ ] source branch에 CH102 실물 3D 파일이 없다는 점을 확인

### Gate M2 — Canonical 계약 대조

- [ ] Baseline의 CH102 이름·훅·역할·2D/3D 등신 범위와 일치
- [ ] Character Bible/Anchor의 마오 활·의상·성인성·금지 조건과 일치
- [ ] 전역 피부·체형·얼굴 분리 변경은 별도 승인 대상으로 분리
- [ ] 외부 IP 유사성 기록과 source provenance 확인

### Gate M3 — Current 문서 정산

- [ ] `ART-1101~1103`, `ART-1109`만 CH102 근거로 상태 갱신
- [ ] `ART-1104~1108`은 `Review`로 유지
- [ ] Current Baseline의 승인 카운트는 사람 승인 기록 확인 후 갱신
- [ ] `IMPLEMENTATION_STATUS.md`에 CH102 2D와 Gate B pending을 기록
- [ ] Android/Unity 테스트 수치를 source branch 값으로 덮어쓰지 않음

### Gate M4 — 기술 검증

- [ ] `python scripts/validate_project_docs.py`
- [ ] `git diff --check`
- [ ] art metadata/review validator 또는 해당 작업의 수동 파일 목록 검사
- [ ] Legacy 경로가 변경되지 않음
- [ ] Unity Runtime/Scenes/CharacterRoster에 CH102를 자동 교체하지 않음

### Gate M5 — 사람 확인 및 PR

- [ ] 사용자가 CH102 2D 통합 범위를 확인
- [ ] `current/recamp-unified`에서 `feature/art-ch102-2d-integration` 분기
- [ ] 선택 파일과 최소 문서만 커밋
- [ ] Current Generation PR로 리뷰
- [ ] PR 승인 후에만 `current/recamp-unified`로 머지

## 7. 실행 순서

1. Android feature PR(`feature/android-safearea-validation`)의 Current 통합 여부를 먼저 정리한다.
2. 최신 Current 통합 HEAD에서 `feature/art-ch102-2d-integration`을 생성한다.
3. source branch에서 CH102 선택 파일만 가져온다. 전체 branch merge나 무차별 cherry-pick은 사용하지 않는다.
4. Current의 Character Bible/Anchor/Art Direction과 대조해 CH102 차이를 수동 정리한다.
5. Current `art_production_backlog.md`, `sprint_backlog.md`, `IMPLEMENTATION_STATUS.md`를 CH102 범위만 갱신한다.
6. 문서·metadata·LFS·경로 검증을 실행한다.
7. PR에서 2D Gate A 통합만 리뷰한다.
8. 머지 후 CH102 Gate B 작업 브랜치를 별도로 생성한다.

## 8. 머지 후 CH102 다음 작업

머지 자체가 3D 제작 승인을 의미하지 않는다. 다음 순서가 남는다.

```text
CH102 2D 통합
→ Gate B 사람 리뷰
→ 2D→3D 변환표 확정
→ Blender 5.2~5.3H Blockout
→ 공용 Rig/Shader/Animator/Prefab Proof
→ Unity 쿼터뷰·성능·Android Character Proof
```

Gate B에서 확인할 최소 항목은 turnaround identity, 활 socket/collider, 5.2~5.3H 비율, 6-slot material, no-physics 정책, quarter-view readability, animation clearance, Android budget이다.

## 9. 현재 판정

- Git 병합 가능성: `가능 / textual conflict 없음`
- 전체 브랜치 즉시 머지: `보류 / 범위와 상태 충돌`
- CH102 2D 선택 통합: `사람 범위 확인 후 가능`
- CH102 3D/Blender/Unity 통합: `불가 / Gate B와 실제 모델 proof 없음`
- Legacy 직접 머지: `금지`
