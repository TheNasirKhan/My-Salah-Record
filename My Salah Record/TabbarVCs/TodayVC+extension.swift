//
//  TodayVC+extension.swift
//  My Salah Record
//
//  Created by Nasir Khan on 14/03/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit

extension TodayVC : UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeeklyTopPerformers
        
        cell.lbl_rank.text = String( indexPath.row + 1)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salahs.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Qcell", for: indexPath)
            
            return cell
        }
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SalahTimingCell
        
        cell.title.text = salahs[indexPath.row - 1]
        
        return cell
    }
}
