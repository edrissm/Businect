//
//  ProfilseiteViewController.swift
//  Businect
//  Created by Nina and Edriss
//  Copyright © 2019 Scrum-Made. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import GoogleSignIn

// Klasse, welche auf der Profilseite eines Nenutzers der Businect-App die dazugehörigen Daten (Benutzerspezifische Daten und Foto) aus der Firebase-Datenbank anzeigt.
class ProfilePageViewController: UIViewController {
    
    var refName: DatabaseReference!
    
    @IBOutlet weak var lblVorname: UILabel!
    @IBOutlet weak var lblBeruf: UILabel!
    @IBOutlet weak var lblBranche: UILabel!
    @IBOutlet weak var lblEMail: UILabel!
    @IBOutlet weak var lblInteresse1: UILabel!
    @IBOutlet weak var lblInteresse2: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var downloadImage: UIImageView!
    
    var availability = Bool()
    
    @IBOutlet weak var switchOutlet: UISwitch!
    
    @IBOutlet weak var stateSwitch: UISwitch!
    
    // Created by Nina
    @IBAction func switchAction(_ sender: UISwitch) {
        if switchOutlet.isOn == false {
            stateSwitch.setOn(false, animated:true)
        }
        else{
            stateSwitch.setOn(true, animated:true)
        }
    }
    
    
    
    // Created by Nina
    @objc func stateChanged(switchState: UISwitch) {
        if switchState.isOn { Database.database().reference().child("Benutzer").child(Auth.auth().currentUser?.displayName ?? "noDisplayName").updateChildValues(["Verfuegbarkeit": true])
        } else {
            Database.database().reference().child("Benutzer").child(Auth.auth().currentUser?.displayName ?? "noDisplayName").updateChildValues(["Verfuegbarkeit": false])
        }
    }
    
    var user = [NameModel]()
    
    // Wenn die Seite geladen wird, werden die Benutzerspezifischen Daten aus der Firebase-Datenbank geladen. Die jeweils passenden Daten werden dabei durch die Firebase-Authentifizierung erfasst.
    // Created by Nina and Edriss
    override func viewDidLoad() {
        super.viewDidLoad()
        stateSwitch.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
        
        refName = Database.database().reference().child("Benutzer");
        refName.observe(DataEventType.value, with: { (snapshot) in
            
            
            
            if snapshot.childrenCount > 0 {
                self.user.removeAll()
                let username = snapshot.childSnapshot(forPath: Auth.auth().currentUser?.displayName ?? "noDisplayName")
                let nameObject = username.value as? [String: AnyObject]
                let beruf  = nameObject?["Beruf"]
                let vorname  = nameObject?["Vorname"]
                let id = nameObject?["Id"]
                let branche = nameObject?["Branche"]
                let eMail = nameObject?["EMail"]
                let interesse1 = nameObject?["Interesse1"]
                let interesse2 = nameObject?["Interesse2"]
                let name = nameObject?["Name"]
                let Passwort = nameObject?["Passwort"]
                let Verfuegbarkeit = nameObject?["Verfuegbarkeit"]
                
                let user = NameModel(Beruf: beruf as? String, Vorname: vorname as? String, Id: id as? String, Branche: branche as? String, EMail: eMail as? String, Interesse1: interesse1 as? String, Interesse2: interesse2 as? String, Name: name as? String, Passwort: Passwort as? String, Verfuegbarkeit: Verfuegbarkeit as? Bool)
                
                self.lblVorname.text = user.vorname
                self.lblBeruf.text = user.beruf
                self.lblBranche.text = user.branche
                self.lblEMail.text = user.eMail
                self.lblInteresse1.text = user.interesse1
                self.lblInteresse2.text = user.interesse2
                self.lblName.text = user.name
                self.availability = user.verfuegbarkeit ?? true
                
                if(user.verfuegbarkeit == false){
                    print("hallo")
                    self.stateSwitch.setOn(false, animated:true)
                }else {
                    self.stateSwitch.setOn(true, animated:true)
                }
                self.user.append(user)
            }
        })
    }
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    // Wenn man auf den Button "Profilgoto anzeigen" klickt, wird das Profulfoto des eingeloggten Nutzers im UIImageVeiw angezeigt.
    // Created by Nina
    @IBAction func onDownloadTapped(_ sender: Any) {
        var imageName : String = ""
        imageName = Auth.auth().currentUser?.email ?? ""
        let fileFormat = ".png"
        let downloadImageRef = imageReference.child(imageName+fileFormat)
        let downloadTask = downloadImageRef.getData(maxSize: 1024 * 10 * 12) { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                self.downloadImage.image = image
            }
            print (error ?? "NO ERROR")
        }
        downloadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        downloadTask.resume()
    }
    
    
    
}
