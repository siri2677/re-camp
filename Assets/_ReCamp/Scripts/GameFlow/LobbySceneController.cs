using ReCamp.Runtime;
using UnityEngine;

namespace ReCamp.GameFlow
{
    public sealed class LobbySceneController : MonoBehaviour
    {
        public void StartBattle()
        {
            if (GameManager.Instance == null)
            {
                return;
            }

            GameManager.Instance.StartRun();
        }

        public void GoToTitle()
        {
            if (GameManager.Instance == null)
            {
                return;
            }

            GameManager.Instance.GoToTitle();
        }
    }
}
