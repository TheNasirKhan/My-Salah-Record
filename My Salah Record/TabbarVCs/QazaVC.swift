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
        
        cell.btnAddRecord.addTarget(self, action: #selector(self.btnAddRecordAction(_:)), for: .touchUpInside)
        cell.btnInc.addTarget(self, action: #selector(self.btnIncAction(_:)), for: .touchUpInside)
        cell.btnDec.addTarget(self, action: #selector(self.btnDecAction(_:)), for: .touchUpInside)
        cell.btnInfo.addTarget(self, action: #selector(self.btnInfoAction(_:)), for: .touchUpInside)
        
        cell.txtDays.tag = indexPath.row + 100
        cell.txtDays.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        cell.txtDays.setBottomBorder()
        
        return cell
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let index = textField.tag - 100
        let indexPath = IndexPath(row: index, section: 0)
        guard let cell = table.cellForRow(at: indexPath) as? QazaCounterCell else { return }
        
        cell.lblCount.text = textField.text
        
    }
    
    @objc func btnAddRecordAction(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.table)
        guard let indexPath = self.table.indexPathForRow(at:buttonPosition) else { return }
        guard let cell = table.cellForRow(at: indexPath) as? QazaCounterCell else { return }
        
        if cell.txtDays.isHidden {
            cell.txtDays.isHidden = false
            sender.setTitle("   Save   ", for: .normal)
            sender.roundBorder()
        }
        
    }
    
    @objc func btnIncAction(_ sender: UIButton) {
        
    }
    
    @objc func btnDecAction(_ sender: UIButton) {
        
    }
    
    @IBAction func btnInfoActionNav(_ sender: Any) {
        self.messagePopAlert(title: "Adding Qaza Record", message: "This section is to calculate your previous life time qaza records and helps you perform your all Salah that you have missed previously. Calculate number of estimated days manually and enter in text field. If you have never missed any Salah, ignore this section.") {
        }
    }
    
    @objc func btnInfoAction(_ sender: UIButton) {
        
    }
    
    
}
