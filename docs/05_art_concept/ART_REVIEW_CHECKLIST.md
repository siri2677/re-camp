# Re:Camp Art Review Checklist

> Version: 2.0
> 최종 갱신: 2026-07-24

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
Scope: Character 2D / Character 3D / Environment / UI / VFX / Unity Prefab
Current Status: WIP / REVIEW
Anchor Spec Version: 2.0
Character Bible Version: 2.0
Input References:
Tool / Model:
License Evidence:
2D Proportion Target:
3D Proportion Target:
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
| PRE-06 | 원본 전투 앵커, 최신 Character Bible·Anchor Spec, Approved 시트의 우선순위 준수 | 비교 캡처 | |
| PRE-07 | 외부 작품의 얼굴·의상·무기·로고를 직접 복제하지 않음 | 레퍼런스·차이 기록 | |
| PRE-08 | LFS 대상 확장자가 저장소 규칙과 일치 | `git check-attr` 결과 | |

라이선스 검토가 `Pending`이어도 내부 `REVIEW`는 가능하지만 출시 자산 승인과 배포는 불가하다.

## 4. Gate A — 매력·정체성·방향

Gate A는 “무엇을 만들 것인가”를 승인하는 단계다. 2D 후보·Color Key·UI 방향·VFX 언어에
적용하며 모델링이나 Unity Import 완료를 의미하지 않는다.

### 4.1 캐릭터 2D Gate A

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| CHA-A01 | 정확히 성인 여성으로 읽히며 유아형·남성·성별 모호 회귀가 없음 | 전신 정면·3/4 | |
| CHA-A02 | 2D 대표 일러스트가 캐릭터별 약 6.8~7.4등신 범위와 목표값을 충족 | 머리 단위 비율 가이드 | |
| CHA-A03 | 얼굴·체형·의상 패션이 남성향 서브컬처 대표 캐릭터로 충분한 매력을 가짐 | 얼굴 크롭·전신 | |
| CHA-A04 | Character Bible의 한 문장 훅이 이미지 한 장에서 전달됨 | 한 문장 훅 주석 | |
| CHA-A05 | `CHARACTER_ANCHOR_SPEC.md`의 얼굴·헤어·체형·실루엣·장비 앵커와 일치 | 앵커 대조표 | |
| CHA-A06 | 대표 특징 1개와 보조 특징 2개가 즉시 읽힘 | 주석 전신 | |
| CHA-A07 | 패션 요소와 역할 장비가 기능적으로 연결되고 단순 역할 코스튬에 머물지 않음 | 기능 설명 | |
| CHA-A08 | 대표색·보조색·포인트색이 다른 캐릭터와 구분됨 | 팔레트 칩 | |
| CHA-A09 | 대표 장비만으로 전투 역할을 추측할 수 있음 | 장비 포함 실루엣 | |
| CHA-A10 | 장비 제거 흑백 실루엣에서도 헤어·의상·체형으로 5인을 구분할 수 있음 | 동일 크기 흑백 비교 | |
| CHA-A11 | 128px 얼굴 크롭에서 눈매·헤어·성격이 서로 구분됨 | 5인 얼굴 스트립 | |
| CHA-A12 | 저채도·색각 보정 미리보기에서도 역할 구분을 장비·형태가 보완함 | 접근성 비교 | |
| CHA-A13 | 다른 캐릭터의 전용 모티프를 침범하지 않음 | 교차 충돌표 | |
| CHA-A14 | 평상시와 임무 상태의 반전 성격이 중립 포즈·대표 표정에 드러남 | 표정 2~3종 | |
| CHA-A15 | 외부 작품의 고유 얼굴·의상 절개·무기·로고를 직접 복제하지 않음 | 레퍼런스 차이 분석 | |
| CHA-A16 | 약 7등신 2D와 5~6등신 3D가 서로 다른 용도라는 Scope가 명시됨 | Scope Assessment | |

다음은 즉시 `FAIL`이다.

- 성인 여성 5인 방향 위반
- 2D 대표 Key Art가 6.5등신 미만으로 어려 보이거나 얼굴이 지나치게 작아 실사 패션 모델처럼 보임
- 캐릭터의 한 문장 훅과 대표 장비를 설명할 수 없음
- 다섯 명이 동일한 검정 전술복·은발·네온 장식의 팔레트 스왑처럼 보임
- 루나가 일반 은발·보라 총기 요원, 미유가 장총 사용자, 코코가 간호사 코스튬·물리 방패 사용자,
  이리스가 일반 검정 암살자, 노아가 얼굴과 허리선이 사라진 중장갑 남성 탱커처럼 회귀
- 얼굴을 가려 애착·표정 전달이 불가능함
- 외부 IP의 고유 디자인을 추적 가능할 정도로 복제함

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
| UIV-A05 | Android Landscape와 Windows 개발 화면의 글자·버튼·터치 영역 계획이 있음 | 2종 해상도 Mockup | |
| UIV-A06 | 128px 이하 UI 초상화에서 얼굴·헤어·대표색으로 5인을 구분 | 초상화 스트립 | |

## 5. Gate B — 제작 가능성·구조

Gate B는 “일관되게 만들 수 있는가”를 검증한다. Character Turnaround, 장비 구조, 환경 모듈,
UI 컴포넌트와 3D Blockout 직전에 적용한다.

### 5.1 캐릭터·3D Gate B

| ID | 확인 항목 | 필수 증거 | 판정 |
|---|---|---|---|
| CHA-B01 | 약 7등신 정면·측면·후면의 얼굴·헤어·의상 절개가 일치 | Turnaround | |
| CHA-B02 | 장비의 크기·결합·접힘·손잡이·발광부 구조가 정의 | Equipment Sheet | |
| CHA-B03 | `2D to 3D Simplification`에 확대·삭제·결합할 요소가 명시 | 변환표 | |
| CHA-B04 | 캐릭터별 5~6등신 목표값에서 성인 여성 가독성과 공용 Humanoid 관절 확보 | 비율 가이드 | |
| CHA-B05 | 어깨·팔꿈치·손목·골반·무릎의 주요 포즈가 의상과 충돌하지 않음 | 포즈 Blockout | |
| CHA-B06 | 얼굴·눈·헤어·의상·장비 Material 슬롯이 분리 가능 | 재질표 | |
| CHA-B07 | 머리·손·발·대표 무기 강조가 카메라·리그·애니메이션을 막지 않음 | 3D Notes | |
| CHA-B08 | 긴 헤어·코트·케이프·케이블의 물리 본과 관통 위험이 예산화됨 | Physics Note | |
| CHA-B09 | 대표 Idle·Attack·Skill·Victory의 장비 동작과 소켓이 정의 | 모션 썸네일 | |
| CHA-B10 | 폴리곤·Texture·Bone·BlendShape·LOD·Shader 예산을 `CHARACTER_3D_SPEC.md`에서 확인 | 규격 링크 | |

다음은 Gate B `FAIL`이다.

- 2D를 단순 축소해 3D의 얼굴·장비·실루엣이 읽히지 않음
- 3D가 5등신 미만 또는 6등신 초과로 제안됨
- 공용 Humanoid Rig에서 주요 관절이 작동하지 않음
- 긴 헤어·천·장비 구조가 카메라와 캐릭터를 지속적으로 가림
- `CHARACTER_3D_SPEC.md`가 없거나 성능 예산이 미정인 상태에서 최종 모델 승인을 요청함

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
| UNI-C01 | 승인된 Source와 Import 자산의 버전·GUID 대응이 manifest에 존재 | Import 기록 | |
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
| CHA-C03 | 장비 제거 상태에서도 헤어·의상·체형으로 5/5 식별 | 블라인드 캡처 | |
| CHA-C04 | Idle·이동·공격·피격·스킬에서 치명적 관통·변형 없음 | PlayMode 영상/캡처 | |
| CHA-C05 | 장비 소켓·VFX 소켓·Hitbox가 애니메이션과 일치 | Prefab/Probe | |
| CHA-C06 | HUD 이름·초상화·포인트색·능력 상태가 선택 캐릭터와 일치 | UI 캡처 | |
| CHA-C07 | 대표 Battle Scene의 목표 기기 성능 예산을 만족 | Profiler 기록 | |
| CHA-C08 | 기존 Gray Box 기능과 보상·스킬·Scene 흐름 회귀 없음 | 전체 회귀 | |
| CHA-C09 | Character ID가 올바른 Visual Prefab·Portrait·Icon·VFX 세트를 로드 | 자동 참조 검사 | |
| CHA-C10 | 필수 Animation State·Avatar·장비/VFX Socket이 누락·이탈 없이 동작 | 상태 재생 Probe | |
| CHA-C11 | 선택 → Lobby → Battle → Result 왕복에서 Visual·Animator·VFX 참조가 유지 | PlayMode 통합 테스트 | |
| CHA-C12 | Android Landscape 실기기에서 얼굴·대표 장비와 터치 HUD가 서로 가리지 않음 | 실기기 캡처 | |

`CHARACTER_3D_SPEC.md`에 목표 기기·프레임, 폴리곤, Texture, Material 슬롯, Bone,
BlendShape, LOD, Particle, Overdraw 예산이 없으면 `CHA-C07`은 `PASS`로 판정하지 않는다.
기준 카메라와 동일 조명에서 색을 제거한 블라인드 실루엣 검토로 5/5를 구분하지 못하면
`CHA-C02`와 `CHA-C03`도 `PASS`로 판정하지 않는다.

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
