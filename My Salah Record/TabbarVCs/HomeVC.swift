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
import CoreLocation

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
        btnoAddNumber.roundBorder()
        let isAnonymous = Auth.auth().currentUser!.isAnonymous
        vuAddNumber.isHidden = !isAnonymous
        constFooterHeight.constant = isAnonymous ? 60 : 0
    }
    
    func getTimeZoneName(completion: @escaping (String?) -> ()) {
        let location = Profile.sharedInstance.location ?? GeoPoint(latitude: 21.3891, longitude: 39.8579)
        let loc = CLLocation(latitude: location.latitude, longitude: location.longitude)
        CLGeocoder().reverseGeocodeLocation(loc) { (placemarks, error) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                completion(placemarks?.last?.timeZone?.description)
            }
        }
    }
    
    func getIslamicDate() -> String {
        let dateNow = DateFormatter()
        let islamicCalendar = Calendar.init(identifier: Calendar.Identifier.islamicCivil)
        dateNow.calendar = islamicCalendar
//        dateNow.locale = Locale.init(identifier: "ar_SA")
        dateNow.dateFormat = "dd MMMM yyyy"
        
        return "\(dateNow.string(from: Date()))"
    }
}
