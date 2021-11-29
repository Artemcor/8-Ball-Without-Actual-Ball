//
//  DBManagedAnswer+CoreDataClass.swift
//  
//
//  Created by Стожок Артём on 28.11.2021.
//
//

import Foundation
import CoreData

@objc(DBManagedAnswer)
public class DBManagedAnswer: NSManagedObject {

}

extension DBManagedAnswer {
    func toMangedAnswer() -> ManagedAnswer {
        let managedAnswer = ManagedAnswer(answer: self.answer, type: self.type, date: self.date, isLocal: self.isLocal)
        return managedAnswer
    }
}
