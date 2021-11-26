//
//  AnswerCoreDataModel+CoreDataProperties.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 25.11.2021.
//
//

import Foundation
import CoreData


extension AnswerCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AnswerCoreDataModel> {
        return NSFetchRequest<AnswerCoreDataModel>(entityName: "AnswerCoreDataModel")
    }

    @NSManaged public var answer: String?
    @NSManaged public var type: String?

}

extension AnswerCoreDataModel : Identifiable {

}
