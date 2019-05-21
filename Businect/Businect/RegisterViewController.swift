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

/*
 override func viewWillAppear(_ animated: Bool) {
 if Auth.auth().currentUser != nil {
 self.registerButton.isEnabled = false
 self.loginButton.isEnabled = false
 self.logoutButton.isEnabled = true
 self.Profillink.isEnabled = true
 } else {
 self.registerButton.isEnabled = true
 self.loginButton.isEnabled = true
 self.logoutButton.isEnabled = false
 self.Profillink.isEnabled = false
 }
 }
 */

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
            // ...
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
        
        // Do any additional setup after loading the view.
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
   
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = "Carter Keneth"
        changeRequest?.commitChanges(completion: { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        })
    print("aajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfefaajdsnjdncfjncjenjnvjeververvewfewfewfef")
        print(Auth.auth().currentUser?.displayName as Any)
        print(Auth.auth().currentUser?.email as Any)
        if(Auth.auth().currentUser?.displayName==nil){
            print("schnil")
        }
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
