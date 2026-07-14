# Re:Camp Art Production Backlog

이 문서는 캐릭터 5명과 환경·UI·VFX 아트의 세부 실행 작업을 관리한다.

상태는 `Todo`, `Ready`, `In Progress`, `Review`, `Blocked`, `Done`을 사용한다.

## ART-00. 방향과 관리 체계

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-0001 | 통합 아트 방향 확정 | High | Done | 2D 일반 등신 + 3D 5~6등신 + 쿼터뷰 방향 문서화 |
| ART-0002 | 캐릭터 5명 설정 통일 | High | Done | CHARACTER_BIBLE과 character_table 일치 |
| ART-0003 | 통합 캐릭터 라인업 1차 시안 | High | Review | 사용자 검토 후 Approved 또는 수정 결정 |
| ART-0004 | 아트 디렉터리·승인 규칙 작성 | High | Done | WIP/REVIEW/APPROVED와 파일 구조 정의 |
| ART-0005 | MCP 제작 가이드 작성 | Medium | Done | ComfyUI·Figma·Blender·Coplay 역할 정의 |
| ART-0006 | 아트 생성 자산 메타데이터 템플릿 작성 | Medium | Todo | 도구·모델·시드·입력·수정·라이선스 기록 양식 추가 |
| ART-0007 | Git LFS 대상 검토 및 갱신 | High | Ready | blend/fbx/psd/kra/tga/exr 등 추적 규칙 검증 |

## ART-01. 제작 파이프라인

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-0101 | ComfyUI 이미지 워크플로 구성 | High | Todo | ART-0003 | 기준 이미지를 사용한 반복 생성 가능 |
| ART-0102 | 캐릭터 일관성 변수 정의 | High | Todo | ART-0101 | 얼굴·헤어·의상·색상 고정 항목 문서화 |
| ART-0103 | Figma 캐릭터 시트 템플릿 구성 | High | Todo | 없음 | 전신·표정·Turnaround·장비·팔레트 프레임 완성 |
| ART-0104 | Blender MCP 연결 검증 | Medium | Todo | 없음 | 테스트 소품 생성·저장·Export 성공 |
| ART-0105 | Coplay/Aura Unity Import 검증 | Medium | Todo | DEV-0101 | 테스트 FBX를 Prefab으로 구성 |
| ART-0106 | art_source 디렉터리 생성 | Medium | Todo | DEV-0101 | figma_exports/blender/textures/comfyui_workflows 생성 |
| ART-0107 | 아트 리뷰 체크리스트 적용 | High | Ready | ART-0004 | 모든 Review 자산에 동일 체크리스트 사용 |

## ART-10. 루나 2D 디자인

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-1001 | 루나 단독 전신 후보 제작 | High | Ready | 얼굴·후드·단검·색상 후보 3안 이상 |
| ART-1002 | 루나 얼굴·헤어 확정 | High | Todo | 정면·3/4 시점에서 동일한 인상 유지 |
| ART-1003 | 루나 의상·실루엣 확정 | High | Todo | 쿼터뷰에서 고양이 후드와 단검 식별 |
| ART-1004 | 루나 Turnaround | High | Todo | 정면·측면·후면 구조 일치 |
| ART-1005 | 루나 표정 8종 | Medium | Todo | 기본·미소·장난·놀람·진지·화남·슬픔·당황 |
| ART-1006 | 루나 장비 상세 시트 | High | Todo | 에너지 단검·탐지 장치·백팩 구조 확정 |
| ART-1007 | 루나 컬러·재질표 | Medium | Todo | 민트·크림·핑크와 재질 규칙 확정 |
| ART-1008 | 루나 2D 제작 시트 승인 | High | Todo | 모든 필수 시트 Approved |

## ART-11. 미유 2D 디자인

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-1101 | 미유 단독 전신 후보 제작 | High | Ready | 엔지니어·드론·라일락 컬러가 명확한 3안 이상 |
| ART-1102 | 미유 얼굴·헤어 확정 | High | Todo | 비대칭 단발과 무표정 인상 고정 |
| ART-1103 | 미유 의상·실루엣 확정 | High | Todo | 큰 소매·공구·드론 실루엣 식별 |
| ART-1104 | 미유 Turnaround | High | Todo | 정면·측면·후면 구조 일치 |
| ART-1105 | 미유 표정 8종 | Medium | Todo | 무표정에서 희미한 미소까지 단계 표현 |
| ART-1106 | 미유 장비 상세 시트 | High | Todo | 전투 드론·건틀릿·공구 키트 구조 확정 |
| ART-1107 | 미유 컬러·재질표 | Medium | Todo | 라일락·그레이·네온 블루 확정 |
| ART-1108 | 미유 2D 제작 시트 승인 | High | Todo | 모든 필수 시트 Approved |

## ART-12. 코코 2D 디자인

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-1201 | 코코 단독 전신 후보 제작 | High | Ready | 구조요원·의료 장비·따뜻한 인상 3안 이상 |
| ART-1202 | 코코 얼굴·헤어 확정 | High | Todo | 부드러운 웨이브와 단호한 표정 모두 표현 가능 |
| ART-1203 | 코코 의상·실루엣 확정 | High | Todo | 의료 케이프·가방·보호막 장치 식별 |
| ART-1204 | 코코 Turnaround | High | Todo | 정면·측면·후면 구조 일치 |
| ART-1205 | 코코 표정 8종 | Medium | Todo | 다정함과 응급 상황의 진지함 표현 |
| ART-1206 | 코코 장비 상세 시트 | High | Todo | 펄스 인젝터·의료 가방·보호막 발생기 확정 |
| ART-1207 | 코코 컬러·재질표 | Medium | Todo | 코랄·아이보리·그린 확정 |
| ART-1208 | 코코 2D 제작 시트 승인 | High | Todo | 모든 필수 시트 Approved |

## ART-13. 이리스 2D 디자인

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-1301 | 이리스 단독 전신 후보 제작 | High | Ready | 정밀 사격·긴 실루엣·보스 딜러 인상 3안 이상 |
| ART-1302 | 이리스 얼굴·헤어 확정 | High | Todo | 냉정한 눈매와 긴 헤어 구조 고정 |
| ART-1303 | 이리스 의상·실루엣 확정 | High | Todo | 비대칭 코트·라이플·바이저 식별 |
| ART-1304 | 이리스 Turnaround | High | Todo | 정면·측면·후면 구조 일치 |
| ART-1305 | 이리스 표정 8종 | Medium | Todo | 냉정함·당황·칭찬 반응 표현 |
| ART-1306 | 이리스 장비 상세 시트 | High | Todo | 에너지 라이플·조준 바이저 구조 확정 |
| ART-1307 | 이리스 컬러·재질표 | Medium | Todo | 퍼플·화이트·크림슨 확정 |
| ART-1308 | 이리스 2D 제작 시트 승인 | High | Todo | 모든 필수 시트 Approved |

## ART-14. 노아 2D 디자인

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-1401 | 노아 단독 전신 후보 제작 | High | Ready | 수호자·대형 방패·안정적인 실루엣 3안 이상 |
| ART-1402 | 노아 얼굴·헤어 확정 | High | Todo | 무뚝뚝하지만 따뜻한 인상 표현 |
| ART-1403 | 노아 의상·실루엣 확정 | High | Todo | 넓은 어깨·방호 재킷·방패 식별 |
| ART-1404 | 노아 Turnaround | High | Todo | 정면·측면·후면 구조 일치 |
| ART-1405 | 노아 표정 8종 | Medium | Todo | 무표정·걱정·미소·전투 집중 표현 |
| ART-1406 | 노아 장비 상세 시트 | High | Todo | 전개식 방패·방호 장비·모듈 확정 |
| ART-1407 | 노아 컬러·재질표 | Medium | Todo | 네이비·스틸·앰버 확정 |
| ART-1408 | 노아 2D 제작 시트 승인 | High | Todo | 모든 필수 시트 Approved |

## ART-20. 3D 공용 규격과 루나 Proof

| ID | 작업 | 우선순위 | 상태 | 선행 작업 | 완료 기준 |
|---|---|---:|---|---|---|
| ART-2001 | CHARACTER_3D_SPEC.md 작성 | High | Todo | ART-1008 | 비율·폴리곤·텍스처·Rig·LOD·Shader 규격 확정 |
| ART-2002 | 공용 5~6등신 Base Mesh | High | Todo | ART-2001 | 다섯 캐릭터에 재사용 가능한 신체 베이스 |
| ART-2003 | 공용 Humanoid Rig | High | Todo | ART-2002 | Unity Humanoid Avatar 정상 생성 |
| ART-2004 | 공용 툰 셰이더 기준 | High | Todo | DEV-0101 | 얼굴·눈·헤어·의상 Material 규칙 확정 |
| ART-2005 | 루나 3D Blockout | High | Todo | ART-1008, ART-2002 | 쿼터뷰 실루엣 검증 가능 |
| ART-2006 | 루나 Unity 실루엣 테스트 | High | Todo | ART-2005, ART-0105 | 머리·후드·단검 식별성 승인 |
| ART-2007 | 루나 최종 모델·Texture | High | Todo | ART-2006 | 승인된 2D 시트와 일치 |
| ART-2008 | 루나 Rig·Weight·표정 | High | Todo | ART-2007 | 기본 동작과 표정에서 치명적 변형 없음 |
| ART-2009 | 루나 대표 애니메이션 | High | Todo | ART-2008 | Idle·Run·Attack·Dash·Skill·Hit·Victory |
| ART-2010 | 루나 VFX·Prefab 통합 | High | Todo | ART-2009 | 로비·전투에서 정상 동작 |
| ART-2011 | 루나 캐릭터 매력 사용자 검증 | High | Todo | ART-2010 | 타깃 사용자 10명 이상 평가 기록 |

## ART-21. 나머지 3D 캐릭터

| ID | 작업 | 우선순위 | 상태 | 선행 작업 |
|---|---|---:|---|---|
| ART-2101 | 미유 3D Blockout·실루엣 검증 | High | Todo | ART-1108, ART-2011 |
| ART-2102 | 미유 최종 모델·애니메이션·VFX | High | Todo | ART-2101 |
| ART-2111 | 코코 3D Blockout·실루엣 검증 | High | Todo | ART-1208, ART-2011 |
| ART-2112 | 코코 최종 모델·애니메이션·VFX | High | Todo | ART-2111 |
| ART-2121 | 이리스 3D Blockout·실루엣 검증 | High | Todo | ART-1308, ART-2011 |
| ART-2122 | 이리스 최종 모델·애니메이션·VFX | High | Todo | ART-2121 |
| ART-2131 | 노아 3D Blockout·실루엣 검증 | High | Todo | ART-1408, ART-2011 |
| ART-2132 | 노아 최종 모델·애니메이션·VFX | High | Todo | ART-2131 |

## ART-30. 환경·몬스터·소품

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-3001 | 폐허 거리 Color Key | High | Todo | 캐릭터 가독성과 자연에 잠식된 톤 검증 |
| ART-3002 | 폐허 거리 Modular Blockout | High | Todo | 플레이 가능한 Gray Box 대체 가능 |
| ART-3003 | 캠프 Color Key와 구조 | High | Todo | 따뜻한 안전 공간과 성장 단계 표현 |
| ART-3004 | 캠프 시설 4종 디자인 | High | Todo | 발전기·작업대·식량 창고·통신탑 |
| ART-3005 | 일반 몬스터 3종 1차 디자인 | High | Todo | 역할과 실루엣 구분 |
| ART-3006 | 보스 1종 1차 디자인 | High | Todo | 패턴과 약점이 외형에서 읽힘 |
| ART-3007 | 연구소 Color Key·Blockout | Medium | Todo | 두 번째 스테이지 방향 확정 |
| ART-3008 | 추가 몬스터 3종·보스 1종 | Medium | Todo | 연구소 전용 적 구성 |
| ART-3009 | 자원·상자·환경 소품 세트 | Medium | Todo | 상호작용 오브젝트 식별성 확보 |

## ART-40. UI·VFX·출시 아트

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-4001 | UI Design System | High | Todo | 버튼·패널·폰트·간격·컬러 토큰 정의 |
| ART-4002 | 로비·캐릭터 선택 UI | High | Todo | 5명 정보와 매력이 명확히 전달됨 |
| ART-4003 | 전투 HUD·스킬 선택 UI | High | Todo | 모바일에서 가독성 확보 |
| ART-4004 | 결과·캠프 강화 UI | High | Todo | 보상과 성장 피드백 명확 |
| ART-4005 | 캐릭터별 VFX 언어 시트 | High | Todo | 5명의 색상과 형태 언어 구분 |
| ART-4006 | 로고·스토어 Key Art | Medium | Todo | 게임 톤과 캐릭터 중심 메시지 전달 |
| ART-4007 | 출시 아트 최종 일관성 리뷰 | High | Todo | WIP 미포함, 라이선스·메타데이터 확인 |

## 현재 바로 시작할 작업

```text
1. ART-0003 통합 라인업 사용자 검토
2. ART-0007 Git LFS 검증
3. ART-0101 ComfyUI 워크플로 구성
4. ART-0103 Figma 캐릭터 시트 템플릿
5. ART-1001~1401 캐릭터 5명 단독 전신 후보 제작
```
