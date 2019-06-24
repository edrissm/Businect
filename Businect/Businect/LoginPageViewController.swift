//
//  LoginPageViewController.swift
//  Businect
//  Created by Nina and Edriss
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn
// Der LoginPageViewController zeigt ein Anmeldefenster mit Eingabe der Email und des Passwortes.
// Nur registrierte Nutzer, die in der Firebase Authentication registriert wurden, koennen sich anmelden.
class LoginPageViewController: UIViewController, UITextFieldDelegate, GIDSignInUIDelegate{

  
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    // Anmeldefenster wird geladen
    override func viewDidLoad() {
        super.viewDidLoad()
setupGoogleButtons()
    }
    // Der Button für das Google Sign in wird erstellt und die Referenz zur Klasse App Delegate wird gebildet.
    fileprivate func setupGoogleButtons() {
      
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 440 + 66, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
         GIDSignIn.sharedInstance().uiDelegate = self
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
