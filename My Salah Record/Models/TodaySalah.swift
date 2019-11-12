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


enum SalahType {
    case fajar
    case zohor
    case asar
    case maghrib
    case isha
    
    func getSalahName() -> String {
        switch self {
        case .fajar: return "fajar"
        case .zohor: return "zahor"
        case .asar: return "asar"
        case .maghrib: return "maghrib"
        case .isha: return "isha"
        }
    }
}

final class TodaySalah {
    
    static var shared = TodaySalah()
    
    var fajar: Bool
    var zohor: Bool
    var asar: Bool
    var maghrib: Bool
    var isha: Bool
    var salahDate: Date
    
    init() {
        fajar = false
        zohor = false
        asar = false
        maghrib = false
        isha = false
        salahDate = Date()
    }
    
    init(userData: DocumentSnapshot) {
        let data = JSON(userData.data() ?? [:])
        
        salahDate = data["salahDate"].stringValue.toDate() ?? Date()
        fajar = data[SalahType.fajar.getSalahName()].boolValue
        zohor = data[SalahType.zohor.getSalahName()].boolValue
        asar = data[SalahType.asar.getSalahName()].boolValue
        maghrib = data[SalahType.maghrib.getSalahName()].boolValue
        isha = data[SalahType.isha.getSalahName()].boolValue
        
    }
    
}
