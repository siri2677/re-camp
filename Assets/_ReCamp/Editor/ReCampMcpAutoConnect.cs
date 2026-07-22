using MCPForUnity.Editor.Services.Transport.Transports;
using UnityEditor;
using UnityEngine;

namespace ReCamp.Editor
{
    [InitializeOnLoad]
    internal static class ReCampMcpAutoConnect
    {
        private const string SessionKey = "ReCamp.McpAutoConnect.Started";
        private const string UseHttpTransportKey = "MCPForUnity.UseHttpTransport";

        static ReCampMcpAutoConnect()
        {
            if (Application.isBatchMode ||
                EditorPrefs.GetBool(UseHttpTransportKey, true) ||
                StdioBridgeHost.IsRunning ||
                SessionState.GetBool(SessionKey, false))
            {
                return;
            }

            SessionState.SetBool(SessionKey, true);
            EditorApplication.delayCall += StartBridgeIfStillNeeded;
        }

        private static void StartBridgeIfStillNeeded()
        {
            if (!EditorPrefs.GetBool(UseHttpTransportKey, true) && !StdioBridgeHost.IsRunning)
            {
                StdioBridgeHost.StartAutoConnect();
            }
        }
    }
}
