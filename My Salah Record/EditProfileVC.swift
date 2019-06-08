////
////  EditProfileVC.swift
////  My Salah Record
////
////  Created by Nasir Khan on 03/06/2019.
////  Copyright © 2019 Techwisely. All rights reserved.
////
//



//
//  EditProfileViewController.swift
//  Former-Demo
//
//  Created by Ryo Aoyama on 10/31/15.
//  Copyright © 2015 Ryo Aoyama. All rights reserved.
//

import UIKit
import Former

final class EditProfileVC: FormViewController {
    
    // MARK: Public
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    @IBAction func btn_next(_ sender: Any) {
        self.performSegue(withIdentifier: "Dashboard", sender: nil)
    }
    // MARK: Private
    
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
        let nicknameRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
            $0.titleLabel.text = "Nickname"
            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
            }.configure {
                $0.placeholder = "Add your nickname"
                $0.text = Profile.sharedInstance.nickname
            }.onTextChanged {
                Profile.sharedInstance.nickname = $0
        }
        let locationRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
            $0.titleLabel.text = "Location"
            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
            }.configure {
                $0.placeholder = "Add your location"
                $0.text = Profile.sharedInstance.location
            }.onTextChanged {
                Profile.sharedInstance.location = $0
        }
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
        let jobRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
            $0.titleLabel.text = "Job"
            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
            }.configure {
                $0.placeholder = "Add your job"
                $0.text = Profile.sharedInstance.job
            }.onTextChanged {
                Profile.sharedInstance.job = $0
        }
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
    
    private func configure() {
        title = "Edit Profile"
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
        let moreRow = SwitchRowFormer<FormSwitchCell>() {
            $0.titleLabel.text = "Add more information ?"
            $0.titleLabel.textColor = .formerColor()
            $0.titleLabel.font = .boldSystemFont(ofSize: 15)
            $0.switchButton.onTintColor = .formerSubColor()
            }.configure {
                $0.switched = Profile.sharedInstance.moreInformation
                $0.switchWhenSelected = true
            }.onSwitchChanged { [weak self] in
                Profile.sharedInstance.moreInformation = $0
                self?.switchInfomationSection()
        }
        
        // Create Headers
        
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
//        let introductionSection = SectionFormer(rowFormer: introductionRow)
//            .set(headerViewFormer: createHeader("Introduction"))
        let aboutSection = SectionFormer(rowFormer: nameRow, genderRow, originRow, birthdayRow)
            .set(headerViewFormer: createHeader("About"))
//        let moreSection = SectionFormer(rowFormer: moreRow)
//            .set(headerViewFormer: createHeader("More Infomation"))
        
        former.append(sectionFormer: imageSection, aboutSection)
            .onCellSelected { [weak self] _ in
                self?.formerInputAccessoryView.update()
        }
        if Profile.sharedInstance.moreInformation {
            former.append(sectionFormer: informationSection)
        }
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
            former.insertUpdate(sectionFormer: informationSection, toSection: former.numberOfSections, rowAnimation: .top)
        } else {
            former.removeUpdate(sectionFormer: informationSection, rowAnimation: .top)
        }
    }
}

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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




//import Former
//
//final class EditProfileVC: FormViewController {
//
//    // MARK: Private
//
//
//    fileprivate lazy var imgProfile: LabelRowFormer<ProfileImageCell> = {
//        LabelRowFormer<ProfileImageCell>(instantiateType: .Nib(nibName: "ProfileImageCell")) {
//            $0.iconView.image = Profile.sharedInstance.image
//            }.configure {
//                $0.text = "Choose profile image from library"
//                $0.rowHeight = 60
//            }.onSelected { [weak self] _ in
//                self?.former.deselect(animated: true)
//                self?.presentImagePicker()
//        }
//    }()
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        former.append(sectionFormer: SectionFormer(rowFormer: imgProfile)
//            .set(headerViewFormer: LabelViewFormer<FormLabelHeaderView>() { view in
//                view.titleLabel.text = "Profile Image"
//            }))
//
//
//        let txtName = TextFieldRowFormer<FormTextFieldCell>()
//            .configure { row in
//                row.placeholder = "Full Name"
//            }.onSelected { row in
//                // Do Something
//        }
//        let pickerViewOrigin = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
//            $0.titleLabel.text = "Select the origin"
//            }.configure { row in
//                row.pickerItems = ["Hanafi", "Shafi", "Shia"].map {
//                    InlinePickerItem(title: "\($0)", value: Int($0))
//                }
//            }.onValueChanged { item in
//                // Do Something
//        }
//
//        let datePickerDOB = InlineDatePickerRowFormer<FormInlineDatePickerCell>() {
//            $0.titleLabel.text = "Date of birth"
////            $0.titleLabel.textColor = .formerColor()
////            $0.titleLabel.font = .boldSystemFont(ofSize: 16)
////            $0.displayLabel.textColor = .formerSubColor()
////            $0.displayLabel.font = .boldSystemFont(ofSize: 14)
//            }.inlineCellSetup {
//                $0.datePicker.datePickerMode = .date
//            }.configure {_ in
////                $0.displayEditingColor = .formerHighlightedSubColor()
//            }.displayTextFromDate(String.mediumDateShortTime)
//
//
//        let header = LabelViewFormer<FormLabelHeaderView>() { view in
//            view.titleLabel.text = "User Details"
//        }
//        let section = SectionFormer(rowFormer: txtName, pickerViewOrigin, datePickerDOB)
//            .set(headerViewFormer: header)
//        former.append(sectionFormer: section)
//
//    }
//
//    let picker = UIImagePickerController()
//
//    private func presentImagePicker() {
//
//        picker.delegate = self
//        picker.sourceType = .photoLibrary
//        picker.allowsEditing = false
//        present(picker, animated: true, completion: nil)
//    }
//}
//
//
//extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        picker.dismiss(animated: true, completion: nil)
//        Profile.sharedInstance.image = image
//        imgProfile.cellUpdate {
//            $0.iconView.image = image
//        }
//    }
//}
