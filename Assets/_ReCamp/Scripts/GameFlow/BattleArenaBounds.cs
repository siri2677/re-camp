using UnityEngine;

namespace ReCamp.GameFlow
{
    /// <summary>
    /// Defines the playable XZ rectangle independently from its temporary wall visuals.
    /// Transform movement does not receive collision resolution, so actors must clamp
    /// through this component instead of relying on the boundary colliders alone.
    /// </summary>
    public sealed class BattleArenaBounds : MonoBehaviour
    {
        public static BattleArenaBounds Instance { get; private set; }

        [SerializeField] private Vector2 playableHalfExtents = new(11.25f, 11.25f);
        [SerializeField] private Vector2 cameraViewHalfExtents = new(8.5f, 6.5f);

        public Vector2 PlayableHalfExtents => playableHalfExtents;

        private void Awake()
        {
            Instance = this;
        }

        private void OnDestroy()
        {
            if (Instance == this)
            {
                Instance = null;
            }
        }

        public Vector3 ClampActorPosition(Vector3 worldPosition, float padding = 0f)
        {
            var center = transform.position;
            var halfX = Mathf.Max(0f, playableHalfExtents.x - Mathf.Max(0f, padding));
            var halfZ = Mathf.Max(0f, playableHalfExtents.y - Mathf.Max(0f, padding));
            worldPosition.x = Mathf.Clamp(worldPosition.x, center.x - halfX, center.x + halfX);
            worldPosition.z = Mathf.Clamp(worldPosition.z, center.z - halfZ, center.z + halfZ);
            return worldPosition;
        }

        public Vector3 ClampCameraFocus(Vector3 worldPosition)
        {
            var center = transform.position;
            var halfX = Mathf.Max(0f, playableHalfExtents.x - cameraViewHalfExtents.x);
            var halfZ = Mathf.Max(0f, playableHalfExtents.y - cameraViewHalfExtents.y);
            worldPosition.x = Mathf.Clamp(worldPosition.x, center.x - halfX, center.x + halfX);
            worldPosition.z = Mathf.Clamp(worldPosition.z, center.z - halfZ, center.z + halfZ);
            return worldPosition;
        }

        private void OnDrawGizmosSelected()
        {
            var size = new Vector3(playableHalfExtents.x * 2f, 0.05f, playableHalfExtents.y * 2f);
            Gizmos.color = new Color(0.35f, 0.95f, 0.8f, 0.9f);
            Gizmos.DrawWireCube(transform.position, size);
        }
    }
}
