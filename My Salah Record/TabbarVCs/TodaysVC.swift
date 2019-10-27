//
//  HomeVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 20/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit
import Firebase

class TodaysVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    let salahs = ["Fajar", "Zohar", "Asar", "Maghrib", "Isha"]
    var todayTimes:[(AKPrayerTime.TimeNames, Any)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        setupPrayers()
    }
    
    func setupPrayers() {
        let location = Profile.sharedInstance.location ?? GeoPoint(latitude: 21.3891, longitude: 39.8579)
        let prayerKit:AKPrayerTime = AKPrayerTime(lat: location.latitude, lng: location.longitude)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalahTimingCell", for: indexPath) as! SalahTimingCell
        
        let (timeName, time) = todayTimes[indexPath.row]
        cell.title!.text = timeName.toString()
        cell.time!.text = time as? String
        
        return cell
    }

}
