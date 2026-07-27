using UnityEngine;

namespace ReCamp.Data
{
    /// <summary>Immutable gray-box combat and presentation data for one playable character.</summary>
    public sealed class CharacterDefinition
    {
        public CharacterDefinition(
            CharacterId id,
            string displayName,
            string role,
            string summary,
            Color32 primaryColor,
            Color32 secondaryColor,
            Color32 accentColor,
            int maxHealth,
            float moveSpeed,
            int attackDamage,
            float attackRange,
            float attackInterval,
            string signatureAbilityName,
            string signatureAbilityDescription,
            float abilityCooldown)
        {
            Id = id;
            DisplayName = displayName;
            Role = role;
            Summary = summary;
            PrimaryColor = primaryColor;
            SecondaryColor = secondaryColor;
            AccentColor = accentColor;
            MaxHealth = Mathf.Max(1, maxHealth);
            MoveSpeed = Mathf.Max(0.1f, moveSpeed);
            AttackDamage = Mathf.Max(1, attackDamage);
            AttackRange = Mathf.Max(0.1f, attackRange);
            AttackInterval = Mathf.Max(0.05f, attackInterval);
            SignatureAbilityName = signatureAbilityName;
            SignatureAbilityDescription = signatureAbilityDescription;
            AbilityCooldown = Mathf.Max(0.1f, abilityCooldown);
        }

        public CharacterId Id { get; }
        public string DisplayName { get; }
        public string Role { get; }
        public string Summary { get; }
        public Color32 PrimaryColor { get; }
        public Color32 SecondaryColor { get; }
        public Color32 AccentColor { get; }
        public int MaxHealth { get; }
        public float MoveSpeed { get; }
        public int AttackDamage { get; }
        public float AttackRange { get; }
        public float AttackInterval { get; }
        public string SignatureAbilityName { get; }
        public string SignatureAbilityDescription { get; }
        public float AbilityCooldown { get; }
    }
}
