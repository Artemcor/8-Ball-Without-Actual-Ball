//
//  HistoryFlowCoordinator.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 20.12.2021.
//

import UIKit

class HistoryFlowCoordinator: NavigationNode, FlowCoordinator {
    var containerViewController: UIViewController?
    private let dbService: DBService

    init(parent: NavigationNode, dbService: DBService) {
        self.dbService = dbService
        super.init(parent: parent)
    }

    func createFlow() -> UIViewController {
        let historyModel = HistoryModel(dbService: dbService)
        let historyViewModel = HistoryViewModel(model: historyModel)
        let historyViewController = HistoryViewController(viewModel: historyViewModel)
        historyViewController.tabBarItem = UITabBarItem(
            title: L10n.blankSpace,
            image: Asset.Assets.historyBarIcon.image,
            tag: 0
        )
        return historyViewController
    }
}
