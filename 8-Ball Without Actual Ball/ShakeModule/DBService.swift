//
//  DBService.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 25.11.2021.
//

import Foundation
import CoreData

class DBService {

    func loadAnswers(isLocal: Bool) -> [ManagedAnswer] {
        var answers = [DBManagedAnswer]()
        let fetchRequest = DBManagedAnswer.fetchRequest()
        let descriptor = NSSortDescriptor(key: "date", ascending: false)
        let predicate = NSPredicate(format: "isLocal == \(isLocal)")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = [descriptor]
        do {
            answers = try context.fetch(fetchRequest)
        } catch {
            fatalError("Fetch error: \(error)")
        }
        return answers.toMangedAnswers()
    }

    func saveAnswers(answers: [ManagedAnswer]) {
        for answer in answers {
            let dbAnswer = DBManagedAnswer(context: context)
            dbAnswer.answer = answer.answer
            dbAnswer.type = answer.type
            dbAnswer.isLocal = answer.isLocal
            dbAnswer.date = answer.date
        }
        saveContext()
        NotificationCenter.default.post(name: Notification.Name( rawValue: L10n.loadAnswers), object: nil)
    }

    // MARK: - Core Data stack

    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "8BallModel")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
