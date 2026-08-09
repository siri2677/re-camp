# Re:Camp Art Production Backlog

> 최종 갱신: 2026-08-09
> 상태 기준: 신규 5인 Concept Package — Gate A Pending

상세 실행 순서와 전체 우선순위는 `planning/sprint_backlog.md`를 우선한다. 이 문서는 신규 아트
산출물을 세분화한다. 기존 Unity Gray Box의 루나·미유·코코·이리스·노아는 기능 검증용 레거시이며
이 백로그의 신규 디자인 입력이 아니다.

## ART-00. 방향·관리

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-0001 | 신규 통합 Art Direction v3.0 | High | Done | 신규 5인, 일본 모바일 서브컬처, 2D 약 7등신·3D 5~6등신·쿼터뷰 문서화 |
| ART-0002 | 신규 5인 Character Bible v3.0 | High | Done | CH101~CH105의 역할·훅·성격·장비·스킬·캠프 기능 확정 |
| ART-0003 | 기존 라인업 REVIEW 이력 관리 | Medium | Done | 기존 자산을 `HISTORY ONLY`로 분리하고 신규 앵커로 사용하지 않음 |
| ART-0004 | MCP 제작·승인 가이드 v3.0 | High | Done | 이미지 provider 대기, Gate A/B/C, 도구 역할 정의 |
| ART-0005 | 자산 구조·상태·이름 규칙 v3.0 | High | Done | 신규 폴더·CH101~CH105 식별자·WIP/REVIEW/APPROVED 정의 |
| ART-0006 | AI 생성 metadata 양식 | Medium | Done | 도구·모델·Seed·입력·변형·권리·유사성 기록 |
| ART-0007 | Git LFS 패턴·속성 검증 | High | Done | PNG·FBX·BLEND·KRA·TGA·EXR 규칙 검증 |
| ART-0008 | 과거 raw PNG 이력 | Low | Blocked | 유효 원본 확보 또는 `HISTORY ONLY` 기록 결정 |
| ART-0009 | 신규 2D→3D 비율·변환 기준 | High | Done | Bible·Anchor·Checklist·Template v3.0 일치 |

## ART-01. 제작 파이프라인

| ID | 작업 | 우선순위 | 상태 | 완료 기준 |
|---|---|---:|---|---|
| ART-0101 | 신규 5인 후보 생성 workflow | High | Ready | provider 연결 후 캐릭터별 3안·동일 캔버스·공통 Negative Prompt |
| ART-0102 | 도구 비종속 신규 캐릭터 Anchor v3.0 | High | Done | 얼굴·헤어·체형·패션·장비·팔레트·비율·금지 회귀 확정 |
| ART-0103 | Figma 캐릭터 제작 시트 템플릿 v003 | High | Review | 6-Frame 구조와 CH101~CH105 Instance, Import·Export 검증 |
| ART-0104 | Blender 장비·소품 Export | Medium | Ready | 신규 장비와 환경 소품을 명명 규격으로 저장·Export |
| ART-0105 | FBX Import·Material·Prefab 테스트 | Medium | Todo | 승인 시트와 연결된 FBX가 Unity Prefab으로 동작 |
| ART-0106 | `art_source/` 디렉터리 | Medium | Done | figma_exports·blender·textures·metadata 경로 존재 |
| ART-0107 | Gate A/B/C 리뷰 체크리스트 v3.0 | High | Done | 신규 로스터의 매력·원작성·제작·Unity 검증 반영 |
| ART-0108 | ComfyUI·ComfyUI MCP 고정 workflow | Low | Deferred | 대량 일관성·정밀 인페인팅 병목일 때만 Ready |
| ART-0109 | `ASSET_NAMING_GUIDE.md` v002 | High | Done | 신규 Subject·CH101~CH105·Export·GUID 예외 확정 |
| ART-0110 | `ANIMATION_GUIDE.md` 레거시 경계 | Medium | Review | 기존 Gray Box 모션과 신규 승인 모션 계약을 분리 기록 |
| ART-0111 | v003 Figma 실사용 검증 | High | Todo | SVG Import·Component Clone·한글·PNG/PDF Export·사용성 검토 |
| ART-0112 | 신규 2D→3D 변환표 샘플 | High | Todo | Gate A 후보 선택 후 확대·삭제·결합·물리 위험·Face128·실루엣 기록 |

이미지 provider 연결 전에는 후보 이미지를 생성했다고 기록하지 않는다. 로컬 GPU·ComfyUI 설치는
현재 완료 조건이 아니다.

## ART-10. CH101 아마사와 린 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1001 | 3안 전신 후보 | Ready | 신호 주자 훅·성인성·단일 세이버·리본 후보 3안 |
| ART-1002 | 얼굴·헤어 선택 | Todo | 펄 블랙 단발·청록 언더라이트·128px 얼굴 |
| ART-1003 | 패션·체형·실루엣 | Todo | 비대칭 크롭 재킷·리본·세이버 포함/제거 실루엣 |
| ART-1004 | Front·Side·Back | Todo | 6.9~7.1H와 리본·비콘 후면 구조 |
| ART-1005 | 표정 시트 | Todo | 장난스러움·집중·귀환 불안·캠프 표정 |
| ART-1006 | 장비 상세 | Todo | 단일 와이어 세이버·신호 리본·경로 비콘 |
| ART-1007 | 컬러·재질 | Todo | 펄 화이트·차콜·청록·버밀리온·발광 규칙 |
| ART-1008 | 2D→3D 변환표 | Todo | 6.9~7.1H→5.3~5.4H 단순화와 물리 위험 |
| ART-1009 | 사람 Gate A | Todo | 사용자 승인 후에만 `APPROVED` |

## ART-11. CH102 키사라기 마오 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1101 | 3안 전신 후보 | Ready | 폐허 설계자 훅·접이식 활·구조 링 후보 3안 |
| ART-1102 | 얼굴·헤어 선택 | Todo | 잿빛 라벤더 롱 보브·레몬 언더라이트·128px 얼굴 |
| ART-1103 | 패션·체형·실루엣 | Todo | 비대칭 대형 소매·워크 재킷·활 프레임 |
| ART-1104 | Front·Side·Back | Todo | 6.8~7.0H와 활·구조 링 후면 구조 |
| ART-1105 | 표정 시트 | Todo | 졸림·구조 열정·실패 당황·캠프 집중 |
| ART-1106 | 장비 상세 | Todo | 접이식 자기 활·구조 링·자기장 프레임 |
| ART-1107 | 컬러·재질 | Todo | 울트라바이올렛·그래파이트·레몬·투명 폴리머 |
| ART-1108 | 2D→3D 변환표 | Todo | 6.8~7.0H→5.2~5.3H 단순화와 물리 위험 |
| ART-1109 | 사람 Gate A | Todo | 사용자 승인 후에만 `APPROVED` |

## ART-12. CH103 카나데 노조미 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1201 | 3안 전신 후보 | Ready | 공명 의무관 훅·배턴·응급 베일 후보 3안 |
| ART-1202 | 얼굴·헤어 선택 | Todo | 크림 로즈-코랄 웨이브·한쪽 브레이드·128px 얼굴 |
| ART-1203 | 패션·체형·실루엣 | Todo | 코랄 랩 재킷·앰플 벨트·베일 패널 |
| ART-1204 | Front·Side·Back | Todo | 7.0~7.2H와 베일·배턴 후면 구조 |
| ART-1205 | 표정 시트 | Todo | 따뜻한 미소·현장 지휘·걱정·안도 |
| ART-1206 | 장비 상세 | Todo | 공명 배턴·응급 베일·파형 패널 |
| ART-1207 | 컬러·재질 | Todo | 코랄·아이보리·아쿠아·반투명 폴리머 |
| ART-1208 | 2D→3D 변환표 | Todo | 7.0~7.2H→5.5~5.6H 단순화와 얼굴 가림 위험 |
| ART-1209 | 사람 Gate A | Todo | 사용자 승인 후에만 `APPROVED` |

## ART-13. CH104 시온 타테가미 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1301 | 3안 전신 후보 | Ready | 궤도 측량사 훅·프리즘 부채·지도 링 후보 3안 |
| ART-1302 | 얼굴·헤어 선택 | Todo | 딥 인디고 롱 레이어·마젠타 끝빛·128px 얼굴 |
| ART-1303 | 패션·체형·실루엣 | Todo | 포슬린 재킷 드레스·지도 리본·부채 |
| ART-1304 | Front·Side·Back | Todo | 7.1~7.3H와 지도 링 후면 구조 |
| ART-1305 | 표정 시트 | Todo | 우아한 집중·생활 허술함·당황·안도 |
| ART-1306 | 장비 상세 | Todo | 프리즘 측량 부채·궤도 지도 링·벡터선 |
| ART-1307 | 컬러·재질 | Todo | 포슬린·인디고·마젠타·투명 프리즘 |
| ART-1308 | 2D→3D 변환표 | Todo | 7.1~7.3H→5.6~5.7H 단순화와 긴 천 위험 |
| ART-1309 | 사람 Gate A | Todo | 사용자 승인 후에만 `APPROVED` |

## ART-14. CH105 쿠로가네 아카리 2D 디자인

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1401 | 3안 전신 후보 | Ready | 앵커 수호자 훅·건틀릿·케이블 후보 3안 |
| ART-1402 | 얼굴·헤어 선택 | Todo | 블랙-그린 하이 레이어·코퍼 핀·128px 얼굴 |
| ART-1403 | 패션·체형·실루엣 | Todo | 크롭 볼레로·하이웨이스트·앵커 링 |
| ART-1404 | Front·Side·Back | Todo | 7.2~7.4H와 케이블·링 후면 구조 |
| ART-1405 | 표정 시트 | Todo | 무뚝뚝함·행동형 배려·장난·전투 집중 |
| ART-1406 | 장비 상세 | Todo | 키네틱 건틀릿·앵커 케이블·링·릴 |
| ART-1407 | 컬러·재질 | Todo | 포레스트 그린·블랙·코퍼·황금 격자 |
| ART-1408 | 2D→3D 변환표 | Todo | 7.2~7.4H→5.7~5.8H 단순화와 케이블 위험 |
| ART-1409 | 사람 Gate A | Todo | 사용자 승인 후에만 `APPROVED` |

## ART-15. 5인 일관성·원작성 리뷰

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-1501 | 신규 후보 라인업 리뷰 | Todo | 동일 캔버스 5인 훅·역할·팔레트·장비 비교 |
| ART-1502 | 128px·실루엣·저채도 리뷰 | Todo | 얼굴 스트립·장비 포함/제거·색각 보정 |
| ART-1503 | 외부 IP 유사성 리뷰 | Todo | 차이 기록·metadata·사람/법률 검토 입력 |
| ART-1504 | Gate A 비교 시트 | Todo | 4096×2304 후보 보드와 사용자 선택 영역 |
| ART-1510 | 레퍼런스 품질 Alignment | Done | Reset Brief의 품질 축·비복제 규칙·프롬프트 작성 |

## ART-20. 공용 3D 규격과 CH101 Proof

| ID | 작업 | 상태 | 선행 조건 | 완료 기준 |
|---|---|---|---|---|
| ART-2001 | `CHARACTER_3D_SPEC`·Unity Presentation 계약 | Todo | Gate A | 비율·성능·Rig·LOD·ID 연결 규격 |
| ART-2002 | 공용 5~6등신 Base Mesh | Todo | ART-2001 | 5.2~5.8H 체형 범위 수용 |
| ART-2003 | 공용 Humanoid Rig | Todo | ART-2002 | Unity Humanoid Avatar 정상 생성 |
| ART-2004 | Toon Shader·Material 규칙 | Todo | Unity 기반 | 얼굴·헤어·의상·장비·Emission 슬롯 |
| ART-2005 | CH101 3D Blockout | Todo | ART-1009, ART-2002 | 5.3~5.4H·리본·세이버 쿼터뷰 검증 |
| ART-2006 | CH101 Unity Gate C | Todo | ART-2005, ART-0105 | 식별성·관통·성능 승인 |
| ART-2007 | CH101 최종 모델·Texture | Todo | ART-2006 | 승인 2D 시트와 동일 캐릭터 |
| ART-2008 | Rig·Weight·표정 | Todo | ART-2007 | 기본 동작과 표정 변형 없음 |
| ART-2009 | 대표 애니메이션 | Todo | ART-2008, ART-0110 | Idle·Run·Attack·Dash·Skill·Hit·Victory |
| ART-2010 | VFX·사운드·Prefab 통합 | Todo | ART-2009 | 로비·선택·전투 정상 동작 |
| ART-2011 | 타깃 사용자 매력 검증 | Todo | ART-2010 | 신호 주자 훅과 개선 평가 기록 |

## ART-21. 나머지 3D 캐릭터

| ID | 작업 | 상태 | 선행 조건 |
|---|---|---|---|
| ART-2101~2102 | CH102 Blockout → 최종 모델·애니메이션·VFX | Todo | ART-1109, ART-2011 |
| ART-2111~2112 | CH103 Blockout → 최종 모델·애니메이션·VFX | Todo | ART-1209, ART-2011 |
| ART-2121~2122 | CH104 Blockout → 최종 모델·애니메이션·VFX | Todo | ART-1309, ART-2011 |
| ART-2131~2132 | CH105 Blockout → 최종 모델·애니메이션·VFX | Todo | ART-1409, ART-2011 |

## ART-30. 환경·몬스터·소품

| ID | 작업 | 상태 | 완료 기준 |
|---|---|---|---|
| ART-3001 | 폐허 거리 Color Key | Todo | 신규 캐릭터 가독성과 자연 잠식 톤 |
| ART-3002 | 폐허 거리 Modular Blockout | Todo | 플레이 가능한 Gray Box 대체 가능 |
| ART-3003 | 캠프 Color Key | Todo | 따뜻한 조명과 캐릭터 개인 공간 |
| ART-3004 | 캠프 시설 스타일라이즈드 모델 | Todo | 작업대·안테나·방어선 기능 식별 |
| ART-3005 | 일반 몬스터 3종 | Todo | 캐릭터 VFX와 충돌하지 않는 실루엣 |
| ART-3006 | 보스 1종 | Todo | 약점 표식·앵커·공명과 연결 |
| ART-3007 | 공용 환경 Shader·Material | Todo | 폐허·자연·캠프 톤 구분 |
| ART-3008 | 소품·자원 세트 | Todo | 상호작용 오브젝트 식별 |

## 상태 원칙

- `Ready`: 문서·프롬프트가 준비됐지만 외부 도구 실행을 기다림
- `WIP`: 제작 중
- `REVIEW`: 비교와 사람 피드백 대기
- `CONDITIONAL`: 수정 조건이 남은 승인
- `APPROVED`: 사용자가 명시적으로 승인한 범위
- `SUPERSEDED`·`ARCHIVE`: 과거 방향·대체 자산
- `Blocked`: 필요한 외부 연결이나 권리 정보가 없어서 실행 불가

빈 이미지, 워터마크, 권리 불명 자산, companion metadata가 없는 생성물은 Review 후보에도 올리지 않는다.
