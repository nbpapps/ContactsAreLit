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
    
    //MARK: - actions
    
    @objc private func addContactButtonTapped() {
        showAddContactViewController()
    }
    
    private func showAddContactViewController() {
        let addContactViewController = AddContactViewController(coreDataInterface: coreDataInterface)
        let navController = UINavigationController(rootViewController: addContactViewController)
        navController.modalPresentationStyle = .fullScreen
        present(navController, animated: true) {
            
        }
    }
    
    //MARK: - fetch
    func fetch() {
        guard let contacts = coreDataInterface.fetch() else{
            return
        }
        updateSnapshotWith(contacts: contacts)
    }

}
