using System;
using System.Collections.Generic;
using System.Linq;
using CoreGraphics;
using SceneKit;
using UIKit;
using ARKit;

namespace arsample2
{
    public partial class GameViewController : UIViewController
    {
        public ARSCNView SceneView
        {
            get { return View as ARSCNView; }
        }

        protected GameViewController(IntPtr handle) : base(handle)
        {
            // Note: this .ctor should not contain any initialization logic.
        }

        public override void DidReceiveMemoryWarning()
        {
            base.DidReceiveMemoryWarning();
            // Release any cached data, images, etc that aren't in use.
        }

        public override void ViewDidLoad()
        {
            base.ViewDidLoad();

            // Code to start the Xamarin Test Cloud Agent
#if ENABLE_TEST_CLOUD
			Xamarin.Calabash.Start();
#endif

            SceneView.Delegate = new SceneViewDelegate();

            // create a new scene
            var scene = SCNScene.FromFile("art.scnassets/ship");

            SceneView.Scene = scene;

            // create and add a camera to the scene
            //var cameraNode = SCNNode.Create();
            //cameraNode.Camera = SCNCamera.Create();
            //scene.RootNode.AddChildNode(cameraNode);

            // place the camera
            //cameraNode.Position = new SCNVector3(0, 0, 15);

            // create and add a light to the scene
            //var lightNode = SCNNode.Create();
            //lightNode.Light = SCNLight.Create();
            //lightNode.Light.LightType = SCNLightType.Omni;
            //lightNode.Position = new SCNVector3(0, 10, 10);
            //scene.RootNode.AddChildNode(lightNode);

            // create and add an ambient light to the scene
            //var ambientLightNode = SCNNode.Create();
            //ambientLightNode.Light = SCNLight.Create();
            //ambientLightNode.Light.LightType = SCNLightType.Ambient;
            //ambientLightNode.Light.Color = UIColor.DarkGray;
            //scene.RootNode.AddChildNode(ambientLightNode);

            // retrieve the ship node
            //var ship = scene.RootNode.FindChildNode("ship", true);

            // animate the 3d object
            //ship.RunAction(SCNAction.RepeatActionForever(SCNAction.RotateBy(0, 2, 0, 1)));

            // retrieve the SCNView
            //var scnView = (ARSCNView)View;

            // set the scene to the view
            //scnView.Scene = scene;

            // allows the user to manipulate the camera
            //scnView.AllowsCameraControl = true;

            // show statistics such as fps and timing information
            //scnView.ShowsStatistics = true;

            // configure the view
            //scnView.BackgroundColor = UIColor.Black;

            // add a tap gesture recognizer
            //var tapGesture = new UITapGestureRecognizer(HandleTap);
            //var gestureRecognizers = new List<UIGestureRecognizer>();
            //gestureRecognizers.Add(tapGesture);
            //gestureRecognizers.AddRange(scnView.GestureRecognizers);
            //scnView.GestureRecognizers = gestureRecognizers.ToArray();
        }

        public override void ViewWillAppear(bool animated)
        {
            base.ViewWillAppear(animated);

            // Create a session configuration
            var configuration = new ARWorldTrackingConfiguration
            {
                PlaneDetection = ARPlaneDetection.Horizontal | ARPlaneDetection.Vertical,
                WorldAlignment = ARWorldAlignment.GravityAndHeading,
                LightEstimationEnabled = true
            };

            SceneView.DebugOptions = ARSCNDebugOptions.ShowFeaturePoints;

            // Run the view's session
            SceneView.Session.Run(configuration, ARSessionRunOptions.ResetTracking);


            // Find the ship and position it just in front of the camera
            var ship = SceneView.Scene.RootNode.FindChildNode("ship", true);


            ship.Position = new SCNVector3(2f, -2f, -9f);
            //HACK: to see the jet move (circle around the viewer in a roll), comment out the ship.Position line above
            // and uncomment the code below (courtesy @lobrien)

            //var animation = SCNAction.RepeatActionForever(SCNAction.RotateBy(0, (float)Math.PI, (float)Math.PI, (float)1));
            //var pivotNode = new SCNNode { Position = new SCNVector3(0.0f, 2.0f, 0.0f) };
            //pivotNode.RunAction(SCNAction.RepeatActionForever(SCNAction.RotateBy(0, -2, 0, 10)));
            //ship.RemoveFromParentNode();
            //pivotNode.AddChildNode(ship);
            //SceneView.Scene.RootNode.AddChildNode(pivotNode);
            //ship.Scale = new SCNVector3(0.1f, 0.1f, 0.1f);
            //ship.Position = new SCNVector3(2f, -2f, -3f);
            //ship.RunAction(SCNAction.RepeatActionForever(SCNAction.RotateBy(0, 0, 2, 1)));

            //ENDHACK
        }

        public override void ViewWillDisappear(bool animated)
        {
            base.ViewWillDisappear(animated);

            // Pause the view's session
            SceneView.Session.Pause();
        }

        public override bool ShouldAutorotate()
        {
            return true;
        }

        public override UIInterfaceOrientationMask GetSupportedInterfaceOrientations()
        {
            return UIInterfaceOrientationMask.All;
        }


        void HandleTap(UIGestureRecognizer gestureRecognize)
        {
            // retrieve the SCNView
            var scnView = (SCNView)View;

            // check what nodes are tapped
            CGPoint p = gestureRecognize.LocationInView(scnView);
            SCNHitTestResult[] hitResults = scnView.HitTest(p, (SCNHitTestOptions)null);

            // check that we clicked on at least one object
            if (hitResults.Length > 0)
            {
                // retrieved the first clicked object
                SCNHitTestResult result = hitResults[0];

                // get its material
                SCNMaterial material = result.Node.Geometry.FirstMaterial;

                // highlight it
                SCNTransaction.Begin();
                SCNTransaction.AnimationDuration = 0.5f;

                // on completion - unhighlight
                SCNTransaction.SetCompletionBlock(() =>
                {
                    SCNTransaction.Begin();
                    SCNTransaction.AnimationDuration = 0.5f;

                    material.Emission.Contents = UIColor.Black;

                    SCNTransaction.Commit();
                });

                material.Emission.Contents = UIColor.Red;

                SCNTransaction.Commit();
            }
        }
    }
}
