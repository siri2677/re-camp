using NUnit.Framework;
using ReCamp.Domain;
using ReCamp.UnityAdapter;

namespace ReCamp.Tests.EditMode
{
    public sealed class DomainCampSaveAdapterTests
    {
        [Test]
        public void LegacyCampSave_RoundTripsThroughDomainWithFoodMappedToRations()
        {
            var legacy = new UnityCampSaveData
            {
                scrap = 12,
                food = 8,
                dataFragments = 3,
                generatorLevel = 2,
                workbenchLevel = 1,
                foodStorageLevel = 4,
            };

            var domain = DomainCampSaveAdapter.ToDomain(legacy);
            var restored = DomainCampSaveAdapter.ToUnity(domain);

            Assert.That(domain.Resources[ResourceKind.Rations], Is.EqualTo(8));
            Assert.That(domain.FacilityLevels[FacilityKind.RationStorage], Is.EqualTo(4));
            Assert.That(restored.version, Is.EqualTo(UnityCampSaveData.CurrentVersion));
            Assert.That(restored.food, Is.EqualTo(8));
            Assert.That(restored.dataFragments, Is.EqualTo(3));
        }

        [Test]
        public void DomainSession_SaveRestoresFacilityEffectsAndBalances()
        {
            var session = new GameSession();
            session.Resources.Add(ResourceKind.Scrap, 15);
            session.Resources.Add(ResourceKind.DataFragment, 2);
            session.Resources.Add(ResourceKind.Rations, 10);

            Assert.That(session.TryUpgrade(FacilityKind.Workshop), Is.True);
            Assert.That(session.TryUpgrade(FacilityKind.RationStorage), Is.True);

            var restored = GameSession.FromSave(session.CreateSave());

            Assert.That(restored.Player.Attack, Is.EqualTo(12));
            Assert.That(restored.Player.MaxHealth, Is.EqualTo(110));
            Assert.That(restored.Resources[ResourceKind.Scrap], Is.Zero);
            Assert.That(restored.Facility(FacilityKind.Workshop).Level, Is.EqualTo(1));
        }
    }
}
