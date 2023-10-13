//
//  ViewController.swift
//  World Tracking
//
//  Created by Patrycja Chrzaszcz on 08/10/2023.
//

import UIKit
import ARKit
class ViewController: UIViewController {

    @IBOutlet weak var sceneView: ARSCNView!
    //Tracks orientation
    let configuration = ARWorldTrackingConfiguration()
    override func viewDidLoad() {
        super.viewDidLoad()
        //Debug options
        //If world was developed correctly
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
        //allows for light reflected off a surface
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    func restartSession(){
        self.sceneView.session.pause()
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    @IBAction func reset(_ sender: Any) {
        //pauses the current session
        self.restartSession()
        //remove box
        self.sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
        //node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
       //node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.1, height: 0.3)
        //node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
        //chamferRadius cuts off bits from the box to give a rounder edge
//        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1/2)
//        node.geometry = SCNSphere(radius: 0.1)
//        node.geometry = SCNTube(innerRadius: 0.2, outerRadius: 0.3, height: 0.5)
        //node.geometry = SCNTorus(ringRadius: 0.3, pipeRadius: 0.1)
        //flat surface ( looks like a 2d box )
        //node.geometry = SCNPlane(width: 0.2, height: 0.2)
        //node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
        
        //adding shapes onto each other
        //house shape
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x:0, y:0.2))
        path.addLine(to: CGPoint(x:0.2, y:0.3))
        path.addLine(to: CGPoint(x:0.4, y:0.2))
        path.addLine(to: CGPoint(x: 0.4, y: 0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape

//        light reflected off a surface
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
//        Colour is blue
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
                
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //3D Vector X,Y,Z
        node.position = SCNVector3(0,0,-0.7)
        //Scene is whats displaying the camera view of real world
        //Node is inside scene
        //Root node has no shape, size or colour
        //positioned where world origin (starting position)
        
        //Node is inside camera view
        self.sceneView.scene.rootNode.addChildNode(node)
    }
}

