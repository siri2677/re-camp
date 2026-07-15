using ReCamp.GameFlow;
using ReCamp.Enemy;
using ReCamp.Player;
using ReCamp.UI;
using UnityEditor;
using UnityEditor.SceneManagement;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace ReCamp.Editor
{
    /// <summary>Creates the minimal M1 scenes and registers them in Build Settings.</summary>
    public static class ReCampSceneBuilder
    {
        private const string SceneDirectory = "Assets/_ReCamp/Scenes";

        [MenuItem("ReCamp/Setup/Create M1 Scene Flow")]
        public static void CreateM1SceneFlow()
        {
            EnsureFolder(SceneDirectory);
            CreateBootstrapScene();
            CreateTitleScene();
            CreateLobbyScene();
            CreateBattleScene();
            CreateResultScene();

            EditorBuildSettings.scenes = new[]
            {
                BuildScene("00_Bootstrap"),
                BuildScene("01_Title"),
                BuildScene("02_Lobby"),
                BuildScene("03_Battle"),
                BuildScene("04_Result"),
            };

            AssetDatabase.SaveAssets();
            AssetDatabase.Refresh();
            Debug.Log("Re:Camp M1 scene flow created successfully.");
        }

        private static void CreateBootstrapScene()
        {
            var scene = NewScene("00_Bootstrap");
            var controller = new GameObject("BootstrapController");
            controller.AddComponent<BootstrapSceneController>();
            SaveScene(scene, "00_Bootstrap");
        }

        private static void CreateTitleScene()
        {
            var scene = NewScene("01_Title");
            var controller = new GameObject("TitleController");
            controller.AddComponent<TitleSceneController>();
            controller.AddComponent<PrototypeSceneUI>();
            SaveScene(scene, "01_Title");
        }

        private static void CreateLobbyScene()
        {
            var scene = NewScene("02_Lobby");
            var controller = new GameObject("LobbyController");
            controller.AddComponent<LobbySceneController>();
            controller.AddComponent<PrototypeSceneUI>();
            SaveScene(scene, "02_Lobby");
        }

        private static void CreateBattleScene()
        {
            var scene = NewScene("03_Battle");
            CreateBattleCamera();
            var controller = new GameObject("BattleController");
            controller.AddComponent<BattleSceneController>();
            controller.AddComponent<PrototypeSceneUI>();

            var player = GameObject.CreatePrimitive(PrimitiveType.Capsule);
            player.name = "Player";
            player.transform.position = Vector3.zero;
            player.AddComponent<PlayerStats>();
            player.AddComponent<PlayerController>();
            player.AddComponent<PlayerAttack>();

            var spawner = new GameObject("EnemySpawner");
            spawner.AddComponent<EnemySpawner>();
            SaveScene(scene, "03_Battle");
        }

        private static void CreateBattleCamera()
        {
            var cameraObject = new GameObject("Main Camera");
            cameraObject.tag = "MainCamera";
            cameraObject.transform.position = new Vector3(0f, 0f, -10f);
            var camera = cameraObject.AddComponent<Camera>();
            camera.orthographic = true;
            camera.orthographicSize = 6f;
            camera.backgroundColor = new Color(0.07f, 0.1f, 0.14f);
            cameraObject.AddComponent<BattleCameraFollow>();
        }

        private static void CreateResultScene()
        {
            var scene = NewScene("04_Result");
            var controller = new GameObject("ResultController");
            controller.AddComponent<ResultSceneController>();
            controller.AddComponent<PrototypeSceneUI>();
            SaveScene(scene, "04_Result");
        }

        private static Scene NewScene(string name)
        {
            var scene = EditorSceneManager.NewScene(NewSceneSetup.EmptyScene, NewSceneMode.Single);
            scene.name = name;
            return scene;
        }

        private static void SaveScene(Scene scene, string name)
        {
            EditorSceneManager.SaveScene(scene, $"{SceneDirectory}/{name}.unity");
        }

        private static EditorBuildSettingsScene BuildScene(string name)
        {
            return new EditorBuildSettingsScene($"{SceneDirectory}/{name}.unity", true);
        }

        private static void EnsureFolder(string folder)
        {
            if (AssetDatabase.IsValidFolder(folder))
            {
                return;
            }

            AssetDatabase.CreateFolder("Assets/_ReCamp", "Scenes");
        }
    }
}
