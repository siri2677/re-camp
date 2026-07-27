using NUnit.Framework;
using ReCamp.Item;

namespace ReCamp.Tests.EditMode
{
    public sealed class ResourceLedgerTests
    {
        [Test]
        public void Add_TracksEachResourceAndTotal()
        {
            var ledger = new ResourceLedger();

            ledger.Add(ResourceType.Scrap, 3);
            ledger.Add(ResourceType.Food, 5);
            ledger.Add(ResourceType.DataFragment, 7);

            Assert.That(ledger.Scrap, Is.EqualTo(3));
            Assert.That(ledger.Food, Is.EqualTo(5));
            Assert.That(ledger.DataFragments, Is.EqualTo(7));
            Assert.That(ledger.Total, Is.EqualTo(15));
        }

        [Test]
        public void Add_NegativeAmountClampsBalanceAtZero()
        {
            var ledger = new ResourceLedger();
            ledger.Add(ResourceType.Scrap, 2);

            ledger.Add(ResourceType.Scrap, -10);

            Assert.That(ledger.Scrap, Is.Zero);
            Assert.That(ledger.Total, Is.Zero);
        }

        [Test]
        public void TrySpend_WhenBalanceIsSufficient_DeductsAndReturnsTrue()
        {
            var ledger = new ResourceLedger();
            ledger.Add(ResourceType.Food, 8);

            var spent = ledger.TrySpend(ResourceType.Food, 3);

            Assert.That(spent, Is.True);
            Assert.That(ledger.Food, Is.EqualTo(5));
        }

        [Test]
        public void TrySpend_WhenBalanceIsInsufficient_LeavesBalanceAndReturnsFalse()
        {
            var ledger = new ResourceLedger();
            ledger.Add(ResourceType.DataFragment, 2);

            var spent = ledger.TrySpend(ResourceType.DataFragment, 3);

            Assert.That(spent, Is.False);
            Assert.That(ledger.DataFragments, Is.EqualTo(2));
        }

        [Test]
        public void Clone_CopiesBalancesWithoutSharingFutureChanges()
        {
            var original = new ResourceLedger();
            original.Add(ResourceType.Scrap, 4);
            original.Add(ResourceType.Food, 2);

            var copy = original.Clone();
            copy.Add(ResourceType.Scrap, 3);

            Assert.That(original.Scrap, Is.EqualTo(4));
            Assert.That(copy.Scrap, Is.EqualTo(7));
            Assert.That(copy.Food, Is.EqualTo(2));
        }
    }
}
