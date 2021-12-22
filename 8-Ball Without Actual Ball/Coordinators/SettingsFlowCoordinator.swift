//
//  SettingsFlowCoordinator.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 20.12.2021.
//

import UIKit
enum OrdersEventForSettingsVC: NavigationEvent {
    case shake
}

class SettingsFlowCoordinator: NavigationNode {
    weak var containerViewController: UIViewController?
    private let dbService: DBService

    init(parent: NavigationNode, dbService: DBService) {
        self.dbService = dbService
        super.init(parent: parent)
        addHandlers()
    }

    private func addHandlers() {
        addHandler { [weak self] (event: OrdersEventForSettingsVC) in
            guard let self = self else { return }
            switch event {
            case .shake:
                self.dissmissSettingsController()
            }
        }
    }

    func dissmissSettingsController() {
        containerViewController?.navigationController?.popViewController(animated: true)
    }
}

extension SettingsFlowCoordinator: FlowCoordinator {
    func createFlow() -> UIViewController {
        let model = SettingsModel(dbService: dbService, parent: self)
        let viewModel = SettingsViewModel(model: model)
        let settingsViewController = SettingsViewController(viewModel: viewModel)
        containerViewController = settingsViewController
        return settingsViewController
    }
}
