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
    
}
