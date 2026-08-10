using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ReCamp.Input
{
    public enum TouchAction
    {
        Attack,
        Signature,
        Utility,
        Extract,
    }

    /// <summary>Converts one owned UI pointer gesture into a battle command.</summary>
    [DisallowMultipleComponent]
    public sealed class TouchHoldButton : MonoBehaviour, IPointerDownHandler, IPointerUpHandler, IPointerExitHandler, ICancelHandler
    {
        private const int NoPointer = int.MinValue;

        [SerializeField] private TouchAction action;

        private BattleInputRouter inputRouter;
        private int activePointerId = NoPointer;

        public TouchAction Action => action;
        public bool IsHeld => activePointerId != NoPointer;
        public int ActivePointerId => activePointerId;

        public void Configure(TouchAction configuredAction)
        {
            action = configuredAction;
        }

        private void Awake()
        {
            inputRouter = BattleInputRouter.EnsureInstance();
        }

        private void OnDisable()
        {
            ReleaseActivePointer();
        }

        public void OnPointerDown(PointerEventData eventData)
        {
            if (eventData == null || IsHeld || !IsInteractable())
            {
                return;
            }

            activePointerId = eventData.pointerId;
            var router = inputRouter ??= BattleInputRouter.EnsureInstance();
            switch (action)
            {
                case TouchAction.Attack:
                    router.SubmitAttackPressed();
                    break;
                case TouchAction.Signature:
                    router.SubmitSignaturePressed();
                    break;
                case TouchAction.Utility:
                    router.SubmitUtilityPressed();
                    break;
                case TouchAction.Extract:
                    router.SubmitExtractPressed();
                    break;
            }
        }

        public void OnPointerUp(PointerEventData eventData)
        {
            ReleasePointer(eventData);
        }

        public void OnPointerExit(PointerEventData eventData)
        {
            ReleasePointer(eventData);
        }

        public void OnCancel(BaseEventData eventData)
        {
            if (eventData is PointerEventData pointerEvent && pointerEvent.pointerId != activePointerId)
            {
                return;
            }

            ReleaseActivePointer();
        }

        private void ReleasePointer(PointerEventData eventData)
        {
            if (eventData == null || eventData.pointerId != activePointerId)
            {
                return;
            }

            ReleaseActivePointer();
        }

        private void ReleaseActivePointer()
        {
            if (!IsHeld)
            {
                return;
            }

            activePointerId = NoPointer;
            if (inputRouter == null)
            {
                return;
            }

            switch (action)
            {
                case TouchAction.Attack:
                    inputRouter.SubmitAttackReleased();
                    break;
                case TouchAction.Signature:
                    inputRouter.SubmitSignatureReleased();
                    break;
                case TouchAction.Utility:
                    inputRouter.SubmitUtilityReleased();
                    break;
                case TouchAction.Extract:
                    inputRouter.SubmitExtractReleased();
                    break;
            }
        }

        private bool IsInteractable()
        {
            var button = GetComponent<Button>();
            return button == null || button.interactable;
        }
    }
}
