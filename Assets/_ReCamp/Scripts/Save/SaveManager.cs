using System;
using ReCamp.Domain;
using ReCamp.UnityAdapter;
using UnityEngine;

namespace ReCamp.Save
{
    [Serializable]
    public sealed class CampSaveData
    {
        public const int CurrentVersion = 2;

        public int version = CurrentVersion;
        public int scrap;
        public int food;
        public int dataFragments;
        public int generatorLevel;
        public int workbenchLevel;
        public int foodStorageLevel;
    }

    public static class SaveManager
    {
        private const string LegacyCampSaveKey = "ReCamp.CampSave.v1";
        private const string CampSaveKey = "ReCamp.CampSave.v2";

        public static CampSaveData LoadCamp()
        {
            if (PlayerPrefs.HasKey(CampSaveKey))
            {
                var current = Deserialize(PlayerPrefs.GetString(CampSaveKey));
                return IsValid(current) ? current : new CampSaveData();
            }

            if (!PlayerPrefs.HasKey(LegacyCampSaveKey))
            {
                return new CampSaveData();
            }

            var migrated = MigrateLegacy(Deserialize(PlayerPrefs.GetString(LegacyCampSaveKey)));
            PlayerPrefs.SetString(CampSaveKey, JsonUtility.ToJson(migrated));
            PlayerPrefs.Save();
            return migrated;
        }

        public static GameSession LoadDomainCamp()
        {
            var saved = LoadCamp();
            return GameSession.FromSave(DomainCampSaveAdapter.ToDomain(new UnityCampSaveData
            {
                scrap = saved.scrap,
                food = saved.food,
                dataFragments = saved.dataFragments,
                generatorLevel = saved.generatorLevel,
                workbenchLevel = saved.workbenchLevel,
                foodStorageLevel = saved.foodStorageLevel,
            }));
        }

        private static CampSaveData Deserialize(string json)
        {
            try
            {
                return JsonUtility.FromJson<CampSaveData>(json) ?? new CampSaveData();
            }
            catch
            {
                return new CampSaveData();
            }
        }

        private static bool IsValid(CampSaveData data)
        {
            return data != null &&
                data.version == CampSaveData.CurrentVersion &&
                data.scrap >= 0 &&
                data.food >= 0 &&
                data.dataFragments >= 0 &&
                data.generatorLevel >= 0 &&
                data.workbenchLevel >= 0 &&
                data.foodStorageLevel >= 0;
        }

        private static CampSaveData MigrateLegacy(CampSaveData legacy)
        {
            var adapterSave = new UnityCampSaveData
            {
                scrap = legacy.scrap,
                food = legacy.food,
                dataFragments = legacy.dataFragments,
                generatorLevel = legacy.generatorLevel,
                workbenchLevel = legacy.workbenchLevel,
                foodStorageLevel = legacy.foodStorageLevel,
            };
            var migrated = DomainCampSaveAdapter.ToUnity(DomainCampSaveAdapter.ToDomain(adapterSave));
            return new CampSaveData
            {
                version = CampSaveData.CurrentVersion,
                scrap = migrated.scrap,
                food = migrated.food,
                dataFragments = migrated.dataFragments,
                generatorLevel = migrated.generatorLevel,
                workbenchLevel = migrated.workbenchLevel,
                foodStorageLevel = migrated.foodStorageLevel,
            };
        }

        public static void SaveCamp(GameSession session)
        {
            if (session == null)
            {
                throw new ArgumentNullException(nameof(session));
            }

            var adapted = DomainCampSaveAdapter.ToUnity(session.CreateSave());
            var data = new CampSaveData
            {
                version = CampSaveData.CurrentVersion,
                scrap = adapted.scrap,
                food = adapted.food,
                dataFragments = adapted.dataFragments,
                generatorLevel = adapted.generatorLevel,
                workbenchLevel = adapted.workbenchLevel,
                foodStorageLevel = adapted.foodStorageLevel,
            };
            PlayerPrefs.SetString(CampSaveKey, JsonUtility.ToJson(data));
            PlayerPrefs.Save();
        }
    }
}
