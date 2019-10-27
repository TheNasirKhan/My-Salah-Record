//
//  RoundShadowView.swift
//  My Salah Record
//
//  Created by Nasir Khan on 26/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit

class RoundShadow: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height/2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 1.0
    }
}
