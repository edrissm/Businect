//
//  LoginPageViewController.swift
//  Businect
// Created by Nina and Edriss
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import FirebaseAuth

// Der LoginPageViewController zeigt ein Anmeldefenster mit Eingabe der Email und des Passwortes.
// Nur registrierte Nutzer, die in der Firebase Authentication registriert wurden, koennen sich anmelden.
class LoginPageViewController: UIViewController, UITextFieldDelegate {

  
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    // Anmeldefenster wird geladen
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // Wenn der Button "Anmelden" geklickt wird, oeffnet sich die Startseite und der User ist eingeloggt.
    // Bei fehlgeschlagenem Anmeldeversuch wird ein Error ausgegeben.
    // Created by Nina and Edriss
    @IBAction func loginClickButton(_ sender: Any) {
        print("Login Button clicked")
            if(usernameTextField.text != "" && passwordTextField.text != ""){
            Auth.auth().signIn(withEmail: usernameTextField.text!, password: passwordTextField.text!){
                (user, error) in
                
              if(user != nil){
                    print("user authenticated")
                self.presentingViewController?.dismiss(animated: true, completion: nil)
                } else{
                    print("there was an error")
                    self.errorLabel.isHidden = false
               }
            }
        } else {
            print("there was an error")
            self.errorLabel.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Created by Nina and Edriss
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField==usernameTextField{
            passwordTextField.becomeFirstResponder()
        } else{
            passwordTextField.resignFirstResponder()
        }
        return true
    }
}
