using ReCamp.GameFlow;
using UnityEngine;
using UnityEngine.InputSystem;

namespace ReCamp.Player
{
    [RequireComponent(typeof(PlayerStats))]
    public sealed class PlayerController : MonoBehaviour
    {
        public static PlayerController Instance { get; private set; }

        [SerializeField, Min(0f)] private float rotationSpeed = 720f;

        private PlayerStats stats;
        private Camera movementCamera;

        private void Awake()
        {
            Instance = this;
            stats = GetComponent<PlayerStats>();
            movementCamera = Camera.main;
        }

        private void OnDestroy()
        {
            if (Instance == this)
            {
                Instance = null;
            }
        }

        private void Update()
        {
            if (stats.Health.IsDead)
            {
                return;
            }

            var keyboard = Keyboard.current;
            if (keyboard == null)
            {
                return;
            }

            var input = Vector2.zero;
            if (keyboard.aKey.isPressed || keyboard.leftArrowKey.isPressed)
            {
                input.x -= 1f;
            }

            if (keyboard.dKey.isPressed || keyboard.rightArrowKey.isPressed)
            {
                input.x += 1f;
            }

            if (keyboard.sKey.isPressed || keyboard.downArrowKey.isPressed)
            {
                input.y -= 1f;
            }

            if (keyboard.wKey.isPressed || keyboard.upArrowKey.isPressed)
            {
                input.y += 1f;
            }

            if (input.sqrMagnitude > 1f)
            {
                input.Normalize();
            }

            var movement = GetCameraRelativeMovement(input);
            var nextPosition = transform.position + movement * stats.MoveSpeed * Time.deltaTime;
            if (BattleArenaBounds.Instance != null)
            {
                nextPosition = BattleArenaBounds.Instance.ClampActorPosition(nextPosition, 0.5f);
            }

            transform.position = nextPosition;

            if (movement.sqrMagnitude > 0.0001f && rotationSpeed > 0f)
            {
                var targetRotation = Quaternion.LookRotation(movement, Vector3.up);
                transform.rotation = Quaternion.RotateTowards(
                    transform.rotation,
                    targetRotation,
                    rotationSpeed * Time.deltaTime);
            }
        }

        private Vector3 GetCameraRelativeMovement(Vector2 input)
        {
            if (movementCamera == null)
            {
                movementCamera = Camera.main;
            }

            if (movementCamera == null)
            {
                return new Vector3(input.x, 0f, input.y);
            }

            var forward = Vector3.ProjectOnPlane(movementCamera.transform.forward, Vector3.up).normalized;
            var right = Vector3.ProjectOnPlane(movementCamera.transform.right, Vector3.up).normalized;
            var movement = right * input.x + forward * input.y;
            return movement.sqrMagnitude > 1f ? movement.normalized : movement;
        }
    }
}
