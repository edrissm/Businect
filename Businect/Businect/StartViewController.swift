//
//  StartViewController.swift
//  Businect
//
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class StartViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var Profillink: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    // Startseite wird geladen
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Prueft ob ein User angemeldet ist, und zeigt demnach die Buttons zur Profilseite
    // oder zum Anmelden bzw. Registrieren.
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

    // User wird abgemeldet und Button Anmelden und Registrieren erscheint.
    @IBAction func logOutButtonClicked(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do{
                try Auth.auth().signOut()
                self.registerButton.isEnabled = true
                self.loginButton.isEnabled = true
                self.logoutButton.isEnabled = false
                self.Profillink.isEnabled = false
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
}
