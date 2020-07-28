using System;
using ARKit;
using SceneKit;
using UIKit;

namespace ARSample.iOS
{
    public partial class AboutViewController : UIViewController
    {
        public AboutViewModel ViewModel { get; set; }
        public AboutViewController(IntPtr handle) : base(handle)
        {
            ViewModel = new AboutViewModel();
        }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            Title = ViewModel.Title;

            AppNameLabel.Text = "ARSample";
            VersionLabel.Text = "1.0";
            AboutTextView.Text = "This app is written in C# and native APIs using the Xamarin Platform. It shares code with its iOS, Android, & Windows versions.";

            ARSCNView SceneView = (View as ARSCNView);

            // Create a new scene
            var scene = SCNScene.FromFile("3DModels.scnassets/window");

            // Set the scene to the view
            SceneView.Scene = scene;
        }

        partial void ReadMoreButton_TouchUpInside(UIButton sender) => ViewModel.OpenWebCommand.Execute(null);
    }
}
