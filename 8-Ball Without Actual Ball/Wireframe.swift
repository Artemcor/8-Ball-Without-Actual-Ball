//
//  Wireframe.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import UIKit

class Wireframe {
    func start() -> ShakeViewController? {
        let apiInteractor = ShakeAPIInteractor()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(
            withIdentifier: StoryboardScene.Main.shakeViewController.identifier) as? ShakeViewController else {
                print("Instantiation Viewcontroller Errror")
                return nil
            }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Fetching AppDelegate Error")
            return nil
        }
        let dataModel = AnswerDataModel()
        controller.apiInteractor = apiInteractor
        appDelegate.dataModel = dataModel
        controller.dataModel = dataModel
        return controller
    }
}
