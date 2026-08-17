using System;

namespace ReCamp.UnityAdapter
{
    /// <summary>Normalized canvas anchors calculated from a device safe-area rectangle.</summary>
    public readonly struct SafeAreaAnchorData
    {
        public SafeAreaAnchorData(float minX, float minY, float maxX, float maxY)
        {
            MinX = minX;
            MinY = minY;
            MaxX = maxX;
            MaxY = maxY;
        }

        public float MinX { get; }
        public float MinY { get; }
        public float MaxX { get; }
        public float MaxY { get; }
    }

    /// <summary>Pure safe-area math so aspect ratios and cutouts can be tested without a device.</summary>
    public static class SafeAreaLayout
    {
        public static SafeAreaAnchorData Calculate(
            int screenWidth,
            int screenHeight,
            int safeX,
            int safeY,
            int safeWidth,
            int safeHeight)
        {
            if (screenWidth <= 0 || screenHeight <= 0)
            {
                return new SafeAreaAnchorData(0f, 0f, 1f, 1f);
            }

            var minX = Clamp01((float)safeX / screenWidth);
            var minY = Clamp01((float)safeY / screenHeight);
            var maxX = Clamp01((float)(safeX + Math.Max(0, safeWidth)) / screenWidth);
            var maxY = Clamp01((float)(safeY + Math.Max(0, safeHeight)) / screenHeight);
            if (maxX < minX) maxX = minX;
            if (maxY < minY) maxY = minY;
            return new SafeAreaAnchorData(minX, minY, maxX, maxY);
        }

        private static float Clamp01(float value)
        {
            return Math.Max(0f, Math.Min(1f, value));
        }
    }
}
