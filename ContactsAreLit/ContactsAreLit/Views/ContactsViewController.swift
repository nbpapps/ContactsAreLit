//
//  ContactsViewController.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 05/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import UIKit

final class ContactsViewController: UIViewController,UICollectionViewDelegate {
   
    var contactsCollectionView : UICollectionView!
    var diffableDataSource : UICollectionViewDiffableDataSource<String,Contact>!
    
    let coreDataInterface : CoreDataInterface
    
    //MARK: - init
    init(coreDataInterface : CoreDataInterface) {
        self.coreDataInterface = coreDataInterface
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Text.noStoryboradImplementation)
    }
    
    //MARK:- life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configueAddButton()
        configureContactsCollectionView()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }
    
    //MARK: - config
    
    private func configureView() {
        title = Text.contacts
        view.backgroundColor = .systemBackground
    }
    
    private func configureContactsCollectionView() {
        contactsCollectionView = UICollectionView(frame: view.bounds, collectionViewLayout:UIConfig.createFlowLayout(in: view, numberOfColums: Values.numberOfCollectionViewColums))
        view.addSubview(contactsCollectionView)
        contactsCollectionView.backgroundColor = .systemBackground
        contactsCollectionView.register(ContactCollectionViewCell.self, forCellWithReuseIdentifier: ContactCollectionViewCell.reuseId)
        contactsCollectionView.delegate = self
    }
    
    private func configureDataSource() {
        diffableDataSource = UICollectionViewDiffableDataSource<String,Contact>(collectionView: contactsCollectionView, cellProvider: { (collectionView, indexPath, contact) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContactCollectionViewCell.reuseId, for: indexPath) as? ContactCollectionViewCell else {
                preconditionFailure(Text.incorrectCell)

            }
            cell.contactName.text = contact.name
            if let imageData = contact.image {
                cell.contactImageView.image = UIImage(data: imageData)
            }else{
                cell.contactImageView.image = UIImage(named: Text.placeholderImageName)
            }
            
            return cell
        })
    }
    
    private func configueAddButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContactButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    //MARK: - update
    private func updateSnapshotWith(contacts : [Contact]) {
        var snapshot = NSDiffableDataSourceSnapshot<String,Contact>()
        snapshot.appendSections(["a"])
        snapshot.appendItems(contacts)
        diffableDataSource.apply(snapshot)
    }
    
    private func updateContact(contact : Contact,for status : ContactStatusChange) {
        switch status {
        case .update:
            var currentSnapshot = diffableDataSource.snapshot()
            currentSnapshot.reloadItems([contact])
            diffableDataSource.apply(currentSnapshot)
        case .delete:
            var currentSnapshot = diffableDataSource.snapshot()
            currentSnapshot.deleteItems([contact])
            diffableDataSource.apply(currentSnapshot)
        case .none:
            break
        }
    }
    
    
    //MARK: - actions
    
    @objc private func addContactButtonTapped() {
        showAddContactViewController()
    }
    
    private func showAddContactViewController() {
        let addContactViewController = AddContactViewController(coreDataInterface: coreDataInterface, isEditingContact: true)
        let navController = UINavigationController(rootViewController: addContactViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true)
    }
    
    //MARK: - fetch
    func fetch() {
        coreDataInterface.fetchContact { (result) in
            switch result {
            case .success(let contacts) :
                DispatchQueue.main.async {
                    self.updateSnapshotWith(contacts: contacts)
                }
            case .failure(let error):
                print("fetch error \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: - collection view delegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let contact = diffableDataSource.itemIdentifier(for: indexPath) {
            let showContactViewController = ShowContactViewController(coreDataInterface: coreDataInterface, isEditingContact: false,contact: contact)
            showContactViewController.onContactStatusChange  = { [weak self] status,contact in
                self?.updateContact(contact: contact, for: status)
            }
            navigationController?.pushViewController(showContactViewController, animated: true)
        }
    }

}
