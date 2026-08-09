# Re:Camp Art Production Roadmap

> 최종 갱신: 2026-08-09
> 상태: New Concept Package Complete — Gate A Pending

## 목표

Re:Camp의 아트는 플레이 역할과 세계 기능을 먼저 정의한 뒤, 사용자 레퍼런스의 품질 축에 가까운
원작 캐릭터·환경·UI/VFX를 새로 탐색하고, 사람 승인된 2D 제작 시트에서 3D Proof와 출시 자산으로
확장한다.

```text
신규 5인 역할·훅·패션·실루엣 정의
→ 캐릭터별 3안 이미지 후보 생성
→ 사람 Gate A에서 방향 선택
→ 승인된 제작 시트·Turnaround·2D→3D 변환표
→ CH101 아마사와 린 5~6등신 Character Proof
→ 공용 Rig·Shader·Animator·Prefab 아트 규격
→ CH102~CH105 최종 모델·애니메이션·VFX
→ 환경·UI·VFX·사운드 아트 방향
→ 기술팀 handoff와 별도 Unity·Android 검증
```

현재 Unity의 기존 5인 로스터는 기능 Gray Box 검증용 레거시다. 신규 CH101~CH105 디자인과 런타임을
아직 연결하지 않았으며, 이미지 provider가 연결되기 전까지 후보 이미지 생성도 기록하지 않는다.

## 도구 도입 원칙

- 현재 문서·프롬프트·metadata 준비는 이미지 provider 없이 완료할 수 있다.
- 이미지 provider 연결 후 캐릭터별 3안을 동일 캔버스·조명·Negative Prompt로 생성한다.
- 사람 Gate A의 승인과 제작 시트를 다음 단계의 입력으로 사용한다.
- 캐릭터 일관성 대량 생성, 정밀 인페인팅, Seed·LoRA·ControlNet 고정 workflow가 실제 병목일 때
  ComfyUI 도입을 재평가한다.
- ComfyUI는 현재 `Deferred`이며 로컬 모델·GPU·설치·MCP 연결은 개발 선행 조건이 아니다.
- `Deferred`는 선택 작업이고, 이미지 provider 연결 대기는 외부 연결 `Blocked`로 기록한다.

## A0. 방향 통일 — Done

- `CURRENT_PROJECT_BASELINE.md`에 2D 약 7등신·3D 5~6등신 분리 반영
- `ART_DIRECTION.md` v3.0
- `CHARACTER_BIBLE.md` v3.0
- `CHARACTER_ANCHOR_SPEC.md` v3.0
- `ART_REVIEW_CHECKLIST.md` v3.0
- 신규 성인 여성 5인의 역할·훅·패션·기능·반전 매력
- AI 생성 metadata 양식과 외부 IP 비복제 규칙
- 기존 라인업·캐릭터별 REVIEW 자산의 `HISTORY ONLY` 전환

## A1. 반복 가능한 파이프라인 — Review

### 완료

- Git LFS 규칙
- `art_source/`와 신규 캐릭터 아트 구조
- 생성 metadata companion 규칙
- WIP / REVIEW / CONDITIONAL / APPROVED 승인 흐름
- 신규 5인 도구 비종속 Anchor와 회귀 규칙 v3.0
- 캐릭터·환경·UI/VFX Gate A/B/C 공통 리뷰 체크리스트 v3.0
- 캐릭터 제작 시트 6-Frame 규격 v003과 CH101~CH105 Instance
- 신규 이미지·Blender·Unity 자산 Export·LOD·Socket·GUID 명명 규격
- 공용·신규 캐릭터 Motion 계약의 레거시 Gray Box 경계

### 남은 작업

- 이미지 provider 연결
- 캐릭터별 3안 후보와 metadata 생성
- v003 Figma Import·Component Clone·PNG/PDF Export·사람 사용성 검토
- Gate A 선택 후보의 2D→3D 변환표
- Blender 장비 Export와 FBX → Unity Import·Material·Prefab 테스트
- ComfyUI 고정 workflow는 `Deferred`

## A2. 신규 5인 2D 디자인·Gate A — Ready / Pending

기존 5인 REVIEW 패키지는 역사·비교 자료로만 보존한다. 새 컨셉의 기준은 다음 신규 로스터다.

| ID | 이름 | 2D→3D 목표 | 훅 | 대표 장비 |
|---|---|---|---|---|
| CH101 | 아마사와 린 | 6.9~7.1H → 5.3~5.4H | 신호 리본으로 길을 그리는 신호 주자 | 단일 와이어 세이버 |
| CH102 | 키사라기 마오 | 6.8~7.0H → 5.2~5.3H | 폐품으로 접히는 활을 만드는 설계자 | 자기 활·구조 링 |
| CH103 | 카나데 노조미 | 7.0~7.2H → 5.5~5.6H | 공명으로 죽어가는 신호를 붙잡는 의무관 | 공명 배턴·응급 베일 |
| CH104 | 시온 타테가미 | 7.1~7.3H → 5.6~5.7H | 접힌 빛의 지도로 약점을 읽는 측량사 | 프리즘 측량 부채 |
| CH105 | 쿠로가네 아카리 | 7.2~7.4H → 5.7~5.8H | 닻을 박아 숨 쉴 공간을 만드는 수호자 | 키네틱 건틀릿·케이블 |

### 캐릭터별 필수 산출물

- 약 7등신 단독 전신 후보 3안 이상
- 한 문장 훅과 대표 특징 1개·보조 특징 2개 주석
- 얼굴 정면·3/4과 평상시↔임무 상태 표정
- 약 7등신 Front·Side·Back Turnaround
- 표정 시트와 128px 얼굴 비교
- 헤어 구조와 패션 Layer·기능 분해도
- 대표 장비 상세·접힘·발광·Socket 구조
- 컬러·재질 팔레트
- 대표 포즈 3종
- 외부 IP 유사성 검토와 Re:Camp 변형 metadata
- 캐릭터별 2D→3D 확대·삭제·결합 변환표

### Gate A 완료 기준

- 사용자 승인 `APPROVED` 또는 조건이 명시된 `CONDITIONAL`
- 성인 여성성·3초 훅·128px 얼굴·장비 실루엣 통과
- 5인 간 얼굴·체형·패션·색·대표 장비가 구분됨
- 전투·탐험·캠프 역할이 외형에서 설명됨
- 외부 작품의 고유 디자인을 직접 복제하지 않음
- 제작 후보의 도구·권리·입력 레퍼런스·수정 이력 metadata 존재

### 현재 판정

- 신규 역할·성격·비주얼 훅: 문서 완료
- 신규 생성 Prompt·Negative Prompt·Gate A 표: 문서 완료
- 신규 이미지 후보: `NOT CREATED / provider pending`
- 사람 Gate A: `0/5`
- `APPROVED`: `NOT GRANTED`

상세 브리프는 `planning/ART_DIRECTION_RESET_BRIEF_2026-08-09.md`와
`planning/DESIGN_DIRECTION_2026-08-09.md`를 따른다.

## A3. CH101 아마사와 린 Character Proof — Todo

- Gate A Approved 약 7등신 Key Art와 제작 시트
- 단일 와이어 세이버·신호 리본·경로 비콘 상세
- 2D 6.9~7.1H → 3D 5.3~5.4H 변환표
- `CHARACTER_3D_SPEC.md`와 Unity Presentation 계약
- Gate A/B Approved 후 Blender Blockout
- Unity 쿼터뷰에서 얼굴·리본·세이버 실루엣 Gate C 검증
- 최종 모델·Texture·Rig·Weight·BlendShape
- Idle·Run·Attack·Dash·Skill·Hit·Victory
- 전용 Toon Material·VFX·사운드·Prefab
- Android Landscape 로비·선택·전투 통합과 타깃 사용자 매력 검증

2D와 3D가 같은 아마사와 린으로 보이고 관통·변형·성능 문제가 허용 범위이며, 사용자 평가에서
신호 주자 훅과 캐릭터 매력이 전달되면 통과한다.

## A4. 공용 3D 기반 — Todo

- Character ID별 Visual Prefab·Portrait·Icon·VFX·Audio를 분리 연결하는 Unity Presentation
- 기능 Root 아래 교체 가능한 `CharacterVisual` Prefab과 장비·VFX Socket
- 캐릭터별 5.2~5.8등신을 수용하는 공용 스타일라이즈드 Base Mesh
- 공용 Humanoid 호환 Rig와 Animator
- 얼굴·눈·헤어·의상 Toon Shader·Material 슬롯
- 목표 Android 기기·프레임과 물리 본·Collider·폴리곤·Texture·LOD·VFX 예산
- Unity 캐릭터 Prefab 템플릿

CH101에서 검증된 구조로 CH102~CH105 Blockout을 만들고 공용 이동·피격 애니메이션을 재사용한다.

## A5. 나머지 캐릭터 — Todo

CH102 키사라기 마오 → CH103 카나데 노조미 → CH104 시온 타테가미 → CH105 쿠로가네 아카리 순으로 제작한다.

- CH102: 6.8~7.0H → 5.2~5.3H, 비대칭 소매·자기 활·구조 링
- CH103: 7.0~7.2H → 5.5~5.6H, 코랄 랩 레이어·공명 배턴·응급 베일
- CH104: 7.1~7.3H → 5.6~5.7H, 인디고 레이어·프리즘 부채·지도 링
- CH105: 7.2~7.4H → 5.7~5.8H, 크롭 볼레로·건틀릿·앵커 케이블

공용 기반을 사용하되 얼굴·헤어·체형·패션·장비, 대표 Idle, 기본 공격, 스킬 3종, 승리 모션,
선택 연출과 VFX에서 개성을 구분한다. 5명 모두 선택·로비·전투에서 정상 동작하고 외형·모션·플레이
방식이 명확히 구분되면 완료한다.

## A6. 환경·몬스터·소품 — Todo

```text
Gray Box 환경
→ 캠프 핵심 시설
→ 버려진 거리
→ 일반 몬스터 3종과 보스 1종
→ 폐쇄된 연구소
→ 추가 몬스터 3종과 보스 1종
→ 환경 폴리시
```

- 스테이지 2개, 일반 몬스터 6종, 보스 2종
- 캠프 시설 4종 이상
- 폐허 모듈, 바리케이드, 고철, 자원·상자 세트
- 배경은 캐릭터보다 낮은 채도·시각 밀도를 유지하고 캠프는 따뜻한 안전 지대로 대비한다.

## A7. UI·VFX·사운드 — Todo

### UI

- 둥근 패널·얇은 외곽선·가벼운 글래스 기반 Design System
- 타이틀·로비·캐릭터 선택·정보·친밀도·대화
- 전투 HUD·스킬 선택·결과·정산·캠프 강화
- 약 7등신 Key Art와 128px 초상화의 얼굴·헤어·대표색 일관성
- Android Landscape Touch·Safe Area 가독성

### 신규 캐릭터 VFX 언어

| 캐릭터 | 색과 형태 방향 |
|---|---|
| CH101 린 | 청록-백색 경로 리본과 짧은 세이버 궤적 |
| CH102 마오 | 보라-레몬 자기장과 구조 프레임 |
| CH103 노조미 | 아쿠아-코랄 공명 파동과 넓은 보호 베일 |
| CH104 시온 | 백색-마젠타 프리즘선과 지도 궤도 |
| CH105 아카리 | 코퍼-황금 앵커 격자와 무거운 충격파 |

작은 화면에서 전투 정보가 읽히고 이펙트만 보아도 캐릭터를 구분할 수 있어야 한다.

## A8. 출시 폴리시 — Todo

- 캐릭터 5명 2D·3D 최종 일관성·리터칭 리뷰
- 애니메이션 타이밍·타격감·물리 본·관통 수정
- LOD·Texture·Material·화면비·성능 검증
- 승인되지 않은 WIP 제거
- AI metadata·라이선스·버전·외부 IP 유사성 검토
- 스토어 스크린샷·트레일러·약 7등신 대표 Key Art

## 승인 규칙

- `WIP`: 제작 중, 게임 기준 사용 금지
- `REVIEW`: 비교·검토 가능, 최종 모델링 기준 사용 금지
- `CONDITIONAL`: 수정 조건이 남은 승인
- `APPROVED`: 사람 검토를 통과한 제작 기준
- `DEFERRED`: 선택 도구 또는 작업의 필요성을 나중에 재평가
- `SUPERSEDED`: 새 방향으로 대체됨
- `REJECTED`: 검토에서 반려되어 제작 기준으로 사용 금지
- `ARCHIVE`: 이력 보관

Gate A(매력·정체성) → Gate B(2D→3D 제작 가능성) → Gate C(Unity 통합) 순서를 건너뛰지 않는다.
