//
//  Ex+AppDelegate.swift
//  My Salah Record
//
//  Created by Nasir Khan on 13/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit

extension AppDelegate {
    
    func NextViewController(storybordid:String)
    {
        
        let storyBoard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let exampleVC = storyBoard.instantiateViewController(withIdentifier:storybordid )
        // self.present(exampleVC, animated: true)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = exampleVC
        self.window?.makeKeyAndVisible()
    }
    
}
