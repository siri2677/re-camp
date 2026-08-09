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

    /// <summary>Converts one UI pointer gesture into a battle command.</summary>
    [DisallowMultipleComponent]
    public sealed class TouchHoldButton : MonoBehaviour, IPointerDownHandler, IPointerUpHandler, IPointerExitHandler, ICancelHandler
    {
        [SerializeField] private TouchAction action;

        private BattleInputRouter inputRouter;
        private bool held;

        public TouchAction Action => action;

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
            Release();
        }

        public void OnPointerDown(PointerEventData eventData)
        {
            if (held || !IsInteractable())
            {
                return;
            }

            held = true;
            switch (action)
            {
                case TouchAction.Attack:
                    inputRouter.SubmitAttackPressed();
                    break;
                case TouchAction.Signature:
                    inputRouter.SubmitSignaturePressed();
                    break;
                case TouchAction.Utility:
                    inputRouter.SubmitUtilityPressed();
                    break;
                case TouchAction.Extract:
                    inputRouter.SubmitExtractPressed();
                    break;
            }
        }

        public void OnPointerUp(PointerEventData eventData)
        {
            Release();
        }

        public void OnPointerExit(PointerEventData eventData)
        {
            Release();
        }

        public void OnCancel(BaseEventData eventData)
        {
            Release();
        }

        private void Release()
        {
            if (!held)
            {
                return;
            }

            held = false;
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
