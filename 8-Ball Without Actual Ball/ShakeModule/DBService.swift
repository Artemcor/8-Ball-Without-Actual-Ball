//
//  DBService.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 25.11.2021.
//

import Foundation
import CoreData

class DBService {

    func loadAnswers(isLocal: Bool, completion: @escaping ((_ result: [ManagedAnswer]) -> Void)) {
        backgroundMOC.perform {
            let fetchRequest = DBManagedAnswer.fetchRequest()
            let descriptor = NSSortDescriptor(key: "date", ascending: false)
            let predicate = NSPredicate(format: "isLocal == \(isLocal)")
            fetchRequest.predicate = predicate
            fetchRequest.sortDescriptors = [descriptor]
            do {
                let DBManagedAnswers = try self.backgroundMOC.fetch(fetchRequest)
                completion(DBManagedAnswers.toMangedAnswers())
            } catch {
                fatalError("Fetch error: \(error)")
            }
        }
    }

    func saveAnswers(answers: [ManagedAnswer]) {
        backgroundMOC.perform {
            for answer in answers {
                let dbAnswer = DBManagedAnswer(context: self.backgroundMOC)
                dbAnswer.answer = answer.answer
                dbAnswer.type = answer.type
                dbAnswer.isLocal = answer.isLocal
                dbAnswer.date = answer.date
            }
            self.saveContext()
        }
    }

    // MARK: - Core Data stack

    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    private lazy var backgroundMOC = persistentContainer.newBackgroundContext()
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
        if self.backgroundMOC.hasChanges {
            do {
                try self.backgroundMOC.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
