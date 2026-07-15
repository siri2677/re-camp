using UnityEngine;
using UnityEngine.SceneManagement;

namespace ReCamp.GameFlow
{
    public static class SceneLoader
    {
        public static AsyncOperation Load(GameScene scene, LoadSceneMode loadSceneMode = LoadSceneMode.Single)
        {
            return SceneManager.LoadSceneAsync(ToSceneName(scene), loadSceneMode);
        }

        public static string ToSceneName(GameScene scene)
        {
            return scene switch
            {
                GameScene.Bootstrap => "00_Bootstrap",
                GameScene.Title => "01_Title",
                GameScene.Lobby => "02_Lobby",
                GameScene.Battle => "03_Battle",
                GameScene.Result => "04_Result",
                _ => "00_Bootstrap",
            };
        }
    }
}
