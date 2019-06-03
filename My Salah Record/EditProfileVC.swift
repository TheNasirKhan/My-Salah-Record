//
//  EditProfileVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 03/06/2019.
//  Copyright © 2019 Techwisely. All rights reserved.
//

import Former

final class EditProfileVC: FormViewController {
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let labelRow = TextFieldRowFormer<FormTextFieldCell>()
            .configure { row in
                row.placeholder = "Full Name"
            }.onSelected { row in
                // Do Something
        }
        let inlinePickerRow = InlinePickerRowFormer<FormInlinePickerCell, Int>() {
            $0.titleLabel.text = "Select the origin"
            }.configure { row in
                row.pickerItems = ["Hanafi", "Shafi", "Shia"].map {
                    InlinePickerItem(title: "\($0)", value: Int($0))
                }
            }.onValueChanged { item in
                // Do Something
        }
        
        let dob = InlineDatePickerRowFormer<FormInlineDatePickerCell>() {
            $0.titleLabel.text = "Date of birth"
//            $0.titleLabel.textColor = .formerColor()
//            $0.titleLabel.font = .boldSystemFont(ofSize: 16)
//            $0.displayLabel.textColor = .formerSubColor()
//            $0.displayLabel.font = .boldSystemFont(ofSize: 14)
            }.inlineCellSetup {
                $0.datePicker.datePickerMode = .date
            }.configure {_ in
//                $0.displayEditingColor = .formerHighlightedSubColor()
            }.displayTextFromDate(String.mediumDateShortTime)
        
        
        let header = LabelViewFormer<FormLabelHeaderView>() { view in
            view.titleLabel.text = "Label Header"
        }
        let section = SectionFormer(rowFormer: imageRow, labelRow, inlinePickerRow, dob)
            .set(headerViewFormer: header)
        former.append(sectionFormer: section)
        
    }
    
    private func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = false
        present(picker, animated: true, completion: nil)
    }
}


extension EditProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        picker.dismiss(animated: true, completion: nil)
        Profile.sharedInstance.image = image
        imageRow.cellUpdate {
            $0.iconView.image = image
        }
    }
}
