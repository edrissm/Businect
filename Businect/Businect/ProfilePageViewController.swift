//
//  ProfilseiteViewController.swift
//  Businect
//  Created by Nina and Edriss
//  Copyright © 2019 Scrum-Made. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

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
    @IBOutlet weak var lblPasswort: UILabel!
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
        if switchState.isOn { Database.database().reference().child("Benutzer").child(Auth.auth().currentUser?.displayName ?? "noDisplayName").updateChildValues(["Verfügbarkeit": true])
        } else {
              Database.database().reference().child("Benutzer").child(Auth.auth().currentUser?.displayName ?? "noDisplayName").updateChildValues(["Verfügbarkeit": false])
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
                let Verfuegbarkeit = nameObject?["Verfuegbarkeit"]
                
                let benutzer = NameModel(Beruf: Beruf as? String, Vorname: Vorname as? String, Id: Id as? String, Branche: Branche as? String, EMail: EMail as? String, Interesse1: Interesse1 as? String, Interesse2: Interesse2 as? String, Name: Name as? String, Passwort: Passwort as? String, Verfuegbarkeit: Verfuegbarkeit as? Bool)
                
                self.lblVorname.text = benutzer.Vorname
                self.lblBeruf.text = benutzer.Beruf
                self.lblBranche.text = benutzer.Branche
                self.lblEMail.text = benutzer.EMail
                self.lblInteresse1.text = benutzer.Interesse1
                self.lblInteresse2.text = benutzer.Interesse2
                self.lblName.text = benutzer.Name
                self.lblPasswort.text = benutzer.Passwort
                self.availability = benutzer.Verfuegbarkeit ?? true
                    
                self.user.append(benutzer)
            }
        })
    }
   
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
    // Wenn man auf den Button "Profilgoto anzeigen" klickt, wird das Profulfoto des eingeloggten Nutzers im UIImageVeiw angezeigt.
    // Created by Nina
    @IBAction func onDownloadTapped(_ sender: Any) {
        var fotoName : String = ""
        fotoName = Auth.auth().currentUser?.email ?? ""
        let dateiFormat = ".png"
        let downloadImageRef = imageReference.child(fotoName+dateiFormat)
        let downloadtask = downloadImageRef.getData(maxSize: 1024 * 10 * 12) { (data, error) in
            if let data = data {
                let image = UIImage(data: data)
                self.downloadImage.image = image
            }
            print (error ?? "NO ERROR")
        }
        downloadtask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        downloadtask.resume()
    }
    
  

}
