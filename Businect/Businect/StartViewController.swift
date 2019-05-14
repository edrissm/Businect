//
//  StartViewController.swift
//  Businect
//
//  Created by Edriss Mosafer on 14.05.19.
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
