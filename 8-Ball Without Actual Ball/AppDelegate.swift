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
    private let dataModel = AnswerDataModel()

    private func saveData() {
        dataModel.saveAnswers()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = window?.rootViewController as! UINavigationController
        let controller = navigationController.viewControllers[0] as! ShakeViewController
        controller.dataModel = dataModel
        controller.apiInteractor = ShakeAPIInteractor()
        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }
}

