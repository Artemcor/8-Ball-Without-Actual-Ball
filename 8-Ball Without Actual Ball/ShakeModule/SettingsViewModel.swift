//
//  SettingsViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.11.2021.
//

import Foundation

class SettingsViewModel {
    private let settingModel: SettingsModel

    func answerRecieved(_ answer: PresentableAnswer) {
        let answer = answer.toAnswer()
        settingModel.saveAnswers(answer)
    }

    func buttonPressed() {
        settingModel.dismissSettingsVC()
    }

    // MARK: - Initialization

    init (model: SettingsModel) {
        settingModel = model
    }
}
