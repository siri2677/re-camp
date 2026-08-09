using System.Collections;
using System.Collections.Generic;
using NUnit.Framework;
using ReCamp.Camp;
using ReCamp.GameFlow;
using ReCamp.Item;
using ReCamp.Runtime;
using ReCamp.Save;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.TestTools;

namespace ReCamp.Tests.PlayMode
{
    public sealed class SceneSettlementRuntimeTests
    {
        private const string LegacyCampSaveKey = "ReCamp.CampSave.v1";
        private const string CampSaveKey = "ReCamp.CampSave.v2";

        private bool hadOriginalLegacySave;
        private bool hadOriginalCurrentSave;
        private string originalLegacySave;
        private string originalCurrentSave;

        [UnitySetUp]
        public IEnumerator SetUp()
        {
            hadOriginalLegacySave = PlayerPrefs.HasKey(LegacyCampSaveKey);
            originalLegacySave = hadOriginalLegacySave ? PlayerPrefs.GetString(LegacyCampSaveKey) : null;
            hadOriginalCurrentSave = PlayerPrefs.HasKey(CampSaveKey);
            originalCurrentSave = hadOriginalCurrentSave ? PlayerPrefs.GetString(CampSaveKey) : null;

            DestroyPersistentManagers();
            yield return null;

            PlayerPrefs.DeleteKey(LegacyCampSaveKey);
            PlayerPrefs.SetString(CampSaveKey, JsonUtility.ToJson(new CampSaveData()));
            PlayerPrefs.Save();

            yield return SceneManager.LoadSceneAsync(SceneLoader.ToSceneName(GameScene.Bootstrap));
            yield return new WaitUntil(() =>
                SceneManager.GetActiveScene().name == SceneLoader.ToSceneName(GameScene.Lobby) &&
                GameManager.Instance != null);
        }

        [UnityTearDown]
        public IEnumerator TearDown()
        {
            DestroyPersistentManagers();
            yield return null;

            if (hadOriginalLegacySave)
            {
                PlayerPrefs.SetString(LegacyCampSaveKey, originalLegacySave);
            }
            else
            {
                PlayerPrefs.DeleteKey(LegacyCampSaveKey);
            }

            if (hadOriginalCurrentSave)
            {
                PlayerPrefs.SetString(CampSaveKey, originalCurrentSave);
            }
            else
            {
                PlayerPrefs.DeleteKey(CampSaveKey);
            }

            PlayerPrefs.Save();
        }

        [UnityTest]
        public IEnumerator BootstrapToBattleToResultToLobby_SettlesExtractedRewardsOnce()
        {
            var manager = GameManager.Instance;
            Assert.That(manager, Is.Not.Null);
            Assert.That(SceneManager.GetActiveScene().name, Is.EqualTo(SceneLoader.ToSceneName(GameScene.Lobby)));

            manager.StartRun();
            yield return new WaitUntil(() =>
                SceneManager.GetActiveScene().name == SceneLoader.ToSceneName(GameScene.Battle));

            var battle = Object.FindAnyObjectByType<BattleSceneController>();
            Assert.That(battle, Is.Not.Null);

            battle.CollectResource(ResourceType.Scrap, 4);
            battle.CollectResource(ResourceType.Food, 2);
            battle.CollectResource(ResourceType.DataFragment, 1);
            battle.ConfigureResolvedReturnDelay(0.05f);
            battle.ResolveVictory();

            yield return new WaitUntil(() =>
                SceneManager.GetActiveScene().name == SceneLoader.ToSceneName(GameScene.Result));

            var resultScene = Object.FindAnyObjectByType<ResultSceneController>();
            Assert.That(resultScene, Is.Not.Null);
            Assert.That(manager.CurrentRunState, Is.EqualTo(RunState.Result));
            Assert.That(manager.HasActiveRun, Is.False);
            Assert.That(manager.LastRunOutcome, Is.EqualTo(ReCamp.Domain.RunOutcome.Extracted));
            Assert.That(manager.LastRunResourceCount, Is.EqualTo(7));
            Assert.That(manager.LastRunRewards.Scrap, Is.EqualTo(4));
            Assert.That(manager.LastRunRewards.Food, Is.EqualTo(2));
            Assert.That(manager.LastRunRewards.DataFragments, Is.EqualTo(1));
            Assert.That(resultScene.LastCollectedResources, Is.EqualTo(7));
            Assert.That(resultScene.LastRewards.Scrap, Is.EqualTo(4));
            Assert.That(CampManager.Instance.Inventory.Scrap, Is.EqualTo(4));
            Assert.That(CampManager.Instance.Inventory.Food, Is.EqualTo(2));
            Assert.That(CampManager.Instance.Inventory.DataFragments, Is.EqualTo(1));

            resultScene.ReturnToLobby();
            yield return new WaitUntil(() =>
                SceneManager.GetActiveScene().name == SceneLoader.ToSceneName(GameScene.Lobby));

            Assert.That(manager.CurrentRunState, Is.EqualTo(RunState.Lobby));
            Assert.That(manager.HasActiveRun, Is.False);
        }

        private static void DestroyPersistentManagers()
        {
            var objects = new HashSet<GameObject>();
            foreach (var manager in Object.FindObjectsByType<GameManager>(
                         FindObjectsInactive.Include,
                         FindObjectsSortMode.None))
            {
                objects.Add(manager.gameObject);
            }

            foreach (var camp in Object.FindObjectsByType<CampManager>(
                         FindObjectsInactive.Include,
                         FindObjectsSortMode.None))
            {
                objects.Add(camp.gameObject);
            }

            foreach (var gameObject in objects)
            {
                Object.Destroy(gameObject);
            }
        }
    }
}
