//
//  RegisterViewController.swift
//  Businect
//
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
    
    @IBOutlet weak var buttonEnablen: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBAction func Weiter(_ sender: Any) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = textFieldVorname.text!+textFieldName.text!
        changeRequest?.commitChanges { (error) in
            print("Error in displayrewuest")
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    @IBAction func buttonAddUser(_ sender: UIButton) {
        if(textFieldPasswort.text!.count > 6 && isValidEmail(testStr: textFieldEmail.text!) && textFieldInteresse2.text!.count > 0 && textFieldInteresse1.text!.count > 0 && textFieldBeruf.text!.count > 0 && textFieldName.text!.count > 0 && textFieldVorname.text!.count > 0 && textFielBranche.text!.count > 0){
            addName()
            buttonEnablen.isEnabled = true
            Weiter.isEnabled = true
        } else{
            print("there was an error")
            self.errorLabel.isHidden = false
        }
    }
    
    @IBOutlet weak var Weiter: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Weiter.isEnabled = false
        buttonEnablen.isEnabled = true
        refName = Database.database().reference().child("Benutzer")
    }
    
    
    func addName(){
        Auth.auth().createUser(withEmail: textFieldEmail.text! as String, password: textFieldPasswort.text! as String)
        
        let name = ["id": textFieldVorname.text!+textFieldName.text! as String,
                    "Name": textFieldName.text! as String,
                    "Vorname": textFieldVorname.text! as String,
                    "EMail": textFieldEmail.text! as String,
                    "Passwort": textFieldPasswort.text! as String,
                    "Branche": textFielBranche.text! as String,
                    "Beruf": textFieldBeruf.text! as String,
                    "Interesse1": textFieldInteresse1.text! as String,
                    "Interesse2": textFieldInteresse2.text! as String
        ]
        refName.child(textFieldVorname.text!+textFieldName.text! as String).setValue(name)
    }
}
