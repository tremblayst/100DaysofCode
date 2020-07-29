using System;
using System.IO;
using System.Linq;
using NUnit.Framework;
using Xamarin.UITest;
using Xamarin.UITest.iOS;
using Xamarin.UITest.Queries;

namespace arsample2.UITests
{
    [TestFixture]
    public class Tests
    {
        iOSApp app;

        [SetUp]
        public void BeforeEachTest()
        {
            app = ConfigureApp.iOS.StartApp();
        }

        [Test]
        public void MainScreenIsDisplayed()
        {
            AppResult[] results = app.WaitForElement(c => c.Class("SCNView"));
            app.Screenshot("Main screen");

            Assert.IsTrue(results.Any());
        }
    }
}

