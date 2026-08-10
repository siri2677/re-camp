#!/usr/bin/env python3
"""Validate Re:Camp Current Generation documentation ownership.

Uses only the Python standard library so it can run locally and in GitHub Actions.
"""

from __future__ import annotations

import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
BASELINE = ROOT / "docs/00_project/CURRENT_PROJECT_BASELINE.md"

ROUTING_FILES = {
    "AGENTS": ROOT / "AGENTS.md",
    "Skill": ROOT / ".agents/skills/recamp-unity/SKILL.md",
    "README": ROOT / "README.md",
    "Planning Index": ROOT / "planning/README.md",
}

OWNED_FILES = {
    "Character Bible": ROOT / "docs/05_art_concept/CHARACTER_BIBLE.md",
    "Character Anchor": ROOT / "docs/05_art_concept/CHARACTER_ANCHOR_SPEC.md",
    "Art Direction": ROOT / "docs/05_art_concept/ART_DIRECTION.md",
    "Roadmap": ROOT / "planning/roadmap.md",
    "Sprint Backlog": ROOT / "planning/sprint_backlog.md",
    "Implementation Status": ROOT / "planning/IMPLEMENTATION_STATUS.md",
    "Art Roadmap": ROOT / "planning/art_production_roadmap.md",
    "Art Backlog": ROOT / "planning/art_production_backlog.md",
}

HISTORICAL_DOCS = {
    ROOT / "planning/DESIGN_DIRECTION_2026-08-09.md",
    ROOT / "planning/ART_DIRECTION_RESET_BRIEF_2026-08-09.md",
    ROOT / "planning/DESIGN_PROGRESS_2026-08-07.md",
    ROOT / "docs/plans/DESIGN_REFACTOR_ALIGNMENT_2026-08-09.md",
}

STALE_PHRASES = (
    "2D 일반 등신",
    "3D 4~5등신",
    "4~5등신 SD-lite",
    "기본 목표 비율은 약 5.2~5.5",
    "1차 상용 출시: Steam Windows",
    "Steam Windows — 1차 상용 출시",
)

# Global decisions must not be copied into routing/index files.
ROUTING_DUPLICATION_PHRASES = (
    "6.8~7.4",
    "5.2~5.8",
    "아마사와 린",
    "키사라기 마오",
    "카나데 노조미",
    "시온 타테가미",
    "쿠로가네 아카리",
)

REQUIRED_BASELINE_MARKERS = (
    "current/recamp-unified",
    "legacy/recamp-pre-generation",
    "1인 개발 Production Budget",
    "LLM 작업별 필수 Read Set",
    "문서 역할과 갱신 규칙",
    "Branch와 PR 기준",
    "scripts/validate_project_docs.py",
)

SKIP_DIR_NAMES = {
    ".git",
    "Library",
    "Temp",
    "Logs",
    "bin",
    "obj",
    "art_refs",  # asset metadata/reviews may quote historical decisions accurately
}


def read(path: Path, errors: list[str]) -> str:
    if not path.is_file():
        errors.append(f"missing required file: {path.relative_to(ROOT)}")
        return ""
    return path.read_text(encoding="utf-8")


def active_markdown_files() -> list[Path]:
    files: set[Path] = set()
    for base in (ROOT, ROOT / "docs", ROOT / "planning", ROOT / ".agents"):
        if not base.exists():
            continue
        for path in base.rglob("*.md"):
            relative = path.relative_to(ROOT)
            if any(part in SKIP_DIR_NAMES for part in relative.parts):
                continue
            if path in HISTORICAL_DOCS:
                continue
            files.add(path)
    return sorted(files)


def validate_baseline(errors: list[str]) -> None:
    text = read(BASELINE, errors)
    for marker in REQUIRED_BASELINE_MARKERS:
        if marker not in text:
            errors.append(f"Baseline missing required marker {marker!r}")


def validate_routing(errors: list[str]) -> None:
    baseline_ref = "docs/00_project/CURRENT_PROJECT_BASELINE.md"
    for label, path in ROUTING_FILES.items():
        text = read(path, errors)
        if not text:
            continue
        if baseline_ref not in text:
            errors.append(f"{label} does not route global decisions to the Baseline: {path.relative_to(ROOT)}")
        for phrase in STALE_PHRASES + ROUTING_DUPLICATION_PHRASES:
            if phrase in text:
                errors.append(f"{label} duplicates/stales global guidance {phrase!r}: {path.relative_to(ROOT)}")


def validate_owned_files(errors: list[str]) -> None:
    for label, path in OWNED_FILES.items():
        text = read(path, errors)
        if not text:
            continue
        if "CURRENT_PROJECT_BASELINE.md" not in text:
            errors.append(f"{label} must reference the Canonical Baseline: {path.relative_to(ROOT)}")


def validate_historical_docs(errors: list[str]) -> None:
    for path in sorted(HISTORICAL_DOCS):
        text = read(path, errors)
        if not text:
            continue
        if "HISTORICAL" not in text and "SUPERSEDED" not in text:
            errors.append(f"date-stamped design document is not marked historical/superseded: {path.relative_to(ROOT)}")
        if "CURRENT_PROJECT_BASELINE.md" not in text:
            errors.append(f"historical design document does not route current decisions to Baseline: {path.relative_to(ROOT)}")


def validate_all_active_docs(errors: list[str]) -> None:
    for path in active_markdown_files():
        text = path.read_text(encoding="utf-8")
        for phrase in STALE_PHRASES:
            if phrase in text:
                errors.append(f"stale generation guidance {phrase!r} in active document: {path.relative_to(ROOT)}")


def validate_branch_language(errors: list[str]) -> None:
    baseline = read(BASELINE, errors)
    readme = read(ROOT / "README.md", errors)
    agents = read(ROOT / "AGENTS.md", errors)
    for path, text in ((BASELINE, baseline), (ROOT / "README.md", readme), (ROOT / "AGENTS.md", agents)):
        if "develop   :" in text or "develop :" in text:
            errors.append(f"long-lived develop guidance remains in {path.relative_to(ROOT)}")


def main() -> int:
    errors: list[str] = []
    validate_baseline(errors)
    validate_routing(errors)
    validate_owned_files(errors)
    validate_historical_docs(errors)
    validate_all_active_docs(errors)
    validate_branch_language(errors)

    if errors:
        print("Current Generation documentation validation failed:\n")
        for error in errors:
            print(f"- {error}")
        return 1

    print(f"Current Generation documentation validation passed ({len(active_markdown_files())} active Markdown files checked).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
