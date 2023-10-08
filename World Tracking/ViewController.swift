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
        //cuts off bits from the box to give a rounder edge
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.1/2)
        //light reflected off a surface
        node.geometry?.firstMaterial?.specular.contents = UIColor.white
        //Colour is blue
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        
        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
        //3D Vector X,Y,Z
        node.position = SCNVector3(x,y,z)
        //Scene is whats displaying the camera view of real world
        //Node is inside scene
        //Root node has no shape, size or colour
        //positioned where world origin (starting position)
        
        //Node is inside camera view
        self.sceneView.scene.rootNode.addChildNode(node)
    }
}

