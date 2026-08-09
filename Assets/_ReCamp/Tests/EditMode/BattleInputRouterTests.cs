using NUnit.Framework;
using ReCamp.Input;
using UnityEngine;

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
    }
}
