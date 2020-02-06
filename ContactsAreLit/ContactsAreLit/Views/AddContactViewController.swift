//
//  AddContactViewController.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 05/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class AddContactViewController: UIViewController {

    var contactImageView : CALImageView!
    var selectPhotoButton : CALButton!
    var plusImageView : CALImageView!
    
    var nameTextField : CALTextField!
    var phoneTextField : CALTextField!
    var emailTextField : CALTextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configueContactImageView()
        configurePlusImageView()
        configureSelectPhotoButton()
        configureNameTextField()
        configureEmailTextField()
        configurePhoneTextField()
        configueNavButtons()
        layoutView()
    }
    
    //MARK: - configure
    private func configureView() {
        title = Text.addContact
        view.backgroundColor = .systemBackground
    }
    
    private func configueContactImageView() {
        contactImageView = CALImageView(image: UIImage(named: Text.placeholderImageName))
        view.addSubview(contactImageView)
    }
    
    private func configurePlusImageView() {
        plusImageView = CALImageView(image:  UIImage(systemName: Text.addPhoto)!)
        view.addSubview(plusImageView)
    }
    
    private func configureSelectPhotoButton() {
        selectPhotoButton = CALButton(backgroundColor: .clear, title: "")
        selectPhotoButton.addTarget(self, action: #selector(selectContactImageButtonTapped), for: .touchUpInside)
        view.addSubview(selectPhotoButton)
    }
    
    private func configureNameTextField() {
        nameTextField = CALTextField(placeholderText:Text.enterContactName, keyboardType: .default)
        view.addSubview(nameTextField)
    }
    
    private func configurePhoneTextField() {
        phoneTextField = CALTextField(placeholderText:Text.enterContactPhone, keyboardType: .phonePad)
        view.addSubview(phoneTextField)
    }
    
    private func configureEmailTextField() {
        emailTextField = CALTextField(placeholderText:Text.enterContactEmail, keyboardType: .emailAddress)
        view.addSubview(emailTextField)
    }
    
    private func configueNavButtons() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    
    //MARK:- layout
    private func layoutView() {
        NSLayoutConstraint.activate([
            contactImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Values.imageViewPadding),
            contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor),
            contactImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            plusImageView.leadingAnchor.constraint(equalTo: contactImageView.leadingAnchor, constant: Values.imageInImagePadding),
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
        print("selectContactImageButtonPressed")
    }
    
    @objc private func saveButtonTapped() {
        print("saveButtonPressed")
    }
    
    @objc private func cancelButtonTapped() {
        print("cancelButtonPressed")
    }
    
    
    
    


}
