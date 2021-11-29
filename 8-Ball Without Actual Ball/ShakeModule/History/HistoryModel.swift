//
//  HistoryModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 26.11.2021.
//

import Foundation

class HistoryModel {
    private let dbService: DBService

    func fetchAnswers() -> [Answer] {
        let managedAnswers = dbService.loadAnswers(isLocal: false)
        return managedAnswers.toAnswers()
    }

    init(dbService: DBService) {
        self.dbService = dbService
    }
}
