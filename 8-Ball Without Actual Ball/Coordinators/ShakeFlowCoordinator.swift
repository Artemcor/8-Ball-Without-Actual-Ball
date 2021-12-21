//
//  ShakeCoordinator.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 20.12.2021.
//

import UIKit

class ShakeFlowCoordinator: NavigationNode, FlowCoordinator, ShakeRoutable {
    var containerViewController: UIViewController?
    private let dbService: DBService
    private let secureStorageService: SecureStorage
    private let apiService: ShakeAPIService

    init(parent: NavigationNode, dbService: DBService, secureStorageService: SecureStorage, apiService: ShakeAPIService) {
        self.dbService = dbService
        self.secureStorageService = secureStorageService
        self.apiService = apiService
        super.init(parent: parent)
    }

    func createFlow() -> UIViewController {
        let model = ShakeModel(apiService: apiService, secureStorage: secureStorageService, dbService: dbService)
        let viewModel = ShakeViewModel(model: model, coordinator: self)
        let shakeViewController = ShakeViewController(viewModel: viewModel)
        shakeViewController.tabBarItem = UITabBarItem(
            title: L10n.blankSpace,
            image: Asset.Assets.shakeBarIcon.image,
            tag: 0
        )
        return shakeViewController
    }

    func showSettingsController() {
        let settingsCoordinator = SettingsFlowCoordinator(parent: self, dbService: dbService)
        let settingsViewController = settingsCoordinator.createFlow()
        settingsCoordinator.containerViewController = settingsViewController
        containerViewController?.navigationController!.pushViewController(settingsViewController, animated: true)
    }
}
