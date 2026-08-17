using ReCamp.Runtime;
using ReCamp.Item;
using ReCamp.UnityAdapter;
using UnityEngine;

namespace ReCamp.GameFlow
{
    public sealed class ResultSceneController : MonoBehaviour
    {
        public int LastCollectedResources
        {
            get
            {
                if (GameManager.Instance == null)
                {
                    return 0;
                }

                return GameManager.Instance.LastRunResourceCount;
            }
        }

        public ResourceLedger LastRewards => GameManager.Instance == null
            ? new ResourceLedger()
            : GameManager.Instance.LastRunRewards;

        public RunSettlementViewData LastSettlement => GameManager.Instance?.LastRunSettlement == null
            ? null
            : RunSettlementViewAdapter.Create(GameManager.Instance.LastRunSettlement);

        public void ReturnToLobby()
        {
            if (GameManager.Instance == null)
            {
                return;
            }

            GameManager.Instance.ReturnToLobby();
        }
    }
}
