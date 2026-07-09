# AGENT.md

## Re:Camp Development Guide

이 문서는 Re:Camp 프로젝트 개발을 시작하기 위한 저장소 구성, Unity 프로젝트 구조, 브랜치 전략, 개발 순서, 데이터 관리 방식, GitHub 운영 규칙을 정의한다.

---

## 1. 프로젝트 운영 방향

Re:Camp는 초기 MVP 단계이므로 GitHub 단일 저장소로 관리한다.

```text
GitHub 단일 저장소
= Unity 프로젝트
+ 기획 문서
+ 개발 문서
+ 데이터 테이블
+ 아트 레퍼런스
+ 일정 관리
```

초기에는 저장소를 여러 개로 나누지 않는다.

```text
비추천 초기 구조

re-camp-client
re-camp-docs
re-camp-art
re-camp-backend
```

위와 같이 나누면 초기 개발 단계에서 관리 비용이 증가한다.  
현재 단계에서는 기획, 코드, 데이터, 아트 레퍼런스를 하나의 저장소에서 함께 추적하는 것이 가장 안정적이다.

---

## 2. 추천 저장소 구조

```text
re-camp/
├── Assets/
│   └── _ReCamp/
│       ├── Art/
│       │   ├── Characters/
│       │   ├── Environments/
│       │   ├── UI/
│       │   └── VFX/
│       ├── Audio/
│       │   ├── BGM/
│       │   └── SFX/
│       ├── Prefabs/
│       │   ├── Player/
│       │   ├── Enemies/
│       │   ├── UI/
│       │   ├── Items/
│       │   └── Stage/
│       ├── Scenes/
│       │   ├── 00_Bootstrap.unity
│       │   ├── 01_Title.unity
│       │   ├── 02_Lobby.unity
│       │   ├── 03_Battle.unity
│       │   └── 04_Result.unity
│       ├── Scripts/
│       │   ├── Core/
│       │   ├── GameFlow/
│       │   ├── Player/
│       │   ├── Enemy/
│       │   ├── Combat/
│       │   ├── Skill/
│       │   ├── Item/
│       │   ├── Camp/
│       │   ├── UI/
│       │   ├── Data/
│       │   ├── Save/
│       │   └── Utils/
│       ├── ScriptableObjects/
│       │   ├── Characters/
│       │   ├── Skills/
│       │   ├── Enemies/
│       │   ├── Items/
│       │   └── Stages/
│       └── Resources/
│
├── Packages/
├── ProjectSettings/
│
├── docs/
│   ├── 00_project/
│   ├── 01_game_design/
│   ├── 02_system_design/
│   ├── 03_content_design/
│   ├── 04_ui_ux/
│   ├── 05_art_concept/
│   ├── 06_dev_docs/
│   ├── 07_balance/
│   ├── 08_qa/
│   └── 09_portfolio/
│
├── tables/
│   ├── character_table.md
│   ├── skill_table.md
│   ├── enemy_table.md
│   ├── item_table.md
│   ├── stage_table.md
│   └── camp_facility_table.md
│
├── planning/
│   ├── roadmap.md
│   ├── milestone.md
│   ├── sprint_backlog.md
│   └── task_board_rule.md
│
├── art_refs/
│   ├── character/
│   ├── background/
│   ├── ui/
│   └── moodboard/
│
├── README.md
├── AGENT.md
├── CHANGELOG.md
├── .gitignore
└── .gitattributes
```

---

## 3. Unity 내부 구조 원칙

Unity의 `Assets` 폴더 안에는 프로젝트 전용 루트 폴더를 만든다.

```text
Assets/_ReCamp/
```

이렇게 구성하는 이유는 외부 에셋과 프로젝트 자체 리소스가 섞이는 것을 막기 위해서다.

예를 들어 Asset Store 에셋을 추가하면 다음처럼 들어올 수 있다.

```text
Assets/SomeAssetPack/
Assets/TextMesh Pro/
Assets/Plugins/
Assets/_ReCamp/
```

이때 직접 제작한 파일은 전부 `_ReCamp` 안에 유지한다.

---

## 4. 브랜치 전략

### 4.1 개인 개발 기준 최소 전략

혼자 개발할 경우에는 아래 구조만으로도 충분하다.

```text
main
feature/*
```

예시:

```text
main
feature/core-loop
feature/player-movement
feature/enemy-spawn
feature/battle-ui
feature/camp-system
```

### 4.2 포트폴리오 및 협업 고려 전략

포트폴리오와 추후 협업 가능성까지 고려하면 아래 구조를 권장한다.

```text
main
develop
feature/*
fix/*
release/*
```

| 브랜치 | 역할 |
|---|---|
| `main` | 안정된 데모 버전 |
| `develop` | 개발 통합 브랜치 |
| `feature/*` | 기능 개발 |
| `fix/*` | 버그 수정 |
| `release/*` | 데모 배포 준비 |

현재 Re:Camp에서는 아래 전략을 기본으로 한다.

```text
main
develop
feature/*
```

예시:

```text
main
develop
feature/project-setup
feature/core-loop
feature/player-controller
feature/enemy-system
feature/skill-system
feature/camp-system
```

---

## 5. 커밋 메시지 규칙

커밋 메시지는 다음 타입을 사용한다.

```text
feat: 새로운 기능 추가
fix: 버그 수정
docs: 문서 수정
style: 코드 포맷 수정
refactor: 구조 개선
test: 테스트 추가
chore: 설정/빌드/기타 작업
art: 아트 리소스 추가
balance: 밸런스 수치 수정
```

예시:

```text
feat: 플레이어 이동 시스템 구현
feat: 기본 공격 판정 추가
docs: MVP 범위 문서 작성
art: 루나 캐릭터 콘셉트 이미지 추가
balance: 몬스터 체력 수치 조정
refactor: 전투 상태 관리 구조 분리
```

---

## 6. Unity Git 설정

Unity에서 아래 설정을 적용한다.

```text
Edit
→ Project Settings
→ Editor
```

설정값:

```text
Version Control Mode: Visible Meta Files
Asset Serialization Mode: Force Text
```

이 설정은 Unity의 `.meta` 파일을 Git으로 관리하고, Scene/Prefab 변경사항을 텍스트 기반으로 추적하기 위해 필요하다.

---

## 7. Git LFS 설정

Unity 프로젝트는 이미지, 사운드, FBX, PSD 같은 바이너리 파일이 많으므로 Git LFS 사용을 권장한다.

### 7.1 LFS 관리 대상

```text
*.png
*.jpg
*.jpeg
*.psd
*.fbx
*.wav
*.mp3
*.ogg
*.mp4
*.mov
*.blend
*.ai
*.clip
```

### 7.2 .gitattributes 예시

```text
*.png filter=lfs diff=lfs merge=lfs -text
*.jpg filter=lfs diff=lfs merge=lfs -text
*.jpeg filter=lfs diff=lfs merge=lfs -text
*.psd filter=lfs diff=lfs merge=lfs -text
*.fbx filter=lfs diff=lfs merge=lfs -text
*.blend filter=lfs diff=lfs merge=lfs -text
*.wav filter=lfs diff=lfs merge=lfs -text
*.mp3 filter=lfs diff=lfs merge=lfs -text
*.ogg filter=lfs diff=lfs merge=lfs -text
*.mp4 filter=lfs diff=lfs merge=lfs -text
*.mov filter=lfs diff=lfs merge=lfs -text
```

대용량 원본 PSD, 영상, 미사용 리소스는 저장소에 바로 넣지 않는다.  
초기에는 실제 사용 리소스와 문서 중심으로 관리한다.

---

## 8. Unity용 .gitignore 기준

Unity에서 Git에 올리지 않을 항목은 다음과 같다.

```text
Library/
Temp/
Obj/
Build/
Builds/
Logs/
UserSettings/
.vs/
.idea/
```

반드시 Git에 포함해야 하는 항목:

```text
Assets/
Packages/
ProjectSettings/
*.meta
README.md
AGENT.md
docs/
tables/
planning/
```

---

## 9. Issue 및 Milestone 구성

### 9.1 Milestone

```text
M0. 프로젝트 세팅
M1. 코어 루프 프로토타입
M2. MVP 완성
M3. 데모 완성
M4. 포트폴리오 빌드
```

### 9.2 Issue Label

```text
type: feature
type: bug
type: docs
type: art
type: balance
type: qa
priority: high
priority: medium
priority: low
system: combat
system: exploration
system: ui
system: camp
system: data
```

---

## 10. 첫 번째 개발 목표

처음에는 전체 게임을 만들려고 하지 않는다.  
가장 먼저 전투 1판이 완전히 돌아가게 만든다.

```text
캐릭터가 움직인다
몬스터가 나온다
공격이 된다
몬스터가 죽는다
자원을 얻는다
결과 화면으로 간다
다시 로비로 돌아온다
```

이것이 Re:Camp의 첫 번째 완성 단위다.

---

## 11. 개발 Phase

### Phase 0. 프로젝트 세팅

```text
1. GitHub 저장소 생성
2. Unity 프로젝트 생성
3. .gitignore 추가
4. .gitattributes 추가
5. Git LFS 설정
6. README.md 추가
7. docs/ 폴더 추가
8. main / develop 브랜치 생성
```

### Phase 1. Unity 기본 구조

```text
1. Bootstrap Scene 생성
2. Title Scene 생성
3. Lobby Scene 생성
4. Battle Scene 생성
5. Result Scene 생성
6. Scene 이동 구조 구현
7. GameManager 생성
8. UIManager 생성
9. SaveManager 생성
```

### Phase 2. 플레이어 조작

```text
1. PlayerController 구현
2. 이동 입력 처리
3. 모바일 가상 조이스틱 적용
4. 캐릭터 애니메이션 연결
5. 카메라 추적 구현
6. 체력 UI 연결
```

### Phase 3. 전투 기본

```text
1. 기본 공격 구현
2. 적 피격 처리
3. 적 사망 처리
4. 데미지 표시
5. 쿨타임 처리
6. 피격 이펙트 적용
```

### Phase 4. 몬스터 시스템

```text
1. EnemyController 구현
2. 플레이어 추적 AI
3. 몬스터 스폰 시스템
4. 몬스터 체력/공격력 데이터화
5. 웨이브 생성
6. 보스 몬스터 기본 구조
```

### Phase 5. 탐험/보상 루프

```text
1. 자원 드랍
2. 자원 획득 처리
3. 탐험 제한 시간
4. 귀환 버튼
5. 사망 처리
6. 결과 화면
7. 획득 보상 정산
```

### Phase 6. 성장 시스템

```text
1. 캐릭터 레벨업
2. 스킬 선택
3. 스킬 강화
4. 캠프 시설 업그레이드
5. 저장/불러오기
```

---

## 12. C# 코드 구조

초기 C# 스크립트는 다음 구조를 기준으로 작성한다.

```text
Scripts/
├── Core/
│   ├── GameManager.cs
│   ├── SceneLoader.cs
│   └── ServiceLocator.cs
│
├── GameFlow/
│   ├── GameState.cs
│   ├── BattleState.cs
│   └── ResultState.cs
│
├── Player/
│   ├── PlayerController.cs
│   ├── PlayerStats.cs
│   └── PlayerAttack.cs
│
├── Enemy/
│   ├── EnemyController.cs
│   ├── EnemySpawner.cs
│   └── EnemyStats.cs
│
├── Combat/
│   ├── Damageable.cs
│   ├── DamageData.cs
│   └── HitDetector.cs
│
├── Skill/
│   ├── SkillBase.cs
│   ├── SkillManager.cs
│   └── SkillData.cs
│
├── Item/
│   ├── DropItem.cs
│   └── ItemData.cs
│
├── Camp/
│   ├── CampManager.cs
│   └── CampFacilityData.cs
│
├── UI/
│   ├── UIManager.cs
│   ├── LobbyUI.cs
│   ├── BattleUI.cs
│   └── ResultUI.cs
│
├── Data/
│   ├── CharacterData.cs
│   ├── EnemyData.cs
│   ├── StageData.cs
│   └── GameDatabase.cs
│
└── Save/
    ├── SaveManager.cs
    └── SaveData.cs
```

---

## 13. 데이터 관리 방식

초기 MVP에서는 `ScriptableObject` 기반 데이터 관리를 사용한다.

대상 데이터:

```text
CharacterData
SkillData
EnemyData
ItemData
StageData
CampFacilityData
```

### CharacterData 예시

```csharp
using UnityEngine;

[CreateAssetMenu(menuName = "ReCamp/Data/Character")]
public class CharacterData : ScriptableObject
{
    public string characterId;
    public string displayName;
    public int maxHp;
    public float moveSpeed;
    public int attackPower;
    public Sprite portrait;
}
```

초기에는 ScriptableObject가 가장 빠르다.  
데이터가 많아지면 CSV, Google Sheet, JSON 방식으로 확장한다.

---

## 14. 초기 작업 순서

```text
1. 저장소 생성
2. Unity에서 ReCamp 프로젝트 생성
3. Unity 프로젝트 폴더에 .gitignore 추가
4. Git LFS 초기화
5. README.md 추가
6. docs/와 tables/ 추가
7. 첫 커밋 생성
8. develop 브랜치 생성
9. M0 프로젝트 세팅 Issue 생성
10. feature/project-setup 브랜치에서 작업 시작
```

첫 커밋 예시:

```text
chore: initialize ReCamp Unity project
```

문서 커밋 예시:

```text
docs: add initial game design documents
```

개발 시작 커밋 예시:

```text
feat: add bootstrap scene flow
```

---

## 15. 최종 개발 방향

```text
저장소:
GitHub 단일 저장소

브랜치:
main / develop / feature/*

문서:
docs/에 기획서와 개발 문서 보관

데이터:
tables/에는 md 테이블
Unity 내부에는 ScriptableObject

아트:
art_refs/에는 레퍼런스
Assets/_ReCamp/Art에는 실제 사용 리소스

개발 목표:
전투 1판이 완전히 돌아가는 MVP부터 구현
```

---

## 16. Re:Camp 초기 개발 순서

```text
1. 저장소 세팅
2. Unity 프로젝트 세팅
3. 씬 흐름 구성
4. 플레이어 이동
5. 몬스터 스폰
6. 기본 전투
7. 자원 획득
8. 결과 화면
9. 캠프 성장
10. 저장 기능
```

이 순서대로 개발하면 기획서에서 실제 구현까지 자연스럽게 이어진다.
