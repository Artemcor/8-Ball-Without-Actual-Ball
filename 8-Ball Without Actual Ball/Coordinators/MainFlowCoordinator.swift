//
//  MainFlowCoordinator.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 24.11.2021.
//

import UIKit

class MainFlowCoordinator: NavigationNode, FlowCoordinator {
    var containerViewController: UIViewController?
    private let dbService: DBService
    private let secureStorageService: SecureStorage
    private let apiService: ShakeAPIService

    init () {
        secureStorageService = SecureStorage()
        apiService = ShakeAPIService()
        dbService = DBService()
        super.init(parent: nil)
    }

    func createFlow() -> UIViewController {
        let shakeFlowCoordinator = ShakeFlowCoordinator(parent: self, dbService: dbService, secureStorageService: secureStorageService, apiService: apiService)
        let shakeViewController = shakeFlowCoordinator.createFlow()
        shakeFlowCoordinator.containerViewController = shakeViewController

        let settingsFlowCoordinator = SettingsFlowCoordinator(parent: self, dbService: dbService)
        let settingsViewController = settingsFlowCoordinator.createFlow()
        settingsFlowCoordinator.containerViewController = settingsViewController

        let historyFlowCoordinator = HistoryFlowCoordinator(parent: self, dbService: dbService)
        let historyViewController = historyFlowCoordinator.createFlow()
        historyFlowCoordinator.containerViewController = historyViewController

        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [UINavigationController(rootViewController: shakeViewController), UINavigationController(rootViewController: historyViewController)]
        tabBarViewController.tabBar.tintColor = .systemPurple
        return tabBarViewController
    }
}
