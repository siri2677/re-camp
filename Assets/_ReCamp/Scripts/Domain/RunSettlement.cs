using System;

namespace ReCamp.Domain
{
    /// <summary>Portable command emitted when a run reaches a terminal outcome.</summary>
    public sealed class ResolveRunCommand
    {
        public ResolveRunCommand(int runId, RunOutcome outcome, int scrap, int rations, int dataFragments)
        {
            if (runId <= 0) throw new ArgumentOutOfRangeException(nameof(runId));
            if (scrap < 0) throw new ArgumentOutOfRangeException(nameof(scrap));
            if (rations < 0) throw new ArgumentOutOfRangeException(nameof(rations));
            if (dataFragments < 0) throw new ArgumentOutOfRangeException(nameof(dataFragments));

            RunId = runId;
            Outcome = outcome;
            Scrap = scrap;
            Rations = rations;
            DataFragments = dataFragments;
        }

        public int RunId { get; private set; }
        public RunOutcome Outcome { get; private set; }
        public int Scrap { get; private set; }
        public int Rations { get; private set; }
        public int DataFragments { get; private set; }
    }

    /// <summary>Immutable result of applying the run settlement policy.</summary>
    public sealed class RunResolvedEvent
    {
        internal RunResolvedEvent(int runId, RunOutcome outcome, int scrap, int rations, int dataFragments)
        {
            RunId = runId;
            Outcome = outcome;
            Scrap = scrap;
            Rations = rations;
            DataFragments = dataFragments;
        }

        public int RunId { get; private set; }
        public RunOutcome Outcome { get; private set; }
        public int Scrap { get; private set; }
        public int Rations { get; private set; }
        public int DataFragments { get; private set; }
        public int Total => Scrap + Rations + DataFragments;
        public bool PreservesRewards => Outcome != RunOutcome.Defeated;
    }

    /// <summary>Single owner for terminal run reward policy.</summary>
    public static class RunSettlementPolicy
    {
        public static RunResolvedEvent Resolve(ResolveRunCommand command)
        {
            if (command == null) throw new ArgumentNullException(nameof(command));

            if (command.Outcome == RunOutcome.Defeated)
            {
                return new RunResolvedEvent(command.RunId, command.Outcome, 0, 0, 0);
            }

            return new RunResolvedEvent(
                command.RunId,
                command.Outcome,
                command.Scrap,
                command.Rations,
                command.DataFragments);
        }
    }
}
