#!/usr/bin/env python3
"""Validate Re:Camp's canonical documentation ownership and stale guidance.

This script intentionally uses only the Python standard library so it can run
locally and in GitHub Actions without installing project dependencies.
"""

from __future__ import annotations

import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASELINE = ROOT / "docs/00_project/CURRENT_PROJECT_BASELINE.md"

ROUTING_FILES = {
    "AGENTS.md": ROOT / "AGENTS.md",
    "Skill": ROOT / ".agents/skills/recamp-unity/SKILL.md",
    "README": ROOT / "README.md",
    "Planning index": ROOT / "planning/README.md",
}

OWNERSHIP_FILES = {
    "Baseline": BASELINE,
    "Art Direction": ROOT / "docs/05_art_concept/ART_DIRECTION.md",
    "Character Bible": ROOT / "docs/05_art_concept/CHARACTER_BIBLE.md",
    "Roadmap": ROOT / "planning/roadmap.md",
    "Sprint Backlog": ROOT / "planning/sprint_backlog.md",
    "Art Roadmap": ROOT / "planning/art_production_roadmap.md",
    "Art Backlog": ROOT / "planning/art_production_backlog.md",
}

STALE_PHRASES = (
    "2D 일반 등신",
    "3D 4~5등신",
    "4~5등신 SD-lite",
    "기본 목표 비율은 약 5.2~5.5",
    "1차 상용 출시: Steam Windows",
    "Steam Windows — 1차 상용 출시",
)

# Historical asset records may accurately quote superseded decisions.
HISTORICAL_PATH_MARKERS = (
    "art_refs/",
    ".metadata.md",
    ".review.md",
    "REJECTED",
    "INVALID",
)

REQUIRED_BASELINE_MARKERS = (
    "LLM 작업별 필수 Read Set",
    "문서 역할과 갱신 규칙",
    "Branch와 PR 기준",
    "scripts/validate_project_docs.py",
)

V003_POSITIVE_ACTIONS = re.compile(
    r"v003.{0,80}(교정|수정해서 사용|기반 이미지|제작 앵커|재사용)", re.IGNORECASE
)
V003_NEGATIONS = (
    "사용하지",
    "기준으로 사용하지",
    "이력",
    "실패",
    "금지",
    "보존",
    "아니다",
)


def read_text(path: Path, errors: list[str]) -> str:
    if not path.is_file():
        errors.append(f"missing required file: {path.relative_to(ROOT)}")
        return ""
    return path.read_text(encoding="utf-8")


def is_historical(path: Path) -> bool:
    normalized = path.relative_to(ROOT).as_posix()
    return any(marker in normalized for marker in HISTORICAL_PATH_MARKERS)


def iter_operational_markdown() -> list[Path]:
    candidates: list[Path] = []
    for base in (ROOT, ROOT / "docs", ROOT / "planning", ROOT / ".agents"):
        if not base.exists():
            continue
        for path in base.rglob("*.md"):
            relative = path.relative_to(ROOT)
            if any(part in {".git", "Library", "Temp", "Logs", "bin", "obj"} for part in relative.parts):
                continue
            if is_historical(path):
                continue
            candidates.append(path)
    return sorted(set(candidates))


def validate_routing(errors: list[str]) -> None:
    baseline_ref = "docs/00_project/CURRENT_PROJECT_BASELINE.md"
    for label, path in ROUTING_FILES.items():
        text = read_text(path, errors)
        if not text:
            continue
        if baseline_ref not in text:
            errors.append(f"{label} must route global decisions to {baseline_ref}: {path.relative_to(ROOT)}")
        for phrase in STALE_PHRASES:
            if phrase in text:
                errors.append(f"{label} contains stale global guidance {phrase!r}: {path.relative_to(ROOT)}")


def validate_baseline(errors: list[str]) -> None:
    text = read_text(BASELINE, errors)
    for marker in REQUIRED_BASELINE_MARKERS:
        if marker not in text:
            errors.append(f"Baseline missing required section/marker {marker!r}")


def validate_ownership_headers(errors: list[str]) -> None:
    baseline_ref = "CURRENT_PROJECT_BASELINE.md"
    for label, path in OWNERSHIP_FILES.items():
        text = read_text(path, errors)
        if not text or path == BASELINE:
            continue
        if baseline_ref not in text:
            errors.append(f"{label} must reference the canonical Baseline: {path.relative_to(ROOT)}")


def validate_stale_phrases(errors: list[str]) -> None:
    for path in iter_operational_markdown():
        text = path.read_text(encoding="utf-8")
        relative = path.relative_to(ROOT)
        for phrase in STALE_PHRASES:
            if phrase in text:
                errors.append(f"stale phrase {phrase!r} in active document: {relative}")

        for line_number, line in enumerate(text.splitlines(), start=1):
            if not V003_POSITIVE_ACTIONS.search(line):
                continue
            if any(negation in line for negation in V003_NEGATIONS):
                continue
            errors.append(
                f"v003 appears to be promoted as an active design source: {relative}:{line_number}: {line.strip()}"
            )


def validate_no_long_lived_develop(errors: list[str]) -> None:
    readme = read_text(ROOT / "README.md", errors)
    baseline = read_text(BASELINE, errors)
    for path, text in ((ROOT / "README.md", readme), (BASELINE, baseline)):
        if "develop   :" in text or "develop :" in text:
            errors.append(f"long-lived develop branch guidance remains in {path.relative_to(ROOT)}")


def main() -> int:
    errors: list[str] = []
    validate_routing(errors)
    validate_baseline(errors)
    validate_ownership_headers(errors)
    validate_stale_phrases(errors)
    validate_no_long_lived_develop(errors)

    if errors:
        print("Documentation consistency validation failed:\n")
        for error in errors:
            print(f"- {error}")
        return 1

    checked = len(iter_operational_markdown())
    print(f"Documentation consistency validation passed ({checked} active Markdown files checked).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
