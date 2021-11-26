//
//  HistoryDBAnswer+CoreDataProperties.swift
//  
//
//  Created by Стожок Артём on 26.11.2021.
//
//

import Foundation
import CoreData


extension HistoryDBAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryDBAnswer> {
        return NSFetchRequest<HistoryDBAnswer>(entityName: "HistoryDBAnswer")
    }

    @NSManaged public var answer: String?
    @NSManaged public var date: Date?

}
