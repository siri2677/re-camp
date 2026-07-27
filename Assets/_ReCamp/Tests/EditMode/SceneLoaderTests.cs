using NUnit.Framework;
using ReCamp.GameFlow;

namespace ReCamp.Tests.EditMode
{
    public sealed class SceneLoaderTests
    {
        [TestCase(GameScene.Bootstrap, "00_Bootstrap")]
        [TestCase(GameScene.Title, "01_Title")]
        [TestCase(GameScene.Lobby, "02_Lobby")]
        [TestCase(GameScene.Battle, "03_Battle")]
        [TestCase(GameScene.Result, "04_Result")]
        public void ToSceneName_ReturnsBuildSceneName(GameScene scene, string expectedName)
        {
            Assert.That(SceneLoader.ToSceneName(scene), Is.EqualTo(expectedName));
        }

        [Test]
        public void ToSceneName_WhenValueIsUnknown_FallsBackToBootstrap()
        {
            Assert.That(SceneLoader.ToSceneName((GameScene)999), Is.EqualTo("00_Bootstrap"));
        }
    }
}
