# Re:Camp Art Review Checklist

이 문서는 `ART-0107`의 공통 Gate A/B/C 판정표다. 캐릭터, 환경, UI, VFX를 게임에 적용하기
전에 같은 증거와 용어로 검토하기 위해 사용한다. 체크리스트 통과 권고와 자산의 인간
`APPROVED` 승인은 별개다.

## 1. 판정값

| 판정 | 의미 |
|---|---|
| `PASS` | 현재 Gate의 요구와 증거를 모두 충족 |
| `CONDITIONAL` | 방향은 유효하지만 명시된 수정·증거가 남음 |
| `FAIL` | 상위 방향 또는 필수 조건과 충돌해 다음 Gate로 진행 불가 |
| `N/A` | 해당 자산에 적용되지 않음. 이유 필수 |
| `NOT TESTED` | 검증하지 않음. `PASS`로 계산하지 않음 |

한 항목이라도 `FAIL`이면 Gate 전체는 `FAIL`이다. `CONDITIONAL` 또는 `NOT TESTED`가 있으면
Gate 전체는 최대 `CONDITIONAL`이다. 인간 리뷰어의 이름·날짜·결정이 없으면 자산 상태를
`APPROVED`로 변경하지 않는다.

## 2. 리뷰 헤더

```yaml
Review ID:
Backlog ID:
Asset:
Asset Version:
Scope: Character / Environment / UI / VFX / 3D / Unity Prefab
Current Status: WIP / REVIEW
Anchor Spec Version:
Input References:
Tool / Model:
License Evidence:
Reviewer: Pending
Review Date:
Gate: A / B / C
Decision: NOT TESTED
Next Owner:
```

## 3. 공통 사전 검사

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| PRE-01 | 경로·상태는 `ART_ASSET_STRUCTURE.md`, 파일명·버전은 `ASSET_NAMING_GUIDE.md`와 일치 | 파일 경로 | |
| PRE-02 | AI/외부 도구 사용 시 companion metadata 존재 | `.metadata.md` | |
| PRE-03 | 도구·모델·입력 레퍼런스·수정 내역이 추정 없이 기록 | metadata 필드 | |
| PRE-04 | 상업 이용·입력 권리·출시 사용 여부가 구분됨 | 라이선스 근거 | |
| PRE-05 | `REJECTED`·`SUPERSEDED` 자산을 제작 앵커로 사용하지 않음 | 입력 목록 | |
| PRE-06 | 원본 전투 앵커와 최신 Approved 시트의 우선순위 준수 | 비교 캡처 | |
| PRE-07 | LFS 대상 확장자가 저장소 규칙과 일치 | `git check-attr` 결과 | |

라이선스 검토가 `Pending`이어도 내부 `REVIEW`는 가능하지만 출시 자산 승인과 배포는 불가하다.

## 4. Gate A — 매력·정체성·방향

Gate A는 “무엇을 만들 것인가”를 승인하는 단계다. 2D 후보·Color Key·UI 방향·VFX 언어에
적용하며 모델링이나 Unity Import 완료를 의미하지 않는다.

### 4.1 캐릭터 Gate A

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| CHA-A01 | 정확히 성인 여성으로 읽히며 유아형·남성·성별 모호 회귀가 없음 | 전신 정면·3/4 | |
| CHA-A02 | 남성향 서브컬쳐 캐릭터로 얼굴·체형·의상 매력이 충분함 | 얼굴 크롭·전신 | |
| CHA-A03 | `CHARACTER_ANCHOR_SPEC.md`의 역할·얼굴·헤어·실루엣 앵커와 일치 | 앵커 대조표 | |
| CHA-A04 | 대표 특징 1개와 보조 특징 2개가 즉시 읽힘 | 주석 전신 | |
| CHA-A05 | 대표색·보조색·포인트색이 다른 캐릭터와 구분됨 | 팔레트 칩 | |
| CHA-A06 | 대표 장비만으로 전투 역할을 추측할 수 있음 | 장비 포함 실루엣 | |
| CHA-A07 | 장비 제거 흑백 실루엣에서도 5인을 구분할 수 있음 | 동일 크기 흑백 비교 | |
| CHA-A08 | 128px 얼굴 크롭에서 눈매·헤어·성격이 서로 구분됨 | 5인 얼굴 스트립 | |
| CHA-A09 | 저채도·색각 보정 미리보기에서도 역할 구분을 장비·형태가 보완함 | 접근성 비교 | |
| CHA-A10 | 다른 캐릭터의 전용 모티프를 침범하지 않음 | 교차 충돌표 | |
| CHA-A11 | 일반 등신 2D와 4~5등신 SD-lite 3D의 용도가 혼동되지 않음 | Scope Assessment | |
| CHA-A12 | Character Bible의 성격이 중립 포즈와 대표 표정에 드러남 | 표정 2종 | |

다음은 즉시 `FAIL`이다.

- 성인 여성 5인 방향 위반
- 루나↔코코 의료 모티프, 미유↔이리스 장비·색, 코코↔노아 방패 역할의 치명적 혼동
- 대표 무기·장비가 다른 캐릭터로 교체됨
- 최종 인게임 3D를 4~5등신 범위 밖으로 제안함. 2~3등신 유아형과 5등신 초과 모델을 포함
- 얼굴을 가려 애착·표정 전달이 불가능함

### 4.2 환경 Gate A

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| ENV-A01 | 자연에 잠식된 부드러운 포스트 아포칼립스 톤 | Color Key | |
| ENV-A02 | 캐릭터보다 채도·명암·디테일 우선도가 낮음 | 캐릭터 합성 | |
| ENV-A03 | 이동·위험·자원·상호작용 영역이 색과 형태로 구분됨 | 오버레이 | |
| ENV-A04 | 전투 지역과 따뜻한 캠프의 온도·조명 대비가 명확 | 나란한 Color Key | |
| ENV-A05 | 원본 전투 앵커의 쿼터뷰 구성·랜드마크·가독성을 계승 | 앵커 비교 | |

### 4.3 UI·VFX Gate A

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| UIV-A01 | 둥근 패널·얇은 외곽선·가벼운 글래스 방향 일치 | Design System 시트 | |
| UIV-A02 | 전투 중 필요한 정보만 우선하고 캐릭터·전장을 가리지 않음 | HUD Mockup | |
| UIV-A03 | 캐릭터별 색상과 형태 언어가 `ART_DIRECTION.md`와 일치 | 5인 VFX 스트립 | |
| UIV-A04 | 공격·회복·보호막·위험 피드백을 정지 화면에서도 구분 | 기능 비교 | |
| UIV-A05 | PC와 모바일에서 글자·버튼·터치 영역 확장 계획이 있음 | 2종 해상도 Mockup | |

## 5. Gate B — 제작 가능성·구조

Gate B는 “일관되게 만들 수 있는가”를 검증한다. Character Turnaround, 장비 구조, 환경 모듈,
UI 컴포넌트와 3D Blockout 직전에 적용한다.

### 5.1 캐릭터·3D Gate B

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| CHA-B01 | 정면·측면·후면의 얼굴·헤어·의상 절개가 일치 | Turnaround | |
| CHA-B02 | 장비의 크기·결합·접힘·손잡이·발광부 구조가 정의 | Equipment Sheet | |
| CHA-B03 | 4~5등신 SD-lite에서 성인 여성 가독성과 공용 Humanoid 관절 확보 | 비율 가이드 | |
| CHA-B04 | 어깨·팔꿈치·손목·골반·무릎의 주요 포즈가 의상과 충돌하지 않음 | 포즈 Blockout | |
| CHA-B05 | 얼굴·눈·헤어·의상·장비 Material 슬롯이 분리 가능 | 재질표 | |
| CHA-B06 | 머리·손·무기 과장이 카메라·리그·애니메이션을 막지 않음 | 3DNotes | |
| CHA-B07 | 대표 Idle·Attack·Skill·Victory의 장비 동작과 소켓이 정의 | 모션 썸네일 | |
| CHA-B08 | 폴리곤·Texture·LOD·Shader 예산을 `CHARACTER_3D_SPEC.md`에서 확인 | 규격 링크 | |

`CHARACTER_3D_SPEC.md`가 없거나 예산이 미정이면 최종 모델 Gate B는 `PASS`가 될 수 없다.

### 5.2 환경 Gate B

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| ENV-B01 | 쿼터뷰에 맞는 Modular 단위·Pivot·Grid 규칙 | 모듈 시트 | |
| ENV-B02 | 이동 충돌과 시각 Mesh를 분리할 수 있음 | Blockout | |
| ENV-B03 | 카메라를 가리는 전경 오브젝트의 처리 규칙 | Occlusion 시트 | |
| ENV-B04 | 식생·파편·발광 소품의 밀도 단계가 정의 | 밀도 비교 | |
| ENV-B05 | 재사용 모듈과 고유 랜드마크가 구분됨 | Kit 목록 | |

### 5.3 UI·VFX Gate B

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| UIV-B01 | 컬러·폰트·간격·라운드·Outline 토큰 정의 | Token 표 | |
| UIV-B02 | 버튼·패널·게이지의 Normal/Hover/Pressed/Disabled 상태 | 컴포넌트 시트 | |
| UIV-B03 | `ASSET_NAMING_GUIDE.md`에 맞는 9-slice·Vector·Raster Export 규칙과 파일명이 정의 | Export 표 | |
| UIV-B04 | VFX 수명·크기·레이어·블렌딩·색상 변형 규칙 | VFX 사양 | |
| UIV-B05 | Safe Area와 16:9 외 종횡비 대응 규칙 | 레이아웃 시트 | |

## 6. Gate C — Unity 통합·가독성·성능

Gate C는 “실제 게임에서 사용할 수 있는가”를 검증한다. Unity Scene과 Prefab 증거 없이
`PASS`할 수 없다.

### 6.1 공통 Unity 사전 조건

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| UNI-C01 | 승인된 Source와 Import 자산의 버전·GUID 대응이 `ASSET_NAMING_GUIDE.md` manifest에 존재 | Import 기록 | |
| UNI-C02 | Scale·축·Pivot·단위가 `ASSET_NAMING_GUIDE.md`의 결과 계약과 일치 | Inspector 캡처 | |
| UNI-C03 | Texture·Material·Shader 참조 누락과 분홍 Material이 없음 | Console·Prefab | |
| UNI-C04 | Prefab Override와 Scene 직접 참조가 의도대로 관리됨 | Prefab 검사 | |
| UNI-C05 | `_ReCamp` Console 오류 0 | 오류 필터 결과 | |
| UNI-C06 | 관련 EditMode·PlayMode 테스트 또는 직접 Probe 통과 | 검증 기록 | |

### 6.2 캐릭터 Gate C

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| CHA-C01 | 기준 Orthographic 쿼터뷰에서 얼굴·헤어·대표 장비 식별 | 100%·50% 캡처 | |
| CHA-C02 | 5인 동일 조명·거리 비교에서 실루엣과 팔레트 구분 | 라인업 캡처 | |
| CHA-C03 | Idle·이동·공격·피격·스킬에서 치명적 관통·변형 없음 | PlayMode 영상/캡처 | |
| CHA-C04 | 장비 소켓·VFX 소켓·Hitbox가 애니메이션과 일치 | Prefab/Probe | |
| CHA-C05 | HUD 이름·초상화·포인트색·능력 상태가 선택 캐릭터와 일치 | UI 캡처 | |
| CHA-C06 | 대표 Battle Scene의 성능 예산을 만족 | Profiler 기록 | |
| CHA-C07 | 기존 Gray Box 기능과 보상·스킬·Scene 흐름 회귀 없음 | 전체 회귀 | |
| CHA-C08 | 각 Character ID가 올바른 Visual Prefab·Portrait·Icon·VFX 세트를 로드하고 참조 누락이 없음 | 자동 참조 검사 | |
| CHA-C09 | 필수 Animation State·Avatar·장비/VFX Socket이 누락·이탈 없이 동작 | 상태 재생 Probe | |
| CHA-C10 | 선택 → Lobby → Battle → Result 왕복에서 Visual·Animator·VFX 참조가 유지 | PlayMode 통합 테스트 | |

`CHARACTER_3D_SPEC.md`에 목표 기기·프레임, 폴리곤, Texture, Material 슬롯, Bone,
BlendShape, LOD, Particle, Overdraw 예산이 없으면 `CHA-C06`은 `PASS`로 판정하지 않는다.
기준 카메라와 동일 조명에서 5인 캡처를 남기고, 색을 제거한 블라인드 실루엣 검토에서
5/5를 구분하지 못하면 `CHA-C02`도 `PASS`로 판정하지 않는다.

### 6.3 환경 Gate C

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| ENV-C01 | 이동 경계·충돌·카메라 Clamp와 시각 환경이 일치 | Scene Probe | |
| ENV-C02 | 캐릭터·적·자원·위험 VFX가 환경에서 묻히지 않음 | 전투 캡처 | |
| ENV-C03 | Occlusion 때문에 캐릭터가 장시간 가려지지 않음 | 경로 Probe | |
| ENV-C04 | 모듈 반복이 눈에 띄지 않고 랜드마크가 탐색을 보조 | Scene 캡처 | |
| ENV-C05 | 대표 Battle Scene의 Draw Call·Triangle·Memory 예산 충족 | Profiler 기록 | |

### 6.4 UI·VFX Gate C

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| UIV-C01 | 지정 해상도와 Safe Area에서 잘림·겹침 없음 | 다중 해상도 캡처 | |
| UIV-C02 | 버튼·키보드·게임패드 포커스와 상태 피드백 동작 | 입력 Probe | |
| UIV-C03 | VFX가 캐릭터·적·자원·HUD 정보를 가리지 않음 | 전투 캡처 | |
| UIV-C04 | 공격·회복·보호막·위험 피드백이 실제 움직임에서도 구분 | PlayMode Probe | |
| UIV-C05 | 과도한 Overdraw·Particle·Canvas Rebuild가 없음 | Profiler 기록 | |

## 7. Gate별 허용 범위

| 자산 상태·Gate | 허용 사용 | 금지 사용 |
|---|---|---|
| `WIP` | 내부 탐색·비교 | 모델링 기준, Unity 최종 자산 |
| `REVIEW` + Gate A 후보 | 비교, 방향 검토, 임시 Blockout 참고 | 최종 Turnaround·출시 자산 |
| Gate A 인간 승인 | 제작 시트·Turnaround 진행 | Gate B 없는 최종 모델링 |
| Gate B 인간 승인 | 3D Blockout·Unity Import 테스트 | Gate C 없는 최종 게임 사용 |
| Gate C 인간 승인 | 지정 범위의 게임 제작·출시 후보 | 다른 범위까지 자동 승인 |

캐릭터 디자인, 환경 구성, UI/VFX처럼 범위가 다르면 metadata의 `Scope Assessment`에 각각
별도 판정을 기록한다.

## 8. 리뷰 결과 기록 양식

```markdown
## Summary

- Gate:
- Decision: PASS / CONDITIONAL / FAIL / NOT TESTED
- Status remains: REVIEW
- Human approval: Pending

## Evidence

| Check ID | Result | Evidence | Required Change | Owner |
|---|---|---|---|---|

## Blocking Changes

1.

## Recommended Changes

1.

## Retest Scope

-

## Human Decision

- Reviewer: Pending
- Date: Pending
- Decision: Pending
```

리뷰 기록은 원본 이미지를 덮어쓰지 않는다. 수정본은 새 버전으로 저장하고 이전 판정과 변경
이력을 companion metadata에 남긴다.
