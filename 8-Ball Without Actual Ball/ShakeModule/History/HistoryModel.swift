//
//  HistoryModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 26.11.2021.
//

import Foundation

class HistoryModel {
    private let dbService: DBService

    func fetchAnswers() -> [HistoryAnswer] {
        var answers = [HistoryAnswer]()
        let dbAnswers = dbService.loadHistoryAnswers()
        for dbAnswer in dbAnswers {
            let answer = HistoryAnswer(answer: dbAnswer.answer, date: dbAnswer.date)
            answers.append(answer)
        }
        return answers
    }

    init(dbService: DBService) {
        self.dbService = dbService
    }
}
