//
//  ProfilseiteViewController.swift
//  Businect
//
//  Created by Edriss Mosafer on 14.05.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ProfilseiteViewController: UIViewController {
    
    var refName: DatabaseReference!
    
    @IBOutlet weak var displayNameLabel: UILabel!
    
    @IBOutlet weak var lblVorname: UILabel!
    @IBOutlet weak var lblBeruf: UILabel!
    
    @IBOutlet weak var lblBranche: UILabel!
    
    @IBOutlet weak var lblEMail: UILabel!
    @IBOutlet weak var lblInteresse1: UILabel!
    @IBOutlet weak var lblInteresse2: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPasswort: UILabel!
    
    @IBOutlet weak var downloadImage: UIImageView!
    
    var benutzerList = [NameModel]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.displayNameLabel.text = Auth.auth().currentUser?.email
        //print(Auth.auth().currentUser?.email as! String)
        //print(Auth.auth().currentUser?.displayName as! String)
        print(Auth.auth().currentUser?.displayName as Any);
        print("aajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfef")
        print(Auth.auth().currentUser?.displayName ?? "jjj")
        
       // self.VornameLabel.text=Auth.auth().currentUser?.email
        refName = Database.database().reference().child("Benutzer");
        
        //observing the data changes
        refName.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.benutzerList.removeAll()
                //iterating through all the values
                
                let name = snapshot.childSnapshot(forPath: "-Lf-WWPOihohJGbWlEua")
                
                    //getting values
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
                    
                    
                    //creating artist object with model and fetched values
                let benutzer = NameModel(Beruf: Beruf as? String, Vorname: Vorname as? String, Id: Id as? String, Branche: Branche as? String, EMail: EMail as? String, Interesse1: Interesse1 as? String, Interesse2: Interesse2 as? String, Name: Name as? String, Passwort: Passwort as? String)
                    
                    //appending it to list
               
                
                
                self.lblVorname.text = benutzer.Vorname
                self.lblBeruf.text = benutzer.Beruf
                self.lblBranche.text = benutzer.Branche
                self.lblEMail.text = benutzer.EMail
                self.lblInteresse1.text = benutzer.Interesse1
                self.lblInteresse2.text = benutzer.Interesse2
                self.lblName.text = benutzer.Name
                self.lblPasswort.text = benutzer.Passwort
                    
                self.benutzerList.append(benutzer)
                
                
                
                //reloading the tableview
               // self.tblName.reloadData()
            }
        })
        

    }
   
        
        //databaseHandle = (ref?.observe(DataEventType.value, with: { (snapshot) in
        //   let post = snapshot.value as? String
            
         //   if let actualPost = post {
       //         self.postData.append(actualPost)/
        //        self.tableView.reloadData()
       //     }
       // }))!
    
   // refHandle = postRef.observe(DataEventType.value, with: { (snapshot) in
   // let postDict = snapshot.value as? [String : AnyObject] ?? [:]
    
    
    var imageReference: StorageReference {
        return Storage.storage().reference().child("images")
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
