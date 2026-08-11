# Re:Camp Current Generation Art Production Roadmap

> 최종 갱신: 2026-08-10
> 역할: 아트 제작 단계와 Gate 의존 관계

전역 로스터·비율·플랫폼·Production Budget은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`가 소유한다. 캐릭터별 내용은 Character Bible/Anchor, 세부 산출물 상태는 `planning/art_production_backlog.md`가 소유한다.

## 제작 흐름

```text
Current 디자인 계약
→ 후보 생성·비교
→ 사람 Gate A
→ Approved 2D 제작 시트
→ 2D→3D 변환표·Gate B
→ CH101 3D Character Proof
→ 공용 Rig·Shader·Animator·Prefab 검증
→ 나머지 캐릭터 확장
→ 환경·UI·VFX·Audio
→ Unity·Android Gate C
→ 출시 자산 검수
```

## A0 — Current 디자인 계약 — Review

준비된 것:

- 캐릭터별 역할·성격·외형 세부.
- 제작 Anchor와 공통 시각 언어.
- Gate A/B/C와 metadata/review 규칙.
- Legacy 자산의 역사 자료 분리.

Exit: 사람 Gate A가 적용될 실제 후보와 비교 증거가 준비된다.

## A1 — 반복 가능한 2D Pipeline — In Progress

- 같은 조건의 후보 생성.
- 128px 얼굴·실루엣·저채도 비교.
- 제작 시트 Import·Clone·Export 검증.
- metadata/review/version 추적.
- 2D→3D 변환표 작성.

Exit: 한 캐릭터를 후보→승인→제작 시트까지 반복할 수 있다.

## A2 — 5인 Gate A — In Progress

캐릭터별 필수 결과:

- 통제 후보 3안 이상.
- 얼굴·전신·대표 장비·실루엣 비교.
- 평상시/임무 표정 차이.
- 사람 선택과 수정 요청.
- Approved 2D 제작 시트.

정확한 캐릭터 특징은 Character Bible/Anchor를 읽으며 이 Roadmap에 복제하지 않는다.

## A3 — CH101 Character Proof — In Progress

- Approved 2D 시트.
- 2D→3D 변환표.
- Blender Blockout.
- 공용 Rig·Shader·Animator 기반.
- 대표 Motion·VFX·Audio.
- Unity 로비·전투 통합.
- Android Gate C와 사용자 첫인상 검증.

Exit: 매력·가독성·Gameplay 훅·모델링 비용·모바일 성능이 함께 증명된다.

## A4 — 공용 3D 기반 — In Progress

- 공용 Base Mesh/Rig/Shader/Animator/Prefab 구조.
- Visual Root와 Gameplay Root 분리.
- Material·Socket·LOD·Collider·VFX 예산.
- Import/Validation 자동화.

Exit: CH101 구조로 다음 캐릭터 Blockout을 만들 수 있다.

## A5 — 나머지 캐릭터 — Todo

- 공용 기반을 사용한다.
- 얼굴·헤어·체형·대표 장비·Signature Motion·VFX만 필요한 범위에서 개별화한다.
- Production Budget을 넘는 캐릭터별 독립 Physics/Rig/Shader 구조는 만들지 않는다.

Exit: 모든 Current 캐릭터가 같은 Pipeline으로 선택·로비·전투에 통합된다.

## A6 — 환경·몬스터·소품 — Todo

- Gray Box Gameplay 구조를 보존한 상태에서 환경을 교체한다.
- 캐릭터보다 낮은 시각 밀도와 명확한 이동·전투·상호작용 가독성을 유지한다.
- 모듈형 환경과 재사용 가능한 소품 세트를 우선한다.

## A7 — UI·VFX·Audio — Todo

- Android Landscape UI Design System.
- Character Portrait/Icon.
- 역할을 구분하는 공용 기반 VFX.
- BGM·전투·UI·환경 Audio.

Exit: 기능 가독성·캐릭터 식별·모바일 성능·라이선스 검토를 통과한다.

## A8 — 통합·출시 검수 — Todo

- Source→Export→Unity 추적.
- 쿼터뷰·화면비·Safe Area 검수.
- Android 성능·발열·메모리.
- WIP·Missing·Placeholder 제거.
- AI metadata·라이선스·외부 IP 유사성 검토.
- Store 자산.

이 Roadmap에서 캐릭터 이름·정확한 비율·현재 P0 순서·개별 작업 상태를 중복 관리하지 않는다.
