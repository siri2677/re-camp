using System.IO;
using NUnit.Framework;
using ReCamp.Input;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ReCamp.Tests.EditMode
{
    public sealed class BattleInputRouterTests
    {
        private GameObject routerObject;
        private BattleInputRouter router;

        [SetUp]
        public void SetUp()
        {
            if (BattleInputRouter.Instance != null)
            {
                Object.DestroyImmediate(BattleInputRouter.Instance.gameObject);
            }

            routerObject = new GameObject("BattleInputRouterTest");
            router = routerObject.AddComponent<BattleInputRouter>();
        }

        [TearDown]
        public void TearDown()
        {
            if (routerObject != null)
            {
                Object.DestroyImmediate(routerObject);
            }
        }

        [Test]
        public void NormalizeMove_AppliesDeadZoneAndUnitLimit()
        {
            Assert.That(BattleInputRouter.NormalizeMove(Vector2.right * 0.05f), Is.EqualTo(Vector2.zero));
            Assert.That(BattleInputRouter.NormalizeMove(Vector2.right * 2f), Is.EqualTo(Vector2.right));
        }

        [Test]
        public void SubmitMove_CancelReturnsToZero()
        {
            router.SubmitMove(Vector2.up);
            Assert.That(router.MoveInput, Is.EqualTo(Vector2.up));

            router.SubmitMoveCancelled();

            Assert.That(router.MoveInput, Is.EqualTo(Vector2.zero));
        }

        [Test]
        public void ExtractCommand_EmitsOnlyOnStateTransitions()
        {
            var started = 0;
            var cancelled = 0;
            router.ExtractStarted += () => started++;
            router.ExtractCancelled += () => cancelled++;

            router.SubmitExtractPressed();
            router.SubmitExtractPressed();
            router.SubmitExtractReleased();
            router.SubmitExtractReleased();

            Assert.That(started, Is.EqualTo(1));
            Assert.That(cancelled, Is.EqualTo(1));
            Assert.That(router.IsExtractionHeld, Is.False);
        }

        [Test]
        public void ResetTransientInput_CancelsHeldCommandsAndMovement()
        {
            var signatureReleased = 0;
            router.SignatureReleased += () => signatureReleased++;
            router.SubmitMove(Vector2.one);
            router.SubmitSignaturePressed();
            router.SubmitExtractPressed();

            router.ResetTransientInput();

            Assert.That(router.MoveInput, Is.EqualTo(Vector2.zero));
            Assert.That(router.IsExtractionHeld, Is.False);
            Assert.That(signatureReleased, Is.EqualTo(1));
        }

        [Test]
        public void TouchHoldButton_IgnoresReleaseFromDifferentPointer()
        {
            var eventSystemObject = new GameObject("TouchHoldButtonEventSystem", typeof(EventSystem));
            var buttonObject = new GameObject("TouchHoldButtonTest", typeof(RectTransform), typeof(Button));
            try
            {
                var eventSystem = eventSystemObject.GetComponent<EventSystem>();
                var holdButton = buttonObject.AddComponent<TouchHoldButton>();
                holdButton.Configure(TouchAction.Signature);

                var pressed = 0;
                var released = 0;
                router.SignaturePressed += () => pressed++;
                router.SignatureReleased += () => released++;

                var ownerPointer = new PointerEventData(eventSystem) { pointerId = 101 };
                var otherPointer = new PointerEventData(eventSystem) { pointerId = 202 };

                holdButton.OnPointerDown(ownerPointer);
                holdButton.OnPointerDown(otherPointer);
                holdButton.OnPointerUp(otherPointer);

                Assert.That(holdButton.IsHeld, Is.True);
                Assert.That(holdButton.ActivePointerId, Is.EqualTo(101));
                Assert.That(pressed, Is.EqualTo(1));
                Assert.That(released, Is.EqualTo(0));

                holdButton.OnPointerUp(ownerPointer);

                Assert.That(holdButton.IsHeld, Is.False);
                Assert.That(released, Is.EqualTo(1));
            }
            finally
            {
                Object.DestroyImmediate(buttonObject);
                Object.DestroyImmediate(eventSystemObject);
            }
        }

        [Test]
        public void AndroidPlayerSettings_AutorotationIsLandscapeOnly()
        {
            var projectSettingsPath = Path.GetFullPath(Path.Combine(Application.dataPath, "../ProjectSettings/ProjectSettings.asset"));
            var serializedSettings = File.ReadAllText(projectSettingsPath);

            StringAssert.Contains("defaultScreenOrientation: 4", serializedSettings);
            StringAssert.Contains("allowedAutorotateToPortrait: 0", serializedSettings);
            StringAssert.Contains("allowedAutorotateToPortraitUpsideDown: 0", serializedSettings);
            StringAssert.Contains("allowedAutorotateToLandscapeRight: 1", serializedSettings);
            StringAssert.Contains("allowedAutorotateToLandscapeLeft: 1", serializedSettings);
        }
    }
}
