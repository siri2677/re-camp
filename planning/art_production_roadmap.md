# Re:Camp Art Production Roadmap

## 목표

Re:Camp의 아트 목표는 성인 여성 5인의 기획과 비주얼을 함께 확정하고, 공용 기반을 사용해 순차적으로 출시 품질까지 완성하는 것이다.

```text
2D 일반 등신 대표 일러스트
→ 캐릭터별 Approved 제작 시트
→ 3D 5~6등신 스타일라이즈드 Blockout
→ 공용 Rig·Shader·Animator·Prefab
→ 최종 모델·애니메이션
→ Unity 쿼터뷰·성능 검증
```

최종 아트보다 먼저 5명의 전투 역할을 Gray Box로 검증한다. 루나 Character Proof가 품질·비용 기준을 통과하기 전에는 나머지 캐릭터의 최종 3D를 대량 제작하지 않는다. `battle_vertical_slice_concept.png`를 전투 화면의 캐릭터 존재감·카메라·환경·색 대비 기준으로 유지하되 정확한 체형 비율은 최신 Baseline을 따른다.

## 도구 도입 원칙

- 현재 Unity 기능 개발과 초기 아트 방향 검토에는 ComfyUI 또는 ComfyUI MCP가 필요하지 않다.
- 현재 이용 가능한 이미지 생성 도구로 후보를 만들고, 사람 승인과 제작 시트를 기준으로 다음 단계로 이동한다.
- 캐릭터 일관성 대량 생성, 정밀 인페인팅, Seed·LoRA·ControlNet·IP-Adapter 고정 워크플로가 실제 병목이 될 때 ComfyUI 도입을 재평가한다.
- 그때까지 ComfyUI는 `Deferred`이며, 로컬 모델·GPU·설치·MCP 연결은 개발 선행 조건이 아니다.
- `Deferred`는 필요성이 아직 확인되지 않은 선택 작업이고, 기술적으로 진행할 수 없는 `Blocked`와 구분한다.

## A0. 방향 통일 — Review

### 완료

- Art Direction, Character Bible, MCP Guide
- 2D 일반 등신 + 3D 5~6등신 스타일라이즈드 + 툰 셰이딩·쿼터뷰 방향
- 성인 여성 5인·남성향 캐릭터 구성
- AI 생성 메타데이터 양식
- 성인 여성 5인 라인업 `REVIEW v003`

### 이력과 남은 기준

- v001: `Invalid` — 거의 빈 이미지, LFS raw blob
- v002: `Rejected` — 전원 여성 조건 누락, 원본 이미지 미참조
- v003: 원본 전투 콘셉트와 전원 성인 여성 조건으로 교정했으나 기존 4~5등신 비율은 최종 기준이 아니며 Gate A `FAIL` 권고, 상태는 `REVIEW` 유지
- 루나↔코코 의료 모티프, 미유↔이리스 색, 코코↔노아 방패 인상, 5인 얼굴·실루엣 차별화와 5~6등신 비율 수정 필요
- 캐릭터별 WIP의 흑백 실루엣·128px 얼굴·저채도 비교 후 사람 승인 필요

## A1. 반복 가능한 파이프라인 — In Progress

### 완료

- Git LFS 규칙
- `art_source/`와 Unity Art 구조
- 생성 메타데이터 companion 규칙
- WIP / REVIEW / APPROVED 승인 흐름
- 5인 도구 비종속 캐릭터 앵커·회귀 규칙
- 캐릭터·환경·UI/VFX Gate A/B/C 공통 리뷰 체크리스트
- 캐릭터 제작 시트 6-Frame 규격과 Figma import용 SVG v001
- 이미지→Blender→Unity 자산·Export·LOD·Socket·GUID 명명 규격
- 공용·5인 고유 Motion, Animator, Event·장비·Unity Import 규격

### 남은 작업

- Figma 실제 Import·Component Clone·PNG/PDF Export와 사람 사용성 검토
- Blender MCP 소품 Export와 저장 규칙
- FBX → Unity Import·Material·Prefab 테스트
- ComfyUI 고정 워크플로는 `Deferred`

파이프라인은 같은 얼굴·헤어·의상 설정으로 후보를 반복하고, 결과를 제작 시트에 정리하며, Blender 테스트 자산을 Unity Prefab으로 가져올 수 있을 때 완료로 본다.

## A2. 5인 2D 방향 확정 — Todo

디자인 탐색과 비교는 함께 진행하되, 개별 제작 시트는 루나 → 미유 → 코코 → 이리스 → 노아 순으로 완성한다. 후보 제작은 현재 도구로 시작하며 ComfyUI 도입을 기다리지 않는다.

### 캐릭터별 필수 산출물

- 일반 등신 Key Art와 단독 전신 후보
- 정면·측면·후면 Turnaround
- 얼굴 확대와 표정 8종
- 헤어 구조와 의상 분해도
- 무기·장비 상세도
- 컬러·재질 팔레트
- 대표 포즈 3종
- 3D 제작 주의사항

### 완료 기준

- 5명 모두 사람 검토를 통과한 `APPROVED` 제작 시트를 보유한다.
- 시점마다 얼굴·헤어·의상·무기 구조가 일치한다.
- 캐릭터별 색상과 실루엣이 겹치지 않는다.
- 전투 역할과 성격, 성인 여성 캐릭터의 매력이 외형에서 구분된다.

## A3. 루나 Character Proof — Todo

- 일반 등신 Key Art와 Approved 제작 시트
- 에너지 단검·탐지 장치 상세
- Gate A/B Approved 후 5~6등신 스타일라이즈드 Blender Blockout, 기본 목표 약 5.2~5.5등신
- Unity 쿼터뷰에서 얼굴·후드·단검 실루엣 Gate C 검증
- 최종 모델·Texture·Rig·Weight·BlendShape
- Idle·Run·Attack·Dash·Skill·Hit·Victory 애니메이션
- 전용 Toon Material·VFX·사운드·Prefab
- 로비·선택·전투 통합과 타깃 사용자 매력 검증

일러스트와 3D가 같은 캐릭터로 보이고, 관통·변형·성능 문제가 허용 범위이며, 사용자 평가에서 개선점과 긍정 반응을 기록하면 통과한다.

## A4. 공용 3D 기반 — Todo

- Character ID별 Visual Prefab·Portrait·Icon·VFX·Audio를 분리 연결하는 Unity Presentation 정의
- 기능 Root 아래 교체 가능한 `CharacterVisual` Prefab과 장비·VFX 소켓 계약
- 공용 5~6등신 스타일라이즈드 Base Mesh와 Humanoid 호환 Rig
- 얼굴·눈·헤어·의상 Toon Shader와 Material 슬롯 규칙
- 공용 Animator와 Idle·Walk·Run·Hit·Down 애니메이션
- 목표 기기·프레임과 물리 본·Collider·폴리곤·Texture·LOD·VFX 예산
- Unity 캐릭터 Prefab 템플릿

루나에서 검증된 구조로 다른 캐릭터 Blockout을 만들고 공용 이동·피격 애니메이션을 재사용할 수 있어야 한다.

## A5. 나머지 캐릭터 — Todo

루나 기반으로 미유 → 코코 → 이리스 → 노아 순으로 제작한다. 공용 기반을 사용하되 얼굴·헤어·의상·무기, 대표 Idle, 기본 공격, 스킬 3종, 승리 모션, 선택 연출, VFX에서 개성을 구분한다.

5명 모두 선택·로비·전투에서 정상 동작하고 외형·모션·플레이 방식이 명확히 구분되면 완료한다.

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
- 배경은 캐릭터보다 낮은 채도·시각 밀도를 유지하고, 캠프는 따뜻한 안전 지대로 대비한다.

## A7. UI·VFX·사운드 — Todo

### UI

- 둥근 패널·얇은 외곽선·가벼운 글래스 기반 Design System
- 타이틀·로비·캐릭터 선택·정보·친밀도·대화
- 전투 HUD·스킬 선택·결과·정산·캠프 강화
- Android Landscape Touch·Safe Area 가독성을 제품 기준으로 하고 Windows Editor 입력을 개발·QA용으로 유지

### 캐릭터 VFX 언어

| 캐릭터 | 색과 형태 방향 |
|---|---|
| 루나 | 민트·청록 베기와 탐지 링 |
| 미유 | 라일락·네온 블루 드론·홀로그램 |
| 코코 | 코랄·그린 회복·보호막 |
| 이리스 | 퍼플·크림슨 조준·정밀 사격 |
| 노아 | 네이비·앰버 방벽·반격 |

작은 화면에서 전투 정보가 읽히고, 이펙트만 보아도 캐릭터를 구분할 수 있어야 한다.

## A8. 출시 폴리시 — Todo

- 캐릭터 5명 최종 일관성·리터칭 리뷰
- 애니메이션 타이밍·타격감·물리 본·관통 수정
- LOD·Texture·Material·화면비·성능 검증
- 승인되지 않은 WIP 제거
- AI 메타데이터·라이선스·버전 검토
- 스토어 스크린샷·트레일러·대표 Key Art

## 승인 규칙

- `WIP`: 제작 중, 게임 기준 사용 금지
- `REVIEW`: 비교·검토 가능, 최종 모델링 기준 사용 금지
- `APPROVED`: 사람 검토를 통과한 제작 기준
- `DEFERRED`: 선택 도구 또는 작업의 필요성을 나중에 재평가하며 현재 선행 조건이 아님
- `SUPERSEDED`: 새 방향으로 대체됨
- `REJECTED`: 검토에서 반려되어 제작 기준으로 사용 금지
- `ARCHIVE`: 이력 보관

Gate A(매력) → Gate B(제작 가능성) → Gate C(Unity 통합) 순서를 건너뛰지 않는다.
