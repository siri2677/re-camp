using NUnit.Framework;
using ReCamp.Domain;
using ReCamp.UnityAdapter;

namespace ReCamp.Tests.EditMode
{
    public sealed class RunSettlementViewAdapterTests
    {
        [Test]
        public void Create_CopiesDomainSettlementIntoViewSnapshot()
        {
            var settlement = RunSettlementPolicy.Resolve(
                new ResolveRunCommand(31, RunOutcome.Expired, 3, 2, 1));

            var view = RunSettlementViewAdapter.Create(settlement);

            Assert.That(view.RunId, Is.EqualTo(31));
            Assert.That(view.Outcome, Is.EqualTo(RunOutcome.Expired));
            Assert.That(view.PreservesRewards, Is.True);
            Assert.That(view.Scrap, Is.EqualTo(3));
            Assert.That(view.Rations, Is.EqualTo(2));
            Assert.That(view.DataFragments, Is.EqualTo(1));
            Assert.That(view.Total, Is.EqualTo(6));
        }

        [Test]
        public void Create_RejectsMissingSettlement()
        {
            Assert.That(
                () => RunSettlementViewAdapter.Create(null),
                Throws.TypeOf<System.ArgumentNullException>());
        }
    }
}
