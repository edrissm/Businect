//
//  ViewController.swift
//  ARBusinect
//
// Created by Nina, Edriss, Muqarab and Max
// Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import AVFoundation

// ViewController, welche die Kamera öffnet und automatisch nach QR-Codes scannt und diese mit den Nutzerinformationen augmented anzeigt.
class ARViewController: UIViewController, ARSCNViewDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var backview: UIView!
    
    var refName: DatabaseReference!
    var user = [NameModel]()
    var tempVorname = ""
    var tempName = ""
    var tempBeruf = ""
    var tempBranche = ""
    var tempInteresse1 = ""
    var tempInteresse2 = ""
    var tempVerfuegbarkeit = true
    
   
    var video = AVCaptureVideoPreviewLayer()
   
    // Zeigt die eigenen Benutzerinformationen augmented an.
    // Created by Nina, Edriss and Muqarab
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
         let session = AVCaptureSession()
         
        
         let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)!
         
        
         do{
         let input = try AVCaptureDeviceInput(device: captureDevice)
         session.addInput(input)
         }
         catch{
         print("ERROR")
         }
         
         let output = AVCaptureMetadataOutput()
         //add the session
         session.addOutput(output)
         output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
         output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
         video = AVCaptureVideoPreviewLayer(session: session)
         video.frame = backview.layer.bounds
         backview.layer.addSublayer(video)
        backview.isHidden = false
         session.startRunning()
 
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    
    }
   
    func session(_ session: ARSession, didFailWithError error: Error) {
       
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        
        
    }
 
    // Falls ein QR Code erkannt wurde, wird eine Benachrichtigung mit dessen Inhalt ausgegeben als eine Benachrichtigung.
    // Created by Edriss
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    var data: String? = object.stringValue // {Some "Hallo"}
                    var newString: String = data! // Hallo
                    
                    
                    let configuration = ARWorldTrackingConfiguration()
                    
                sceneView.session.run(configuration)
                    
                    backview.isHidden = true
                    
                    //Firebase Benutzerdaten runterladen
                    refName = Database.database().reference().child("Benutzer");
                    refName.observe(DataEventType.value, with: { (snapshot) in
                       
//                        var ai = "Benutzer/"
//                        ai += neuerString
//                        ai += "/Vorname"
//                        var bi = "Benutzer/"
//                        bi += neuerString
//                        bi += "/Name"
//
//                              let ref = Database.database().reference()
//                        ref.child(ai).observeSingleEvent(of: .value) { (snapshot) in
//                                 let data = snapshot.value as? String
//                                let tempVorname = data!
//
                        
                        if snapshot.childrenCount > 0 {
                            self.user.removeAll()
                            let name = snapshot.childSnapshot(forPath: newString ?? "noDisplayName")
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
                            let Verfuegbarkeit = nameObject?["Verfuegbarkeit"]

                            let userData = NameModel(Beruf: Beruf as? String, Vorname: Vorname as? String, Id: Id as? String, Branche: Branche as? String, EMail: EMail as? String, Interesse1: Interesse1 as? String, Interesse2: Interesse2 as? String, Name: Name as? String, Passwort: Passwort as? String, Verfuegbarkeit: Verfuegbarkeit as? Bool)

                            self.tempVorname = userData.vorname!
                            self.tempName = userData.name!
                            self.tempBeruf =  userData.beruf!
                            self.tempBranche = userData.branche!
                            self.tempInteresse1 = userData.interesse1!
                            self.tempInteresse2 = userData.interesse2!
                            self.tempVerfuegbarkeit = userData.verfuegbarkeit!
//
                            
                            let material = SCNMaterial()
                            if self.tempVerfuegbarkeit==true{
//                                let text = SCNText(string: tempVorname + tempName, extrusionDepth: 1)
                                let text = SCNText(string: "Vorname: " + self.tempVorname + "\nName: " + self.tempName + "\nBeruf: " + self.tempBeruf + "\nBranche: " + self.tempBranche + "\nInteressen: " + self.tempInteresse1 + "& " + self.tempInteresse2, extrusionDepth: 1)
//                                print(self.tempVorname)
                                material.diffuse.contents = UIColor.green
                                text.materials = [material]
                                let node = SCNNode()
                                node.position = SCNVector3(x: 0, y: 0.02, z: -0.1)
                                node.scale = SCNVector3(x: 0.001, y: 0.001, z: 0.001)
                                node.geometry = text
                                self.sceneView.scene.rootNode.addChildNode(node)
                                self.sceneView.autoenablesDefaultLighting = true
//                                self.user.append(userData)
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
//                                self.user.append(userData)
                            }
                        }
                    })
                    sceneView.delegate = self
                    
                   
                }
                }
        }
    }
}
