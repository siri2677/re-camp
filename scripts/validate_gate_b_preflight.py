#!/usr/bin/env python3
"""Validate the documentation-only Gate B preflight package for CH101-CH105."""

from __future__ import annotations

import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE_COMMIT = "418ef96"
COMMON_CHECKLIST = "docs/05_art_concept/ART_REVIEW_CHECKLIST.md"
COMMON_SPEC = "docs/05_art_concept/CHARACTER_3D_SPEC.md"

CHARACTERS = {
    "CH101": "art_source/manifests/CH101_Rin_GateB_Preflight_REVIEW_v001.md",
    "CH102": "art_source/manifests/CH102_Mao_GateB_Preflight_REVIEW_v001.md",
    "CH103": "art_source/manifests/CH103_Nozomi_GateB_Preflight_REVIEW_v001.md",
    "CH104": "art_source/manifests/CH104_Shion_GateB_Preflight_REVIEW_v001.md",
    "CH105": "art_source/manifests/CH105_Akari_GateB_Preflight_REVIEW_v001.md",
}

APPROVED_SHEETS = {
    "CH101": "art_refs/characters/rin/concept/CH101_Rin_CharacterSheet_APPROVED_v001.png",
    "CH102": "art_refs/characters/mao/concept/CH102_Mao_CharacterSheet_APPROVED_v001.png",
    "CH103": "art_refs/characters/nozomi/concept/CH103_Nozomi_CharacterSheet_APPROVED_v001.png",
    "CH104": "art_refs/characters/shion/concept/CH104_Shion_CharacterSheet_APPROVED_v001.png",
    "CH105": "art_refs/characters/akari/concept/CH105_Akari_CharacterSheet_APPROVED_v001.png",
}

STALE_MARKERS = (
    "GATE A PENDING",
    "Gate A pending / 2D APPROVED not granted",
    "Human Gate A remains pending",
)


def read(relative: str, errors: list[str]) -> str:
    path = ROOT / relative
    if not path.is_file():
        errors.append(f"missing required Gate B file: {relative}")
        return ""
    return path.read_text(encoding="utf-8")


def require(text: str, marker: str, label: str, errors: list[str]) -> None:
    if marker not in text:
        errors.append(f"{label} missing marker: {marker!r}")


def validate_character_preflights(errors: list[str]) -> None:
    for character, relative in CHARACTERS.items():
        text = read(relative, errors)
        if not text:
            continue
        label = f"{character} Gate B preflight"
        require(text, SOURCE_COMMIT, label, errors)
        require(text, COMMON_CHECKLIST, label, errors)
        require(text, COMMON_SPEC, label, errors)
        require(text, APPROVED_SHEETS[character], label, errors)
        require(text, "Gate B", label, errors)
        require(text, "NOT APPROVED", label, errors)
        require(text, "NOT TESTED", label, errors)
        for marker in STALE_MARKERS:
            if marker in text:
                errors.append(f"{label} contains stale approval marker: {marker!r}")


def validate_integrated_preflight(errors: list[str]) -> None:
    relative = "art_source/manifests/CH101-105_GateB_Preflight_REVIEW_20260812.md"
    text = read(relative, errors)
    if not text:
        return
    label = "integrated Gate B preflight"
    require(text, SOURCE_COMMIT, label, errors)
    require(text, "Gate B: `NOT APPROVED`", label, errors)
    require(text, "3D/Unity proof: `NOT TESTED`", label, errors)
    require(text, COMMON_CHECKLIST, label, errors)
    require(text, COMMON_SPEC, label, errors)
    for character in CHARACTERS:
        require(text, character, label, errors)
    for marker in STALE_MARKERS:
        if marker in text:
            errors.append(f"{label} contains stale approval marker: {marker!r}")


def main() -> int:
    errors: list[str] = []
    validate_character_preflights(errors)
    validate_integrated_preflight(errors)
    if errors:
        print("Gate B preflight validation failed:\n")
        for error in errors:
            print(f"- {error}")
        return 1
    print("Gate B preflight validation passed (CH101-CH105 documentation package checked).")
    return 0


if __name__ == "__main__":
    sys.exit(main())
