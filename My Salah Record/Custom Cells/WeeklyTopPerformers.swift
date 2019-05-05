//
//  WeeklyTopPerformers.swift
//  My Salah Record
//
//  Created by Nasir Khan on 13/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

class WeeklyTopPerformers: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var vu_bg: UIView!
    @IBOutlet weak var lbl_rank: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.vu_bg.layer.cornerRadius = self.vu_bg.frame.size.height/2
        self.vu_bg.clipsToBounds = true
        self.vu_bg.layer.borderWidth = 1
        self.vu_bg.layer.borderColor = UIColor.gray.cgColor
        
        img.layer.cornerRadius = img.frame.size.height/2
        img.clipsToBounds = true
        
        
        self.lbl_rank.layer.cornerRadius = self.lbl_rank.frame.size.height/2
        self.lbl_rank.clipsToBounds = true
        self.lbl_rank.layer.borderWidth = 2
        self.lbl_rank.layer.borderColor = UIColor.white.cgColor
        
    }
    
}
