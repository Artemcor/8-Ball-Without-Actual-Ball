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
        dbService.saveLocalAnswers(answers: [answer])
    }

    // MARK: - Initialization

    init(dbService: DBService) {
        self.dbService = dbService
    }
}
