//
//  ShakeCoordinator.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 20.12.2021.
//

import UIKit

enum OrdersEventForShakeVC: NavigationEvent {
    case settings
}

class ShakeFlowCoordinator: NavigationNode {
    weak var containerViewController: UIViewController?
    private let dbService: DBService
    private let secureStorageService: SecureStorage
    private let apiService: ShakeAPIService

    init(parent: NavigationNode?, dbService: DBService, secureStorageService: SecureStorage, apiService: ShakeAPIService) {
        self.dbService = dbService
        self.secureStorageService = secureStorageService
        self.apiService = apiService
        super.init(parent: parent)
        addHandlers()
    }

    private func addHandlers() {
        addHandler { [weak self] (event: OrdersEventForShakeVC) in
            guard let self = self else { return }
            switch event {
            case .settings:
                self.showSettingsController()
            }
        }
    }

    private func showSettingsController() {
        let settingsCoordinator = SettingsFlowCoordinator(parent: self, dbService: dbService)
        let settingsViewController = settingsCoordinator.createFlow()
        containerViewController?.navigationController?.pushViewController(settingsViewController, animated: true)
    }
}

extension ShakeFlowCoordinator: FlowCoordinator {
    func createFlow() -> UIViewController {
        let model = ShakeModel(apiService: apiService, secureStorage: secureStorageService, dbService: dbService, parent: self)
        let viewModel = ShakeViewModel(model: model)
        let shakeViewController = ShakeViewController(viewModel: viewModel)
        containerViewController = shakeViewController
        shakeViewController.tabBarItem = UITabBarItem(
            title: L10n.blankSpace,
            image: Asset.Assets.shakeBarIcon.image,
            tag: 0
        )
        return shakeViewController
    }
}
