//
//  DatePickerTextFieldView.swift
//  My Salah Record
//
//  Created by Nasir Khan on 17/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

class DatePickerTextFieldView: UIView {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
    }

}
