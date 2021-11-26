//
//  DBService.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 25.11.2021.
//

import Foundation
import CoreData

class DBService {
    private let context: NSManagedObjectContext

    func save(answers: [Answer]) {
        for answer in answers {
            let dbAnswer = CoreDataAnswer(context: context)
            dbAnswer.answer = answer.answer
            dbAnswer.type = answer.type
        }
        do {
            try context.save()
        } catch {
            fatalError("Error: \(error)")
        }
        NotificationCenter.default.post(name: Notification.Name( rawValue: "load answers"), object: nil)
    }

    func loadAnswers() -> [CoreDataAnswer] {
        var answers = [CoreDataAnswer]()
        let fetchRequest = NSFetchRequest<CoreDataAnswer>()
        let entity = CoreDataAnswer.entity()
        fetchRequest.entity = entity
        do {
            answers = try context.fetch(fetchRequest)
        } catch {
            fatalError("Fetch error: \(error)")
        }
        return answers
    }

    init(context: NSManagedObjectContext) {
        self.context = context
    }
}
