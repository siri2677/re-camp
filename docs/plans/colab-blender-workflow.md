# Re:Camp Colab Blender Workflow

> 상태: `REVIEW / AUTOMATION SCAFFOLD ONLY`
> 기준: `art/current-roster-gate-a-ch102`
> Source art: morning current-roster commit `418ef96`

이 문서는 Google Colab의 무료 관리형 Notebook과 Google Drive를 사용해 Blender 자동화 실험을 재현하는 방법을 정의한다. 이 패키지는 Blender GUI 작업, 최종 캐릭터 모델, Unity Import, Android 성능, 사람 Gate B 승인을 주장하지 않는다.

Google Drive 권한이 보안 프로그램에 의해 차단되면 `notebooks/00_colab_blender_nodrive_test.ipynb`를 사용한다. 이 대체 경로는 Drive를 mount하지 않고, 실행 결과를 `/content`에서 ZIP으로 만들어 브라우저 다운로드한다.

## 1. 저장소 역할 분리

| 위치 | 소유 내용 | 지속성 |
|---|---|---|
| GitHub `re-camp` | Notebook, Blender Python, 검증 코드, 문서 | 영구 |
| Google Drive `MyDrive/re-camp` | `.blend`, FBX, 렌더, JSON 리포트 | 영구적 저장 대상 |
| Colab `/content` | 현재 실행 중인 Blender와 임시 작업 복사본 | 세션 종료 시 삭제 |

Drive는 영구 작업 저장소로 쓰되, 대량의 Blender 파일을 Drive에서 직접 편집하지 않는다. 작업 시작 시 `/content`로 복사하고, 렌더·FBX·리포트를 완료 후 Drive에 동기화한다.

## 2. Notebook 실행 순서

1. `notebooks/00_colab_blender_setup.ipynb`를 Colab에서 연다.
2. Drive를 `/content/drive`에 mount한다.
3. `re-camp` 저장소의 지정 branch를 `/content/re-camp`에 clone한다.
4. Blender를 현재 Colab runtime에 설치하고 버전을 출력한다.
5. `notebooks/01_ch101_blockout.ipynb`를 실행한다.
6. CH101 approved 2D source를 읽기 입력으로 사용하고, 임시 `/content`에서 문서용 blockout을 만든다.
7. Front/Side/Back PNG, `.blend`, 선택적 FBX, JSON 검증 리포트를 Drive의 `re-camp/ch101_blockout/`에 복사한다.

### Drive 없는 테스트 경로

1. `notebooks/00_colab_blender_nodrive_test.ipynb`를 연다.
2. 모든 셀을 순서대로 실행한다.
3. 마지막 셀에서 `re-camp-CH101-blockout.zip`을 다운로드한다.
4. Colab 세션이 종료되기 전에 ZIP을 로컬에 보관한다.

## 3. 자동화 범위

현재 스크립트가 자동화하는 항목:

- 중립적인 humanoid blockout primitive 생성
- 장비 placeholder와 Gate B socket 이름 생성
- Front/Side/Back 렌더
- `.blend` 저장
- 선택적 FBX export
- socket·mesh·source commit·Gate 상태 JSON 검증

현재 스크립트가 자동화하지 않는 항목:

- 승인된 2D 이미지를 최종 3D 얼굴·헤어·의상으로 변환
- sculpting, topology, weight paint, facial rig, final animation
- Unity Editor 시각 Import 확인
- Android 성능 측정
- Gate B 사람 승인

생성물의 상태는 항상 `DOCUMENTATION ONLY / NOT GATE B APPROVED`와 `technical proof: NOT TESTED`로 기록한다.

## 4. 세션 종료와 백업 규칙

- Notebook의 첫 셀에서 Drive를 mount한다.
- 현재 runtime에 설치한 Blender는 세션 종료 후 사라질 수 있으므로 설치 셀을 매번 재실행한다.
- `.blend` 저장 직후 Drive에 복사한다.
- 장시간 작업은 여러 단계의 checkpoint 파일을 만든다.
- GitHub에는 재현 가능한 스크립트·Notebook·문서만 먼저 push한다.
- 생성 FBX와 렌더를 Git에 넣을 때는 용량과 LFS 정책을 먼저 확인한다.

## 5. 로컬 검증

Notebook JSON과 Blender Python 문법은 Blender가 설치되지 않은 환경에서도 다음으로 확인한다.

```text
python scripts/validate_colab_package.py
```

Blender가 설치된 환경에서는 다음을 실행한다.

```text
blender --background --python scripts/blender/build_blockout.py -- --character CH101 --output-dir artifacts/ch101 --render --export-fbx
blender --background --python scripts/blender/validate_asset.py -- --blend artifacts/ch101/CH101_Blockout_REVIEW_v001.blend --report artifacts/ch101/reports/validation.json
```

이 저장소의 현재 Codex 실행 환경에는 Blender가 설치되어 있지 않으므로, 위 명령은 Colab 또는 Blender가 설치된 로컬/GPU 환경에서 실행해야 한다.
