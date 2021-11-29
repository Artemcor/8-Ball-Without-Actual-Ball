//
//  Extensions.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 28.11.2021.
//

import Foundation
import CoreData

extension Array where Element == Answer {
    func toMangedLocalAnswers() -> [ManagedAnswer] {
        return self.map { $0.toManaged(isLocal: true) }
    }

    func toPresentable() -> [PresentableAnswer] {
        return self.map { $0.toPresentable() }
    }
}

extension Array where Element == DBManagedAnswer {
    func toMangedAnswers() -> [ManagedAnswer] {
        return self.map { $0.toMangedAnswer() }
    }
}

extension Array where Element == ManagedAnswer {
    func toAnswers() -> [Answer] {
        return self.map { $0.toAnswer() }
    }
}

extension DBManagedAnswer {
    func toMangedAnswer() -> ManagedAnswer {
        let managedAnswer = ManagedAnswer(answer: self.answer, type: self.type, date: self.date, isLocal: self.isLocal)
        return managedAnswer
    }
}

extension NSManagedObject {
    convenience init(context: NSManagedObjectContext) {
        let name = String(describing: type(of: self))
        let entity = NSEntityDescription.entity(forEntityName: name, in: context)!
        self.init(entity: entity, insertInto: context)
    }
}
