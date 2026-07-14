# Re:Camp Integrated Sprint Backlog

이 문서는 실제 개발을 시작할 때 가장 먼저 확인하는 통합 작업 목록이다.

상태는 `Todo`, `Ready`, `In Progress`, `Review`, `Blocked`, `Done`을 사용한다.

## 현재 우선 실행 순서

```text
1. 통합 캐릭터 라인업 검토 및 수정 방향 확정
2. Unity 프로젝트 생성과 Git 반영
3. 기존 ReCamp.Core의 Unity 통합 방식 검증
4. Lobby → Battle → Result → Lobby Gray Box 구현
5. 캐릭터 5명 전투 프로토타입 구현
6. 캐릭터 5명 단독 2D 콘셉트 제작 시작
7. 루나 Character Proof와 Vertical Slice 제작
```

---

## Sprint 0. 저장소·기획·아트 방향

### 목표

개발과 아트 제작을 시작할 수 있는 기준 문서와 저장소 구조를 준비한다.

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| RC-0001 | GitHub 저장소 초기화 | High | Done |
| RC-0002 | README.md 작성 | High | Done |
| RC-0003 | AGENT.md 작성 | High | Done |
| RC-0004 | Unity `.gitignore` 추가 | High | Done |
| RC-0005 | Git LFS `.gitattributes` 추가 | High | Done |
| RC-0006 | 게임 콘셉트·MVP·코어 루프 문서 작성 | High | Done |
| RC-0007 | 캐릭터·스킬·몬스터·아이템·스테이지 테이블 작성 | High | Done |
| RC-0008 | 통합 캐릭터 설정과 아트 방향 작성 | High | Done |
| RC-0009 | 아트 MCP·자산 관리 가이드 작성 | Medium | Done |
| RC-0010 | `planning/` 통합 실행 계획 작성 | High | Done |
| RC-0011 | 통합 캐릭터 라인업 1차 시안 검토 | High | Review |
| RC-0012 | Git LFS 규칙을 현재 아트 구조에 맞게 검증 | High | Ready |

### 완료 기준

- `planning/`만 확인해도 다음 작업을 선택할 수 있음
- 게임·캐릭터·아트 문서 간 역할과 설정 충돌이 없음
- 통합 라인업의 승인 또는 수정 방향이 결정됨

---

## Sprint 1. Unity 프로젝트와 코어 통합 기반

### 목표

Unity 프로젝트를 생성하고 기존 게임 규칙 코어를 실제 Unity 프로젝트에 연결할 기반을 만든다.

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| DEV-0101 | Unity LTS 버전 확정 및 프로젝트 생성 | High | Ready | 없음 |
| DEV-0102 | Visible Meta Files·Force Text 설정 | High | Todo | DEV-0101 |
| DEV-0103 | `Assets/_ReCamp` 폴더 구조 생성 | High | Todo | DEV-0101 |
| DEV-0104 | `Packages`, `ProjectSettings`, `.meta` Git 반영 | High | Todo | DEV-0102 |
| DEV-0105 | Bootstrap·Title·Lobby·Battle·Result Scene 생성 | High | Todo | DEV-0103 |
| DEV-0106 | SceneLoader 구현 | High | Todo | DEV-0105 |
| DEV-0107 | Unity GameManager와 서비스 초기화 구조 구현 | High | Todo | DEV-0105 |
| DEV-0108 | `ReCamp.Core`의 Unity 런타임 호환성 검토 | High | Ready | 없음 |
| DEV-0109 | Core 소스 공유·Assembly·Adapter 방식 확정 | High | Todo | DEV-0108 |
| DEV-0110 | Core 상태를 Unity Presentation과 연결 | High | Todo | DEV-0107, DEV-0109 |
| DEV-0111 | EditMode·PlayMode 테스트 Assembly 구성 | High | Todo | DEV-0103 |
| DEV-0112 | Core 테스트와 Unity 테스트 CI 구성 | Medium | Todo | DEV-0111 |
| DEV-0113 | 기존 Unity 비종속 Core PR 검토·통합 | High | Ready | DEV-0108 |

### 아트 파이프라인 병행 작업

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| ART-0101 | ComfyUI 또는 동등한 이미지 워크플로 구성 | High | Ready | RC-0011 |
| ART-0102 | 캐릭터 일관성 변수·메타데이터 정의 | High | Todo | ART-0101 |
| ART-0103 | Figma 캐릭터 제작 시트 템플릿 구성 | High | Ready | 없음 |
| ART-0104 | Blender MCP 연결·소품 Export 검증 | Medium | Todo | 없음 |
| ART-0105 | Coplay/Aura FBX Import·Prefab 테스트 | Medium | Todo | DEV-0101, ART-0104 |
| ART-0106 | `art_source/` 디렉터리 생성 | Medium | Todo | DEV-0101 |

### 완료 기준

```text
Unity 프로젝트가 다른 환경에서 Clone 후 열림
5개 Scene이 존재함
기존 Core와 Unity의 연결 방식이 확정됨
루나 기준 이미지 반복 생성과 Figma 시트 정리가 가능함
```

---

## Sprint 2. Scene 흐름과 Gray Box 전투

### 목표

임시 모델로 Lobby → Battle → Result → Lobby 흐름과 기본 전투를 완성한다.

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| DEV-0201 | Bootstrap Scene 구성 | High | Todo | DEV-0105, DEV-0107 |
| DEV-0202 | Lobby Scene Gray Box | High | Todo | DEV-0105 |
| DEV-0203 | Battle Scene Gray Box | High | Todo | DEV-0105 |
| DEV-0204 | Result Scene Gray Box | High | Todo | DEV-0105 |
| DEV-0205 | Lobby에서 Battle 진입 | High | Todo | DEV-0106, DEV-0202 |
| DEV-0206 | Battle 종료 후 Result 이동 | High | Todo | DEV-0106, DEV-0203 |
| DEV-0207 | Result에서 Lobby 복귀 | High | Todo | DEV-0106, DEV-0204 |
| DEV-0208 | Input System과 PlayerController | High | Todo | DEV-0203 |
| DEV-0209 | 쿼터뷰 카메라와 이동 경계 | High | Todo | DEV-0208 |
| DEV-0210 | 기본 공격·Hitbox·Damageable | High | Todo | DEV-0208 |
| DEV-0211 | EnemyController와 추적 AI | High | Todo | DEV-0203 |
| DEV-0212 | EnemySpawner와 웨이브 | High | Todo | DEV-0211 |
| DEV-0213 | 몬스터 사망·보상 1회 지급 | High | Todo | DEV-0210, DEV-0212 |
| DEV-0214 | 탐험 시간·귀환·사망·만료 상태 | High | Todo | DEV-0110, DEV-0203 |
| DEV-0215 | 결과 정산과 로컬 저장 연결 | High | Todo | DEV-0110, DEV-0204 |
| TEST-0201 | Scene 흐름 PlayMode 테스트 | High | Todo | DEV-0207 |
| TEST-0202 | 전투·보상·정산 EditMode/PlayMode 테스트 | High | Todo | DEV-0215 |

### 완료 기준

- 임시 Capsule 캐릭터가 이동하고 공격 가능
- 몬스터가 스폰·추적·피격·사망함
- 자원 획득 후 결과 정산과 저장이 동작함
- Scene 흐름 자동 테스트가 통과함

---

## Sprint 3. 캐릭터 5명 전투 프로토타입

### 목표

최종 아트 제작 전에 캐릭터 5명의 전투 역할과 조작 차이를 검증한다.

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| CHR-0301 | 공용 CharacterController·Stats 구조 | High | Todo | DEV-0208, DEV-0110 |
| CHR-0302 | 캐릭터 선택과 데이터 적용 | High | Todo | CHR-0301 |
| CHR-0310 | 루나 이동·대시·근접 연속 공격 | High | Todo | CHR-0302 |
| CHR-0311 | 루나 스캔·자원 탐지 | Medium | Todo | CHR-0310 |
| CHR-0320 | 미유 드론 자동 사격 | High | Todo | CHR-0302 |
| CHR-0321 | 미유 대상 지정·오버클럭·자동 회수 | Medium | Todo | CHR-0320 |
| CHR-0330 | 코코 회복·재생 | High | Todo | CHR-0302 |
| CHR-0331 | 코코 보호막·상태 해제·손실 감소 | Medium | Todo | CHR-0330 |
| CHR-0340 | 이리스 차지 사격·약점 공격 | High | Todo | CHR-0302 |
| CHR-0341 | 이리스 보스 표식·치명타 강화 | Medium | Todo | CHR-0340 |
| CHR-0350 | 노아 정면 방어·퍼펙트 가드 | High | Todo | CHR-0302 |
| CHR-0351 | 노아 반격·방벽·밀쳐내기 | Medium | Todo | CHR-0350 |
| CHR-0360 | 캐릭터 5명 밸런스·역할 중복 검토 | High | Todo | CHR-0311~CHR-0351 |
| TEST-0301 | 캐릭터별 핵심 스킬 테스트 | High | Todo | CHR-0360 |

### 아트 동시 작업

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| ART-1001 | 루나 단독 전신 후보 제작 | High | Ready |
| ART-1101 | 미유 단독 전신 후보 제작 | High | Ready |
| ART-1201 | 코코 단독 전신 후보 제작 | High | Ready |
| ART-1301 | 이리스 단독 전신 후보 제작 | High | Ready |
| ART-1401 | 노아 단독 전신 후보 제작 | High | Ready |
| ART-1501 | 5명 후보를 함께 배치한 일관성 리뷰 | High | Todo |

### 완료 기준

- 캐릭터 5명이 임시 모델로 모두 플레이 가능
- 플레이 방식과 강점이 겹치지 않음
- 5명 모두 단독 전신 디자인 방향이 결정됨

---

## Sprint 4. 캐릭터 5명 Approved 2D 제작 시트

### 목표

다섯 캐릭터 모두 3D 모델링에 사용할 수 있는 제작 시트를 확보한다.

### 공통 작업

각 캐릭터마다 다음을 완료한다.

```text
얼굴·헤어 확정
의상·실루엣 확정
정면·측면·후면 Turnaround
표정 8종
무기·장비 상세
컬러·재질표
대표 포즈
3D 제작 주의사항
```

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| ART-4001 | 루나 2D 제작 시트 Approved | High | Todo |
| ART-4002 | 미유 2D 제작 시트 Approved | High | Todo |
| ART-4003 | 코코 2D 제작 시트 Approved | High | Todo |
| ART-4004 | 이리스 2D 제작 시트 Approved | High | Todo |
| ART-4005 | 노아 2D 제작 시트 Approved | High | Todo |
| ART-4006 | 5인 최종 라인업·색상·신장 비교 시트 | High | Todo |
| ART-4007 | 3D 모델링 가능성 리뷰 | High | Todo |

세부 작업 ID는 `planning/art_production_backlog.md`를 따른다.

### 완료 기준

5명 모두 Approved 제작 시트를 보유하고, 캐릭터 간 실루엣·색상·무기·역할이 명확히 구분된다.

---

## Sprint 5. 루나 Character Proof

### 목표

루나를 첫 번째 최종 캐릭터로 완성해 캐릭터 아트·3D·Unity 파이프라인을 검증한다.

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| ART-5001 | CHARACTER_3D_SPEC.md 작성 | High | Todo | ART-4001 |
| ART-5002 | 공용 5~6등신 Base Mesh | High | Todo | ART-5001 |
| ART-5003 | 공용 Humanoid Rig | High | Todo | ART-5002 |
| ART-5004 | 공용 툰 셰이더와 Material 규칙 | High | Todo | DEV-0101 |
| ART-5010 | 루나 3D Blockout | High | Todo | ART-4001, ART-5002 |
| ART-5011 | 루나 Unity 쿼터뷰 실루엣 검증 | High | Todo | ART-5010, ART-0105 |
| ART-5012 | 루나 최종 모델·Texture | High | Todo | ART-5011 |
| ART-5013 | 루나 Rig·Weight·표정 | High | Todo | ART-5012 |
| ART-5014 | 루나 고유 애니메이션 | High | Todo | ART-5013 |
| ART-5015 | 루나 VFX·사운드·Prefab | High | Todo | ART-5014 |
| UI-5001 | 루나 캐릭터 선택·정보·대화 UI | Medium | Todo | ART-5015 |
| TEST-5001 | 루나 실제 플레이·관통·성능 테스트 | High | Todo | ART-5015 |
| UX-5001 | 타깃 사용자 캐릭터 매력 테스트 | High | Todo | TEST-5001 |

### 완료 기준

- 일러스트와 3D가 같은 캐릭터로 보임
- 쿼터뷰에서 얼굴·후드·단검 식별 가능
- 기본 전투와 애니메이션 정상 동작
- 사용자 검증에서 개선점과 긍정 반응 기록

---

## Sprint 6. Vertical Slice

### 목표

루나와 첫 번째 스테이지를 출시 수준으로 완성한다.

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| VS-6001 | 버려진 거리 Color Key·Blockout·최종 환경 | High | Todo |
| VS-6002 | 일반 몬스터 3종 최종 제작 | High | Todo |
| VS-6003 | 첫 번째 보스 최종 제작 | High | Todo |
| VS-6004 | 캠프 시설 3종 최종 제작 | High | Todo |
| VS-6005 | 로비·전투·결과·캠프 UI | High | Todo |
| VS-6006 | 루나 스킬·VFX·타격감 폴리시 | High | Todo |
| VS-6007 | 저장·튜토리얼·설정 | High | Todo |
| VS-6008 | 사운드와 음악 1차 적용 | Medium | Todo |
| VS-6009 | 성능·메모리·로딩 최적화 | High | Todo |
| VS-6010 | 외부 Vertical Slice 테스트 | High | Todo |

### 완료 기준

외부 사용자가 캐릭터의 매력, 전투, 탐험, 귀환, 캠프 성장의 핵심 재미를 한 구간에서 경험할 수 있다.

---

## Sprint 7. 나머지 캐릭터와 전체 콘텐츠

### 목표

검증된 공용 기반으로 나머지 캐릭터와 출시 콘텐츠를 완성한다.

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| PROD-7001 | 미유 최종 모델·애니메이션·VFX | High | Todo |
| PROD-7002 | 코코 최종 모델·애니메이션·VFX | High | Todo |
| PROD-7003 | 이리스 최종 모델·애니메이션·VFX | High | Todo |
| PROD-7004 | 노아 최종 모델·애니메이션·VFX | High | Todo |
| PROD-7005 | 폐쇄된 연구소 최종 제작 | High | Todo |
| PROD-7006 | 추가 몬스터 3종·보스 1종 | High | Todo |
| PROD-7007 | 캠프 시설 4종 이상과 성장 연출 | High | Todo |
| PROD-7008 | 캐릭터 해금 임무와 친밀도 | Medium | Todo |
| PROD-7009 | 캐릭터별 대화·로비 상호작용 | Medium | Todo |
| PROD-7010 | 전체 UI·VFX·사운드 완성 | High | Todo |

### 완료 기준

5명 캐릭터, 2개 스테이지, 6종 일반 몬스터, 2종 보스와 전체 성장 루프를 처음부터 끝까지 플레이할 수 있다.

---

## Sprint 8. QA와 출시 준비

| ID | 작업 | 우선순위 | 상태 |
|---|---|---:|---|
| REL-8001 | 전체 회귀 테스트 | High | Todo |
| REL-8002 | 저장 데이터 안정화와 마이그레이션 | High | Todo |
| REL-8003 | 실제 기기·다양한 PC 사양 테스트 | High | Todo |
| REL-8004 | CPU·GPU·메모리·GC·Draw Call 최적화 | High | Todo |
| REL-8005 | 해상도·입력·키 설정 대응 | High | Todo |
| REL-8006 | 캐릭터 리깅·관통·애니메이션 폴리시 | High | Todo |
| REL-8007 | 승인되지 않은 WIP 자산 제거 | High | Todo |
| REL-8008 | 라이선스·AI 생성 메타데이터 검토 | High | Todo |
| REL-8009 | 스토어 이미지·트레일러·설명 작성 | Medium | Todo |
| REL-8010 | 체험판 또는 외부 베타 | High | Todo |
| REL-8011 | Release Candidate 승인 | High | Todo |

## Backlog 운영 규칙

- 구현 또는 아트 작업을 시작할 때 해당 ID를 `In Progress`로 바꾼다.
- 완료 결과의 커밋·PR·이미지 경로를 작업 항목 근처에 기록한다.
- 코드가 동작해도 자동 테스트 또는 직접 검증이 없으면 `Done`으로 바꾸지 않는다.
- 아트는 Approved 상태가 아니면 최종 게임 자산으로 사용하지 않는다.
- 새 업무는 구현 전에 먼저 이 문서 또는 아트 백로그에 등록한다.
