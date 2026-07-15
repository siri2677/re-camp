using ReCamp.Data;
using ReCamp.Enemy;
using UnityEngine;

namespace ReCamp.Player
{
    [RequireComponent(typeof(PlayerStats))]
    public sealed class PlayerAttack : MonoBehaviour
    {
        private const float LunaSecondHitMultiplier = 1.2f;
        private const float LunaFinisherMultiplier = 1.75f;

        private PlayerStats stats;
        private float nextAttackTime;
        private EnemyController comboTarget;
        private int comboStep;
        private float comboExpiresAt;

        public int ComboStep => stats != null && stats.Character?.Id == CharacterId.Luna
            ? comboStep
            : 0;
        public float ComboRemaining => ComboStep > 0
            ? Mathf.Max(0f, comboExpiresAt - Time.time)
            : 0f;

        private void Awake()
        {
            stats = GetComponent<PlayerStats>();
        }

        private void Update()
        {
            if (stats.Health.IsDead || Time.time < nextAttackTime)
            {
                return;
            }

            var target = EnemyController.FindClosestAlive(transform.position, stats.AttackRange);
            if (target == null)
            {
                if (comboExpiresAt > 0f && Time.time >= comboExpiresAt)
                {
                    ResetCombo();
                }

                return;
            }

            target.TakeDamage(ResolveAttackDamage(target));
            nextAttackTime = Time.time + stats.AttackInterval;
        }

        private int ResolveAttackDamage(EnemyController target)
        {
            if (stats.Character?.Id != CharacterId.Luna)
            {
                ResetCombo();
                return stats.AttackDamage;
            }

            if (comboTarget != target || Time.time >= comboExpiresAt)
            {
                comboStep = 0;
            }

            comboTarget = target;
            comboStep = comboStep % 3 + 1;
            comboExpiresAt = Time.time + Mathf.Max(0.9f, stats.AttackInterval * 2.4f);

            var multiplier = comboStep switch
            {
                2 => LunaSecondHitMultiplier,
                3 => LunaFinisherMultiplier,
                _ => 1f,
            };
            return Mathf.CeilToInt(stats.AttackDamage * multiplier);
        }

        private void ResetCombo()
        {
            comboTarget = null;
            comboStep = 0;
            comboExpiresAt = 0f;
        }
    }
}
