//
//  TopPerformersCell.swift
//  My Salah Record
//
//  Created by Nasir Khan on 14/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

class TopPerformersCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTile: UILabel!
    @IBOutlet weak var btnImg: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.btnImg.setTitleColor(.white, for: .normal)
        self.btnImg.layer.cornerRadius = self.btnImg.frame.size.height/2
        self.btnImg.clipsToBounds = true
        self.btnImg.layer.borderWidth = 1
        self.btnImg.layer.borderColor = UIColor.gray.cgColor
        
        self.img.layer.cornerRadius = self.img.frame.size.height/2
        self.img.clipsToBounds = true
        self.img.layer.borderWidth = 1
        self.img.layer.borderColor = UIColor.gray.cgColor
        
    }

}
