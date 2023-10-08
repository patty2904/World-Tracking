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
    
    @IBAction func add(_ sender: Any) {
        print("button has been pressed")
        // Specify the URL of the USDZ file
        if let usdzURL = URL(string: "https://developer.apple.com/augmented-reality/quick-look/models/nike-pegasus/sneaker_pegasustrail.usdz") {
            let task = URLSession.shared.dataTask(with: usdzURL) { (data, response, error) in
                if let data = data, error == nil {
                    // Create a temporary file URL to save the downloaded USDZ file
                    let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                    let tempUSDZURL = documentsURL.appendingPathComponent("temp_usdz_file.usdz")
                    
                    do {
                        try data.write(to: tempUSDZURL)
                        
                        let referenceNode = SCNReferenceNode(url: tempUSDZURL)
                        
                        // Check if the reference node was successfully created
                        if let referenceNode = referenceNode {
                            referenceNode.load()
                            
                            // Scale the reference node to make it smaller
                            let scale = SCNVector3(0.01, 0.01, 0.01) // Adjust the scale as needed
                            referenceNode.scale = scale
                            
                            // Set the position for your USDZ object
                            referenceNode.position = SCNVector3(0, 0, 0) // Adjust the position as needed
                            
                            // Add the reference node to the scene
                            DispatchQueue.main.async {
                                self.sceneView.scene.rootNode.addChildNode(referenceNode)
                            }
                        } else {
                            print("Failed to create reference node for USDZ file.")
                        }
                    } catch {
                        print("Error saving USDZ file to a temporary location: \(error)")
                    }
                } else {
                    print("Error downloading the USDZ file: \(error?.localizedDescription ?? "Unknown error")")
                }
            }
            task.resume()
        } else {
            print("Invalid URL for the USDZ file.")
        }
    }
}

