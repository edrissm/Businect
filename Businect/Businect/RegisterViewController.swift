//
//  RegisterViewController.swift
//  Businect
//
//  Created by Muqarab Afzal on 07.05.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class RegisterViewController: UIViewController {
    var refName: DatabaseReference!
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldVorname: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPasswort: UITextField!
    
    @IBOutlet weak var textFieldBeruf: UITextField!
    @IBOutlet weak var textFielBranche: UITextField!
    @IBOutlet weak var textFieldInteresse1: UITextField!
    
    @IBOutlet weak var textFieldInteresse2: UITextField!
    @IBOutlet weak var labelmessage: UILabel!
    @IBAction func buttonAddUser(_ sender: UIButton) {
        addName()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refName = Database.database().reference().child("Name")
        
        // Do any additional setup after loading the view.
    }
    
    func addName(){
        let key = refName.childByAutoId().key
        
        let name = ["id":key,
                    "Name": textFieldName.text! as String,
                    "Vorname": textFieldVorname.text! as String,
                    "EMail": textFieldEmail.text! as String,
                    "Passwort": textFieldPasswort.text! as String,
                    "Branche": textFielBranche.text! as String,
                    "Beruf": textFieldBeruf.text! as String,
                    "Interesse1": textFieldInteresse1.text! as String,
                    "Interesse2": textFieldInteresse2.text! as String
        ]
        
        refName.child(key!).setValue(name)
        
        Auth.auth().createUser(withEmail: textFieldEmail.text! as String, password: textFieldPasswort.text! as String)
        
        
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
