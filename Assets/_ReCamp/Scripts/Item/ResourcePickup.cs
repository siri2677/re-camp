using System.Collections.Generic;
using ReCamp.GameFlow;
using ReCamp.Player;
using UnityEngine;

namespace ReCamp.Item
{
    public sealed class ResourcePickup : MonoBehaviour
    {
        private static readonly List<ResourcePickup> ActivePickups = new();

        [SerializeField] private ResourceType resourceType;
        [SerializeField, Min(1)] private int amount = 1;
        [SerializeField, Min(0.1f)] private float pickupRange = 1.25f;
        [SerializeField, Min(0.1f)] private float attractionSpeed = 8f;

        private BattleSceneController battle;
        private Vector3 baseScale;
        private float revealedUntil;

        public bool IsRevealed => revealedUntil > Time.time;
        public static int ActiveCount => ActivePickups.Count;

        private void Awake()
        {
            baseScale = transform.localScale;
            ActivePickups.Add(this);
        }

        private void Start()
        {
            battle = FindFirstObjectByType<BattleSceneController>();
        }

        private void OnDestroy()
        {
            ActivePickups.Remove(this);
        }

        private void Update()
        {
            UpdateRevealFeedback();

            var player = PlayerController.Instance;
            if (player == null)
            {
                return;
            }

            var offset = player.transform.position - transform.position;
            offset.y = 0f;
            var distance = offset.magnitude;
            var playerStats = player.GetComponent<PlayerStats>();
            var rolePickupRange = playerStats == null || playerStats.Ability == null
                ? 0f
                : playerStats.Ability.ResourcePickupRange;
            var effectivePickupRange = Mathf.Max(pickupRange, rolePickupRange);
            if (distance > effectivePickupRange)
            {
                return;
            }

            var targetPosition = player.transform.position;
            targetPosition.y = transform.position.y;
            transform.position = Vector3.MoveTowards(
                transform.position,
                targetPosition,
                attractionSpeed * (playerStats?.Ability?.ResourceAttractionSpeedMultiplier ?? 1f) *
                Time.deltaTime);

            var remainingOffset = targetPosition - transform.position;
            remainingOffset.y = 0f;
            if (remainingOffset.sqrMagnitude <= 0.35f * 0.35f)
            {
                battle?.CollectResource(resourceType, amount);
                Destroy(gameObject);
            }
        }

        public static int RevealWithin(Vector3 origin, float range, float duration)
        {
            var revealedCount = 0;
            var rangeSquared = Mathf.Max(0f, range) * Mathf.Max(0f, range);
            for (var index = ActivePickups.Count - 1; index >= 0; index--)
            {
                var pickup = ActivePickups[index];
                if (pickup == null)
                {
                    ActivePickups.RemoveAt(index);
                    continue;
                }

                var offset = pickup.transform.position - origin;
                offset.y = 0f;
                if (offset.sqrMagnitude > rangeSquared)
                {
                    continue;
                }

                pickup.revealedUntil = Mathf.Max(pickup.revealedUntil, Time.time + Mathf.Max(0f, duration));
                revealedCount++;
            }

            return revealedCount;
        }

        private void UpdateRevealFeedback()
        {
            if (!IsRevealed)
            {
                transform.localScale = baseScale;
                return;
            }

            var pulse = 1f + Mathf.Sin(Time.time * 8f) * 0.12f;
            transform.localScale = baseScale * pulse;
            transform.Rotate(Vector3.up, 100f * Time.deltaTime, Space.World);
        }

        public static void Spawn(ResourceType type, int amount, Vector3 position)
        {
            var pickupObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
            pickupObject.name = $"Pickup_{type}";
            position.y = 0.25f;
            pickupObject.transform.position = position;
            pickupObject.transform.localScale = Vector3.one * 0.35f;
            var renderer = pickupObject.GetComponent<Renderer>();
            renderer.material.color = type switch
            {
                ResourceType.Scrap => new Color(0.65f, 0.65f, 0.7f),
                ResourceType.Food => new Color(0.3f, 0.85f, 0.35f),
                _ => new Color(0.3f, 0.65f, 1f),
            };

            var pickup = pickupObject.AddComponent<ResourcePickup>();
            pickup.resourceType = type;
            pickup.amount = Mathf.Max(1, amount);
        }
    }
}
