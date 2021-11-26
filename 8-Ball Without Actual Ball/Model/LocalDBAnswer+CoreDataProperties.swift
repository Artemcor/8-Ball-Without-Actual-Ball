//
//  LocalDBAnswer+CoreDataProperties.swift
//  
//
//  Created by Стожок Артём on 26.11.2021.
//
//

import Foundation
import CoreData

extension LocalDBAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalDBAnswer> {
        return NSFetchRequest<LocalDBAnswer>(entityName: "LocalDBAnswer")
    }

    @NSManaged public var answer: String
    @NSManaged public var type: String

}
