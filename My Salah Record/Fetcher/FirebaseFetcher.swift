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

class FirebaseFetcher {
    
    static var sharedInstance = FirebaseFetcher()
    
    let db = Firestore.firestore()
    let storageRef = Storage.storage().reference()
    var ref: DocumentReference? = nil
    
//    func addDoc(completionHandler:  @escaping (DocumentReference?) -> ()) {
//
//        ref = db.collection("users").addDocument(data: [
//            "first": "Ada",
//            "last": "Lovelace",
//            "born": 1815
//        ]) { err in
//            if let err = err {
//                print("Error adding document: \(err)")
//                completionHandler(nil)
//            } else {
//                print("Document added with ID: \(self.ref!.documentID)")
//                completionHandler(self.ref!)
//
//            }
//        }
//
//    }
//
//    func getDoc(userID: String, completion: @escaping (DocumentSnapshot?) -> ()) {
//
//        db.collection("users").document(userID).getDocument { (document, error) in
//            if let document = document, document.exists {
//                completion(document)
////                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
////                print("Document data: \(dataDescription)")
//            } else {
////                print("Document does not exist")
////                 Add a new User Data
//                completion(nil)
//            }
//        }
//
//    }
    
    func getUser(userID: String, completion: @escaping (DocumentSnapshot?) -> ()) {
        db.collection("users").document(userID).getDocument { (document, error) in
            if let document = document, document.exists {
                completion(document)
            } else {
                completion(nil)
            }
        }
    }
    
    func addUser(userProfile:Profile, completionHandler:  @escaping () -> ()) {
        db.collection("users").document(userProfile.id!).setData(userProfile.toDict()) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                completionHandler()
            }
        }
    }
    
    func uploadImage(userID: String, image: UIImage) {
        guard let data = image.pngData() else { return }
        storageRef.child("profileImages/\(userID).png").putData(data, metadata: nil, completion: { (metadata, error) in
            if error != nil {
                print("error")
            } else {
                
            }
        })
    }
    
    func getProfileImage(userID:String, completionHandler:  @escaping (UIImage) -> ()) {
        storageRef.child("profileImages/\(userID).png").getData(maxSize: 10 * 1024 * 1024, completion: { (data, error) in
            if error != nil {
                print("error")
            } else {
                completionHandler(UIImage(data: data!) ?? UIImage())
            }
        })
    }
    
    
}
