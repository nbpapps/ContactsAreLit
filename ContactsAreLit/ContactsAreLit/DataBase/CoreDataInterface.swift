//
//  CoreDataInterface.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 06/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import CoreData

typealias saveCompletion = (CoreDataError?) -> Void
typealias fetchCompletion = (Result<[Contact],CoreDataError>) -> Void
typealias deleteCompletion = (CoreDataError?) -> Void

enum CoreDataError :Error {
    case coreDataError(errorMessage : String)
}

struct CoreDataInterface {
    
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func delete(contact : Contact, withCompletion completion : @escaping deleteCompletion) {
        persistentContainer.viewContext.delete(contact)
        do {
            try self.persistentContainer.viewContext.save()
            completion(nil)
        }catch{
            completion(.coreDataError(errorMessage: "error saving contact \(error.localizedDescription)"))
        }
    }
    
    func update(with completion: @escaping saveCompletion) {
        persistentContainer.viewContext.perform {
            do {
                try self.persistentContainer.viewContext.save()
                completion(nil)
            }catch{
                completion(.coreDataError(errorMessage: "error saving contact \(error.localizedDescription)"))
            }
        }
    }
    
    func saveContactWith(name : String,phone : String, email : String?,imageData : Data?,and completion: @escaping saveCompletion) {
        persistentContainer.viewContext.perform {
            let contact = Contact(context: self.persistentContainer.viewContext)
            contact.name = name
            contact.phone = phone
            contact.email = email
            contact.image = imageData
            contact.id = UUID()
            
            do {
                try self.persistentContainer.viewContext.save()
                completion(nil)
            }catch{
                completion(.coreDataError(errorMessage: "error saving contact \(error.localizedDescription)"))
            }
        }
    }
    
    func fetchContact(with completion : @escaping fetchCompletion) {
        let request = Contact.createFetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        
        //we use a DispatchQueue to preform the fetch in the background
        let queue = DispatchQueue(label: Text.fetchContactQueueTag,qos:.userInteractive)
        queue.async {
            do {
                let contacts = try self.persistentContainer.viewContext.fetch(request)
                completion(.success(contacts))
            }catch{
                completion(.failure(.coreDataError(errorMessage: "error fetching contacts \(error.localizedDescription)")))
            }
        }
    }
    
}
