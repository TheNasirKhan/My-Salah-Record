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
import UserNotifications

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
        setupLocalNotification()
        scheduleNotification()
    }
    
    func setupLocalNotification() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                self.scheduleNotification()
            } else {
                print("D'oh")
            }
        }
    }
    
    func scheduleNotification() {
        let center = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = "Mark Today's Salah"
        content.body = "Please Mark your Today's Salah as performed."
        content.categoryIdentifier = "alarm"
        content.userInfo = ["type": "Today"]
        content.sound = UNNotificationSound.default

        var dateComponents = DateComponents()
        dateComponents.hour = 22
        dateComponents.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        center.add(request)
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
