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
        // Do any additional setup after loading the view.
    }
    
    func restartSession(){
        self.sceneView.session.pause()
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
        //Box has firm edges
        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
        //Colour is blue
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
        //3D Vector X,Y,Z
        node.position = SCNVector3(0,0,-0.3)
        //Scene is whats displaying the camera view of real world
        //Node is inside scene
        //Root node has no shape, size or colour
        //positioned where world origin (starting position)
        
        //Node is inside camera view
        self.sceneView.scene.rootNode.addChildNode(node)
    }
}

