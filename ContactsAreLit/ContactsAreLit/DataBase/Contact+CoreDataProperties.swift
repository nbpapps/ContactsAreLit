//
//  Contact+CoreDataProperties.swift
//  ContactsAreLit
//
//  Created by niv ben-porath on 08/02/2020.
//  Copyright © 2020 nbpApps. All rights reserved.
//
//

import Foundation
import CoreData


extension Contact {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var email: String?
    @NSManaged public var image: Data?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var id: UUID?

}
