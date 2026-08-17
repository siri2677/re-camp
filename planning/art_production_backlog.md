# Re:Camp Art Production Backlog

> 최종 갱신: 2026-08-07

전역 비주얼·로스터·허용 비율은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`가 소유한다.

상세 실행 순서와 전체 우선순위는 `planning/sprint_backlog.md`를 우선한다. 이 문서는 아트 산출물을
세분화한다. `Deferred`는 기술적 차단이 아니라 필요성이 확인될 때 도입하는 선택 작업이다.

2026-08-07 사용자 Gate A 판정으로 기존 5인 v002 패키지는 `STYLE REJECTED / HISTORY ONLY`가 됐다.
아래 ART-1001~1409·1501~1504의 기존 파일 수량·비율·장비 메모는 기술 이력으로 보존하지만, 얼굴·렌더링·
통합 시트는 승인 근거가 아니며 공통 얼굴/흉상 하우스 스타일 락 이후 재생성한다.

## ART-00. 방향·관리

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-0001 | 통합 Art Direction v2.1 | High | Done | 일본 모바일 서브컬처 얼굴·헤어·렌더링, 2D 약 7등신·3D 5~6등신·쿼터뷰 문서화 |
| ART-0002 | 성인 여성 5인 Character Bible v2.1 | High | Done | 5인 한 문장 훅·패션·체형·성격·장비·2D/3D 목표 확정 |
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
| ART-0101 | 현재 이미지 생성 도구 기반 반복 워크플로 | High | In Progress | 얼굴/흉상 마스터 v002→사용자 선호 노출도·신장·체형과 루나/미유 하체 분리를 반영한 전신 라인업 v007→전체 스타일 락→공통 참조 전파 순서로 재설계 |
| ART-0102 | 도구 비종속 캐릭터 앵커·메타데이터 규칙 v2.1 | High | Done | 얼굴·헤어·체형·패션·장비·팔레트·2D/3D 비율·회귀 조건 확정 |
| ART-0103 | Figma 캐릭터 제작 시트 템플릿 v002 | High | Review | 6-Frame v002 SVG 완료, Figma Import·Component·Export 검증 필요 |
| ART-0104 | Blender MCP 소품 생성·FBX Export | Medium | Ready | ART-0109 명명 규격으로 테스트 소품 저장·Export 성공 |
| ART-0105 | FBX Import·Material·Prefab 테스트 | Medium | In Progress | `ReCampCharacterImportProof` preflight validator와 CH101 v010 production-skinning-review FBX 연결. Blender LOD/6-material/2-influence 검증 완료; Unity LODGroup·Prefab·실행 캡처 대기 |
| ART-0106 | `art_source/` 디렉터리 | Medium | Done | figma_exports·blender·textures·comfyui_workflows 존재 |
| ART-0107 | Gate A/B/C 리뷰 체크리스트 v2.1 | High | Done | 일본 서브컬처 화풍·약 7등신 Key Art·2D→3D 변환·외부 IP 유사성·Unity Gate 반영 |
| ART-0108 | ComfyUI·ComfyUI MCP 고정 워크플로 | Low | Deferred | 대량 일관성·정밀 인페인팅·고정 Seed/LoRA/ControlNet/IP-Adapter가 병목일 때만 Ready |
| ART-0109 | `ASSET_NAMING_GUIDE.md` | High | Done | 이미지·Blender·FBX·Unity·Prefab·Material·Socket 이름과 버전·Export·GUID 규칙 확정 |
| ART-0110 | `ANIMATION_GUIDE.md` | Medium | Done | 공용/전용 상태·in-place·Animator·Event·Socket·파일·Import·Gate 규칙 확정 |
| ART-0111 | v002 Figma 실사용 검증 | High | Todo | SVG Import, Component Clone, 한글 보존, PNG/PDF Export, 사람 사용성 검토 |
| ART-0112 | 2D→3D 변환표 샘플 검증 | High | Review | 루나 v004에서 2D 7.09H→3D 5.39H, 확대·삭제·결합·물리 위험, Face128·실루엣 증거와 통합 시트까지 작성. Figma Frame 05 실사용·사람 검토는 ART-0111 및 승인 Gate에서 확인 |
| ART-0113 | CH101 고품질 3D 시각 제작 모델 | In Progress | A/B 통합 WIP v002, Turnaround WIP v003, 3D LookDev 목표 v004, A canonical Turnaround v005, Expression v006, Equipment v007, Pose Board v008, Neutral Body Sculpt v009, Readability v010, Blender 모델링/리그·소켓 템플릿과 리그 자동 검증 PASS를 기록. 공식 CC0 MPFB 인체 바디를 CH101 리그에 자동 웨이트 바인드한 WIP도 생성했으나 얼굴·헤어·의상·장비 스타일링은 미완료. 2026-08-17 스타일링 run6/7과 MPFB helper 정렬 run1도 실제 인체 표면에 붙은 프리미엄 모델로 읽히지 않아 반려 WIP로 기록. v005/v010 기반 2D Face/Bust Style Anchor v011·4방향 회전 시트 v012와 MPFB 와이어 바디·가이드·리그를 묶은 V012 Modeling Guide WIP을 추가했으며 사람 검토 전 production mesh 입력으로 고정하지 않는다. 공통 베이스 run3/4·연결 Skin run2·voxel run1은 시각 반려. Gate B·Unity 후보로 취급하지 않음 |

로컬 모델 보유, GPU 준비, ComfyUI 설치는 현재 완료 조건이나 개발 선행 조건이 아니다.

## ART-10. 루나 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1001 | 약 7등신 단독 전신 WIP 후보 | In Progress | 통합 전신 패션 v007에서 패널 없는 차콜 하이웨이스트 유틸리티 쇼츠 루나 방향 1안 생성. 신규 단독 3안·선택 KeyArt·사용자 방향 승인 남음 |
| ART-1002 | 얼굴·헤어 확정 | In Progress | 새 공통 얼굴 시스템으로 밝고 영리한 인상과 기계식 센서 귀를 재검증 |
| ART-1003 | 패션·체형·실루엣 확정 | In Progress | 슬림 애슬레틱 체형·패널 없는 짧은 차콜 쇼츠·센서 허리 장비를 v007에서 검토, 개별 KeyArt 확정 남음 |
| ART-1004 | 약 7등신 Turnaround | In Progress | 기존 비율 이력 유지, 새 KeyArt 확정 후 3뷰 재전파 |
| ART-1005 | 표정 8종 | In Progress | 새 얼굴 스타일과 성격 대비로 재생성 |
| ART-1006 | 장비 상세 시트 | In Progress | 구조 메모 유지, 새 패션·렌더링 기준으로 재전파 |
| ART-1007 | 컬러·재질표 | In Progress | 팔레트 수치는 유지하고 공통 재질 렌더링으로 재검증 |
| ART-1008 | 2D→3D 변환표 | In Progress | 기존 수치는 초안, 새 KeyArt로 재측정 |
| ART-1009 | 루나 2D 제작 시트 승인 | In Progress | 신규 통합 시트와 Gate A 재시험 필요 |

## ART-11. 미유 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1101 | 약 7등신 단독 전신 WIP 후보 | In Progress | 통합 전신 패션 v007에서 테크 쇼츠 위 짧은 라일락 비대칭 랩 패널·바닥 케이블 없는 미유 방향 1안 생성. 신규 단독 3안·선택 KeyArt·사용자 방향 승인 남음 |
| ART-1102 | 얼굴·헤어 확정 | In Progress | 새 공통 얼굴 시스템에서 졸린 성인 눈매와 비대칭 보브 재검증 |
| ART-1103 | 패션·체형·실루엣 확정 | In Progress | 큰 소매·성인 소형 체형·드론 2기·쇼츠가 보이는 짧은 라일락 비대칭 랩 패널을 v007에서 검토, 개별 KeyArt 확정 남음 |
| ART-1104 | 약 7등신 Turnaround | In Progress | 기존 비율 이력 유지, 새 KeyArt 확정 후 3뷰 재전파 |
| ART-1105 | 표정 8종 | In Progress | 새 얼굴 스타일과 기계 집중 반전으로 재생성 |
| ART-1106 | 장비 상세 시트 | In Progress | 구조 메모 유지, 새 렌더링 기준으로 재전파 |
| ART-1107 | 컬러·재질표 | In Progress | 팔레트 수치는 유지하고 공통 재질 렌더링으로 재검증 |
| ART-1108 | 2D→3D 변환표 | In Progress | 기존 수치는 초안, 새 KeyArt로 재측정 |
| ART-1109 | 미유 2D 제작 시트 승인 | In Progress | 신규 통합 시트와 Gate A 재시험 필요 |

## ART-12. 코코 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1201 | 약 7등신 단독 전신 WIP 후보 | In Progress | 통합 전신 패션 v007에서 코코 방향 1안 생성. 신규 단독 3안·선택 KeyArt·사용자 방향 승인 남음 |
| ART-1202 | 얼굴·헤어 확정 | In Progress | 서양 핀업 드리프트를 제거하고 따뜻한 성인 애니 얼굴로 전면 재설계 |
| ART-1203 | 패션·체형·실루엣 확정 | In Progress | 구조대장 패션·하프 케이프·건강한 곡선 체형을 새 KeyArt로 재검토 |
| ART-1204 | 약 7등신 Turnaround | In Progress | 기존 구조 이력 유지, 새 KeyArt 확정 후 3뷰 재전파 |
| ART-1205 | 표정 8종 | In Progress | 새 얼굴 스타일과 다정함↔지휘 반전으로 재생성 |
| ART-1206 | 장비 상세 시트 | In Progress | 구조 메모 유지, 새 패션·렌더링 기준으로 재전파 |
| ART-1207 | 컬러·재질표 | In Progress | 팔레트 수치는 유지하고 공통 재질 렌더링으로 재검증 |
| ART-1208 | 2D→3D 변환표 | In Progress | 기존 수치는 초안, 새 KeyArt로 재측정 |
| ART-1209 | 코코 2D 제작 시트 승인 | In Progress | 신규 통합 시트와 Gate A 재시험 필요 |

## ART-13. 이리스 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1301 | 약 7등신 단독 전신 WIP 후보 | In Progress | 통합 전신 패션 v007에서 이리스 방향 1안 생성. 신규 단독 3안·선택 KeyArt·사용자 방향 승인 남음 |
| ART-1302 | 얼굴·헤어 확정 | In Progress | 길어진 얼굴과 별도 SF 렌더를 제거하고 우아한 성인 애니 눈매로 재설계 |
| ART-1303 | 패션·체형·실루엣 확정 | In Progress | 콜드 화이트 롱 코트·우아한 장신을 새 KeyArt로 재검토 |
| ART-1304 | 약 7등신 Turnaround | In Progress | 기존 구조 이력 유지, 새 KeyArt 확정 후 3뷰 재전파 |
| ART-1305 | 표정 8종 | In Progress | 새 얼굴 스타일과 냉정함↔생활 실수 반전으로 재생성 |
| ART-1306 | 장비 상세 시트 | In Progress | 관측 랜스 구조 메모 유지, 새 렌더링 기준으로 재전파 |
| ART-1307 | 컬러·재질표 | In Progress | 팔레트 수치는 유지하고 공통 재질 렌더링으로 재검증 |
| ART-1308 | 2D→3D 변환표 | In Progress | 기존 수치는 초안, 새 KeyArt로 재측정 |
| ART-1309 | 이리스 2D 제작 시트 승인 | In Progress | 신규 통합 시트와 Gate A 재시험 필요 |

## ART-14. 노아 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1401 | 약 7등신 단독 전신 WIP 후보 | In Progress | 통합 전신 패션 v007에서 노아 방향 1안 생성. 신규 단독 3안·선택 KeyArt·사용자 방향 승인 남음 |
| ART-1402 | 얼굴·헤어 확정 | In Progress | 3D 세미리얼 얼굴·광원을 제거하고 강인한 성인 애니 얼굴로 전면 재설계 |
| ART-1403 | 패션·체형·실루엣 확정 | In Progress | 탄탄한 장신·여성적 허리선·방벽 실루엣을 새 KeyArt로 재검토 |
| ART-1404 | 약 7등신 Turnaround | In Progress | 기존 구조 이력 유지, 새 KeyArt 확정 후 3뷰 재전파 |
| ART-1405 | 표정 8종 | In Progress | 새 얼굴 스타일과 침착함↔온기 반전으로 재생성 |
| ART-1406 | 장비 상세 시트 | In Progress | 방벽 구조 메모 유지, 새 패션·렌더링 기준으로 재전파 |
| ART-1407 | 컬러·재질표 | In Progress | 팔레트 수치는 유지하고 공통 재질 렌더링으로 재검증 |
| ART-1408 | 2D→3D 변환표 | In Progress | 기존 수치는 초안, 새 KeyArt로 재측정 |
| ART-1409 | 노아 2D 제작 시트 승인 | In Progress | 신규 통합 시트와 Gate A 재시험 필요 |

## ART-15. 5인 일관성 리뷰

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1501 | 약 7등신 후보 일관성 리뷰 | In Progress | 전신 패션 v007은 동일 게임 응집도·신장·체형·하체 패션 사전 점검 WIP. 최종 판정은 새 KeyArt 5개 확정 뒤 수행 |
| ART-1502 | 128px 얼굴·흑백 실루엣·저채도 검토 | In Progress | 기존 크기·합성 절차만 유지하고 새 얼굴·전신으로 전부 재생성 |
| ART-1503 | 외부 IP 유사성 리뷰 | In Progress | 새 디자인 확정 후 차이 분석·역이미지·법률·상표 검토 재수행 |
| ART-1504 | 최종 라인업 비교 시트 | In Progress | 새 5인 KeyArt와 공통 하우스 스타일을 기준으로 v003 작성 필요 |

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
