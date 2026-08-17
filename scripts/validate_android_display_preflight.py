#!/usr/bin/env python3
"""Validate deterministic Android landscape and safe-area project settings."""

from __future__ import annotations

import json
import re
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
PROJECT_SETTINGS = ROOT / "ProjectSettings" / "ProjectSettings.asset"
REPORT = ROOT / "planning" / "DEV-0115_ANDROID_DISPLAY_PREFLIGHT.json"


def setting(text: str, name: str) -> int | None:
    match = re.search(rf"^\s*{re.escape(name)}:\s*(-?\d+)\s*$", text, re.MULTILINE)
    return int(match.group(1)) if match else None


def main() -> int:
    text = PROJECT_SETTINGS.read_text(encoding="utf-8")
    expected = {
        "defaultScreenOrientation": 4,
        "allowedAutorotateToPortrait": 0,
        "allowedAutorotateToPortraitUpsideDown": 0,
        "allowedAutorotateToLandscapeRight": 1,
        "allowedAutorotateToLandscapeLeft": 1,
    }
    values = {name: setting(text, name) for name in expected}
    errors = [f"{name} expected {want}, got {values[name]}" for name, want in expected.items() if values[name] != want]
    report = {
        "project_settings": str(PROJECT_SETTINGS),
        "status": "PASS" if not errors else "FAIL",
        "orientation": "LANDSCAPE_AUTO_ROTATE_ONLY",
        "values": values,
        "safe_area_contract": {
            "source": "Assets/_ReCamp/Scripts/UI/BattleHudController.cs",
            "calculator": "ReCamp.UnityAdapter.SafeAreaLayout",
            "cutout_test_matrix": [
                {"width": 1920, "height": 1080, "x": 96, "y": 24, "safeWidth": 1728, "safeHeight": 1032},
                {"width": 1280, "height": 720, "x": 0, "y": 0, "safeWidth": 1280, "safeHeight": 720},
                {"width": 2340, "height": 1080, "x": 0, "y": 48, "safeWidth": 2340, "safeHeight": 1032},
            ],
        },
        "errors": errors,
        "device_validation": "PENDING / requires AndroidPlayer and physical device",
    }
    REPORT.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(report, ensure_ascii=False, indent=2))
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())
