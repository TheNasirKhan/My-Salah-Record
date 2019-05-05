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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.img.layer.cornerRadius = self.img.frame.size.height/2
        self.img.clipsToBounds = true
        self.img.layer.borderWidth = 1
        self.img.layer.borderColor = UIColor.gray.cgColor
        
    }

}
