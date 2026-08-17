# Re:Camp 디자인 작업 진척도 — 2026-08-07

> 최종 갱신: 2026-08-08

## 결론

기존 5인 2D 산출물은 파일 수량·해상도·비율·메타데이터 기준으로는 작성됐지만, 사용자가 2026-08-07
화풍 불일치와 목표 품질 미달을 명시적으로 거절했다. 따라서 현행 KeyArt·Face128·통합 시트·라인업은
Gate A `FAIL / STYLE REJECTED / HISTORY ONLY`이며 계획한 디자인 작업은 완료 상태가 아니다.

새 방향은 원신·승리의 여신: 니케·이환·젠레스 존 제로의 고유 캐릭터를 복제하지 않고, 그 품질군에서
공통적으로 느껴지는 고급 애니메이션 얼굴·성인 여성 매력·도시형 패션·정돈된 셀 렌더링을 Re:Camp의
독자 하우스 스타일로 재구성하는 것이다.

## 사용자 Gate A 거절 기록

- 판정일: 2026-08-07
- 판정: `FAIL / REVISION REQUIRED`
- 승인된 캐릭터: `0/5`
- 핵심 사유: 5인의 선화·얼굴 해부·눈·피부·헤어·재질·광원·배경 렌더링이 서로 달라 한 게임의
  로스터로 보이지 않음
- 추가 사유: 코코의 서양 핀업풍, 이리스의 별도 고밀도 SF 일러스트풍, 노아의 3D 세미리얼풍이 강하며
  사용자가 원하는 프리미엄 애니메이션·가챠 캐릭터 감도에 미달

## 새 스타일 캘리브레이션

| 산출물 | 역할 | 현재 판정 |
|---|---|---|
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFaceStyleMaster_WIP_v002.png` | 동일 얼굴 해부·홍채·선화·피부·헤어 채색을 검토하는 5인 흉상 마스터 | `ACTIVE WIP`; 루나 기계식 센서 귀 교정 완료, 사용자 스타일 락 판정 필요 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFullBodyFashionLineup_WIP_v007.png` | 같은 렌더러의 5인 전신·패션·체형·노출도·실루엣 캘리브레이션 | `ACTIVE WIP`; 루나는 패널 없는 차콜 쇼츠, 미유는 쇼츠 위 짧은 라일락 랩 패널·바닥 케이블 없음으로 하체 실루엣 분리, 전체 스타일 락 필요 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFullBodyFashionLineup_WIP_v006.png` | 루나·미유 하체 패널 배분 교정 | `SUPERSEDED WIP`; 패널 배분은 맞지만 루나 쇼츠가 밝은 크림색으로 변해 v007에서 재질 복원 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFullBodyFashionLineup_WIP_v005.png` | 미유 순수 테크 쇼츠 실험 | `SUPERSEDED WIP`; 최신 사용자 선택은 미유의 짧은 랩 패널 복원·루나 패널 제거 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFullBodyFashionLineup_WIP_v004.png` | 사용자 선호 노출도와 5인 신장·체형 분리 기준 | `SUPERSEDED WIP`; v005~v007의 비율·신장 베이스 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFullBodyFashionLineup_WIP_v003.png` | 사용자 선호 노출도를 유지한 스트랩 정리본 | `SUPERSEDED WIP`; v004의 비율 수정 베이스 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFullBodyFashionLineup_WIP_v001.png` | 최초 전신 패션 라인업과 사용자 선호 노출도 기준 | `USER-PREFERRED BASE`; v003·v004 계보의 노출도 기준 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFullBodyFashionLineup_WIP_v002.png` | 긴 바지·크롭 팬츠를 포함한 하체 구조 분리 실험 | `USER REJECTED / HISTORY ONLY`; v001보다 허벅지 노출이 줄어 선호 방향과 불일치 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterFaceStyleMaster_WIP_v001.png` | 최초 얼굴 마스터 이력 | `SUPERSEDED WIP`; 루나 생물 귀 오류로 v002가 우선 |
| `art_refs/characters/style_calibration/ReCamp_FiveCharacterStyleCalibration_WIP_v001.png` | 동일 카메라·광원·전신 렌더링 가능성 검토 | `WIP`; 렌더 일관성은 개선됐으나 기존 전술복 영향과 얼굴 검토 크기 한계가 있음 |

새 캘리브레이션 이미지는 built-in `imagegen`으로 생성·편집했다. 사용자 제공 화면은
스타일·매력·채색 품질 참고로만, Character Bible과 Anchor Spec은 역할·팔레트·대표 장비 기준으로
사용했다. 외부 작품의 캐릭터, 의상, 무기, UI, 로고와 고유 모티프는 복제하지 않는다.

## 거절된 현행 앵커

| 캐릭터 | 역사 자료로 남기는 KeyArt | 판정 |
|---|---|---|
| 루나 | `art_refs/characters/luna/concept/Luna_KeyArt_REVIEW_v002.png` | `STYLE REJECTED`; 단독 애니풍 요소는 있으나 공통 렌더 락 없음 |
| 미유 | `art_refs/characters/miyu/concept/Miyu_KeyArt_REVIEW_v002.png` | `STYLE REJECTED`; 로스터 공통 얼굴·재질과 불일치 |
| 코코 | `art_refs/characters/coco/concept/Coco_KeyArt_REVIEW_v005.png` | `STYLE REJECTED`; 서양 핀업·다른 선화/배경 처리 |
| 이리스 | `art_refs/characters/iris/concept/Iris_KeyArt_REVIEW_v006.png` | `STYLE REJECTED`; 별도 고밀도 SF 렌더와 길어진 얼굴·체형 |
| 노아 | `art_refs/characters/noah/concept/Noah_KeyArt_REVIEW_v003.png` | `STYLE REJECTED`; 가장 강한 3D·세미리얼 얼굴·광원·재질 드리프트 |

## 계획 대비 현재 진척

| 계획 항목 | 유효 수량 | 현재 판정 |
|---|---:|---|
| 공통 하우스 스타일 계약 | 1/1 | 문서 보강 완료, 시각 검증 `In Progress` |
| 5인 얼굴·흉상 스타일 마스터 | 1/1 | WIP v002 생성, 사용자 재검토 전 |
| 5인 전신 패션 캘리브레이션 | 1/1 | WIP v007 생성; 사용자 노출도·신장·체형, 루나 패널 없는 차콜 쇼츠, 미유 짧은 랩 패널·바닥 케이블 제외 방향 반영, 전체 스타일 락 전 |
| 얼굴 하우스 스타일 사용자 승인 | 0/1 | Gate A 재시험 필요 |
| 선택 KeyArt | 0/5 | 기존 5개는 역사 자료, 스타일 락 후 전면 재생성 |
| 전신 후보·Turnaround·표정·장비·팔레트 | 0/5 | 구조·비율 메모는 재사용 가능, 현행 시각 결과는 승인 근거로 사용 불가 |
| exact 128px 얼굴 | 5/5 기술 증거 | 크기는 유효하지만 얼굴 그림체가 거절돼 재생성 필요 |
| 2D→3D 변환표 | 5/5 기술 초안 | 측정·확대/삭제/결합 원칙만 유지, 새 KeyArt로 재측정 필요 |
| 4096×4608 통합 시트 | 0/5 유효 | 기존 5개는 기술 조립 이력, 시각 방향 무효 |
| 5인 라인업·교차 검토 | 0/2 유효 | 기존 v002 보드는 Gate A 실패 이력 |
| 사람 Gate A 승인 | 0/5 | `FAIL / REVISION REQUIRED` |
| 3D Blockout | 0/5 | 새 루나 Gate A 승인 이후 시작 |
| 최종 Unity 아트 적용 | 0/5 | 3D Gate B/C 이후 진행 |

## 현재 작업 상태

- `ART-0101`: 공통 하우스 스타일 반복 워크플로 재설계 `In Progress`
- 2026-08-08 사용자 방향: 전신 v002의 바지형보다 v001의 짧은 하의·허벅지 노출을 선호. 해당 방향과
  신장·체형을 유지하면서 루나는 치마형 힙 패널 없이 차콜 쇼츠만, 미유는 쇼츠 위 짧은 라일락
  비대칭 랩 패널을 유지하되 바닥 케이블은 제외한 v007을 활성 WIP로 지정
- `ART-1001~1409`: 5인 KeyArt와 파생 시트 전면 재작업 `In Progress`
- `ART-1501~1504`: 새 KeyArt 확정 뒤 일관성·얼굴·실루엣·유사성 보드 재작성 `In Progress`
- A2 공식 완료: 5명 모두 동일 하우스 스타일로 사람 Gate A를 통과할 때
- 기존 169개 PNG: 삭제하지 않고 실패 이력·비율·장비 구조·도구 검증 자료로 보존

## 다음 제작 순서

```text
5인 얼굴·흉상 하우스 스타일 마스터 WIP v002
→ 5인 전신 패션·노출도·체형 라인업 WIP v007
→ 사용자 공통 스타일·얼굴·패션·실루엣 락
→ 같은 마스터를 공통 참조로 5인 개별 KeyArt 생성
→ Face128·Turnaround·표정·장비·2D→3D·통합 시트 재전파
→ ART-1501~1504 재검토
→ 캐릭터별 Gate A 승인
```

`APPROVED`: `NOT GRANTED`
