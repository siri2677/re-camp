using System.Collections;
using System.Collections.Generic;
using NUnit.Framework;
using ReCamp.Data;
using ReCamp.Enemy;
using ReCamp.Item;
using ReCamp.Player;
using UnityEngine;
using UnityEngine.TestTools;

namespace ReCamp.Tests.PlayMode
{
    public sealed class CharacterAbilityRuntimeTests
    {
        private GameObject playerObject;
        private readonly List<GameObject> spawnedObjects = new();

        [UnityTearDown]
        public IEnumerator TearDown()
        {
            if (playerObject != null)
            {
                Object.Destroy(playerObject);
                playerObject = null;
            }

            foreach (var spawnedObject in spawnedObjects)
            {
                if (spawnedObject != null)
                {
                    Object.Destroy(spawnedObject);
                }
            }

            spawnedObjects.Clear();
            yield return null;
        }

        [UnityTest]
        public IEnumerator PlayerStats_AppliesCharacterAndEnsuresAbilityController()
        {
            var stats = CreatePlayer(CharacterId.Iris);
            yield return null;

            Assert.That(stats.Character.Id, Is.EqualTo(CharacterId.Iris));
            Assert.That(stats.AttackRange, Is.EqualTo(CharacterRoster.Get(CharacterId.Iris).AttackRange));
            Assert.That(stats.Ability, Is.Not.Null);
            Assert.That(stats.Ability.AbilityName, Is.EqualTo("포커스 샷"));
        }

        [UnityTest]
        public IEnumerator LunaAbility_DashesAndStartsCooldown()
        {
            var stats = CreatePlayer(CharacterId.Luna);
            var origin = stats.transform.position;
            yield return null;

            Assert.That(stats.Ability.TryActivate(), Is.True);

            Assert.That(stats.transform.position.z, Is.GreaterThan(origin.z + 4f));
            Assert.That(stats.Ability.CooldownRemaining, Is.GreaterThan(0f));
            Assert.That(stats.Ability.TryActivate(), Is.False);
        }

        [UnityTest]
        public IEnumerator LunaUtility_RevealsNearbyResourcesAndExpandsPickupRange()
        {
            var stats = CreatePlayer(CharacterId.Luna);
            var nearbyPickup = CreatePickup(new Vector3(4f, 0f, 0f));
            var distantPickup = CreatePickup(new Vector3(12f, 0f, 0f));
            yield return null;

            Assert.That(stats.Ability.TryActivateUtility(), Is.True);

            Assert.That(stats.Ability.IsScanning, Is.True);
            Assert.That(stats.Ability.LastScanCount, Is.EqualTo(1));
            Assert.That(stats.Ability.ResourcePickupRange, Is.GreaterThan(6f));
            Assert.That(nearbyPickup.IsRevealed, Is.True);
            Assert.That(distantPickup.IsRevealed, Is.False);
        }

        [UnityTest]
        public IEnumerator LunaBasicAttack_UsesThreeHitComboFinisher()
        {
            var stats = CreatePlayer(CharacterId.Luna);
            var attack = playerObject.AddComponent<PlayerAttack>();
            var enemy = CreateEnemy(new Vector3(0f, 0f, 2f), 100);

            yield return new WaitForSeconds(0.9f);

            Assert.That(attack.ComboStep, Is.EqualTo(3));
            Assert.That(enemy.Health.CurrentHealth, Is.LessThanOrEqualTo(71));
        }

        [UnityTest]
        public IEnumerator MiyuRole_KeepsDroneOnlineAndOverclockedWithWideAutoPickup()
        {
            var stats = CreatePlayer(CharacterId.Miyu);
            yield return null;

            Assert.That(stats.Ability.IsDroneOnline, Is.True);
            Assert.That(stats.Ability.ResourcePickupRange, Is.GreaterThan(5f));
            Assert.That(stats.Ability.TryActivateUtility(), Is.True);
            Assert.That(stats.Ability.IsDroneOverclocked, Is.True);
        }

        [UnityTest]
        public IEnumerator CocoAndNoahAbilities_HealAndGuard()
        {
            var stats = CreatePlayer(CharacterId.Coco);
            stats.Health.TakeDamage(50);
            var damagedHealth = stats.Health.CurrentHealth;
            yield return null;

            Assert.That(stats.Ability.TryActivate(), Is.True);
            Assert.That(stats.Health.CurrentHealth, Is.GreaterThan(damagedHealth));

            Assert.That(stats.Ability.TryActivateUtility(), Is.True);
            Assert.That(stats.Health.ShieldPoints, Is.GreaterThan(0));
            var shieldBeforeHit = stats.Health.ShieldPoints;
            stats.Health.TakeDamage(5);
            Assert.That(stats.Health.CurrentHealth, Is.GreaterThan(damagedHealth));
            Assert.That(stats.Health.ShieldPoints, Is.LessThan(shieldBeforeHit));

            stats.ApplyCharacter(CharacterRoster.Get(CharacterId.Noah));
            Assert.That(stats.Ability.TryActivate(), Is.True);
            Assert.That(stats.Ability.IsGuarding, Is.True);
            Assert.That(stats.Health.DamageTakenMultiplier, Is.LessThan(1f));
        }

        [UnityTest]
        public IEnumerator IrisRole_MarksTargetAndReleasesChargedFocusShot()
        {
            var stats = CreatePlayer(CharacterId.Iris);
            var enemy = CreateEnemy(new Vector3(0f, 0f, 6f), 150);
            yield return null;

            Assert.That(stats.Ability.TryActivateUtility(), Is.True);
            Assert.That(enemy.IsMarked, Is.True);
            Assert.That(stats.Ability.BeginCharge(), Is.True);
            yield return new WaitForSeconds(0.1f);

            var healthBeforeShot = enemy.Health.CurrentHealth;
            Assert.That(stats.Ability.ChargeRatio, Is.GreaterThan(0f));
            Assert.That(stats.Ability.ReleaseCharge(), Is.True);
            Assert.That(enemy.Health.CurrentHealth, Is.LessThan(healthBeforeShot));
            Assert.That(stats.Ability.CooldownRemaining, Is.GreaterThan(0f));
        }

        [UnityTest]
        public IEnumerator NoahRole_DeploysBarrierAndKnocksEnemiesAway()
        {
            var stats = CreatePlayer(CharacterId.Noah);
            var enemy = CreateEnemy(new Vector3(0f, 0f, 3f), 100);
            var originalEnemyPosition = enemy.transform.position;
            yield return null;

            Assert.That(stats.Ability.TryActivateUtility(), Is.True);

            Assert.That(stats.Ability.IsBarrierActive, Is.True);
            Assert.That(stats.Ability.BarrierRemaining, Is.GreaterThan(0f));
            Assert.That(enemy.transform.position.z, Is.GreaterThan(originalEnemyPosition.z + 2f));
        }

        private PlayerStats CreatePlayer(CharacterId id)
        {
            playerObject = new GameObject($"{id} Ability Test Player");
            var stats = playerObject.AddComponent<PlayerStats>();
            stats.ApplyCharacter(CharacterRoster.Get(id));
            return stats;
        }

        private ResourcePickup CreatePickup(Vector3 position)
        {
            var pickupObject = new GameObject("Ability Test Pickup");
            pickupObject.transform.position = position;
            spawnedObjects.Add(pickupObject);
            return pickupObject.AddComponent<ResourcePickup>();
        }

        private EnemyController CreateEnemy(Vector3 position, int health)
        {
            var enemyObject = new GameObject("Ability Test Enemy");
            enemyObject.transform.position = position;
            spawnedObjects.Add(enemyObject);
            var enemy = enemyObject.AddComponent<EnemyController>();
            enemy.Configure(health, 0.1f, 1);
            return enemy;
        }
    }
}
