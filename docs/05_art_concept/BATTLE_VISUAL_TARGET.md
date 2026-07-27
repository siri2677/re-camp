# Re:Camp Battle Visual Target

> 최종 갱신: 2026-07-27
> 역할: Unity 전투 화면의 카메라·공간·가독성 계약

제품·전역 비주얼·자산 우선순위는 `docs/00_project/CURRENT_PROJECT_BASELINE.md`를 따른다. 캐릭터 설정은 `CHARACTER_BIBLE.md`, 외형 Anchor는 `CHARACTER_ANCHOR_SPEC.md`, 표현 규칙은 `ART_DIRECTION.md`가 소유한다.

## 기준 자료와 상태

| 자료 | 상태 | 사용 범위 |
|---|---|---|
| `art_refs/moodboard/battle_vertical_slice_concept.png` | REVIEW reference | 폐허 구도·쿼터뷰·색 대비·플레이어 존재감 참고. 캐릭터 외형·무기·파티 구성 기준이 아님 |
| `Assets/_ReCamp/Captures/battle_quarter_view_hud.png` | REVIEW evidence | Unity Gray Box 카메라·HUD·경계 기능 증거 |
| `ReCamp_Character_Lineup.png` | INVALID history | 손상·빈 이미지 이력, 제작 기준에서 제외 |
| `ReCamp_CharacterLineup_REJECTED_v002.png` | REJECTED history | 생성 실패 비교 이력 |
| `ReCamp_CharacterLineup_REVIEW_v003.png` | Gate A FAIL history | 실패 원인 비교에만 사용하며 신규 디자인 기반으로 사용하지 않음 |

## 화면 계약

- Orthographic 카메라는 X축 약 `35.3°`, Y축 `45°`의 쿼터뷰를 기준으로 한다.
- 플레이 영역은 낮은 폐허 벽과 모서리 마커로 닫힌 형태를 만든다.
- 중앙 교전 공간은 비우고 폐허 블록·바리케이드·식생은 가장자리에 배치한다.
- 환경은 자연에 잠식된 폐허로 표현하고 캐릭터보다 낮은 채도·디테일을 유지한다.
- 캐릭터·적·공격·자원·상호작용은 배경과 명도·채도·형태가 구분돼야 한다.
- HUD는 최소 정보와 충분한 터치 영역을 사용하며 세부 계약은 `MOBILE_INPUT_AND_LIFECYCLE.md`를 따른다.
- 캠프는 전투 영역의 장식이 아니라 로비의 따뜻하고 안전한 별도 공간으로 다룬다.

## Gray Box 기능 팔레트

| 역할 | 색상 | 용도 |
|---|---|---|
| 플레이어·안전·체력 | `#69E5BE` | 기능 검증용 플레이어·안전 표시 |
| 적·경고 | `#F48B7F` | 적과 위험 표시 |
| HUD·장비 차콜 | `#141D21` | 기능 UI 기반색 |
| 전투 지면 | `#334740` | 이동 가능 영역 |
| 폐허 스톤 | `#61756E` | 환경 경계 |
| 센서·데이터 | `#48BEFF` | 기술 피드백 |

이 HEX 값은 Gray Box 기능색이다. 출시 팔레트나 캐릭터 제작 시트의 고정 색이 아니다.

## 무드보드 재사용 범위

사용 가능:

- Orthographic 구도.
- 폐허 가장자리 배치와 열린 중앙 교전 공간.
- 플레이어·적·자원·배경의 대비.
- 낮은 HUD 밀도.
- 부드러운 포스트 아포칼립스 톤.

사용 불가:

- 이미지 속 캐릭터 얼굴·체형·의상·무기.
- 다인 파티 구성.
- 출시 자산으로의 직접 사용.
- 개별 캐릭터 제작 시트 대체.

## 실행 연결

- 기존 Gray Box는 기능과 회귀 테스트 기반으로 유지한다.
- 캐릭터 디자인은 역사 라인업을 수정하지 않고 현재 Character Bible·Anchor에서 새 후보를 제작한다.
- 캐릭터 자산이 승인되면 실제 쿼터뷰 캡처로 실루엣·카메라 framing·HUD 가림을 다시 검증한다.
- 작업 순서와 상태는 `planning/sprint_backlog.md`, 검증 증거는 `planning/IMPLEMENTATION_STATUS.md`에서만 갱신한다.
