using System;
using UnityEngine;
using UnityEngine.InputSystem;

namespace ReCamp.Input
{
    /// <summary>Translates device input into the commands consumed by battle gameplay.</summary>
    [DisallowMultipleComponent]
    public sealed class BattleInputRouter : MonoBehaviour
    {
        public const float DefaultMoveDeadZone = 0.12f;

        public static BattleInputRouter Instance { get; private set; }

        [SerializeField, Range(0f, 0.99f)] private float moveDeadZone = DefaultMoveDeadZone;

        private Vector2 touchMove;
        private bool touchMoveActive;
        private bool touchExtractHeld;
        private bool keyboardExtractHeld;
        private bool signatureHeld;
        private bool utilityHeld;

        public Vector2 MoveInput { get; private set; }
        public bool IsExtractionHeld { get; private set; }

        public event Action AttackPressed;
        public event Action AttackReleased;
        public event Action SignaturePressed;
        public event Action SignatureReleased;
        public event Action UtilityPressed;
        public event Action UtilityReleased;
        public event Action ExtractStarted;
        public event Action ExtractCancelled;

        public static BattleInputRouter EnsureInstance()
        {
            if (Instance != null)
            {
                return Instance;
            }

            var existing = FindAnyObjectByType<BattleInputRouter>();
            if (existing != null)
            {
                Instance = existing;
                return existing;
            }

            var inputObject = new GameObject("BattleInputRouter");
            return inputObject.AddComponent<BattleInputRouter>();
        }

        public static Vector2 NormalizeMove(Vector2 input, float deadZone = DefaultMoveDeadZone)
        {
            var magnitude = Mathf.Clamp01(input.magnitude);
            var clampedDeadZone = Mathf.Clamp(deadZone, 0f, 0.99f);
            if (magnitude <= clampedDeadZone)
            {
                return Vector2.zero;
            }

            var remappedMagnitude = Mathf.InverseLerp(clampedDeadZone, 1f, magnitude);
            return input / input.magnitude * remappedMagnitude;
        }

        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
                return;
            }

            Instance = this;
        }

        private void Update()
        {
            UpdateMoveInput();
            UpdateKeyboardCommands();
        }

        private void OnDisable()
        {
            ResetTransientInput();
        }

        private void OnApplicationPause(bool paused)
        {
            if (paused)
            {
                ResetTransientInput();
            }
        }

        private void OnApplicationFocus(bool hasFocus)
        {
            if (!hasFocus)
            {
                ResetTransientInput();
            }
        }

        private void OnDestroy()
        {
            if (Instance == this)
            {
                Instance = null;
            }
        }

        public void SubmitMove(Vector2 input)
        {
            touchMove = input;
            touchMoveActive = true;
            UpdateMoveInput();
        }

        public void SubmitMoveCancelled()
        {
            touchMove = Vector2.zero;
            touchMoveActive = false;
            UpdateMoveInput();
        }

        public void SubmitAttackPressed()
        {
            AttackPressed?.Invoke();
        }

        public void SubmitAttackReleased()
        {
            AttackReleased?.Invoke();
        }

        public void SubmitSignaturePressed()
        {
            if (signatureHeld)
            {
                return;
            }

            signatureHeld = true;
            SignaturePressed?.Invoke();
        }

        public void SubmitSignatureReleased()
        {
            if (!signatureHeld)
            {
                return;
            }

            signatureHeld = false;
            SignatureReleased?.Invoke();
        }

        public void SubmitUtilityPressed()
        {
            if (utilityHeld)
            {
                return;
            }

            utilityHeld = true;
            UtilityPressed?.Invoke();
        }

        public void SubmitUtilityReleased()
        {
            if (!utilityHeld)
            {
                return;
            }

            utilityHeld = false;
            UtilityReleased?.Invoke();
        }

        public void SubmitExtractPressed()
        {
            touchExtractHeld = true;
            UpdateExtractionState();
        }

        public void SubmitExtractReleased()
        {
            touchExtractHeld = false;
            UpdateExtractionState();
        }

        public void ResetTransientInput()
        {
            var wasExtracting = IsExtractionHeld;
            var wasSignatureHeld = signatureHeld;
            var wasUtilityHeld = utilityHeld;

            touchMove = Vector2.zero;
            touchMoveActive = false;
            touchExtractHeld = false;
            keyboardExtractHeld = false;
            signatureHeld = false;
            utilityHeld = false;
            MoveInput = Vector2.zero;
            IsExtractionHeld = false;

            if (wasExtracting)
            {
                ExtractCancelled?.Invoke();
            }

            if (wasSignatureHeld)
            {
                SignatureReleased?.Invoke();
            }

            if (wasUtilityHeld)
            {
                UtilityReleased?.Invoke();
            }
        }

        private void UpdateMoveInput()
        {
            var source = touchMoveActive ? touchMove : ReadKeyboardMove();
            MoveInput = NormalizeMove(source, moveDeadZone);
        }

        private void UpdateKeyboardCommands()
        {
            var keyboard = Keyboard.current;
            if (keyboard == null)
            {
                if (!touchMoveActive)
                {
                    MoveInput = Vector2.zero;
                }

                return;
            }

            if (keyboard.spaceKey.wasPressedThisFrame)
            {
                SubmitSignaturePressed();
            }

            if (keyboard.spaceKey.wasReleasedThisFrame)
            {
                SubmitSignatureReleased();
            }

            if (keyboard.eKey.wasPressedThisFrame)
            {
                SubmitUtilityPressed();
            }

            if (keyboard.eKey.wasReleasedThisFrame)
            {
                SubmitUtilityReleased();
            }

            var keyboardExtracting = keyboard.rKey.isPressed;
            if (keyboardExtracting != keyboardExtractHeld)
            {
                keyboardExtractHeld = keyboardExtracting;
                UpdateExtractionState();
            }
        }

        private Vector2 ReadKeyboardMove()
        {
            var keyboard = Keyboard.current;
            if (keyboard == null)
            {
                return Vector2.zero;
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

            return input;
        }

        private void UpdateExtractionState()
        {
            var nextState = touchExtractHeld || keyboardExtractHeld;
            if (nextState == IsExtractionHeld)
            {
                return;
            }

            IsExtractionHeld = nextState;
            if (nextState)
            {
                ExtractStarted?.Invoke();
            }
            else
            {
                ExtractCancelled?.Invoke();
            }
        }
    }
}
