# Re:Camp Android Build and Release Baseline

> 최종 갱신: 2026-08-17
> 상태: Active Implementation Contract
> 대상: Android Vertical Slice → External Test → Google Play Closed Test

## 1. 목적

Unity Android Build Support 설치부터 Development APK, 외부 테스트, Google Play용 AAB까지의
빌드·서명·버전·검증 기준을 정의한다.

현재 Android Module, SDK·NDK·OpenJDK, 배포용 Application Identifier와 실기기 검증은 완료되지 않았다.
본 문서는 DEV-0114·DEV-0117의 작업 기준이며 실제 설치·빌드 결과가 생길 때 버전과 증거를 갱신한다.

## 2. 제품과 빌드 대상

- 1차 제품 플랫폼: Google Play Android
- 화면 방향: Landscape
- 렌더링: URP
- 기본 성능 목표: 30 FPS
- 선택형 품질 목표: 지원 기기에서 60 FPS
- CPU Architecture: ARM64 필수
- Scripting Backend: IL2CPP 우선
- Development 과정에서는 APK를 사용한다.
- Google Play 배포에는 AAB를 사용한다.

정확한 Android API Level은 Unity Android Module 설치 시점과 Google Play 제출 시점의 요구사항을
확인해 기록한다. 오래된 문서 값을 관성적으로 고정하지 않는다.

## 3. 필수 도구 체인

Unity Hub의 현재 프로젝트 Unity 버전 `6000.5.3f1`에 다음 Module을 추가한다.

- Android Build Support
- Android SDK & NDK Tools
- OpenJDK

설치 후 다음을 증거로 남긴다.

```text
Unity Version
AndroidPlayer 경로
SDK 경로와 버전
NDK 경로와 버전
OpenJDK 경로와 버전
설치 날짜
설치 담당자
```

Unity가 제공하는 Embedded 도구 체인을 기본으로 사용한다. 외부 SDK·NDK·JDK를 지정해야 할 명확한
문제가 생기기 전에는 개인 PC마다 다른 경로를 사용하지 않는다.

### 현재 도구 체인 preflight (2026-08-17)

`scripts/validate_android_toolchain_preflight.py`를 설치 없이 실행한 결과는 `BLOCKED`다.
Unity `6000.5.3f1`와 외부 SDK·NDK·OpenJDK 경로는 발견되었지만, Unity가 Android 빌드에
사용할 `Editor/Data/PlaybackEngines/AndroidPlayer` 모듈이 없다. 원본 JSON 증거는
`planning/DEV-0114_ANDROID_TOOLCHAIN_PREFLIGHT.json`에 저장한다. Unity Hub에서 해당
버전의 Android Build Support(Embedded SDK & NDK Tools, OpenJDK 포함)를 설치한 뒤
동일 스크립트를 다시 실행하고, 그 다음에만 Android 빌드 검증을 시작한다.

## 4. Build Profile

최소 다음 Profile을 구분한다.

| Profile | 용도 | Development Build | Script Debugging | 배포 파일 |
|---|---|---:|---:|---|
| `Android_Dev` | 개발·ADB 로그·외부 Smoke | On | 필요 시 On | APK |
| `Android_Test` | 외부 테스터·Closed Test 후보 | Off | Off | APK 또는 AAB |
| `Android_Release` | Google Play 제출 | Off | Off | AAB |

Profile 설정은 개인 Editor 상태에만 두지 않고 저장소에 반영 가능한 Unity Build Profile 자산으로 관리한다.

## 5. Application Identifier

현재 Unity Template Identifier는 출시용으로 사용할 수 없다.

2026-08-17 ProjectSettings preflight 결과, Landscape·ARM64·IL2CPP·5개 Build Scene·Version Code는
통과했지만 Android Identifier가 `com.UnityTechnologies.com.unity.template.urpblank`로 남아
`DEV-0117`을 차단하고 있다. Re:Camp 소유 reverse-DNS Identifier 결정은 제품/배포 결정이므로
임의로 변경하지 않는다. 자동 점검 원본은 `planning/DEV-0117_ANDROID_RELEASE_PREFLIGHT.json`이다.

최종 Identifier는 사용자가 승인한 뒤 다음 문서와 설정을 함께 갱신한다.

```text
Application Identifier: TBD
Product Name: Re:Camp
Company Name: TBD
```

권장 형식은 역도메인 구조지만 실제 소유 가능한 이름을 사용한다. 임시 Identifier로 외부 배포를 시작한 뒤
출시 직전에 변경하지 않는다. Closed Test 전에 확정하는 것을 원칙으로 한다.

## 6. 버전 규칙

### 사용자 표시 버전

Semantic Versioning을 단순화해 사용한다.

```text
0.<milestone>.<patch>
```

예시:

- `0.1.0`: 첫 Android Vertical Slice
- `0.2.0`: Closed Test 주요 기능 추가
- `0.2.1`: 버그 수정
- `1.0.0`: 최초 정식 출시

### Android Version Code

- 모든 업로드에서 반드시 증가한다.
- 동일 Version Name의 재빌드도 Version Code는 증가한다.
- 수동으로 이전 값보다 낮추지 않는다.
- Build Log와 Test 기록에 Version Name·Code·Git SHA를 함께 남긴다.

## 7. 서명키

### Development

- Unity 기본 Debug Keystore를 사용할 수 있다.
- 외부 테스트 전 설치 충돌 여부를 확인한다.

### Release

- Release Keystore는 Git에 커밋하지 않는다.
- 비밀번호를 문서·Commit·Issue·Console Capture에 기록하지 않는다.
- Keystore 파일은 암호화된 별도 저장소와 백업에 보관한다.
- Alias, 생성일, 담당자, 백업 위치만 보안 문서에 기록한다.
- Google Play App Signing 사용 여부는 Closed Test 준비 시 확정한다.

Keystore 분실은 동일 앱 업데이트 불가 문제로 이어질 수 있으므로 최초 Test Track 업로드 전에 백업을 검증한다.

## 8. Player Settings 기준

Android Target 전환 후 다음 항목을 확인한다.

- Landscape Orientation
- ARM64
- IL2CPP
- Color Space
- Graphics API 우선순위
- Internet Access 필요 여부
- Write Permission 정책
- Managed Stripping Level
- Minify 사용 여부
- Multithreaded Rendering
- Incremental GC
- Splash Screen
- Package Name
- Version Name·Code

각 값은 성능·호환성 검증 전 임의로 높이거나 낮추지 않는다. 최종 값과 변경 이유를 Build Record에 남긴다.

## 9. 권한과 데이터

Vertical Slice 기본 원칙:

- 불필요한 Android 권한을 요청하지 않는다.
- 계정·광고·결제·위치·연락처·마이크·카메라 권한을 사용하지 않는다.
- 로컬 저장만 사용한다.
- 네트워크 기능이 추가되지 않는 한 Internet Permission 필요성을 검토한다.
- 외부 SDK를 추가할 때 권한·개인정보·데이터 수집 영향을 다시 검토한다.

## 10. Development APK 완료 조건

첫 APK는 다음 조건을 모두 충족해야 한다.

1. Android Target으로 컴파일 성공
2. ARM64 APK 생성
3. 실제 기기에 설치·실행
4. Title 또는 Lobby 진입
5. Touch로 캐릭터 이동
6. 공격·Dash·Skill·귀환 입력
7. 3~5분 Battle Loop 완주
8. Result와 Camp 저장 확인
9. Background·Resume 확인
10. Android Back 확인
11. 치명적 Exception·ANR 없음
12. Git SHA·Unity 버전·기기·OS·APK Hash 기록

## 11. 기기 Test Record

각 Test 결과는 다음 형식으로 저장한다.

```yaml
Build:
  version_name:
  version_code:
  git_sha:
  unity_version:
  build_profile:
Device:
  manufacturer:
  model:
  android_version:
  chipset:
  ram:
Display:
  resolution:
  aspect_ratio:
  cutout:
Result:
  install:
  launch:
  full_loop:
  background_resume:
  back_button:
  average_fps:
  peak_memory:
  thermal_note:
  crash_or_anr:
Evidence:
  logcat:
  screenshots:
  video:
Tester:
  name:
  date:
```

## 12. External Test와 Closed Test

### External APK Test

- 소수의 지정 테스터에게 직접 APK 제공
- 설치 경로, 빌드 버전, 알려진 문제를 함께 전달
- 캐릭터 첫인상, 조작, 가독성, 5분 반복 의향, 발열·배터리·Crash를 수집
- 개인 정보가 포함된 Log를 공개 채널에 올리지 않는다.

### Google Play Closed Test

진입 조건:

- 최종 Application Identifier
- Release Signing 준비
- AAB Build 성공
- 저장 Migration Test
- 주요 기기군 Smoke
- 개인정보·Data Safety 초안
- Store Listing 임시 자산
- Crash·ANR 확인 경로
- 테스터 피드백 수집 방식

Google Play 정책·Target API·테스트 요구사항은 실제 Track 생성 시 공식 자료로 다시 확인한다.

## 13. 빌드 실패 처리

- Build Log의 최초 원인부터 확인한다.
- SDK·NDK·JDK 경로를 무작정 교체하지 않는다.
- 개인 PC에서만 해결되는 수동 설정은 문서와 Build Profile에 반영한다.
- Gradle Template을 커스텀하기 전 기본 Export로 재현한다.
- Plugin 충돌은 최소 재현 Branch에서 분리 검증한다.
- 실패 Build를 정상으로 표시하거나 Artifact로 배포하지 않는다.

## 14. 자동화 후보

DEV-0112 CI에서 다음을 자동화한다.

- Unity Version 검증
- EditMode·PlayMode Tests
- Android Development Build
- Version·Git SHA 주입
- APK/AAB Artifact 보관
- Build Log 보관
- LFS Pointer·대용량 자산 누락 검사

Release Signing은 CI Secret과 보안 저장소가 준비되기 전 자동화하지 않는다.

## 15. 현재 차단 요소

- Android Build Support(AndroidPlayer) 미설치
- Unity Embedded SDK·NDK·OpenJDK 미확인 (외부 SDK·NDK·OpenJDK 경로는 존재하지만 기본 계약은 Embedded 도구 체인)
- Application Identifier 미결정 (ProjectSettings preflight에서 Unity Template 값 확인)
- Touch HUD와 공통 입력 계층은 구현되어 있으며, 포인터 소유권 자동 회귀까지 추가했다. Android 실기기 Smoke는 남아 있다.
- Landscape ProjectSettings와 SafeArea 계산기 자동 preflight는 PASS했다. Landscape·Cutout 실기기 검증은 AndroidPlayer 설치 후 진행한다.
- Test Device Matrix 미작성

위 항목이 해결되기 전 DEV-0117을 `Done`으로 변경하지 않는다.
