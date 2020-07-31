using System;
using Foundation;
using System.Collections.Generic;
using SceneKit;
using UIKit;
using ARKit;

namespace arsample2
{
    public class SceneViewDelegate : ARSCNViewDelegate
    {
        private readonly IDictionary<NSUuid, PlaneNode> planeNodes = new Dictionary<NSUuid, PlaneNode>();

        public override void DidAddNode(ISCNSceneRenderer renderer, SCNNode node, ARAnchor anchor)
        {
            if (anchor is ARPlaneAnchor planeAnchor)
            {
                UIColor colour;

                if (planeAnchor.Alignment == ARPlaneAnchorAlignment.Vertical)
                {
                    colour = UIColor.Red;
                }
                else
                {
                    colour = UIColor.Blue;
                }

                var planeNode = new PlaneNode(planeAnchor, colour);
                var angle = (float)(-Math.PI / 2);
                planeNode.EulerAngles = new SCNVector3(angle, 0, 0);

                node.AddChildNode(planeNode);
                this.planeNodes.Add(anchor.Identifier, planeNode);
            }
        }

        public override void DidRemoveNode(ISCNSceneRenderer renderer, SCNNode node, ARAnchor anchor)
        {
            if (anchor is ARPlaneAnchor planeAnchor)
            {
                this.planeNodes[anchor.Identifier].RemoveFromParentNode();
                this.planeNodes.Remove(anchor.Identifier);
            }
        }

        public override void DidUpdateNode(ISCNSceneRenderer renderer, SCNNode node, ARAnchor anchor)
        {
            if (anchor is ARPlaneAnchor planeAnchor)
            {
                this.planeNodes[anchor.Identifier].Update(planeAnchor);
            }
        }
    }
}