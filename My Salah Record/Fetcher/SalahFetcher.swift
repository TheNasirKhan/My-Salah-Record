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

class SalahFetcher {
    
    static var shared = SalahFetcher()
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    var ref: DocumentReference? = nil
    
    func getTodaySalahRecord(userProfile:Profile, completion: @escaping (DocumentSnapshot?) -> ()) {
        db.collection("todaySalah").document(userProfile.id!).getDocument { (document, error) in
            if let document = document, document.exists {
                completion(document)
            } else {
                completion(nil)
            }
        }
    }
    
    func setSalah(userProfile:Profile, todaySalah: TodaySalah , salahType: SalahType, isPerformed: Bool, completionHandler:  @escaping () -> ()) {
        if Calendar.current.isDateInToday(todaySalah.salahDate) {
            db.collection("todaySalah").document(userProfile.id!).setValue(isPerformed, forKey: salahType.getSalahName())
            completionHandler()
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
        
    }
    
}
