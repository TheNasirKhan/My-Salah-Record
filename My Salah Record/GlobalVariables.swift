//
//  GlobalVariables.swift
//  Rapydjobs
//
//  Created by Nasir Khan on 22/10/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

let themeColor1 = UIColor(rgb: 0x75cbd9)
let themeColor2 = UIColor(rgb: 0x88cdc0)
let shadowColor = UIColor(rgb: 0x71cade)
let greyColor = UIColor(rgb: 0x989898)

let themeColor3 = UIColor(rgb: 0x71CADE)

//71CADE // Switch blue
//92A2AD // tabbar gray

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


extension String {
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Riyadh")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
}

extension Date {
    
    func toString(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Riyadh")
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        
        return str
    }
    
    func readable(withFormat format: String = "dd MMMM yyyy") -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        
        return str
    }
}

extension String {
    
    var isValidName: Bool {
        let RegEx = "^\\w{7,18}$"
        let Test = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Test.evaluate(with: self)
    }
    
    
}
