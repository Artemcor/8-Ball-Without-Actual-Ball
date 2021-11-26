//
//  HistoryAnswer+CoreDataProperties.swift
//  
//
//  Created by Стожок Артём on 26.11.2021.
//
//

import Foundation
import CoreData


extension HistoryAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryAnswer> {
        return NSFetchRequest<HistoryAnswer>(entityName: "HistoryAnswer")
    }

    @NSManaged public var answer: String?
    @NSManaged public var date: Date?

}
