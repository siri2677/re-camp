using NUnit.Framework;
using ReCamp.Input;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ReCamp.Tests.EditMode
{
    public sealed class TouchHoldButtonTests
    {
        private GameObject routerObject;
        private GameObject buttonObject;
        private TouchHoldButton button;

        [SetUp]
        public void SetUp()
        {
            if (BattleInputRouter.Instance != null)
            {
                Object.DestroyImmediate(BattleInputRouter.Instance.gameObject);
            }

            routerObject = new GameObject("Touch Hold Router Test");
            var router = routerObject.AddComponent<BattleInputRouter>();
            buttonObject = new GameObject("Touch Hold Button Test");
            button = buttonObject.AddComponent<TouchHoldButton>();
            button.Configure(TouchAction.Signature);
        }

        [TearDown]
        public void TearDown()
        {
            if (buttonObject != null)
            {
                Object.DestroyImmediate(buttonObject);
            }

            if (routerObject != null)
            {
                Object.DestroyImmediate(routerObject);
            }
        }

        [Test]
        public void NonOwnerPointerCannotReleaseHeldGesture()
        {
            var pressed = 0;
            var released = 0;
            BattleInputRouter.Instance.SignaturePressed += () => pressed++;
            BattleInputRouter.Instance.SignatureReleased += () => released++;
            var owner = Pointer(10);
            var other = Pointer(11);

            button.OnPointerDown(owner);
            button.OnPointerDown(other);
            button.OnPointerUp(other);

            Assert.That(pressed, Is.EqualTo(1));
            Assert.That(released, Is.Zero);
            Assert.That(BattleInputRouter.Instance.IsExtractionHeld, Is.False);

            button.OnPointerUp(owner);

            Assert.That(released, Is.EqualTo(1));
        }

        [Test]
        public void OwnerPointerExitReleasesGesture()
        {
            var released = 0;
            BattleInputRouter.Instance.SignatureReleased += () => released++;
            var owner = Pointer(3);

            button.OnPointerDown(owner);
            button.OnPointerExit(owner);

            Assert.That(released, Is.EqualTo(1));
        }

        private static PointerEventData Pointer(int pointerId)
        {
            var data = new PointerEventData(null)
            {
                pointerId = pointerId,
            };
            return data;
        }
    }
}
