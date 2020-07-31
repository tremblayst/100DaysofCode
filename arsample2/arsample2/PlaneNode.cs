using System;
using SceneKit;
using UIKit;
using ARKit;

namespace arsample2
{
    internal class PlaneNode : SCNNode
    {
        private readonly SCNPlane planeGeometry;

        public PlaneNode(ARPlaneAnchor planeAnchor, UIColor colour)
        {
            Geometry = (planeGeometry = CreateGeometry(planeAnchor, colour));
        }

        public void Update(ARPlaneAnchor planeAnchor)
        {
            planeGeometry.Width = planeAnchor.Extent.X;
            planeGeometry.Height = planeAnchor.Extent.Z;

            Position = new SCNVector3(
                planeAnchor.Center.X,
                planeAnchor.Center.Y,
                planeAnchor.Center.Z);
        }

        private static SCNPlane CreateGeometry(ARPlaneAnchor planeAnchor, UIColor colour)
        {
            var material = new SCNMaterial();
            material.Diffuse.Contents = colour;
            material.DoubleSided = true;
            material.Transparency = 0.8f;

            var geometry = SCNPlane.Create(planeAnchor.Extent.X, planeAnchor.Extent.Z);
            geometry.Materials = new[] { material };

            return geometry;
        }
    }
}
