# Re:Camp Project Overview

## 1. 프로젝트 정의

Re:Camp는 멸망 이후 자연에 잠식된 위험 구역을 짧게 탐험하고 자원을 회수해 생존자 캠프를 성장시키는 **3D 고정 쿼터뷰 로그라이트 RPG**다.

## 2. 프로젝트 목적

- 직접 조작 기반의 탐험·전투·귀환 루프 검증
- 서브컬쳐 캐릭터와 부드러운 포스트 아포칼립스의 결합
- 루나 Character Proof를 통해 2D 디자인이 3D 게임 캐릭터로 전환되는 제작 파이프라인 검증
- 플레이 가능한 포트폴리오 Vertical Slice 완성
- 이후 캐릭터 5명과 스테이지 2개로 확장 가능한 기반 마련

## 3. 현재 단일 기준

최신 플랫폼·기술·아트·범위 기준은 다음 문서를 따른다.

- `docs/00_project/CURRENT_PROJECT_BASELINE.md`

## 4. 플랫폼과 기술

| 항목 | 기준 |
|---|---|
| 1차 플랫폼 | Windows PC |
| 2차 플랫폼 | Android |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| Input | Unity Input System |
| Camera | 고정 쿼터뷰 |
| Save | 로컬 저장 |

## 5. 핵심 플레이 루프

```text
로비
→ 탐험 준비
→ 위험 구역 진입
→ 몬스터 전투
→ 자원 획득과 스킬 선택
→ 귀환 또는 사망·시간 만료
→ 결과 정산
→ 캠프 성장
→ 로비 복귀
```

## 6. 포트폴리오 Vertical Slice

| 항목 | 범위 |
|---|---|
| 캐릭터 | 루나 1명 |
| 인게임 표현 | 3D 5~6등신 스타일라이즈드, 툰 셰이딩 |
| 스테이지 | 버려진 거리 1개 |
| 일반 몬스터 | 3종 |
| 보스 | 1종 |
| 스킬 | 약 6개 |
| 자원 | 고철·식량·데이터 조각 |
| 캠프 시설 | 발전기·작업대·식량 창고 |
| UI | 로비·전투·스킬 선택·결과·캠프 강화 |
| 플레이 시간 | 3~5분 |

## 7. 장기 출시 목표

- 플레이어블 캐릭터 5명
- 스테이지 2개
- 일반 몬스터 6종
- 보스 2종
- 캠프 시설 4종 이상
- 캐릭터 해금, 친밀도, 대화와 로비 상호작용

장기 목표는 Vertical Slice가 품질·재미·성능 Gate를 통과한 후 진행한다.

## 8. 비주얼 방향

```text
2D 일반 등신 대표 일러스트
+ 3D 5~6등신 스타일라이즈드 캐릭터
+ 공용 Humanoid Rig와 툰 셰이더
+ 자연에 잠식된 스타일라이즈드 폐허
+ 따뜻하고 희망적인 캠프
```

## 9. 제작 도구

- ComfyUI Cloud MCP: 2D 시안과 반복 생성
- Figma Remote MCP: 캐릭터 제작 시트와 UI
- Blender MCP: 3D Blockout·모델·Rig·Animation·Export
- Coplay: Unity Scene·Prefab·Component 자동화
- Aura: Unity Import·Prefab·Material·Animator 검증과 보완
- GitHub MCP: 문서·PR·자산 승인 이력

Coplay와 Aura는 병행하되 한 작업의 Primary Tool을 지정해 충돌을 방지한다.

## 10. 현재 제작 순서

```text
기준 문서 통합
→ Unity 프로젝트와 카메라 Gray Box
→ 루나 2D Approved 제작 시트
→ 루나 3D Blockout
→ Coplay/Aura Import·Prefab 테스트
→ 루나 Character Proof
→ Vertical Slice
→ 나머지 캐릭터와 콘텐츠 확장
```

## 11. 제외 범위

```text
멀티플레이
PvP
길드
실시간 계정 서버
가챠
상점 결제·광고
오픈월드
복잡한 장비 파밍
캐릭터별 완전 고유 골격
대량 시네마틱
풀 보이스
```

## 12. 완료 판단

포트폴리오 1차 완료는 콘텐츠 양이 아니라 다음 조건으로 판단한다.

- 한 판의 탐험·전투·귀환·성장이 끝까지 작동함
- 루나의 2D와 3D 인상이 일치함
- 고정 쿼터뷰에서 캐릭터·적·위험·자원이 읽힘
- 외부 사용자가 핵심 재미와 성장 동기를 이해함
- Windows 목표 성능을 유지함
