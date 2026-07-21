# Re:Camp Current Project Baseline

> 최종 갱신: 2026-07-21  
> 상태: Active  
> 목적: 프로젝트 문서가 충돌할 때 우선 적용하는 현재 기준

## 1. 문서 우선순위

```text
CURRENT_PROJECT_BASELINE.md
→ BUSINESS_AND_PLATFORM_STRATEGY.md
→ planning/sprint_backlog.md
→ planning/roadmap.md
→ 분야별 상세 Spec
→ tables/
→ APPROVED art_refs/
→ REVIEW·WIP art_refs/
```

캐릭터 외형은 개별 `APPROVED` 제작 시트가 텍스트 설명보다 우선한다.

## 2. 프로젝트 정의

Re:Camp는 멸망 이후 자연에 잠식된 위험 구역을 짧게 탐험하고 자원을 회수해 캠프를 성장시키는 **가로형 모바일 3D 고정 쿼터뷰 로그라이트 RPG**다.

```text
짧은 탐험의 긴장감
+ 무사 귀환의 성취감
+ 캠프의 누적 성장
+ 서브컬쳐 캐릭터에 대한 애착
```

## 3. 최종 목표와 현재 목표

### 최종 제품 목표

**Google Play Android에 정식 배포 가능한 완성형 모바일 게임 출시**가 1차 제품 목표다.

```text
Android Landscape Full Release
→ 한 판 3~5분
→ Touch UI와 Auto Aim 보조
→ 로컬 저장 기반 싱글플레이
→ 가챠·광고·강제 라이브 운영 없음
```

수익 극대화는 핵심 목표가 아니다. 다음을 우선한다.

1. 실제로 완성하고 배포할 수 있는가
2. 모바일에서 3~5분 플레이가 자연스러운가
3. 캐릭터·전투·캠프 성장의 매력이 전달되는가
4. 포트폴리오로 제작 과정과 결과를 설명할 수 있는가
5. 업데이트를 혼자 감당할 수 있는가

### 현재 실행 목표

```text
Windows 개발·디버그 기반
→ Android 입력·해상도 Gray Box
→ 루나 Character Proof
→ Android Vertical Slice
→ APK 외부 테스트·Google Play Closed Test
→ Android Full Release
→ Windows 공개 빌드·Steam은 후속 선택
```

Portfolio Vertical Slice는 최종 결과물이 아니라 Android 정식 출시 가능성을 검증하는 중간 Gate다.

현재 상태:

- 5인 캐릭터 라인업 Direction Approved
- Unity 프로젝트 생성과 기술 기반 구축 준비
- ReCamp.Core Unity 통합 방식 검토
- 루나 Character Proof용 아트 파이프라인 구축
- 모바일 입력·UI·성능 기준 재정리

아직 최종 캐릭터 모델, 최종 환경, Unity Prefab, 플레이 가능한 Vertical Slice는 완성되지 않았다.

## 4. 플랫폼 기준

| 항목 | 현재 기준 |
|---|---|
| 1차 제품 플랫폼 | Google Play Android |
| 화면 방향 | 가로형 Landscape |
| 개발·디버그 플랫폼 | Windows PC |
| 1차 외부 테스트 | Android APK 제한 배포·Google Play Closed Test |
| PC 공개 빌드 | itch.io 또는 포트폴리오용 Windows Demo |
| Steam | Android 출시 후 별도 PC 제품화 가치가 있을 때 검토 |
| iOS | Android 안정화 후 검토 |
| Unity | Unity 6.3 LTS |
| Render Pipeline | URP |
| 입력 | Unity Input System |
| Android 입력 | 가상 조이스틱·공격·대시·스킬 Touch UI |
| PC 입력 | 개발·QA용 Keyboard/Mouse·Gamepad Adapter |
| 카메라 | 고정 쿼터뷰 |
| 저장 | 로컬 저장 |
| 플레이 방식 | 싱글플레이 |

Windows는 제품 목표가 아니라 빠른 Editor 반복, Profiler, 자동 테스트, 아트 검수와 포트폴리오 영상 제작을 위한 개발 기준이다.

## 5. 출시·수익 원칙

수익은 플랫폼 우선순위와 작업 완료 여부를 결정하지 않는다. 비용은 프로젝트를 중단시키지 않을 범위인지 확인하는 용도로만 관리한다.

- Google Play 등록과 테스트 요건은 출시 준비 시 재확인한다.
- 무료 출시, 저가 유료 앱, 무료 체험 후 1회 해금 중 적합한 방식은 Vertical Slice 외부 테스트 후 결정한다.
- 가챠·광고·유료 재화를 전제로 게임 구조를 변경하지 않는다.
- 손익분기 판매량은 필수 목표가 아니라 과도한 외주·구독 지출을 방지하는 참고값이다.
- 수익이 없거나 적어도 완성도 높은 공개 빌드와 포트폴리오 결과를 성공으로 인정한다.

## 6. 플레이 시간 기준

```text
1회 탐험: 3~5분
캠프 정비: 1~3분
권장 모바일 세션: 탐험 1~3회, 약 5~15분
장기 플레이: 캐릭터·캠프 성장으로 여러 세션 연결
```

모바일 사용 상황을 고려한다.

- 출퇴근·휴식 시간·취침 전 짧은 플레이
- 중단 후 재개가 쉬운 구조
- 긴 튜토리얼과 복잡한 메뉴 이동 최소화
- 한 손 플레이를 강제하지 않으며 가로형 양손 조작을 기준으로 함

## 7. 비주얼 기준

```text
2D 일반 등신 서브컬쳐 대표 일러스트
+ 3D 5~6등신 스타일라이즈드 인게임 캐릭터
+ 툰 셰이딩
+ 자연에 잠식된 부드러운 포스트 아포칼립스
+ 캐릭터보다 낮은 채도와 밀도의 환경
```

캐릭터 공통 원칙:

- 3~4등신 SD가 아닌 5~6등신
- 모바일 화면에서 머리·상체·무기 실루엣이 식별됨
- 얼굴·헤어·의상·무기는 캐릭터별 고유 제작
- 공용 Humanoid Rig·기본 Animation·Prefab 기반 사용
- 최종 판단은 Android 실기기 쿼터뷰에서의 매력과 식별성

## 8. 캐릭터 상태

| ID | 캐릭터 | 역할 | 대표 장비 |
|---|---|---|---|
| CH001 | 루나 | 정찰형 근접 딜러 | 에너지 단검·탐지 장치 |
| CH002 | 미유 | 드론 원거리 딜러 | 전투 드론·제어 건틀릿 |
| CH003 | 코코 | 회복·보호 지원 | 의료 장비·보호막 장치 |
| CH004 | 이리스 | 정밀 원거리 딜러 | 에너지 라이플·조준 장치 |
| CH005 | 노아 | 방어·반격 탱커 | 전개식 방패·방호 장비 |

현재 5인 라인업은 `Direction Approved`다.

- 이름·역할·대표 색상·무기·큰 실루엣은 사용 가능
- 개별 얼굴·헤어·의상 구조는 최종 승인 전
- 통합 라인업은 최종 Turnaround나 3D 모델링 시트가 아님
- 개별 캐릭터는 별도의 `APPROVED` 제작 시트를 거쳐야 함

## 9. 제작 우선순위

```text
5인 라인업 방향 승인
→ Unity Windows 개발 기반
→ Android Landscape 해상도·Touch Input Gray Box
→ ComfyUI·Figma·Blender 파이프라인
→ 루나 2D Approved 제작 시트
→ 루나 3D Blockout
→ Coplay Import·Prefab·Android Camera 검증
→ Editor Validation Tool·수동 실기기 QA
→ 루나 Character Proof
→ Android Portfolio Vertical Slice
→ APK 외부 테스트·Google Play Closed Test
→ Android Full Release
→ Windows·Steam 후속 판단
```

나머지 4명은 루나 Proof 전까지 단독 전신 방향과 3D 위험 요소만 정리하고 고비용 최종 제작은 보류한다.

## 10. 제작 도구

| 도구 | 주 역할 |
|---|---|
| ComfyUI Cloud MCP | 캐릭터·환경·몬스터·VFX 2D 후보 |
| Figma Remote MCP | 캐릭터 제작 시트·모바일 UI Design System |
| Blender MCP | 3D Blockout·모델·Rig·Animation·FBX Export 보조 |
| Coplay MCP | Unity Scene·Prefab·Component·Material·Animator 자동화 |
| GitHub MCP | 문서·브랜치·PR·승인 자산·작업 이력 |
| 코드 에이전트 | C#·Importer·Validation Tool·테스트 |
| Unity 수동 검수 | Android 실기기·Inspector·Console·PlayMode·Profiler |

비용 원칙:

- 기본 파이프라인은 무료 또는 이미 보유한 범위에서 동작해야 한다.
- Aura AI는 체험 이후 별도 비용이 필요하므로 필수 파이프라인에서 제외한다.
- Coplay 미지원 작업은 Editor Script·Preset·수동 검수로 보완한다.

## 11. 범위 구분

### Android Portfolio Vertical Slice

- 루나 1명
- 버려진 거리 1개
- 일반 몬스터 3종
- 보스 1종
- 스킬 약 6개
- 캠프 시설 3종
- Touch Battle HUD·스킬 선택·결과·캠프 강화
- 로컬 저장
- 3~5분 완결 루프
- Android APK 실행·발열·메모리·Safe Area 검증

### Android Full Release 목표

- 플레이어블 캐릭터 5명
- 스테이지 2개 이상 또는 동등한 반복 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화
- 난이도·도전·반복 목표
- 첫 실행·튜토리얼·설정·저장 안정성
- 다수 화면 비율·기기 품질 단계·발열·메모리 대응
- Google Play 테스트·스토어 등록에 필요한 자료

Vertical Slice가 품질 Gate를 통과하기 전에 Full Release 최종 자산을 대량 제작하지 않는다.

## 12. 현재 제외 범위

```text
멀티플레이
PvP
길드
실시간 계정 서버
가챠
강제 광고
유료 재화 중심 설계
오픈월드
캐릭터별 완전 고유 골격
복잡한 의상 교체
대량 시네마틱
풀 보이스
유료 Aura AI 의존 파이프라인
Android와 PC 동시 정식 출시
```

## 13. 승인 Gate

### Gate A — 방향

- 캐릭터 역할·색상·실루엣 구분
- 모바일 화면에서 세계관·UI·환경 일치

### Gate B — 제작 가능성

- 2D 시트 구조 일치
- 3D 모델·Rig·Animation 구현 가능

### Gate C — 모바일 조작·가독성

- 가로형 Touch UI로 전체 흐름 완주
- 고정 쿼터뷰에서 얼굴·상체·무기 식별
- 공격 방향·위험·자원 구분
- UI가 전투 영역을 과도하게 가리지 않음

### Gate D — Android Vertical Slice

- 탐험·전투·귀환·성장 완주
- 기준 Android 기기 성능·발열·메모리 기록
- 외부 테스트에서 조작 이해와 재플레이 의향 확인

### Gate E — Android Full Release

- 본편 콘텐츠와 성장 구조 완결
- 첫 실행·저장·업데이트·오류 대응 준비
- Google Play 테스트·심사 준비
- 목표 기기 범위에서 안정적 실행

## 14. 변경 원칙

플랫폼·Scope 변경 시 같은 PR에서 갱신한다.

```text
CURRENT_PROJECT_BASELINE.md
BUSINESS_AND_PLATFORM_STRATEGY.md
planning/roadmap.md
planning/sprint_backlog.md
관련 상세 Spec
README.md 또는 PROJECT_OVERVIEW.md
```
