using System;
using ReCamp.Camp;
using ReCamp.Item;
using UnityEngine;

namespace ReCamp.Save
{
    [Serializable]
    public sealed class CampSaveData
    {
        public int scrap;
        public int food;
        public int dataFragments;
        public int generatorLevel;
        public int workbenchLevel;
        public int foodStorageLevel;
    }

    public static class SaveManager
    {
        private const string CampSaveKey = "ReCamp.CampSave.v1";

        public static CampSaveData LoadCamp()
        {
            if (!PlayerPrefs.HasKey(CampSaveKey))
            {
                return new CampSaveData();
            }

            try
            {
                return JsonUtility.FromJson<CampSaveData>(PlayerPrefs.GetString(CampSaveKey)) ?? new CampSaveData();
            }
            catch
            {
                return new CampSaveData();
            }
        }

        public static void SaveCamp(ResourceLedger inventory, CampManager camp)
        {
            var data = new CampSaveData
            {
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
