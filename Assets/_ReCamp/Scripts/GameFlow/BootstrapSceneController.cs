using ReCamp.Runtime;
using UnityEngine;

namespace ReCamp.GameFlow
{
    public sealed class BootstrapSceneController : MonoBehaviour
    {
        [SerializeField] private GameObject gameManagerPrefab;
        [SerializeField] private GameScene nextScene = GameScene.Lobby;

        private void Start()
        {
            EnsureGameManager();
            SceneLoader.Load(nextScene);
        }

        private void EnsureGameManager()
        {
            if (GameManager.Instance != null)
            {
                return;
            }

            if (gameManagerPrefab != null)
            {
                Instantiate(gameManagerPrefab);
                return;
            }

            var managerObject = new GameObject(nameof(GameManager));
            managerObject.AddComponent<GameManager>();
        }
    }
}
