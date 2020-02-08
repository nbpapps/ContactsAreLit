//
//  ShowContactViewController.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 07/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

enum ContactStatusChange {
    case update
    case delete
    case none
  }


final class ShowContactViewController: ContactViewController {
    
    var makeCallButton : CALButton!
    var deleteButton : CALButton!
    
    var contact : Contact
    
    //we use this closure to tell the main VC that a contact has been updated
    var onContactStatusChange : (ContactStatusChange,Contact) -> () = {_,_  in }
    var contactStatusChange : ContactStatusChange = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureMakeCallButton()
        configureDeleteButton()
        configueNavButtonsForDisplayInfo()
        layoutShowContactView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        onContactStatusChange(contactStatusChange,contact)
    }
    
    init(coreDataInterface : CoreDataInterface,isEditingContact : Bool,contact : Contact) {
        self.contact = contact
        super.init(coreDataInterface: coreDataInterface, isEditingContact: isEditingContact)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Text.noStoryboradImplementation)
    }
    
    //MARK:- configure
    
    private func configureView() {
        title = Text.contactInfo
        view.backgroundColor = .systemBackground
    }
    
    private func configureMakeCallButton() {
        makeCallButton = CALButton(backgroundColor: .clear, title: "")
        makeCallButton.addTarget(self, action: #selector(makeCallButtonTapped), for: .touchUpInside)
        view.addSubview(makeCallButton)
    }
    
    private func configureDeleteButton() {
        deleteButton = CALButton(backgroundColor: .red, title: Text.deleteButton)
        deleteButton.addTarget(self, action: #selector(deleteContactButtonTapped), for: .touchUpInside)
        view.addSubview(deleteButton)
    }
    
    private func layoutShowContactView() {
        NSLayoutConstraint.activate([
            makeCallButton.topAnchor.constraint(equalTo: phoneTextField.topAnchor),
            makeCallButton.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            makeCallButton.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            makeCallButton.bottomAnchor.constraint(equalTo: phoneTextField.bottomAnchor),
            
            deleteButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Values.bottomSpacing),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Values.buttonPadding),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Values.buttonPadding)
        ])
    }
    
    override func configueContactImageView() {
        if let imageData = contact.image {
            contactImageView = CALImageView(image: UIImage(data: imageData))
        }else{
            contactImageView = CALImageView(image: UIImage(named: Text.placeholderImageName))
        }
        
        super.configueContactImageView()
    }
    
    override func configureNameTextField() {
        nameTextField = CALTextField(text: contact.name)
        super.configureNameTextField()
    }
    
    override func configurePhoneTextField() {
        phoneTextField = CALTextField(text: contact.phone, keyboardType: .phonePad,textColor: UIColor(named: Text.mainAppColor)!)
        super.configurePhoneTextField()
    }
    
    override func configureEmailTextField() {
        emailTextField = CALTextField(text: contact.email, keyboardType: .emailAddress)
        super.configureEmailTextField()
    }
    
    private func configueNavButtonsForDisplayInfo() {
        let editButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped))
        navigationItem.rightBarButtonItems = [editButton]
    }
    
    private func configureNavButtonsForEditing() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        let cancelButton = UIBarButtonItem(barButtonSystemItem:.cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItems = [saveButton,cancelButton]
    }
    
    private func populateContactInfo(contactInfo : Contact) {
        nameTextField.text = contactInfo.name
        phoneTextField.text = contactInfo.phone
        emailTextField.text = contactInfo.email
        
        if let imageData = contactInfo.image {
            contactImageView.image = UIImage(data: imageData)
        }else{
            contactImageView.image = UIImage(named: Text.placeholderImageName)
        }
    }
    
    //MARK: - change edit mode
    private func changeEditMode() {
        
        if isEditingContact {
            //we were in editing mode, now need to show display mode
            configureScreenForDisplayMode()
        }else{
            //we are in dislpay mode, need to change to edit mode
            configureScreenForEditMode()
        }
        isEditingContact.toggle()
    }
    

    //MARK: - actions
    @objc private func editButtonTapped() {
        changeEditMode()
    }
    
    @objc private func saveButtonTapped() {
        updateContactInfo()
        changeEditMode()
    }
    
    @objc private func cancelButtonTapped() {
        changeEditMode()
    }
    
    @objc private func makeCallButtonTapped() {
        makeCall()
    }
    
    @objc private func deleteContactButtonTapped() {
        showDeleteAlert()
    }
    
    private func makeCall() {
        if let phone = contact.phone, let phoneUrl = URL(string: "tel://" + phone),UIApplication.shared.canOpenURL(phoneUrl) {
            UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
        }
    }
    
    //MARK: - show delete alert
    private func showDeleteAlert() {
        let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: .alert)
        let action = UIAlertAction(title: Text.deleteAlertTitle, style: .destructive) { [weak self](action) in
            self?.deleteContact()
        }
        let cancel = UIAlertAction(title: Text.cancelAction, style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: contact changes
    
    private func deleteContact() {
        coreDataInterface.delete(contact: contact) {[weak self] (error) in
            if let deleteError = error {
                print(deleteError.localizedDescription)
            }else{
                self?.contactStatusChange = .delete
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    private func updateContactInfo() {
        contactStatusChange = .update
        contact.name = nameTextField.text
        contact.phone = phoneTextField.text
        contact.email = emailTextField.text
        contact.image = contactImageView.image?.imageData
        
        coreDataInterface.update { [weak self](error) in
            if let saveError = error {
                print(saveError.localizedDescription)
            }else if let updatedContact = self?.contact{
                self?.populateContactInfo(contactInfo: updatedContact)
            }else{
                print("no contact error")
            }
        }
    }
}

extension ShowContactViewController {
    private func configureScreenForEditMode() {
        configureNavButtonsForEditing()
        
        nameTextField.updateForEditing(withPlaceHolderText: Text.enterContactName)
        phoneTextField.updateForEditing(withPlaceHolderText: Text.enterContactPhone)
        emailTextField.updateForEditing(withPlaceHolderText: Text.enterContactEmail)
        
        makeCallButton.isHidden = true
        deleteButton.isHidden = true
    }
    
    private func configureScreenForDisplayMode() {
        view.endEditing(true)
        configueNavButtonsForDisplayInfo()
        
        nameTextField.updateForShowingText()
        phoneTextField.updateForShowingText(with: UIColor(named: Text.mainAppColor)!)
        emailTextField.updateForShowingText()
        
        makeCallButton.isHidden = false
        deleteButton.isHidden = false

        populateContactInfo(contactInfo: contact)
    }
       
}
