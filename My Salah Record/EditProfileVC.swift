//
//  EditProfileVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 03/06/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import UIKit
import Former
import FirebaseAuth

final class EditProfileVC: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    func save() {
        
        let profile = Profile.sharedInstance
        if  profile.name != nil && profile.birthDay != nil {
            Profile.sharedInstance.id = Auth.auth().currentUser!.uid
            Profile.sharedInstance.startedDate = Date()
            FirebaseFetcher.sharedInstance.addUser(userProfile: Profile.sharedInstance) {
                DispatchQueue.main.async {
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarVC") else { return }
                    self.present(vc, animated: true, completion: nil)
                }
            }
        } else {
            self.popUp(message: "Please provide your valid Name and Date of Birth")
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
        let locationRow = TextFieldRowFormer<ProfileFieldCell>(instantiateType: .Nib(nibName: "ProfileFieldCell")) { [weak self] in
            $0.titleLabel.text = "Location"
            $0.textField.inputAccessoryView = self?.formerInputAccessoryView
            }.configure {
                $0.placeholder = "Add your location"
                $0.text = Profile.sharedInstance.location
            }.onTextChanged {
                Profile.sharedInstance.location = $0
        }
        let periodRow = StepperRowFormer<FormStepperCell>(){
            $0.titleLabel.text = "Period Length"
            }.displayTextFromValue {
                "\(Int($0)) Days"
            }.onValueChanged({ (value) in
                Profile.sharedInstance.periodcycle = "\(Int(value))"
            })
        
        let cycleRow = StepperRowFormer<FormStepperCell>(){
            $0.titleLabel.text = "Cycle Length"
            }.displayTextFromValue {
                "\(Int($0)) Days"
            }.onValueChanged({ (value) in
                Profile.sharedInstance.cycleLength = "\(Int(value))"
            })
        
        return SectionFormer(rowFormer: periodRow, cycleRow)
    }()
    
    private lazy var signOutSection: SectionFormer = {
        let signOutRow = LabelRowFormer<FormLabelCell>()
            .configure { row in
                row.text = "Save & Begin"
            }.onSelected { row in
                self.save()
        }
        return SectionFormer(rowFormer: signOutRow)
    }()
    
    private func configure() {
        title = "Edit Profile"
        tableView.contentInset.top = 0
        tableView.contentInset.bottom = 0
//        tableView.backgroundColor = .white
        
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
        
        let imageSection = SectionFormer(rowFormer: imageRow).set(headerViewFormer: createHeader("Profile Image"))
        let aboutSection = SectionFormer(rowFormer: nameRow, genderRow, originRow, birthdayRow, introductionRow).set(headerViewFormer: createHeader("About"))
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

extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            Profile.sharedInstance.image = image
            imageRow.cellUpdate {
                $0.iconView.image = image
                FirebaseFetcher.sharedInstance.uploadImage(userID: Profile.sharedInstance.id ?? "default", image: image)
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
