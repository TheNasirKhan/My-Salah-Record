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
import FirebaseCore
//import FirebaseFirestoreSwift

class SalahFetcher {
    
    static var shared = SalahFetcher()
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    var ref: DocumentReference? = nil
    
    //Today Salah Count Methods
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
        increamentTotalCount(userProfile: userProfile, todaySalah: todaySalah, salahType: salahType) { }
        increamentThisMonthTotalCount(userProfile: userProfile, todaySalah: todaySalah, salahType: salahType) { }
    }
    
    // Total Salah Count Methods
    func getTotalCount(userProfile:Profile, todaySalah: TodaySalah , salahType: SalahType, completionHandler:  @escaping (Int?) -> ()) {
        db.collection("salahCount").document(userProfile.id!).collection("totalCount").document(salahType.getSalahName()).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = JSON(document.data() ?? [:])["count"].intValue
                completionHandler(data)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func increamentTotalCount(userProfile:Profile, todaySalah: TodaySalah , salahType: SalahType, completionHandler:  @escaping () -> ()) {
        getTotalCount(userProfile: userProfile, todaySalah: todaySalah, salahType: salahType) { (count) in
            if let count = count {
                self.db.collection("salahCount").document(userProfile.id!).collection("totalCount").document(salahType.getSalahName()).updateData([
                    "count": count + 1
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        completionHandler()
                    }
                }
            } else {
                self.db.collection("salahCount").document(userProfile.id!).collection("totalCount").document(salahType.getSalahName()).setData([
                    "count": 1
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
    }
    
    // Total This Month Salah Count Methods
    func getThisMonthTotalCount(userProfile:Profile, todaySalah: TodaySalah , salahType: SalahType, completionHandler:  @escaping (Int?) -> ()) {
        db.collection("salahCount").document(userProfile.id!).collection("totalCount").document(salahType.getSalahName()).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = JSON(document.data() ?? [:])["count"].intValue
                completionHandler(data)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func increamentThisMonthTotalCount(userProfile:Profile, todaySalah: TodaySalah , salahType: SalahType, completionHandler:  @escaping () -> ()) {
        getTotalCount(userProfile: userProfile, todaySalah: todaySalah, salahType: salahType) { (count) in
            if let count = count {
                self.db.collection("salahCount").document(userProfile.id!).collection(Date().getThisMonth()).document(salahType.getSalahName()).updateData([
                    "count": count + 1
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        completionHandler()
                    }
                }
            } else {
                self.db.collection("salahCount").document(userProfile.id!).collection(Date().getThisMonth()).document(salahType.getSalahName()).setData([
                    "count": 1
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
    }
    
    // Qaza Record
    
    func getTotalQaza(userProfile:Profile, completion: @escaping (DocumentSnapshot?) -> ()) {
        db.collection("qazaCount").document(userProfile.id!).getDocument { (document, error) in
            if let document = document, document.exists {
//                TodaySalah.lastDaySalah = TodaySalah(userData: document)
                TotalQaza.shared = TotalQaza(data: document)
                completion(document)
            } else {
                completion(nil)
            }
        }
    }
    
    func getQazaCount(userProfile:Profile, salahType: SalahType, completionHandler:  @escaping (Int?) -> ()) {
        db.collection("qazaCount").document(userProfile.id!).getDocument { (document, error) in
            if let document = document, document.exists {
                let data = JSON(document.data() ?? [:])[salahType.getSalahName()].intValue
                completionHandler(data)
            } else {
                completionHandler(nil)
            }
        }
    }
    
    func setQazaCount(userProfile:Profile, salahType: SalahType, count: Int, completionHandler:  @escaping () -> ()) {
        self.db.collection("qazaCount").document(userProfile.id!).updateData([
            salahType.getSalahName(): count
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                completionHandler()
                SalahFetcher.shared.getTotalQaza(userProfile: Profile.sharedInstance) { (doc) in }
            }
        }
    }
    
    func incDecQazaCount(userProfile:Profile, todaySalah: TodaySalah, salahType: SalahType, isInc: Bool, completionHandler:  @escaping () -> ()) {
        getQazaCount(userProfile: userProfile, salahType: salahType) { (count) in
            if let count = count {
                self.db.collection("qazaCount").document(userProfile.id!).updateData([
                    salahType.getSalahName(): count + (isInc ? 1 : -1)
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        completionHandler()
                        SalahFetcher.shared.getTotalQaza(userProfile: Profile.sharedInstance) { (doc) in }
                    }
                }
            } else {
                self.db.collection("qazaCount").document(userProfile.id!).setData([
                    salahType.getSalahName(): (isInc ? 1 : 0)
                ]) { err in
                    if let err = err {
                        print("Error updating document: \(err)")
                    } else {
                        print("Document successfully updated")
                        completionHandler()
                        SalahFetcher.shared.getTotalQaza(userProfile: Profile.sharedInstance) { (doc) in }
                    }
                }
            }
        }
    }
    
}


extension Date {
    func getThisMonth() -> String {
        let df = DateFormatter()
        df.setLocalizedDateFormatFromTemplate("MMM-yyyy")
        return df.string(from: self)
    }
}
