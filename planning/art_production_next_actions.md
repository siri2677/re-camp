# Re:Camp Art Production Next Actions

이 문서는 현재 시점에서 바로 시작할 아트 작업을 순서대로 정리한다. 장기 상태는 `art_production_backlog.md`에서 관리하고, 이 문서는 다음 실행 작업을 빠르게 선택하는 용도로 사용한다.

## 현재 목표

```text
통합 캐릭터 라인업 리뷰 완료
→ 루나 기준 이미지를 반복 생성할 수 있는 파이프라인 구축
→ 루나 2D 제작 시트 승인
→ 3D Blockout
→ Unity 쿼터뷰 가독성 검증
```

## 실행 순서

| 순서 | 연계 ID | 작업 | 상태 | 결과물 |
|---:|---|---|---|---|
| 1 | RC-0011 / ART-0003 | 통합 라인업 유지·수정 항목 결정 | Review | 캐릭터별 피드백 목록 |
| 2 | ART-0101 | ComfyUI 캐릭터 생성 워크플로 구성 | Ready | Workflow JSON, 테스트 출력 |
| 3 | ART-0102 | 루나 고정 변수와 메타데이터 적용 | Ready | 설정 YAML, 기준 프롬프트 |
| 4 | ART-1001 | 루나 단독 전신 후보 3안 이상 제작 | Ready | REVIEW 후보 이미지 |
| 5 | ART-1002 | 루나 얼굴·헤어 확정 | Todo | 얼굴 기준 이미지 |
| 6 | ART-1003 | 루나 의상·실루엣 확정 | Todo | 전신 기준 이미지 |
| 7 | ART-1004~1007 | Turnaround·표정·장비·재질 시트 | Todo | 제작 시트 세트 |
| 8 | ART-1008 | 루나 2D 제작 시트 승인 | Todo | APPROVED 기준 시트 |
| 9 | ART-2001 | 3D 수치 규격 리뷰 | Review | 승인된 3D Spec |
| 10 | ART-2005 | 루나 3D Blockout | Todo | 저해상도 FBX |
| 11 | ART-0105 / ART-2006 | Unity Import와 쿼터뷰 실루엣 테스트 | Blocked | Prefab, 테스트 스크린샷 |

`ART-0105`와 `ART-2006`은 Unity 프로젝트 생성 작업 `DEV-0101` 이후 진행한다.

## 작업 1. 통합 라인업 리뷰

### 입력

- `art_refs/art_direction/ReCamp_Character_Lineup.png`
- `docs/05_art_concept/ART_DIRECTION.md`
- `docs/05_art_concept/CHARACTER_BIBLE.md`

### 체크리스트

- 5명의 얼굴과 헤어가 구분되는가
- 대표 색상 3개가 캐릭터마다 구분되는가
- 무기와 장비가 전투 역할을 표현하는가
- 작은 화면에서 머리·상체·무기 실루엣이 구분되는가
- 3D 구현이 어려운 장식이 과도하지 않은가

### 완료 조건

```text
각 캐릭터에 대해 Keep / Revise 항목 작성
+ 라인업 APPROVED 또는 재생성 결정
```

## 작업 2. ComfyUI 워크플로 구축

### 입력

- `COMFYUI_CHARACTER_CONSISTENCY_SPEC.md`
- 승인 또는 REVIEW 상태의 루나 기준 이미지

### 필수 기록

```text
Checkpoint
VAE
LoRA와 Weight
Reference Adapter 설정
ControlNet 설정
Seed
Sampler/Scheduler
Steps/CFG
해상도
후처리
라이선스 확인 결과
```

### 완료 조건

같은 얼굴·헤어·후드·재킷·단검 설정을 유지한 루나 전신 이미지를 3회 이상 반복 생성할 수 있다.

## 작업 3. 루나 후보 비교

후보마다 한 번에 하나 또는 두 개 요소만 변경한다.

```text
A안: 현재 통합 라인업 유지
B안: 정찰 장비와 단검 기능성 강화
C안: 고양이 후드와 캐릭터 매력 강화
```

평가 기준:

- 첫인상
- 얼굴 기억성
- 고양이 후드 식별성
- 정찰형 근접 딜러 역할 전달
- 3D 제작 가능성
- 쿼터뷰 가독성

## 작업 4. 루나 제작 시트

필수 결과물:

- Key Art
- Front / Side / Back
- Turnaround
- Expression Sheet 8종
- Equipment Sheet
- Material Palette
- 3D Notes

파일명과 상태는 `ASSET_NAMING_GUIDE.md`와 `ART_ASSET_STRUCTURE.md`를 따른다.

## 작업 5. 3D Blockout과 Unity 테스트

### 3D 입력 문서

- `CHARACTER_3D_SPEC.md`
- `ANIMATION_GUIDE.md`
- 루나 APPROVED 제작 시트

### Unity 입력 문서

- `UNITY_ART_IMPORT_GUIDE.md`
- `ASSET_NAMING_GUIDE.md`

### 테스트 Scene에서 확인할 항목

- 쿼터뷰에서 후드와 단검이 보이는가
- 일반 전투 거리에서 얼굴·상체 실루엣이 읽히는가
- Run, Attack, Dash 포즈에서 무기가 몸에 가려지지 않는가
- 배경보다 캐릭터의 명도와 채도 대비가 높은가
- LOD1과 모바일 Texture 설정에서 품질이 허용 가능한가

## 새 문서 리뷰 작업

이번에 추가된 문서는 초기 기준이므로 실제 제작 테스트 후 승인한다.

| 문서 | 초기 상태 | 승인 조건 |
|---|---|---|
| `ART_PRODUCTION_START_GUIDE.md` | Ready | 첫 2주 작업에 사용 가능 |
| `COMFYUI_CHARACTER_CONSISTENCY_SPEC.md` | Ready | 루나 반복 생성 성공 |
| `CHARACTER_3D_SPEC.md` | Review | Blockout과 모바일 테스트 통과 |
| `ANIMATION_GUIDE.md` | Review | 공용 Rig와 루나 Clip 테스트 통과 |
| `UNITY_ART_IMPORT_GUIDE.md` | Review | FBX·Texture·Prefab Import 성공 |
| `ASSET_NAMING_GUIDE.md` | Ready | 신규 산출물에 적용 가능 |

## 작업 종료 시 기록

각 작업을 마치면 다음 내용을 Backlog 또는 PR에 기록한다.

```text
작업 ID
결과 파일 경로
사용 도구와 버전
검증 방법
남은 문제
Review 또는 Approved 여부
다음 작업
```
