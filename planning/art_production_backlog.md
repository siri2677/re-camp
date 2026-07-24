# Re:Camp Art Production Backlog

> 최종 갱신: 2026-07-24

상세 실행 순서와 전체 우선순위는 `planning/sprint_backlog.md`를 우선한다. 이 문서는 아트 산출물을
세분화한다. `Deferred`는 기술적 차단이 아니라 필요성이 확인될 때 도입하는 선택 작업이다.

## ART-00. 방향·관리

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-0001 | 통합 Art Direction v2.0 | High | Done | 2D 약 7등신·3D 5~6등신·트렌드/기능/반전 매력·쿼터뷰 문서화 |
| ART-0002 | 성인 여성 5인 Character Bible v2.0 | High | Done | 5인 한 문장 훅·패션·체형·성격·장비·2D/3D 목표 확정 |
| ART-0003 | 과거 라인업 `REVIEW v003` 이력 관리 | Medium | Review | Gate A `FAIL` 유지, 새 디자인 앵커로 사용하지 않음 |
| ART-0004 | MCP 제작·승인 가이드 | High | Done | 도구 역할과 승인 절차 정의 |
| ART-0005 | 자산 구조·상태·이름 규칙 | High | Done | WIP/REVIEW/APPROVED와 경로 정의 |
| ART-0006 | AI 생성 메타데이터 양식 | Medium | Done | 도구·모델·Seed·입력·수정·권리·유사성 기록 |
| ART-0007 | Git LFS 패턴·속성 검증 | High | Done | PNG·FBX·BLEND·KRA·TGA·EXR 규칙 검증 |
| ART-0008 | 원격 v001 raw PNG/LFS 교정 | Low | Blocked | 유효 원본 확보 또는 이력 보존 결정 |
| ART-0009 | 2D→3D 비율·변환 기준 단일화 | High | Done | Baseline·Art Direction·Bible·Anchor·Checklist·Template v002 일치 |

## ART-01. 제작 파이프라인

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-0101 | 현재 이미지 생성 도구 기반 반복 워크플로 | High | Review | 한 문장 훅·Anchor v2.0·외부 IP 회귀 조건으로 반복 가능 |
| ART-0102 | 도구 비종속 캐릭터 앵커·메타데이터 규칙 v2.0 | High | Done | 얼굴·헤어·체형·패션·장비·팔레트·2D/3D 비율·회귀 조건 확정 |
| ART-0103 | Figma 캐릭터 제작 시트 템플릿 v002 | High | Review | 6-Frame v002 SVG 완료, Figma Import·Component·Export 검증 필요 |
| ART-0104 | Blender MCP 소품 생성·FBX Export | Medium | Ready | ART-0109 명명 규격으로 테스트 소품 저장·Export 성공 |
| ART-0105 | FBX Import·Material·Prefab 테스트 | Medium | Todo | ART-0104·0109 결과가 Unity Prefab으로 동작 |
| ART-0106 | `art_source/` 디렉터리 | Medium | Done | figma_exports·blender·textures·comfyui_workflows 존재 |
| ART-0107 | Gate A/B/C 리뷰 체크리스트 v2.0 | High | Done | 약 7등신 Key Art·2D→3D 변환·외부 IP 유사성·Unity Gate 반영 |
| ART-0108 | ComfyUI·ComfyUI MCP 고정 워크플로 | Low | Deferred | 대량 일관성·정밀 인페인팅·고정 Seed/LoRA/ControlNet/IP-Adapter가 병목일 때만 Ready |
| ART-0109 | `ASSET_NAMING_GUIDE.md` | High | Done | 이미지·Blender·FBX·Unity·Prefab·Material·Socket 이름과 버전·Export·GUID 규칙 확정 |
| ART-0110 | `ANIMATION_GUIDE.md` | Medium | Done | 공용/전용 상태·in-place·Animator·Event·Socket·파일·Import·Gate 규칙 확정 |
| ART-0111 | v002 Figma 실사용 검증 | High | Todo | SVG Import, Component Clone, 한글 보존, PNG/PDF Export, 사람 사용성 검토 |
| ART-0112 | 2D→3D 변환표 샘플 검증 | High | Todo | 루나 샘플에서 확대·삭제·결합·헤어/천 단순화 필드 사용 가능 |

로컬 모델 보유, GPU 준비, ComfyUI 설치는 현재 완료 조건이나 개발 선행 조건이 아니다.

## ART-10. 루나 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1001 | 약 7등신 단독 전신 WIP 후보 | Ready | 센서 고양이 정찰병 훅 기반 6.9~7.1등신 후보 3안 이상 |
| ART-1002 | 얼굴·헤어 확정 | Todo | 밝고 영리한 성인 인상, 민트 실버 비대칭 보브가 정면·3/4에서 일치 |
| ART-1003 | 패션·체형·실루엣 확정 | Todo | 크림 크롭 재킷·비대칭 허리 패널·슬림 애슬레틱 체형·센서 귀 식별 |
| ART-1004 | 약 7등신 Turnaround | Todo | Front·Side·Back 6.9~7.1등신과 의상·후드·백팩 구조 일치 |
| ART-1005 | 표정 8종 | Todo | 장난스러운 평상시와 임무 집중 대비 포함 |
| ART-1006 | 장비 상세 시트 | Todo | 센서 후드·쌍단검·손목 스캐너·백팩 구조와 접힘/발광 정의 |
| ART-1007 | 컬러·재질표 | Todo | 민트 실버·차콜·크림·핑크 소량과 공용 캠프 재질 규칙 확정 |
| ART-1008 | 2D→3D 변환표 | Todo | 6.9~7.1 → 5.3~5.4, 확대·삭제·결합·물리 본 위험 명시 |
| ART-1009 | 루나 2D 제작 시트 승인 | Todo | CHA-A01~A16과 사람 검토 후 Approved |

## ART-11. 미유 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1101 | 약 7등신 단독 전신 WIP 후보 | Ready | 비대칭 드론 테크니션 훅 기반 6.8~7.0등신 후보 3안 이상 |
| ART-1102 | 얼굴·헤어 확정 | Todo | 졸린 성인 눈매와 스모키 라일락 비대칭 보브 고정 |
| ART-1103 | 패션·체형·실루엣 확정 | Todo | 한쪽 큰 워크 보머·작은 성인 체형·드론 2기 식별 |
| ART-1104 | 약 7등신 Turnaround | Todo | Front·Side·Back과 드론 기준 위치·비대칭 방향 일치 |
| ART-1105 | 표정 8종 | Todo | 무표정부터 기계 이야기의 열정과 미세한 미소까지 표현 |
| ART-1106 | 장비 상세 시트 | Todo | 성격이 다른 드론 2기·제어 건틀릿·입력 패드·공구 키트 확정 |
| ART-1107 | 컬러·재질표 | Todo | 스모키 라일락·그래파이트·시안과 드론 재질 규칙 확정 |
| ART-1108 | 2D→3D 변환표 | Todo | 6.8~7.0 → 5.2~5.3, 드론·큰 소매·헤어 우선순위 명시 |
| ART-1109 | 미유 2D 제작 시트 승인 | Todo | CHA-A01~A16과 사람 검토 후 Approved |

## ART-12. 코코 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1201 | 약 7등신 단독 전신 WIP 후보 | Ready | 현장 구조대장 훅 기반 7.0~7.2등신 후보 3안 이상 |
| ART-1202 | 얼굴·헤어 확정 | Todo | 따뜻한 성인 얼굴·코랄 코퍼 웨이브·위기 시 단호한 눈매 표현 |
| ART-1203 | 패션·체형·실루엣 확정 | Todo | 구조복·하프 케이프·건강한 곡선 체형·인젝터 식별 |
| ART-1204 | 약 7등신 Turnaround | Todo | Front·Side·Back과 구조 하네스·케이프·앰플 구조 일치 |
| ART-1205 | 표정 8종 | Todo | 다정함과 응급 상황의 현장 지휘 대비 표현 |
| ART-1206 | 장비 상세 시트 | Todo | 인젝터 배턴·의료 팩·생체 스캐너·투명 보호막 프로젝터 확정 |
| ART-1207 | 컬러·재질표 | Todo | 코랄 코퍼·아이보리·제이드와 투명 의료 폴리머 확정 |
| ART-1208 | 2D→3D 변환표 | Todo | 7.0~7.2 → 5.5~5.6, 케이프·앰플·보호막 단순화 명시 |
| ART-1209 | 코코 2D 제작 시트 승인 | Todo | CHA-A01~A16과 사람 검토 후 Approved |

## ART-13. 이리스 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1301 | 약 7등신 단독 전신 WIP 후보 | Ready | 관측 장비형 저격수 훅 기반 7.2~7.4등신 후보 3안 이상 |
| ART-1302 | 얼굴·헤어 확정 | Todo | 날카로운 성인 눈매·딥 플럼 긴 헤어·실버 관측 밴드 고정 |
| ART-1303 | 패션·체형·실루엣 확정 | Todo | 콜드 화이트 롱 코트·우아한 장신·긴 세로 실루엣 식별 |
| ART-1304 | 약 7등신 Turnaround | Todo | Front·Side·Back과 코트 분할·긴 헤어·라이플 휴대 구조 일치 |
| ART-1305 | 표정 8종 | Todo | 냉정함·당황·칭찬 반응·생활 실수 대비 표현 |
| ART-1306 | 장비 상세 시트 | Todo | 접힘 에너지 라이플·단안 바이저·거리 측정 모듈 확정 |
| ART-1307 | 컬러·재질표 | Todo | 딥 플럼·콜드 화이트·잉크·크림슨 소량 확정 |
| ART-1308 | 2D→3D 변환표 | Todo | 7.2~7.4 → 5.7~5.8, 코트·헤어·라이플 길이와 물리 본 명시 |
| ART-1309 | 이리스 2D 제작 시트 승인 | Todo | CHA-A01~A16과 사람 검토 후 Approved |

## ART-14. 노아 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1401 | 약 7등신 단독 전신 WIP 후보 | Ready | 이동식 피난처 수호자 훅 기반 7.2~7.4등신 후보 3안 이상 |
| ART-1402 | 얼굴·헤어 확정 | Todo | 침착한 성인 얼굴·미드나이트 네이비 짧은 보브·앰버 포인트 고정 |
| ART-1403 | 패션·체형·실루엣 확정 | Todo | 탄탄한 최장신·테일러드 방호 재킷·수직 방패 식별 |
| ART-1404 | 약 7등신 Turnaround | Todo | Front·Side·Back과 방패 접힘·재킷·하프 케이프 구조 일치 |
| ART-1405 | 표정 8종 | Todo | 무뚝뚝함·걱정·작은 미소·전투 집중과 행동형 배려 표현 |
| ART-1406 | 장비 상세 시트 | Todo | 케이스→문·벽 다단 전개 방패·충격 흡수·통신 모듈 확정 |
| ART-1407 | 컬러·재질표 | Todo | 미드나이트 네이비·스틸·앰버와 방벽 재질 확정 |
| ART-1408 | 2D→3D 변환표 | Todo | 7.2~7.4 → 5.7~5.8, 방패 단계·갑옷 면적·관통 위험 명시 |
| ART-1409 | 노아 2D 제작 시트 승인 | Todo | CHA-A01~A16과 사람 검토 후 Approved |

## ART-15. 5인 일관성 리뷰

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1501 | 약 7등신 후보 일관성 리뷰 | Todo | 전원 성인 여성, 한 문장 훅·얼굴·체형·패션·실루엣·팔레트·무기 구분 |
| ART-1502 | 128px 얼굴·흑백 실루엣·저채도 검토 | Todo | 장비 포함/제거 상태에서 5/5 구분 |
| ART-1503 | 외부 IP 유사성 리뷰 | Todo | 얼굴·의상 절개·무기·로고 직접 복제 없음, 차별화 기록 |
| ART-1504 | 최종 라인업 비교 시트 | Todo | 2D 약 7등신과 캐릭터별 3D 5~6등신 변환 기준 포함 |

## ART-20. 공용 3D 규격과 루나 Proof

| ID | 작업 | 상태 | 선행 조건 | 완료 기준 |
|---|---|---|---|---|
| ART-2001 | `CHARACTER_3D_SPEC.md`·Unity Presentation 계약 | Todo | ART-1009 | 비율·성능 예산·Rig·LOD·Shader와 Character ID→Prefab/Portrait/Icon/VFX 연결 규격 확정 |
| ART-2002 | 공용 5~6등신 스타일라이즈드 Base Mesh | Todo | ART-2001 | 5.2~5.8등신·5명 체형 차이를 수용하는 재사용 베이스 |
| ART-2003 | 공용 Humanoid Rig | Todo | ART-2002 | Unity Humanoid Avatar 정상 생성 |
| ART-2004 | 공용 Toon Shader·Material 규칙 | Todo | Unity 기반 | 얼굴·눈·헤어·의상·장비·Emission 슬롯 규칙 확정 |
| ART-2005 | 루나 3D Blockout | Todo | ART-1009, ART-2002 | 5.3~5.4등신·얼굴·센서 귀·쌍단검 쿼터뷰 검증 가능 |
| ART-2006 | 루나 Unity Gate C | Todo | ART-2005, ART-0105 | CHA-C01~C12와 Android 실기기 식별성 승인 |
| ART-2007 | 루나 최종 모델·Texture | Todo | ART-2006 | Approved 2D 시트와 동일 캐릭터로 인식 |
| ART-2008 | Rig·Weight·표정 | Todo | ART-2007 | 기본 동작과 표정의 치명적 변형 없음 |
| ART-2009 | 대표 애니메이션 | Todo | ART-2008, ART-0110 | Idle·Run·Attack·Dash·Skill·Hit·Victory |
| ART-2010 | VFX·사운드·Prefab 통합 | Todo | ART-2009 | 로비·선택·전투 정상 동작 |
| ART-2011 | 타깃 사용자 매력 검증 | Todo | ART-2010 | 센서 고양이 정찰병 훅과 긍정·개선 평가 기록 |

## ART-21. 나머지 3D 캐릭터

| ID | 작업 | 상태 | 선행 조건 |
|---|---|---|---|
| ART-2101~2102 | 미유 5.2~5.3 Blockout 검증 → 최종 모델·애니메이션·VFX | Todo | ART-1109, ART-2011 |
| ART-2111~2112 | 코코 5.5~5.6 Blockout 검증 → 최종 모델·애니메이션·VFX | Todo | ART-1209, ART-2011 |
| ART-2121~2122 | 이리스 5.7~5.8 Blockout 검증 → 최종 모델·애니메이션·VFX | Todo | ART-1309, ART-2011 |
| ART-2131~2132 | 노아 5.7~5.8 Blockout 검증 → 최종 모델·애니메이션·VFX | Todo | ART-1409, ART-2011 |

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
| ART-4002 | 로비·캐릭터 선택 UI | Todo | 약 7등신 Key Art와 5명 정보·매력이 명확히 전달됨 |
| ART-4003 | 전투 HUD·스킬 선택 UI | Todo | Android Landscape Touch·Safe Area 가독성, Windows 입력 회귀 없음 |
| ART-4004 | 결과·캠프 강화 UI | Todo | 보상과 성장 피드백 명확 |
| ART-4005 | 캐릭터별 VFX 언어 시트 | Todo | 5명의 색상·형태·기능 언어 구분 |
| ART-4006 | 128px HUD 초상화 세트 | Todo | 얼굴·헤어·포인트색으로 5/5 식별 |
| ART-4007 | 로고·스토어 Key Art | Todo | 약 7등신 캐릭터 중심 메시지 전달 |
| ART-4008 | 출시 아트 최종 리뷰 | Todo | WIP 미포함, 라이선스·메타데이터·유사성 확인 |

## 메타데이터 필수 필드

`Asset Name`, `Subject`, `Purpose`, `Status`, `Generated Date`, `Tool/Model`, `Workflow Version`,
`Seed`, `Input References`, `Human Edits`, `Usage Restriction`, `Reviewer`, `2D Proportion Target`,
`3D Proportion Target`, `One-line Visual Hook`, `Trend / Function Rationale`, `External-IP Similarity`,
`2D to 3D Simplification`을 companion Markdown에 기록한다.

빈 이미지, 워터마크, 권리 불명 자산, companion metadata가 없는 생성물은 Review 후보에도 올리지 않는다.
