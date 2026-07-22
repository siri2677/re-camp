# Re:Camp Art Production Backlog

상세 실행 순서와 전체 우선순위는 `planning/sprint_backlog.md`를 우선한다. 이 문서는 아트 산출물을 세분화한다. `Deferred`는 기술적 차단이 아니라 필요성이 확인될 때 도입하는 선택 작업이다.

## ART-00. 방향·관리

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-0001 | 통합 Art Direction | High | Done | 2D 일반 등신·3D 4~5등신 SD-lite·쿼터뷰 문서화 |
| ART-0002 | 성인 여성 5인 Character Bible | High | Done | 캐릭터·테이블 설정 일치 |
| ART-0003 | 성인 여성 5인·남성향 라인업 `REVIEW v003` | High | Review | Gate A `FAIL` 권고 기록; 역할 모티프·얼굴·실루엣 교정 후 사람 재검토 |
| ART-0004 | MCP 제작·승인 가이드 | High | Done | 도구 역할과 승인 절차 정의 |
| ART-0005 | 자산 구조·상태·이름 규칙 | High | Done | WIP/REVIEW/APPROVED와 경로 정의 |
| ART-0006 | AI 생성 메타데이터 양식 | Medium | Done | 도구·모델·Seed·입력·수정·권리 기록 |
| ART-0007 | Git LFS 패턴·속성 검증 | High | Done | PNG·FBX·BLEND·KRA·TGA·EXR 규칙 검증 |
| ART-0008 | 원격 v001 raw PNG/LFS 교정 | Medium | Blocked | 유효 원본 확보 또는 이력 보존 결정 |

## ART-01. 제작 파이프라인

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-0101 | 현재 이미지 생성 도구 기반 반복 워크플로 | High | Review | 원본 앵커와 전원 성인 여성 회귀 조건으로 반복 가능 |
| ART-0102 | 도구 비종속 캐릭터 앵커·메타데이터 규칙 | High | Done | `CHARACTER_ANCHOR_SPEC.md`에 얼굴·헤어·실루엣·의상·장비·팔레트와 회귀 조건 확정 |
| ART-0103 | Figma 캐릭터 제작 시트 템플릿 | High | Review | `CHARACTER_SHEET_TEMPLATE_SPEC.md`·6-Frame SVG 완료, Figma Import·Component·Export 검증 필요 |
| ART-0104 | Blender MCP 소품 생성·FBX Export | Medium | Ready | ART-0109 명명 규격으로 테스트 소품 저장·Export 성공 |
| ART-0105 | FBX Import·Material·Prefab 테스트 | Medium | Todo | ART-0104·0109 결과가 Unity Prefab으로 동작 |
| ART-0106 | `art_source/` 디렉터리 | Medium | Done | figma_exports·blender·textures·comfyui_workflows 존재 |
| ART-0107 | Gate A/B/C 리뷰 체크리스트 | High | Done | `ART_REVIEW_CHECKLIST.md`를 모든 Review 자산의 공통 판정표로 사용 |
| ART-0108 | ComfyUI·ComfyUI MCP 고정 워크플로 | Low | Deferred | 대량 일관성·정밀 인페인팅·고정 Seed/LoRA/ControlNet/IP-Adapter가 병목일 때만 Ready |
| ART-0109 | `ASSET_NAMING_GUIDE.md` | High | Done | 이미지·Blender·FBX·Unity·Prefab·Material·Socket 이름과 버전·Export·GUID 규칙 확정 |
| ART-0110 | `ANIMATION_GUIDE.md` | Medium | Done | 공용/전용 상태·in-place·Animator·Event·Socket·파일·Import·Gate 규칙 확정 |

로컬 모델 보유, GPU 준비, ComfyUI 설치는 현재 완료 조건이나 개발 선행 조건이 아니다.

## ART-10. 루나 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1001 | 단독 전신 WIP 후보 | Ready | 얼굴·후드·단검·민트 계열 후보 3안 이상 |
| ART-1002 | 얼굴·헤어 확정 | Todo | 정면·3/4에서 동일한 인상 |
| ART-1003 | 의상·실루엣 확정 | Todo | 쿼터뷰에서 고양이 후드와 단검 식별 |
| ART-1004 | Turnaround | Todo | 정면·측면·후면 구조 일치 |
| ART-1005 | 표정 8종 | Todo | 기본·미소·장난·놀람·진지·화남·슬픔·당황 |
| ART-1006 | 장비 상세 시트 | Todo | 에너지 단검·탐지 장치·백팩 구조 확정 |
| ART-1007 | 컬러·재질표 | Todo | 민트·크림·핑크와 재질 규칙 확정 |
| ART-1008 | 2D 제작 시트 승인 | Todo | 모든 필수 시트 사람 검토 후 Approved |

## ART-11. 미유 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1101 | 단독 전신 WIP 후보 | Ready | 엔지니어·드론·라일락 방향 3안 이상 |
| ART-1102 | 얼굴·헤어 확정 | Todo | 비대칭 단발과 무표정 인상 고정 |
| ART-1103 | 의상·실루엣 확정 | Todo | 큰 소매·공구·드론 식별 |
| ART-1104 | Turnaround | Todo | 정면·측면·후면 구조 일치 |
| ART-1105 | 표정 8종 | Todo | 무표정부터 희미한 미소까지 단계 표현 |
| ART-1106 | 장비 상세 시트 | Todo | 전투 드론·건틀릿·공구 키트 구조 확정 |
| ART-1107 | 컬러·재질표 | Todo | 라일락·그레이·네온 블루 확정 |
| ART-1108 | 2D 제작 시트 승인 | Todo | 모든 필수 시트 사람 검토 후 Approved |

## ART-12. 코코 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1201 | 단독 전신 WIP 후보 | Ready | 구조요원·의료 장비·따뜻한 인상 3안 이상 |
| ART-1202 | 얼굴·헤어 확정 | Todo | 부드러운 웨이브와 단호한 표정 표현 |
| ART-1203 | 의상·실루엣 확정 | Todo | 의료 케이프·가방·보호막 장치 식별 |
| ART-1204 | Turnaround | Todo | 정면·측면·후면 구조 일치 |
| ART-1205 | 표정 8종 | Todo | 다정함과 응급 상황의 진지함 표현 |
| ART-1206 | 장비 상세 시트 | Todo | 인젝터·의료 가방·보호막 발생기 확정 |
| ART-1207 | 컬러·재질표 | Todo | 코랄·아이보리·그린 확정 |
| ART-1208 | 2D 제작 시트 승인 | Todo | 모든 필수 시트 사람 검토 후 Approved |

## ART-13. 이리스 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1301 | 단독 전신 WIP 후보 | Ready | 정밀 사격·긴 실루엣·보스 딜러 방향 3안 이상 |
| ART-1302 | 얼굴·헤어 확정 | Todo | 냉정한 눈매와 긴 헤어 구조 고정 |
| ART-1303 | 의상·실루엣 확정 | Todo | 비대칭 코트·라이플·바이저 식별 |
| ART-1304 | Turnaround | Todo | 정면·측면·후면 구조 일치 |
| ART-1305 | 표정 8종 | Todo | 냉정함·당황·칭찬 반응 표현 |
| ART-1306 | 장비 상세 시트 | Todo | 에너지 라이플·조준 바이저 구조 확정 |
| ART-1307 | 컬러·재질표 | Todo | 퍼플·화이트·크림슨 확정 |
| ART-1308 | 2D 제작 시트 승인 | Todo | 모든 필수 시트 사람 검토 후 Approved |

## ART-14. 노아 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1401 | 단독 전신 WIP 후보 | Ready | 수호자·대형 방패·안정적 실루엣 3안 이상 |
| ART-1402 | 얼굴·헤어 확정 | Todo | 무뚝뚝하지만 따뜻한 인상 표현 |
| ART-1403 | 의상·실루엣 확정 | Todo | 넓은 어깨·방호 재킷·방패 식별 |
| ART-1404 | Turnaround | Todo | 정면·측면·후면 구조 일치 |
| ART-1405 | 표정 8종 | Todo | 무표정·걱정·미소·전투 집중 표현 |
| ART-1406 | 장비 상세 시트 | Todo | 전개식 방패·방호 장비·모듈 확정 |
| ART-1407 | 컬러·재질표 | Todo | 네이비·스틸·앰버 확정 |
| ART-1408 | 2D 제작 시트 승인 | Todo | 모든 필수 시트 사람 검토 후 Approved |

## ART-15. 5인 일관성 리뷰

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1501 | 후보 일관성 리뷰 | Todo | 전원 성인 여성, 역할·실루엣·팔레트·무기 구분 |
| ART-1502 | 최종 라인업 비교 시트 | Todo | 일반 등신 2D와 4~5등신 3D 변환 기준 포함 |

## ART-20. 공용 3D 규격과 루나 Proof

| ID | 작업 | 상태 | 선행 조건 | 완료 기준 |
|---|---|---|---|---|
| ART-2001 | `CHARACTER_3D_SPEC.md`·Unity Presentation 계약 | Todo | ART-1008 | 비율·성능 예산·Rig·LOD·Shader와 Character ID→Prefab/Portrait/Icon/VFX 연결 규격 확정 |
| ART-2002 | 공용 4~5등신 SD-lite Base Mesh | Todo | ART-2001 | 5명에게 재사용 가능한 베이스 |
| ART-2003 | 공용 Humanoid Rig | Todo | ART-2002 | Unity Humanoid Avatar 정상 생성 |
| ART-2004 | 공용 Toon Shader·Material 규칙 | Todo | Unity 기반 | 얼굴·눈·헤어·의상 슬롯 규칙 확정 |
| ART-2005 | 루나 3D Blockout | Todo | ART-1008, ART-2002 | 쿼터뷰 실루엣 검증 가능 |
| ART-2006 | 루나 Unity Gate C | Todo | ART-2005, ART-0105 | 얼굴·후드·단검 식별성 승인 |
| ART-2007 | 루나 최종 모델·Texture | Todo | ART-2006 | Approved 2D 시트와 일치 |
| ART-2008 | Rig·Weight·표정 | Todo | ART-2007 | 기본 동작과 표정의 치명적 변형 없음 |
| ART-2009 | 대표 애니메이션 | Todo | ART-2008, ART-0110 | Idle·Run·Attack·Dash·Skill·Hit·Victory |
| ART-2010 | VFX·사운드·Prefab 통합 | Todo | ART-2009 | 로비·선택·전투 정상 동작 |
| ART-2011 | 타깃 사용자 매력 검증 | Todo | ART-2010 | 평가와 개선점 기록 |

## ART-21. 나머지 3D 캐릭터

| ID | 작업 | 상태 | 선행 조건 |
|---|---|---|---|
| ART-2101~2102 | 미유 Blockout 검증 → 최종 모델·애니메이션·VFX | Todo | ART-1108, ART-2011 |
| ART-2111~2112 | 코코 Blockout 검증 → 최종 모델·애니메이션·VFX | Todo | ART-1208, ART-2011 |
| ART-2121~2122 | 이리스 Blockout 검증 → 최종 모델·애니메이션·VFX | Todo | ART-1308, ART-2011 |
| ART-2131~2132 | 노아 Blockout 검증 → 최종 모델·애니메이션·VFX | Todo | ART-1408, ART-2011 |

## ART-30. 환경·몬스터·소품

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-3001 | 폐허 거리 Color Key | Todo | 캐릭터 가독성과 자연에 잠식된 톤 검증 |
| ART-3002 | 폐허 거리 Modular Blockout | Todo | 플레이 가능한 Gray Box 대체 가능 |
| ART-3003 | 캠프 Color Key와 구조 | Todo | 따뜻한 안전 공간과 성장 단계 표현 |
| ART-3004 | 캠프 시설 4종 | Todo | 발전기·작업대·식량 창고·통신탑 |
| ART-3005 | 일반 몬스터 3종 1차 디자인 | Todo | 역할과 실루엣 구분 |
| ART-3006 | 보스 1종 1차 디자인 | Todo | 패턴과 약점이 외형에서 읽힘 |
| ART-3007 | 연구소 Color Key·Blockout | Todo | 두 번째 스테이지 방향 확정 |
| ART-3008 | 추가 몬스터 3종·보스 1종 | Todo | 연구소 전용 적 구성 |
| ART-3009 | 자원·상자·환경 소품 세트 | Todo | 상호작용 오브젝트 식별성 확보 |

## ART-40. UI·VFX·출시 아트

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-4001 | UI Design System | Todo | 버튼·패널·폰트·간격·컬러 토큰 정의 |
| ART-4002 | 로비·캐릭터 선택 UI | Todo | 5명 정보와 매력이 명확히 전달됨 |
| ART-4003 | 전투 HUD·스킬 선택 UI | Todo | Android Landscape Touch·Safe Area 가독성 확보, Windows 개발 입력 회귀 없음 |
| ART-4004 | 결과·캠프 강화 UI | Todo | 보상과 성장 피드백 명확 |
| ART-4005 | 캐릭터별 VFX 언어 시트 | Todo | 5명의 색상과 형태 언어 구분 |
| ART-4006 | 로고·스토어 Key Art | Todo | 캐릭터 중심 메시지 전달 |
| ART-4007 | 출시 아트 최종 리뷰 | Todo | WIP 미포함, 라이선스·메타데이터 확인 |

## 메타데이터 필수 필드

`Asset Name`, `Subject`, `Purpose`, `Status`, `Generated Date`, `Tool/Model`, `Workflow Version`, `Seed`, `Input References`, `Human Edits`, `Usage Restriction`, `Reviewer`를 companion Markdown에 기록한다.

빈 이미지, 워터마크, 권리 불명 자산, companion metadata가 없는 생성물은 Review 후보에도 올리지 않는다.
