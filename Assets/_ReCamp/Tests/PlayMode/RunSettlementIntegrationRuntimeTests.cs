using System.Collections;
using NUnit.Framework;
using ReCamp.GameFlow;
using ReCamp.Item;
using ReCamp.Runtime;
using UnityEngine;
using UnityEngine.TestTools;

namespace ReCamp.Tests.PlayMode
{
    public sealed class RunSettlementIntegrationRuntimeTests
    {
        private GameObject managerObject;

        [UnitySetUp]
        public IEnumerator SetUp()
        {
            foreach (var manager in Object.FindObjectsByType<GameManager>(
                         FindObjectsInactive.Include,
                         FindObjectsSortMode.None))
            {
                Object.Destroy(manager.gameObject);
            }

            yield return null;

            managerObject = new GameObject("Run Settlement Integration Manager");
            managerObject.AddComponent<GameManager>();
            yield return null;
        }

        [UnityTearDown]
        public IEnumerator TearDown()
        {
            if (managerObject != null)
            {
                Object.Destroy(managerObject);
                managerObject = null;
            }

            yield return null;
        }

        [UnityTest]
        public IEnumerator RunFlow_ResolvesOnceAndPreservesExpiredRewards()
        {
            var manager = GameManager.Instance;
            manager.StartRun();
            yield return null;

            var runId = manager.CurrentRunId;
            manager.AddRunReward(ResourceType.Scrap, 5);
            manager.AddRunReward(ResourceType.Food, 2);
            manager.AddRunReward(ResourceType.DataFragment, 1);

            var eventCount = 0;
            manager.RunResolved += _ => eventCount++;
            var settlement = manager.ResolveRun(BattleResolutionReason.TimeExpired);

            Assert.That(settlement, Is.Not.Null);
            Assert.That(settlement.RunId, Is.EqualTo(runId));
            Assert.That(settlement.Outcome, Is.EqualTo(ReCamp.Domain.RunOutcome.Expired));
            Assert.That(manager.LastRunRewards.Scrap, Is.EqualTo(5));
            Assert.That(manager.LastRunRewards.Food, Is.EqualTo(2));
            Assert.That(manager.LastRunRewards.DataFragments, Is.EqualTo(1));
            Assert.That(eventCount, Is.EqualTo(1));
            Assert.That(manager.HasActiveRun, Is.False);

            var duplicate = manager.ResolveRun(BattleResolutionReason.Defeat);
            Assert.That(duplicate, Is.Null);
            Assert.That(eventCount, Is.EqualTo(1));
            Assert.That(manager.LastSettledRunId, Is.EqualTo(runId));
        }
    }
}
