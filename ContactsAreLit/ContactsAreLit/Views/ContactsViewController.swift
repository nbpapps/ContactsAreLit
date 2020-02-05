//
//  ContactsViewController.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 05/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class ContactsViewController: UIViewController {
    var contactsCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configueAddButton()
        configureContactsCollectionView()
        
    }
    
    //MARK: - create properties
    
    private func configureView() {
        title = Text.contacts
        view.backgroundColor = .systemBackground
    }
    
    private func configureContactsCollectionView() {
        
    }
    
    private func configueAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    //MARK: - actions
    
    @objc private func addContactButtonTapped() {
        showAddContactViewController()
    }
    
    private func showAddContactViewController() {
        let addContactViewController = AddContactViewController()
        let navController = UINavigationController(rootViewController: addContactViewController)
//        navigationController?.show(addContactViewController, sender: self)
        present(navController, animated: true) {
            
        }

    }

}
