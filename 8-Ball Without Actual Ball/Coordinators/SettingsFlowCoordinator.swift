//
//  SettingsFlowCoordinator.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 20.12.2021.
//

import UIKit

class SettingsFlowCoordinator: NavigationNode, FlowCoordinator {
    var containerViewController: UIViewController?
    private let dbService: DBService

    init(parent: NavigationNode, dbService: DBService) {
        self.dbService = dbService
        super.init(parent: parent)
    }

    func createFlow() -> UIViewController {
        let model = SettingsModel(dbService: dbService)
        let viewModel = SettingsViewModel(model: model)
        let settingsViewController = SettingsViewController(viewModel: viewModel)
        return settingsViewController
    }
}
