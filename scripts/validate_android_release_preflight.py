#!/usr/bin/env python3
"""Read-only ProjectSettings preflight for DEV-0117's first Android build."""

from __future__ import annotations

import json
import re
from datetime import datetime, timezone
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
PROJECT_SETTINGS = REPO_ROOT / "ProjectSettings" / "ProjectSettings.asset"
BUILD_SETTINGS = REPO_ROOT / "ProjectSettings" / "EditorBuildSettings.asset"
REPORT_PATH = REPO_ROOT / "planning" / "DEV-0117_ANDROID_RELEASE_PREFLIGHT.json"
EXPECTED_SCENES = [
    "Assets/_ReCamp/Scenes/00_Bootstrap.unity",
    "Assets/_ReCamp/Scenes/01_Title.unity",
    "Assets/_ReCamp/Scenes/02_Lobby.unity",
    "Assets/_ReCamp/Scenes/03_Battle.unity",
    "Assets/_ReCamp/Scenes/04_Result.unity",
]


def scalar(text: str, key: str) -> str | None:
    match = re.search(rf"^\s*{re.escape(key)}:\s*(.*?)\s*$", text, re.MULTILINE)
    return match.group(1) if match else None


def check(name: str, status: str, detail: str, blocking: bool = False) -> dict[str, object]:
    return {"name": name, "status": status, "blocking": blocking, "detail": detail}


def main() -> int:
    project = PROJECT_SETTINGS.read_text(encoding="utf-8")
    build = BUILD_SETTINGS.read_text(encoding="utf-8")
    checks: list[dict[str, object]] = []

    orientation = scalar(project, "defaultScreenOrientation")
    landscape_left = scalar(project, "allowedAutorotateToLandscapeLeft")
    landscape_right = scalar(project, "allowedAutorotateToLandscapeRight")
    portrait = scalar(project, "allowedAutorotateToPortrait")
    portrait_upside_down = scalar(project, "allowedAutorotateToPortraitUpsideDown")
    orientation_pass = (
        orientation == "4"
        and landscape_left == "1"
        and landscape_right == "1"
        and portrait == "0"
        and portrait_upside_down == "0"
    )
    checks.append(
        check(
            "Landscape orientation",
            "PASS" if orientation_pass else "FAIL",
            f"default={orientation}, landscapeLeft={landscape_left}, landscapeRight={landscape_right}, "
            f"portrait={portrait}, portraitUpsideDown={portrait_upside_down}",
            blocking=True,
        )
    )

    architecture = scalar(project, "AndroidTargetArchitectures")
    checks.append(
        check(
            "ARM64 architecture",
            "PASS" if architecture == "2" else "FAIL",
            f"AndroidTargetArchitectures={architecture} (expected 2 / ARM64)",
            blocking=True,
        )
    )

    backend_match = re.search(r"scriptingBackend:\s*\n\s*Android:\s*(\d+)", project)
    backend = backend_match.group(1) if backend_match else None
    checks.append(
        check(
            "Android IL2CPP backend",
            "PASS" if backend == "1" else "FAIL",
            f"scriptingBackend.Android={backend} (expected 1 / IL2CPP)",
            blocking=True,
        )
    )

    identifier_match = re.search(r"applicationIdentifier:\s*\n\s*Android:\s*(\S+)", project)
    identifier = identifier_match.group(1) if identifier_match else None
    is_template_identifier = not identifier or "unity.template" in identifier.lower() or "unitytechnologies" in identifier.lower()
    checks.append(
        check(
            "Release application identifier",
            "BLOCKED" if is_template_identifier else "PASS",
            f"Android identifier={identifier!r}; choose a Re:Camp-owned reverse-DNS ID before APK/AAB",
            blocking=True,
        )
    )

    version_code = scalar(project, "AndroidBundleVersionCode")
    checks.append(
        check(
            "Android version code",
            "PASS" if version_code and version_code.isdigit() and int(version_code) > 0 else "FAIL",
            f"AndroidBundleVersionCode={version_code}",
            blocking=True,
        )
    )

    target_sdk = scalar(project, "AndroidTargetSdkVersion")
    checks.append(
        check(
            "Android target SDK",
            "REVIEW" if target_sdk == "0" else "PASS",
            f"AndroidTargetSdkVersion={target_sdk}; 0 means Unity/installed module default and must be recorded at build time",
        )
    )

    scenes = re.findall(r"^\s*path:\s*(Assets/_ReCamp/Scenes/[^\s]+\.unity)\s*$", build, re.MULTILINE)
    checks.append(
        check(
            "Build scene flow",
            "PASS" if scenes == EXPECTED_SCENES else "FAIL",
            f"enabled scenes={scenes}",
            blocking=True,
        )
    )

    blockers = [item["name"] for item in checks if item["blocking"] and item["status"] != "PASS"]
    report = {
        "task": "DEV-0117",
        "generatedAtUtc": datetime.now(timezone.utc).isoformat(),
        "status": "PASS" if not blockers else "BLOCKED",
        "projectSettings": str(PROJECT_SETTINGS),
        "buildSettings": str(BUILD_SETTINGS),
        "checks": checks,
        "blockers": blockers,
        "nextAction": (
            "Choose and record the release application identifier, install AndroidPlayer, then build an ARM64 IL2CPP APK."
            if blockers
            else "Build the Android_Dev APK after DEV-0114 toolchain preflight passes."
        ),
    }
    REPORT_PATH.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"DEV-0117 Android release preflight: {report['status']}")
    print(f"Report: {REPORT_PATH}")
    if blockers:
        print("Blockers: " + ", ".join(blockers))
    return 0 if not blockers else 1


if __name__ == "__main__":
    raise SystemExit(main())
