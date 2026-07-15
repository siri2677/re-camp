using System.Linq;
using NUnit.Framework;
using ReCamp.Data;

namespace ReCamp.Tests.EditMode
{
    public sealed class CharacterRosterTests
    {
        [Test]
        public void Roster_ContainsFiveCompleteAndUniqueDefinitions()
        {
            Assert.That(CharacterRoster.All, Has.Count.EqualTo(5));
            Assert.That(CharacterRoster.All.Select(definition => definition.Id).Distinct().Count(), Is.EqualTo(5));

            foreach (var definition in CharacterRoster.All)
            {
                Assert.That(definition.DisplayName, Is.Not.Empty);
                Assert.That(definition.Role, Is.Not.Empty);
                Assert.That(definition.Summary, Is.Not.Empty);
                Assert.That(definition.MaxHealth, Is.Positive);
                Assert.That(definition.MoveSpeed, Is.Positive);
                Assert.That(definition.AttackDamage, Is.Positive);
                Assert.That(definition.AttackRange, Is.Positive);
                Assert.That(definition.AttackInterval, Is.Positive);
                Assert.That(definition.SignatureAbilityName, Is.Not.Empty);
                Assert.That(definition.AbilityCooldown, Is.Positive);
            }
        }

        [Test]
        public void Roster_PreviousAndNext_WrapAtBothEnds()
        {
            Assert.That(CharacterRoster.GetPrevious(CharacterId.Luna).Id, Is.EqualTo(CharacterId.Noah));
            Assert.That(CharacterRoster.GetNext(CharacterId.Noah).Id, Is.EqualTo(CharacterId.Luna));
        }
    }
}
