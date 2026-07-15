using System;

namespace ReCamp.Item
{
    [Serializable]
    public sealed class ResourceLedger
    {
        public int Scrap { get; private set; }
        public int Food { get; private set; }
        public int DataFragments { get; private set; }
        public int Total => Scrap + Food + DataFragments;

        public void Add(ResourceType type, int amount)
        {
            switch (type)
            {
                case ResourceType.Scrap:
                    Scrap = Math.Max(0, Scrap + amount);
                    break;
                case ResourceType.Food:
                    Food = Math.Max(0, Food + amount);
                    break;
                case ResourceType.DataFragment:
                    DataFragments = Math.Max(0, DataFragments + amount);
                    break;
            }
        }

        public bool TrySpend(ResourceType type, int amount)
        {
            amount = Math.Max(0, amount);
            var available = Get(type);
            if (available < amount)
            {
                return false;
            }

            Add(type, -amount);
            return true;
        }

        public int Get(ResourceType type)
        {
            return type switch
            {
                ResourceType.Scrap => Scrap,
                ResourceType.Food => Food,
                ResourceType.DataFragment => DataFragments,
                _ => 0,
            };
        }

        public ResourceLedger Clone()
        {
            var copy = new ResourceLedger();
            copy.Add(ResourceType.Scrap, Scrap);
            copy.Add(ResourceType.Food, Food);
            copy.Add(ResourceType.DataFragment, DataFragments);
            return copy;
        }

        public string ToSummary()
        {
            return $"Scrap {Scrap}  Food {Food}  Data {DataFragments}";
        }
    }
}
