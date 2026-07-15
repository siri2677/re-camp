# Re:Camp Art Production Backlog

상세 상태의 단일 실행 순서는 `planning/sprint_backlog.md`를 우선한다. 이 문서는 아트 산출물을 세분화한다.

`Deferred`는 기술적 차단이 아니라 현재 필요성이 확인되지 않은 선택 작업이다. 해당 작업은 도입 트리거가 발생하기 전까지 실행 큐와 선행 조건에서 제외한다.

## A0. 방향·관리

| ID | 작업 | 상태 |
|---|---|---|
| ART-0001 | 통합 Art Direction | Done |
| ART-0002 | 5인 Character Bible | Done |
| ART-0003 | 성인 여성 5인·남성향 라인업 `REVIEW v003` | Review |
| ART-0004 | MCP 제작·승인 가이드 | Done |
| ART-0005 | 자산 구조·상태·이름 규칙 | Done |
| ART-0006 | AI 생성 메타데이터 양식 | Done |
| ART-0007 | Git LFS 패턴·속성 검증 | Done |
| ART-0008 | 원격 v001 raw PNG/LFS 교정 | Blocked |

## A1. 파이프라인

| ID | 작업 | 상태 |
|---|---|---|
| ART-0101 | 현재 이미지 생성 도구 기반 반복 워크플로 | Review |
| ART-0102 | 도구 비종속 캐릭터 앵커·입력 참조·메타데이터 규칙 | Todo |
| ART-0103 | Figma 캐릭터 제작 시트 템플릿 | Ready |
| ART-0104 | Blender MCP 소품 생성·FBX Export | Blocked |
| ART-0105 | FBX Import·Material·Prefab 테스트 | Todo |
| ART-0106 | `art_source/` 디렉터리 | Done |
| ART-0107 | Gate A/B/C 리뷰 체크리스트 | Ready |
| ART-0108 | ComfyUI·ComfyUI MCP 도입 및 고정 워크플로 | Deferred |

`ART-0108`은 동일 캐릭터 대량 생성, 정밀 인페인팅, 또는 Seed·LoRA·ControlNet·IP-Adapter를 고정한 재현 워크플로가 실제로 필요할 때만 `Ready`로 바꾼다. 로컬 모델 보유나 GPU 준비는 현재 완료 조건이 아니다.

## A2. 캐릭터 2D

각 캐릭터에 동일한 산출물 묶음을 적용한다.

이 작업은 ComfyUI를 선행 조건으로 삼지 않고 현재 이용 가능한 이미지 생성 도구로 시작한다.

```text
FullBody 후보
Face/Hair 후보
Outfit 후보
Weapon/Equipment 후보
Front/Side/Back Turnaround
Expression 8종
Material Palette
3D Notes
```

| ID | 캐릭터 | 첫 작업 | 상태 |
|---|---|---|---|
| ART-1001 | 루나 | 단독 전신 WIP 후보 | Ready |
| ART-1101 | 미유 | 단독 전신 WIP 후보 | Ready |
| ART-1201 | 코코 | 단독 전신 WIP 후보 | Ready |
| ART-1301 | 이리스 | 단독 전신 WIP 후보 | Ready |
| ART-1401 | 노아 | 단독 전신 WIP 후보 | Ready |
| ART-1501 | 5인 | 후보 일관성 리뷰 | Todo |

## A3. 루나 3D Proof

| ID | 작업 | 상태 | 선행 조건 |
|---|---|---|---|
| ART-2001 | `CHARACTER_3D_SPEC.md` | Todo | 루나 2D Approved |
| ART-2002 | 공용 4~5등신 SD-lite Base Mesh | Todo | ART-2001 |
| ART-2003 | 루나 Blockout | Todo | Base Mesh·Turnaround |
| ART-2004 | Unity 쿼터뷰 실루엣 검증 | Todo | FBX Import |
| ART-2005 | 최종 Model·Texture | Todo | Gate C Blockout 승인 |
| ART-2006 | Humanoid Rig·Weight·BlendShape | Todo | Final Model |
| ART-2007 | Idle·Run·Attack·Dash·Skill·Hit·Victory | Todo | Rig |
| ART-2008 | Toon Material·VFX·Prefab | Todo | Animation |

## A4. 환경·몬스터·UI·VFX

- 폐허 거리 Color Key와 모듈 Blockout
- 일반 적 3종과 첫 보스의 실루엣 시트
- 캠프 시설 3종의 성장 상태
- UI Design System과 전투·로비·결과 화면
- 캐릭터별 공격·스킬·피격·획득 VFX

루나 Vertical Slice가 승인된 뒤 출시 범위로 확장한다.

## 메타데이터 필수 필드

`Asset Name`, `Subject`, `Purpose`, `Status`, `Generated Date`, `Tool/Model`, `Workflow Version`, `Seed`, `Input References`, `Human Edits`, `Usage Restriction`, `Reviewer`를 companion Markdown에 기록한다.

빈 이미지, 워터마크, 권리 불명 자산, companion metadata가 없는 생성물은 Review 후보에도 올리지 않는다.
