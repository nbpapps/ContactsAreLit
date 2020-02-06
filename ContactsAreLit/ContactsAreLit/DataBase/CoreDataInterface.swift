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

enum CoreDataError :Error {
    case saveError(errorMessage : String)
}


struct CoreDataInterface {
    
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func saveContactWith(name : String,phone : String, email : String?,image : Data?,and completion: @escaping saveCompletion) {
        persistentContainer.viewContext.perform {
            let contact = Contact(context: self.persistentContainer.viewContext)
            contact.name = name
            contact.phone = phone
            contact.email = email
            contact.image = image
            do {
                try self.persistentContainer.viewContext.save()
                completion(nil)
            }catch{
                completion(.saveError(errorMessage: "error saving contact \(error.localizedDescription)"))
            }
        }
    }
    
    func fetch() -> [Contact]?{
        let request = Contact.createFetchRequest()
        let sort = NSSortDescriptor(key: "name", ascending: true)
        request.sortDescriptors = [sort]
        do {
            let contacts = try persistentContainer.viewContext.fetch(request)
            return contacts
        }catch{
            return nil
        }
        
    }
    
}
