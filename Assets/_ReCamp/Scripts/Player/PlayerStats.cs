using ReCamp.Camp;
using ReCamp.Combat;
using ReCamp.Core;
using ReCamp.Data;
using UnityEngine;

namespace ReCamp.Player
{
    [RequireComponent(typeof(Damageable))]
    public sealed class PlayerStats : MonoBehaviour
    {
        private static readonly int BaseColorId = Shader.PropertyToID("_BaseColor");
        private static readonly int ColorId = Shader.PropertyToID("_Color");

        [SerializeField, Min(1)] private int maxHealth = 100;
        [SerializeField, Min(0.1f)] private float moveSpeed = 5f;
        [SerializeField, Min(1)] private int attackDamage = 5;
        [SerializeField, Min(0.1f)] private float attackRange = 3f;
        [SerializeField, Min(0.05f)] private float attackInterval = 0.6f;

        public Damageable Health { get; private set; }
        public CharacterAbilityController Ability { get; private set; }
        public CharacterDefinition Character { get; private set; }
        public float MoveSpeed => moveSpeed;
        public int AttackDamage => attackDamage + (CampManager.Instance?.AttackBonus ?? 0);
        public float AttackRange => attackRange;
        public float AttackInterval => attackInterval;

        private void Awake()
        {
            Health = GetComponent<Damageable>();
            var selectedCharacter = GameManager.Instance == null
                ? CharacterRoster.Default
                : GameManager.Instance.SelectedCharacter;
            ApplyCharacter(selectedCharacter);
        }

        public void ApplyCharacter(CharacterDefinition definition)
        {
            Character = definition ?? CharacterRoster.Default;
            maxHealth = Character.MaxHealth;
            moveSpeed = Character.MoveSpeed;
            attackDamage = Character.AttackDamage;
            attackRange = Character.AttackRange;
            attackInterval = Character.AttackInterval;

            if (Health == null)
            {
                Health = GetComponent<Damageable>();
            }

            Health.Configure(maxHealth + (CampManager.Instance?.MaxHealthBonus ?? 0));

            Ability = GetComponent<CharacterAbilityController>();
            if (Ability == null)
            {
                Ability = gameObject.AddComponent<CharacterAbilityController>();
            }

            Ability.Configure(this, Character);
            ApplyRuntimePalette();
        }

        private void ApplyRuntimePalette()
        {
            var renderers = GetComponentsInChildren<Renderer>(true);
            var propertyBlock = new MaterialPropertyBlock();
            foreach (var targetRenderer in renderers)
            {
                if (targetRenderer == null)
                {
                    continue;
                }

                var rendererName = targetRenderer.name.ToLowerInvariant();
                var useAccent = rendererName.Contains("accent") || rendererName.Contains("weapon") ||
                    rendererName.Contains("visor") || rendererName.Contains("blade") ||
                    rendererName.Contains("drone") || rendererName.Contains("shield");
                var color = useAccent
                    ? (Color)Character.AccentColor
                    : (Color)Character.PrimaryColor;

                targetRenderer.GetPropertyBlock(propertyBlock);
                propertyBlock.SetColor(BaseColorId, color);
                propertyBlock.SetColor(ColorId, color);
                targetRenderer.SetPropertyBlock(propertyBlock);
                propertyBlock.Clear();
            }
        }
    }
}
