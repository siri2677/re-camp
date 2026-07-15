using System.Collections;
using System.Collections.Generic;
using NUnit.Framework;
using ReCamp.Camp;
using ReCamp.Core;
using ReCamp.Data;
using UnityEngine;
using UnityEngine.TestTools;

namespace ReCamp.Tests.PlayMode
{
    public sealed class GameManagerSelectionRuntimeTests
    {
        private GameObject managerObject;

        [UnitySetUp]
        public IEnumerator SetUp()
        {
            var managerObjects = new HashSet<GameObject>();
            foreach (var manager in Object.FindObjectsByType<GameManager>(
                         FindObjectsInactive.Include,
                         FindObjectsSortMode.None))
            {
                managerObjects.Add(manager.gameObject);
            }

            foreach (var camp in Object.FindObjectsByType<CampManager>(
                         FindObjectsInactive.Include,
                         FindObjectsSortMode.None))
            {
                managerObjects.Add(camp.gameObject);
            }

            foreach (var existingObject in managerObjects)
            {
                Object.Destroy(existingObject);
            }

            if (managerObjects.Count > 0)
            {
                yield return null;
            }

            managerObject = new GameObject("Game Manager Selection Test");
            managerObject.AddComponent<GameManager>();
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
        public IEnumerator SelectCharacter_NotifiesOnlyForARealValidChange()
        {
            var manager = GameManager.Instance;
            var notifications = new List<CharacterDefinition>();
            manager.SelectedCharacterChanged += notifications.Add;

            Assert.That(manager.SelectCharacter(CharacterId.Iris), Is.True);
            Assert.That(manager.SelectedCharacterId, Is.EqualTo(CharacterId.Iris));
            Assert.That(manager.SelectedCharacter, Is.SameAs(CharacterRoster.Get(CharacterId.Iris)));
            Assert.That(notifications, Has.Count.EqualTo(1));
            Assert.That(notifications[0], Is.SameAs(manager.SelectedCharacter));

            Assert.That(manager.SelectCharacter(CharacterId.Iris), Is.True);
            Assert.That(manager.SelectCharacter((CharacterId)999), Is.False);

            Assert.That(manager.SelectedCharacterId, Is.EqualTo(CharacterId.Iris));
            Assert.That(notifications, Has.Count.EqualTo(1));
            yield return null;
        }

        [UnityTest]
        public IEnumerator PreviousAndNextSelection_WrapAcrossRosterEnds()
        {
            var manager = GameManager.Instance;
            var notifiedIds = new List<CharacterId>();
            manager.SelectedCharacterChanged += definition => notifiedIds.Add(definition.Id);

            var previous = manager.SelectPreviousCharacter();
            var next = manager.SelectNextCharacter();

            Assert.That(previous.Id, Is.EqualTo(CharacterId.Noah));
            Assert.That(next.Id, Is.EqualTo(CharacterId.Luna));
            Assert.That(manager.SelectedCharacterId, Is.EqualTo(CharacterId.Luna));
            Assert.That(notifiedIds, Is.EqualTo(new[] { CharacterId.Noah, CharacterId.Luna }));
            yield return null;
        }
    }
}
