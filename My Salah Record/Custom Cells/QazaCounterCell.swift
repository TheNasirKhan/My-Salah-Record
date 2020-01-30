//
//  QazaCounterCell.swift
//  My Salah Record
//
//  Created by Nasir Khan on 17/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

class QazaCounterCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var btnInc: UIButton!
    @IBOutlet weak var btnDec: UIButton!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var btnInfo: UIButton!
    @IBOutlet weak var btnAddRecord: UIButton!
    @IBOutlet weak var txtDays: UITextField!
    @IBOutlet weak var vubg: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
