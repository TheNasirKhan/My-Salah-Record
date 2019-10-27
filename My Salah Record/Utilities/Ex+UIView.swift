//
//  Ex+UIView.swift
//  My Salah Record
//
//  Created by Nasir Khan on 13/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit


extension UIColor {
    public static let AppBlue = UIColor(red: 21/255, green: 120/255, blue: 252/255, alpha: 1)
    public static let AppGreen = UIColor(red: 0/255, green: 213/255, blue: 147/255, alpha: 1)
    public static let AppLightGray = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 1)
    public static let AppDarkGray = UIColor(red: 32/255, green: 60/255, blue: 83/255, alpha: 1)
    public static let AppRed = UIColor(red: 254/255, green: 95/255, blue: 95/255, alpha: 1)
    
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static func colorFromHex(_ hex: String) -> UIColor {
        
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexString.hasPrefix("#") {
            
            hexString.remove(at: hexString.startIndex)
        }
        
        if hexString.count != 6 {
            
            return UIColor.magenta
        }
        
        var rgb: UInt32 = 0
        Scanner.init(string: hexString).scanHexInt32(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255,
                            green: CGFloat((rgb & 0x00FF00) >> 8)/255,
                            blue: CGFloat(rgb & 0x0000FF)/255,
                            alpha: 1.0)
    }
}

extension UIView {
    func completeRound() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    func completeRect() {
        self.layer.cornerRadius = 0
        self.clipsToBounds = true
    }
    
    func roundAndShadowProfile() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 20
        
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 3.0
    }
    
    func roundAndShadow() {
        self.layer.cornerRadius = 15
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 0.6
        
    }
    
    func lowRoundAndShadow() {
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowRadius = 1.0
        self.layer.shadowOpacity = 0.63
        
    }
    
    func roundBorder() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addConstraintsWithFormatString(formate: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formate, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
        
    }
    
    func layerBlackGradient(_ cornerRadius: Int = 0) {
        let gradient: CAGradientLayer = CAGradientLayer()
        let startColor = UIColor.black.withAlphaComponent(0.4).cgColor
        let endStart = UIColor.clear.cgColor
        
        gradient.colors = [startColor, endStart]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = self.bounds
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if cornerRadius > 0 {
            gradient.cornerRadius = CGFloat(cornerRadius)
        }
        self.layer.insertSublayer(gradient, at: 0)
    }
}

public extension UIFont {
    static func customFont(name: String, size: CGFloat) -> UIFont {
        let font = UIFont(name: name, size: size)
        assert(font != nil, "Can't load font: \(name)")
        return font ?? UIFont.systemFont(ofSize: size)
    }
    
    static func mainFont(ofSize size: CGFloat,isBold : Bool = false) -> UIFont {
        switch isBold {
        case true:
            return customFont(name: "Helvetica Bold", size: size)
        case false:
            return customFont(name: "Helvetica Regular", size: size)
        }
        
    }
}

extension String {
    
    func getFlag() -> String {
        let base : UInt32 = 127397
        var s = ""
        for v in self.unicodeScalars {
            s.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return String(s)
    }
    
}


extension UITableView {
    
    func scrollToBottom(){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections - 1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: false)
        }
    }
}

