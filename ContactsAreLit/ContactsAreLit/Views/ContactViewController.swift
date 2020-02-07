//
//  ContactViewController.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 07/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

class ContactViewController: UIViewController {
    
    var contactImageView : CALImageView!
    var selectPhotoButton : CALButton!
    var plusImageView : CALImageView!
    
    var nameTextField : CALTextField!
    var phoneTextField : CALTextField!
    var emailTextField : CALTextField!
    
    let coreDataInterface : CoreDataInterface
    
    var isEditingContact : Bool
    
    init(coreDataInterface : CoreDataInterface,isEditingContact : Bool) {
        self.coreDataInterface = coreDataInterface
        self.isEditingContact = isEditingContact
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Text.noStoryboradImplementation)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //            configureView()
        configueContactImageView()
        configurePlusImageView()
        configureSelectPhotoButton()
        configureNameTextField()
        configureEmailTextField()
        configurePhoneTextField()
        //            configueNavButtons()
        layoutView()
    }
    
    //MARK: - configure
    //        private func configureView() {
    //            title = Text.addContact
    //            view.backgroundColor = .systemBackground
    //        }
    
    func configueContactImageView() {
//        contactImageView = CALImageView(image: UIImage(named: Text.placeholderImageName))
        view.addSubview(contactImageView)
    }
    
    private func configurePlusImageView() {
        plusImageView = CALImageView(image:  UIImage(systemName: Text.addPhoto)!)
        view.addSubview(plusImageView)
        //        view.bringSubviewToFront(plusImageView)
    }
    
    private func configureSelectPhotoButton() {
        selectPhotoButton = CALButton(backgroundColor: .clear, title: "")
        selectPhotoButton.addTarget(self, action: #selector(selectContactImageButtonTapped), for: .touchUpInside)
        view.addSubview(selectPhotoButton)
    }
    
    func configureNameTextField() {
        //            nameTextField = CALTextField(placeholderText:Text.enterContactName, keyboardType: .default)
        view.addSubview(nameTextField)
    }
    
    func configurePhoneTextField() {
        //            phoneTextField = CALTextField(placeholderText:Text.enterContactPhone, keyboardType: .phonePad)
        view.addSubview(phoneTextField)
    }
    
    func configureEmailTextField() {
        //            emailTextField = CALTextField(placeholderText:Text.enterContactEmail, keyboardType: .emailAddress)
        view.addSubview(emailTextField)
    }
    
    //        private func configueNavButtons() {
    //            let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    //            navigationItem.rightBarButtonItem = saveButton
    //
    //            let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    //            navigationItem.leftBarButtonItem = cancelButton
    //        }
    
    
    //MARK:- layout
    private func layoutView() {
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Values.imageViewPadding),
            contactImageView.heightAnchor.constraint(equalToConstant: Values.imageViewHeight),
            contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor),
            contactImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            plusImageView.trailingAnchor.constraint(equalTo: contactImageView.leadingAnchor, constant: -20),
            plusImageView.bottomAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: -Values.imageInImagePadding),
            
            selectPhotoButton.topAnchor.constraint(equalTo: contactImageView.topAnchor),
            selectPhotoButton.leadingAnchor.constraint(equalTo: contactImageView.leadingAnchor),
            selectPhotoButton.trailingAnchor.constraint(equalTo: contactImageView.trailingAnchor),
            selectPhotoButton.bottomAnchor.constraint(equalTo: contactImageView.bottomAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: contactImageView.bottomAnchor, constant: Values.viewSpasing),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Values.textFieldPadding),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Values.textFieldPadding),
            nameTextField.heightAnchor.constraint(equalToConstant: Values.textFieldHeight),
            
            phoneTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: Values.viewSpasing),
            phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Values.textFieldPadding),
            phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Values.textFieldPadding),
            phoneTextField.heightAnchor.constraint(equalToConstant: Values.textFieldHeight),
            
            emailTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: Values.viewSpasing),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Values.textFieldPadding),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Values.textFieldPadding),
            emailTextField.heightAnchor.constraint(equalToConstant: Values.textFieldHeight)
        ])
    }
    
    
    //MARK:-actions
    @objc private func selectContactImageButtonTapped() {
        guard isEditingContact == true else {
            return
        }
        let mediaPermissions = MediaPermissions()
        mediaPermissions.checkPhotoLibraryPermission {[weak self] (photoPermition) in
            switch photoPermition {
            case .authorized:
                DispatchQueue.main.async {
                    self?.showPhotoLibrary()
                }
            case .unauthorized:
                print("no permission to select photos")
            }
            
        }
    }
    
    //        @objc private func saveButtonTapped() {
    //            saveContact()
    //        }
    //
    //        @objc private func cancelButtonTapped() {
    //            dismiss(animated: true, completion: nil)
    //        }
    
    private func showPhotoLibrary() {
        let mediaImport = MediaImport()
        add(mediaImport)
        mediaImport.openPhotoLibrary()
        mediaImport.onImageSelect = { [weak self] image in
            mediaImport.remove()
            DispatchQueue.main.async {
                self?.contactImageView.image = image
            }
        }
    }
    
    //        private func saveContact() {
    //            let name = nameTextField.text
    //            let phone = phoneTextField.text
    //            let email = emailTextField.text
    //            let imageData = contactImageView.image?.imageData
    //
    //            coreDataInterface.saveContactWith(name: name!, phone: phone!, email: email, imageData: imageData) {[weak self] (error) in
    //                if let saveError = error {
    //                    print(saveError)
    //                }else{
    //                    self?.dismiss(animated: true) {
    //
    //                    }
    //                }
    //            }
    //        }
}
