# Re:Camp Art Production Roadmap

## 목표

```text
2D 일반 등신 대표 일러스트
→ 캐릭터별 Approved 제작 시트
→ 3D 4~5등신 SD-lite Blockout
→ 공용 Rig·Shader·Animator·Prefab
→ 최종 모델·애니메이션
→ Unity 쿼터뷰·성능 검증
```

최종 아트보다 먼저 5명의 전투 역할을 Gray Box로 검증한다. 루나 Character Proof가 품질·비용 기준을 통과하기 전에는 나머지 캐릭터의 최종 3D를 대량 제작하지 않는다.

## 도구 도입 원칙

- 현재 Unity 기능 개발과 초기 아트 방향 검토에는 ComfyUI 또는 ComfyUI MCP가 필요하지 않다.
- 현재 이용 가능한 이미지 생성 도구로 후보를 만들고, 사람 승인과 제작 시트를 기준으로 다음 단계로 이동한다.
- 캐릭터 일관성 대량 생성, 정밀 인페인팅, Seed·LoRA·ControlNet·IP-Adapter 고정 워크플로가 실제 병목이 될 때 ComfyUI 도입을 재평가한다.
- 그때까지 ComfyUI는 `Deferred`이며, 로컬 모델·GPU·설치·MCP 연결은 어떤 개발 작업의 선행 조건도 아니다.
- `Deferred`는 필요성이 아직 확인되지 않은 선택 작업이고, 기술적으로 진행할 수 없는 `Blocked`와 구분한다.

## A0. 방향 통일 — In Progress

- Art Direction, Character Bible, MCP Guide: Done
- 5인 라인업 v001: Invalid — 거의 빈 이미지, LFS raw blob
- 혼성 5인 라인업 v002: Rejected — 전원 여성 조건 누락, 원본 이미지 미참조
- 성인 여성 5인 라인업 `REVIEW v003`: Done, 사람 Review 대기
- 실루엣·색상·무기 사람 승인: Todo
- AI 메타데이터 양식: Done

## A1. 반복 가능한 파이프라인 — In Progress

- Git LFS 규칙: Done
- `art_source/`와 Unity Art 구조: Done
- 생성 메타데이터 companion 규칙: Done
- 현재 이미지 생성 도구용 캐릭터 앵커·입력 참조 규칙: Todo
- ComfyUI·ComfyUI MCP 설치와 고정 Seed/LoRA/ControlNet/IP-Adapter 워크플로: Deferred
- Figma 제작 시트 템플릿: Ready
- Blender MCP 소품 Export: Blocked
- FBX → Unity Prefab 테스트: Todo

## A2. 5인 2D 방향 확정 — Todo

각 캐릭터마다 전신 후보, 얼굴·헤어, 의상, 무기·장비 후보를 만든다. 5명을 함께 배치해 실루엣·팔레트·세계관 일관성을 검토한다.

후보 제작은 현재 이용 가능한 이미지 생성 도구로 시작하며 ComfyUI 도입을 기다리지 않는다. 반복 일관성이나 정밀 수정이 병목으로 확인되면 `ART-0108`을 다시 평가한다.

제작 순서는 루나 → 미유 → 코코 → 이리스 → 노아다.

## A3. 루나 Character Proof — Todo

- 일반 등신 Key Art
- 정면·측면·후면 Turnaround
- 표정 8종, 헤어·의상 분해, 에너지 단검·탐지 장치 상세
- 컬러·재질표와 3D 제작 주의사항
- Gate A/B Approved 후 4~5등신 SD-lite Blender Blockout
- Unity 쿼터뷰 Gate C 검증
- 최종 모델·Rig·BlendShape·애니메이션·VFX·Prefab

## A4. 공용 3D 기반 — Todo

- 공용 4~5등신 SD-lite Base Mesh와 Humanoid 호환 Rig
- 공용 Toon Shader, Animator, Collider, LOD 규칙
- 공용 이동·피격·사망 애니메이션
- 캐릭터 Prefab 템플릿

## A5. 나머지 캐릭터 — Todo

루나에서 검증된 기반으로 미유, 코코, 이리스, 노아를 제작한다. 캐릭터별 얼굴·헤어·의상·무기·대표 Idle·공격·스킬·승리 모션을 구분한다.

## A6. 환경·몬스터·소품 — Todo

- 버려진 거리와 폐쇄된 연구소
- 일반 몬스터 6종, 보스 2종
- 캠프 시설 4종 이상
- 폐허 모듈, 바리케이드, 고철, 자원 상자

배경은 캐릭터보다 낮은 채도·디테일을 유지하고 캠프는 따뜻한 안전 지대로 대비시킨다.

## A7. UI·VFX·사운드 — Todo

- 둥근 패널·얇은 외곽선·가벼운 글래스의 UI Design System
- 캐릭터별 포인트 컬러와 스킬 UI
- 공격·피격·사망·획득·회복·가드 피드백
- PC 가독성 우선, 모바일 터치 확장성 유지

## A8. 출시 폴리시 — Todo

- 승인되지 않은 WIP 제거
- 리깅·관통·LOD·성능 검증
- AI 메타데이터·라이선스 검토
- 스토어 스크린샷·트레일러·대표 이미지

## 승인 규칙

- `WIP`: 제작 중, 게임 기준 사용 금지
- `REVIEW`: 비교·검토 가능, 최종 모델링 기준 사용 금지
- `APPROVED`: 사람 검토를 통과한 제작 기준
- `DEFERRED`: 선택 도구 또는 작업의 필요성을 나중에 재평가하며 현재 선행 조건이 아님
- `SUPERSEDED`: 새 방향으로 대체됨
- `ARCHIVE`: 이력 보관

Gate A(매력) → Gate B(제작 가능성) → Gate C(Unity 통합) 순서를 건너뛰지 않는다.
