//
//  DBManagedAnswer+CoreDataProperties.swift
//  
//
//  Created by Стожок Артём on 28.11.2021.
//
//

import Foundation
import CoreData


extension DBManagedAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DBManagedAnswer> {
        return NSFetchRequest<DBManagedAnswer>(entityName: "DBManagedAnswer")
    }

    @NSManaged public var answer: String?
    @NSManaged public var date: Date?
    @NSManaged public var isLocal: Bool
    @NSManaged public var type: String?

}
