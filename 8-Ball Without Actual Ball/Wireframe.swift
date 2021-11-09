//
//  Wireframe.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import UIKit

class Wireframe {
    func start() -> ShakeViewController {
        let apiInteractor = ShakeAPIInteractor()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ShakeViewController") as! ShakeViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let dataModel = AnswerDataModel()
        controller.apiInteractor = apiInteractor
        appDelegate.dataModel = dataModel
        controller.dataModel = dataModel
        return controller
    }
}
