# Re:Camp Workspace

- Re:Camp 기획·Unity·아트·MCP 작업을 시작할 때 `.agents/skills/recamp-unity/SKILL.md`를 적용한다.
- 진입점은 `planning/README.md`다. 먼저 이것만 읽고, 필요한 작업 ID와 문서만 `rg`로 찾는다. `planning/`, `docs/`, `art/` 전체를 한꺼번에 읽지 않는다.
- 고정 방향은 성인 여성 5인, 남성향 서브컬처, 2D 일반 등신, 3D 5~6등신 스타일라이즈드다. 기본 목표 비율은 약 5.2~5.5등신이며 캐릭터별로 5~6등신 범위를 허용한다. `battle_vertical_slice_concept.png`를 원본 전투 비주얼 앵커로 사용하되 정확한 체형 비율은 최신 Baseline을 따른다. 현재 회색 박스는 최종 품질이 아니다.
- 기존 사용자 변경을 보존하고 소스는 `apply_patch`로 수정한다. Unity 패키지 캐시나 설치된 플러그인 캐시는 수정하지 않는다.
- Unity 변경은 컴파일, `_ReCamp` 오류 Console, EditMode/PlayMode 테스트를 변경 위험에 맞게 검증한다. MCP 결과 전체 JSON을 대화에 전달하지 말고 요약 필드만 출력하며 반복 작업은 배치한다.
- 아트는 사람 승인 전까지 `APPROVED`로 표시하지 않는다. ComfyUI와 대용량 생성 모델은 세부 아트가 필요한 시점의 선택 사항이다.
- 커밋·푸시는 사용자가 명시적으로 요청한 경우에만 수행한다.
