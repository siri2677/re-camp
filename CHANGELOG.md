# CHANGELOG

## Unreleased — Android Mobile-First Baseline

- 수익보다 게임 적합성·완성 가능성·포트폴리오 가치를 우선하도록 플랫폼 판단 기준 수정
- 이전 Steam-first 판단이 상업 손익을 과도하게 반영했다고 보고 Android-first로 교정
- 1차 제품 목표를 Google Play Android 정식 출시로 변경
- 가로형 Landscape 모바일 게임을 제품 정체성으로 확정
- Windows를 Unity 개발·디버그·자동 테스트·Profiler·포트폴리오 빌드로 분리
- Steam을 Android 출시 후 선택적 PC 제품화 대상으로 변경
- 권장 플레이 세션을 모바일 기준 5~15분으로 재정의
- 가상 조이스틱·공격·대시·스킬 Touch UI와 Auto Aim 기준 추가
- Android Back·Background/Resume·Safe Area·화면비 기준 추가
- 30 FPS 기본·지원 기기 60 FPS 품질 단계로 기술 목표 수정
- MVP·Vertical Slice·Roadmap·Sprint Backlog를 Android Build와 실기기 검증 중심으로 재구성
- APK 외부 테스트 → Google Play Closed Test → Android Full Release 출시 흐름 추가
- 수익·손익분기를 필수 성공 조건에서 제외하고 비용 통제 참고값으로 변경
- `business_cost_log.md`를 프로젝트 완주 비용 관리 중심으로 재작성
- 모바일 출시를 위해 가챠·강제 광고·유료 재화 중심 설계를 추가하지 않도록 유지

## Unreleased — Production Baseline Integration

- 프로젝트 단일 기준 문서 `CURRENT_PROJECT_BASELINE.md` 추가
- Unity 6.3 LTS·URP·Input System 기준 명시
- 2D 일반 등신 대표 일러스트 + 3D 5~6등신 스타일라이즈드 인게임 방향 통일
- 고정 쿼터뷰 Camera·UI 기준 추가
- 루나 Character Proof 우선 제작 순서로 변경
- 중복 아트 Backlog ID를 분야별 Prefix로 통합
- ComfyUI Cloud·Figma Remote·Blender·Coplay·GitHub MCP 역할 정리
- Aura AI의 체험 이후 유료 구조를 확인하고 필수 제작 파이프라인에서 제외
- Unity 통합을 Coplay MCP + Import Preset·Validation Editor Tool + 수동 Unity QA로 통일
- 환경 Modular·VFX·기술 성능·Scope Cut 기준 추가

## 0.0.1 — Initial Setup

- Re:Camp 저장소 초기화
- README 작성
- AGENT 개발 가이드 작성
- Unity용 `.gitignore` 추가
- Git LFS용 `.gitattributes` 추가
- 초기 기획·Roadmap·Table 문서 구조 추가
