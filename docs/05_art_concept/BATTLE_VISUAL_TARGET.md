# Re:Camp Battle Visual Target

## 문서 역할

이 문서는 현재 Unity Gray Box의 카메라·전투 공간·가독성 기준을 기록한다. 캐릭터 설정은
`CHARACTER_BIBLE.md`, 고정·가변 외형은 `CHARACTER_ANCHOR_SPEC.md`, 세부 제작 기준은 사람
승인을 받은 개별 캐릭터 시트가 소유한다.

## 기준 자료와 상태

| 자료 | 상태 | 사용 범위 |
|---|---|---|
| `art_refs/moodboard/battle_vertical_slice_concept.png` | PRIMARY ANCHOR / REVIEW | 기존 원본 전투 콘셉트. 폐허 구도·쿼터뷰·색 대비·여성 주인공의 화면 존재감을 우선 참고하되 세부 제작 시트는 아님 |
| `Assets/_ReCamp/Captures/battle_quarter_view_hud.png` | REVIEW | Unity Gray Box 카메라·HUD·경계 기능 검증 |
| 원격 `art_refs/art_direction/ReCamp_Character_Lineup.png` | INVALID | 거의 빈 이미지로 확인돼 모든 제작 기준에서 제외 |
| `art_refs/art_direction/ReCamp_CharacterLineup_REJECTED_v002.png` | REJECTED | 전원 여성 조건 누락, 노아가 남성으로 생성됨, 원본 이미지와 다른 신규 계열 |
| `art_refs/art_direction/ReCamp_CharacterLineup_REVIEW_v003.png` | HISTORICAL REVIEW / Gate A `FAIL` | 과거 4~5등신·역할 모티프·얼굴·실루엣 실패 기록. 새 제작 앵커로 사용하지 않음 |
| 신규 `art_refs/characters/lineup/ReCamp_FiveCharacterLineup_REVIEW_v001.png` | NOT CREATED / provider pending | 신규 CH101~CH105 2D 약 7등신 후보 보드 예정. 생성 전에는 존재한다고 기록하지 않음 |
| 신규 `art_refs/characters/lineup/ReCamp_FiveCharacterCrossReview_REVIEW_v001.png` | NOT CREATED / provider pending | 128px 얼굴·장비 포함/제거 실루엣·저채도 교차 보드 예정 |

## 유지하는 화면 언어

- Orthographic 카메라는 X축 약 `35.3°`, Y축 `45°`의 쿼터뷰를 사용한다.
- 플레이 영역은 낮은 폐허 벽과 모서리 마커로 닫힌 형태를 만든다.
- 중앙 교전 공간은 비우고, 폐허 블록·바리케이드·식생은 가장자리에 배치한다.
- 환경은 자연에 아름답게 잠식된 폐허로 표현하고 캐릭터보다 낮은 채도·디테일을 유지한다.
- HUD는 둥근 패널, 얇은 외곽선, 가벼운 글래스 표현과 최소 정보를 사용한다.
- 캐릭터·공격·자원은 배경보다 높은 명도·채도 대비를 가진다.

캠프는 전투 영역 안의 천막 장식이 아니라 로비의 따뜻하고 안전한 별도 공간으로 다룬다.

## 잠정 기능 팔레트

| 역할 | 색상 | 상태 |
|---|---|---|
| 플레이어·안전·체력 | `#69E5BE` | 기존 Gray Box 프록시 |
| 적·경고 | `#F48B7F` | Gray Box 식별색 |
| HUD·장비 차콜 | `#141D21` | Gray Box UI 기반색 |
| 전투 지면 | `#334740` | 환경 잠정색 |
| 폐허 스톤 | `#61756E` | 환경 잠정색 |
| CH101 경로 | 청록-백색 | 신규 디자인 문서 기준, 런타임 미적용 |
| CH102 구조 | 보라-레몬 | 신규 디자인 문서 기준, 런타임 미적용 |
| CH103 공명 | 아쿠아-코랄 | 신규 디자인 문서 기준, 런타임 미적용 |
| CH104 측량 | 백색-마젠타 | 신규 디자인 문서 기준, 런타임 미적용 |
| CH105 앵커 | 코퍼-황금 | 신규 디자인 문서 기준, 런타임 미적용 |

## 기존 생성 이미지 기록

- 생성 방식: 기존 전투 콘셉트·Gray Box 캡처의 과거 metadata에 보존
- 신규 캐릭터 생성 방식: provider 연결 대기
- 캐릭터 판단: 기존 이미지는 카메라·폐허 구도·화면 존재감만 참고하며 신규 얼굴·의상·무기 기준이 아니다.
- 재사용 기준: Orthographic 구도, 폐허 가장자리 배치, 자원·적·플레이어 대비, HUD 밀도, 부드러운 포스트 아포칼립스 톤
- 출시 자산 사용: 미승인

## 현재 판정과 실행 연결

- v002는 `REJECTED`로 보존하며 재사용하지 않는다.
- v003 생성·metadata·Gate A 기록은 과거 `FAIL` 이력으로만 보존한다.
- 역할 모티프·얼굴·실루엣 교정은 5인 개별 REVIEW 제작 패키지와 통합 교차 검토 보드에 반영했다.
- 사람 승인 전에는 최신 개별/통합 REVIEW 자산도 `APPROVED`나 최종 모델링 시트로 사용하지 않는다.
- 가변 작업 순서와 상태는 이 문서에서 관리하지 않고 `planning/sprint_backlog.md`만 따른다.

기존 Gray Box는 폐기하지 않는다. 아트 승인을 기다리는 동안 자동 테스트와 5인 전투 프로토타입의 기능 기반으로 유지한다.
