//
//  AppDelegate.swift
//  Businect
//
//  Copyright © 2019 Scrum-Made. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate{
    let userDefault = UserDefaults()
    var window: UIWindow?
    
   // Das Einloggen über Google wird ermöglicht und die Daten auf die man zugreifen kann werden auf der Firebase Datenbank gespeichert.
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
       
        if let error = error {
            print("Login mit Google Fehlgeschlagen", error)
            return
        }
        print("Erfolgreich eingeloggt")
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print("Failed to create a Firebase User with Google account: ", error)
                return
            }
            
            guard let uid = user?.uid else { return }
            guard let email = user?.email else { return }
            guard let username = user?.displayName else { return }
            
            print("Successfully logged into Firebase with Google", uid)
           self.userDefault.set(true, forKey: "usersignedIn")
          self.userDefault.synchronize()
            let values = ["Beruf": "" , "Branche": "" ,"EMail" :email,"Interesse1": "" ,"Interesse2": "" ,"Name": "" ,"Passwort": "" , "Verfuegbarkeit": true ,"Vorname": username ] as [String : Any]
            Database.database().reference().child("Benutzer").child(username).updateChildValues(values, withCompletionBlock: { (errror, ref) in
                
            })
        })
      
    }
    
   

    

// Verschiedene Schnittstellen wie die Tastur und Firebase werden in dieser Funktion aktiviert und können somit in der ganzen App benutzt werden.
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        return true
    }
    //Methode um auf die Google Seite weitergeleitet zu werden und die Account Daten einzugeben.
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

