# Re:Camp Roadmap

## 목표

Re:Camp는 먼저 **전투 1판이 완전히 돌아가는 MVP**를 완성한 뒤, 캐릭터/스킬/캠프 시스템을 확장한다.

---

## M0. 프로젝트 세팅

### 목표

Unity 프로젝트와 GitHub 저장소 기본 구조를 준비한다.

### 작업

```text
- 저장소 초기화
- README.md 작성
- AGENT.md 작성
- .gitignore 작성
- .gitattributes 작성
- docs/ 구조 생성
- tables/ 구조 생성
- planning/ 구조 생성
- Unity 프로젝트 생성
- Unity Version Control 설정
```

### 완료 기준

```text
GitHub 저장소에 초기 문서와 Unity 설정 기준이 준비된다.
```

---

## M1. 코어 루프 프로토타입

### 목표

로비에서 전투로 진입하고, 전투 후 결과 화면으로 돌아오는 최소 루프를 만든다.

### 작업

```text
- Bootstrap Scene 생성
- Lobby Scene 생성
- Battle Scene 생성
- Result Scene 생성
- SceneLoader 구현
- GameManager 구현
- 임시 UI 구성
```

### 완료 기준

```text
로비 → 전투 → 결과 → 로비 흐름이 동작한다.
```

---

## M2. 전투 MVP

### 목표

플레이어와 몬스터의 기본 전투가 동작하도록 만든다.

### 작업

```text
- PlayerController 구현
- PlayerStats 구현
- PlayerAttack 구현
- EnemyController 구현
- EnemySpawner 구현
- Damageable 구현
- 기본 공격 판정 구현
- 몬스터 사망 처리
```

### 완료 기준

```text
플레이어가 이동하고, 몬스터가 등장하며, 공격으로 몬스터를 처치할 수 있다.
```

---

## M3. 탐험/보상 루프

### 목표

자원 획득과 결과 정산을 구현한다.

### 작업

```text
- 자원 드랍 구현
- 자원 획득 구현
- 전투 시간 제한 구현
- 귀환 버튼 구현
- 결과 화면 구현
- 보상 정산 구현
```

### 완료 기준

```text
몬스터 처치 후 자원을 얻고, 전투 종료 후 결과 화면에서 보상을 확인할 수 있다.
```

---

## M4. 캠프 성장

### 목표

획득 자원으로 캠프 시설을 성장시킨다.

### 작업

```text
- CampManager 구현
- CampFacilityData 구현
- 시설 강화 UI 구현
- 강화 효과 적용
- SaveManager 구현
- SaveData 구현
```

### 완료 기준

```text
전투 보상으로 캠프 시설을 강화하고, 강화 상태가 저장된다.
```

---

## M5. 데모 완성

### 목표

포트폴리오용 플레이 가능 데모를 만든다.

### 작업

```text
- 캐릭터 2~3명 확장
- 스킬 10개 이상 확장
- 스테이지 2개 확장
- 보스 2종 확장
- UI 개선
- 사운드 적용
- 튜토리얼 추가
- 밸런스 조정
```

### 완료 기준

```text
외부 사용자에게 보여줄 수 있는 10~15분 분량의 플레이 데모가 완성된다.
```
