//
//  SettingsViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.11.2021.
//

import Foundation

class SettingsViewModel {
    private let settingModel: SettingsModel
    private let coordinator: SettingsRoutable

    func answerRecieved(_ answer: PresentableAnswer) {
        let answer = answer.toAnswer()
        settingModel.saveAnswers(answer)
    }

    func buttonPressed() {
        coordinator.dissmissSettingsController()
    }

    // MARK: - Initialization

    init (model: SettingsModel, coordinator: SettingsFlowCoordinator) {
        settingModel = model
        self.coordinator = coordinator
    }
}
