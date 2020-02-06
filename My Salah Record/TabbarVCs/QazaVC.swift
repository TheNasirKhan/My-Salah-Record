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
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        SalahFetcher.shared.getTotalQaza(userProfile: Profile.sharedInstance) { (doc) in
            self.table.reloadData()
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            table.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        table.contentInset = .zero
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salahs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countCell", for: indexPath) as! QazaCounterCell
        
        let rec = TotalQaza.shared
        cell.title.text = salahs[indexPath.row]
        
        switch indexPath.row {
        case 0:
            cell.lblCount.text = "\(rec.fajar ?? 0)"
            case 1:
            cell.lblCount.text = "\(rec.zohor ?? 0)"
            case 2:
            cell.lblCount.text = "\(rec.asar ?? 0)"
            case 3:
            cell.lblCount.text = "\(rec.maghrib ?? 0)"
            case 4:
            cell.lblCount.text = "\(rec.isha ?? 0)"
        default:
            cell.lblCount.text = "\(0)"
        }
        
        
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
        
        
        
    }
    
    @objc func btnAddRecordAction(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.table)
        guard let indexPath = self.table.indexPathForRow(at:buttonPosition) else { return }
        guard let cell = table.cellForRow(at: indexPath) as? QazaCounterCell else { return }
        let textField = cell.txtDays!
        if cell.txtDays.isHidden {
            cell.txtDays.isHidden = false
            sender.setTitle("   Save   ", for: .normal)
            sender.roundBorder()
        } else {
            if textField.text?.isEmpty ?? true {
                //Some Error
            } else {
                cell.lblCount.text = textField.text
                var type = SalahType.fajar
                
                switch indexPath.row {
                    case 0: type = .fajar
                    case 1: type = .zohor
                    case 2: type = .asar
                    case 3: type = .maghrib
                    case 4: type = .isha
                default:
                    type = .fajar
                }
                
                SalahFetcher.shared.setQazaCount(userProfile: Profile.sharedInstance, salahType: type, count: Int(textField.text!)!) {
                    
                }
            }
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
