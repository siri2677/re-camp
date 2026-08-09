using System;
using DomainFacilityKind = ReCamp.Domain.FacilityKind;
using DomainGameSession = ReCamp.Domain.GameSession;
using ReCamp.Item;
using ReCamp.Save;
using UnityEngine;

namespace ReCamp.Camp
{
    public sealed class CampManager : MonoBehaviour
    {
        public static CampManager Instance { get; private set; }

        public ResourceLedger Inventory { get; private set; } = new();

        private DomainGameSession domainSession;

        public int AttackBonus => domainSession == null ? 0 : domainSession.AttackBonus;
        public int MaxHealthBonus => domainSession == null ? 0 : domainSession.MaxHealthBonus;
        public float ExplorationTimeBonusSeconds => domainSession == null
            ? 0f
            : domainSession.ExplorationTimeBonusSeconds;

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
            return domainSession == null
                ? 0
                : domainSession.Facility(ToDomainFacility(facility)).Level;
        }

        public bool TryUpgrade(CampFacility facility)
        {
            if (domainSession == null || !domainSession.TryUpgrade(ToDomainFacility(facility)))
            {
                return false;
            }

            SyncFromDomain();
            Save();
            return true;
        }

        public void Deposit(ResourceLedger rewards)
        {
            if (domainSession == null || rewards == null || rewards.Total == 0)
            {
                return;
            }

            domainSession.Resources.Add(ReCamp.Domain.ResourceKind.Scrap, rewards.Scrap);
            domainSession.Resources.Add(ReCamp.Domain.ResourceKind.Rations, rewards.Food);
            domainSession.Resources.Add(ReCamp.Domain.ResourceKind.DataFragment, rewards.DataFragments);
            SyncFromDomain();
            Save();
        }


        private void Load()
        {
            domainSession = SaveManager.LoadDomainCamp();
            SyncFromDomain();
        }

        private void Save()
        {
            SaveManager.SaveCamp(domainSession);
        }

        private void SyncFromDomain()
        {
            Inventory = new ResourceLedger();
            Inventory.Add(ResourceType.Scrap, domainSession.Resources[ReCamp.Domain.ResourceKind.Scrap]);
            Inventory.Add(ResourceType.Food, domainSession.Resources[ReCamp.Domain.ResourceKind.Rations]);
            Inventory.Add(ResourceType.DataFragment, domainSession.Resources[ReCamp.Domain.ResourceKind.DataFragment]);
        }

        private static DomainFacilityKind ToDomainFacility(CampFacility facility)
        {
            return facility switch
            {
                CampFacility.Generator => DomainFacilityKind.Generator,
                CampFacility.Workbench => DomainFacilityKind.Workshop,
                CampFacility.FoodStorage => DomainFacilityKind.RationStorage,
                _ => throw new ArgumentOutOfRangeException(nameof(facility), facility, null),
            };
        }
    }
}
