//
//  UserPostCell.swift
//  My Salah Record
//
//  Created by Nasir Khan on 26/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit

class UserPostCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var vuBG: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgProfile.completeRound()
        vuBG.roundAndShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
