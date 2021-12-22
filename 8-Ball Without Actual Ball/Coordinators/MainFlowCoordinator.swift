//
//  MainFlowCoordinator.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 24.11.2021.
//

import UIKit

class MainFlowCoordinator: NavigationNode {
    weak var containerViewController: UIViewController?
    private let dbService: DBService
    private let secureStorageService: SecureStorage
    private let apiService: ShakeAPIService
    private let window: UIWindow

    init (window: UIWindow) {
        secureStorageService = SecureStorage()
        apiService = ShakeAPIService()
        dbService = DBService()
        self.window = window
        super.init(parent: nil)
    }

    func createFlow() {
        let shakeFlowCoordinator = ShakeFlowCoordinator(parent: self, dbService: dbService, secureStorageService: secureStorageService, apiService: apiService)
        let shakeViewController = shakeFlowCoordinator.createFlow()

        let historyFlowCoordinator = HistoryFlowCoordinator(parent: self, dbService: dbService)
        let historyViewController = historyFlowCoordinator.createFlow()

        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [UINavigationController(rootViewController: shakeViewController), UINavigationController(rootViewController: historyViewController)]
        tabBarViewController.tabBar.tintColor = .systemPurple
        window.rootViewController = tabBarViewController
        window.backgroundColor = .systemBackground
        window.makeKeyAndVisible()
    }
}
