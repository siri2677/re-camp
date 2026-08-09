using System;
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
            session.Resources.Add(ResourceKind.Scrap, 2);
            session.Resources.Add(ResourceKind.DataFragment, 1);
            session.Resources.Add(ResourceKind.Rations, 3);

            Assert.That(session.TryUpgrade(FacilityKind.Workshop), Is.True);
            Assert.That(session.TryUpgrade(FacilityKind.RationStorage), Is.True);

            var restored = GameSession.FromSave(session.CreateSave());

            Assert.That(restored.Player.Attack, Is.EqualTo(12));
            Assert.That(restored.Player.MaxHealth, Is.EqualTo(120));
            Assert.That(restored.Resources[ResourceKind.Scrap], Is.Zero);
            Assert.That(restored.Resources[ResourceKind.Rations], Is.Zero);
            Assert.That(restored.Facility(FacilityKind.Workshop).Level, Is.EqualTo(1));
        }

        [Test]
        public void RunSettlement_ExtractedRewardsDepositOnce()
        {
            var service = new RunSettlementService();
            var command = DomainCampSaveAdapter.ToRunSettlementCommand(
                "run-001",
                RunOutcome.Extracted,
                4,
                2,
                1);

            var first = service.Settle(command);
            var duplicate = service.Settle(command);
            var unityRewards = DomainCampSaveAdapter.ToUnityRunRewards(first);

            Assert.That(first.Applied, Is.True);
            Assert.That(first.Deposited, Is.True);
            Assert.That(unityRewards.scrap, Is.EqualTo(4));
            Assert.That(unityRewards.food, Is.EqualTo(2));
            Assert.That(unityRewards.dataFragments, Is.EqualTo(1));
            Assert.That(duplicate.Applied, Is.False);
            Assert.That(duplicate.Deposited, Is.False);
            Assert.That(duplicate.DepositedRewards[ResourceKind.Scrap], Is.Zero);
        }

        [TestCase(RunOutcome.Defeated)]
        [TestCase(RunOutcome.Expired)]
        public void RunSettlement_NonExtractedOutcomesDiscardRewards(RunOutcome outcome)
        {
            var service = new RunSettlementService();
            var result = service.Settle(
                DomainCampSaveAdapter.ToRunSettlementCommand(
                    outcome.ToString(),
                    outcome,
                    7,
                    3,
                    2));

            Assert.That(result.Applied, Is.True);
            Assert.That(result.Deposited, Is.False);
            Assert.That(result.DepositedRewards[ResourceKind.Scrap], Is.Zero);
            Assert.That(result.DepositedRewards[ResourceKind.Rations], Is.Zero);
            Assert.That(result.DepositedRewards[ResourceKind.DataFragment], Is.Zero);
        }

        [Test]
        public void RunSettlement_RejectsNegativeRewardsBeforeMutatingService()
        {
            var service = new RunSettlementService();

            Assert.Throws<ArgumentException>(() =>
                DomainCampSaveAdapter.ToRunSettlementCommand(
                    "run-invalid",
                    RunOutcome.Extracted,
                    -1,
                    0,
                    0));

            var valid = service.Settle(
                DomainCampSaveAdapter.ToRunSettlementCommand(
                    "run-invalid",
                    RunOutcome.Extracted,
                    1,
                    0,
                    0));
            Assert.That(valid.Applied, Is.True);
        }

        [Test]
        public void SkillCommands_RespectIndependentCooldownsAndEmitActivationEvent()
        {
            var processor = new SkillCommandProcessor();
            var signature = new SkillCommand(SkillSlot.Signature, 10f, 2f);
            var accepted = processor.TryBegin(signature);
            var rejected = processor.TryBegin(new SkillCommand(SkillSlot.Signature, 11f, 2f));
            var utility = processor.TryBegin(new SkillCommand(SkillSlot.Utility, 11f, 3f));
            var activation = processor.CreateActivatedEvent(signature, accepted);

            Assert.That(accepted.Accepted, Is.True);
            Assert.That(rejected.Accepted, Is.False);
            Assert.That(rejected.Rejection, Is.EqualTo(SkillCommandRejection.Cooldown));
            Assert.That(utility.Accepted, Is.True);
            Assert.That(processor.CooldownRemaining(SkillSlot.Signature, 12f), Is.Zero);
            Assert.That(activation.Slot, Is.EqualTo(SkillSlot.Signature));
            Assert.That(activation.ActivatedAt, Is.EqualTo(10f));
            Assert.That(activation.CooldownEndsAt, Is.EqualTo(12f));
        }

        [Test]
        public void SkillCommands_CancelRestoresAvailabilityAfterFailedPresentation()
        {
            var processor = new SkillCommandProcessor();
            var command = new SkillCommand(SkillSlot.Utility, 4f, 8f);
            var accepted = processor.TryBegin(command);

            processor.Cancel(SkillSlot.Utility);

            var retry = processor.TryBegin(new SkillCommand(SkillSlot.Utility, 4f, 8f));
            Assert.That(accepted.Accepted, Is.True);
            Assert.That(retry.Accepted, Is.True);
        }
    }
}
