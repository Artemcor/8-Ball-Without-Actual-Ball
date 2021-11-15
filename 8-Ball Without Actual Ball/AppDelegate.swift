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

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        guard let controller = Wireframe().start() else {
            print("initialization Error")
            return false
        }
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: controller)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
}
