using System.Collections;
using NUnit.Framework;
using ReCamp.Input;
using ReCamp.GameFlow;
using ReCamp.UI;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.TestTools;

namespace ReCamp.Tests.PlayMode
{
    public sealed class BattleHudRuntimeTests
    {
        private GameObject battleObject;

        [UnityTearDown]
        public IEnumerator TearDown()
        {
            if (battleObject != null)
            {
                Object.Destroy(battleObject);
                battleObject = null;
            }

            var hudRoot = GameObject.Find("BattleHUD_Runtime");
            if (hudRoot != null)
            {
                Object.Destroy(hudRoot);
            }

            yield return null;
        }

        [UnityTest]
        public IEnumerator BattleHud_CreatesSafeTouchControlsThatEmitExtractionCommand()
        {
            battleObject = new GameObject("BattleHudTestBattle");
            battleObject.AddComponent<BattleSceneController>();
            battleObject.AddComponent<BattleHudController>();
            yield return null;
            var joystick = GameObject.Find("BattleHUD_Runtime/SafeArea/MoveJoystick");
            var attackButton = GameObject.Find("BattleHUD_Runtime/SafeArea/AttackTouchButton")
                ?.GetComponent<TouchHoldButton>();
            var returnButton = GameObject.Find("BattleHUD_Runtime/SafeArea/ReturnToCampButton")
                ?.GetComponent<TouchHoldButton>();
            Assert.That(joystick, Is.Not.Null);
            Assert.That(joystick.GetComponent<VirtualJoystick>(), Is.Not.Null);
            Assert.That(attackButton, Is.Not.Null);
            Assert.That(returnButton, Is.Not.Null);

            returnButton.OnPointerDown(new PointerEventData(EventSystem.current));
            Assert.That(BattleInputRouter.Instance.IsExtractionHeld, Is.True);

            returnButton.OnPointerUp(new PointerEventData(EventSystem.current));
            Assert.That(BattleInputRouter.Instance.IsExtractionHeld, Is.False);
        }
    }
}
