# Re:Camp Art Production Roadmap

> 최종 갱신: 2026-07-27
> 상태: Active
> 역할: 아트 제작 단계와 Gate 의존 관계

전역 비주얼·로스터·허용 비율·플랫폼은 `docs/00_project/CURRENT_PROJECT_BASELINE.md`가 소유한다. 캐릭터별 고유 설정은 `CHARACTER_BIBLE.md`, 고정·가변 항목은 `CHARACTER_ANCHOR_SPEC.md`, 표현 규칙은 `ART_DIRECTION.md`를 따른다.

실제 우선순위는 `planning/sprint_backlog.md`, 세부 산출물 ID는 `planning/art_production_backlog.md`가 소유한다.

## 제작 흐름

```text
설계 계약
→ 반복 파이프라인 Proof
→ 캐릭터 후보·교차 비교
→ 개별 Approved 2D 제작 시트
→ 2D→3D 변환 계약
→ 루나 Character Proof
→ 공용 3D 기반
→ 나머지 캐릭터
→ 환경·몬스터·UI·VFX·Audio
→ Unity·Android 통합
→ 출시 자산 검수
```

루나 Character Proof가 품질·비용·가독성·성능 기준을 통과하기 전에는 나머지 캐릭터의 최종 3D를 대량 제작하지 않는다.

## A0. 설계 계약 — Review

완료:

- Canonical Baseline.
- Character Bible·Anchor Spec.
- Art Direction·Review Checklist.
- 제작 시트·명명·Animation·metadata 계약.
- 역사 자산의 상태와 사용 제한.

남은 일:

- 개별 후보와 교차 비교 증거.
- 사람 승인 제작 시트.

Exit 기준: 모든 신규 후보가 현재 계약을 사용하고 역사 실패 자산을 제작 기준으로 사용하지 않는다.

## A1. 반복 가능한 파이프라인 — In Progress

완료:

- Git LFS와 아트 디렉터리.
- WIP / REVIEW / APPROVED 흐름.
- Figma 제작 시트 템플릿.
- 이미지→Blender→Unity 명명·Export·GUID 계약.
- Motion·Animator·Event·Import 계약.

남은 일:

- Figma Import·Component Clone·한글·PNG/PDF Export 검증.
- 샘플 2D→3D 변환표 검증.
- Blender 테스트 소품 Export.
- FBX→Unity Material·Prefab Proof.

Exit 기준: 같은 앵커로 후보를 반복하고, 제작 시트와 Export 기록을 남기며, 테스트 자산을 Unity Prefab으로 재현할 수 있다.

## A2. 5인 2D 디자인·방향 확정 — Todo

캐릭터별 필수 산출물:

- 단독 전신 후보 3안 이상.
- 한 문장 훅과 대표·보조 특징 주석.
- 얼굴 정면·3/4과 평상시·임무 상태.
- Front·Side·Back Turnaround.
- 표정 8종과 작은 얼굴 비교.
- 헤어·의상 Layer와 기능 분해.
- 무기·장비·접힘·발광·Socket 상세.
- 컬러·재질표와 대표 포즈.
- 실루엣·저채도·외부 IP 유사성 검토.
- 캐릭터별 2D→3D 변환표.

Exit 기준:

- 5명 모두 Gate A/B와 사람 검토를 통과한다.
- 시점별 얼굴·헤어·의상·장비가 일치한다.
- 한 문장 훅이 한 장에서 전달된다.
- 캐릭터 간 얼굴·체형·패션·색·실루엣이 구분된다.

## A3. 루나 Character Proof — Todo

- Approved 2D 제작 시트.
- 2D→3D 변환표와 Unity Presentation 계약.
- Blender Blockout과 쿼터뷰 Gate C.
- 최종 모델·Texture·Rig·Weight·BlendShape.
- 대표 Animation·Toon Material·VFX·Audio·Prefab.
- 로비·선택·전투 통합.
- Android Gate와 사용자 첫인상 검증.

Exit 기준: 2D와 3D가 같은 루나로 인식되고, 대표 훅·관통·변형·성능·플레이 피드백이 허용 범위다.

## A4. 공용 3D 기반 — Todo

- Character ID별 Visual Prefab·Portrait·Icon·VFX·Audio 연결.
- 기능 Root와 교체 가능한 CharacterVisual 계약.
- 공용 Base Mesh·Humanoid Rig·Shader·Animator.
- 물리 본·Collider·LOD·Texture·VFX 예산.
- Unity Prefab 템플릿과 Validation.

Exit 기준: 루나에서 검증된 구조로 다음 캐릭터 Blockout을 만들고 공용 이동·피격 Animation을 재사용할 수 있다.

## A5. 나머지 캐릭터 — Todo

제작 순서는 `planning/art_production_backlog.md`를 따른다.

- 공용 기반을 사용한다.
- 얼굴·헤어·체형·패션·무기·대표 Motion·VFX는 캐릭터별로 분리한다.
- 선택·로비·전투에서 외형·모션·플레이가 명확히 구분돼야 한다.

Exit 기준: 5명 모두 최종 Prefab으로 핵심 흐름에서 정상 동작한다.

## A6. 환경·몬스터·소품 — Todo

```text
Gray Box 보존
→ 캠프 핵심 시설
→ 첫 위험 구역
→ 첫 적·보스 세트
→ 추가 환경·적
→ 환경 폴리시
```

Exit 기준: 이동·교전·자원·상호작용이 읽히고 캐릭터보다 낮은 시각 밀도를 유지하며 성능 예산을 통과한다.

## A7. UI·VFX·Audio — Todo

- UI Design System과 화면별 Layout.
- Portrait·Icon·Skill·상태 피드백.
- 캐릭터별 VFX 언어.
- BGM·UI·전투·환경 Audio.
- 모바일 Safe Area와 입력 상태.

Exit 기준: 기능·가독성·캐릭터 식별·성능·라이선스 검수를 통과한다.

## A8. 통합·출시 검수 — Todo

- Prefab·Material·Animation·VFX·Audio 연결.
- 쿼터뷰와 화면비별 검수.
- Android 성능·발열·메모리.
- WIP·Missing·Placeholder 제거.
- AI metadata·라이선스·외부 IP 유사성.
- 스토어 Key Art·스크린샷·트레일러.

Exit 기준: Gate C·Android Gate·Release QA를 통과한다.

## 도구 원칙

- 현재 사용 가능한 도구로 후보와 검증을 시작한다.
- ComfyUI는 대량 일관성·정밀 인페인팅·재현 가능한 고정 워크플로가 실제 병목일 때만 `Deferred`에서 전환한다.
- 도구 사용 여부는 승인 기준을 낮추지 않는다.
- 생성 결과는 metadata·review·사람 승인 없이 최종 자산으로 승격하지 않는다.

이 Roadmap에서 캐릭터별 수치·전역 비율·현재 P0 순서·상세 작업 상태를 중복 관리하지 않는다.
