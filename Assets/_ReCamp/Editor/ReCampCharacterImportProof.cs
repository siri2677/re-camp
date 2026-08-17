using System;
using System.Collections.Generic;
using System.IO;
using UnityEditor;
using UnityEngine;

namespace ReCamp.Editor
{
    /// <summary>
    /// Read-only Gate B/C preflight for the CH101 Blender export.
    /// It writes a small evidence report and never changes importer settings.
    /// </summary>
    public static class ReCampCharacterImportProof
    {
        private const string AssetPath = "Assets/_ReCamp/Art/Characters/CH101/CH101_Blockout_REVIEW_v010.fbx";
        private const string ReportPath = "Assets/_ReCamp/Art/Characters/CH101/Reports/CH101_UnityImportProof_REVIEW_v003.json";
        private const string SourceCommit = "183b0f0983969937d779f70b2ac51e53fc976203";
        private const int MeshTriangleBudget = 18000;
        private const int EquipmentTriangleBudget = 2000;

        private static readonly string[] RequiredSockets =
        {
            "Socket_Equipment_Primary",
            "Socket_Gauntlet_L",
            "Socket_Gauntlet_R",
            "Socket_AnchorRing_Carry",
            "Socket_AnchorRing_Active",
            "Socket_LineAttach",
            "Socket_VFXCenter",
            "Socket_CameraFocus",
        };

        [Serializable]
        private sealed class ProofReport
        {
            public string status;
            public string gate = "Gate B/C preflight only";
            public string assetPath = AssetPath;
            public string sourceCommit = SourceCommit;
            public string importerAnimationType = "NOT TESTED";
            public string materialImportMode = "NOT TESTED";
            public int meshCount;
            public int triangleCount;
            public int totalTriangleCount;
            public int lod0MeshCount;
            public int lod1MeshCount;
            public int lod2MeshCount;
            public int lod0TriangleCount;
            public int lod1TriangleCount;
            public int lod2TriangleCount;
            public int skinnedRendererCount;
            public int boneCount;
            public int animationClipCount;
            public int materialSlotCount;
            public string materialBudgetStatus = "NOT TESTED";
            public string skinningStatus = "NOT TESTED";
            public int maxInfluencesPerVertex;
            public string[] requiredSockets = Array.Empty<string>();
            public string[] missing;
            public string[] warnings;
        }

        [MenuItem("ReCamp/Art/Validate CH101 Unity Import Proof")]
        public static void Validate()
        {
            var missing = new List<string>();
            var warnings = new List<string>();
            var report = new ProofReport();
            var importedAsset = AssetDatabase.LoadAssetAtPath<GameObject>(AssetPath);
            if (importedAsset == null)
            {
                missing.Add(AssetPath);
                warnings.Add("CH101 v010 FBX is not present; run the locked Blender/Colab export first.");
                report.status = "BLOCKED / SOURCE ASSET MISSING";
                report.missing = missing.ToArray();
                report.warnings = warnings.ToArray();
                WriteReport(report);
                Debug.LogWarning($"CH101 Unity Import Proof blocked: missing {AssetPath}");
                return;
            }

            var importer = AssetImporter.GetAtPath(AssetPath) as ModelImporter;
            if (importer == null)
            {
                missing.Add("ModelImporter");
            }
            else
            {
                report.importerAnimationType = importer.animationType.ToString();
                report.materialImportMode = importer.materialImportMode.ToString();
                if (importer.animationType != ModelImporterAnimationType.Human)
                {
                    missing.Add("ModelImporter.animationType=Human");
                }
            }

            var transforms = importedAsset.GetComponentsInChildren<Transform>(true);
            var transformNames = new HashSet<string>();
            foreach (var transform in transforms)
            {
                transformNames.Add(transform.name);
            }

            var missingSockets = new List<string>();
            foreach (var socket in RequiredSockets)
            {
                if (!transformNames.Contains(socket))
                {
                    missingSockets.Add(socket);
                }
            }
            missing.AddRange(missingSockets);
            report.requiredSockets = RequiredSockets;

            var renderers = importedAsset.GetComponentsInChildren<Renderer>(true);
            var materialNames = new HashSet<string>();
            foreach (var renderer in renderers)
            {
                foreach (var material in renderer.sharedMaterials)
                {
                    if (material != null)
                    {
                        materialNames.Add(material.name);
                    }
                }
                if (renderer is SkinnedMeshRenderer skinned)
                {
                    report.skinnedRendererCount++;
                    report.boneCount = Math.Max(report.boneCount, skinned.bones?.Length ?? 0);
                    if (skinned.sharedMesh != null)
                    {
                        report.meshCount++;
                        AddLodStats(report, renderer.gameObject.name, skinned.sharedMesh.triangles.Length / 3);
                        foreach (var weight in skinned.sharedMesh.boneWeights)
                        {
                            var influenceCount = 0;
                            if (weight.weight0 > 0f) influenceCount++;
                            if (weight.weight1 > 0f) influenceCount++;
                            if (weight.weight2 > 0f) influenceCount++;
                            if (weight.weight3 > 0f) influenceCount++;
                            report.maxInfluencesPerVertex = Math.Max(report.maxInfluencesPerVertex, influenceCount);
                        }
                    }
                }
                else if (renderer is MeshRenderer meshRenderer)
                {
                    var filter = meshRenderer.GetComponent<MeshFilter>();
                    if (filter?.sharedMesh != null)
                    {
                        report.meshCount++;
                        AddLodStats(report, renderer.gameObject.name, filter.sharedMesh.triangles.Length / 3);
                    }
                }
            }

            report.materialSlotCount = materialNames.Count;
            report.materialBudgetStatus = report.materialSlotCount <= 6 ? "PASS" : "FAIL / CONSOLIDATION REQUIRED";
            report.skinningStatus = report.skinnedRendererCount > 0 ? "IMPORTED / PRODUCTION REVIEW WEIGHTS" : "NOT TESTED";
            if (report.materialSlotCount > 6)
            {
                warnings.Add($"Material count {report.materialSlotCount} exceeds the six-slot review budget.");
            }
            report.triangleCount = report.lod0TriangleCount;

            if (report.triangleCount > MeshTriangleBudget + EquipmentTriangleBudget)
            {
                warnings.Add($"Triangle count {report.triangleCount} exceeds the combined review budget {MeshTriangleBudget + EquipmentTriangleBudget}.");
            }

            report.animationClipCount = AssetDatabase.LoadAllAssetsAtPath(AssetPath).Length;
            report.status = missing.Count == 0 ? "REVIEW / IMPORTED" : "BLOCKED / IMPORT PREFLIGHT FAILED";
            report.missing = missing.ToArray();
            report.warnings = warnings.ToArray();
            WriteReport(report);
            Debug.Log($"CH101 Unity Import Proof: {report.status}; triangles={report.triangleCount}, bones={report.boneCount}, missing={missing.Count}");
        }

        private static void WriteReport(ProofReport report)
        {
            var absolutePath = Path.GetFullPath(ReportPath);
            Directory.CreateDirectory(Path.GetDirectoryName(absolutePath));
            File.WriteAllText(absolutePath, JsonUtility.ToJson(report, true));
            AssetDatabase.Refresh();
        }

        private static void AddLodStats(ProofReport report, string objectName, int triangles)
        {
            report.totalTriangleCount += triangles;
            if (objectName.Contains("_LOD2", StringComparison.OrdinalIgnoreCase))
            {
                report.lod2MeshCount++;
                report.lod2TriangleCount += triangles;
            }
            else if (objectName.Contains("_LOD1", StringComparison.OrdinalIgnoreCase))
            {
                report.lod1MeshCount++;
                report.lod1TriangleCount += triangles;
            }
            else
            {
                report.lod0MeshCount++;
                report.lod0TriangleCount += triangles;
            }
        }
    }
}
