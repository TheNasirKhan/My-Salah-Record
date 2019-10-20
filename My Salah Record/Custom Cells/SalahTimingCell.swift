//
//  SalahTimingCell.swift
//  My Salah Record
//
//  Created by Nasir Khan on 13/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

class SalahTimingCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var performed: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            self.switch.isUserInteractionEnabled = false
            performed.text = "Performed"
        }
    }
    
}


class DatesCell: UITableViewCell {
    
    @IBOutlet weak var englishDate: UILabel!
    @IBOutlet weak var islamicDate: UILabel!
    @IBOutlet weak var joiningDate: UILabel!
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}


class QuotationCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
