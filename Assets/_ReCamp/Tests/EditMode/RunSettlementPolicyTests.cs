using NUnit.Framework;
using ReCamp.Domain;

namespace ReCamp.Tests.EditMode
{
    public sealed class RunSettlementPolicyTests
    {
        [Test]
        public void ExtractedRun_PreservesAllRewards()
        {
            var result = RunSettlementPolicy.Resolve(
                new ResolveRunCommand(RunOutcome.Extracted, 5, 3, 2));

            Assert.That(result.Outcome, Is.EqualTo(RunOutcome.Extracted));
            Assert.That(result.PreservesRewards, Is.True);
            Assert.That(result.Scrap, Is.EqualTo(5));
            Assert.That(result.Rations, Is.EqualTo(3));
            Assert.That(result.DataFragments, Is.EqualTo(2));
            Assert.That(result.Total, Is.EqualTo(10));
        }

        [Test]
        public void ExpiredRun_PreservesAllRewardsForForcedReturn()
        {
            var result = RunSettlementPolicy.Resolve(
                new ResolveRunCommand(RunOutcome.Expired, 4, 1, 6));

            Assert.That(result.Outcome, Is.EqualTo(RunOutcome.Expired));
            Assert.That(result.PreservesRewards, Is.True);
            Assert.That(result.Total, Is.EqualTo(11));
        }

        [Test]
        public void DefeatedRun_DiscardsTemporaryRewards()
        {
            var result = RunSettlementPolicy.Resolve(
                new ResolveRunCommand(RunOutcome.Defeated, 9, 8, 7));

            Assert.That(result.Outcome, Is.EqualTo(RunOutcome.Defeated));
            Assert.That(result.PreservesRewards, Is.False);
            Assert.That(result.Total, Is.Zero);
        }

        [Test]
        public void ResolveRunCommand_RejectsNegativeRewards()
        {
            Assert.That(
                () => new ResolveRunCommand(RunOutcome.Extracted, -1, 0, 0),
                Throws.TypeOf<System.ArgumentOutOfRangeException>());
        }
    }
}
