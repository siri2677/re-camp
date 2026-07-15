using ReCamp.Player;
using UnityEngine;

namespace ReCamp.GameFlow
{
    public sealed class BattleCameraFollow : MonoBehaviour
    {
        [SerializeField, Min(0.1f)] private float followSpeed = 8f;
        [SerializeField] private Vector3 followOffset = new(-10f, 10f, -10f);

        private void LateUpdate()
        {
            var player = PlayerController.Instance;
            if (player == null)
            {
                return;
            }

            var focusPosition = player.transform.position;
            if (BattleArenaBounds.Instance != null)
            {
                focusPosition = BattleArenaBounds.Instance.ClampCameraFocus(focusPosition);
            }

            var target = focusPosition + followOffset;
            transform.position = Vector3.Lerp(transform.position, target, followSpeed * Time.deltaTime);
        }
    }
}
