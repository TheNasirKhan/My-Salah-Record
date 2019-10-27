//
//  ProfileVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 20/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCell", for: indexPath) as! ProfileHeaderCell
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatesCell", for: indexPath) as! DatesCell
            
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuotationCell", for: indexPath) as! QuotationCell
            
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserPostCell", for: indexPath) as! UserPostCell
            
            return cell
        }
        
    }

}
