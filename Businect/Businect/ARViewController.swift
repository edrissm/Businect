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

// ViewController, welche die Kamera öffnet und automatisch nach QR-Codes scannt und diese mit den Nutzerinformationen augmented anzeigt.
class ARViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    
    var refName: DatabaseReference!
    var user = [NameModel]()
    var tempVorname = ""
    var tempName = ""
    var tempBeruf = ""
    var tempBranche = ""
    var tempInteresse1 = ""
    var tempInteresse2 = ""
    var tempVerfügbarkeit = true
   
    // Zeigt die eigenen Benutzerinformationen augmented an.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Firebase Benutzerdaten runterladen
        refName = Database.database().reference().child("Benutzer");
        refName.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                self.user.removeAll()
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
                let Verfuegbarkeit = nameObject?["Verfügbarkeit"]
                 
                let userData = NameModel(Beruf: Beruf as? String, Vorname: Vorname as? String, Id: Id as? String, Branche: Branche as? String, EMail: EMail as? String, Interesse1: Interesse1 as? String, Interesse2: Interesse2 as? String, Name: Name as? String, Passwort: Passwort as? String, Verfuegbarkeit: Verfuegbarkeit as? Bool)
                
                self.tempVorname = userData.Vorname!
                self.tempName = userData.Name!
                self.tempBeruf =  userData.Beruf!
                self.tempBranche = userData.Branche!
                self.tempInteresse1 = userData.Interesse1!
                self.tempInteresse2 = userData.Interesse2!
                self.tempVerfügbarkeit = userData.Verfuegbarkeit!
                
                
                let material = SCNMaterial()
                if self.tempVerfügbarkeit==true{
                    let text = SCNText(string: "Vorname: " + self.tempVorname + "\nName: " + self.tempName + "\nBranche: " + self.tempBranche + "\nInteressen: " + self.tempInteresse1 + "," + self.tempInteresse2, extrusionDepth: 1)
                    print(self.tempVorname)
                    material.diffuse.contents = UIColor.green
                    text.materials = [material]
                    let node = SCNNode()
                    node.position = SCNVector3(x: 0, y: 0.02, z: -0.1)
                    node.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
                    node.geometry = text
                    self.sceneView.scene.rootNode.addChildNode(node)
                    self.sceneView.autoenablesDefaultLighting = true
                    self.user.append(userData)
                } else{
                    let text = SCNText(string: "Nicht Verfügbar", extrusionDepth: 1)
                    print(self.tempVorname)
                    material.diffuse.contents = UIColor.red
                    text.materials = [material]
                    let node = SCNNode()
                    node.position = SCNVector3(x: 0, y: 0.02, z: -0.1)
                    node.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
                    node.geometry = text
                    self.sceneView.scene.rootNode.addChildNode(node)
                    self.sceneView.autoenablesDefaultLighting = true
                    self.user.append(userData)
                }
            }
        })
        sceneView.delegate = self
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
