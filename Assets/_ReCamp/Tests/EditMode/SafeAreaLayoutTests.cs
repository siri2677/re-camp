using NUnit.Framework;
using ReCamp.UnityAdapter;

namespace ReCamp.Tests.EditMode
{
    public sealed class SafeAreaLayoutTests
    {
        [Test]
        public void LandscapeCutouts_ConvertToNormalizedAnchors()
        {
            var anchors = SafeAreaLayout.Calculate(1920, 1080, 96, 24, 1728, 1032);

            Assert.That(anchors.MinX, Is.EqualTo(0.05f).Within(0.0001f));
            Assert.That(anchors.MinY, Is.EqualTo(24f / 1080f).Within(0.0001f));
            Assert.That(anchors.MaxX, Is.EqualTo(0.95f).Within(0.0001f));
            Assert.That(anchors.MaxY, Is.EqualTo(1056f / 1080f).Within(0.0001f));
        }

        [Test]
        public void InvalidScreenFallsBackToFullCanvas()
        {
            var anchors = SafeAreaLayout.Calculate(0, 0, 10, 10, 100, 100);

            Assert.That(anchors.MinX, Is.Zero);
            Assert.That(anchors.MinY, Is.Zero);
            Assert.That(anchors.MaxX, Is.EqualTo(1f));
            Assert.That(anchors.MaxY, Is.EqualTo(1f));
        }

        [Test]
        public void OutOfBoundsSafeAreaIsClampedAndOrdered()
        {
            var anchors = SafeAreaLayout.Calculate(1000, 500, -100, 600, -50, -20);

            Assert.That(anchors.MinX, Is.EqualTo(0f));
            Assert.That(anchors.MinY, Is.EqualTo(1f));
            Assert.That(anchors.MaxX, Is.EqualTo(0f));
            Assert.That(anchors.MaxY, Is.EqualTo(1f));
        }
    }
}
