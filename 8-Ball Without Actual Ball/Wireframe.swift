//
//  Wireframe.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 24.11.2021.
//

import UIKit

class Wireframe {
    private let dbService = DBService()

    func buildTabBarViewController() -> UITabBarController {
        let tabBarViewController = UITabBarController()
        tabBarViewController.viewControllers = [buildShakeViewController(), buildHistoryViewController()]
        tabBarViewController.tabBar.tintColor = .systemPurple
        return tabBarViewController
    }

    private func buildShakeViewController() -> UINavigationController {
        let secureStorageService = SecureStorage()
        let apiService = ShakeAPIService()
        let model = ShakeModel(apiService: apiService, secureStorage: secureStorageService, dbService: dbService)
        let viewModel = ShakeViewModel(model: model)
        let shakeViewController = ShakeViewController(viewModel: viewModel)

        viewModel.delegate = shakeViewController
        shakeViewController.tabBarItem = UITabBarItem(
            title: L10n.blankSpace,
            image: Asset.Assets.shakeBarIcon.image,
            tag: 0
        )
        return UINavigationController(rootViewController: shakeViewController)
    }

    private func buildHistoryViewController() -> UINavigationController {
        let historyModel = HistoryModel(dbService: dbService)
        let historyViewModel = HistoryViewModel(model: historyModel)
        let historyViewController = HistoryViewController(viewModel: historyViewModel)
        historyViewController.tabBarItem = UITabBarItem(
            title: L10n.blankSpace,
            image: Asset.Assets.historyBarIcon.image,
            tag: 0
        )

        historyViewModel.delegate = historyViewController
        return UINavigationController(rootViewController: historyViewController)
    }

    func buildSettingsViewController() -> SettingsViewController {
        let model = SettingsModel(dbService: dbService)
        let viewModel = SettingsViewModel(model: model)
        let settingsViewController = SettingsViewController(viewModel: viewModel)
        return settingsViewController
    }
}
