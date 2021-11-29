//
//  SettingsModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.11.2021.
//

import Foundation

class SettingsModel {
    private let dbService: DBService

    func saveAnswers(_ answer: Answer) {
        let manegedAnswer = answer.toManaged(isLocal: true)
        dbService.saveAnswers(answers: [manegedAnswer])
    }

    // MARK: - Initialization

    init(dbService: DBService) {
        self.dbService = dbService
    }
}
