//
//  AddContactViewController.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 05/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class AddContactViewController: ContactViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configueNavButtons()
    }
    
    //MARK: - configure
    private func configureView() {
        title = Text.addContact
        view.backgroundColor = .systemBackground
    }
    
    override func configueContactImageView() {
        contactImageView = CALImageView(image: UIImage(named: Text.placeholderImageName))
        super.configueContactImageView()
    }
    
    override func configureNameTextField() {
        nameTextField = CALTextField(placeholderText:Text.enterContactName, keyboardType: .default)
        super.configureNameTextField()
    }
    
    override func configurePhoneTextField() {
        phoneTextField = CALTextField(placeholderText:Text.enterContactPhone, keyboardType: .phonePad)
        super.configurePhoneTextField()
    }
    
    override func configureEmailTextField() {
        emailTextField = CALTextField(placeholderText:Text.enterContactEmail, keyboardType: .emailAddress)
        super.configureEmailTextField()
    }
    
    private func configueNavButtons() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        navigationItem.rightBarButtonItem = saveButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    
    //MARK:-actions
    @objc private func saveButtonTapped() {
        saveContact()
    }
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func saveContact() {
        let name = nameTextField.text
        let phone = phoneTextField.text
        let email = emailTextField.text
        let imageData = contactImageView.image?.imageData
        
        coreDataInterface.saveContactWith(name: name!, phone: phone!, email: email, imageData: imageData) {[weak self] (error) in
            if let saveError = error {
                print(saveError)
            }else{
                self?.dismiss(animated: true) {}
            }
        }
    }
}
