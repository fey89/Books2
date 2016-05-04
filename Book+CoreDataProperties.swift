//
//  Book+CoreDataProperties.swift
//  Books2
//
//  Created by formateur on 03/05/2016.
//  Copyright © 2016 IPSSI. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Book {

    @NSManaged var title: String?
    @NSManaged var price: NSNumber?
    @NSManaged var year: NSNumber?
    @NSManaged var author: NSManagedObject?

}
