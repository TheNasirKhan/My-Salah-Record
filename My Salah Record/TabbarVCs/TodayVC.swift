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


class TodayVC : UIViewController {
    
    @IBOutlet weak var table: UITableView!
    let salahs = ["Fajar", "Zohar", "Asar", "Maghrib", "Isha"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
        
        
        
        let firebaseFetcher = FirebaseFetcher()
        
        firebaseFetcher.addDoc { (ref: DocumentReference?) in
            print(ref?.documentID ?? 0)
        }
        
        firebaseFetcher.getDoc { (data: [QueryDocumentSnapshot]?) in
            print(data)
        }
        
        
        
        

    }
    
    
    
    
    
}
