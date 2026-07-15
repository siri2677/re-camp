using System.Collections;
using NUnit.Framework;
using ReCamp.Camp;
using ReCamp.Item;
using ReCamp.Save;
using UnityEngine;
using UnityEngine.TestTools;

namespace ReCamp.Tests.PlayMode
{
    public sealed class CampRewardPersistenceRuntimeTests
    {
        private const string CampSaveKey = "ReCamp.CampSave.v1";

        private GameObject campObject;
        private bool hadOriginalSave;
        private string originalSave;

        [UnitySetUp]
        public IEnumerator SetUp()
        {
            hadOriginalSave = PlayerPrefs.HasKey(CampSaveKey);
            originalSave = hadOriginalSave ? PlayerPrefs.GetString(CampSaveKey) : null;

            foreach (var camp in Object.FindObjectsByType<CampManager>(
                         FindObjectsInactive.Include,
                         FindObjectsSortMode.None))
            {
                Object.Destroy(camp.gameObject);
            }

            yield return null;

            var seed = new CampSaveData
            {
                scrap = 1,
                food = 2,
                dataFragments = 3,
                generatorLevel = 2,
                workbenchLevel = 1,
                foodStorageLevel = 1,
            };
            PlayerPrefs.SetString(CampSaveKey, JsonUtility.ToJson(seed));
            PlayerPrefs.Save();
        }

        [UnityTearDown]
        public IEnumerator TearDown()
        {
            if (campObject != null)
            {
                Object.Destroy(campObject);
                campObject = null;
                yield return null;
            }

            if (hadOriginalSave)
            {
                PlayerPrefs.SetString(CampSaveKey, originalSave);
            }
            else
            {
                PlayerPrefs.DeleteKey(CampSaveKey);
            }

            PlayerPrefs.Save();
        }

        [UnityTest]
        public IEnumerator Deposit_PreservesRewardsAndGeneratorGrantsExplorationTime()
        {
            campObject = new GameObject("Camp Reward Persistence Test");
            var camp = campObject.AddComponent<CampManager>();
            yield return null;

            var rewards = new ResourceLedger();
            rewards.Add(ResourceType.Scrap, 5);
            rewards.Add(ResourceType.Food, 4);
            rewards.Add(ResourceType.DataFragment, 1);

            camp.Deposit(rewards);

            Assert.That(camp.ExplorationTimeBonusSeconds, Is.EqualTo(60f).Within(0.0001f));
            Assert.That(camp.Inventory.Scrap, Is.EqualTo(6));
            Assert.That(camp.Inventory.Food, Is.EqualTo(6));
            Assert.That(camp.Inventory.DataFragments, Is.EqualTo(4));
            Assert.That(rewards.Scrap, Is.EqualTo(5), "Settlement must not mutate the run reward ledger.");
            Assert.That(rewards.Food, Is.EqualTo(4));
            Assert.That(rewards.DataFragments, Is.EqualTo(1));

            var persisted = SaveManager.LoadCamp();
            Assert.That(persisted.scrap, Is.EqualTo(6));
            Assert.That(persisted.food, Is.EqualTo(6));
            Assert.That(persisted.dataFragments, Is.EqualTo(4));
            Assert.That(persisted.generatorLevel, Is.EqualTo(2));
            Assert.That(persisted.workbenchLevel, Is.EqualTo(1));
            Assert.That(persisted.foodStorageLevel, Is.EqualTo(1));
        }
    }
}
