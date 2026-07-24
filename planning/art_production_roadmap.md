# Re:Camp Art Production Roadmap

> 최종 갱신: 2026-07-24
> 상태: Active

## 목표

Re:Camp의 아트 목표는 성인 여성 5인의 캐릭터 훅과 비주얼을 약 7등신 2D 제작 시트에서 먼저
확정하고, 이를 5~6등신 인게임 모델로 번역해 순차적으로 출시 품질까지 완성하는 것이다.

```text
5인 캐릭터 훅·패션·실루엣 재탐색
→ 2D 약 7등신 Approved 제작 시트
→ 캐릭터별 2D→3D 변환표
→ 루나 5~6등신 스타일라이즈드 Character Proof
→ 공용 Rig·Shader·Animator·Prefab
→ 나머지 캐릭터 최종 모델·애니메이션
→ 환경·UI·VFX·사운드
→ Unity 쿼터뷰·Android 성능·출시 검증
```

최종 아트보다 먼저 5명의 전투 역할을 Gray Box로 검증한다. 루나 Character Proof가 품질·비용
기준을 통과하기 전에는 나머지 캐릭터의 최종 3D를 대량 제작하지 않는다.
`battle_vertical_slice_concept.png`는 전투 화면의 캐릭터 존재감·카메라·환경·색 대비 참고이며
개별 캐릭터 외형과 파티 구성은 공식 디자인 기준이 아니다.

## 도구 도입 원칙

- 현재 Unity 기능 개발과 초기 아트 방향 검토에는 ComfyUI 또는 ComfyUI MCP가 필요하지 않다.
- 현재 이용 가능한 이미지 생성 도구로 후보를 만들고, 사람 승인과 제작 시트를 기준으로 다음 단계로 이동한다.
- 캐릭터 일관성 대량 생성, 정밀 인페인팅, Seed·LoRA·ControlNet·IP-Adapter 고정 워크플로가
  실제 병목이 될 때 ComfyUI 도입을 재평가한다.
- 그때까지 ComfyUI는 `Deferred`이며 로컬 모델·GPU·설치·MCP 연결은 개발 선행 조건이 아니다.
- `Deferred`는 필요성이 아직 확인되지 않은 선택 작업이고 기술적으로 진행할 수 없는 `Blocked`와 구분한다.

## A0. 방향 통일 — Review

### 완료

- `CURRENT_PROJECT_BASELINE.md`에 2D 약 7등신·3D 5~6등신 분리 반영
- `ART_DIRECTION.md` v2.0
- `CHARACTER_BIBLE.md` v2.0
- `CHARACTER_ANCHOR_SPEC.md` v2.0
- `ART_REVIEW_CHECKLIST.md` v2.0
- 성인 여성 5인·남성향 캐릭터 구성
- 캐릭터별 한 문장 훅, 2D·3D 목표 비율, 패션·기능·반전 매력 재정의
- AI 생성 메타데이터 양식

### 이력과 남은 기준

- v001 라인업: `Invalid` — 거의 빈 이미지, LFS raw blob
- v002 라인업: `Rejected` — 전원 여성 조건 누락, 원본 이미지 미참조
- v003 라인업: `Review / Gate A FAIL` — 과거 4~5등신·역할 혼동·얼굴·실루엣 문제
- v003은 새 디자인의 기반 이미지가 아니라 실패 원인과 비교 이력으로만 사용
- 새 후보는 각 캐릭터의 한 문장 훅과 약 7등신 2D 기준으로 처음부터 재탐색
- 흑백 실루엣·128px 얼굴·저채도·외부 IP 유사성 비교 후 사람 승인 필요

## A1. 반복 가능한 파이프라인 — In Progress

### 완료

- Git LFS 규칙
- `art_source/`와 Unity Art 구조
- 생성 메타데이터 companion 규칙
- WIP / REVIEW / APPROVED 승인 흐름
- 5인 도구 비종속 캐릭터 앵커·회귀 규칙 v2.0
- 캐릭터·환경·UI/VFX Gate A/B/C 공통 리뷰 체크리스트 v2.0
- 캐릭터 제작 시트 6-Frame 규격 v002
- Figma import용 `ReCamp_CharacterSheet_Template_REVIEW_v002.svg`
- 이미지→Blender→Unity 자산·Export·LOD·Socket·GUID 명명 규격
- 공용·5인 고유 Motion, Animator, Event·장비·Unity Import 규격

### 남은 작업

- v002 SVG의 실제 Figma Import·Component Clone·PNG/PDF Export와 사람 사용성 검토
- 샘플 루나 Frame에서 약 7등신 가이드와 2D→3D 변환표 검증
- Blender MCP 소품 Export와 저장 규칙
- FBX → Unity Import·Material·Prefab 테스트
- ComfyUI 고정 워크플로는 `Deferred`

파이프라인은 같은 얼굴·헤어·의상 앵커로 후보를 반복하고, 결과를 제작 시트에 정리하며,
Blender 테스트 자산을 Unity Prefab으로 가져올 수 있을 때 완료로 본다.

## A2. 5인 2D 디자인 재탐색·방향 확정 — Todo

후보 비교는 5명을 함께 진행하되 개별 제작 시트는 루나 → 미유 → 코코 → 이리스 → 노아 순으로 완성한다.
후보 제작은 현재 도구로 시작하며 ComfyUI 도입을 기다리지 않는다.

### 캐릭터별 필수 산출물

- 약 7등신 단독 전신 WIP 후보 3안 이상
- 한 문장 훅과 대표 특징 1개·보조 특징 2개 주석
- 얼굴 정면·3/4과 평상시↔임무 상태 표정
- 약 7등신 정면·측면·후면 Turnaround
- 표정 8종과 128px 얼굴 비교
- 헤어 구조와 패션 Layer·기능 분해도
- 무기·장비 상세도와 접힘·발광·Socket 구조
- 컬러·재질 팔레트
- 대표 포즈 3종
- 외부 IP 유사성 검토
- 캐릭터별 2D→3D 확대·삭제·결합 변환표

### 완료 기준

- 5명 모두 사람 검토를 통과한 `APPROVED` 약 7등신 2D 제작 시트를 보유한다.
- 시점마다 얼굴·헤어·의상·무기 구조가 일치한다.
- 한 문장 훅이 이미지 한 장에서 전달된다.
- 캐릭터별 얼굴·체형·키·패션·색상·실루엣이 겹치지 않는다.
- 전투 역할과 성격의 반전 매력이 외형과 표정에서 구분된다.
- 외부 작품의 고유 디자인을 직접 복제하지 않는다.

## A3. 루나 Character Proof — Todo

- 약 7등신 Key Art와 Approved 제작 시트
- 센서 고양이 후드·쌍 에너지 단검·손목 스캐너 상세
- 루나 2D 6.9~7.1등신 → 3D 5.3~5.4등신 변환표
- `CHARACTER_3D_SPEC.md`와 Unity Presentation 계약
- Gate A/B Approved 후 Blender Blockout
- Unity 쿼터뷰에서 얼굴·센서 귀·쌍단검 실루엣 Gate C 검증
- 최종 모델·Texture·Rig·Weight·BlendShape
- Idle·Run·Attack·Dash·Skill·Hit·Victory 애니메이션
- 전용 Toon Material·VFX·사운드·Prefab
- Android Landscape 로비·선택·전투 통합과 타깃 사용자 매력 검증

2D와 3D가 같은 루나로 보이고 관통·변형·성능 문제가 허용 범위이며, 사용자 평가에서 한 문장 훅과
캐릭터 매력이 전달되면 통과한다.

## A4. 공용 3D 기반 — Todo

- Character ID별 Visual Prefab·Portrait·Icon·VFX·Audio를 분리 연결하는 Unity Presentation 정의
- 기능 Root 아래 교체 가능한 `CharacterVisual` Prefab과 장비·VFX 소켓 계약
- 캐릭터별 약 5.2~5.8등신을 수용하는 공용 스타일라이즈드 Base Mesh
- 공용 Humanoid 호환 Rig
- 얼굴·눈·헤어·의상 Toon Shader와 Material 슬롯 규칙
- 공용 Animator와 Idle·Walk·Run·Hit·Down 애니메이션
- 목표 Android 기기·프레임과 물리 본·Collider·폴리곤·Texture·LOD·VFX 예산
- Unity 캐릭터 Prefab 템플릿

루나에서 검증된 구조로 다른 캐릭터 Blockout을 만들고 공용 이동·피격 애니메이션을 재사용할 수 있어야 한다.

## A5. 나머지 캐릭터 — Todo

루나 기반으로 미유 → 코코 → 이리스 → 노아 순으로 제작한다.

- 미유: 2D 6.8~7.0 → 3D 5.2~5.3, 비대칭 헤어·큰 소매·드론 2기
- 코코: 2D 7.0~7.2 → 3D 5.5~5.6, 구조대 하프 케이프·인젝터·투명 보호막
- 이리스: 2D 7.2~7.4 → 3D 5.7~5.8, 화이트 롱 코트·장거리 라이플·바이저
- 노아: 2D 7.2~7.4 → 3D 5.7~5.8, 짧은 보브·테일러드 방호복·전개 방패

공용 기반을 사용하되 얼굴·헤어·체형·패션·무기, 대표 Idle, 기본 공격, 스킬 3종, 승리 모션,
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
- Android Landscape Touch·Safe Area 가독성을 제품 기준으로 유지

### 캐릭터 VFX 언어

| 캐릭터 | 색과 형태 방향 |
|---|---|
| 루나 | 청록 쌍단검 궤적과 센서 링 |
| 미유 | 라일락·시안 홀로그램과 서로 다른 드론 탄도 |
| 코코 | 코랄·제이드 회복 파동과 투명 곡면 보호막 |
| 이리스 | 크림슨 조준선과 압축 직선 타격광 |
| 노아 | 앰버 격자 방벽과 무거운 반격 충격파 |

작은 화면에서 전투 정보가 읽히고 이펙트만 보아도 캐릭터를 구분할 수 있어야 한다.

## A8. 출시 폴리시 — Todo

- 캐릭터 5명 2D·3D 최종 일관성·리터칭 리뷰
- 애니메이션 타이밍·타격감·물리 본·관통 수정
- LOD·Texture·Material·화면비·성능 검증
- 승인되지 않은 WIP 제거
- AI 메타데이터·라이선스·버전·외부 IP 유사성 검토
- 스토어 스크린샷·트레일러·약 7등신 대표 Key Art

## 승인 규칙

- `WIP`: 제작 중, 게임 기준 사용 금지
- `REVIEW`: 비교·검토 가능, 최종 모델링 기준 사용 금지
- `APPROVED`: 사람 검토를 통과한 제작 기준
- `DEFERRED`: 선택 도구 또는 작업의 필요성을 나중에 재평가하며 현재 선행 조건이 아님
- `SUPERSEDED`: 새 방향으로 대체됨
- `REJECTED`: 검토에서 반려되어 제작 기준으로 사용 금지
- `ARCHIVE`: 이력 보관

Gate A(매력·정체성) → Gate B(2D→3D 제작 가능성) → Gate C(Unity 통합) 순서를 건너뛰지 않는다.
