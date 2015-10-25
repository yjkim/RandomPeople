//
//  AWPerson.swift
//  RandomPeople
//
//  Created by ryan on 10/25/15.
//  Copyright © 2015 while1.io. All rights reserved.
//

import Foundation
import CoreData

@objc(AWPerson)
class AWPerson: NSManagedObject {

    var fullName: String {
        get {
            var fullName = ""
            if let firstName = firstName {
                fullName += firstName
            }
            if let lastName = lastName {
                fullName += ", \(lastName)"
            }
            return fullName
        }
    }
    
    var deceased: Bool {
        get {
            self.willAccessValueForKey("deceased")
            let deceasedNum = self.primitiveValueForKey("deceased")
            self.didAccessValueForKey("deceased")
            return deceasedNum!.boolValue
        }
        set {
            let deceasedNum = NSNumber(bool: newValue)
            self.willChangeValueForKey("deceased")
            self.setPrimitiveValue(deceasedNum, forKey: "deceased")
            self.didChangeValueForKey("deceased")
        }
    }
    
    var dateOfDeath: NSDate {
        get {
            self.willAccessValueForKey("dateOfDeath")
            let dateOfDeath = self.primitiveValueForKey("dateOfDeath")
            self.didAccessValueForKey("dateOfDeath")
            return dateOfDeath as! NSDate
        }
        set {
            self.willChangeValueForKey("dateOfDeath")
            self.setPrimitiveValue(newValue, forKey: "dateOfDeath")
            self.didChangeValueForKey("dateOfDeath")
            
            self.deceased = true
        }
    }
    
    class func personInManagedObjectContext(moc: NSManagedObjectContext) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: moc)
    }
    
    class func randomPersonInManagedObjectContext(moc: NSManagedObjectContext) -> AWPerson? {
        if let randomPerson = AWPerson.personInManagedObjectContext(moc) as? AWPerson {
            randomPerson.firstName = AWPerson.randomFirstName()
            randomPerson.lastName = AWPerson.randomLastName()
            randomPerson.dateOfDeath = NSDate(timeIntervalSince1970: NSTimeInterval(random()))
            return randomPerson
        }
        return nil
    }
    
    class func randomFirstName() -> String {
        let personFirstNamesArray = ["John", "Jane", "Adam", "Amit", "Peter", "Mary", "Susan", "Anne", "Jeffery", "Mohammed"]
        let randomIndex = random() % personFirstNamesArray.count
        return personFirstNamesArray[randomIndex]
    }
    
    class func randomLastName() -> String {
        let personLastNamesArray = ["Smith", "Patel", "Jones", "Adams", "Peterson", "Jackson", "Ali", "Jefferson", "Dickens"]
        let randomIndex = random() % personLastNamesArray.count
        return personLastNamesArray[randomIndex]
    }
}
