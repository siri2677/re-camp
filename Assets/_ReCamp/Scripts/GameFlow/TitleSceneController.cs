using ReCamp.Runtime;
using UnityEngine;

namespace ReCamp.GameFlow
{
    public sealed class TitleSceneController : MonoBehaviour
    {
        public void EnterLobby()
        {
            if (GameManager.Instance == null)
            {
                return;
            }

            GameManager.Instance.ReturnToLobby();
        }
    }
}
