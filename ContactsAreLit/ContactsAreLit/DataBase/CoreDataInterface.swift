//
//  CoreDataInterface.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 06/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataInterface {
    
    let persistentContainer: NSPersistentContainer
    
    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }
    
    func saveContactWith(name : String,phone : String, email : String,image : Data) {
        persistentContainer.viewContext.perform {
            let contact = Contact(context: self.persistentContainer.viewContext)
            contact.name = name
            contact.phone = phone
            contact.email = email
            contact.image = image
            
            do {
                try self.persistentContainer.viewContext.save()
            }catch{
                
            }
        }
    }
}
