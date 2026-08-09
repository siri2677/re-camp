# Re:Camp 디자인 작업 진척도 — 2026-08-09 리셋 반영

## 결론

기존 루나·미유·코코·이리스·노아 2D REVIEW 패키지는 새 방향의 기준에서 제외하고 `HISTORY ONLY`로 전환했다.
새 로스터의 역할·성격·비주얼 훅·Anchor·공통 Art Direction·후보 생성 프롬프트·Gate A 검토표는 문서로 작성했다.
이미지 provider와 로컬 생성 경로가 현재 연결되지 않아 신규 PNG 후보 이미지는 아직 생성하지 않았다.
따라서 신규 디자인은 문서 기준 완료이지만 시각 후보 제작과 사람 Gate A 승인은 완료되지 않았다.

## 신규 로스터 기준

| ID | 캐릭터 | 2D 목표 | 3D 목표 | 대표 장비 | 현재 상태 |
|---|---|---:|---:|---|---|
| CH101 | 아마사와 린 | 6.9~7.1H | 5.3~5.4H | 단일 와이어 세이버·신호 리본 | Prompt Ready / REVIEW |
| CH102 | 키사라기 마오 | 6.8~7.0H | 5.2~5.3H | 접이식 자기 활·구조 링 | Prompt Ready / REVIEW |
| CH103 | 카나데 노조미 | 7.0~7.2H | 5.5~5.6H | 공명 배턴·응급 베일 | Prompt Ready / REVIEW |
| CH104 | 시온 타테가미 | 7.1~7.3H | 5.6~5.7H | 프리즘 측량 부채·지도 링 | Prompt Ready / REVIEW |
| CH105 | 쿠로가네 아카리 | 7.2~7.4H | 5.7~5.8H | 키네틱 건틀릿·앵커 케이블 | Prompt Ready / REVIEW |

## 작업 상태

| 계획 항목 | 상태 | 근거 |
|---|---|---|
| 5인 역할·전투 계약 | 완료 | `docs/05_art_concept/CHARACTER_BIBLE.md` v3.0 |
| 5인 성격·비주얼 훅 | 완료 | Character Bible·Art Direction v3.0 |
| 공통 고정·가변·금지 앵커 | 완료 | `CHARACTER_ANCHOR_SPEC.md` v3.0 |
| 5인 후보 생성 프롬프트 | 완료 | `planning/ART_DIRECTION_RESET_BRIEF_2026-08-09.md` |
| Gate A 검토표 | 준비 완료 | Reset Brief·`ART_REVIEW_CHECKLIST.md` v3.0 |
| 신규 후보 PNG 이미지 | 대기 | 외부 이미지 provider 또는 로컬 생성 경로 연결 필요; Unity Editor instance 불필요 |
| 2D 제작 시트·Turnaround | 대기 | 사람 Gate A 이후 |
| 2D→3D 변환표 | 대기 | 선택된 후보·제작 시트 이후 |
| 3D Blockout·Unity Proof | 대기 | Gate A/B 승인 이후 |
| 사람 Gate A 승인 | 0/5 | 사용자 판정 필요 |
| 최종 Unity 아트 적용 | 0/5 | 3D Gate B/C 이후 |

## 기존 자산 상태

- 과거 라인업·캐릭터별 REVIEW 이미지: `HISTORY ONLY`, 신규 디자인 입력 아님
- 신규 기준과 섞지 않음
- 실제 신규 승인안이 생기면 관련 자료를 `SUPERSEDED` 또는 `ARCHIVE`로 기록
- 기존 Unity Gray Box 캐릭터와 테스트는 기능 검증용 레거시이며 이번 아트 리셋의 승인 증거가 아님

## 다음 실행

1. 이미지 provider를 연결한다.
2. 공통 프롬프트와 캐릭터별 프롬프트로 캐릭터당 3안씩 생성한다.
3. 동일 캔버스에서 얼굴·전신·장비 포함/제거 실루엣·팔레트를 비교한다.
4. 사용자 Gate A에서 5인 방향을 선택한다.
5. 선택된 캐릭터만 제작 시트와 2D→3D 변환표로 확장한다.

`APPROVED`: `NOT GRANTED`
`Human Gate A`: `0/5`
