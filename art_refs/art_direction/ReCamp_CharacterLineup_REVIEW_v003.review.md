# Re:Camp Character Lineup REVIEW v003 — Gate A Review

이 기록은 `ReCamp_CharacterLineup_REVIEW_v003.png`를
`docs/05_art_concept/ART_REVIEW_CHECKLIST.md`와
`docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md`에 대조한 보조 리뷰다. 자동 리뷰 권고는
사람의 승인 결정을 대신하지 않는다.

```yaml
Review ID: ART-0003-GATE-A-v003
Backlog ID: RC-0011 / ART-0003
Asset: art_refs/art_direction/ReCamp_CharacterLineup_REVIEW_v003.png
Asset Version: v003
Scope: Character / 3D SD-lite Direction
Current Status: REVIEW
Anchor Spec Version: 2026-07-19
Input References:
  - art_refs/moodboard/battle_vertical_slice_concept.png
  - docs/05_art_concept/CHARACTER_BIBLE.md
  - docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md
Tool / Model: Codex built-in image_gen
License Evidence: Pending
Reviewer: Codex assistant review recommendation
Review Date: 2026-07-19
Gate: A
Decision: FAIL
Next Owner: Human art review / individual character WIP
```

## 1. 요약 판정

- Gate A 권고: `FAIL`
- 자산 상태: `REVIEW` 유지
- 사람 승인: `Pending`
- 3D 4~5등신 SD-lite 방향 후보: `CONDITIONAL`
- 2D 일반 등신 대표 원화·제작 시트: `FAIL` — 이 이미지의 제작 범위가 아님
- Gate B 제작 구조: `NOT TESTED`
- Gate C Unity 통합: `NOT TESTED`

성인 여성 5인, 좌우 순서, 역할 장비, SD-lite 비율이라는 큰 방향은 유효하다. 그러나 루나의
의료 십자 모티프가 코코의 전용 역할 언어를 침범하고, 얼굴·체형·표정과 일부 팔레트의
차이가 작다. 공통 체크리스트의 치명적 모티프 충돌 조건에 해당하므로 현재 버전은 다음
Gate의 제작 기준으로 사용할 수 없다.

## 2. 공통 사전 검사

| ID | 결과 | 증거 | 남은 조치 |
|---|---|---|---|
| PRE-01 | PASS | 이미지와 metadata가 `REVIEW v003`로 일치 | 없음 |
| PRE-02 | PASS | companion `ReCamp_CharacterLineup_REVIEW_v003.metadata.md` 존재 | 없음 |
| PRE-03 | PASS | 도구·워크플로·입력 이미지·최종 프롬프트 기록 | 수정본은 새 버전으로 이력 추가 |
| PRE-04 | CONDITIONAL | 내부 Review 제한은 기록됐으나 상업 이용·입력 권리 근거는 Pending | 출시 후보 전 권리 증거 확정 |
| PRE-05 | PASS | 혼성 v002는 입력으로 사용하지 않았다고 metadata에 명시 | 없음 |
| PRE-06 | CONDITIONAL | 원본 전투 앵커는 사용했으나 캐릭터별 Approved 시트는 아직 0/5 | 개별 Approved 시트 생성 후 재대조 |
| PRE-07 | PASS | PNG의 `filter/diff/merge=lfs`, `text=unset` 확인 | 새 PNG도 같은 속성 확인 |

## 3. 캐릭터 Gate A 대조

| ID | 결과 | 관찰 근거 | 필수 수정·증거 |
|---|---|---|---|
| CHA-A01 | CONDITIONAL | 정확히 5명의 여성으로 구성되지만 루나는 둥근 얼굴·큰 눈·작은 체구 때문에 다른 4명보다 유아형으로 읽힐 여지가 있음 | 성인 눈매·몸통과 사지 비율을 유지한 교정 전신 |
| CHA-A02 | CONDITIONAL | 여성 캐릭터 매력은 있으나 다섯 명의 얼굴형과 미소가 유사해 개별 애착 포인트가 약함 | 얼굴형·눈매·체형·표정 차별화 |
| CHA-A03 | FAIL | 루나 의상의 반복 의료 십자가가 정찰/탐색 앵커와 충돌하고 코코의 의료 모티프를 침범함 | 십자가를 스캔·레이더·경로 탐색 기호로 교체 |
| CHA-A04 | CONDITIONAL | 장비는 대체로 읽히지만 얼굴·체형 기반 보조 특징은 약함 | 인물별 대표 1개·보조 2개를 주석 전신에 표시 |
| CHA-A05 | CONDITIONAL | 대표색은 구분되지만 미유와 이리스의 보라 계열이 근접하고 코코·노아의 방패 면적이 역할색을 약화할 수 있음 | 팔레트 칩과 저채도 비교에서 명도·포인트색 분리 |
| CHA-A06 | CONDITIONAL | 드론·의료 장비·장총·대형 방패의 역할은 읽히나 루나의 정찰 장비가 의료 기호 때문에 흐려짐 | 루나 Scanner/탐지 장치를 명확한 형태로 교정 |
| CHA-A07 | NOT TESTED | 장비 제거 흑백 실루엣 비교가 없음 | 동일 크기 5인 흑백 실루엣 스트립 |
| CHA-A08 | CONDITIONAL | 확대 관찰에서 눈과 얼굴형이 서로 유사하며 필수 128px 얼굴 스트립이 없음 | 128px 얼굴 스트립과 눈매·헤어 차별화 |
| CHA-A09 | NOT TESTED | 저채도·색각 보정 비교가 없음 | 저채도·색각 보정 미리보기 |
| CHA-A10 | FAIL | 루나↔코코의 의료 기호, 코코↔노아의 원형/대형 방패 인상, 미유↔이리스의 보라색 비중이 교차 충돌함 | 의료·방패·보라색을 역할별 형태 언어로 분리 |
| CHA-A11 | PASS | metadata가 3D SD-lite 인게임 방향 후보로 범위를 제한하고 최종 2D 시트 사용을 금지함 | 다음 산출물도 2D/3D 범위를 명시 |
| CHA-A12 | CONDITIONAL | 다섯 명 모두 비슷한 미소와 중립 자세라 Character Bible 성격 차이가 약함 | 캐릭터별 중립 표정과 대표 표정 1종 추가 |

## 4. 캐릭터별 수정 지시

| 캐릭터 | 유지할 강점 | 다음 후보의 차단 수정 |
|---|---|---|
| 루나 | 민트·크림·핑크, 고양이 귀 후드, 단검, 소형 정찰 장비 | 의료 십자가 전부 제거, Scanner/레이더 기호로 교체, 성인 눈매·비율 강화 |
| 미유 | 비대칭 보라 단발, 큰 소매, 드론·건틀릿 | 이리스보다 밝은 라일락/홀로 블루로 분리하고 수리 도구·드론 링크 표현 강화 |
| 코코 | 코랄·그린, 웨이브 헤어, 인젝터·의료 역할 | 의료 아이콘을 코코 전용으로 집중하고 보호막을 투명 앰플/홀로 형태로 만들어 노아와 분리 |
| 이리스 | 긴 장총, 바이저, 정밀 사격 실루엣 | 딥 플럼·크림슨으로 미유와 분리, 눈이 보이는 투명/가동식 바이저와 고유 총열 구조 정의 |
| 노아 | 짙은 네이비·앰버, 대형 방패, 수호자 인상 | 키·어깨·스탠스를 더 크게 하고 보조 권총 대신 방패 제어 건틀릿/에너지 엣지로 역할 집중 |

공통으로 장비를 제거한 실루엣, 128px 얼굴, 저채도·색각 비교를 만들어 5/5 식별성을
재검증한다. 수정은 통합 v004 한 장에 바로 고정하기보다 캐릭터별 WIP에서 먼저 해결한다.

## 5. 현재 Unity 적용성

현재 프로젝트는 캐릭터 규칙과 Gray Box 표현까지 연결되어 있다. 이 상태는 디자인을 받을
논리적 슬롯이 있다는 뜻이지, 최종 Presentation 자산이 준비됐다는 뜻은 아니다.

2026-07-19에 Unity `6000.5.3f1`로 `03_Battle`을 직접 Play Mode 실행했다. 민트색 루나
Primitive, 단색 적·장애물, HP·자원·능력·전투 상태 텍스트 HUD가 표시됐고 `_ReCamp`
Console 오류는 0건이었다. 종료 후 활성 Scene은 `03_Battle`, Scene dirty는 `false`였다.

| 적용 항목 | 현재 상태 | 판정 |
|---|---|---|
| 캐릭터 ID·이름·역할·전투 수치·능력 문자열 | 5/5 연결 | Gray Box 기능 기준 사용 가능 |
| 대표색·포인트색 런타임 적용 | 5/5 연결 | Primitive 구분용. 보조색은 미사용 |
| 캐릭터 선택과 HUD 이름·능력·상태 텍스트 | 5/5 연결 | 기능 검증용 |
| Approved 2D 제작 시트 | 0/5 | 최종 제작 차단 |
| 3D Model/Visual Prefab·Toon Material/Texture | 0/5 | Gate B/C 진행 불가 |
| Animator·공용/고유 Animation | 0/5 | Gate C 진행 불가 |
| 최종 공격·능력 VFX/Audio Prefab | 0/5 | 현재 Primitive 효과만 존재 |
| HUD 초상화·능력 아이콘·캐릭터별 UI 토큰 | 0/5 | 현재 텍스트 HUD만 존재 |

`CharacterDefinition`에는 전투 수치와 색상은 있지만 Visual Prefab, Sprite, Animator, VFX,
Audio 참조가 없다. `PlayerStats`는 Renderer 이름을 기준으로 대표색·포인트색만 덮고,
Battle Scene의 플레이어는 Capsule/Sphere/Cube 프록시다. 따라서 v003을 그대로 Import하거나
프록시 위에 덧입히는 방식은 허용하지 않는다.

## 6. 최종 자산 적용 전에 필요한 Unity Presentation 계약

게임 규칙 데이터와 Unity 자산을 분리해 `CharacterId`로 조회하는 Unity 전용 Presentation
정의를 확정해야 한다. 실제 구현은 3D 규격과 루나 Approved 시트가 준비된 뒤 진행한다.

- Visual Prefab, 로비 전신, HUD 초상화, 선택 썸네일
- 대표/역할 능력 아이콘과 캐릭터별 UI 색 토큰
- Body/Face/Eye/Hair/Outfit/Equipment/Emission Material 세트
- Animator Controller, Avatar, 공용·전용 Animation
- 공격·능력·피격·승리 VFX/Audio Prefab
- Weapon/BladeTip/Muzzle/Scanner/Drone/Shield/VFXCenter 소켓
- LOD, 폴리곤·텍스처·Material·Bone·Particle 성능 메타데이터
- 공격·피격·능력·상태 변경을 Presentation에 전달하는 런타임 이벤트

기능 Root 아래에 교체 가능한 `CharacterVisual` 자식을 두고, 현재 Transform 이동과 충돌
로직을 유지하기 위해 기본 애니메이션은 in-place로 설계한다.

## 7. 게임 적용 결정

현재 v003에 허용되는 용도는 다음뿐이다.

- 5인 3D SD-lite 방향·역할·팔레트 비교
- 캐릭터별 단독 WIP 제작의 참고 입력
- Gray Box 팔레트와 역할 피드백의 대조

다음 용도는 금지한다.

- 최종 2D 대표 원화·Turnaround·모델링 시트
- 최종 3D Model/Prefab·HUD 초상화·아이콘·VFX의 직접 제작 기준
- 출시·홍보·상업 배포 자산
- 사람 검토 없는 `APPROVED` 승격

## 8. 재검토 순서

1. 사람 리뷰에서 앵커 규칙과 위 수정 지시를 확인한다.
2. `ART-0103` 제작 시트 템플릿을 완성한다.
3. 루나 `ART-1001~1008`에서 의료 모티프를 제거한 일반 등신 제작 시트를 먼저 승인한다.
4. 같은 Gate A 증거를 미유·코코·이리스·노아에 순차 적용한다.
5. `ART-2001`에서 3D 예산과 Unity Presentation/Prefab 계약을 확정한다.
6. `ART-0105` Import 파이프라인과 루나 Blockout으로 Gate B/C를 검증한다.
7. 루나가 통과한 계약만 나머지 4명에게 확장한다.

## 9. 사람 결정

- Reviewer: Pending
- Date: Pending
- Decision: Pending
- 승인 시에도 범위를 `3D SD-lite direction only` 또는 개별 캐릭터 수정 지시로 명시한다.
