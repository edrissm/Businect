//
//  LoginPageViewController.swift
//  Businect
//
//  Created by Edriss Mosafer on 14.05.19.
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginPageViewController: UIViewController {

  
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


}
