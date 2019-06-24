//
//  StartViewController.swift
//  Businect
//  Created by Nina and Edriss
//  Copyright © 2019 Scrum-Made. All rights reserved.

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
// Der StartViewController ist die Startseite der Businect-App und leitet das Login und Logout
// sowie das Registrieren und den Link zur Profilseite ein.
class StartViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var profileLink: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var qrScanner: UIButton!
    
    // Startseite wird geladen
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Prueft ob ein User angemeldet ist, und zeigt demnach die Buttons zur Profilseite
    // oder zum Anmelden bzw. Registrieren.
    // Created by Nina and Edriss
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.registerButton.isEnabled = false
            self.loginButton.isEnabled = false
            self.logoutButton.isEnabled = true
            self.profileLink.isEnabled = true
            self.qrScanner.isEnabled = true
        } else {
            self.registerButton.isEnabled = true
            self.loginButton.isEnabled = true
            self.logoutButton.isEnabled = false
            self.profileLink.isEnabled = false
            self.qrScanner.isEnabled = false
        }
    }

    // User wird abgemeldet und Button Anmelden und Registrieren erscheint.
    // Created by Nina and Edriss
    @IBAction func logOutButtonClicked(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            do{
                try Auth.auth().signOut()
                try GIDSignIn.sharedInstance()?.signOut()
                self.registerButton.isEnabled = true
                self.loginButton.isEnabled = true
                self.logoutButton.isEnabled = false
                self.profileLink.isEnabled = false
                self.qrScanner.isEnabled = false
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
}
