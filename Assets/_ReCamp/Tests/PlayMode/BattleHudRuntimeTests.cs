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

            var safeAreaObject = GameObject.Find("BattleHUD_Runtime/SafeArea");
            var joystick = GameObject.Find("BattleHUD_Runtime/SafeArea/MoveJoystick");
            var attackButtonObject = GameObject.Find("BattleHUD_Runtime/SafeArea/AttackTouchButton");
            var signatureButtonObject = GameObject.Find("BattleHUD_Runtime/SafeArea/SignatureTouchButton");
            var utilityButtonObject = GameObject.Find("BattleHUD_Runtime/SafeArea/UtilityTouchButton");
            var returnButtonObject = GameObject.Find("BattleHUD_Runtime/SafeArea/ReturnToCampButton");

            Assert.That(safeAreaObject, Is.Not.Null);
            Assert.That(joystick, Is.Not.Null);
            Assert.That(joystick.GetComponent<VirtualJoystick>(), Is.Not.Null);
            Assert.That(attackButtonObject, Is.Not.Null);
            Assert.That(signatureButtonObject, Is.Not.Null);
            Assert.That(utilityButtonObject, Is.Not.Null);
            Assert.That(returnButtonObject, Is.Not.Null);

            Assert.That(joystick.transform.IsChildOf(safeAreaObject.transform), Is.True);
            Assert.That(attackButtonObject.transform.IsChildOf(safeAreaObject.transform), Is.True);
            Assert.That(signatureButtonObject.transform.IsChildOf(safeAreaObject.transform), Is.True);
            Assert.That(utilityButtonObject.transform.IsChildOf(safeAreaObject.transform), Is.True);
            Assert.That(returnButtonObject.transform.IsChildOf(safeAreaObject.transform), Is.True);

            var safeAreaTransform = safeAreaObject.GetComponent<RectTransform>();
            Assert.That(Screen.width, Is.GreaterThan(0));
            Assert.That(Screen.height, Is.GreaterThan(0));
            var screenSafeArea = Screen.safeArea;
            var expectedMin = new Vector2(screenSafeArea.xMin / Screen.width, screenSafeArea.yMin / Screen.height);
            var expectedMax = new Vector2(screenSafeArea.xMax / Screen.width, screenSafeArea.yMax / Screen.height);
            Assert.That(safeAreaTransform.anchorMin.x, Is.EqualTo(expectedMin.x).Within(0.001f));
            Assert.That(safeAreaTransform.anchorMin.y, Is.EqualTo(expectedMin.y).Within(0.001f));
            Assert.That(safeAreaTransform.anchorMax.x, Is.EqualTo(expectedMax.x).Within(0.001f));
            Assert.That(safeAreaTransform.anchorMax.y, Is.EqualTo(expectedMax.y).Within(0.001f));

            var returnButton = returnButtonObject.GetComponent<TouchHoldButton>();
            Assert.That(returnButton, Is.Not.Null);

            var pointer = new PointerEventData(EventSystem.current) { pointerId = 31 };
            returnButton.OnPointerDown(pointer);
            Assert.That(BattleInputRouter.Instance.IsExtractionHeld, Is.True);

            returnButton.OnPointerUp(pointer);
            Assert.That(BattleInputRouter.Instance.IsExtractionHeld, Is.False);
        }
    }
}
