using NUnit.Framework;
using ReCamp.Domain;

namespace ReCamp.Tests.EditMode
{
    public sealed class AbilityContractsTests
    {
        [Test]
        public void UseAbilityCommand_CarriesPortableIntent()
        {
            var command = new UseAbilityCommand(2, AbilitySlot.Utility, "miyu.overclock", 10f);

            Assert.That(command.CharacterId, Is.EqualTo(2));
            Assert.That(command.Slot, Is.EqualTo(AbilitySlot.Utility));
            Assert.That(command.AbilityKey, Is.EqualTo("miyu.overclock"));
            Assert.That(command.CooldownSeconds, Is.EqualTo(10f));
        }

        [Test]
        public void AbilityResolvedEvent_PreservesCommandAndResult()
        {
            var command = new UseAbilityCommand(0, AbilitySlot.Signature, "luna.dash", 4.5f);
            var result = new AbilityResolvedEvent(command, true);

            Assert.That(result.Command, Is.SameAs(command));
            Assert.That(result.Succeeded, Is.True);
        }

        [Test]
        public void UseAbilityCommand_RejectsMissingKey()
        {
            Assert.That(
                () => new UseAbilityCommand(0, AbilitySlot.Signature, "", 1f),
                Throws.TypeOf<System.ArgumentException>());
        }
    }
}
