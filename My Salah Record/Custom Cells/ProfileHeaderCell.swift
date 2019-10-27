//
//  ProfileHeaderCell.swift
//  My Salah Record
//
//  Created by Nasir Khan on 20/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit

class ProfileHeaderCell: UITableViewCell {

    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var vuBG: UIView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var vuImgProfile: UIView!
    @IBOutlet weak var vuCreatePost: UIView!
    
    @IBOutlet weak var imgCreatePost: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        vuCreatePost.lowRoundAndShadow()
        vuImgProfile.roundAndShadow()
        imgProfile.layer.cornerRadius = 15
        imgCreatePost.completeRound()
//        vuCreatePost.roundBorder()
        
    }
    
}



