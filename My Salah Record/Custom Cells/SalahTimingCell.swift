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
    var indexPath : IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        if sender.isOn {
            var salahType : SalahType = .fajar
            
            switch indexPath?.row {
            case 0: salahType = .fajar
            case 2: salahType = .zohor
            case 3: salahType = .asar
            case 5: salahType = .maghrib
            case 6: salahType = .isha
            default: print("default")
            }
            
            SalahFetcher.shared.setSalah(userProfile: Profile.sharedInstance, todaySalah: TodaySalah.shared, salahType: salahType, isPerformed: true) {
                self.switch.isUserInteractionEnabled = false
                self.performed.text = "Performed"
            }
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

