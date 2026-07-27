using NUnit.Framework;
using ReCamp.GameFlow;
using UnityEngine;

namespace ReCamp.Tests.EditMode
{
    public sealed class BattleArenaBoundsTests
    {
        private GameObject arenaObject;

        [TearDown]
        public void TearDown()
        {
            if (arenaObject != null)
            {
                Object.DestroyImmediate(arenaObject);
            }
        }

        [Test]
        public void ClampActorPosition_ClampsXZWithPaddingAndPreservesHeight()
        {
            var bounds = CreateBounds(new Vector3(10f, 2f, -5f));

            var clamped = bounds.ClampActorPosition(new Vector3(100f, 7f, -100f), 0.5f);

            Assert.That(clamped.x, Is.EqualTo(20.75f).Within(0.0001f));
            Assert.That(clamped.y, Is.EqualTo(7f).Within(0.0001f));
            Assert.That(clamped.z, Is.EqualTo(-15.75f).Within(0.0001f));
        }

        [Test]
        public void ClampCameraFocus_AccountsForCameraViewExtents()
        {
            var bounds = CreateBounds(new Vector3(10f, 2f, -5f));

            var clamped = bounds.ClampCameraFocus(new Vector3(100f, 7f, -100f));

            Assert.That(clamped.x, Is.EqualTo(12.75f).Within(0.0001f));
            Assert.That(clamped.y, Is.EqualTo(7f).Within(0.0001f));
            Assert.That(clamped.z, Is.EqualTo(-9.75f).Within(0.0001f));
        }

        [Test]
        public void ClampActorPosition_WhenPaddingExceedsArena_UsesArenaCenter()
        {
            var center = new Vector3(3f, 1f, -4f);
            var bounds = CreateBounds(center);

            var clamped = bounds.ClampActorPosition(new Vector3(100f, 8f, -100f), 100f);

            Assert.That(clamped, Is.EqualTo(new Vector3(center.x, 8f, center.z)));
        }

        private BattleArenaBounds CreateBounds(Vector3 position)
        {
            arenaObject = new GameObject("Battle Arena Bounds Test");
            arenaObject.transform.position = position;
            return arenaObject.AddComponent<BattleArenaBounds>();
        }
    }
}
