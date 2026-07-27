using System.Collections.Generic;
using ReCamp.Combat;
using ReCamp.GameFlow;
using ReCamp.Player;
using UnityEngine;

namespace ReCamp.Enemy
{
    [RequireComponent(typeof(Damageable))]
    public sealed class EnemyController : MonoBehaviour
    {
        private static readonly List<EnemyController> ActiveEnemies = new();

        [SerializeField, Min(1)] private int maxHealth = 20;
        [SerializeField, Min(0.1f)] private float moveSpeed = 2f;
        [SerializeField, Min(1)] private int contactDamage = 5;
        [SerializeField, Min(0.1f)] private float contactRange = 1f;
        [SerializeField, Min(0.1f)] private float contactInterval = 1f;
        [SerializeField, Min(0f)] private float rotationSpeed = 540f;

        private Damageable health;
        private float nextContactTime;
        private float markedUntil;
        private float markedDamageMultiplier = 1f;
        private GameObject markVisual;

        public bool IsDead => health == null || health.IsDead;
        public bool IsBoss => name.StartsWith("Boss_");
        public bool IsMarked => markedUntil > Time.time;
        public float MarkRemaining => IsMarked ? Mathf.Max(0f, markedUntil - Time.time) : 0f;
        public Damageable Health => health;
        public static int ActiveCount => ActiveEnemies.Count;

        private void Awake()
        {
            health = GetComponent<Damageable>();
            health.Configure(maxHealth);
            health.Died += HandleDeath;
            ActiveEnemies.Add(this);
        }

        private void OnDestroy()
        {
            if (health != null)
            {
                health.Died -= HandleDeath;
            }

            ActiveEnemies.Remove(this);
        }

        private void Update()
        {
            UpdateMarkVisual();

            var player = PlayerController.Instance;
            if (IsDead || player == null)
            {
                return;
            }

            var offset = player.transform.position - transform.position;
            offset.y = 0f;
            var distance = offset.magnitude;
            if (distance > contactRange)
            {
                var direction = offset.normalized;
                var nextPosition = transform.position + direction * moveSpeed * Time.deltaTime;
                transform.position = EnergyBarrier.ClampEnemyMovement(transform.position, nextPosition, 0.35f);
                if (rotationSpeed > 0f)
                {
                    var targetRotation = Quaternion.LookRotation(direction, Vector3.up);
                    transform.rotation = Quaternion.RotateTowards(
                        transform.rotation,
                        targetRotation,
                        rotationSpeed * Time.deltaTime);
                }

                return;
            }

            if (Time.time >= nextContactTime)
            {
                player.GetComponent<PlayerStats>().Health.TakeDamage(contactDamage);
                nextContactTime = Time.time + contactInterval;
            }
        }

        public void Configure(int healthValue, float speed, int damage)
        {
            maxHealth = Mathf.Max(1, healthValue);
            moveSpeed = Mathf.Max(0.1f, speed);
            contactDamage = Mathf.Max(1, damage);
            health.Configure(maxHealth);
        }

        public void TakeDamage(int amount)
        {
            if (IsMarked)
            {
                amount = Mathf.CeilToInt(amount * markedDamageMultiplier);
            }

            health.TakeDamage(amount);
        }

        public void Mark(float duration, float damageMultiplier)
        {
            markedUntil = Mathf.Max(markedUntil, Time.time + Mathf.Max(0.1f, duration));
            markedDamageMultiplier = Mathf.Max(1f, damageMultiplier);
            EnsureMarkVisual();
            markVisual.SetActive(true);
        }

        public void ClearMark()
        {
            markedUntil = 0f;
            markedDamageMultiplier = 1f;
            if (markVisual != null)
            {
                markVisual.SetActive(false);
            }
        }

        public static EnemyController FindClosestAlive(Vector3 origin, float range)
        {
            EnemyController closest = null;
            var closestDistanceSquared = range * range;
            foreach (var enemy in ActiveEnemies)
            {
                if (enemy == null || enemy.IsDead)
                {
                    continue;
                }

                var delta = enemy.transform.position - origin;
                delta.y = 0f;
                var distanceSquared = delta.sqrMagnitude;
                if (distanceSquared <= closestDistanceSquared)
                {
                    closest = enemy;
                    closestDistanceSquared = distanceSquared;
                }
            }

            return closest;
        }

        public static int KnockbackInCone(
            Vector3 origin,
            Vector3 forward,
            float range,
            float halfAngle,
            float distance)
        {
            forward = Vector3.ProjectOnPlane(forward, Vector3.up).normalized;
            if (forward.sqrMagnitude < 0.0001f)
            {
                forward = Vector3.forward;
            }

            var affected = 0;
            var rangeSquared = Mathf.Max(0f, range) * Mathf.Max(0f, range);
            var minimumDot = Mathf.Cos(Mathf.Clamp(halfAngle, 0f, 180f) * Mathf.Deg2Rad);
            foreach (var enemy in ActiveEnemies)
            {
                if (enemy == null || enemy.IsDead)
                {
                    continue;
                }

                var offset = enemy.transform.position - origin;
                offset.y = 0f;
                if (offset.sqrMagnitude > rangeSquared)
                {
                    continue;
                }

                var pushDirection = offset.sqrMagnitude > 0.0001f ? offset.normalized : forward;
                if (Vector3.Dot(forward, pushDirection) < minimumDot)
                {
                    continue;
                }

                var nextPosition = enemy.transform.position + pushDirection * Mathf.Max(0f, distance);
                if (BattleArenaBounds.Instance != null)
                {
                    nextPosition = BattleArenaBounds.Instance.ClampActorPosition(nextPosition, 0.35f);
                }

                enemy.transform.position = nextPosition;
                affected++;
            }

            return affected;
        }

        private void EnsureMarkVisual()
        {
            if (markVisual != null)
            {
                return;
            }

            markVisual = GameObject.CreatePrimitive(PrimitiveType.Cylinder);
            markVisual.name = "Iris_TargetMark";
            markVisual.transform.SetParent(transform, false);
            markVisual.transform.localPosition = new Vector3(0f, 1.55f, 0f);
            markVisual.transform.localScale = new Vector3(0.55f, 0.025f, 0.55f);
            markVisual.GetComponent<Renderer>().material.color = new Color32(194, 55, 75, 255);
            var markerCollider = markVisual.GetComponent<Collider>();
            if (markerCollider != null)
            {
                Destroy(markerCollider);
            }
        }

        private void UpdateMarkVisual()
        {
            if (markVisual == null)
            {
                return;
            }

            markVisual.SetActive(IsMarked);
            if (IsMarked)
            {
                markVisual.transform.Rotate(Vector3.up, 120f * Time.deltaTime, Space.Self);
            }
        }

        private void HandleDeath(Damageable _)
        {
            Destroy(gameObject);
        }
    }
}
