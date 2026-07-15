using System.Collections.Generic;
using ReCamp.Combat;
using ReCamp.Data;
using ReCamp.Enemy;
using ReCamp.GameFlow;
using ReCamp.Item;
using UnityEngine;
using UnityEngine.InputSystem;

namespace ReCamp.Player
{
    /// <summary>Input-driven gray-box implementation of each character's combat identity.</summary>
    [DisallowMultipleComponent]
    public sealed class CharacterAbilityController : MonoBehaviour
    {
        private const float LunaDashDistance = 4.5f;
        private const float LunaScanDuration = 4f;
        private const float LunaScanRange = 7f;
        private const float MiyuOverclockDuration = 5f;
        private const float CocoShieldDuration = 6f;
        private const float IrisChargeDuration = 1.4f;
        private const float IrisMarkDuration = 7f;
        private const float NoahGuardDuration = 2.5f;
        private const float NoahGuardMultiplier = 0.3f;
        private const float NoahBarrierDuration = 5f;

        private PlayerStats stats;
        private CharacterDefinition definition;
        private Damageable subscribedHealth;
        private float nextReadyTime;
        private float nextUtilityReadyTime;
        private float guardEndsAt;
        private float scanEndsAt;
        private float overclockEndsAt;
        private float shieldEndsAt;
        private float chargeStartedAt;
        private float droneOrbitAngle;
        private float nextDroneAttackTime;
        private bool counterAvailable;
        private bool isCharging;
        private int lastScanCount;
        private Transform droneTransform;
        private EnemyController markedTarget;
        private EnergyBarrier activeBarrier;

        public CharacterDefinition Definition => definition;
        public string AbilityName => definition == null ? "대표 능력" : definition.SignatureAbilityName;
        public string UtilityAbilityName => definition == null
            ? "역할 능력"
            : definition.Id switch
            {
                CharacterId.Luna => "스캔 펄스",
                CharacterId.Miyu => "오버클럭",
                CharacterId.Coco => "세이프 존",
                CharacterId.Iris => "마크 타깃",
                CharacterId.Noah => "배리어 월",
                _ => "역할 능력",
            };
        public float CooldownDuration => definition == null ? 0f : definition.AbilityCooldown;
        public float UtilityCooldownDuration => definition == null
            ? 0f
            : definition.Id switch
            {
                CharacterId.Luna => 7f,
                CharacterId.Miyu => 10f,
                CharacterId.Coco => 10f,
                CharacterId.Iris => 9f,
                CharacterId.Noah => 12f,
                _ => 0f,
            };
        public float CooldownRemaining => Mathf.Max(0f, nextReadyTime - Time.time);
        public float UtilityCooldownRemaining => Mathf.Max(0f, nextUtilityReadyTime - Time.time);
        public float GuardRemaining => IsGuarding ? Mathf.Max(0f, guardEndsAt - Time.time) : 0f;
        public float ScanRemaining => IsScanning ? Mathf.Max(0f, scanEndsAt - Time.time) : 0f;
        public float ShieldRemaining => IsShieldActive ? Mathf.Max(0f, shieldEndsAt - Time.time) : 0f;
        public float MarkRemaining => markedTarget == null ? 0f : markedTarget.MarkRemaining;
        public float BarrierRemaining => activeBarrier == null ? 0f : activeBarrier.Remaining;
        public float ChargeRatio => !isCharging
            ? 0f
            : Mathf.Clamp01((Time.time - chargeStartedAt) / IrisChargeDuration);
        public int LastScanCount => lastScanCount;
        public bool IsReady => definition != null && stats != null && CooldownRemaining <= 0f;
        public bool IsUtilityReady => definition != null && stats != null && UtilityCooldownRemaining <= 0f;
        public bool IsGuarding => definition != null && definition.Id == CharacterId.Noah &&
            guardEndsAt > Time.time;
        public bool IsScanning => definition != null && definition.Id == CharacterId.Luna &&
            scanEndsAt > Time.time;
        public bool IsDroneOnline => definition != null && definition.Id == CharacterId.Miyu &&
            droneTransform != null;
        public bool IsDroneOverclocked => IsDroneOnline && overclockEndsAt > Time.time;
        public bool IsShieldActive => definition != null && definition.Id == CharacterId.Coco &&
            stats?.Health != null && stats.Health.ShieldPoints > 0 && shieldEndsAt > Time.time;
        public bool IsCharging => isCharging;
        public bool HasMarkedTarget => markedTarget != null && markedTarget.IsMarked;
        public bool IsBarrierActive => activeBarrier != null;
        public float ResourcePickupRange => definition == null
            ? 1.25f
            : definition.Id switch
            {
                CharacterId.Luna => IsScanning ? LunaScanRange : 2.25f,
                CharacterId.Miyu => 5.5f,
                _ => 1.25f,
            };
        public float ResourceAttractionSpeedMultiplier => definition == null
            ? 1f
            : definition.Id switch
            {
                CharacterId.Luna when IsScanning => 1.8f,
                CharacterId.Miyu => 2.25f,
                _ => 1f,
            };
        public string RoleStatusText => definition == null
            ? "역할 정보 불러오는 중"
            : definition.Id switch
            {
                CharacterId.Luna when IsScanning => $"탐지 {lastScanCount} · 스캔 {ScanRemaining:0.0}s",
                CharacterId.Luna => $"자원 감지 {ResourcePickupRange:0.0}m",
                CharacterId.Miyu when IsDroneOverclocked => $"드론 오버클럭 {Mathf.Max(0f, overclockEndsAt - Time.time):0.0}s",
                CharacterId.Miyu when IsDroneOnline => $"드론 온라인 · 회수 {ResourcePickupRange:0.0}m",
                CharacterId.Miyu => "드론 재연결 중",
                CharacterId.Coco when IsShieldActive => $"보호막 {stats.Health.ShieldPoints} · {ShieldRemaining:0.0}s",
                CharacterId.Coco => "보호막 없음",
                CharacterId.Iris when IsCharging => $"차지 {ChargeRatio * 100f:0}%",
                CharacterId.Iris when HasMarkedTarget => $"표식 {MarkRemaining:0.0}s",
                CharacterId.Iris => "정밀 조준 대기",
                CharacterId.Noah when IsBarrierActive => $"방벽 {BarrierRemaining:0.0}s",
                CharacterId.Noah when IsGuarding => $"가드 {GuardRemaining:0.0}s",
                CharacterId.Noah => "전개 장치 대기",
                _ => string.Empty,
            };

        private void Awake()
        {
            stats = GetComponent<PlayerStats>();
            if (stats != null && stats.Character != null)
            {
                Configure(stats, stats.Character);
            }
        }

        private void Update()
        {
            UpdateTimedStates();
            UpdateDrone();

            var keyboard = Keyboard.current;
            if (keyboard == null)
            {
                return;
            }

            if (definition?.Id == CharacterId.Iris)
            {
                if (keyboard.spaceKey.wasPressedThisFrame)
                {
                    BeginCharge();
                }

                if (keyboard.spaceKey.wasReleasedThisFrame)
                {
                    ReleaseCharge();
                }
            }
            else if (keyboard.spaceKey.wasPressedThisFrame)
            {
                TryActivate();
            }

            if (keyboard.eKey.wasPressedThisFrame)
            {
                TryActivateUtility();
            }
        }

        private void OnDestroy()
        {
            ResetCharacterRuntime();
            SubscribeToHealth(null);
        }

        public void Configure(PlayerStats playerStats, CharacterDefinition characterDefinition)
        {
            if (playerStats == null)
            {
                return;
            }

            var nextDefinition = characterDefinition ?? CharacterRoster.Default;
            var characterChanged = definition == null || definition.Id != nextDefinition.Id;
            if (characterChanged)
            {
                ResetCharacterRuntime();
                nextReadyTime = 0f;
                nextUtilityReadyTime = 0f;
            }

            stats = playerStats;
            definition = nextDefinition;
            SubscribeToHealth(stats.Health);
            EnsureDroneForCurrentCharacter();
        }

        public bool TryActivate()
        {
            if (!CanUseAbility(IsReady))
            {
                return false;
            }

            if (isCharging)
            {
                CancelCharge();
            }

            var activated = definition.Id switch
            {
                CharacterId.Luna => ActivateLunaDash(),
                CharacterId.Miyu => ActivateMiyuDroneBurst(),
                CharacterId.Coco => ActivateCocoRecovery(),
                CharacterId.Iris => ActivateIrisFocusShot(1f),
                CharacterId.Noah => ActivateNoahGuard(),
                _ => false,
            };

            if (activated)
            {
                nextReadyTime = Time.time + definition.AbilityCooldown;
            }

            return activated;
        }

        public bool TryActivateUtility()
        {
            if (!CanUseAbility(IsUtilityReady))
            {
                return false;
            }

            var activated = definition.Id switch
            {
                CharacterId.Luna => ActivateLunaScan(),
                CharacterId.Miyu => ActivateMiyuOverclock(),
                CharacterId.Coco => ActivateCocoShield(),
                CharacterId.Iris => ActivateIrisMark(),
                CharacterId.Noah => ActivateNoahBarrier(),
                _ => false,
            };

            if (activated)
            {
                nextUtilityReadyTime = Time.time + UtilityCooldownDuration;
            }

            return activated;
        }

        public bool BeginCharge()
        {
            if (definition?.Id != CharacterId.Iris || isCharging || !CanUseAbility(IsReady))
            {
                return false;
            }

            isCharging = true;
            chargeStartedAt = Time.time;
            return true;
        }

        public bool ReleaseCharge()
        {
            if (!isCharging)
            {
                return false;
            }

            var chargeRatio = ChargeRatio;
            CancelCharge();
            if (!CanUseAbility(IsReady) || !ActivateIrisFocusShot(chargeRatio))
            {
                return false;
            }

            nextReadyTime = Time.time + definition.AbilityCooldown;
            return true;
        }

        private bool ActivateLunaDash()
        {
            var direction = GetPlanarForward();
            var nextPosition = transform.position + direction * LunaDashDistance;
            if (BattleArenaBounds.Instance != null)
            {
                nextPosition = BattleArenaBounds.Instance.ClampActorPosition(nextPosition, 0.5f);
            }

            transform.position = nextPosition;
            return true;
        }

        private bool ActivateMiyuDroneBurst()
        {
            var range = Mathf.Max(8f, stats.AttackRange * 1.6f);
            var target = EnemyController.FindClosestAlive(transform.position, range);
            if (target == null)
            {
                return false;
            }

            var multiplier = IsDroneOverclocked ? 2.8f : 2.25f;
            target.TakeDamage(Mathf.CeilToInt(stats.AttackDamage * multiplier));
            return true;
        }

        private bool ActivateCocoRecovery()
        {
            var healing = Mathf.CeilToInt(stats.Health.MaxHealth * 0.35f);
            return stats.Health.Heal(healing) > 0;
        }

        private bool ActivateIrisFocusShot(float chargeRatio)
        {
            var range = Mathf.Max(14f, stats.AttackRange * 1.75f);
            var target = EnemyController.FindClosestAlive(transform.position, range);
            if (target == null)
            {
                return false;
            }

            var damageMultiplier = Mathf.Lerp(2f, 4f, Mathf.Clamp01(chargeRatio));
            if (target.IsBoss)
            {
                damageMultiplier *= 1.25f;
            }

            target.TakeDamage(Mathf.CeilToInt(stats.AttackDamage * damageMultiplier));
            return true;
        }

        private bool ActivateNoahGuard()
        {
            guardEndsAt = Time.time + NoahGuardDuration;
            counterAvailable = true;
            stats.Health.SetDamageTakenMultiplier(NoahGuardMultiplier);
            return true;
        }

        private bool ActivateLunaScan()
        {
            scanEndsAt = Time.time + LunaScanDuration;
            lastScanCount = ResourcePickup.RevealWithin(transform.position, LunaScanRange, LunaScanDuration);
            return true;
        }

        private bool ActivateMiyuOverclock()
        {
            EnsureDroneForCurrentCharacter();
            if (droneTransform == null)
            {
                return false;
            }

            overclockEndsAt = Time.time + MiyuOverclockDuration;
            nextDroneAttackTime = 0f;
            return true;
        }

        private bool ActivateCocoShield()
        {
            var shieldPoints = Mathf.CeilToInt(stats.Health.MaxHealth * 0.3f);
            stats.Health.SetShield(Mathf.Max(stats.Health.ShieldPoints, shieldPoints));
            shieldEndsAt = Time.time + CocoShieldDuration;
            return true;
        }

        private bool ActivateIrisMark()
        {
            var range = Mathf.Max(16f, stats.AttackRange * 1.8f);
            var target = EnemyController.FindClosestAlive(transform.position, range);
            if (target == null)
            {
                return false;
            }

            if (markedTarget != null && markedTarget != target)
            {
                markedTarget.ClearMark();
            }

            markedTarget = target;
            markedTarget.Mark(IrisMarkDuration, 1.35f);
            return true;
        }

        private bool ActivateNoahBarrier()
        {
            if (activeBarrier != null)
            {
                DestroyOwnedObject(activeBarrier.gameObject);
            }

            var direction = GetPlanarForward();
            var center = transform.position + direction * 2.4f + Vector3.up;
            activeBarrier = EnergyBarrier.Spawn(center, direction, 5.5f, NoahBarrierDuration);
            EnemyController.KnockbackInCone(transform.position, direction, 6f, 55f, 2.6f);
            return activeBarrier != null;
        }

        private void UpdateTimedStates()
        {
            if (guardEndsAt > 0f && Time.time >= guardEndsAt)
            {
                EndGuard();
            }

            if (shieldEndsAt > 0f &&
                (Time.time >= shieldEndsAt || stats?.Health == null || stats.Health.ShieldPoints <= 0))
            {
                if (stats?.Health != null && Time.time >= shieldEndsAt)
                {
                    stats.Health.ClearShield();
                }

                shieldEndsAt = 0f;
            }

            if (markedTarget != null && (!markedTarget.IsMarked || markedTarget.IsDead))
            {
                markedTarget = null;
            }

            if (activeBarrier == null)
            {
                activeBarrier = null;
            }
        }

        private void UpdateDrone()
        {
            if (definition?.Id != CharacterId.Miyu)
            {
                return;
            }

            EnsureDroneForCurrentCharacter();
            if (droneTransform == null)
            {
                return;
            }

            droneOrbitAngle += (IsDroneOverclocked ? 180f : 105f) * Time.deltaTime;
            var radians = droneOrbitAngle * Mathf.Deg2Rad;
            droneTransform.localPosition = new Vector3(
                Mathf.Cos(radians) * 1.4f,
                1.25f + Mathf.Sin(Time.time * 3f) * 0.12f,
                Mathf.Sin(radians) * 1.4f);

            if (stats.Health == null || stats.Health.IsDead || Time.time < nextDroneAttackTime)
            {
                return;
            }

            var target = EnemyController.FindClosestAlive(
                droneTransform.position,
                Mathf.Max(9f, stats.AttackRange * 1.35f));
            if (target != null)
            {
                var damageMultiplier = IsDroneOverclocked ? 0.85f : 0.55f;
                target.TakeDamage(Mathf.Max(1, Mathf.CeilToInt(stats.AttackDamage * damageMultiplier)));
            }

            nextDroneAttackTime = Time.time + (IsDroneOverclocked ? 0.38f : 0.85f);
        }

        private void EnsureDroneForCurrentCharacter()
        {
            if (definition?.Id != CharacterId.Miyu || droneTransform != null)
            {
                return;
            }

            var drone = GameObject.CreatePrimitive(PrimitiveType.Sphere);
            drone.name = "Miyu_Drone_Runtime";
            drone.transform.SetParent(transform, false);
            drone.transform.localPosition = new Vector3(1.4f, 1.25f, 0f);
            drone.transform.localScale = Vector3.one * 0.38f;
            drone.GetComponent<Renderer>().material.color = (Color)definition.AccentColor;
            var droneCollider = drone.GetComponent<Collider>();
            if (droneCollider != null)
            {
                DestroyOwnedObject(droneCollider);
            }

            droneTransform = drone.transform;
            nextDroneAttackTime = Time.time + 0.35f;
        }

        private void HandleDamaged(Damageable _, int __)
        {
            if (!IsGuarding || !counterAvailable)
            {
                return;
            }

            counterAvailable = false;
            var target = EnemyController.FindClosestAlive(transform.position, 4f);
            if (target != null)
            {
                target.TakeDamage(stats.AttackDamage * 3);
            }
        }

        private bool CanUseAbility(bool ready)
        {
            return ready && stats?.Health != null && !stats.Health.IsDead;
        }

        private Vector3 GetPlanarForward()
        {
            var direction = Vector3.ProjectOnPlane(transform.forward, Vector3.up).normalized;
            return direction.sqrMagnitude < 0.0001f ? Vector3.forward : direction;
        }

        private void CancelCharge()
        {
            isCharging = false;
            chargeStartedAt = 0f;
        }

        private void EndGuard()
        {
            guardEndsAt = 0f;
            counterAvailable = false;
            subscribedHealth?.ResetDamageTakenMultiplier();
        }

        private void ResetCharacterRuntime()
        {
            EndGuard();
            CancelCharge();
            if (stats?.Health != null)
            {
                stats.Health.ClearShield();
            }

            if (markedTarget != null)
            {
                markedTarget.ClearMark();
                markedTarget = null;
            }

            if (droneTransform != null)
            {
                DestroyOwnedObject(droneTransform.gameObject);
                droneTransform = null;
            }

            if (activeBarrier != null)
            {
                DestroyOwnedObject(activeBarrier.gameObject);
                activeBarrier = null;
            }

            scanEndsAt = 0f;
            overclockEndsAt = 0f;
            shieldEndsAt = 0f;
            lastScanCount = 0;
        }

        private void SubscribeToHealth(Damageable health)
        {
            if (subscribedHealth == health)
            {
                return;
            }

            if (subscribedHealth != null)
            {
                subscribedHealth.Damaged -= HandleDamaged;
            }

            subscribedHealth = health;
            if (subscribedHealth != null)
            {
                subscribedHealth.Damaged += HandleDamaged;
            }
        }

        private static void DestroyOwnedObject(Object ownedObject)
        {
            if (ownedObject == null)
            {
                return;
            }

            if (Application.isPlaying)
            {
                Destroy(ownedObject);
            }
            else
            {
                DestroyImmediate(ownedObject);
            }
        }
    }

    /// <summary>Runtime wall that blocks direct enemy movement without relying on rigidbody physics.</summary>
    internal sealed class EnergyBarrier : MonoBehaviour
    {
        private static readonly List<EnergyBarrier> ActiveBarriers = new();
        private const float Thickness = 0.25f;

        private float width;
        private float expiresAt;

        public float Remaining => Mathf.Max(0f, expiresAt - Time.time);

        private void Awake()
        {
            ActiveBarriers.Add(this);
        }

        private void Update()
        {
            if (Time.time >= expiresAt)
            {
                Destroy(gameObject);
            }
        }

        private void OnDestroy()
        {
            ActiveBarriers.Remove(this);
        }

        public static EnergyBarrier Spawn(
            Vector3 center,
            Vector3 forward,
            float barrierWidth,
            float duration)
        {
            var barrierObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
            barrierObject.name = "Noah_EnergyBarrier_Runtime";
            barrierObject.transform.position = center;
            barrierObject.transform.rotation = Quaternion.LookRotation(forward, Vector3.up);
            barrierObject.transform.localScale = new Vector3(barrierWidth, 2f, Thickness);
            barrierObject.GetComponent<Renderer>().material.color = new Color32(234, 166, 55, 220);
            var collider = barrierObject.GetComponent<Collider>();
            if (collider != null)
            {
                if (Application.isPlaying)
                {
                    Destroy(collider);
                }
                else
                {
                    DestroyImmediate(collider);
                }
            }

            var barrier = barrierObject.AddComponent<EnergyBarrier>();
            barrier.width = Mathf.Max(0.5f, barrierWidth);
            barrier.expiresAt = Time.time + Mathf.Max(0.1f, duration);
            return barrier;
        }

        public static Vector3 ClampEnemyMovement(Vector3 current, Vector3 proposed, float radius)
        {
            for (var index = ActiveBarriers.Count - 1; index >= 0; index--)
            {
                var barrier = ActiveBarriers[index];
                if (barrier == null)
                {
                    ActiveBarriers.RemoveAt(index);
                    continue;
                }

                proposed = barrier.ClampMovement(current, proposed, radius);
            }

            return proposed;
        }

        private Vector3 ClampMovement(Vector3 current, Vector3 proposed, float radius)
        {
            var center = transform.position;
            center.y = proposed.y;
            var currentOffset = current - center;
            var proposedOffset = proposed - center;
            currentOffset.y = 0f;
            proposedOffset.y = 0f;

            var right = transform.right;
            var forward = transform.forward;
            var proposedLateral = Vector3.Dot(proposedOffset, right);
            var halfWidth = width * 0.5f + radius;
            if (Mathf.Abs(proposedLateral) > halfWidth)
            {
                return proposed;
            }

            var safeDepth = Thickness * 0.5f + radius;
            var currentDepth = Vector3.Dot(currentOffset, forward);
            var proposedDepth = Vector3.Dot(proposedOffset, forward);
            if (currentDepth >= safeDepth && proposedDepth < safeDepth)
            {
                proposed += forward * (safeDepth - proposedDepth);
            }

            return proposed;
        }
    }
}
