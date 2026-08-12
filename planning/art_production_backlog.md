# Re:Camp Current Generation Art Production Backlog

> 최종 갱신: 2026-08-10
> 역할: 아트 산출물 ID·상태·선행 조건·완료 증거

전역 로스터·비율·플랫폼·Production Budget은 Canonical Baseline, 캐릭터별 디자인 내용은 Character Bible/Anchor가 소유한다. 이 Backlog는 **무엇을 만들었고 어떤 증거가 필요한지**만 기록한다.

전체 실행 우선순위는 `planning/sprint_backlog.md`를 따른다.

## ART-00 — 방향·관리

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| ART-0001 | Current 공통 Art Direction | Done | 공통 표현 규칙 소유 문서 존재 |
| ART-0002 | Current Character Bible | Done | 캐릭터별 고유 설정 소유 문서 존재 |
| ART-0003 | Legacy/Historical 아트 분리 | Done | Current 제작 앵커와 분리됨 |
| ART-0004 | 제작·승인 가이드 | Done | 도구 역할·Gate·사람 승인 절차 정의 |
| ART-0005 | 자산 상태·디렉터리·이름 | Done | WIP/REVIEW/APPROVED와 경로 정의 |
| ART-0006 | 생성 metadata | Done | Tool·Input·Edit·Rights·Similarity 필드 |
| ART-0007 | Git LFS | Done | 대상 자산 속성 검증 |
| ART-0008 | 손상/과거 Raw 자산 | Blocked | 유효 원본 확보 또는 역사 보존 결정 |
| ART-0009 | Current 문서 소유권 | In Progress | 중복 전역 결정 제거와 validator 통과 |

## ART-01 — 제작 Pipeline

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| ART-0101 | 통제 후보 생성 Workflow | In Progress | 동일 조건 후보와 metadata 반복 가능 |
| ART-0102 | Character Anchor | Done | 캐릭터별 LOCKED/CONTROLLED/OPEN/FORBIDDEN 정의 |
| ART-0103 | 제작 시트 Template | Review | 실제 Import·Clone·Export 검증 |
| ART-0104 | Blender 소품 Export Proof | Ready | Source·FBX·Manifest 기록 |
| ART-0105 | Unity Import·Material·Prefab Proof | Todo | 테스트 자산 재현 가능 |
| ART-0106 | `art_source/` 구조 | Done | 편집 원본·Export 경로 존재 |
| ART-0107 | Gate A/B/C Checklist | Done | 판정 항목·증거·차단 조건 정의 |
| ART-0108 | ComfyUI 고정 Workflow | Deferred | 실제 반복/인페인팅 병목 시 재평가 |
| ART-0109 | Asset/Export Naming | Done | Version·LOD·Socket·GUID 규칙 |
| ART-0110 | Animation Handoff | Review | Current/Legacy 경계·공용/고유 Motion 계약 확인 |
| ART-0111 | 제작 시트 실사용 검증 | Review | 한글·이미지 교체·PNG/PDF·사용성 |
| ART-0112 | 2D→3D 변환표 Proof | Review | CH101~CH105 통합 변환표 Proof와 CHA-B01~B10 문서 감사 완료; 실제 3D/Unity 증거는 미실시 |

## 캐릭터별 2D 작업

각 캐릭터의 ID, 이름, 훅, 외형은 이 Backlog가 아니라 Canonical Baseline과 Character Bible/Anchor를 따른다.

### ART-10 — CH101

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| ART-1001 | 전신 후보 3안 | In Progress | 동일 Character Anchor로 3안 + metadata |
| ART-1002 | 얼굴·헤어 선택 | Done | 128px 얼굴 비교 + 사람 선택 |
| ART-1003 | 패션·체형·실루엣 | Done | 장비 on/off 비교 |
| ART-1004 | Turnaround | Done | Front·Side·Back 일치 |
| ART-1005 | 표정 시트 | Done | 평상시·임무 대비 포함 |
| ART-1006 | 대표 장비 상세 | Done | 구조·활성 상태·Socket·단순화 기록 |
| ART-1007 | 컬러·재질 | Done | 공통 Art Direction과 일치 |
| ART-1008 | 2D→3D 변환표 | Done | 확대·삭제·결합·물리 제거 |
| ART-1009 | 사람 Gate A | Done | 승인 기록과 Approved 경로 |

### ART-11 — CH102

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| ART-1101 | 전신 후보 3안 | Done | A/B/C unified character sheet approved + metadata |
| ART-1102 | 얼굴·헤어 선택 | Done | Face128 evidence and unified identity approved |
| ART-1103 | 패션·체형·실루엣 | Done | Equipment ON/OFF and state silhouette evidence approved |
| ART-1104 | Turnaround | Review | CH102 Front·Side·Back review asset assembled; 3D cross-check remains |
| ART-1105 | 표정 시트 | Review | CH102 six-expression review asset assembled; deformation proof remains |
| ART-1106 | 대표 장비 상세 | Review | CH102 bow state/detail review asset assembled; socket proof remains |
| ART-1107 | 컬러·재질 | Review | CH102 palette/material review asset assembled; shader proof remains |
| ART-1108 | 2D→3D 변환표 | Review | CH102 state-aware translation contract ready for Gate B review |
| ART-1109 | 사람 Gate A | Done | Approval record and APPROVED path |

### ART-12 — CH103

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| ART-1201 | 전신 후보 3안 | Done | CH103 morning-roster A/B/C state board + current 2D evidence approval |
| ART-1202 | 얼굴·헤어 선택 | Done | CH103 Face128-equivalent identity board + human confirmation |
| ART-1203 | 패션·체형·실루엣 | Done | CH103 ON/OFF/LOW-SAT silhouette evidence + human confirmation |
| ART-1204 | Turnaround | Review | CH103 front·side·back review asset and identity continuity assembled; 3D cross-check remains |
| ART-1205 | 표정 시트 | Review | CH103 six-expression review asset assembled; deformation proof remains |
| ART-1206 | 대표 장비 상세 | Review | CH103 baton/veil structure, activation, socket proposal, simplification record assembled |
| ART-1207 | 컬러·재질 | Review | CH103 palette, material separation, and low-saturation review assembled; shader proof remains |
| ART-1208 | 2D→3D 변환표 | Review | CH103 translation contract assembled; Gate B technical proof remains open |
| ART-1209 | 사람 Gate A | Done | Approval record and APPROVED path |

### ART-13 — CH104

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| ART-1301 | 전신 후보 3안 | Done | CH104 morning-roster A/B/C state board + current 2D package approval |
| ART-1302 | 얼굴·헤어 선택 | Done | CH104 Face128-equivalent identity board + human confirmation |
| ART-1303 | 패션·체형·실루엣 | Done | CH104 ON/OFF/LOW-SAT silhouette evidence + human confirmation |
| ART-1304 | Turnaround | Review | CH104 front/back/side turnaround asset and companion records assembled from approved sheet; 3D cross-check remains |
| ART-1305 | 표정 시트 | Review | CH104 six-expression review asset assembled; identity continuity and deformation proof remain |
| ART-1306 | 대표 장비 상세 | Review | CH104 prism-fan/map-ring structure, state, provisional socket, and simplification review assembled |
| ART-1307 | 컬러·재질 | Review | CH104 palette roles, material separation, and low-saturation review assembled; shader proof remains |
| ART-1308 | 2D→3D 변환표 | Review | CH104 translation contract, Gate B preflight, and handoff assembled; technical proof remains open |
| ART-1309 | 사람 Gate A | Done | Approval record and APPROVED 2D production-sheet path |

### ART-14 — CH105

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| ART-1401 | 전신 후보 3안 | Review | CH105 오전 로스터 5번째 인물 기준 A/B/C 상태 후보 보드와 통합 CharacterSheet REVIEW assembled; Gate A 리뷰 대기 |
| ART-1402 | 얼굴·헤어 선택 | Review | CH105 Face128-equivalent 보드 연결; 동일 스케일 사람 검토 남음 |
| ART-1403 | 패션·체형·실루엣 | Review | CH105 장비 ON/OFF/LOW-SAT 보드 연결; 동일 스케일 사람 검토 남음 |
| ART-1404 | Turnaround | Review | CH105 front·side·back continuity is assembled in the unified character-sheet REVIEW package; 3D cross-check remains open |
| ART-1405 | 표정 시트 | Review | CH105 six-expression identity board assembled; deformation and human review remain open |
| ART-1406 | 대표 장비 상세 | Review | CH105 single anchor-ring/gauntlet structure, A/B/C state, provisional planning labels, and simplification review assembled |
| ART-1407 | 컬러·재질 | Review | CH105 source-faithful palette roles, material separation, and low-saturation review assembled; shader proof remains open |
| ART-1408 | 2D→3D 변환표 | Review | CH105 keep/enlarge/simplify/remove, provisional socket, material category, state, and no-physics contract recorded; technical proof remains open |
| ART-1409 | 사람 Gate A | Review | CH105 전체 2D 패키지 검토 요청서와 승인 경계를 정리함; 사용자 결정 대기, 별도 APPROVED 산출물은 아직 없음 |

## ART-15 — 5인 교차 리뷰

| ID | 작업 | 상태 | 완료 조건 |
|---|---|---|---|
| ART-1501 | 후보 일관성 리뷰 | Review | 현재 로스터 전용 CH101~CH105 교차 검토 패키지 연결; 최종 5/5 사람 판정 대기 |
| ART-1502 | 128px·실루엣·저채도 리뷰 | Review | 현재 로스터 전용 exact 128px 얼굴·장비 OFF·저채도 근거 연결; 동일 스케일 5/5 사람 판정 대기 |
| ART-1503 | 외부 IP 유사성 리뷰 | Review | 현재 CH101~CH105 원작성 사전 점검과 외부/법률 검토 경계를 기록함; 정식 clearance는 미실시 |
| ART-1504 | 최종 비교 시트 | Review | 오전 로스터 기반 CH101~CH105 비교 시트와 metadata/review 연결; 5인 사람 판정 및 CH105 Gate A 대기 |

## ART-20 — CH101 3D Character Proof

| ID | 작업 | 상태 | 선행 조건 |
|---|---|---|---|
| ART-2001 | 3D Presentation 계약 | Done | ART-1009 |
| ART-2002 | 공용 Base/Rig Proof | Todo | ART-2001 |
| ART-2003 | 공용 Toon Material | Todo | ART-2001 |
| ART-2004 | 공용 Animator/Prefab | Todo | ART-2002 |
| ART-2005 | CH101 Blockout | Todo | ART-1008~1009 |
| ART-2006 | Gate B/C·Android Proof | Todo | ART-2005 |
| ART-2007 | 최종 Model·Texture | Todo | ART-2006 |
| ART-2008 | Rig·Weight·표정 | Todo | ART-2007 |
| ART-2009 | 대표 Animation | Todo | ART-2008 |
| ART-2010 | VFX·Audio·Prefab | Todo | ART-2009 |
| ART-2011 | 사용자 첫인상 검증 | Todo | ART-2010 |

## ART-21 — 나머지 3D 캐릭터

| ID | 작업 | 상태 | 선행 조건 |
|---|---|---|---|
| ART-2101~2102 | CH102 Blockout→통합 | Todo | CH102 Gate A + CH101 Proof |
| ART-2111~2112 | CH103 Blockout→통합 | Todo | CH103 Gate A + CH101 Proof |
| ART-2121~2122 | CH104 Blockout→통합 | Todo | CH104 Gate A + CH101 Proof |
| ART-2131~2132 | CH105 Blockout→통합 | Todo | CH105 Gate A + CH101 Proof |

## ART-30 — 환경·몬스터·소품

| ID | 작업 | 상태 |
|---|---|---|
| ART-3001~3002 | 첫 환경 Color Key·Modular Set | Todo |
| ART-3003~3004 | 캠프 Color Key·핵심 시설 | Todo |
| ART-3005 | 첫 일반 적 세트 | Todo |
| ART-3006 | 첫 보스 | Todo |
| ART-3007~3008 | 추가 환경·적·보스 | Todo |
| ART-3009 | 자원·상자·공용 소품 | Todo |

## ART-40 — UI·VFX·출시 아트

| ID | 작업 | 상태 |
|---|---|---|
| ART-4001 | UI Design System | Todo |
| ART-4002 | 로비·선택 UI | Todo |
| ART-4003 | 전투 HUD | Todo |
| ART-4004 | 결과·캠프 UI | Todo |
| ART-4005 | 캐릭터 VFX Language | Todo |
| ART-4006 | Portrait/Icon | Todo |
| ART-4007 | Logo·Store Key Art | Todo |
| ART-4008 | 출시 아트 리뷰 | Todo |

## 공통 완료 증거

- Source·Export·Runtime 경로.
- Asset Version·Status.
- Tool/Model/Workflow·Input Reference.
- Human Edit·Reviewer·Date.
- Gate 결과와 수정 이력.
- External-IP Similarity.
- 2D→3D Simplification when applicable.

이 Backlog에 캐릭터 세부 디자인을 복사하지 않는다. 각 작업은 실행 시 Canonical Baseline과 해당 Character Bible/Anchor를 읽는다.
