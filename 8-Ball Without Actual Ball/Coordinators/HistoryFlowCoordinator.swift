//
//  HistoryFlowCoordinator.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 20.12.2021.
//

import UIKit

class HistoryFlowCoordinator: NavigationNode {
    weak var containerViewController: UIViewController?
    private let dbService: DBService

    init(parent: NavigationNode, dbService: DBService) {
        self.dbService = dbService
        super.init(parent: parent)
    }
}

extension HistoryFlowCoordinator: FlowCoordinator {
    func createFlow() -> UIViewController {
        let historyModel = HistoryModel(dbService: dbService, parent: self)
        let historyViewModel = HistoryViewModel(model: historyModel)
        let historyViewController = HistoryViewController(viewModel: historyViewModel)
        containerViewController = historyViewController
        historyViewController.tabBarItem = UITabBarItem(
            title: L10n.blankSpace,
            image: Asset.Assets.historyBarIcon.image,
            tag: 0
        )
        return historyViewController
    }
}
