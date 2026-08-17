#!/usr/bin/env python3
"""Read-only Android toolchain preflight for Re:Camp DEV-0114.

The check deliberately does not install or modify Unity/Android tooling. It
records the local state needed to resume Android build work once the Unity Hub
modules and/or environment paths are available.
"""

from __future__ import annotations

import json
import os
import platform
from datetime import datetime, timezone
from pathlib import Path


REPO_ROOT = Path(__file__).resolve().parents[1]
EXPECTED_UNITY_VERSION = "6000.5.3f1"
REPORT_PATH = REPO_ROOT / "planning" / "DEV-0114_ANDROID_TOOLCHAIN_PREFLIGHT.json"


def existing_path(value: str | None) -> Path | None:
    if not value:
        return None
    candidate = Path(value).expanduser()
    return candidate if candidate.exists() else None


def first_existing(candidates: list[Path]) -> Path | None:
    for candidate in candidates:
        if candidate.exists():
            return candidate
    return None


def locate_unity_editor() -> Path | None:
    configured = existing_path(os.environ.get("UNITY_EDITOR"))
    if configured and configured.is_file():
        return configured

    candidates = [
        Path(rf"C:\Program Files\Unity\Hub\Editor\{EXPECTED_UNITY_VERSION}\Editor\Unity.exe"),
        Path(rf"C:\Program Files (x86)\Unity\Hub\Editor\{EXPECTED_UNITY_VERSION}\Editor\Unity.exe"),
    ]
    for root in (Path(r"C:\Program Files\Unity\Hub\Editor"), Path(r"C:\Program Files (x86)\Unity\Hub\Editor")):
        if root.exists():
            candidates.extend(root.glob("*/Editor/Unity.exe"))
    return first_existing(candidates)


def path_check(name: str, candidates: list[Path], required: bool = True) -> dict[str, object]:
    found = first_existing(candidates)
    return {
        "name": name,
        "required": required,
        "status": "PASS" if found else "MISSING",
        "path": str(found) if found else None,
        "candidates": [str(candidate) for candidate in candidates],
    }


def main() -> int:
    editor = locate_unity_editor()
    editor_root = editor.parent if editor else None
    editor_data = editor_root / "Data" if editor_root else None
    playback_engines = editor_data / "PlaybackEngines" if editor_data else None
    android_player = playback_engines / "AndroidPlayer" if playback_engines else None

    default_sdk = Path.home() / "AppData" / "Local" / "Android" / "Sdk"
    sdk_env = [
        existing_path(os.environ.get("ANDROID_SDK_ROOT")),
        existing_path(os.environ.get("ANDROID_HOME")),
        default_sdk if default_sdk.exists() else None,
    ]
    ndk_env = [existing_path(os.environ.get("ANDROID_NDK_ROOT")), existing_path(os.environ.get("ANDROID_NDK_HOME"))]
    java_env = [existing_path(os.environ.get("JAVA_HOME"))]

    sdk_candidates = [candidate for candidate in sdk_env if candidate]
    ndk_candidates = [candidate for candidate in ndk_env if candidate]
    java_candidates = [candidate for candidate in java_env if candidate]
    if android_player:
        sdk_candidates.append(android_player / "SDK")
        ndk_candidates.append(android_player / "NDK")
        java_candidates.append(android_player / "OpenJDK")
    for sdk in sdk_candidates:
        ndk_candidates.extend([sdk / "ndk", sdk / "ndk-bundle"])

    checks = [
        path_check("Unity Editor", [editor] if editor else []),
        {
            "name": "Unity version",
            "required": True,
            "status": "PASS" if editor and EXPECTED_UNITY_VERSION in str(editor) else "MISSING",
            "expected": EXPECTED_UNITY_VERSION,
            "path": str(editor) if editor else None,
        },
        path_check("AndroidPlayer module", [android_player] if android_player else []),
        path_check("Android SDK", sdk_candidates),
        path_check("Android NDK", ndk_candidates),
        path_check("OpenJDK", java_candidates),
    ]
    missing = [check["name"] for check in checks if check["required"] and check["status"] != "PASS"]
    report = {
        "task": "DEV-0114",
        "generatedAtUtc": datetime.now(timezone.utc).isoformat(),
        "host": {"platform": platform.platform(), "python": platform.python_version()},
        "expectedUnityVersion": EXPECTED_UNITY_VERSION,
        "status": "PASS" if not missing else "BLOCKED",
        "checks": checks,
        "missing": missing,
        "installationAttempted": False,
        "resumeAction": (
            "Install Unity Android Build Support for "
            f"{EXPECTED_UNITY_VERSION} (Embedded SDK & NDK Tools/OpenJDK), then rerun this script."
            if missing
            else "Run an Android development build preflight and device smoke test."
        ),
    }
    REPORT_PATH.parent.mkdir(parents=True, exist_ok=True)
    REPORT_PATH.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(f"DEV-0114 Android toolchain preflight: {report['status']}")
    print(f"Report: {REPORT_PATH}")
    if missing:
        print("Missing: " + ", ".join(missing))
    return 0 if not missing else 1


if __name__ == "__main__":
    raise SystemExit(main())
