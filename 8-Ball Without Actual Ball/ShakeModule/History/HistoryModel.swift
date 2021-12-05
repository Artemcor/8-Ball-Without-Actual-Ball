//
//  HistoryModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 26.11.2021.
//

import Foundation

class HistoryModel {
    private let dbService: DBService

    func fetchAnswers(completion: @escaping (_ result: [Answer]) -> Void) {
        dbService.loadAnswers(isLocal: false) {result in
            let answers = result.toAnswers()
            completion(answers)
        }
    }

    init(dbService: DBService) {
        self.dbService = dbService
    }
}
