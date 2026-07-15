using ReCamp.Enemy;
using ReCamp.GameFlow;
using ReCamp.Item;
using ReCamp.Player;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem.UI;
using UnityEngine.UI;

namespace ReCamp.UI
{
    /// <summary>Creates and owns the responsive runtime HUD used by the battle scene.</summary>
    [DisallowMultipleComponent]
    public sealed class BattleHudController : MonoBehaviour
    {
        private static readonly Color Charcoal = new Color32(20, 29, 33, 242);
        private static readonly Color CharcoalSoft = new Color32(31, 43, 47, 228);
        private static readonly Color Mint = new Color32(105, 229, 190, 255);
        private static readonly Color Salmon = new Color32(244, 139, 127, 255);
        private static readonly Color Cream = new Color32(238, 244, 239, 255);
        private static readonly Color Muted = new Color32(170, 193, 185, 255);
        private static readonly Color BarBackground = new Color32(7, 13, 15, 235);

        private const float RefreshInterval = 0.1f;

        private BattleSceneController battle;
        private PlayerStats playerStats;
        private GameObject hudRoot;
        private GameObject createdEventSystem;
        private InputSystemUIInputModule createdInputModule;
        private RectTransform safeAreaRoot;
        private RectTransform healthFill;
        private Text healthText;
        private Text resourcesText;
        private Text characterText;
        private Text abilityText;
        private Text utilityText;
        private Text battleStateText;
        private Text hostilesText;
        private Text timerText;
        private Button returnButton;
        private Font uiFont;
        private float nextRefreshTime;
        private Rect lastSafeArea;
        private Vector2Int lastScreenSize;

        private void Awake()
        {
            battle = GetComponent<BattleSceneController>();
            if (battle == null)
            {
                battle = FindAnyObjectByType<BattleSceneController>();
            }

            BuildHud();
            EnsureEventSystem();
            RefreshSafeArea(true);
            RefreshHud();
        }

        private void Update()
        {
            RefreshSafeArea(false);
            if (Time.unscaledTime < nextRefreshTime)
            {
                return;
            }

            nextRefreshTime = Time.unscaledTime + RefreshInterval;
            RefreshHud();
        }

        private void OnDestroy()
        {
            if (returnButton != null)
            {
                returnButton.onClick.RemoveListener(ReturnToCamp);
            }

            if (createdInputModule != null)
            {
                createdInputModule.UnassignActions();
            }

            DestroyOwnedObject(hudRoot);
            DestroyOwnedObject(createdEventSystem);
        }

        private void BuildHud()
        {
            uiFont = CreateUiFont();

            hudRoot = new GameObject("BattleHUD_Runtime", typeof(RectTransform), typeof(Canvas),
                typeof(CanvasScaler), typeof(GraphicRaycaster));
            var rootTransform = (RectTransform)hudRoot.transform;
            var canvas = hudRoot.GetComponent<Canvas>();
            canvas.renderMode = RenderMode.ScreenSpaceOverlay;
            canvas.sortingOrder = 100;

            var scaler = hudRoot.GetComponent<CanvasScaler>();
            scaler.uiScaleMode = CanvasScaler.ScaleMode.ScaleWithScreenSize;
            scaler.referenceResolution = new Vector2(1920f, 1080f);
            scaler.screenMatchMode = CanvasScaler.ScreenMatchMode.MatchWidthOrHeight;
            scaler.matchWidthOrHeight = 0.5f;

            rootTransform.anchorMin = Vector2.zero;
            rootTransform.anchorMax = Vector2.one;
            rootTransform.offsetMin = Vector2.zero;
            rootTransform.offsetMax = Vector2.zero;

            safeAreaRoot = CreateRect("SafeArea", rootTransform);
            safeAreaRoot.offsetMin = Vector2.zero;
            safeAreaRoot.offsetMax = Vector2.zero;

            BuildVitalsPanel();
            BuildBattleStatusPanel();
            BuildReturnButton();
            BuildControlHint();
        }

        private void BuildVitalsPanel()
        {
            var panel = CreatePanel("VitalsPanel", safeAreaRoot, Charcoal);
            SetRect(panel, new Vector2(0f, 1f), new Vector2(0f, 1f), new Vector2(0f, 1f),
                new Vector2(32f, -32f), new Vector2(470f, 274f));

            CreateText("VitalsTitle", panel, "생존 상태", 22, FontStyle.Bold, Mint,
                TextAnchor.MiddleLeft, new Vector2(20f, -14f), new Vector2(430f, 30f));

            var bar = CreatePanel("HealthBar", panel, BarBackground);
            SetTopLeftRect(bar, new Vector2(20f, -53f), new Vector2(430f, 31f));

            healthFill = CreatePanel("HealthFill", bar, Mint);
            healthFill.anchorMin = Vector2.zero;
            healthFill.anchorMax = Vector2.one;
            healthFill.pivot = new Vector2(0f, 0.5f);
            healthFill.offsetMin = new Vector2(3f, 3f);
            healthFill.offsetMax = new Vector2(-3f, -3f);

            healthText = CreateStretchText("HealthValue", bar, "HP  -- / --", 17,
                FontStyle.Bold, Cream, TextAnchor.MiddleCenter, new Vector2(8f, 0f), new Vector2(-8f, 0f));

            resourcesText = CreateText("Resources", panel,
                "회수  00    SCRAP 0  ·  FOOD 0  ·  DATA 0", 17, FontStyle.Normal, Cream,
                TextAnchor.MiddleLeft, new Vector2(20f, -92f), new Vector2(430f, 30f));

            characterText = CreateText("Character", panel, "루나 · 정찰형 근접 딜러", 16,
                FontStyle.Bold, Cream, TextAnchor.MiddleLeft,
                new Vector2(20f, -126f), new Vector2(430f, 28f));
            abilityText = CreateText("Ability", panel, "[SPACE] 캣 스텝  ·  준비", 16,
                FontStyle.Bold, Mint, TextAnchor.MiddleLeft,
                new Vector2(20f, -158f), new Vector2(430f, 38f));
            utilityText = CreateText("UtilityAbility", panel, "[E] 스캔 펄스  ·  준비", 15,
                FontStyle.Bold, Mint, TextAnchor.MiddleLeft,
                new Vector2(20f, -198f), new Vector2(430f, 58f));
        }

        private void BuildBattleStatusPanel()
        {
            var panel = CreatePanel("BattleStatusPanel", safeAreaRoot, CharcoalSoft);
            SetRect(panel, new Vector2(0.5f, 1f), new Vector2(0.5f, 1f), new Vector2(0.5f, 1f),
                new Vector2(0f, -32f), new Vector2(440f, 146f));

            battleStateText = CreateStretchText("BattleState", panel, "지역 탐색 중", 24,
                FontStyle.Bold, Salmon, TextAnchor.MiddleCenter, new Vector2(18f, 100f), new Vector2(-18f, -8f));
            hostilesText = CreateStretchText("Hostiles", panel, "잔여 적  00", 18,
                FontStyle.Normal, Cream, TextAnchor.MiddleCenter, new Vector2(18f, 55f), new Vector2(-18f, -52f));
            timerText = CreateStretchText("ExplorationTimer", panel, "탐색  05:00", 18,
                FontStyle.Bold, Cream, TextAnchor.MiddleCenter, new Vector2(18f, 10f), new Vector2(-18f, -97f));
        }

        private void BuildReturnButton()
        {
            var buttonRect = CreateRect("ReturnToCampButton", safeAreaRoot);
            SetRect(buttonRect, new Vector2(1f, 1f), new Vector2(1f, 1f), new Vector2(1f, 1f),
                new Vector2(-32f, -32f), new Vector2(250f, 62f));

            var buttonImage = buttonRect.gameObject.AddComponent<Image>();
            buttonImage.color = Salmon;

            returnButton = buttonRect.gameObject.AddComponent<Button>();
            returnButton.targetGraphic = buttonImage;
            returnButton.transition = Selectable.Transition.ColorTint;
            returnButton.colors = new ColorBlock
            {
                normalColor = Color.white,
                highlightedColor = new Color(1f, 1f, 1f, 0.9f),
                pressedColor = new Color(0.78f, 0.78f, 0.78f, 1f),
                selectedColor = Color.white,
                disabledColor = new Color(0.45f, 0.45f, 0.45f, 0.65f),
                colorMultiplier = 1f,
                fadeDuration = 0.08f,
            };
            returnButton.interactable = battle != null;
            returnButton.onClick.AddListener(ReturnToCamp);

            var outline = buttonRect.gameObject.AddComponent<Outline>();
            outline.effectColor = new Color32(10, 18, 21, 160);
            outline.effectDistance = new Vector2(3f, -3f);

            CreateStretchText("Label", buttonRect, "캠프로 귀환", 20, FontStyle.Bold, Charcoal,
                TextAnchor.MiddleCenter, new Vector2(12f, 6f), new Vector2(-12f, -6f));
        }

        private void BuildControlHint()
        {
            var panel = CreatePanel("ControlHintPanel", safeAreaRoot, CharcoalSoft);
            SetRect(panel, new Vector2(0.5f, 0f), new Vector2(0.5f, 0f), new Vector2(0.5f, 0f),
                new Vector2(0f, 30f), new Vector2(980f, 62f));

            CreateStretchText("ControlHint", panel,
                "WASD / 방향키 이동  ·  자동 공격  ·  SPACE 대표 능력(이리스 홀드)  ·  E 역할 능력  ·  R 홀드 귀환",
                17, FontStyle.Normal, Muted, TextAnchor.MiddleCenter,
                new Vector2(22f, 6f), new Vector2(-22f, -6f));
        }

        private void RefreshHud()
        {
            if (battle == null)
            {
                battle = FindAnyObjectByType<BattleSceneController>();
                if (returnButton != null)
                {
                    returnButton.interactable = battle != null;
                }
            }

            if (playerStats == null)
            {
                playerStats = FindAnyObjectByType<PlayerStats>();
            }

            var health = playerStats == null ? null : playerStats.Health;
            var healthRatio = health == null ? 0f : Mathf.Clamp01((float)health.CurrentHealth / health.MaxHealth);
            if (healthFill != null)
            {
                healthFill.gameObject.SetActive(healthRatio > 0f);
                healthFill.anchorMax = new Vector2(healthRatio, 1f);
            }

            if (healthText != null)
            {
                healthText.text = health == null
                    ? "HP  -- / --"
                    : health.ShieldPoints > 0
                        ? $"HP  {health.CurrentHealth} / {health.MaxHealth}  +  SHIELD {health.ShieldPoints}"
                        : $"HP  {health.CurrentHealth} / {health.MaxHealth}";
            }

            var character = playerStats == null ? null : playerStats.Character;
            if (characterText != null)
            {
                characterText.text = character == null
                    ? "캐릭터 정보 불러오는 중"
                    : $"{character.DisplayName} · {character.Role}";
            }

            if (abilityText != null)
            {
                var ability = playerStats == null ? null : playerStats.Ability;
                if (ability == null)
                {
                    abilityText.text = "[SPACE] 대표 능력 불러오는 중";
                    abilityText.color = Muted;
                }
                else if (ability.IsCharging)
                {
                    abilityText.text = $"[SPACE 놓기] {ability.AbilityName}  ·  차지 {ability.ChargeRatio * 100f:0}%";
                    abilityText.color = Salmon;
                }
                else if (ability.IsReady)
                {
                    abilityText.text = $"[SPACE] {ability.AbilityName}  ·  준비";
                    abilityText.color = Mint;
                }
                else
                {
                    abilityText.text = $"[SPACE] {ability.AbilityName}  ·  재사용 {ability.CooldownRemaining:0.0}s";
                    abilityText.color = Muted;
                }
            }

            if (utilityText != null)
            {
                var ability = playerStats == null ? null : playerStats.Ability;
                if (ability == null)
                {
                    utilityText.text = "[E] 역할 능력 불러오는 중";
                    utilityText.color = Muted;
                }
                else if (ability.IsUtilityReady)
                {
                    utilityText.text = $"[E] {ability.UtilityAbilityName}  ·  준비  ·  {ability.RoleStatusText}";
                    utilityText.color = Mint;
                }
                else
                {
                    utilityText.text = $"[E] {ability.UtilityAbilityName}  ·  {ability.UtilityCooldownRemaining:0.0}s  ·  {ability.RoleStatusText}";
                    utilityText.color = Muted;
                }
            }

            if (resourcesText != null)
            {
                var rewards = battle == null ? null : battle.CollectedRewards;
                var total = battle == null ? 0 : battle.CollectedResources;
                resourcesText.text = rewards == null
                    ? $"회수  {total:00}"
                    : $"회수  {total:00}    SCRAP {rewards.Scrap}  ·  FOOD {rewards.Food}  ·  DATA {rewards.DataFragments}";
            }

            var activeHostiles = EnemyController.ActiveCount;
            if (battleStateText != null)
            {
                if (battle != null && battle.IsBattleResolved)
                {
                    battleStateText.text = battle.WasVictory ? "지역 확보 완료" : "작전 실패";
                    battleStateText.color = battle.WasVictory ? Mint : Salmon;
                }
                else
                {
                    battleStateText.text = activeHostiles > 0 ? "교전 진행 중" : "지역 탐색 중";
                    battleStateText.color = activeHostiles > 0 ? Salmon : Mint;
                }
            }

            if (hostilesText != null)
            {
                hostilesText.text = battle != null && battle.IsBattleResolved
                    ? $"결과 화면 이동  {Mathf.CeilToInt(battle.ReturnCountdown)}"
                    : $"잔여 적  {activeHostiles:00}";
            }

            if (timerText != null)
            {
                if (battle == null)
                {
                    timerText.text = "탐색  --:--";
                    timerText.color = Muted;
                }
                else if (battle.IsBattleResolved)
                {
                    timerText.text = $"종료 사유  ·  {GetResolutionReasonLabel(battle.ResolutionReason)}";
                    timerText.color = battle.WasVictory ? Mint : Salmon;
                }
                else if (battle.IsManualExtractionCharging)
                {
                    timerText.text = $"[R HOLD] EXTRACT  {battle.ManualExtractionProgress * 100f:0}%";
                    timerText.color = Salmon;
                }
                else if (float.IsPositiveInfinity(battle.ExplorationTimeRemaining))
                {
                    timerText.text = "탐색 제한 없음  ·  [R HOLD] EXTRACT";
                    timerText.color = Cream;
                }
                else
                {
                    timerText.text = $"탐색 {FormatTime(battle.ExplorationTimeRemaining)}  ·  [R HOLD] EXTRACT";
                    timerText.color = battle.IsTimeWarning ? Salmon : Cream;
                }
            }

            if (returnButton != null)
            {
                returnButton.interactable = battle != null && !battle.IsBattleResolved;
            }
        }

        private void RefreshSafeArea(bool force)
        {
            if (safeAreaRoot == null || Screen.width <= 0 || Screen.height <= 0)
            {
                return;
            }

            var safeArea = Screen.safeArea;
            var screenSize = new Vector2Int(Screen.width, Screen.height);
            if (!force && safeArea == lastSafeArea && screenSize == lastScreenSize)
            {
                return;
            }

            lastSafeArea = safeArea;
            lastScreenSize = screenSize;
            safeAreaRoot.anchorMin = new Vector2(safeArea.xMin / Screen.width, safeArea.yMin / Screen.height);
            safeAreaRoot.anchorMax = new Vector2(safeArea.xMax / Screen.width, safeArea.yMax / Screen.height);
        }

        private void EnsureEventSystem()
        {
            if (EventSystem.current != null)
            {
                return;
            }

            createdEventSystem = new GameObject("BattleHUD_EventSystem", typeof(EventSystem));
            createdInputModule = createdEventSystem.AddComponent<InputSystemUIInputModule>();
        }

        private void ReturnToCamp()
        {
            if (battle == null)
            {
                battle = FindAnyObjectByType<BattleSceneController>();
            }

            battle?.ResolveManualExtraction();
        }

        private RectTransform CreatePanel(string objectName, Transform parent, Color color)
        {
            var rect = CreateRect(objectName, parent);
            var image = rect.gameObject.AddComponent<Image>();
            image.color = color;
            image.raycastTarget = false;

            var outline = rect.gameObject.AddComponent<Outline>();
            outline.effectColor = new Color32(100, 229, 190, 50);
            outline.effectDistance = new Vector2(1f, -1f);
            return rect;
        }

        private Text CreateText(
            string objectName,
            Transform parent,
            string content,
            int fontSize,
            FontStyle fontStyle,
            Color color,
            TextAnchor alignment,
            Vector2 topLeftPosition,
            Vector2 size)
        {
            var rect = CreateRect(objectName, parent);
            SetTopLeftRect(rect, topLeftPosition, size);
            return ConfigureText(rect.gameObject.AddComponent<Text>(), content, fontSize, fontStyle, color, alignment);
        }

        private Text CreateStretchText(
            string objectName,
            Transform parent,
            string content,
            int fontSize,
            FontStyle fontStyle,
            Color color,
            TextAnchor alignment,
            Vector2 offsetMin,
            Vector2 offsetMax)
        {
            var rect = CreateRect(objectName, parent);
            rect.anchorMin = Vector2.zero;
            rect.anchorMax = Vector2.one;
            rect.offsetMin = offsetMin;
            rect.offsetMax = offsetMax;
            return ConfigureText(rect.gameObject.AddComponent<Text>(), content, fontSize, fontStyle, color, alignment);
        }

        private Text ConfigureText(
            Text text,
            string content,
            int fontSize,
            FontStyle fontStyle,
            Color color,
            TextAnchor alignment)
        {
            text.font = uiFont;
            text.text = content;
            text.fontSize = fontSize;
            text.fontStyle = fontStyle;
            text.color = color;
            text.alignment = alignment;
            text.horizontalOverflow = HorizontalWrapMode.Wrap;
            text.verticalOverflow = VerticalWrapMode.Truncate;
            text.raycastTarget = false;
            return text;
        }

        private static RectTransform CreateRect(string objectName, Transform parent)
        {
            var child = new GameObject(objectName, typeof(RectTransform));
            var rect = (RectTransform)child.transform;
            rect.SetParent(parent, false);
            return rect;
        }

        private static void SetTopLeftRect(RectTransform rect, Vector2 position, Vector2 size)
        {
            SetRect(rect, new Vector2(0f, 1f), new Vector2(0f, 1f), new Vector2(0f, 1f), position, size);
        }

        private static void SetRect(
            RectTransform rect,
            Vector2 anchorMin,
            Vector2 anchorMax,
            Vector2 pivot,
            Vector2 position,
            Vector2 size)
        {
            rect.anchorMin = anchorMin;
            rect.anchorMax = anchorMax;
            rect.pivot = pivot;
            rect.anchoredPosition = position;
            rect.sizeDelta = size;
        }

        private static Font CreateUiFont()
        {
            var fallbackFont = Resources.GetBuiltinResource<Font>("LegacyRuntime.ttf");
            try
            {
                return Font.CreateDynamicFontFromOSFont(
                    new[] { "Malgun Gothic", "Apple SD Gothic Neo", "Noto Sans CJK KR", "Arial Unicode MS", "Arial" },
                    18) ?? fallbackFont;
            }
            catch
            {
                return fallbackFont;
            }
        }

        private static string FormatTime(float seconds)
        {
            var totalSeconds = Mathf.Max(0, Mathf.CeilToInt(seconds));
            return $"{totalSeconds / 60:00}:{totalSeconds % 60:00}";
        }

        private static string GetResolutionReasonLabel(BattleResolutionReason reason)
        {
            return reason switch
            {
                BattleResolutionReason.Victory => "목표 달성",
                BattleResolutionReason.Defeat => "전투 불능",
                BattleResolutionReason.ManualExtraction => "수동 귀환",
                BattleResolutionReason.TimeExpired => "탐색 시간 종료",
                _ => "정산 중",
            };
        }

        private static void DestroyOwnedObject(Object ownedObject)
        {
            if (ownedObject == null)
            {
                return;
            }

            if (Application.isPlaying)
            {
                Destroy(ownedObject);
            }
            else
            {
                DestroyImmediate(ownedObject);
            }
        }
    }
}
