//
//  SettingsModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.11.2021.
//

import Foundation

class SettingsModel: NavigationNode {
    private let dbService: DBService

    func saveAnswers(_ answer: Answer) {
        let manegedAnswer = answer.toManaged(isLocal: true)
        dbService.saveAnswers(answers: [manegedAnswer])
    }

    func dismissSettingsVC() {
        raise(event: OrdersEventForSettingsVC.shake)
    }

    // MARK: - Initialization

    init(dbService: DBService, parent: NavigationNode) {
        self.dbService = dbService
        super.init(parent: parent)
    }
}
