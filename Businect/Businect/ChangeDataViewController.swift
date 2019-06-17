//
//  ChangeDataViewController.swift
//  Businect
//
//  Created by Nina Erlacher on 17.06.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import Firebase

class ChangeDataViewController: UIViewController {

    
    @IBOutlet weak var textFieldBeruf: UITextField!
    
    @IBOutlet weak var textFieldBranche: UITextField!
    
    @IBOutlet weak var textFieldInteresse1: UITextField!
    
    @IBOutlet weak var textFieldInteresse2: UITextField!
    
    
    
    @IBAction func changeBeruf(_ sender: Any) {
        Database.database().reference().child("Benutzer").child(Auth.auth().currentUser?.displayName ?? "noDisplayName").updateChildValues(["Beruf": textFieldBeruf.text! as String,])
    }
    
    @IBAction func changeBranche(_ sender: Any) {
        Database.database().reference().child("Benutzer").child(Auth.auth().currentUser?.displayName ?? "noDisplayName").updateChildValues(["Branche": textFieldBranche.text! as String,])
    }
    
    @IBAction func changeInteresse1(_ sender: Any) {
        Database.database().reference().child("Benutzer").child(Auth.auth().currentUser?.displayName ?? "noDisplayName").updateChildValues(["Interesse1": textFieldInteresse1.text! as String])
    }
    
    
    @IBAction func changeInteresse2(_ sender: Any) {
        Database.database().reference().child("Benutzer").child(Auth.auth().currentUser?.displayName ?? "noDisplayName").updateChildValues(["Interesse2": textFieldInteresse2.text! as String])
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
