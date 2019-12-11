//
//  FirebaseFetcher.swift
//  My Salah Record
//
//  Created by Nasir Khan on 14/03/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import SwiftyJSON

class SalahFetcher {
    
    static var shared = SalahFetcher()
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    var ref: DocumentReference? = nil
    
    func getTodaySalahRecord(userProfile:Profile, completion: @escaping (DocumentSnapshot?) -> ()) {
        db.collection("todaySalah").document(userProfile.id!).getDocument { (document, error) in
            if let document = document, document.exists {
                TodaySalah.lastDaySalah = TodaySalah(userData: document)
                if Calendar.current.isDateInToday(TodaySalah.lastDaySalah.salahDate) {
                    TodaySalah.shared = TodaySalah.lastDaySalah
                }
                completion(document)
            } else {
                completion(nil)
            }
        }
    }
    
    func setSalah(userProfile:Profile, todaySalah: TodaySalah , salahType: SalahType, isPerformed: Bool, completionHandler:  @escaping () -> ()) {
        if Calendar.current.isDateInToday(todaySalah.salahDate) {
            db.collection("todaySalah").document(userProfile.id!).setData(
            [
                salahType.getSalahName():isPerformed,
                "salahDate": Date().toString()
                ],
            merge: true
            ) { err in
                if let err = err {
                    print("Error updating document: \(err)")
                } else {
                    print("Document successfully updated")
                    completionHandler()
                }
            }
        } else {
            db.collection("todaySalah").document(userProfile.id!).setData(
                [
                    "salahDate": Date().toString(),
                    salahType.getSalahName(): isPerformed
                ]
            ) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Document successfully written!")
                    completionHandler()
                }
            }
        }
        SalahFetcher.shared.getTodaySalahRecord(userProfile: Profile.sharedInstance) { (data) in }
    }
    
    func getTotalCount(userProfile:Profile, todaySalah: TodaySalah , salahType: SalahType, completionHandler:  @escaping (Int?) -> ()) {
        db.collection("salahCount").document(userProfile.id!).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = JSON(document.data() ?? [:]).intValue
                completionHandler(data)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func increamentTotalCount(userProfile:Profile, todaySalah: TodaySalah , salahType: SalahType, completionHandler:  @escaping () -> ()) {
        
        db.collection("salahCount").document(userProfile.id!).collection("totalCount").document("").updateData([
            "totalCount": 1
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                completionHandler()
            }
        }
    }
}
