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


class TodayVC : UIViewController {
    
    @IBOutlet weak var btnoAddNumber: UIButton!
    @IBOutlet weak var lblAddNumber: UILabel!
    @IBOutlet weak var vuAddNumber: UIView!
    @IBOutlet weak var constFooterHeight: NSLayoutConstraint!
    
    @IBOutlet weak var table: UITableView!
    let salahs = ["Fajar", "Zohar", "Asar", "Maghrib", "Isha"]
    var todayTimes:[(AKPrayerTime.TimeNames, Any)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        setup()
    }
    
    func setup() {
        setupPrayers()
        setupLoginButton()
    }
    
    func setupLoginButton() {
        btnoAddNumber.roundAndShadow()
        let isAnonymous = Auth.auth().currentUser!.isAnonymous
        vuAddNumber.isHidden = !isAnonymous
        constFooterHeight.constant = isAnonymous ? 60 : 0
    }
    
    
    func setupPrayers() {
        let prayerKit:AKPrayerTime = AKPrayerTime(lat: 23.810332, lng: 90.4125181)
        prayerKit.calculationMethod = .Makkah
        prayerKit.asrJuristic = .Hanafi
        prayerKit.outputFormat = .Time12
        let times = prayerKit.getPrayerTimes()
        if let t = times {
            let sortedTimes = t.sorted {a,b in a.0.rawValue < b.0.rawValue}
            todayTimes = sortedTimes
            table.reloadData()
            for (pName, time) in sortedTimes {
                let paddedName:String = (pName.toString() as NSString).padding(toLength: 15, withPad: " ", startingAt: 0)
                print(paddedName  + " : \(time)")
            }
        }
        
        print(todayTimes)
        
    }
    
    
    
    
}
