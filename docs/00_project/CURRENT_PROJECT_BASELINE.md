# Re:Camp Current Generation Baseline

> 최종 갱신: 2026-08-10
> 상태: Active / Canonical
> 기준 브랜치: `current/recamp-unified`
> Legacy: `legacy/recamp-pre-generation`
> 목적: Current Generation의 제품·디자인·플랫폼·제작 제약·현재 Gate를 한 곳에서만 결정한다.

## 1. 세대 구분

Re:Camp 저장소는 이제 두 기준으로 분리한다.

| 구분 | 브랜치 | 의미 |
|---|---|---|
| Legacy | `legacy/recamp-pre-generation` | 2026-07-27 이전 통합 상태. 과거 구현·캐릭터·아트·문서 비교용 |
| Current Generation | `current/recamp-unified` | 2026-08-09 이후 신규 디자인과 최신 Unity 구현을 일치시키는 유일한 활성 기준 |

규칙:

1. 신규 디자인·기획·개발·테스트는 Current Generation에서만 진행한다.
2. Legacy 내용은 회귀·마이그레이션·비교 근거로만 읽는다.
3. Legacy의 캐릭터 이름·외형·장비·아트 방향을 Current 후보의 제작 앵커로 사용하지 않는다.
4. 현재 작업에서 `codex/recamp-unity-mvp`는 출발 이력일 뿐 Canonical branch가 아니다.
5. Current Generation이 안정화되기 전까지 `main`을 신규 디자인 기준으로 해석하지 않는다.

## 2. LLM과 사람의 판단 순서

모든 Current Generation 작업은 이 문서를 가장 먼저 읽는다.

```text
사용자의 최신 명시적 지시
→ CURRENT_PROJECT_BASELINE.md
→ planning/sprint_backlog.md의 대상 작업
→ 작업 분야의 직접 소유 문서
→ tables/ 또는 실제 코드·Scene·ProjectSettings
→ APPROVED 자산과 review
→ REVIEW·WIP 자산
→ Legacy 자료는 필요한 경우에만 비교
```

제품·플랫폼·전역 비주얼·Current 로스터·세대 구분·1인 제작 제약·현재 Gate는 다른 문서에서 다시 정의하지 않는다.

## 3. 제품 정의

Re:Camp는 자연에 잠식된 포스트 아포칼립스 위험 구역을 **3~5분** 동안 탐험하고 자원을 회수해 따뜻한 생존자 캠프를 성장시키는 Android-first 가로형 싱글플레이 3D 고정 쿼터뷰 로그라이트 RPG다.

```text
짧은 탐험의 긴장감
+ 더 진행할지 귀환할지의 위험/보상 판단
+ 무사 귀환과 자원 정산의 성취감
+ 캠프의 누적 성장
+ 성인 여성 5인의 얼굴·패션·역할·관계에 대한 애착
```

핵심 플레이 흐름:

```text
탐험 준비
→ 위험 구역 탐색·전투
→ 자원 회수
→ 계속 탐험 또는 귀환 판단
→ 귀환·사망·시간 만료
→ 결과 정산
→ 캠프 강화
→ 다음 탐험
```

## 4. 고정 제품 결정

| 항목 | Current Generation 기준 |
|---|---|
| 1차 제품 목표 | Google Play Android 정식 배포 가능한 Landscape 모바일 게임 |
| 개발·자동 테스트 | Windows Unity Editor |
| 후속 플랫폼 | Android 안정화 후 Windows 공개 빌드·Steam·iOS 별도 판단 |
| 플레이 | 싱글플레이 |
| 저장 | 로컬 저장 |
| 입력 | Landscape 양손 Touch UI + 조준 보조. PC 입력은 개발·QA용 |
| 캐릭터 | 신규 CH101~CH105 성인 여성 5인 |
| 해금 | 가챠가 아니라 탐험·구조·캠프 스토리 진행 |
| 카메라 | 고정 Orthographic 쿼터뷰 |
| Unity | `6000.5.3f1`, URP |
| 초기 Character Proof | CH101 아마사와 린 1명을 먼저 검증한 뒤 공용 구조를 나머지 4명에 확장 |

초기 출시 범위에서 제외:

```text
멀티플레이·PvP·길드·실시간 계정 서버
가챠·강제 광고·유료 재화 중심 설계
오픈월드·대규모 시네마틱·풀 보이스
캐릭터별 완전 고유 골격
복잡한 의상 교체 시스템
Android와 PC·iOS 동시 정식 출시
```

## 5. Current Generation 로스터

| ID | 이름 | 한 문장 훅 | 전투 역할 | 탐험·캠프 연결 | 2D 목표 | 3D 목표 |
|---|---|---|---|---|---:|---:|
| CH101 | 아마사와 린 | 폐허의 길을 빛나는 신호 리본으로 그리는 신호 주자 | 기동 근접·정찰 | 경로 개척·자원 탐지 | 6.9~7.1H | 5.3~5.4H |
| CH102 | 키사라기 마오 | 버려진 재료로 접히는 활을 만드는 폐허 설계자 | 지속 원거리·수집 제어 | 작업대·부품 재생 | 6.8~7.0H | 5.2~5.3H |
| CH103 | 카나데 노조미 | 죽어가는 신호를 공명으로 붙잡는 현장 의무관 | 회복·정화·보호 | 생존자 치료·신호 안정화 | 7.0~7.2H | 5.5~5.6H |
| CH104 | 시온 타테가미 | 빛의 지도를 접어 폐허의 약점을 읽는 궤도 측량사 | 약점 표식·정밀 폭발 | 지도 제작·위험 예측 | 7.1~7.3H | 5.6~5.7H |
| CH105 | 쿠로가네 아카리 | 무너지는 길에 닻을 박아 숨 쉴 공간을 만드는 전위 수호자 | 가드·밀치기·반격 | 캠프 방어·시설 보강 | 7.2~7.4H | 5.7~5.8H |

이 표가 Current Generation의 로스터·전역 비율·한 문장 훅 요약의 유일한 기준이다. 캐릭터별 성격·스킬·외형 세부사항은 `CHARACTER_BIBLE.md`, 제작 중 고정/가변/금지 항목은 `CHARACTER_ANCHOR_SPEC.md`가 소유한다.

## 6. 고정 비주얼 방향

```text
2D 약 7등신 성인 일본 모바일 서브컬처 Key Art
+ 3D 5~6등신 스타일라이즈드 인게임 캐릭터
+ 스타일라이즈드 자연 침식 폐허
+ 따뜻한 생존자 캠프
+ 툰 셰이딩
+ 캐릭터보다 낮은 채도·밀도의 환경
+ Android Landscape 쿼터뷰 가독성
```

전역 규칙:

- 2D 대표 일러스트는 약 6.8~7.4H 범위이며 6.5H 미만의 유아형 Key Art는 사용하지 않는다.
- 3D는 약 5.2~5.8H의 5~6등신 스타일라이즈드 체형이며 2~3등신 치비 또는 6H를 크게 넘는 길고 가는 체형을 사용하지 않는다.
- 2D와 3D는 같은 캐릭터로 읽혀야 하지만 동일 비율과 장식 수를 복사하지 않는다.
- 2D는 얼굴·패션·표정·재질, 3D는 얼굴·헤어·대표 장비·쿼터뷰 실루엣을 우선한다.
- 일본 모바일 서브컬처 계열의 큰 보석형 눈, 짧은 중안부, 작은 코·입, 깨끗한 셀 색면을 사용한다.
- 자연에 잠식된 폐허는 위협적이되 잔혹·고어 중심으로 만들지 않고, 캠프는 따뜻한 안전 공간으로 대비한다.
- `battle_vertical_slice_concept.png`는 카메라·환경·색 대비·캐릭터 존재감 참고다. 이미지의 개별 캐릭터 외형·무기·파티 구성은 공식 디자인이 아니다.
- 외부 작품은 마감·감정·패션 밀도·실루엣·광원 같은 품질 축만 참고하고 고유 얼굴·의상·무기·포즈·로고·UI를 복제하지 않는다.

## 7. 1인 개발 Production Budget

Current Generation의 디자인은 다음 제작 예산을 넘지 않는 범위에서 구현한다. 그림에 보이는 모든 장치를 실제 물리·독립 시스템으로 구현하지 않는다.

### 공용 제작 기반

- 공용 Humanoid 호환 Skeleton/Rig 1세트를 기본으로 사용한다.
- 캐릭터별 5.2~5.8H 차이는 가능한 범위에서 Mesh·Head/Body proportion·의상 실루엣으로 표현하고 캐릭터마다 완전 고유 Skeleton을 만들지 않는다.
- 공용 이동·피격·Down Animation을 재사용한다.
- 캐릭터별 고유 Animation은 Signature Idle, 기본 공격, 대표 스킬, Utility, Victory처럼 식별에 필요한 것부터 제한적으로 제작한다.
- 공용 Toon Shader와 공용 VFX Shader/Material 구조를 우선한다.

### 동적 장비 제한

캐릭터당 실제로 복잡하게 움직이는 대표 장비는 **최대 1개**를 기본 예산으로 한다.

- 린 신호 리본: Cloth 대신 Trail/Ribbon Mesh/Shader 우선.
- 마오 구조 링: 독립적으로 움직이는 다수 장치 대신 대표 프레임 1~3개의 단순 Transform/VFX.
- 노조미 응급 베일: Cloth Simulation 대신 2~4개의 큰 Mesh와 Shader Animation.
- 시온 지도 링: 단순 궤도 Mesh/VFX. 방향별 복잡한 공간 시뮬레이션은 후순위.
- 아카리 앵커 케이블: Cable Physics 대신 LineRenderer/VFX/Decal 우선.

MVP에서는 Cloth Physics, Cable Physics, 복잡한 기계식 다단 전개, 캐릭터마다 별도 물리 시스템을 필수로 만들지 않는다.

### Gameplay 재사용 원칙

신규 디자인 때문에 기존에 검증한 시스템을 불필요하게 폐기하지 않는다.

```text
Legacy Gray Box 역할        Current Generation 표현
Luna Dash / Scan       →    Rin 이동·경로·탐지
Miyu Range / Pickup    →    Mao 원거리·자원 제어
Coco Heal / Shield     →    Nozomi 회복·보호
Iris Charge / Mark     →    Shion 정밀·약점 표식
Noah Guard / Barrier   →    Akari 가드·공간 고정
```

- 위 매핑은 코드 재사용을 위한 Migration 방향이며 Legacy 캐릭터 디자인을 재사용한다는 의미가 아니다.
- 새 게임 시스템은 캐릭터 훅 전달에 꼭 필요한 경우에만 추가한다.
- 캠프 역할은 초기에는 별도 미니게임보다 기존 자원·시설 시스템에 연결되는 Passive/Modifier로 구현한다.
- 파티 시스템이 없는 현재 범위에서 노조미의 지원 기능은 자기 생존·구조 NPC·영역 효과 중심으로 해석한다.
- 시온의 방향성 약점 판정처럼 추가 시스템 비용이 큰 기능은 기존 Mark 기반으로 먼저 Proof하고 필요할 때 확장한다.

## 8. 현재 Unity 구현 기준선

2026-08-09 최신 Current Generation 출발점에서 확인된 기준:

- Bootstrap·Title·Lobby·Battle·Result Scene 5개.
- `Lobby → Battle → Result → Lobby` 흐름.
- XZ 이동, 자동 공격, 적 Wave·Boss, 승리·패배, 5분 탐험, 조기 귀환.
- 자원 3종, 결과 정산, 캠프 시설, 로컬 저장과 v1→v2 migration.
- `ReCamp.Domain → ReCamp.UnityAdapter → ReCamp.Runtime` 경계.
- 기존 Gray Box 5인의 전투 역할과 능력은 기능 회귀용으로 유지.
- Android Touch 입력 계층과 HUD 구현은 Review 상태이며 실기기 확인이 남음.
- 최근 기록 기준 EditMode `35/35`, PlayMode `21/21`, `_ReCamp` 오류 0.

위 수치는 `planning/IMPLEMENTATION_STATUS.md`가 실제 실행 증거를 소유한다. 테스트를 다시 실행하지 않은 문서 작업으로 수치를 임의 갱신하지 않는다.

## 9. 현재 디자인 상태

- Current Generation 역할·성격·한 문장 훅: 문서화 완료.
- Character Bible·Anchor·Art Direction v3.2: REVIEW 기준선.
- 공통 5인 라인업 WIP: `1/1` 생성.
- 얼굴 유사성 보정 WIP: `1/1` 생성, 128px 검증 전 `CONDITIONAL`.
- 캐릭터별 통제 후보: `1/15`.
- 128px 얼굴·장비 on/off 실루엣·저채도 CH101 검증: `1/1` 생성 및 Gate A 승인; 5인 교차 보드는 미완료.
- 사람 Gate A 승인: `1/5` (CH101).
- Approved 2D 제작 시트: `0/5`.
- 최종 3D Model·Prefab·Animator: `0/5`.

공통 라인업 WIP는 하우스 스타일 탐색 증거일 뿐 최종 디자인 앵커가 아니다. 개별 캐릭터의 사람 Gate A와 제작 시트가 승인되기 전에는 Runtime 로스터를 CH101~CH105로 자동 치환하지 않는다.

## 10. 현재 실행 Gate

실제 순서와 상태는 `planning/sprint_backlog.md`만 갱신한다. 큰 흐름은 다음과 같다.

```text
Android 실기기 기반 완성
+ Current Generation 캐릭터 Gate A
→ CH101 Approved 2D 제작 시트
→ CH101 2D→3D 변환표와 Blockout
→ 공용 Rig·Shader·Animation·Prefab Proof
→ CH101 Android Character Proof
→ 나머지 4명 확장
→ 환경·UI·VFX·Audio 폴리시
→ 출시 QA
```

Gate:

- Gate A: 매력·성인 여성 가독성·한 문장 훅·얼굴·실루엣·역할·원작성.
- Gate B: Turnaround·2D→3D 변환·장비·재질·Rig·Animation 제작 가능성.
- Gate C: Unity 쿼터뷰 가독성·기능 회귀·성능.
- Android Gate: Touch·Safe Area·Lifecycle·APK·실기기 성능.

## 11. 문서 역할과 갱신 규칙

| 내용 | 단일 소스 |
|---|---|
| 세대 구분·제품·플랫폼·전역 비주얼·Current 로스터·전역 비율·1인 제작 예산·현재 Gate | **이 문서** |
| 실제 작업 ID·순서·상태·완료 조건 | `planning/sprint_backlog.md` |
| 마일스톤 | `planning/roadmap.md` |
| 구현·테스트 증거 | `planning/IMPLEMENTATION_STATUS.md` |
| 캐릭터별 성격·전투 계약·개별 외형 세부 | `docs/05_art_concept/CHARACTER_BIBLE.md` |
| 캐릭터별 LOCKED/CONTROLLED/OPEN/FORBIDDEN | `docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md` |
| 색·재질·환경·UI·VFX 표현 규칙 | `docs/05_art_concept/ART_DIRECTION.md` |
| 제작 시트 Frame·Export | `docs/05_art_concept/CHARACTER_SHEET_TEMPLATE_SPEC.md` |
| Gate A/B/C 판정 방법 | `docs/05_art_concept/ART_REVIEW_CHECKLIST.md` |
| 자산별 상태 | 해당 `.metadata.md`, `.review.md`, `APPROVED` 제작 시트 |
| 아트 세부 산출물 작업 | `planning/art_production_backlog.md` |
| 기술 계약 | 분야별 `docs/02_system_design`, `docs/04_ui_ux`, `docs/06_technical` |

규칙:

1. 다른 문서에 플랫폼·전역 로스터·전역 비율·세대 구분·Production Budget을 다시 적지 않는다.
2. Character Bible과 Anchor는 캐릭터별 고유 세부사항만 기록한다.
3. Roadmap은 마일스톤, Backlog는 작업 상태와 완료 조건만 기록한다.
4. 날짜가 붙은 디자인 리셋/정렬 문서는 결정 이력이며 Current 기준보다 우선하지 않는다.
5. 코드나 생성 자산이 존재해도 검증·사람 승인 없이 `Done` 또는 `APPROVED`로 올리지 않는다.
6. Current Generation의 전역 방향 변경은 이 문서를 먼저 수정한다.
7. 문서 변경 후 `python scripts/validate_project_docs.py`를 실행한다.

## 12. LLM 작업별 필수 Read Set

| 작업 | 반드시 읽는 것 |
|---|---|
| 모든 Current 작업 | 이 문서 + `planning/sprint_backlog.md`의 대상 ID |
| Unity Gameplay | `MVP_SYSTEM_ARCHITECTURE.md`, `IMPLEMENTATION_STATUS.md`, 관련 코드·테스트 |
| Core·Save | `DEV-0113_CORE_INTEGRATION_RESULT.md`, `SAVE_DATA_SPEC.md`, Domain·Adapter 코드 |
| Android | `MOBILE_INPUT_AND_LIFECYCLE.md`, `ANDROID_BUILD_AND_RELEASE.md`, ProjectSettings·입력 코드 |
| 캐릭터 디자인 | `CHARACTER_BIBLE.md`, `CHARACTER_ANCHOR_SPEC.md`, `ART_DIRECTION.md`, `ART_REVIEW_CHECKLIST.md`, 해당 최신 asset review |
| 3D·Animation | Approved 제작 시트, 2D→3D 변환표, `ASSET_NAMING_GUIDE.md`, `ANIMATION_GUIDE.md` |
| QA | 해당 기능 계약, `IMPLEMENTATION_STATUS.md`, 실제 테스트 코드·실행 결과 |
| Legacy 비교 | 필요한 경우에만 `legacy/recamp-pre-generation`의 관련 파일 |

## 13. Branch와 PR 기준

```text
legacy/recamp-pre-generation
└─ 과거 세대 보존. 신규 작업 금지

current/recamp-unified
└─ Current Generation 통합 기준
   ├─ feature/*
   ├─ art/*
   ├─ docs/*
   └─ fix/*
```

- Current Generation 작업 브랜치는 `current/recamp-unified`에서 짧게 분기하고 다시 이 브랜치로 PR한다.
- 디자인과 코드가 충분히 안정화되면 별도 검토 후 `main`으로 통합한다.
- `codex/recamp-unity-mvp`에 신규 기준을 계속 누적하지 않는다.
- Legacy와 Current를 직접 상호 병합하지 않는다. 필요한 구현은 의도를 검토한 뒤 Current에 선택적으로 반영한다.
- LLM은 작업 시작 시 현재 branch·HEAD·변경 상태를 확인한다.
