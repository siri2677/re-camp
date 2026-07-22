using System;
using ReCamp.Camp;
using ReCamp.Item;
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
                return Deserialize(PlayerPrefs.GetString(CampSaveKey));
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

        public static void SaveCamp(ResourceLedger inventory, CampManager camp)
        {
            var data = new CampSaveData
            {
                version = CampSaveData.CurrentVersion,
                scrap = inventory.Scrap,
                food = inventory.Food,
                dataFragments = inventory.DataFragments,
                generatorLevel = camp.GetLevel(CampFacility.Generator),
                workbenchLevel = camp.GetLevel(CampFacility.Workbench),
                foodStorageLevel = camp.GetLevel(CampFacility.FoodStorage),
            };
            PlayerPrefs.SetString(CampSaveKey, JsonUtility.ToJson(data));
            PlayerPrefs.Save();
        }
    }
}
