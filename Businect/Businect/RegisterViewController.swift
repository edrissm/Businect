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

// Dieser ViewController erstellt einen neuen Benutzer in der Firebase Authentication
// und erstellt einen Datensatz in der Firebase Database mit allen Attributen die eingeben werden
// müssen.
class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var refName: DatabaseReference!
    @IBOutlet weak var textFieldName: UITextField!
    
    @IBOutlet weak var textFieldVorname: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var textFieldPasswort: UITextField!
    
    @IBOutlet weak var textFieldBeruf: UITextField!
    @IBOutlet weak var textFielBranche: UITextField!
    @IBOutlet weak var textFieldInteresse1: UITextField!
    
    @IBOutlet weak var textFieldInteresse2: UITextField!
    
    @IBOutlet weak var buttonEnablen: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    // Leitet weiter auf die Seite zum "Profilbild hochladen" und gibt dem neuen Nutzer
    // als Attribut dessen Vor- und Nachname mit.
    @IBAction func Weiter(_ sender: Any) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = textFieldVorname.text!+textFieldName.text!
        changeRequest?.commitChanges { (error) in
            // ...
            print("Error in displayrewuest")
        }
    }
    
    // Prueft ob die eingegebene Email-Adresse zulaessig ist
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    // Prueft ob alle Informationen für das Profil eingegeben wurden und erstellt dann das Profil.
    // Der Weiter-Button wird dann angezeigt.
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
    
    // Registrierseite wird geladen
    override func viewDidLoad() {
        super.viewDidLoad()
        Weiter.isEnabled = false
        buttonEnablen.isEnabled = true
        refName = Database.database().reference().child("Benutzer")
        
        // Do any additional setup after loading the view.
    }
    
    // Erstellt einen neuen Benutzer in der Firebase Authentication mit Email-Adresse und Passwort.
    // Dazu wird in der Firebase Database ein Datensatz mit allen Informationen des Benutzers unter
    // der ID des Vor- und Nachenamen gespeichert.
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
                    "Interesse2": textFieldInteresse2.text! as String,
                    "Verfuegbarkeit": true as Bool,
            ] as [String : Any]
       
        refName.child(textFieldVorname.text!+textFieldName.text! as String).setValue(name)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField==textFieldName{
            textFieldVorname.becomeFirstResponder()
        } else if textField==textFieldVorname{
            textFieldEmail.becomeFirstResponder()
        } else if textField==textFieldEmail{
            textFieldPasswort.becomeFirstResponder()
        } else if textField==textFieldPasswort{
            textFielBranche.becomeFirstResponder()
        } else if textField==textFielBranche{
            textFieldBeruf.becomeFirstResponder()
        } else if textField==textFieldBeruf{
            textFieldInteresse1.becomeFirstResponder()
        } else if textField==textFieldInteresse1{
            textFieldInteresse2.becomeFirstResponder()
        } else{
            textFieldInteresse2.resignFirstResponder()
        }
        return true
    }
}
