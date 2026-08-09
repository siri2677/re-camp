using UnityEngine;
using UnityEngine.EventSystems;

namespace ReCamp.Input
{
    /// <summary>Tracks one pointer and emits normalized movement commands.</summary>
    [DisallowMultipleComponent]
    public sealed class VirtualJoystick : MonoBehaviour, IPointerDownHandler, IDragHandler, IPointerUpHandler, ICancelHandler
    {
        [SerializeField, Min(1f)] private float handleRadius = 82f;

        private RectTransform joystickRect;
        private RectTransform handle;
        private BattleInputRouter inputRouter;
        private int pointerId = int.MinValue;

        public Vector2 Value { get; private set; }

        public void Initialize(RectTransform handleTransform, float radius)
        {
            handle = handleTransform;
            handleRadius = Mathf.Max(1f, radius);
            joystickRect = transform as RectTransform;
            ResetVisuals();
        }

        private void Awake()
        {
            joystickRect = transform as RectTransform;
            inputRouter = BattleInputRouter.EnsureInstance();
        }

        private void OnDisable()
        {
            CancelPointer();
        }

        public void OnPointerDown(PointerEventData eventData)
        {
            if (pointerId != int.MinValue)
            {
                return;
            }

            pointerId = eventData.pointerId;
            UpdatePointer(eventData);
        }

        public void OnDrag(PointerEventData eventData)
        {
            if (eventData.pointerId == pointerId)
            {
                UpdatePointer(eventData);
            }
        }

        public void ResetPointer()
        {
            CancelPointer();
        }
        public void OnPointerUp(PointerEventData eventData)
        {
            if (eventData.pointerId == pointerId)
            {
                CancelPointer();
            }
        }

        public void OnCancel(BaseEventData eventData)
        {
            CancelPointer();
        }

        private void UpdatePointer(PointerEventData eventData)
        {
            if (joystickRect == null)
            {
                joystickRect = transform as RectTransform;
            }

            if (joystickRect == null ||
                !RectTransformUtility.ScreenPointToLocalPointInRectangle(
                    joystickRect,
                    eventData.position,
                    eventData.pressEventCamera,
                    out var localPoint))
            {
                return;
            }

            var halfWidth = Mathf.Max(1f, joystickRect.rect.width * 0.5f);
            var halfHeight = Mathf.Max(1f, joystickRect.rect.height * 0.5f);
            var raw = new Vector2(localPoint.x / halfWidth, localPoint.y / halfHeight);
            Value = Vector2.ClampMagnitude(raw, 1f);

            if (handle != null)
            {
                handle.anchoredPosition = Value * handleRadius;
            }

            (inputRouter ??= BattleInputRouter.EnsureInstance()).SubmitMove(Value);
        }

        private void CancelPointer()
        {
            if (pointerId == int.MinValue)
            {
                return;
            }

            pointerId = int.MinValue;
            Value = Vector2.zero;
            ResetVisuals();
            (inputRouter ??= BattleInputRouter.EnsureInstance()).SubmitMoveCancelled();
        }

        private void ResetVisuals()
        {
            if (handle != null)
            {
                handle.anchoredPosition = Vector2.zero;
            }
        }
    }
}
