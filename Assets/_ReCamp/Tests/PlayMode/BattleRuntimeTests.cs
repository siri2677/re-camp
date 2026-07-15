using System.Collections;
using NUnit.Framework;
using ReCamp.GameFlow;
using UnityEngine;
using UnityEngine.TestTools;

namespace ReCamp.Tests.PlayMode
{
    public sealed class BattleRuntimeTests
    {
        private GameObject arenaObject;
        private GameObject controllerObject;

        [UnitySetUp]
        public IEnumerator SetUp()
        {
            if (BattleArenaBounds.Instance != null)
            {
                Object.Destroy(BattleArenaBounds.Instance.gameObject);
                yield return null;
            }
        }

        [UnityTearDown]
        public IEnumerator TearDown()
        {
            if (arenaObject != null)
            {
                Object.Destroy(arenaObject);
                arenaObject = null;
                yield return null;
            }

            if (controllerObject != null)
            {
                Object.Destroy(controllerObject);
                controllerObject = null;
                yield return null;
            }
        }

        [UnityTest]
        public IEnumerator BattleArenaBounds_PublishesAndClearsSingletonAcrossLifecycle()
        {
            arenaObject = new GameObject("Battle Arena Bounds PlayMode Test");
            var bounds = arenaObject.AddComponent<BattleArenaBounds>();

            yield return null;

            Assert.That(BattleArenaBounds.Instance, Is.SameAs(bounds));

            Object.Destroy(arenaObject);
            arenaObject = null;
            yield return null;

            Assert.That(BattleArenaBounds.Instance, Is.Null);
        }

        [UnityTest]
        public IEnumerator BattleArenaBounds_ClampsActorAfterComponentInitialization()
        {
            arenaObject = new GameObject("Battle Arena Bounds PlayMode Test");
            arenaObject.transform.position = new Vector3(-2f, 0f, 4f);
            var bounds = arenaObject.AddComponent<BattleArenaBounds>();

            yield return null;

            var clamped = bounds.ClampActorPosition(new Vector3(-100f, 3f, 100f), 1.25f);
            Assert.That(clamped.x, Is.EqualTo(-12f).Within(0.0001f));
            Assert.That(clamped.y, Is.EqualTo(3f).Within(0.0001f));
            Assert.That(clamped.z, Is.EqualTo(14f).Within(0.0001f));
        }

        [UnityTest]
        public IEnumerator SceneLoaderTargets_AreAvailableInRuntimeBuildSettings()
        {
            yield return null;

            var scenes = new[]
            {
                GameScene.Bootstrap,
                GameScene.Title,
                GameScene.Lobby,
                GameScene.Battle,
                GameScene.Result,
            };

            foreach (var scene in scenes)
            {
                var sceneName = SceneLoader.ToSceneName(scene);
                Assert.That(
                    Application.CanStreamedLevelBeLoaded(sceneName),
                    Is.True,
                    $"Expected '{sceneName}' to be enabled in Build Settings.");
            }
        }

        [UnityTest]
        public IEnumerator ExplorationTimer_ExpiresAsSuccessfulReturn()
        {
            controllerObject = new GameObject("Battle Timer PlayMode Test");
            var controller = controllerObject.AddComponent<BattleSceneController>();
            controller.ConfigureResolvedReturnDelay(30f);
            yield return null;
            controller.ConfigureExplorationTimer(0.05f, 0.025f);

            yield return new WaitUntil(() => controller.IsBattleResolved);

            Assert.That(controller.WasVictory, Is.True);
            Assert.That(controller.ResolutionReason, Is.EqualTo(BattleResolutionReason.TimeExpired));
            Assert.That(controller.ExplorationTimeRemaining, Is.EqualTo(0f).Within(0.001f));
        }

        [UnityTest]
        public IEnumerator ManualExtraction_RequiresHoldAndPreservesSuccessfulReturn()
        {
            controllerObject = new GameObject("Manual Extraction PlayMode Test");
            var controller = controllerObject.AddComponent<BattleSceneController>();
            controller.DisableExplorationTimer();
            controller.ConfigureManualExtraction(0.05f);
            controller.ConfigureResolvedReturnDelay(30f);
            controller.SetManualExtractionHeld(true);

            yield return new WaitUntil(() => controller.IsBattleResolved);

            Assert.That(controller.WasVictory, Is.True);
            Assert.That(controller.ResolutionReason, Is.EqualTo(BattleResolutionReason.ManualExtraction));
            Assert.That(controller.ManualExtractionProgress, Is.EqualTo(1f).Within(0.001f));
        }
    }
}
