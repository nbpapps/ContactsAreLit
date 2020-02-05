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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configueImageView()
        configureSelectPhotoButton()
        layoutView()
        
    }
    
    //MARK: - configure
    private func configureView() {
        title = Text.addContact
        view.backgroundColor = .systemBackground
    }
    
    private func configueImageView() {
        contactImageView = CALImageView(image: UIImage(named: Text.placeholderImageName))
        view.addSubview(contactImageView)
    }
    
    private func configureSelectPhotoButton() {
        selectPhotoButton = CALButton(backgroundColor: .clear, image: UIImage(systemName: Text.addPhoto)!)
        view.addSubview(selectPhotoButton)
    }
    
    private func layoutView() {
        NSLayoutConstraint.activate([
            selectPhotoButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Values.imageViewPadding),
            selectPhotoButton.heightAnchor.constraint(equalTo: selectPhotoButton.widthAnchor),
            selectPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
//            contactImageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: Values.imageViewPadding),
//            contactImageView.heightAnchor.constraint(equalTo: contactImageView.widthAnchor),
//            contactImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    
    
    


}
