//
//  ShowContactViewController.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 07/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class ShowContactViewController: ContactViewController {
    
    var makeCallButton : CALButton!
    
    var contact : Contact
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureMakeCallButton()
        layoutShowContactView()
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
    
    private func layoutShowContactView() {
        NSLayoutConstraint.activate([
            makeCallButton.topAnchor.constraint(equalTo: phoneTextField.topAnchor),
            makeCallButton.leadingAnchor.constraint(equalTo: phoneTextField.leadingAnchor),
            makeCallButton.trailingAnchor.constraint(equalTo: phoneTextField.trailingAnchor),
            makeCallButton.bottomAnchor.constraint(equalTo: phoneTextField.bottomAnchor)
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
    
    //MARK: - actions
    @objc private func makeCallButtonTapped() {
        makeCall()
    }
    
    private func makeCall() {
        if let phone = contact.phone, let phoneUrl = URL(string: "tel://" + phone),UIApplication.shared.canOpenURL(phoneUrl) {
            UIApplication.shared.open(phoneUrl, options: [:], completionHandler: nil)
        }
    }
    
}
