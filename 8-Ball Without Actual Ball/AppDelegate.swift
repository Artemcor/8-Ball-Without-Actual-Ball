//
//  AppDelegate.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: MainFlowCoordinator?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let window = UIWindow()
        coordinator = MainFlowCoordinator()
        window.rootViewController = coordinator?.createFlow()
        self.window = window
        window.backgroundColor = .systemBackground
        window.makeKeyAndVisible()
        return true
    }
}
