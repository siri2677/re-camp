using NUnit.Framework;
using ReCamp.Combat;
using UnityEngine;

namespace ReCamp.Tests.EditMode
{
    public sealed class DamageableTests
    {
        private GameObject target;

        [TearDown]
        public void TearDown()
        {
            if (target != null)
            {
                Object.DestroyImmediate(target);
            }
        }

        [Test]
        public void Configure_ClampsMaximumHealthToOneAndRefillsCurrentHealth()
        {
            var damageable = CreateDamageable();

            damageable.Configure(0);

            Assert.That(damageable.MaxHealth, Is.EqualTo(1));
            Assert.That(damageable.CurrentHealth, Is.EqualTo(1));
            Assert.That(damageable.IsDead, Is.False);
        }

        [Test]
        public void TakeDamage_WhenHealthReachesZero_RaisesDeathOnce()
        {
            var damageable = CreateDamageable();
            damageable.Configure(5);
            var deathCount = 0;
            damageable.Died += _ => deathCount++;

            damageable.TakeDamage(3);
            damageable.TakeDamage(2);
            damageable.TakeDamage(1);

            Assert.That(damageable.CurrentHealth, Is.Zero);
            Assert.That(damageable.IsDead, Is.True);
            Assert.That(deathCount, Is.EqualTo(1));
        }

        [Test]
        public void TakeDamage_WhenAmountIsNotPositive_IsIgnored()
        {
            var damageable = CreateDamageable();
            damageable.Configure(5);

            damageable.TakeDamage(0);
            damageable.TakeDamage(-3);

            Assert.That(damageable.CurrentHealth, Is.EqualTo(5));
            Assert.That(damageable.IsDead, Is.False);
        }

        [Test]
        public void Heal_ClampsToMaximumAndReportsAppliedAmount()
        {
            var damageable = CreateDamageable();
            damageable.Configure(10);
            damageable.TakeDamage(7);

            var applied = damageable.Heal(20);

            Assert.That(applied, Is.EqualTo(7));
            Assert.That(damageable.CurrentHealth, Is.EqualTo(10));
        }

        [Test]
        public void DamageMultiplier_ReducesDamageAndCanBeReset()
        {
            var damageable = CreateDamageable();
            damageable.Configure(20);
            damageable.SetDamageTakenMultiplier(0.5f);

            damageable.TakeDamage(8);
            Assert.That(damageable.CurrentHealth, Is.EqualTo(16));

            damageable.ResetDamageTakenMultiplier();
            damageable.TakeDamage(3);
            Assert.That(damageable.CurrentHealth, Is.EqualTo(13));
        }

        [Test]
        public void Shield_AbsorbsScaledDamageBeforeHealthAndReportsRemainingPoints()
        {
            var damageable = CreateDamageable();
            damageable.Configure(20);
            damageable.SetDamageTakenMultiplier(0.5f);
            damageable.SetShield(3);
            var reportedShield = -1;
            damageable.ShieldChanged += (_, remaining) => reportedShield = remaining;

            damageable.TakeDamage(8);

            Assert.That(damageable.ShieldPoints, Is.Zero);
            Assert.That(reportedShield, Is.Zero);
            Assert.That(damageable.CurrentHealth, Is.EqualTo(19));
        }

        [Test]
        public void Configure_ClearsAnExistingShield()
        {
            var damageable = CreateDamageable();
            damageable.SetShield(12);

            damageable.Configure(25);

            Assert.That(damageable.ShieldPoints, Is.Zero);
        }

        private Damageable CreateDamageable()
        {
            target = new GameObject("Damageable Test Target");
            return target.AddComponent<Damageable>();
        }
    }
}
