using ReCamp.Camp;
using ReCamp.Runtime;
using ReCamp.Data;
using ReCamp.GameFlow;
using UnityEngine;

namespace ReCamp.UI
{
    /// <summary>Temporary IMGUI controls used to validate the MVP scene loop.</summary>
    public sealed class PrototypeSceneUI : MonoBehaviour
    {
        private const float PanelWidth = 560f;
        private const float ButtonHeight = 48f;

        private void OnGUI()
        {
            var isLobby = TryGetComponent(out LobbySceneController lobby);
            var panelHeight = isLobby ? Mathf.Min(620f, Screen.height - 24f) : 320f;
            var panel = new Rect(
                (Screen.width - PanelWidth) * 0.5f,
                (Screen.height - panelHeight) * 0.5f,
                PanelWidth,
                panelHeight);

            GUILayout.BeginArea(panel, GUI.skin.box);
            GUILayout.FlexibleSpace();

            if (isLobby)
            {
                DrawTitle("RE:CAMP");
                GUILayout.Label("출격 캐릭터를 선택하세요", CenteredLabel());
                DrawCharacterSelection();
                GUILayout.Space(8f);
                if (GUILayout.Button("Start Battle", GUILayout.Height(ButtonHeight)))
                {
                    lobby.StartBattle();
                }

                DrawCampPanel();
            }
            else if (TryGetComponent(out BattleSceneController battle))
            {
                DrawTitle("BATTLE");
                GUILayout.Label(battle.CollectedRewards.ToSummary(), CenteredLabel());
                GUILayout.Label($"Hostiles remaining: {ReCamp.Enemy.EnemyController.ActiveCount}", CenteredLabel());
                GUILayout.Space(8f);
                if (GUILayout.Button("Debug: Add Scrap", GUILayout.Height(ButtonHeight)))
                {
                    battle.AddCollectedResource(1);
                }

                if (GUILayout.Button("Return With Rewards", GUILayout.Height(ButtonHeight)))
                {
                    battle.CompleteBattle();
                }
            }
            else if (TryGetComponent(out ResultSceneController result))
            {
                DrawTitle("RUN RESULT");
                GUILayout.Label(result.LastRewards.ToSummary(), CenteredLabel());
                GUILayout.Space(8f);
                if (GUILayout.Button("Return To Lobby", GUILayout.Height(ButtonHeight)))
                {
                    result.ReturnToLobby();
                }
            }
            else if (TryGetComponent(out TitleSceneController title))
            {
                DrawTitle("RE:CAMP");
                if (GUILayout.Button("Start", GUILayout.Height(ButtonHeight)))
                {
                    title.EnterLobby();
                }
            }

            GUILayout.FlexibleSpace();
            GUILayout.EndArea();
        }

        private static void DrawCharacterSelection()
        {
            var manager = GameManager.Instance;
            var selected = manager == null ? CharacterRoster.Default : manager.SelectedCharacter;

            GUILayout.BeginHorizontal();
            if (GUILayout.Button("◀", GUILayout.Width(52f), GUILayout.Height(36f)))
            {
                selected = manager == null
                    ? CharacterRoster.GetPrevious(selected.Id)
                    : manager.SelectPreviousCharacter();
            }

            GUILayout.Label($"{selected.DisplayName} · {selected.Role}", CenteredLabel(18), GUILayout.Height(36f));
            if (GUILayout.Button("▶", GUILayout.Width(52f), GUILayout.Height(36f)))
            {
                selected = manager == null
                    ? CharacterRoster.GetNext(selected.Id)
                    : manager.SelectNextCharacter();
            }

            GUILayout.EndHorizontal();

            GUILayout.BeginHorizontal();
            foreach (var definition in CharacterRoster.All)
            {
                var previousBackground = GUI.backgroundColor;
                GUI.backgroundColor = definition.Id == selected.Id
                    ? Color.Lerp(definition.PrimaryColor, Color.white, 0.25f)
                    : Color.Lerp(definition.SecondaryColor, Color.gray, 0.35f);
                if (GUILayout.Button(definition.DisplayName, GUILayout.Height(42f)))
                {
                    manager?.SelectCharacter(definition.Id);
                    selected = definition;
                }

                GUI.backgroundColor = previousBackground;
            }

            GUILayout.EndHorizontal();
            GUILayout.Space(6f);
            GUILayout.Label(selected.Summary, DetailLabel());
            GUILayout.Label(
                $"HP {selected.MaxHealth}  ·  이동 {selected.MoveSpeed:0.0}  ·  공격 {selected.AttackDamage} / {selected.AttackInterval:0.00}s  ·  사거리 {selected.AttackRange:0.0}",
                CenteredLabel());
            GUILayout.Label(
                $"[SPACE] {selected.SignatureAbilityName} — {selected.SignatureAbilityDescription}",
                DetailLabel());
        }

        private static void DrawTitle(string title)
        {
            GUILayout.Label(title, CenteredLabel(24));
            GUILayout.Space(24f);
        }

        private static void DrawCampPanel()
        {
            var camp = CampManager.Instance;
            if (camp == null)
            {
                return;
            }

            GUILayout.Space(12f);
            GUILayout.Label($"Camp stock: {camp.Inventory.ToSummary()}", CenteredLabel());
            GUILayout.BeginHorizontal();
            if (GUILayout.Button(
                    $"Generator Lv.{camp.GetLevel(CampFacility.Generator)} (+{camp.ExplorationTimeBonusSeconds:0}s)"))
            {
                camp.TryUpgrade(CampFacility.Generator);
            }

            if (GUILayout.Button($"Workbench Lv.{camp.GetLevel(CampFacility.Workbench)}"))
            {
                camp.TryUpgrade(CampFacility.Workbench);
            }

            if (GUILayout.Button($"Food Store Lv.{camp.GetLevel(CampFacility.FoodStorage)}"))
            {
                camp.TryUpgrade(CampFacility.FoodStorage);
            }

            GUILayout.EndHorizontal();
        }

        private static GUIStyle CenteredLabel(int fontSize = 14)
        {
            return new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleCenter,
                fontSize = fontSize,
                wordWrap = true,
            };
        }

        private static GUIStyle DetailLabel()
        {
            return new GUIStyle(GUI.skin.label)
            {
                alignment = TextAnchor.MiddleCenter,
                fontSize = 14,
                wordWrap = true,
                padding = new RectOffset(16, 16, 4, 4),
            };
        }
    }
}
