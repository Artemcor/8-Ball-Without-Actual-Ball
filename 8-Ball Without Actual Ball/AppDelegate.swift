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
    var dataModel: AnswerDataModel!

    private func saveData() {
        dataModel.saveAnswers()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let router = Wireframe().start()
        let window = UIWindow()
        window.rootViewController = UINavigationController(rootViewController: router)
        self.window = window
        window.makeKeyAndVisible()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }
}

