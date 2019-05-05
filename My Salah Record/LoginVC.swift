//
//  LoginVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 13/03/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class LoginVC: UIViewController {
    
    @IBOutlet weak var txt_phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(dismissKeyboardGesture)
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func btn_skip(_ sender: UIButton) {
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            // ...
            
            if (error == nil) {
                
                let user = authResult!.user
                let isAnonymous = user.isAnonymous  // true
                let uid = user.uid
                
                print(uid)
                print(isAnonymous)
                
                let firebaseFetcher = FirebaseFetcher()
                
                firebaseFetcher.addUser(userID: uid, completionHandler: { (data: DocumentReference?) in
                    print(data?.documentID ?? 0)
                })
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "Dashboard", sender: nil)
                }
                
            } else {
                print(error!.localizedDescription)
            }
            
            
            
        }
        
    }
    
    @IBAction func btn_enter(_ sender: Any) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+923452192410", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                self.popUp(message: error.localizedDescription)
                return
            } else {
                UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            }
            // Sign in using the verificationID and the code sent to the user
            // ...
            
            let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
            
            let credential = PhoneAuthProvider.provider().credential(
                withVerificationID: verificationID ?? "",
                verificationCode: verificationID ?? "")
            
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    return
                }
                // User is signed in
                // ...
            }
            
        }
        
        

        
    }
    
    
}
