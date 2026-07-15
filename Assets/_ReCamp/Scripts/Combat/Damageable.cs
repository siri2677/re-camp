using System;
using UnityEngine;

namespace ReCamp.Combat
{
    /// <summary>Owns mutable health and exposes a single death signal for combat actors.</summary>
    public sealed class Damageable : MonoBehaviour
    {
        [SerializeField, Min(1)] private int maxHealth = 10;

        public event Action<Damageable> Died;
        public event Action<Damageable, int> Damaged;
        public event Action<Damageable, int> Healed;
        public event Action<Damageable, int> ShieldChanged;

        public int CurrentHealth { get; private set; }
        public int MaxHealth => maxHealth;
        public int ShieldPoints { get; private set; }
        public bool IsDead => CurrentHealth <= 0;
        public float DamageTakenMultiplier { get; private set; } = 1f;

        private void Awake()
        {
            CurrentHealth = maxHealth;
        }

        public void Configure(int health)
        {
            maxHealth = Mathf.Max(1, health);
            CurrentHealth = maxHealth;
            ShieldPoints = 0;
            DamageTakenMultiplier = 1f;
        }

        public void TakeDamage(int amount)
        {
            if (IsDead || amount <= 0)
            {
                return;
            }

            var scaledDamage = DamageTakenMultiplier <= 0f
                ? 0
                : Mathf.CeilToInt(amount * DamageTakenMultiplier);
            if (scaledDamage <= 0)
            {
                return;
            }

            if (ShieldPoints > 0)
            {
                var absorbedDamage = Mathf.Min(ShieldPoints, scaledDamage);
                ShieldPoints -= absorbedDamage;
                scaledDamage -= absorbedDamage;
                ShieldChanged?.Invoke(this, ShieldPoints);
            }

            if (scaledDamage <= 0)
            {
                return;
            }

            var previousHealth = CurrentHealth;
            CurrentHealth = Mathf.Max(0, CurrentHealth - scaledDamage);
            var appliedDamage = previousHealth - CurrentHealth;
            Damaged?.Invoke(this, appliedDamage);
            if (CurrentHealth == 0)
            {
                Died?.Invoke(this);
            }
        }

        public int Heal(int amount)
        {
            if (IsDead || amount <= 0 || CurrentHealth >= maxHealth)
            {
                return 0;
            }

            var previousHealth = CurrentHealth;
            CurrentHealth = Mathf.Min(maxHealth, CurrentHealth + amount);
            var appliedHealing = CurrentHealth - previousHealth;
            Healed?.Invoke(this, appliedHealing);
            return appliedHealing;
        }

        public int SetShield(int amount)
        {
            var nextShield = Mathf.Max(0, amount);
            if (nextShield == ShieldPoints)
            {
                return ShieldPoints;
            }

            ShieldPoints = nextShield;
            ShieldChanged?.Invoke(this, ShieldPoints);
            return ShieldPoints;
        }

        public void ClearShield()
        {
            SetShield(0);
        }

        public void SetDamageTakenMultiplier(float multiplier)
        {
            DamageTakenMultiplier = float.IsNaN(multiplier) || float.IsInfinity(multiplier)
                ? 1f
                : Mathf.Clamp(multiplier, 0f, 10f);
        }

        public void ResetDamageTakenMultiplier()
        {
            DamageTakenMultiplier = 1f;
        }
    }
}
