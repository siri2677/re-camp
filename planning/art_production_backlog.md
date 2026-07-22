# Re:Camp Art Production Backlog

이 문서는 Re:Camp 아트 제작의 세부 작업·상태·선행 조건을 관리한다.

## 상태

`Todo`, `Ready`, `In Progress`, `Review`, `Blocked`, `Done`을 사용한다. 이미지·모델 자산은 `WIP`, `REVIEW`, `APPROVED`, `SUPERSEDED`, `ARCHIVE` 상태를 기록한다.

## ART-DIR. 방향과 관리

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| PROJ-0004 | 캐릭터 5명 설정 통일 | High | Done | Character Bible·Table 일치 |
| PROJ-0005 | 통합 라인업 방향 승인 | High | Done | 역할·색상·무기·큰 실루엣 승인 |
| PROJ-0007 | Git LFS 아트 규칙 검증 | High | Ready | blend·fbx·psd·tga·exr 확인 |
| PROJ-0008 | AI 생성 자산 Metadata Template | Medium | Ready | 도구·모델·Seed·입력·수정·라이선스 양식 |
| PROJ-0009 | 현재 기준 문서 통합 | High | Review | Android 플랫폼·도구·범위 충돌 없음 |
| PROJ-0011 | 유료 Aura 의존 제거 | High | Review | 필수 아트 파이프라인에서 Aura 작업 없음 |
| PROJ-0012 | Android-first 아트 기준 | High | Review | 실기기 결과가 Windows 결과보다 우선 |

## ART-PIPE. 제작 파이프라인

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-PIPE-0101 | ComfyUI 루나 반복 생성 Workflow | High | Ready | PROJ-0005 | 얼굴·헤어·후드·재킷·단검 유지 출력 3회 |
| ART-PIPE-0102 | 캐릭터 변수·Seed·Metadata | High | Blocked | ART-PIPE-0101, PROJ-0008 | YAML·Prompt·Workflow 기록 |
| ART-PIPE-0103 | Figma 캐릭터 Sheet·Mobile UI Template | High | Ready | 없음 | 제작 시트·Landscape·Safe Area Frame |
| ART-PIPE-0104 | Blender MCP Export Proof | High | Ready | 없음 | 단검 또는 테스트 소품 FBX |
| ART-PIPE-0105 | Coplay Import·Prefab Proof | High | Blocked | DEV-0101, ART-PIPE-0104 | Import·Material·Prefab·Android Test Scene |
| ART-PIPE-0106 | Import Preset·Validation Editor Tool | High | Blocked | DEV-0101, ART-PIPE-0104 | Scale·Rig·Material·Socket·Android Override 검사 |
| ART-PIPE-0107 | Android 실기기 Art QA | High | Blocked | ART-PIPE-0105, ART-PIPE-0106, DEV-0117 | APK Material·LOD·실루엣·Profiler Report |
| ART-PIPE-0108 | `art_source/` 구조 | Medium | Blocked | DEV-0101, PROJ-0007 | 원본·Export·Workflow 분리 |

### Import·Android Proof 체크

```text
FBX Scale·Axis
Texture Import·ASTC Override
Humanoid Avatar
Material·Toon Shader
Prefab Hierarchy
Animator Controller
Collider·Hitbox·Socket
Android Test Scene
Missing Reference·Console Error
Prefab Diff·PlayMode
APK Material·LOD·Memory·Frame Time
```

## ART-2D-10. 루나

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-2D-1001 | 전신 후보 3안 | High | Blocked | ART-PIPE-0101, ART-PIPE-0102 | 유지·기능성·매력 강화 3안 |
| ART-2D-1002 | 얼굴·헤어 승인 | High | Blocked | ART-2D-1001 | 정면·3/4 동일 인상 |
| ART-2D-1003 | 의상·실루엣 승인 | High | Blocked | ART-2D-1001 | 후드·단검·정찰 장비 식별 |
| ART-2D-1004 | Front·Side·Back·Turnaround | High | Blocked | ART-2D-1002, ART-2D-1003 | 구조·길이 일치 |
| ART-2D-1005 | 표정 8종 | Medium | Blocked | ART-2D-1002 | 기본·미소·장난·놀람·진지·화남·슬픔·당황 |
| ART-2D-1006 | 단검·탐지 장치 Sheet | High | Blocked | ART-2D-1003 | 크기·Grip·장착 위치·발광 구조 |
| ART-2D-1007 | 컬러·재질표·3D Notes | High | Blocked | ART-2D-1004, ART-2D-1006 | 민트·크림·핑크·재질 규칙 |
| ART-2D-1008 | 루나 제작 시트 Approved | High | Blocked | ART-2D-1004~1007 | Android 모델링 기준 사용 가능 |
| ART-2D-1009 | Android Readability Sheet | High | Blocked | ART-2D-1008, DEV-0108 | 기본 거리 강조·제거 요소 기록 |

## ART-2D-11. 나머지 캐릭터 방향

루나 Proof 전에는 최종 Turnaround 세트를 만들지 않고 단독 방향과 위험 요소만 정리한다.

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-2D-1101 | 미유 단독 전신 방향 | Medium | Ready | 드론·건틀릿·라일락 실루엣 |
| ART-2D-1201 | 코코 단독 전신 방향 | Medium | Ready | 의료 장비·보호막·코랄 실루엣 |
| ART-2D-1301 | 이리스 단독 전신 방향 | Medium | Ready | 라이플·바이저·긴 실루엣 |
| ART-2D-1401 | 노아 단독 전신 방향 | Medium | Ready | 대형 방패·방호 장비·안정적 실루엣 |
| ART-2D-1501 | 5인 신장·색상·실루엣 비교 | Medium | Todo | 모바일 화면에서 역할 구분 |

## ART-3D. 루나 Character Proof

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-3D-2001 | Character 3D Spec 리뷰 | High | Review | DEV-0108 | 비율·Android Camera·성능 기준 |
| ART-3D-2002 | 공용 5~6등신 Base Mesh | High | Blocked | ART-2D-1008, ART-3D-2001 | 다른 캐릭터 재사용 가능 |
| ART-3D-2003 | 공용 Humanoid Rig 초안 | High | Blocked | ART-3D-2002 | Unity Avatar 생성 |
| ART-3D-2004 | 루나 저해상도 Blockout | High | Blocked | ART-2D-1008, ART-3D-2002 | 후드·단검·비율 확인 |
| ART-3D-2005 | Coplay Import·Prefab | High | Blocked | ART-3D-2004, ART-PIPE-0105 | Prefab·Material·Animator 구성 |
| ART-3D-2006 | Validation Tool·Android QA | High | Blocked | ART-3D-2005, ART-PIPE-0106~0107 | Import·APK·Console·LOD 통과 |
| ART-3D-2007 | 모바일 쿼터뷰 실루엣 승인 | High | Blocked | ART-3D-2006, DEV-0108 | Android 기본 거리 후드·단검 식별 |
| ART-3D-2010 | 최종 모델·Retopology·UV | High | Blocked | ART-3D-2007 | 승인 시트 일치 |
| ART-3D-2011 | Texture·Material·Toon Shader | High | Blocked | ART-3D-2010 | Android Low에서도 인상 유지 |
| ART-3D-2012 | Rig·Weight·BlendShape | High | Blocked | ART-3D-2011 | 치명적 변형 없음 |
| ART-3D-2013 | 공용 Animation 적용 | High | Blocked | ART-3D-2012 | Idle·Run·Hit·Down |
| ART-3D-2014 | 루나 고유 Animation | High | Blocked | ART-3D-2013, CHR-PROT-0310 | Attack·Dash·Skill·Victory |
| ART-3D-2015 | 물리 Bone·Collider·LOD | High | Blocked | ART-3D-2014 | Android 품질 단계·관통 기준 |
| ART-3D-2016 | 최종 Prefab 통합 | High | Blocked | ART-3D-2015, ART-VFX-5002 | Lobby·Battle APK 정상 |
| ART-3D-2020 | 루나 Character Proof 승인 | High | Blocked | ART-3D-2016, TEST-4002 | 2D·3D·Android 매력 검증 |

## ART-ENV. 환경·몬스터·소품

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-ENV-3001 | 버려진 거리 Color Key | High | Ready | 없음 | 자연 침식·모바일 캐릭터 가독성 |
| ART-ENV-3002 | 버려진 거리 Modular Kit | High | Blocked | DEV-0101, ART-ENV-3001 | Gray Box 대체·Android LOD 가능 |
| ART-ENV-3003 | 캠프 Color Key·구조 | High | Ready | 없음 | 안전하고 따뜻한 분위기 |
| ART-ENV-3004 | 캠프 시설 3종 | High | Blocked | ART-ENV-3003, DEV-0101 | 발전기·작업대·식량 창고 |
| ART-ENV-3005 | 일반 몬스터 3종 | High | Blocked | GAME-0204, ART-PIPE-0101 | 역할·실루엣·공격 준비 구분 |
| ART-ENV-3006 | 보스 1종 | High | Blocked | GAME-0205, ART-PIPE-0101 | 패턴·약점이 작은 화면에서 읽힘 |
| ART-ENV-3007 | 자원·상자·소품 세트 | Medium | Blocked | DEV-0101 | 상호작용 상태 식별 |
| ART-ENV-3010 | 폐쇄된 연구소 Color Key·Kit | Low | Blocked | VS-6005 | Full Release 단계 |
| ART-ENV-3011 | 추가 적 3종·보스 1종 | Low | Blocked | VS-6005 | Full Release 단계 |

## ART-UI. Android UI

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-UI-4001 | Mobile UI Design System | High | Ready | ART-PIPE-0103 | Color·Type·Spacing·Touch Button·Panel |
| ART-UI-4002 | Lobby·Exploration Ready | High | Blocked | GAME-0201, ART-UI-4001 | 캐릭터·캠프·탐험 시작 |
| ART-UI-4003 | Touch Battle HUD | High | Blocked | MOB-0251~0253, ART-UI-4001 | HP·시간·목표·스킬·귀환 |
| ART-UI-4004 | Skill Select | High | Blocked | GAME-0203, ART-UI-4001 | 3개 선택지·현재 빌드 |
| ART-UI-4005 | Result | High | Blocked | GAME-0209, ART-UI-4001 | 자원·생존·종료 원인 |
| ART-UI-4006 | Camp Upgrade | High | Blocked | GAME-0210, ART-UI-4001 | 비용·효과·강화 피드백 |
| ART-UI-4007 | Pause·Settings | Medium | Blocked | MOB-0254~0256, ART-UI-4001 | 음량·진동·그래픽·Camera Shake |
| ART-UI-4008 | Touch Tutorial | High | Blocked | ART-UI-4003, GAME-0212 | 이동·공격·대시·스킬·귀환 이해 |
| ART-UI-4009 | 화면비·Safe Area Matrix | High | Blocked | DEV-0105, ART-UI-4001 | 16:9~20:9 잘림·겹침 없음 |

## ART-VFX. VFX·Feedback

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-VFX-5001 | 공통 VFX 언어 | High | Ready | GAME-0203 | 공격·위험·회복·자원 구분 |
| ART-VFX-5002 | 루나 공격·스킬 VFX | High | Blocked | ART-3D-2014, ART-VFX-5001 | 단검·Dash·Scan·Cross Fang |
| ART-VFX-5003 | 적 위험·피격·사망 VFX | High | Blocked | ART-ENV-3005, GAME-0206 | Telegraph·Hit 구분 |
| ART-VFX-5004 | 자원·귀환·성장 VFX | Medium | Blocked | GAME-0207, GAME-0210 | 보상·성장 피드백 |
| ART-VFX-5005 | Android 품질 단계·성능 | High | Blocked | ART-VFX-5002~5004 | Low·Medium·High 가독성·Overdraw 통과 |

## 현재 바로 가능한 작업

```text
PROJ-0007 Git LFS 검증
PROJ-0008 Metadata Template
ART-PIPE-0101 ComfyUI Workflow
ART-PIPE-0103 Figma Sheet·Mobile UI Template
ART-PIPE-0104 Blender Export Proof
ART-2D-1101~1401 나머지 캐릭터 단독 방향
ART-ENV-3001 버려진 거리 Color Key
ART-ENV-3003 캠프 Color Key
ART-UI-4001 Mobile UI Design System
ART-VFX-5001 공통 VFX 언어
```

## 운영 원칙

- Android 실기기 결과가 Windows PlayMode 결과보다 우선
- 루나 Proof 전 나머지 캐릭터 최종 제작 금지
- 승인 자산만 최종 APK에 사용
- 모든 결과에 파일 경로·도구·기기·품질 설정·검증·Commit 기록
