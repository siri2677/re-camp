using System.Collections;
using System.Collections.Generic;
using NUnit.Framework;
using ReCamp.Enemy;
using UnityEngine;
using UnityEngine.TestTools;

namespace ReCamp.Tests.PlayMode
{
    public sealed class EnemyLifecycleRuntimeTests
    {
        private readonly List<GameObject> createdEnemies = new();

        [UnitySetUp]
        public IEnumerator SetUp()
        {
            foreach (var enemy in Object.FindObjectsByType<EnemyController>(
                         FindObjectsInactive.Include,
                         FindObjectsSortMode.None))
            {
                Object.Destroy(enemy.gameObject);
            }

            yield return null;

            Assert.That(EnemyController.ActiveCount, Is.Zero, "Enemy registry must start each test empty.");
        }

        [UnityTearDown]
        public IEnumerator TearDown()
        {
            foreach (var enemyObject in createdEnemies)
            {
                if (enemyObject != null)
                {
                    Object.Destroy(enemyObject);
                }
            }

            createdEnemies.Clear();
            yield return null;
        }

        [UnityTest]
        public IEnumerator FindClosestAlive_SkipsKilledEnemyUntilItsObjectIsDestroyed()
        {
            var fartherEnemy = CreateEnemy("Farther Enemy", new Vector3(5f, 0f, 0f));
            var nearerEnemy = CreateEnemy("Nearer Enemy", new Vector3(2f, 30f, 0f));

            Assert.That(EnemyController.ActiveCount, Is.EqualTo(2));
            Assert.That(
                EnemyController.FindClosestAlive(Vector3.zero, 6f),
                Is.SameAs(nearerEnemy),
                "Targeting should use the nearest horizontal distance.");

            nearerEnemy.TakeDamage(1000);

            Assert.That(nearerEnemy.IsDead, Is.True);
            Assert.That(
                EnemyController.FindClosestAlive(Vector3.zero, 6f),
                Is.SameAs(fartherEnemy),
                "A dead enemy remains registered until destruction, but must stop being targetable immediately.");

            yield return null;

            Assert.That(nearerEnemy == null, Is.True);
            Assert.That(EnemyController.ActiveCount, Is.EqualTo(1));
        }

        [UnityTest]
        public IEnumerator DestroyingEnemy_UnregistersItFromRuntimeQueries()
        {
            var enemy = CreateEnemy("Disposable Enemy", new Vector3(1f, 0f, 0f));

            Assert.That(EnemyController.ActiveCount, Is.EqualTo(1));
            Assert.That(EnemyController.FindClosestAlive(Vector3.zero, 2f), Is.SameAs(enemy));

            Object.Destroy(enemy.gameObject);
            yield return null;

            Assert.That(EnemyController.ActiveCount, Is.Zero);
            Assert.That(EnemyController.FindClosestAlive(Vector3.zero, 2f), Is.Null);
        }

        private EnemyController CreateEnemy(string name, Vector3 position)
        {
            var enemyObject = new GameObject(name);
            enemyObject.transform.position = position;
            createdEnemies.Add(enemyObject);
            return enemyObject.AddComponent<EnemyController>();
        }
    }
}
