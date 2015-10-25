//
//  AWPerson+CoreDataProperties.swift
//  RandomPeople
//
//  Created by ryan on 10/25/15.
//  Copyright © 2015 while1.io. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension AWPerson {

    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var dateOfBirth: NSDate?

}
