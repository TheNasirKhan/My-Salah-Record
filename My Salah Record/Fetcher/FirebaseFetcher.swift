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
    
    let db = Firestore.firestore()

    var ref: DocumentReference? = nil
    
    func addDoc(completionHandler:  @escaping (DocumentReference?) -> ()) {
    
        ref = db.collection("users").addDocument(data: [
            "first": "Ada",
            "last": "Lovelace",
            "born": 1815
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completionHandler(nil)
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
                completionHandler(self.ref!)
                
            }
        }
        
    }
    
    
    func getDoc(completion: @escaping ([QueryDocumentSnapshot]?) -> ()) {
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var newData = [QueryDocumentSnapshot]()
                
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    newData.append(document)
                    
                }
                
                completion(newData)
            }
        }
        
    }
    
    
    func authAnonymous(completion: @escaping ([QueryDocumentSnapshot]?) -> ()) {
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            // ...
            
            if (error == nil) {
                
                let user = authResult?.user
                let isAnonymous = user?.isAnonymous  // true
                let uid = user?.uid
                
                print(uid)
                print(isAnonymous)
                
                
            } else {
                print(error!.localizedDescription)
            }
            
            
            
        }
        
    }
    
    func authByNumber(phone: String, completion: @escaping ([QueryDocumentSnapshot]?) -> ()) {
        
        
        
    }
    
    
    func getUser(userID: String, completion: @escaping (QuerySnapshot?) -> ()) {
        
        db.collection("users/\(userID)").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                print(querySnapshot)
                
                completion(querySnapshot)
                
            }
        }
        
    }
    
    func addUser(userID:String, completionHandler:  @escaping (DocumentReference?) -> ()) {
        
        ref = db.collection("users/\(userID)").addDocument(data: [
            "first": "Ada"
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                completionHandler(nil)
            } else {
                print("Document added with ID: \(self.ref!.documentID)")
                completionHandler(self.ref!)
                
            }
        }
        
    }
    
    
    
}
