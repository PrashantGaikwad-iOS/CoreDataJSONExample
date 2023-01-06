//
//  CDEmployee+CoreDataProperties.swift
//  CoreDBLearning
//
//  Created by prashant on 06/01/23.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var jsonFile: Data?
    @NSManaged public var name: String?
    @NSManaged public var profilePhoto: Data?

    func convertToEmployee() -> Employee {
        return Employee(name: self.name,
                        email: self.email,
                        profilePicture: self.profilePhoto,
                        id: self.id!,
                        jsonFile: self.jsonFile)
        
    }
}

extension CDEmployee : Identifiable {

}
