//
//  QazaVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 17/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

class QazaVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var table: UITableView!
    let salahs = ["Fajar", "Zohar", "Asar", "Maghrib", "Isha"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.tableFooterView = UIView()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salahs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countCell", for: indexPath) as! QazaCounterCell
        
        cell.title.text = salahs[indexPath.row]
        
        return cell
    }
    
    
}
