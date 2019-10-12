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
        
//        let code = UserDefaults.standard.string(forKey: "authVerificationID")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func toDoWithData(authResult:AuthDataResult)  {
        
        let user = authResult.user
        let isAnonymous = user.isAnonymous  // true
        let uid = user.uid
        
        Profile.sharedInstance.id = uid
        
        FirebaseFetcher.sharedInstance.addUser(userProfile: Profile.sharedInstance) {
            DispatchQueue.main.async {
                //                    self.performSegue(withIdentifier: "Dashboard", sender: nil)
                self.performSegue(withIdentifier: "EditProfileVC", sender: nil)
            }
        }
        
        
        
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func btn_skip(_ sender: UIButton) {
        Auth.auth().signInAnonymously() { (authResult, error) in
            if (error == nil) {
                self.toDoWithData(authResult: authResult!)
            } else {
                print(error!.localizedDescription)
                self.popUp(message: error!.localizedDescription)
            }
        }
    }
    
    @IBAction func btn_enter(_ sender: Any) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+923452192410", uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                self.popUp(message: error.localizedDescription)
                return
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
                    } else {
                        self.toDoWithData(authResult: authResult!)
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
    
    func enterVerificationCode() {
        
    }
}

