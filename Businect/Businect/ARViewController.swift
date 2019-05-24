//
//  ViewController.swift
//  ARBusinect
//
//  Created by Muqarab Afzal on 24.05.19.
//  Copyright © 2019 Muqarab Afzal. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var refName: DatabaseReference!
    var benutzerList = [NameModel]()
    let Vorname = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase Benutzerdaten runterladen
        refName = Database.database().reference().child("Benutzer");
        refName.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.benutzerList.removeAll()
                let name = snapshot.childSnapshot(forPath: Auth.auth().currentUser?.displayName ?? "noDisplayName")
                let nameObject = name.value as? [String: AnyObject]
                let Beruf  = nameObject?["Beruf"]
                let Vorname  = nameObject?["Vorname"]
                let Id = nameObject?["Id"]
                let Branche = nameObject?["Branche"]
                let EMail = nameObject?["EMail"]
                let Interesse1 = nameObject?["Interesse1"]
                let Interesse2 = nameObject?["Interesse2"]
                let Name = nameObject?["Name"]
                let Passwort = nameObject?["Passwort"]
                
                let benutzer = NameModel(Beruf: Beruf as? String, Vorname: Vorname as? String, Id: Id as? String, Branche: Branche as? String, EMail: EMail as? String, Interesse1: Interesse1 as? String, Interesse2: Interesse2 as? String, Name: Name as? String, Passwort: Passwort as? String)
                
                self.benutzerList.append(benutzer)
            }
        })
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //        sceneView.showsStatistics = true
        //
        //        // Create a new scene
        //        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        //
        //        // Set the scene to the view
        //        sceneView.scene = scene
        let text = SCNText(string:Vorname, extrusionDepth: 1)
        
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.green
        text.materials = [material]
        
        let node = SCNNode()
        node.position = SCNVector3(x: 0, y: 0.02, z: -0.1)
        node.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
        node.geometry = text
        sceneView.scene.rootNode.addChildNode(node)
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
