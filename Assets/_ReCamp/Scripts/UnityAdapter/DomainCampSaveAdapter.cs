using System.Collections.Generic;
using ReCamp.Domain;
using System;

namespace ReCamp.UnityAdapter
{
    public static class DomainCampSaveAdapter
    {
        public static GameSaveData ToDomain(UnityCampSaveData campSave)
        {
            var resources = new Dictionary<ResourceKind, int>
            {
                { ResourceKind.Scrap, campSave.scrap },
                { ResourceKind.Rations, campSave.food },
                { ResourceKind.DataFragment, campSave.dataFragments },
            };
            var facilities = new Dictionary<FacilityKind, int>
            {
                { FacilityKind.Generator, campSave.generatorLevel },
                { FacilityKind.Workshop, campSave.workbenchLevel },
                { FacilityKind.RationStorage, campSave.foodStorageLevel },
            };
            return new GameSaveData(GameSaveData.CurrentVersion, resources, facilities);
        }

        public static UnityCampSaveData ToUnity(GameSaveData domainSave)
        {
            return new UnityCampSaveData
            {
                version = UnityCampSaveData.CurrentVersion,
                scrap = domainSave.Resources[ResourceKind.Scrap],
                food = domainSave.Resources[ResourceKind.Rations],
                dataFragments = domainSave.Resources[ResourceKind.DataFragment],
                generatorLevel = domainSave.FacilityLevels[FacilityKind.Generator],
                workbenchLevel = domainSave.FacilityLevels[FacilityKind.Workshop],
                foodStorageLevel = domainSave.FacilityLevels[FacilityKind.RationStorage],
            };
        }
    }

    [Serializable]
    public sealed class UnityCampSaveData
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
}
