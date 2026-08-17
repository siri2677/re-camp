using System;
using ReCamp.Domain;

namespace ReCamp.UnityAdapter
{
    /// <summary>Presentation-safe snapshot of a settled run.</summary>
    public sealed class RunSettlementViewData
    {
        internal RunSettlementViewData(RunResolvedEvent settlement)
        {
            RunId = settlement.RunId;
            Outcome = settlement.Outcome;
            PreservesRewards = settlement.PreservesRewards;
            Scrap = settlement.Scrap;
            Rations = settlement.Rations;
            DataFragments = settlement.DataFragments;
        }

        public int RunId { get; private set; }
        public RunOutcome Outcome { get; private set; }
        public bool PreservesRewards { get; private set; }
        public int Scrap { get; private set; }
        public int Rations { get; private set; }
        public int DataFragments { get; private set; }
        public int Total => Scrap + Rations + DataFragments;
    }

    public static class RunSettlementViewAdapter
    {
        public static RunSettlementViewData Create(RunResolvedEvent settlement)
        {
            if (settlement == null) throw new ArgumentNullException(nameof(settlement));
            return new RunSettlementViewData(settlement);
        }
    }
}
