using System;

namespace ReCamp.Domain
{
    public enum AbilitySlot
    {
        Signature,
        Utility,
    }

    /// <summary>Portable intent emitted by keyboard, touch, or another input source.</summary>
    public sealed class UseAbilityCommand
    {
        public UseAbilityCommand(int characterId, AbilitySlot slot, string abilityKey, float cooldownSeconds)
        {
            if (characterId < 0) throw new ArgumentOutOfRangeException(nameof(characterId));
            if (string.IsNullOrWhiteSpace(abilityKey)) throw new ArgumentException("An ability key is required.", nameof(abilityKey));
            if (cooldownSeconds < 0f) throw new ArgumentOutOfRangeException(nameof(cooldownSeconds));

            CharacterId = characterId;
            Slot = slot;
            AbilityKey = abilityKey;
            CooldownSeconds = cooldownSeconds;
        }

        public int CharacterId { get; private set; }
        public AbilitySlot Slot { get; private set; }
        public string AbilityKey { get; private set; }
        public float CooldownSeconds { get; private set; }
    }

    /// <summary>Portable outcome emitted after Runtime attempts an ability command.</summary>
    public sealed class AbilityResolvedEvent
    {
        public AbilityResolvedEvent(UseAbilityCommand command, bool succeeded)
        {
            Command = command ?? throw new ArgumentNullException(nameof(command));
            Succeeded = succeeded;
        }

        public UseAbilityCommand Command { get; private set; }
        public bool Succeeded { get; private set; }
    }
}
