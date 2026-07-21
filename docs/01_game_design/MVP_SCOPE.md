# Re:Camp MVP, Vertical Slice and Release Scope

## 1. 목적

Re:Camp의 최종 1차 목표는 **Google Play Android 정식 출시**다.

MVP와 Portfolio Vertical Slice는 정식 출시 가능성을 단계적으로 검증하는 Gate다.

```text
Windows Editor Gray Box
→ Android Touch Prototype
→ Android Portfolio Vertical Slice
→ APK 외부 테스트
→ Google Play Closed Test
→ Android Full Release
```

## 2. 단계 구분

### Gray Box MVP

Windows Editor에서 게임 규칙과 Scene 흐름을 임시 Capsule·Cube로 검증한다.

### Android Touch Prototype

가로형 화면, 가상 조이스틱, 공격·대시·스킬 버튼과 Auto Aim 보조를 실제 Android 빌드에서 검증한다.

### Android Portfolio Vertical Slice

루나와 첫 번째 스테이지를 최종 방향에 가까운 품질로 제작해 전투·아트·Touch UX·성능·재플레이 의향을 검증한다.

### Google Play Closed Test

설치·업데이트·첫 실행·튜토리얼·저장·기기 호환성과 외부 피드백을 검증한다.

### Android Full Release

캐릭터·스테이지·성장·설정·저장 안정성을 포함한 완성형 모바일 게임을 공개한다.

## 3. 핵심 루프

```text
로비
→ 탐험 준비
→ 전투 진입
→ 몬스터 전투
→ 자원 획득
→ 스킬 선택
→ 귀환·사망·시간 만료
→ 결과 정산
→ 캠프 강화
→ 로비 복귀
```

```text
1회 탐험: 3~5분
캠프 정비: 1~3분
권장 모바일 세션: 약 5~15분
```

## 4. Gray Box MVP 범위

| 구분 | 범위 |
|---|---|
| 캐릭터 | 루나 임시 모델 1명 |
| 개발 환경 | Windows Unity Editor |
| 입력 | Keyboard/Mouse·Gamepad 임시 Adapter |
| 카메라 | 고정 쿼터뷰 Preset 비교 |
| 공격 | 기본 공격과 대시 |
| 적 | 추적형 임시 적 1~3종 |
| 자원 | 고철·식량·데이터 조각 |
| Scene | Bootstrap·Title·Lobby·Battle·Result |
| UI | 기능 검증용 임시 UI |
| 저장 | 로컬 저장 최소 구조 |

## 5. Android Touch Prototype 범위

| 구분 | 범위 |
|---|---|
| 화면 | Landscape·Safe Area |
| 이동 | 좌측 가상 조이스틱 |
| 전투 | 공격·대시·스킬 Touch Button |
| 조준 | Auto Aim 또는 대상 보정 |
| 해상도 | 대표 16:9·19.5:9·20:9 화면비 |
| 성능 | 실제 APK의 CPU·GPU·Memory·발열 기록 |
| 품질 | Low·Medium·High Profile 초안 |

## 6. Android Portfolio Vertical Slice 범위

| 구분 | 범위 |
|---|---|
| 캐릭터 | 루나 1명 |
| 캐릭터 아트 | 2D Approved 제작 시트 + 3D 5~6등신 모델 |
| 렌더링 | URP 툰 셰이딩 |
| 카메라 | 승인된 고정 쿼터뷰 |
| 조작 | 가상 조이스틱·공격·대시·스킬·Auto Aim |
| 스킬 | 약 6개, 매 판 선택·강화 |
| 일반 몬스터 | 3종 |
| 보스 | 1종 |
| 스테이지 | 버려진 거리 1개 |
| 자원 | 고철·식량·데이터 조각 |
| 캠프 시설 | 발전기·작업대·식량 창고 |
| UI | 로비·전투 HUD·스킬 선택·결과·캠프 강화·설정 |
| 저장 | 진행도와 시설 강화 로컬 저장 |
| 탐험 시간 | 3~5분 |
| 실기기 | APK·Safe Area·발열·메모리·화면비 검증 |

## 7. Google Play Closed Test 범위

- 앱 설치·업데이트·삭제 후 재설치
- 첫 실행과 Touch Tutorial
- 화면 회전 잠금과 Landscape 유지
- 기기별 UI 잘림·Safe Area
- 일시정지·백그라운드·복귀
- 저장 손상·버전 마이그레이션
- 발열·배터리·Memory 증가
- 네트워크 없이 핵심 플레이 가능
- 개인정보·권한·스토어 설명 확인
- 외부 테스트 피드백과 재플레이 의향 기록

## 8. Android Full Release 목표 범위

### 콘텐츠

- 플레이어블 캐릭터 5명
- 스테이지 2개 이상 또는 동등한 반복 분량
- 일반 몬스터 6종 이상
- 보스 2종 이상
- 캠프 시설 4종 이상
- 캐릭터 해금·친밀도·대화
- 난이도·도전·반복 목표

### 시스템

- 가로형 Touch 입력과 Auto Aim
- 짧은 세션 중단·복귀
- 로컬 저장·마이그레이션
- Low·Medium·High 품질 단계
- 음량·진동·Camera Shake·그래픽 설정
- 화면비·Safe Area·뒤로가기 처리
- Crash·진행 차단 버그 대응

### 배포

- Google Play Closed Test 통과
- Store Listing·아이콘·Screenshot·Trailer
- 개인정보·권한·지원 기기·콘텐츠 등급 확인
- 무료·저가 유료·1회 해금 중 배포 형태 확정

## 9. 필수 기능 우선순위

### P0 — 완주 가능한 게임 루프

- Scene 전환
- 이동·공격·대시
- 적 스폰·추적·피격·사망
- 자원 획득
- 귀환·사망·시간 종료
- 결과 정산
- 캠프 강화
- 저장 후 재탐험

### P1 — 모바일 조작과 안정성

- Landscape·Safe Area
- 가상 조이스틱·Touch Button
- Auto Aim·대상 보정
- 앱 일시정지·백그라운드·복귀
- 실기기 성능·발열·Memory

### P2 — 로그라이트 전투

- 스킬 선택·강화
- 일반 몬스터 역할 구분
- 보스 패턴과 약점
- 캐릭터별 빌드 차이

### P3 — Character Proof와 Presentation

- 최종 캐릭터 모델·Rig·Animation
- 툰 셰이더
- 공격·스킬 VFX와 사운드
- 환경 Modular Kit
- 모바일 UI Design System

### P4 — Release Readiness

- Tutorial·Settings
- Closed Test·Store Asset
- Save Migration·Crash 대응
- 화면비·기기 품질 단계
- 배포 형태 확정

### P5 — 후속 플랫폼

- Windows 공개 Demo
- Steam PC 제품화
- iOS Build·TestFlight

## 10. 단계별 완료 기준

### Gray Box MVP

1. 다른 PC에서 프로젝트가 열림
2. 로비에서 전투로 진입
3. 이동·공격·적 추적·사망 작동
4. 자원을 획득하고 전투 종료
5. 결과 정산·캠프 강화
6. 저장 후 재탐험
7. 핵심 테스트 통과

### Android Touch Prototype

1. APK가 기준 기기에서 실행
2. Landscape와 Safe Area 정상
3. 가상 조이스틱과 버튼으로 전체 흐름 완주
4. Auto Aim이 의도한 대상을 선택
5. UI가 전투 화면을 과도하게 가리지 않음
6. CPU·GPU·Memory·발열 기록 존재

### Android Portfolio Vertical Slice

1. 루나의 2D와 3D가 같은 캐릭터로 보임
2. 모바일 쿼터뷰에서 후드·단검·공격 방향 식별
3. 몬스터 3종과 보스의 역할·위험 구분
4. 3~5분 탐험·귀환·성장 완주
5. Touch 조작을 별도 설명 없이 이해
6. 다시 탐험하고 싶다는 반응 확인
7. 기준 기기 성능 목표 유지

### Android Full Release

1. 본편 콘텐츠와 성장 구조 완결
2. 캐릭터 5명의 역할·조작·매력 구분
3. 목표 Android 기기 범위에서 안정적 실행
4. 첫 실행·설정·저장·업데이트 흐름 통과
5. Closed Test의 치명적 문제 해결
6. Store Listing과 배포 자료 준비

## 11. Vertical Slice 제외 범위

```text
나머지 4명의 최종 3D 모델
두 번째 스테이지
추가 몬스터 3종과 두 번째 보스
멀티플레이·PvP·길드
계정 서버
가챠·강제 광고·유료 재화 중심 설계
복잡한 장비 파밍
대량 스토리 컷신
풀 보이스
PC·iOS 동시 출시
```

## 12. 범위 통제

상세 축소 기준은 `planning/SCOPE_AND_RISK_RULES.md`를 따른다.

Vertical Slice 승인 전에는 다음을 시작하지 않는다.

- 나머지 캐릭터의 고비용 최종 모델링
- 두 번째 스테이지 최종 환경
- 친밀도·개인 에피소드
- 복잡한 장비·스킨
- Steam·iOS 동시 출시 작업
