# Re:Camp Art References

이 디렉터리는 Re:Camp 아트의 원본 앵커, 검토 후보, 반려 기록을 승인 상태와 함께 관리한다.

## 기준 우선순위

```text
APPROVED 개별 캐릭터 제작 시트
→ 현재 일본 서브컬처 STYLE RESET 개별 REVIEW 패키지
→ 원본 전투 콘셉트 PRIMARY REVIEW(전투 감성·환경·카메라 전용)
→ APPROVED 아트 디렉션 보드
→ 과거 REVIEW 라인업
→ WIP·STYLE REJECTED HISTORY
```

현재 사람 승인된 2D 제작 시트는 CH101~CH104에 있으며, CH105와 5인 교차 판정은 아직 대기 중이다. `REVIEW` 이미지는 제작 방향 비교용이며 출시 자산이나 3D 모델링 시트로 직접 사용하지 않는다.

## 현재 기준 파일

- `style_reference/Japanese_Subculture_CharacterStyle_REFERENCE_v001.png`: 사용자가 지정한 일본 모바일 서브컬처 얼굴·눈·헤어·셀 채색 품질 감도 레퍼런스다. 캐릭터·의상·UI·구도는 복제하지 않는다.
- `characters/STYLE_RESET_2026-08-04.md`: 서양권 반실사 드리프트 반려 사유, 유지할 콘텐츠 앵커, 현재 5인 교체 KeyArt와 승인 경계를 기록한다.
- `characters/lineup/ReCamp_FiveCharacterLineup_REVIEW_v002.png`: 새 일본 서브컬처 KeyArt 5종을 인체 높이 기준으로 정규화한 현재 교차 비교판이다.
- `characters/lineup/ReCamp_FiveCharacterCrossReview_REVIEW_v002.png`: 새 KeyArt 기반 exact 128px 얼굴과 저채도·실루엣 교차 증거다.
- `characters/lineup/ReCamp_CurrentRoster_ART-1504_FinalComparison_REVIEW_20260812.png`: 오전 로스터 `418ef96` 기준 CH101~CH105 현재 2D 시트와 2D/3D 목표를 비교하는 ART-1504 REVIEW 시트다.
- `../art_source/manifests/CH101-105_2DTo3D_Translation_Proof_REVIEW_20260812.md`: CH101~CH105 변환 계약과 CHA-B01~B10 문서 증거를 통합 감사한 ART-0112 REVIEW 문서다.
- `moodboard/battle_vertical_slice_concept.png`: 기존 원본 전투 콘셉트. 캐릭터 감성, 쿼터뷰, 환경, 색 대비의 `PRIMARY REVIEW` 앵커다. 정확한 체형 비율은 최신 Baseline을 따른다.
- `art_direction/ReCamp_CharacterLineup_REVIEW_v003.png`: 과거 4~4.5등신 시도 이력을 보존한 파생 `REVIEW` 라인업이다. Gate A 자동 리뷰 권고는 `FAIL`이며 새 캐릭터 제작의 외형·비율 앵커로 사용하지 않는다.
- `art_direction/ReCamp_CharacterLineup_REVIEW_v003.review.md`: 모티프 충돌·얼굴·실루엣 수정 지시와 Unity 적용 제한을 기록한다.
- `art_direction/ReCamp_CharacterLineup_REJECTED_v002.png`: 남성 캐릭터가 포함되고 원본 계보를 따르지 않은 실패 기록이다. 제작 레퍼런스로 사용하지 않는다.
- 각 이미지의 `*.metadata.md`: 생성 도구, 입력 레퍼런스, 프롬프트, 판정과 사용 제한을 기록한다.

원격 v001 `art_direction/ReCamp_Character_Lineup.png`는 거의 빈 이미지이고 LFS 규칙도 위반해 폐기했다. 새 작업에서 복원하거나 기준으로 사용하지 않는다.

## 운영 원칙

- 성인 여성 5인, 남성향 일본 모바일 서브컬처, 2D 일반 등신, 3D 5~6등신 스타일라이즈드 방향을 유지한다. 3D 기본 목표는 약 5.2~5.5등신이며 캐릭터별 허용 범위는 최신 Baseline을 따른다.
- 대량 생성 후보 전체를 저장하지 않고, 비교·회귀 방지에 필요한 결과만 상태와 메타데이터를 붙여 보존한다.
- 사람 검토 전 `APPROVED`로 승격하지 않는다.
- 이미지 교체 시 버전, 상태, 입력 레퍼런스, 사람 수정 내역을 갱신한다.
- 상업 이용 조건이 확인되지 않은 생성물은 최종 게임 자산으로 사용하지 않는다.

세부 기준은 `docs/05_art_concept/`와 `art_direction/README.md`를 따른다.
