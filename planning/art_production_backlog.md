# Re:Camp Art Production Backlog

> 최종 갱신: 2026-07-27
> 역할: 아트 산출물 ID·상태·선행 조건·완료 증거

전역 비주얼·로스터·허용 비율은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`, 캐릭터별 훅·목표는 `CHARACTER_BIBLE.md`, 고정·가변 요소는 `CHARACTER_ANCHOR_SPEC.md`가 소유한다. 이 Backlog는 해당 값을 복제하지 않는다.

전체 우선순위는 `planning/sprint_backlog.md`를 따른다.

## ART-00. 방향·관리

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-0001 | Art Direction | Done | 표현 규칙의 단일 소유 문서 존재 |
| ART-0002 | Character Bible | Done | 캐릭터별 훅·성격·관계·개별 목표 소유 |
| ART-0003 | 역사 라인업 이력 | Review | 상태·실패 원인 보존, 제작 기준 사용 금지 |
| ART-0004 | MCP 제작·승인 가이드 | Done | 도구 역할과 승인 절차 정의 |
| ART-0005 | 자산 구조·상태·이름 | Done | WIP/REVIEW/APPROVED와 경로 정의 |
| ART-0006 | AI metadata 양식 | Done | 생성·수정·권리·유사성 필드 정의 |
| ART-0007 | Git LFS 검증 | Done | 대상 확장자 속성 검증 |
| ART-0008 | 과거 손상 자산 처리 | Blocked | 유효 원본 확보 또는 영구 이력 보존 결정 |
| ART-0009 | 전역 기준 단일화 | Done | 전역 결정은 Baseline, 세부는 소유 문서로 분리 |

## ART-01. 제작 파이프라인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-0101 | 현재 이미지 도구 반복 워크플로 | Review | 동일 앵커·metadata·회귀 조건으로 반복 가능 |
| ART-0102 | 캐릭터 Anchor·metadata 규칙 | Done | LOCKED/CONTROLLED/FORBIDDEN 정의 |
| ART-0103 | Figma 제작 시트 템플릿 | Review | 템플릿·SVG 존재, 실사용 검증 남음 |
| ART-0104 | Blender 소품·FBX Export Proof | Ready | 규격 이름·소스·Export 기록 |
| ART-0105 | Unity Import·Material·Prefab Proof | Todo | 테스트 FBX가 재현 가능한 Prefab으로 동작 |
| ART-0106 | `art_source/` 구조 | Done | 편집 원본과 Export 경로 존재 |
| ART-0107 | Gate A/B/C Checklist | Done | 판정 항목·필수 증거·차단 조건 정의 |
| ART-0108 | ComfyUI 고정 워크플로 | Deferred | 실제 반복·인페인팅 병목 발생 시 Ready 전환 |
| ART-0109 | 자산·Export 명명 계약 | Done | 이름·버전·LOD·Socket·GUID 정의 |
| ART-0110 | Animation 계약 | Done | 상태·Event·장비·Import·Gate 정의 |
| ART-0111 | Figma 실사용 검증 | Review | Import·Clone·한글·PNG/PDF·사람 사용성 |
| ART-0112 | 2D→3D 변환표 샘플 | Ready | 확대·삭제·결합·물리 본 제한 필드 검증 |

## ART-10. 루나 2D 제작 시트

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1001 | 전신 WIP 후보 | Ready | Bible·Anchor 기준 후보 3안과 metadata |
| ART-1002 | 얼굴·헤어 확정 | Todo | 모든 시점에서 Anchor 회귀 통과 |
| ART-1003 | 패션·체형·실루엣 확정 | Todo | 훅과 역할이 장비 없이도 구분 |
| ART-1004 | Turnaround | Todo | Front·Side·Back 구조 일치 |
| ART-1005 | 표정 8종 | Todo | 평상시·임무 상태 대비 포함 |
| ART-1006 | 장비 상세 | Todo | 대표 장비의 구조·접힘·발광·Socket 정의 |
| ART-1007 | 컬러·재질표 | Todo | Art Direction·Anchor와 일치 |
| ART-1008 | 2D→3D 변환표 | Todo | 개별 목표와 단순화 근거 기록 |
| ART-1009 | 2D 제작 시트 승인 | Todo | Gate A/B와 사람 승인·Approved 경로 |

## ART-11. 미유 2D 제작 시트

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1101 | 전신 WIP 후보 | Ready | Bible·Anchor 기준 후보 3안과 metadata |
| ART-1102 | 얼굴·헤어 확정 | Todo | 모든 시점에서 Anchor 회귀 통과 |
| ART-1103 | 패션·체형·실루엣 확정 | Todo | 훅과 역할이 장비 없이도 구분 |
| ART-1104 | Turnaround | Todo | 캐릭터·드론 방향과 구조 일치 |
| ART-1105 | 표정 8종 | Todo | 캐릭터와 드론 감정 표현 포함 |
| ART-1106 | 장비 상세 | Todo | 드론·건틀릿·공구 구조 정의 |
| ART-1107 | 컬러·재질표 | Todo | Art Direction·Anchor와 일치 |
| ART-1108 | 2D→3D 변환표 | Todo | 개별 목표와 단순화 근거 기록 |
| ART-1109 | 2D 제작 시트 승인 | Todo | Gate A/B와 사람 승인·Approved 경로 |

## ART-12. 코코 2D 제작 시트

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1201 | 전신 WIP 후보 | Ready | Bible·Anchor 기준 후보 3안과 metadata |
| ART-1202 | 얼굴·헤어 확정 | Todo | 모든 시점에서 Anchor 회귀 통과 |
| ART-1203 | 패션·체형·실루엣 확정 | Todo | 구조대 훅과 서포터 역할 구분 |
| ART-1204 | Turnaround | Todo | 케이프·하네스·장비 구조 일치 |
| ART-1205 | 표정 8종 | Todo | 다정함·현장 지휘 대비 포함 |
| ART-1206 | 장비 상세 | Todo | 인젝터·의료 팩·보호막 구조 정의 |
| ART-1207 | 컬러·재질표 | Todo | Art Direction·Anchor와 일치 |
| ART-1208 | 2D→3D 변환표 | Todo | 개별 목표와 단순화 근거 기록 |
| ART-1209 | 2D 제작 시트 승인 | Todo | Gate A/B와 사람 승인·Approved 경로 |

## ART-13. 이리스 2D 제작 시트

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1301 | 전신 WIP 후보 | Ready | Bible·Anchor 기준 후보 3안과 metadata |
| ART-1302 | 얼굴·헤어 확정 | Todo | 모든 시점에서 Anchor 회귀 통과 |
| ART-1303 | 패션·체형·실루엣 확정 | Todo | 관측 장비·저격수 훅 구분 |
| ART-1304 | Turnaround | Todo | 코트·헤어·라이플 휴대 구조 일치 |
| ART-1305 | 표정 8종 | Todo | 임무 완벽주의·일상 반전 포함 |
| ART-1306 | 장비 상세 | Todo | 라이플·바이저·측정 모듈 정의 |
| ART-1307 | 컬러·재질표 | Todo | Art Direction·Anchor와 일치 |
| ART-1308 | 2D→3D 변환표 | Todo | 개별 목표와 단순화 근거 기록 |
| ART-1309 | 2D 제작 시트 승인 | Todo | Gate A/B와 사람 승인·Approved 경로 |

## ART-14. 노아 2D 제작 시트

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1401 | 전신 WIP 후보 | Ready | Bible·Anchor 기준 후보 3안과 metadata |
| ART-1402 | 얼굴·헤어 확정 | Todo | 모든 시점에서 Anchor 회귀 통과 |
| ART-1403 | 패션·체형·실루엣 확정 | Todo | 수호자 훅과 방패 없이도 체형·자세 구분 |
| ART-1404 | Turnaround | Todo | 의상·방패 접힘 구조 일치 |
| ART-1405 | 표정 8종 | Todo | 무뚝뚝함·배려·전투 집중 포함 |
| ART-1406 | 장비 상세 | Todo | 방패 전개·충격 흡수·통신 모듈 정의 |
| ART-1407 | 컬러·재질표 | Todo | Art Direction·Anchor와 일치 |
| ART-1408 | 2D→3D 변환표 | Todo | 개별 목표와 단순화 근거 기록 |
| ART-1409 | 2D 제작 시트 승인 | Todo | Gate A/B와 사람 승인·Approved 경로 |

## ART-15. 5인 교차 리뷰

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1501 | 후보 일관성 리뷰 | Todo | 5명 훅·얼굴·체형·패션·실루엣·팔레트·장비 구분 |
| ART-1502 | 작은 얼굴·실루엣·저채도 리뷰 | Todo | 장비 포함·제거 상태에서 5/5 식별 |
| ART-1503 | 외부 IP 유사성 리뷰 | Todo | 직접 복제 없음과 차별화 기록 |
| ART-1504 | 최종 라인업 비교 시트 | Todo | Approved 시트와 변환표를 한 화면에서 비교 |

## ART-20. 공용 3D·루나 Proof

| ID | 작업 | 상태 | 선행 조건 | 완료 기준 |
|---|---|---|---|---|
| ART-2001 | 3D·Unity Presentation 계약 | Todo | ART-1009 | 성능·Rig·LOD·Shader·ID 연결 정의 |
| ART-2002 | 공용 Base Mesh | Todo | ART-2001 | 5인 개별 목표와 체형 차이를 수용 |
| ART-2003 | 공용 Humanoid Rig | Todo | ART-2002 | Unity Avatar 정상 생성 |
| ART-2004 | Toon Shader·Material 규칙 | Todo | Unity 기반 | 얼굴·헤어·의상·장비 슬롯 정의 |
| ART-2005 | 루나 3D Blockout | Todo | ART-1009·2002 | 쿼터뷰 실루엣 검증 가능 |
| ART-2006 | 루나 Unity Gate C | Todo | ART-2005·0105 | 가독성·기능·성능·Android 증거 |
| ART-2007 | 루나 최종 모델·Texture | Todo | ART-2006 | Approved 2D와 동일 인식 |
| ART-2008 | Rig·Weight·표정 | Todo | ART-2007 | 치명적 변형·관통 없음 |
| ART-2009 | 대표 Animation | Todo | ART-2008·0110 | 계약된 Clip·Event 동작 |
| ART-2010 | VFX·Audio·Prefab | Todo | ART-2009 | 로비·선택·전투 통합 |
| ART-2011 | 사용자 매력 검증 | Todo | ART-2010 | 훅·첫인상·개선 의견 기록 |

## ART-21. 나머지 3D 캐릭터

| ID | 작업 | 상태 | 선행 조건 |
|---|---|---|---|
| ART-2101~2102 | 미유 Blockout→최종 통합 | Todo | ART-1109·2011 |
| ART-2111~2112 | 코코 Blockout→최종 통합 | Todo | ART-1209·2011 |
| ART-2121~2122 | 이리스 Blockout→최종 통합 | Todo | ART-1309·2011 |
| ART-2131~2132 | 노아 Blockout→최종 통합 | Todo | ART-1409·2011 |

## ART-30. 환경·몬스터·소품

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-3001 | 첫 환경 Color Key | Todo | 캐릭터 가독성과 환경 톤 검증 |
| ART-3002 | 첫 환경 Modular Blockout | Todo | Gray Box 대체 가능 |
| ART-3003 | 캠프 Color Key·구조 | Todo | 안전 공간과 성장 단계 표현 |
| ART-3004 | 캠프 시설 | Todo | 기능·실루엣·성장 상태 구분 |
| ART-3005 | 일반 몬스터 1차 세트 | Todo | 역할·실루엣 구분 |
| ART-3006 | 첫 보스 | Todo | 패턴·약점이 외형에서 읽힘 |
| ART-3007 | 추가 환경 | Todo | 두 번째 공간 방향 확정 |
| ART-3008 | 추가 적·보스 | Todo | 환경 전용 역할 구성 |
| ART-3009 | 자원·상자·소품 | Todo | 상호작용 식별성 확보 |

## ART-40. UI·VFX·출시 아트

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-4001 | UI Design System | Todo | Component·Token·상태 정의 |
| ART-4002 | 로비·선택 UI | Todo | 캐릭터 정보·매력·선택 상태 전달 |
| ART-4003 | 전투 HUD·스킬 UI | Todo | 모바일 입력·Safe Area·가독성 검증 |
| ART-4004 | 결과·캠프 UI | Todo | 보상·성장 피드백 전달 |
| ART-4005 | 캐릭터별 VFX 언어 | Todo | 색·형태·기능 구분 |
| ART-4006 | HUD 초상화 세트 | Todo | 작은 크기에서 5/5 식별 |
| ART-4007 | 로고·스토어 Key Art | Todo | 제품 메시지 전달 |
| ART-4008 | 출시 아트 리뷰 | Todo | WIP 제거·라이선스·metadata·유사성 통과 |

## Metadata 필수 항목

- Asset Name·Subject·Purpose·Status.
- Generated Date·Tool/Model·Workflow Version·Seed.
- Input References·Human Edits·Usage Restriction·Reviewer.
- Character/Art owning document references.
- External-IP Similarity.
- 2D to 3D Simplification when applicable.

빈 이미지, 워터마크, 권리 불명 자산, companion metadata가 없는 생성물은 Review 후보로 올리지 않는다.
