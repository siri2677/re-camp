# Re:Camp Save Data Specification

> 최종 갱신: 2026-07-27
> 상태: Active Implementation Contract
> 현재 Unity 저장 버전: `2`

## 1. 목적

로컬 저장 자료의 소유 범위, Version, Migration, 손상 복구, 저장 시점과 테스트 기준을 정의한다.
현재 구현은 Camp 자원과 시설 레벨만 저장하며 Battle 중간 저장·복원은 지원하지 않는다.

## 2. 현재 저장 위치

```text
PlayerPrefs Key
- Legacy: ReCamp.CampSave.v1
- Current: ReCamp.CampSave.v2

Serialization
- UnityEngine.JsonUtility
```

현재 `PlayerPrefs`는 Vertical Slice와 초기 Android Test를 위한 로컬 저장 방식이다. 전체 콘텐츠 규모,
보안, 용량 또는 다중 Profile 요구가 커지면 파일 기반 Repository로 교체할 수 있지만, Migration 없이
저장 방식을 바로 바꾸지 않는다.

## 3. 현재 Schema v2

```yaml
version: 2
scrap: 0
food: 0
dataFragments: 0
generatorLevel: 0
workbenchLevel: 0
foodStorageLevel: 0
```

### 필드 계약

| 필드 | 타입 | 기본값 | 규칙 |
|---|---|---:|---|
| `version` | int | 2 | 현재 Unity 저장 버전 |
| `scrap` | int | 0 | 0 이상 |
| `food` | int | 0 | 0 이상. Domain에서는 `Rations`로 변환 |
| `dataFragments` | int | 0 | 0 이상 |
| `generatorLevel` | int | 0 | 0 이상 |
| `workbenchLevel` | int | 0 | 0 이상. Domain에서는 `Workshop` |
| `foodStorageLevel` | int | 0 | 0 이상. Domain에서는 `RationStorage` |

음수, 누락, 비정상적으로 큰 값에 대한 상한·보정 정책은 시설·경제 밸런스 확정 시 추가한다.

## 4. Domain 변환

```text
Unity CampSaveData
→ UnityCampSaveData
→ DomainCampSaveAdapter
→ ReCamp.Domain.GameSaveData
```

| Unity | Domain |
|---|---|
| Scrap | Scrap |
| Food | Rations |
| DataFragment | DataFragment |
| Generator | Generator |
| Workbench | Workshop |
| FoodStorage | RationStorage |

Domain 자료는 Unity 저장 Key, `PlayerPrefs`, `JsonUtility`를 알지 못한다.

## 5. v1→v2 Migration

현재 Migration 절차:

1. `ReCamp.CampSave.v2`가 있으면 v2를 읽는다.
2. v2가 없고 `ReCamp.CampSave.v1`이 있으면 Legacy JSON을 읽는다.
3. Legacy 값을 `UnityCampSaveData`로 옮긴다.
4. `DomainCampSaveAdapter`를 통해 Domain 자료로 변환한다.
5. Domain 자료를 Unity v2 자료로 다시 변환한다.
6. `ReCamp.CampSave.v2` Key에 저장한다.
7. 변환된 v2를 Runtime에 반환한다.

현재 Legacy Key 삭제는 필수로 하지 않는다. Migration 안정화 후 별도 버전에서 정리할 수 있다.

## 6. 손상 데이터 처리

현재 `JsonUtility` 역직렬화가 실패하면 신규 `CampSaveData`를 반환한다.

추가해야 할 보호 규칙:

- JSON 파싱 실패 Log를 개발 빌드에 기록
- Version 미지원 시 즉시 덮어쓰지 않고 복구 경로 선택
- 음수 자원·시설 레벨을 0으로 보정하거나 저장을 거부
- 필수 필드 누락 시 기본값 적용
- Migration 실패 시 Legacy 원문을 유지
- 새 저장 성공 전 기존 저장을 삭제하지 않음

Vertical Slice에서는 별도 Backup Slot이 없지만 Closed Test 전에 최소 1개의 Backup 또는 복구 전략을
검토한다.

## 7. 저장 시점

현재 또는 목표 저장 시점:

| 이벤트 | 저장 |
|---|---|
| Run 보상 Camp 입금 | 저장 |
| Camp 시설 강화 성공 | 저장 |
| Lobby에서 앱 Background 진입 | 저장 |
| Battle에서 앱 Background 진입 | Camp 영구 상태만 저장 |
| 설정 변경 | 설정 Save 분리 후 저장 |
| 정상 앱 종료 | 가능한 경우 저장하되 종료 이벤트만 의존하지 않음 |

Battle에서 획득 중인 임시 Run 보상은 저장하지 않는다.

## 8. Battle 중 Process 종료 정책

Vertical Slice 정책:

- Battle 중 Background 전환은 같은 Process에서 Pause·Resume을 지원한다.
- OS Kill 또는 강제 종료 후 Battle 중간 상태를 복원하지 않는다.
- 임시 Run 보상은 Camp에 입금하지 않는다.
- 다음 실행 시 Title 또는 Lobby로 진입한다.
- 마지막으로 저장된 Camp 자원과 시설만 복구한다.

Battle 중간 복구를 추가할 경우 Run Save를 Camp Save와 분리하고 Expiry·Version·중복 정산 방지 규칙을
별도로 작성해야 한다.

## 9. 앞으로 추가될 Save 영역

다음 자료는 현재 v2에 포함되지 않는다.

- 캐릭터 해금
- 선택 캐릭터
- 친밀도와 캐릭터 에피소드
- Stage 해금·난이도·최고 기록
- 튜토리얼 진행
- Audio·Graphic·Control 설정
- 언어
- 접근성 설정
- 업적·도전 과제
- 외부 테스트 동의·Telemetry 설정

이 자료를 추가할 때 Camp Save 한 클래스에 무조건 누적하지 않고 다음 Section으로 분리한다.

```text
RootSave
- meta
- camp
- roster
- progression
- settings
- tutorial
```

## 10. Version 규칙

- 저장 구조 또는 의미가 바뀌면 Version을 증가한다.
- 필드 추가만으로도 이전 자료가 안전하게 읽히는지 검증한다.
- 필드 이름 변경은 구 이름을 바로 제거하지 않고 Migration을 제공한다.
- 하나의 Version에서 여러 의미를 사용하지 않는다.
- Git SHA와 앱 Version은 Save Version과 별도다.
- Migration은 `v1→v2→v3`처럼 단계별로 작성할 수 있어야 한다.

## 11. 원자성·중복 방지

향후 파일 저장으로 전환할 경우:

1. 임시 파일에 직렬화
2. 읽기 검증
3. 기존 파일 Backup
4. 임시 파일을 Current로 교체
5. 실패 시 Backup 복원

Run 보상은 한 번만 Camp에 입금해야 한다. Result Scene 재진입, 앱 Resume, 중복 버튼 입력으로 같은 Run이
다시 정산되지 않도록 Run ID 또는 정산 완료 Flag를 Full Release 전 도입한다.

## 12. 개발·QA 기능

개발 빌드에서만 다음 기능을 제공할 수 있다.

- Save 내용 보기
- Save Version 보기
- Camp Save 초기화
- v1 Sample 생성
- Migration 실행
- 손상 JSON Sample 주입
- 자원·시설 Level Test 값 설정

Release Build에는 원시 Save 편집 기능을 포함하지 않는다.

## 13. 테스트 기준

### EditMode

- 신규 저장의 기본값
- v1→v2 Migration
- Food↔Rations 변환
- 시설 Level 왕복
- 잘못된 JSON 복구
- 음수·누락 값 정책
- 미지원 Version 처리

### PlayMode

- Run 완료 후 Camp 입금·저장
- Lobby 재진입 후 유지
- 시설 강화 후 저장
- 앱 Pause Simulation 후 유지
- 중복 Result 처리 시 한 번만 정산

### Android 실기기

- 앱 완전 종료 후 재실행
- Background·Resume
- OS가 앱을 제거한 뒤 재실행
- 앱 업데이트 설치 후 Migration
- 저장 손상 시 Crash 없이 복구

## 14. 완료 조건

`SAVE_DATA_SPEC.md`가 문서상 완료되었다고 해서 저장 시스템 전체가 완료되는 것은 아니다.
다음이 충족돼야 Release Candidate 저장 Gate를 통과한다.

- 현재 Schema와 코드 일치
- 모든 Migration 자동 테스트
- 중복 정산 방지
- 손상 데이터 복구
- Android 업데이트 설치 검증
- Backup 또는 복구 전략
- 설정·진행 자료 추가 후 Version 호환
- 개인정보가 저장될 경우 보안·삭제 정책
