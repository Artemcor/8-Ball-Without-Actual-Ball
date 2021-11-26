//
//  LocalAnswer+CoreDataProperties.swift
//  
//
//  Created by Стожок Артём on 26.11.2021.
//
//

import Foundation
import CoreData


extension LocalAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalAnswer> {
        return NSFetchRequest<LocalAnswer>(entityName: "LocalAnswer")
    }

    @NSManaged public var answer: String?
    @NSManaged public var type: String?

}
