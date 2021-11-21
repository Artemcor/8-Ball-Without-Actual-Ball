//
//  Wireframe.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import UIKit

class Wireframe {
    class func buildShakeViewController() -> ShakeViewController {
        let apiService = ShakeAPIService()
        let model = ShakeModel(apiService: apiService)
        let viewModel = ShakeViewModel(model: model)
        let shakeViewController = ShakeViewController(viewModel: viewModel)

        viewModel.delegate = shakeViewController
        return shakeViewController
    }

    class func buildSettingsViewController() -> SettingsViewController {
        let model = SettingsModel()
        let viewModel = SettingsViewModel(model: model)
        let settingsViewController = SettingsViewController(viewModel: viewModel)
        return settingsViewController
    }
}
