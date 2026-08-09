# DEV-0113 Core Integration Plan

## Goal

Finish the remaining portable-domain boundary for exploration outcomes, reward settlement, and character skill commands/events without duplicating gameplay rules in `ReCamp.Runtime`.

## Existing Architecture

`ReCamp.Domain` owns Unity-independent rules and save DTOs. `ReCamp.UnityAdapter` converts Unity save data and presentation-facing values. `ReCamp.Runtime` owns MonoBehaviours, Scene flow, Input System, HUD, and presentation.

## Files to Modify

- `Assets/_ReCamp/Scripts/Domain/Domain.cs`
- `Assets/_ReCamp/Scripts/UnityAdapter/DomainCampSaveAdapter.cs` only if the new contract needs conversion
- `Assets/_ReCamp/Scripts/Core/GameManager.cs`
- `Assets/_ReCamp/Scripts/GameFlow/BattleSceneController.cs`
- `Assets/_ReCamp/Scripts/Player/CharacterAbilityController.cs` only where a Domain command/event boundary is consumed
- `planning/DEV-0113_CORE_INTEGRATION_RESULT.md`
- `planning/IMPLEMENTATION_STATUS.md`
- `planning/sprint_backlog.md`

## New Tests

- Domain outcome settlement tests
- Domain skill command/event tests
- Runtime integration tests for extracted, defeated, and expired outcomes
- Existing save, reward, and ability tests must remain compatible

## Runtime Flow

1. Runtime submits an exploration outcome and collected rewards to a Domain-owned settlement contract.
2. Domain returns an immutable result describing outcome, deposited rewards, and state transition.
3. Runtime applies the result to Camp persistence and Scene presentation.
4. Character ability presentation submits a Domain command and reacts to the resulting event without owning authoritative skill values.

## Edge Cases

- Settlement must be idempotent for one run.
- Defeat and expiry must not deposit rewards unless the existing product rule explicitly says so.
- Negative rewards and invalid commands must be rejected without mutating state.
- A missing Runtime singleton must not make Domain tests require Unity.
- Existing save migration behavior must remain unchanged.

## Verification

- Run the available Unity EditMode and PlayMode tests after a Unity Editor connection is available.
- Validate scripts and inspect the Unity console for compilation errors.
- Re-run the existing local domain-only checks if available.
- Do not mark `Done` until Fresh Clone and CI evidence are recorded.

## Completion Criteria

- Exploration settlement and skill command/event contracts are owned by Domain.
- Runtime no longer contains a second authoritative implementation of those rules.
- Existing behavior remains preserved by automated tests.
- Fresh Clone, Unity compile, EditMode, PlayMode, and CI evidence are recorded.
