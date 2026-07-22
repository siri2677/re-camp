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
| `art_refs/art_direction/ReCamp_CharacterLineup_REVIEW_v003.png` | REVIEW / Gate A `FAIL` 권고 | 성인 여성 5인·SD-lite 계열은 유효하나 역할 모티프·얼굴·실루엣 교정과 사람 재검토 필요 |

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
| 플레이어·안전·체력 | `#69E5BE` | 루나 민트 계열 프록시 |
| 적·경고 | `#F48B7F` | Gray Box 식별색 |
| HUD·장비 차콜 | `#141D21` | Gray Box UI 기반색 |
| 전투 지면 | `#334740` | 환경 잠정색 |
| 폐허 스톤 | `#61756E` | 환경 잠정색 |
| 센서·데이터 | `#48BEFF` | 기술 피드백 잠정색 |

정확한 프로젝트·캐릭터 HEX 팔레트는 라인업과 개별 시트 승인 때 확정한다.

## 기존 생성 이미지 기록

- 생성 방식: Codex 내장 imagegen
- 기존 프롬프트: companion metadata `art_refs/moodboard/battle_vertical_slice_concept.metadata.md`에 보존
- 캐릭터 판단: 여성 주인공의 민트 계열 색감, 귀여운 실루엣, 화면 내 존재감은 유지할 원본 앵커다. 정확한 비율·소총·의상 구조는 제작 시트에서 재검토한다.
- 재사용 기준: Orthographic 구도, 폐허 가장자리 배치, 자원·적·플레이어 대비, HUD 밀도, 부드러운 포스트 아포칼립스 톤
- 출시 자산 사용: 미승인

## 현재 판정과 실행 연결

- v002는 `REJECTED`로 보존하며 재사용하지 않는다.
- v003 생성·metadata·Gate A 리뷰 기록은 완료됐고 현재 판정은 `REVIEW / FAIL 권고`다.
- 역할 모티프·얼굴·실루엣 교정은 캐릭터별 WIP와 128px 얼굴·흑백 실루엣 증거에서 수행한다.
- 사람 승인 전에는 v003 또는 파생 자산을 `APPROVED`나 최종 모델링 시트로 사용하지 않는다.
- 가변 작업 순서와 상태는 이 문서에서 관리하지 않고 `planning/sprint_backlog.md`만 따른다.

기존 Gray Box는 폐기하지 않는다. 아트 승인을 기다리는 동안 자동 테스트와 5인 전투 프로토타입의 기능 기반으로 유지한다.
