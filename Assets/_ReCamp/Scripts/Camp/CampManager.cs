using ReCamp.Item;
using ReCamp.Save;
using UnityEngine;

namespace ReCamp.Camp
{
    public sealed class CampManager : MonoBehaviour
    {
        public static CampManager Instance { get; private set; }

        public ResourceLedger Inventory { get; private set; } = new();

        private int generatorLevel;
        private int workbenchLevel;
        private int foodStorageLevel;

        public int AttackBonus => workbenchLevel * 2;
        public int MaxHealthBonus => foodStorageLevel * 20;
        public float ExplorationTimeBonusSeconds => generatorLevel * 30f;

        private void Awake()
        {
            if (Instance != null && Instance != this)
            {
                Destroy(gameObject);
                return;
            }

            Instance = this;
            Load();
        }

        public int GetLevel(CampFacility facility)
        {
            return facility switch
            {
                CampFacility.Generator => generatorLevel,
                CampFacility.Workbench => workbenchLevel,
                CampFacility.FoodStorage => foodStorageLevel,
                _ => 0,
            };
        }

        public bool TryUpgrade(CampFacility facility)
        {
            var level = GetLevel(facility);
            if (!CanPayUpgrade(facility, level))
            {
                return false;
            }

            SpendUpgradeCost(facility, level);
            switch (facility)
            {
                case CampFacility.Generator:
                    generatorLevel++;
                    break;
                case CampFacility.Workbench:
                    workbenchLevel++;
                    break;
                case CampFacility.FoodStorage:
                    foodStorageLevel++;
                    break;
            }

            Save();
            return true;
        }

        public void Deposit(ResourceLedger rewards)
        {
            if (rewards == null || rewards.Total == 0)
            {
                return;
            }

            Inventory.Add(ResourceType.Scrap, rewards.Scrap);
            Inventory.Add(ResourceType.Food, rewards.Food);
            Inventory.Add(ResourceType.DataFragment, rewards.DataFragments);
            Save();
        }

        private bool CanPayUpgrade(CampFacility facility, int level)
        {
            return facility switch
            {
                CampFacility.Generator => Inventory.Get(ResourceType.Scrap) >= 3 + level * 2,
                CampFacility.Workbench => Inventory.Get(ResourceType.Scrap) >= 2 + level * 2
                    && Inventory.Get(ResourceType.DataFragment) >= 1 + level,
                CampFacility.FoodStorage => Inventory.Get(ResourceType.Food) >= 3 + level * 2,
                _ => false,
            };
        }

        private void SpendUpgradeCost(CampFacility facility, int level)
        {
            switch (facility)
            {
                case CampFacility.Generator:
                    Inventory.TrySpend(ResourceType.Scrap, 3 + level * 2);
                    break;
                case CampFacility.Workbench:
                    Inventory.TrySpend(ResourceType.Scrap, 2 + level * 2);
                    Inventory.TrySpend(ResourceType.DataFragment, 1 + level);
                    break;
                case CampFacility.FoodStorage:
                    Inventory.TrySpend(ResourceType.Food, 3 + level * 2);
                    break;
            }
        }

        private void Load()
        {
            var data = SaveManager.LoadCamp();
            Inventory.Add(ResourceType.Scrap, data.scrap);
            Inventory.Add(ResourceType.Food, data.food);
            Inventory.Add(ResourceType.DataFragment, data.dataFragments);
            generatorLevel = Mathf.Max(0, data.generatorLevel);
            workbenchLevel = Mathf.Max(0, data.workbenchLevel);
            foodStorageLevel = Mathf.Max(0, data.foodStorageLevel);
        }

        private void Save()
        {
            SaveManager.SaveCamp(Inventory, this);
        }
    }
}
