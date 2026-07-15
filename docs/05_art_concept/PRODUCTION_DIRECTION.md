# Re:Camp Production Direction

## 최종 화면 방향

GitHub `origin/main`의 Art Direction과 Character Bible을 제작 기준으로 사용한다.

```text
2D 일반 등신 성인 여성 캐릭터 일러스트
+ 3D 4~5등신 SD-lite 스타일라이즈드 인게임 캐릭터
+ 자연에 잠식된 부드러운 3D 포스트 아포칼립스 환경
+ 툰 셰이딩
+ Orthographic 쿼터뷰 카메라
+ Unity UGUI 기반 2D 인터페이스
```

`art_refs/moodboard/battle_vertical_slice_concept.png`의 여성 SD 주인공, 쿼터뷰 구도, 밝은 폐허 색감이 원본 제작 방향이다. 2D 대표 일러스트는 일반 등신으로 캐릭터 매력을 보여주고, 인게임은 Unity 제작성과 원본 화면 감성을 살리는 4~5등신 SD-lite로 제작한다.

## 선택 이유

- 2D 대표 일러스트에서 성인 여성 캐릭터의 얼굴·체형·의상 매력을 충분히 보여주고, SD-lite 3D에서는 헤어·색상·무기·대표 실루엣으로 동일성을 유지할 수 있다.
- 7~8등신 실사형보다 머리·손·무기를 조금 키워 쿼터뷰 식별성을 확보한다.
- 공용 Humanoid Rig와 이동·피격 애니메이션을 5명에게 재사용할 수 있다.
- 캐릭터별 얼굴, 헤어, 의상, 무기, 대표 모션은 개별 제작해 애착과 플레이 차이를 만든다.
- 현재 URP 3D Renderer, XZ 전투, Orthographic 카메라, UGUI 기반을 그대로 활용할 수 있다.

## 캐릭터 기준

| 캐릭터 | 역할 | 대표 실루엣·장비 | 색상 |
|---|---|---|---|
| 루나 | 정찰형 근접 딜러 | 고양이 귀 후드, 짧은 재킷, 에너지 단검, 탐지 장치 | 민트 / 크림 / 핑크 |
| 미유 | 드론 원거리 딜러 | 비대칭 단발, 큰 작업 소매, 부유 드론 | 라일락 / 그레이 / 네온 블루 |
| 코코 | 회복·보호막 서포터 | 웨이브 헤어, 의료 케이프, 둥근 의료 장비 | 코랄 / 아이보리 / 그린 |
| 이리스 | 정밀 사격·보스 딜러 | 긴 헤어, 비대칭 코트, 에너지 라이플 | 퍼플 / 화이트 / 크림슨 |
| 노아 | 가드·반격 탱커 | 장신 여성 수호자, 정돈된 단발, 대형 전개식 방패 | 네이비 / 스틸 / 앰버 |

세부 설정은 `CHARACTER_BIBLE.md`를 단일 기준으로 한다.

## 전투 공간·3D 규칙

- `1 Unity unit ≈ 1m`를 잠정 기준으로 사용한다.
- 지면은 `XZ`, 높이는 `Y`, 캐릭터 전방은 `+Z`다.
- Root pivot은 발 중앙에 둔다.
- 공용 테스트 키는 `1.45 unit`에서 시작하고, 4~5등신 SD-lite 비율과 카메라에서 재검증한다.
- 카메라는 Orthographic `X 35.3° / Y 45°`를 현재 기능 기준선으로 사용한다.
- 얼굴과 무기는 작은 화면에서도 식별될 정도로 단순화·과장한다.
- 실제 UI는 월드 오브젝트와 분리한 Screen Space UGUI로 구성한다.

이 값들은 Blockout 잠정안이다. 루나 Approved 2D 시트가 준비되면 `CHARACTER_3D_SPEC.md`에서 키, 축, 피벗, 폴리곤, 텍스처, LOD, Collider, 소켓을 확정한다.

## 모바일·PC 공통 가독성

- 캐릭터는 배경보다 높은 명도·채도 대비를 가진다.
- 머리, 상체, 무기 세 실루엣으로 5명을 구분할 수 있어야 한다.
- 배경 디테일과 채도는 캐릭터보다 낮게 유지한다.
- 머티리얼 수와 투명 오버드로우를 제한한다.
- 전투 UI는 체력, 위험, 스킬, 보상처럼 즉시 필요한 정보만 유지한다.
- PC를 우선 검증하되 터치 영역과 모바일 해상도 확장성을 보존한다.

## 2D → 3D → Unity 파이프라인

```text
통합 라인업 REVIEW
→ 개별 전신 WIP 후보
→ 얼굴·헤어·의상·무기 사람 선택
→ 정면·측면·후면·표정·장비·재질 제작 시트
→ Gate A/B 승인
→ 4~5등신 SD-lite Blender Blockout
→ FBX Export
→ Unity Prefab·Toon Material·Animator·Collider
→ 쿼터뷰 Gate C 검증
```

- `.blend` 원본은 `art_source/blender/`, 승인된 FBX와 Unity 자산은 `Assets/_ReCamp/Art/`에 둔다.
- Unity에는 승인된 FBX를 기준으로 Import한다.
- 모든 생성 이미지에 메타데이터 companion 파일을 둔다.
- 루나 품질과 제작 비용을 검증하기 전에는 나머지 4명의 최종 3D를 대량 제작하지 않는다.

## 첫 번째 품질 목표

첫 Character Proof는 루나다.

- 2D 일반 등신 전신·Turnaround·표정·장비·재질 시트
- 3D 4~5등신 SD-lite 루나, 에너지 단검, 탐지 장치, 소형 백팩
- Idle·Run·Attack·Dash·Skill·Hit·Victory
- 툰 셰이더, 민트·청록 공격 궤적, 최소 타격·획득 VFX
- 폐허 거리 1개, 일반 적 3종, 보스 1종, 캠프 시설 3종
- 로비·전투·결과·캠프 UI와 저장·튜토리얼

## 현재 아티팩트 상태

- `art_refs/art_direction/ReCamp_Character_Lineup.png`: 원격 v001 불량, 사용 금지·교체 필요
- `art_refs/art_direction/ReCamp_CharacterLineup_REJECTED_v002.png`: 전원 여성 조건을 위반해 반려된 감사 기록
- `art_refs/moodboard/battle_vertical_slice_concept.png`: 캐릭터 감성·환경·카메라의 `PRIMARY REVIEW` 원본 앵커
- `Assets/_ReCamp/Captures/battle_quarter_view_hud.png`: Gray Box 기능·가독성 검증 캡처
- `docs/05_art_concept/AI_ASSET_METADATA_TEMPLATE.md`: 생성 자산 기록 양식

최종 모델 제작은 정상 라인업과 루나 개별 제작 시트가 사람 승인을 받은 뒤 시작한다.
