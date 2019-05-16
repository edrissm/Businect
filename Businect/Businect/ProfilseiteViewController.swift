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

class ProfilseiteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var refName: DatabaseReference!
    
    @IBOutlet weak var tblName: UITableView!
    
    
    @IBOutlet weak var downloadImage: UIImageView!
    
    var benutzerList = [NameModel]()
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return benutzerList.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //creating a cell using the custom class
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        //the artist object
        let name: NameModel
        
        //getting the artist of selected position
        name = benutzerList[indexPath.row]
        
        //adding values to labels
        cell.lblVorname.text = name.Vorname
        cell.lblBeruf.text = name.Beruf
        cell.lblBranche.text = name.Branche
        cell.lblEMail.text = name.EMail
        cell.lblInteresse1.text = name.Interesse1
        cell.lblInteresse2.text = name.Interesse2
        cell.lblName.text = name.Name
        cell.lblPasswort.text = name.Passwort
        
        //returning cell
        return cell
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        refName = Database.database().reference().child("Name");
        
        //observing the data changes
        refName.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.benutzerList.removeAll()
                //iterating through all the values
                for name in snapshot.children.allObjects as! [DataSnapshot] {
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
                    
                    self.benutzerList.append(benutzer)
                }
                //reloading the tableview
                self.tblName.reloadData()
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
        let downloadImageRef = imageReference.child("Profilbild.png")
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
