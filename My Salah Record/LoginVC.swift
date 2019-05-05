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
    @IBOutlet weak var btn_login: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn_login.layer.cornerRadius = btn_login.bounds.height / 2
        
        txt_phone.attributedPlaceholder = NSAttributedString(string: "Phone Number",
                                                               attributes: [NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.3)])
        
       
        
        let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        dismissKeyboardGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(dismissKeyboardGesture)
        
        let code = UserDefaults.standard.string(forKey: "authVerificationID")
        print(code)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
            }
            
            // Sign in using the verificationID and the code sent to the user
            
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            
            let alertController = UIAlertController(title: "Verification", message: "Enter Verification code send on your mobile", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Verify", style: .default, handler: { alert -> Void in
                let textField = alertController.textFields![0] as UITextField
                // do something with textField
                
                let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
                
                let credential = PhoneAuthProvider.provider().credential(
                    withVerificationID: verificationID ?? "",
                    verificationCode: textField.text ?? "")
                
                Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                    if let error = error {
                        self.popUp(message: error.localizedDescription)
                        return
                    }
                    // User is signed in
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "Dashboard", sender: nil)
                    }
                }
                
                
            }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alertController.addTextField(configurationHandler: {(textField : UITextField!) -> Void in
                textField.placeholder = "Verification code"
            })
            self.present(alertController, animated: true, completion: nil)
            
            
        }
        
        

        
    }
    
    
}

