//
//  UIViewController+Extension.swift
//  My Salah Record
//
//  Created by Nasir Khan on 25/03/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit
import Toaster


extension UIViewController {
    
    func popUp(message: String) {
        
        Toast(text: message).show()
        
    }
    
    func alert(title: String, message: String, actionTitle: String, comletion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { (action) in
            comletion()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func messagePopAlert(title: String, message: String, actionTitle: String = "Okay", comletion: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


extension UIView {
    func setBottomBorder() {
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.groupTableViewBackground.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
