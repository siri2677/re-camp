# Re:Camp Art References

이 디렉터리는 Re:Camp 아트 제작의 기준 이미지와 승인 상태를 관리한다.

## 현재 포함된 파일

### `art_direction/ReCamp_Character_Lineup.png`

루나·미유·코코·이리스·노아의 역할·대표 색상·무기·큰 실루엣을 통합한 캐릭터 라인업이다.

- 상태: `DIRECTION_APPROVED`
- 승인 범위: 캐릭터 이름·역할·대표 색상·장비·큰 실루엣 방향
- 용도: 개별 캐릭터 시안과 5인 일관성 비교의 출발점
- 제한: 최종 얼굴·의상 구조·Turnaround·3D 모델링 시트로 직접 사용하지 않음

`DIRECTION_APPROVED`는 개별 자산의 `APPROVED`와 다르다. 각 캐릭터는 별도의 제작 시트를 거쳐야 최종 모델링 기준으로 사용할 수 있다.

## 사용 우선순위

```text
개별 캐릭터 APPROVED 제작 시트
> APPROVED Art Direction Board·Palette
> DIRECTION_APPROVED 통합 라인업
> REVIEW 개별 후보
> WIP 생성 후보
```

## 현재 제작 순서

```text
통합 라인업 방향 유지
→ 루나 개별 후보 3안
→ 루나 2D APPROVED 제작 시트
→ 루나 3D 5~6등신 Blockout
→ Coplay/Aura Unity 검증
→ 루나 Character Proof
→ 나머지 캐릭터 최종 제작
```

## 운영 원칙

- 대량 생성 후보를 전부 저장하지 않는다.
- 캐릭터별 얼굴·헤어·의상·무기 구조는 개별 Approved 시트에서 확정한다.
- 파일 교체 시 Version·상태·변경 이유를 갱신한다.
- AI 생성 이미지는 Tool·Model·Seed·입력 Reference·Human Edit·License를 기록한다.
- 상업 사용 조건을 확인하지 못한 생성물은 최종 게임 자산으로 사용하지 않는다.
- `SUPERSEDED` 자산은 신규 작업 기준으로 사용하지 않는다.

## 관련 문서

- `docs/00_project/CURRENT_PROJECT_BASELINE.md`
- `docs/05_art_concept/ART_DIRECTION.md`
- `docs/05_art_concept/CHARACTER_BIBLE.md`
- `docs/05_art_concept/ART_PRODUCTION_MCP_GUIDE.md`
- `docs/05_art_concept/ART_ASSET_STRUCTURE.md`
- `planning/art_production_next_actions.md`
