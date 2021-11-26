//
//  CoreDataAnswer+CoreDataProperties.swift
//  
//
//  Created by Стожок Артём on 25.11.2021.
//
//

import Foundation
import CoreData


extension CoreDataAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreDataAnswer> {
        return NSFetchRequest<CoreDataAnswer>(entityName: "CoreDataAnswer")
    }

    @NSManaged public var answer: String
    @NSManaged public var type: String

}
