//
//  Answers+CoreDataProperties.swift
//  
//
//  Created by Стожок Артём on 26.11.2021.
//
//

import Foundation
import CoreData


extension Answers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Answers> {
        return NSFetchRequest<Answers>(entityName: "Answers")
    }

    @NSManaged public var historyAnswers: NSSet?
    @NSManaged public var localAnswers: NSSet?

}

// MARK: Generated accessors for historyAnswers
extension Answers {

    @objc(addHistoryAnswersObject:)
    @NSManaged public func addToHistoryAnswers(_ value: HistoryAnswer)

    @objc(removeHistoryAnswersObject:)
    @NSManaged public func removeFromHistoryAnswers(_ value: HistoryAnswer)

    @objc(addHistoryAnswers:)
    @NSManaged public func addToHistoryAnswers(_ values: NSSet)

    @objc(removeHistoryAnswers:)
    @NSManaged public func removeFromHistoryAnswers(_ values: NSSet)

}

// MARK: Generated accessors for localAnswers
extension Answers {

    @objc(addLocalAnswersObject:)
    @NSManaged public func addToLocalAnswers(_ value: LocalAnswer)

    @objc(removeLocalAnswersObject:)
    @NSManaged public func removeFromLocalAnswers(_ value: LocalAnswer)

    @objc(addLocalAnswers:)
    @NSManaged public func addToLocalAnswers(_ values: NSSet)

    @objc(removeLocalAnswers:)
    @NSManaged public func removeFromLocalAnswers(_ values: NSSet)

}
