//
//  SettingsVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 13/10/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit
import Former
import FirebaseAuth

final class SettingsVC: FormViewController {
    
    // MARK: Public
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func btn_next(_ sender: Any) {
        //        Profile.sharedInstance.image
        
        FirebaseFetcher.sharedInstance.addUser(userProfile: Profile.sharedInstance) {
            self.performSegue(withIdentifier: "Dashboard", sender: nil)
        }
        
        
    }
    
    private lazy var formerInputAccessoryView: FormerInputAccessoryView = FormerInputAccessoryView(former: self.former)
    
    fileprivate lazy var imageRow: LabelRowFormer<ProfileImageCell> = {
        LabelRowFormer<ProfileImageCell>(instantiateType: .Nib(nibName: "ProfileImageCell")) {
            $0.iconView.image = Profile.sharedInstance.image
            }.configure {
                $0.text = "Choose profile image from library"
                $0.rowHeight = 60
            }.onSelected { [weak self] _ in
                self?.former.deselect(animated: true)
                self?.presentImagePicker()
        }
    }()
    
    private lazy var informationSection: SectionFormer = {
//        let nicknameRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
//            $0.titleLabel.text = "Nickname"
//            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
//            }.configure {
//                $0.placeholder = "Add your nickname"
//                $0.text = Profile.sharedInstance.nickname
//            }.onTextChanged {
//                Profile.sharedInstance.nickname = $0
//        }
//        let locationRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
//            $0.titleLabel.text = "Location"
//            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
//            }.configure {
//                $0.placeholder = "Add your location"
//                $0.text = Profile.sharedInstance.location
//            }.onTextChanged {
//                Profile.sharedInstance.location = $0
//        }
        let phoneRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
            $0.titleLabel.text = "Phone"
            $0.textField.keyboardType = .numberPad
            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
            }.configure {
                $0.placeholder = "Add your phone number"
                $0.text = Profile.sharedInstance.phoneNumber
            }.onTextChanged {
                Profile.sharedInstance.phoneNumber = $0
        }
//        let jobRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
//            $0.titleLabel.text = "Job"
//            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
//            }.configure {
//                $0.placeholder = "Add your job"
//                $0.text = Profile.sharedInstance.job
//            }.onTextChanged {
//                Profile.sharedInstance.job = $0
//        }
        //        let peroidRow = InlinePickerRowFormer<ProfileLabelCell, String>(instantiateType: .Nib(nibName: "ProfileLabelCell")) {
        //            $0.titleLabel.text = "Period Length"
        //            }.configure {
        //                let periodcycles = ["3 Days","4 Days", "5 Days","6 Days","7 Days", "8 Days","9 Days","10 Days"]
        //                $0.pickerItems = periodcycles.map {
        //                    InlinePickerItem(title: $0)
        //                }
        //                if let periodcycle = Profile.sharedInstance.periodcycle {
        //                    $0.selectedRow = periodcycles.index(of: periodcycle) ?? 0
        //                }
        //            }.onValueChanged {
        //                Profile.sharedInstance.periodcycle = $0.title
        //        }
        
        let periodRow = StepperRowFormer<FormStepperCell>(){
            $0.titleLabel.text = "Period Length"
            }.displayTextFromValue { "\(Int($0)) Days" }
        
        let cycleRow = StepperRowFormer<FormStepperCell>(){
            $0.titleLabel.text = "Cycle Length"
            }.displayTextFromValue { "\(Int($0)) Days" }
        
        return SectionFormer(rowFormer: periodRow, cycleRow)
        //nicknameRow, locationRow, phoneRow, jobRow)
    }()
    
    private lazy var signOutSection: SectionFormer = {
        let signOutRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Signout"
            }.onSelected { row in
                
                self.alert(title: "Signout", message: "Are you sure you want to signout? \(Auth.auth().currentUser!.isAnonymous ? "Your data on this device will be lost" : "You can still access your data when returned")", actionTitle: "Signout") {
                    do {
                        try Auth.auth().signOut()
                        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "RootLogin") else { return }
                        self.present(vc, animated: true, completion: nil)
                    } catch let err {
                        print(err)
                    }
                }
        }
        return SectionFormer(rowFormer: signOutRow)
    }()
    
    private func configure() {
        title = "Settings"
        tableView.contentInset.top = 40
        tableView.contentInset.bottom = 40
        
        // Create RowFomers
        
        let nameRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
            $0.titleLabel.text = "Name"
            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
            }.configure {
                $0.placeholder = "Add your name"
                $0.text = Profile.sharedInstance.name
            }.onTextChanged {
                Profile.sharedInstance.name = $0
        }
        let genderRow = InlinePickerRowFormer<ProfileLabelCell, String>(instantiateType: .Nib(nibName: "ProfileLabelCell")) {
            $0.titleLabel.text = "Gender"
            }.configure {
                let genders = ["Male", "Female"]
                $0.pickerItems = genders.map {
                    InlinePickerItem(title: $0)
                }
                if let gender = Profile.sharedInstance.gender {
                    $0.selectedRow = genders.firstIndex(of: gender) ?? 0
                }
            }.onValueChanged {
                Profile.sharedInstance.gender = $0.title
                Profile.sharedInstance.moreInformation = (Profile.sharedInstance.gender == "Female")
                print(Profile.sharedInstance.moreInformation)
                self.switchInfomationSection()
        }
        let originRow = InlinePickerRowFormer<ProfileLabelCell, String>(instantiateType: .Nib(nibName: "ProfileLabelCell")) {
            $0.titleLabel.text = "Origin"
            }.configure {
                let origins = ["Hanafi", "Shafi", "Shia"]
                $0.pickerItems = origins.map {
                    InlinePickerItem(title: $0)
                }
                if let origin = Profile.sharedInstance.gender {
                    $0.selectedRow = origins.firstIndex(of: origin) ?? 0
                }
            }.onValueChanged {
                Profile.sharedInstance.origin = $0.title
        }
        let birthdayRow = InlineDatePickerRowFormer<ProfileLabelCell>(instantiateType: .Nib(nibName: "ProfileLabelCell")) {
            $0.titleLabel.text = "Birthday"
            }.configure {
                $0.date = Profile.sharedInstance.birthDay ?? Date()
            }.inlineCellSetup {
                $0.datePicker.datePickerMode = .date
                $0.datePicker.maximumDate = Date()
            }.displayTextFromDate {
                return String.mediumDateNoTime(date: $0)
            }.onDateChanged {
                Profile.sharedInstance.birthDay = $0
        }
        let introductionRow = TextViewRowFormer<FormTextViewCell>() { [weak self] in
            $0.textView.textColor = .formerSubColor()
            $0.textView.font = .systemFont(ofSize: 15)
            $0.textView.inputAccessoryView = self?.formerInputAccessoryView
            }.configure {
                $0.placeholder = "Add your self-introduction"
                $0.text = Profile.sharedInstance.introduction
            }.onTextChanged {
                Profile.sharedInstance.introduction = $0
        }
        
        let createHeader: ((String) -> ViewFormer) = { text in
            return LabelViewFormer<FormLabelHeaderView>()
                .configure {
                    $0.viewHeight = 40
                    $0.text = text
            }
        }
        
        // Create SectionFormers
        
        let imageSection = SectionFormer(rowFormer: imageRow)
            .set(headerViewFormer: createHeader("Profile Image"))
        let aboutSection = SectionFormer(rowFormer: nameRow, genderRow, originRow, birthdayRow, introductionRow)
            .set(headerViewFormer: createHeader("About"))
        
        former.append(sectionFormer: imageSection, aboutSection)
            .onCellSelected { [weak self] _ in
                self?.formerInputAccessoryView.update()
        }
        if Profile.sharedInstance.moreInformation {
            former.append(sectionFormer: informationSection)
        }
        former.append(sectionFormer: signOutSection)
    }
    
    private func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
    
    private func switchInfomationSection() {
        if Profile.sharedInstance.moreInformation {
            former.insertUpdate(sectionFormer: informationSection, toSection: former.numberOfSections - 1, rowAnimation: .top)
        } else {
            former.removeUpdate(sectionFormer: informationSection, rowAnimation: .top)
        }
    }
}

extension SettingsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            Profile.sharedInstance.image = image
            imageRow.cellUpdate {
                $0.iconView.image = image
            }
        }
        
    }
    
}
