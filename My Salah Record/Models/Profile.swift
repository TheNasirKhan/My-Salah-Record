//
//  Profile.swift
//  Former-Demo
//
//  Created by Ryo Aoyama on 10/31/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SwiftyJSON
import CoreLocation

final class Profile {
    
    static var sharedInstance = Profile()
    
    var id: String?
    var image: UIImage?
    var name: String?
    var gender: String?
    var origin: String?
    var birthDay: Date?
//    var location: String?
    var phoneNumber: String?
    var introduction: String?
    var startedDate: Date?
    var location: GeoPoint?
    
    //For Female
    var periodcycle: String?
    var cycleLength: String?
    var moreInformation = false
    
    init() {
    }
    
    init(userData: DocumentSnapshot) {
        let data = JSON(userData.data() ?? [:])
        
        id = userData.documentID
        name = data["name"].stringValue
        gender = data["gender"].stringValue
        origin = data["origin"].stringValue
        birthDay = data["birthDay"].stringValue.toDate()
        startedDate = data["startedDate"].stringValue.toDate()
        location = userData.get("location") as? GeoPoint ?? GeoPoint(latitude: 0.0, longitude: 0.0)
        phoneNumber = data["phoneNumber"].stringValue
        introduction = data["introduction"].stringValue
        periodcycle = data["periodcycle"].stringValue
        cycleLength = data["cycleLength"].stringValue
        
        FirebaseFetcher.sharedInstance.getProfileImage(userID: id ?? "default", completionHandler: { (image) in
            self.image = image
        })
        
    }
    
    func toDict() -> [String: Any] {
        var dict = [String:Any]()
        
        if let name = name { dict["name"] = name }
        if let gender = gender { dict["gender"] = gender }
        if let origin = origin { dict["origin"] = origin }
        if let birthDay = birthDay?.toString() { dict["birthDay"] = birthDay }
        if let startedDate = startedDate?.toString() { dict["startedDate"] = startedDate}
        if let location = location { dict["location"] = location }
        if let phoneNumber = phoneNumber { dict["phoneNumber"] = phoneNumber }
        if let introduction = introduction { dict["introduction"] = introduction }
        if let periodcycle = periodcycle { dict["periodcycle"] = periodcycle }
        if let cycleLength = cycleLength { dict["cycleLength"] = cycleLength }
        
        return dict
    }
    
}
