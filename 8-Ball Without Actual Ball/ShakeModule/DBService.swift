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

    // MARK: - HistoryAnswers methods

    func saveHistoryAnswers(answers: [Answer]) {
        for answer in answers {
            let dbAnswer = HistoryDBAnswer(context: context)
            dbAnswer.answer = answer.answer
            dbAnswer.date = Date()
        }
        do {
            try context.save()
        } catch {
            fatalError("Error: \(error)")
        }
    }

    func loadHistoryAnswers() -> [HistoryDBAnswer] {
        var answers = [HistoryDBAnswer]()
        let fetchRequest = NSFetchRequest<HistoryDBAnswer>()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let entity = HistoryDBAnswer.entity()
        fetchRequest.entity = entity
        do {
            answers = try context.fetch(fetchRequest)
        } catch {
            fatalError("Fetch error: \(error)")
        }
        return answers
    }

    // MARK: - LocalAnswers methods

    func loadLocalsAnswers() -> [LocalDBAnswer] {
        var answers = [LocalDBAnswer]()
        let fetchRequest = NSFetchRequest<LocalDBAnswer>()
        let entity = LocalDBAnswer.entity()
        fetchRequest.entity = entity
        do {
            answers = try context.fetch(fetchRequest)
        } catch {
            fatalError("Fetch error: \(error)")
        }
        return answers
    }

    func saveLocalAnswers(answers: [Answer]) {
        for answer in answers {
            let dbAnswer = LocalDBAnswer(context: context)
            dbAnswer.answer = answer.answer
            dbAnswer.type = answer.type
        }
        do {
            try context.save()
        } catch {
            fatalError("Error: \(error)")
        }
        NotificationCenter.default.post(name: Notification.Name( rawValue: L10n.loadAnswers), object: nil)
    }

    init(context: NSManagedObjectContext) {
        self.context = context
    }
}
