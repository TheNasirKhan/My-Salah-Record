//
//  InitialVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 19/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit
import FirebaseAuth

class InitialVC: UIViewController {

    @IBOutlet weak var const_topTilte: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        navigationItem.hidesBackButton = true
        
        
        if let uid = Auth.auth().currentUser?.uid {
            
            FirebaseFetcher.sharedInstance.getUser(userID: uid) { (document) in
                if let data = document {
                    Profile.sharedInstance = Profile(userData: data)
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC") else { return }
                    self.present(vc, animated: false, completion: nil)
                } else {
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "EditProfileVC") else { return }
                    self.navigationController?.pushViewController(vc, animated: false)
                }
            }
            
        } else {
            const_topTilte.constant = 60
            
            UIView.animate(withDuration: 2, animations: {
                self.view.layoutIfNeeded()
            }) { (bool) in
                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") else { return }
                self.navigationController?.pushViewController(vc, animated: false)
            }
            
        }
        
    }

}
