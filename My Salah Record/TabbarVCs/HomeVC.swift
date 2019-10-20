//
//  TodayVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 13/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore


class HomeVC : UIViewController {
    
    @IBOutlet weak var btnoAddNumber: UIButton!
    @IBOutlet weak var lblAddNumber: UILabel!
    @IBOutlet weak var vuAddNumber: UIView!
    @IBOutlet weak var constFooterHeight: NSLayoutConstraint!
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        setup()
    }
    
    func setup() {
        setupLoginButton()
    }
    
    func setupLoginButton() {
        btnoAddNumber.roundAndShadow()
        let isAnonymous = Auth.auth().currentUser!.isAnonymous
        vuAddNumber.isHidden = !isAnonymous
        constFooterHeight.constant = isAnonymous ? 60 : 0
    }
    
}
