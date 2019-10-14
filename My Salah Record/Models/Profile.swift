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

final class Profile {
    
    static var sharedInstance = Profile()
    
    var id: String?
    var image: UIImage?
    var name: String?
    var gender: String?
    var periodcycle: String?
    var origin: String?
    var birthDay: Date?
    var introduction: String?
    var moreInformation = false
    var nickname: String?
    var location: String?
    var phoneNumber: String?
    var job: String?
    var isAnonymous: Bool?
    
    init() {
    }
    
    
    init(userData: DocumentSnapshot) {
        let data = JSON(userData.data())
        
        id = userData.documentID
        name = data[""].stringValue
    }
    
}
