# DEV-0116 Touch Command Plan

## Goal

Route keyboard and touch input through one battle command component so movement, attack, abilities, and extraction behave identically on Windows and Android without UI calling gameplay components directly.

## Runtime Flow

```text
Keyboard / VirtualJoystick / TouchHoldButton
→ BattleInputRouter command state/events
→ PlayerController, PlayerAttack, CharacterAbilityController, BattleSceneController
→ existing combat, skill, and extraction state
```

- `Move(Vector2)` is a clamped state with dead-zone filtering.
- `AttackPressed` requests one immediate attack while automatic attack remains the default policy.
- Signature and utility press/release events preserve Iris charge input.
- Extraction start/cancel events drive the existing hold timer.
- Scene destruction, application pause, pointer cancel, and safe-area layout changes reset transient input.

## Files to Modify

- `Assets/_ReCamp/Scripts/Input/BattleInputRouter.cs`
- `Assets/_ReCamp/Scripts/Input/VirtualJoystick.cs`
- `Assets/_ReCamp/Scripts/Input/TouchHoldButton.cs`
- `Assets/_ReCamp/Scripts/Player/PlayerController.cs`
- `Assets/_ReCamp/Scripts/Player/PlayerAttack.cs`
- `Assets/_ReCamp/Scripts/Player/CharacterAbilityController.cs`
- `Assets/_ReCamp/Scripts/GameFlow/BattleSceneController.cs`
- `Assets/_ReCamp/Scripts/UI/BattleHudController.cs`
- relevant EditMode/PlayMode tests and mobile status entries

## Edge Cases

- Pointer cancel or scene transition clears movement and hold state.
- A touch skill press must not execute after pause/background resume.
- The virtual joystick never emits a vector outside magnitude `1`.
- Existing keyboard behavior remains available in the Editor.
- Safe-area refresh does not leave a stale pointer active.

## Verification

- EditMode tests cover dead zone, normalization, and command state reset.
- PlayMode tests cover router lifecycle, touch command delivery, extraction hold, and existing battle regression.
- Unity compile and both test suites run after the change.
- Android build/device verification remains blocked until AndroidPlayer and a test device are available.

## Results

- Unity compile: exit code `0`.
- EditMode: `35/35` passed.
- PlayMode: `21/21` passed, including touch HUD creation and extraction command delivery.
- AndroidPlayer installation, APK build, device smoke, Android Back, and background/resume remain unverified.
