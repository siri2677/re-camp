# Re:Camp Design Direction Update — 2026-08-09

## Status

- State: New Concept Package Complete — Gate A Pending
- Scope: 신규 5인 성인 여성 캐릭터의 2D 방향·전투 역할·캠프 기능·아트 승인 기준
- Canonical detail: `docs/05_art_concept/CHARACTER_BIBLE.md` v3.0, `CHARACTER_ANCHOR_SPEC.md` v3.0, `ART_DIRECTION.md` v3.0
- Execution owner: `planning/ART_DIRECTION_RESET_BRIEF_2026-08-09.md`와 `planning/sprint_backlog.md`
- Human Gate A: `0/5`

## Goal

사용자가 지정한 작품에서는 성인 여성 매력, 프리미엄 Key Art 마감, 감정 표현, 비대칭 패션,
역할 장비의 가독성 같은 품질 축만 흡수한다. 캐릭터·의상·무기·포즈·로고·UI는 직접 복제하지 않는다.

기존 루나·미유·코코·이리스·노아의 얼굴·헤어·의상·장비·훅은 새 방향의 기준에서 제거했다.
기존 자료는 `HISTORY ONLY`로 보존하며 새 컨셉과 섞어 기준을 만들지 않는다.

## New character lineup

| ID | 이름 | 훅 | 전투 역할 | 탐험·캠프 기능 |
|---|---|---|---|---|
| CH101 | 아마사와 린 | 폐허의 길을 빛나는 신호 리본으로 그리는 신호 주자 | 기동 근접·정찰 | 경로 개척·자원 탐지 |
| CH102 | 키사라기 마오 | 버려진 재료로 접히는 활을 만드는 폐허 설계자 | 지속 원거리·수집 제어 | 작업대·부품 재생 |
| CH103 | 카나데 노조미 | 죽어가는 신호를 공명으로 붙잡는 현장 의무관 | 회복·정화·보호 | 생존자 치료·신호 안정화 |
| CH104 | 시온 타테가미 | 빛의 지도를 접어 폐허의 약점을 읽는 궤도 측량사 | 약점 표식·정밀 폭발 | 지도 제작·위험 예측 |
| CH105 | 쿠로가네 아카리 | 무너지는 길에 닻을 박아 숨 쉴 공간을 만드는 전위 수호자 | 가드·밀치기·반격 | 캠프 방어·시설 보강 |

각 캐릭터의 대표 장비와 스킬 계약은 Character Bible의 세부 섹션을 단일 기준으로 한다.

## Character appeal contract

모든 캐릭터는 다음을 만족해야 한다.

1. **성인 여성성**: 얼굴·눈매·헤어·어깨·허리·골반 비율·패션·자세·표정에서 성인 여성으로 읽힌다.
2. **3초 인상**: 이름이나 설명 없이 대표 장비와 자세만으로 훅이 기억된다.
3. **패션과 기능의 결합**: 의상과 장비가 전투·탐험·캠프 기능을 설명한다.
4. **개별 매력 축**: 린은 장난스러운 자신감, 마오는 구조 집착, 노조미는 따뜻한 지휘,
   시온은 우아한 측량, 아카리는 행동형 보호로 구분한다.
5. **작은 화면 가독성**: 128px 얼굴, 흑백 실루엣, 저채도 보드, 장비 제거 상태에서 식별된다.
6. **게임 연결성**: 대표 장비·VFX·Idle·전투 자세가 매력과 역할을 함께 전달한다.
7. **원작성**: 품질 축만 흡수하고 기존 Re:Camp 또는 외부 IP의 고유 형태를 추적 가능하게 재현하지 않는다.

## Execution sequence

1. 기존 REVIEW 자산을 역사·비교 자료로 분리한다.
2. 신규 캐릭터별 3안 생성 프롬프트와 공통 Negative Prompt를 고정한다.
3. 이미지 provider 연결 후 5인 후보를 동일 조건으로 생성한다.
4. 얼굴·체형·헤어·패션·장비·포즈·색·실루엣을 5인 교차 보드에서 비교한다.
5. 사람 Gate A에서 캐릭터별 방향·매력·성인성·원작성·역할 가독성을 판정한다.
6. 승인 후보만 2D 제작 시트·Turnaround·표정·2D→3D 변환표로 확장한다.
7. 승인된 제작 시트 이후에만 Blender Blockout과 Unity Character Proof를 시작한다.

## Implementation boundary

현재 Unity Gray Box의 `CharacterId`와 기존 전투 능력은 기능 검증용 레거시 계약이다.
이번 문서 변경은 런타임 코드·저장 데이터·선택 UI를 자동 마이그레이션하지 않는다.
신규 캐릭터를 실제 플레이어블 로스터로 전환할 때는 별도 시스템 변경으로 다음을 함께 검증해야 한다.

- CharacterId와 아트 metadata의 CH101~CH105 연결
- 능력·입력·HUD·VFX·저장 데이터의 새 역할 매핑
- 해금 순서와 캠프 기능
- 기존 저장 데이터의 호환 또는 명시적 마이그레이션

따라서 현재 구현 문서의 기존 이름은 “레거시 Gray Box”로 해석하며, 신규 아트 승인으로 간주하지 않는다.

## Validation evidence

- Legacy reference alignment evidence (`HISTORY ONLY`): art_refs/characters/lineup/ReCamp_FiveCharacterReferenceAlignment_REVIEW_v001.md
- Legacy correction brief (`HISTORY ONLY`): art_refs/characters/lineup/ReCamp_FiveCharacterReferenceAlignment_ART_BRIEF_v001.md
- 레퍼런스별 흡수 품질과 Re:Camp 변형을 metadata에 기록
- 동일 크기 5인 얼굴 스트립과 128px 비교
- 장비 포함·제거 흑백 실루엣 비교
- 저채도·색각 보정 비교
- 평상시·임무 상태 표정 비교
- 동일 카메라·조명 기준의 2D 후보 비교
- 외부 IP 차이 기록과 사람 리뷰어 결정
- APPROVED 승격 전 필요한 수정·재검토 이력

## Non-goals

- 특정 작품의 캐릭터·의상·무기·포즈·UI·로고 직접 복제
- 모든 캐릭터를 동일한 노출도나 동일한 섹시함으로 통일
- 성인성을 유아형 비율 또는 기능을 해치는 노출로 표현
- 자동 생성 결과만으로 사람 Gate A를 통과시키기
- Gate A 이전의 최종 3D·Prefab·런타임 로스터 마이그레이션

## Completion criteria

- 신규 5인의 역할·성격·비주얼 훅이 `CHARACTER_BIBLE.md`에 있다.
- 신규 5인의 고정·가변·금지 앵커가 `CHARACTER_ANCHOR_SPEC.md`에 있다.
- 공통 화풍·원작성·비율·VFX 언어가 `ART_DIRECTION.md`에 있다.
- 캐릭터별 생성 프롬프트·Negative Prompt·Gate A 표가 `ART_DIRECTION_RESET_BRIEF_2026-08-09.md`에 있다.
- 제작 시트·자산 구조·명명 규칙이 신규 CH101~CH105와 일치한다.
- 현재 상태는 이미지 후보 대기, 사람 Gate A `0/5`, `APPROVED` 없음이다.
