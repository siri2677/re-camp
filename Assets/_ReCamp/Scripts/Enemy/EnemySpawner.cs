using System.Collections;
using ReCamp.GameFlow;
using ReCamp.Item;
using UnityEngine;

namespace ReCamp.Enemy
{
    public sealed class EnemySpawner : MonoBehaviour
    {
        private static readonly Color EnemySalmon = new Color32(196, 79, 68, 255);
        private static readonly Color EnemyStone = new Color32(101, 119, 116, 255);
        private static readonly Color EnemyCharcoal = new Color32(31, 43, 47, 255);
        private static readonly Color EnergyBlue = new Color32(72, 190, 255, 255);

        [SerializeField, Min(1)] private int totalEnemies = 12;
        [SerializeField, Min(0.1f)] private float spawnInterval = 1f;
        [SerializeField, Min(1f)] private float spawnRadius = 7f;

        private BattleSceneController battle;
        private int defeatedEnemies;
        private bool bossSpawned;

        private void Start()
        {
            battle = FindFirstObjectByType<BattleSceneController>();
            StartCoroutine(SpawnWave());
        }

        private IEnumerator SpawnWave()
        {
            for (var index = 0; index < totalEnemies; index++)
            {
                SpawnEnemy(index);
                yield return new WaitForSeconds(spawnInterval);
            }
        }

        private void SpawnEnemy(int index)
        {
            var angle = index * Mathf.PI * 2f / totalEnemies;
            var position = new Vector3(
                Mathf.Cos(angle) * spawnRadius,
                0f,
                Mathf.Sin(angle) * spawnRadius);
            var enemyObject = new GameObject();
            enemyObject.name = $"Enemy_{index + 1:00}";
            enemyObject.transform.position = position;
            CreateScoutRobotVisual(enemyObject.transform, index);
            var enemy = enemyObject.AddComponent<EnemyController>();
            enemy.Configure(15, 1.4f, 4);
            enemyObject.GetComponent<ReCamp.Combat.Damageable>().Died += _ =>
                HandleEnemyDefeated(index, enemyObject.transform.position);
        }

        private void HandleEnemyDefeated(int index, Vector3 position)
        {
            defeatedEnemies++;
            var type = (ResourceType)(index % 3);
            ResourcePickup.Spawn(type, 1, position);
            if (defeatedEnemies >= totalEnemies && !bossSpawned)
            {
                bossSpawned = true;
                StartCoroutine(SpawnBossAfterDelay());
            }
        }

        private IEnumerator SpawnBossAfterDelay()
        {
            yield return new WaitForSeconds(1.5f);

            var bossObject = new GameObject("Boss_GaiaCore");
            bossObject.name = "Boss_GaiaCore";
            bossObject.transform.position = new Vector3(0f, 0f, spawnRadius);
            CreateBossRobotVisual(bossObject.transform);
            var boss = bossObject.AddComponent<EnemyController>();
            boss.Configure(100, 1.2f, 10);
            bossObject.GetComponent<ReCamp.Combat.Damageable>().Died += _ =>
            {
                battle?.CollectResource(ResourceType.DataFragment, 3);
                battle?.ResolveVictory();
            };
        }

        private static void CreateScoutRobotVisual(Transform root, int index)
        {
            var bodyColor = index % 2 == 0 ? EnemySalmon : EnemyStone;
            CreatePart(root, "Body", PrimitiveType.Cube, new Vector3(0f, 0.48f, 0f),
                new Vector3(0.85f, 0.65f, 0.75f), bodyColor);
            CreatePart(root, "Sensor", PrimitiveType.Sphere, new Vector3(0f, 0.6f, 0.42f),
                Vector3.one * 0.24f, EnergyBlue);
            CreatePart(root, "Leg_L", PrimitiveType.Cube, new Vector3(-0.28f, 0.16f, 0f),
                new Vector3(0.22f, 0.32f, 0.3f), EnemyCharcoal);
            CreatePart(root, "Leg_R", PrimitiveType.Cube, new Vector3(0.28f, 0.16f, 0f),
                new Vector3(0.22f, 0.32f, 0.3f), EnemyCharcoal);
            CreatePart(root, "Antenna", PrimitiveType.Cylinder, new Vector3(0f, 0.92f, 0f),
                new Vector3(0.07f, 0.18f, 0.07f), EnergyBlue);
        }

        private static void CreateBossRobotVisual(Transform root)
        {
            CreatePart(root, "Body", PrimitiveType.Cube, new Vector3(0f, 0.85f, 0f),
                new Vector3(1.55f, 1.35f, 1.35f), EnemySalmon);
            CreatePart(root, "Core", PrimitiveType.Sphere, new Vector3(0f, 0.95f, 0.72f),
                Vector3.one * 0.52f, EnergyBlue);
            CreatePart(root, "Foot_L", PrimitiveType.Cube, new Vector3(-0.55f, 0.2f, 0f),
                new Vector3(0.42f, 0.4f, 0.65f), EnemyCharcoal);
            CreatePart(root, "Foot_R", PrimitiveType.Cube, new Vector3(0.55f, 0.2f, 0f),
                new Vector3(0.42f, 0.4f, 0.65f), EnemyCharcoal);
            CreatePart(root, "Crest", PrimitiveType.Cylinder, new Vector3(0f, 1.68f, 0f),
                new Vector3(0.14f, 0.28f, 0.14f), EnemyStone);
        }

        private static void CreatePart(
            Transform parent,
            string partName,
            PrimitiveType primitiveType,
            Vector3 localPosition,
            Vector3 localScale,
            Color color)
        {
            var part = GameObject.CreatePrimitive(primitiveType);
            part.name = partName;
            part.transform.SetParent(parent, false);
            part.transform.localPosition = localPosition;
            part.transform.localScale = localScale;
            part.GetComponent<Renderer>().material.color = color;

            var partCollider = part.GetComponent<Collider>();
            if (partCollider != null)
            {
                Destroy(partCollider);
            }
        }
    }
}
