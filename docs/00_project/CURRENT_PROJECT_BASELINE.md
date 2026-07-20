# Re:Camp Current Project Baseline

> 최종 갱신: 2026-07-20  
> 상태: Active  
> 목적: 프로젝트 문서가 충돌할 때 우선 적용하는 현재 기준

## 1. 문서 우선순위

서로 다른 문서의 내용이 충돌하면 다음 순서로 판단한다.

```text
CURRENT_PROJECT_BASELINE.md
→ planning/sprint_backlog.md의 현재 상태와 선행 조건
→ 분야별 상세 Spec
→ 게임 데이터 tables/
→ APPROVED art_refs/
→ REVIEW·WIP art_refs/
```

캐릭터 외형은 개별 `APPROVED` 제작 시트가 텍스트 설명보다 우선한다. 단, 승인 시트가 없으면 `ART_DIRECTION.md`, `CHARACTER_BIBLE.md`, 통합 라인업 순서로 적용한다.

## 2. 프로젝트 정의

Re:Camp는 멸망 이후 자연에 잠식된 위험 구역을 짧게 탐험하고 자원을 회수해 캠프를 성장시키는 **3D 고정 쿼터뷰 로그라이트 RPG**다.

핵심 경험은 다음 네 가지다.

```text
짧은 탐험의 긴장감
+ 무사 귀환의 성취감
+ 캠프의 누적 성장
+ 서브컬쳐 캐릭터에 대한 애착
```

## 3. 현재 개발 단계

현재는 다음 작업을 병행하는 초기 제작 단계다.

- 통합 캐릭터 라인업 방향 승인 상태 정리
- Unity 프로젝트 생성과 기술 기반 구축 준비
- ReCamp.Core의 Unity 통합 방식 검토
- 루나 Character Proof를 위한 아트 제작 파이프라인 구축
- 실제 디자인 자산 제작 전 수치·파일·승인 규격 정리

아직 최종 캐릭터 모델, 최종 환경, Unity Prefab, 플레이 가능한 Vertical Slice는 완성되지 않았다.

## 4. 플랫폼과 기술 기준

| 항목 | 현재 기준 |
|---|---|
| 1차 플랫폼 | Windows PC |
| 2차 플랫폼 | Android |
| iOS | 초기 범위 제외, 이후 검토 |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| 입력 | Unity Input System |
| PC 기본 입력 | Keyboard + Mouse 또는 Gamepad |
| Android 입력 | 가상 조이스틱과 터치 버튼으로 후속 확장 |
| 카메라 | 고정 쿼터뷰 |
| 저장 | 로컬 저장 |
| 플레이 방식 | 싱글플레이 |

PC에서 게임 루프와 비주얼 품질을 먼저 검증한 뒤 Android용 UI·성능 품질 단계를 추가한다.

## 5. 비주얼 기준

```text
2D 일반 등신 서브컬쳐 대표 일러스트
+ 3D 5~6등신 스타일라이즈드 인게임 캐릭터
+ 툰 셰이딩
+ 자연에 잠식된 부드러운 포스트 아포칼립스
+ 캐릭터보다 낮은 채도와 밀도의 환경
```

캐릭터 공통 원칙:

- 실사 7~8등신이 아니라 머리·손·발·무기를 약간 강조한 5~6등신
- 화면에서 작게 보여도 머리, 상체, 무기 실루엣이 구분되어야 함
- 얼굴·헤어·의상·무기는 캐릭터별 고유 제작
- 공용 Humanoid Rig, 공용 기본 애니메이션, 공용 Prefab 기반 사용
- 최종 판단 기준은 일러스트의 세부 묘사보다 Unity 쿼터뷰에서의 매력과 식별성

## 6. 캐릭터 상태

플레이어블 캐릭터는 다음 5명이다.

| ID | 캐릭터 | 역할 | 대표 장비 |
|---|---|---|---|
| CH001 | 루나 | 정찰형 근접 딜러 | 에너지 단검, 탐지 장치 |
| CH002 | 미유 | 드론 원거리 딜러 | 전투 드론, 제어 건틀릿 |
| CH003 | 코코 | 회복·보호 지원 | 의료 장비, 보호막 장치 |
| CH004 | 이리스 | 정밀 원거리 딜러 | 에너지 라이플, 조준 장치 |
| CH005 | 노아 | 방어·반격 탱커 | 전개식 방패, 방호 장비 |

현재 5인 라인업은 **방향 승인(Direction Approved)** 상태다.

이는 다음을 의미한다.

- 이름, 역할, 대표 색상, 무기와 큰 실루엣 방향은 사용 가능
- 개별 얼굴·헤어·의상 구조는 아직 최종 승인본이 아님
- 통합 라인업 이미지는 최종 Turnaround나 3D 모델링 시트가 아님
- 개별 캐릭터는 별도의 `APPROVED` 제작 시트를 거쳐야 함

## 7. 제작 우선순위

전체 캐릭터의 방향을 유지하되 최종 제작은 루나를 먼저 검증한다.

```text
5인 라인업 방향 승인
→ Unity 카메라·Gray Box 기반 생성
→ ComfyUI·Figma·Blender 파이프라인 검증
→ 루나 2D 제작 시트 승인
→ 루나 3D Blockout
→ Coplay/Aura로 Unity Import·Prefab·쿼터뷰 검증
→ 루나 Character Proof
→ Vertical Slice
→ 나머지 4명 제작 시트와 최종 모델 확장
```

나머지 네 캐릭터는 루나 Proof 전까지 단독 전신 방향과 3D 위험 요소만 정리하고, 고비용 최종 제작은 보류한다.

## 8. MCP와 제작 도구

| 도구 | 주 역할 |
|---|---|
| ComfyUI Cloud MCP | 캐릭터·환경·몬스터·VFX 2D 후보와 반복 생성 |
| Figma Remote MCP | 캐릭터 제작 시트, UI Design System, 리뷰 보드 |
| Blender MCP | 3D Blockout, 소품, 모델·Rig·Animation·FBX Export 보조 |
| Coplay | Unity Scene·Prefab·Component·Material·Animator 자동화와 대량 편집 |
| Aura | Unity FBX/Texture Import, Prefab·Material·Animator 구성 검증과 보완 자동화 |
| GitHub MCP | 문서, 브랜치, PR, 승인 자산과 작업 이력 관리 |
| 코드 에이전트 | C# 코드, Importer, 검증 도구, 테스트, 자동화 스크립트 |

Coplay와 Aura는 둘 다 사용한다. 한 자산을 두 도구가 동시에 수정하지 않도록 작업마다 Primary Tool을 지정하고, 다른 도구는 검증 또는 실패 시 대체 경로로 사용한다.

필수 공동 테스트:

```text
FBX Import
→ Material·Texture 연결
→ Humanoid Avatar 확인
→ Prefab 생성
→ Animator 연결
→ Collider·Socket 구성
→ Scene 배치
→ 누락 Reference 검사
```

## 9. 범위 구분

### Portfolio Vertical Slice 완료 범위

- 루나 1명
- 버려진 거리 1개
- 일반 몬스터 3종
- 보스 1종
- 스킬 약 6개
- 캠프 시설 3종
- 로비·전투·스킬 선택·결과·캠프 강화 UI
- 저장·불러오기
- 약 3~5분의 완결된 탐험·귀환 루프

### 장기 정식 출시 목표

- 플레이어블 캐릭터 5명
- 스테이지 2개
- 일반 몬스터 6종
- 보스 2종
- 캠프 시설 4종 이상
- 캐릭터 해금, 친밀도, 대화와 로비 상호작용

Vertical Slice가 기준 품질을 통과하기 전에 장기 출시 범위의 최종 자산을 대량 제작하지 않는다.

## 10. 현재 제외 범위

```text
멀티플레이
PvP
길드
실시간 계정 서버
가챠
상점 결제와 광고
오픈월드
캐릭터별 완전 고유 골격
복잡한 의상 교체
대량의 시네마틱 컷신
풀 보이스
```

## 11. 승인 게이트

### Gate A — 방향

- 캐릭터의 역할·색상·실루엣이 구분됨
- 세계관과 UI·환경 분위기가 충돌하지 않음

### Gate B — 제작 가능성

- 2D 시트가 정면·측면·후면에서 구조적으로 일치함
- 3D 모델·Rig·Animation으로 구현 가능한 구조임

### Gate C — Unity 가독성

- 고정 쿼터뷰에서 얼굴·상체·무기가 보임
- 환경보다 캐릭터가 우선적으로 읽힘
- 공격 방향·위험·자원이 즉시 구분됨

### Gate D — 플레이와 성능

- 한 판의 탐험·전투·귀환·성장이 완주됨
- Windows 목표 성능을 충족함
- Android 확장 시 품질 단계가 동작함

## 12. 변경 원칙

현재 기준을 변경할 때는 다음 파일을 같은 PR에서 함께 갱신한다.

```text
CURRENT_PROJECT_BASELINE.md
planning/roadmap.md
planning/sprint_backlog.md
관련 상세 Spec
README.md 또는 PROJECT_OVERVIEW.md
```

한 문서만 수정해 다시 기준이 이원화되는 것을 허용하지 않는다.
