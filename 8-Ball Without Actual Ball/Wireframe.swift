//
//  Wireframe.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import UIKit

class Wireframe {
    func buildShakeViewController() -> ShakeViewController? {
        let apiService = ShakeAPIService()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let controller = storyboard.instantiateViewController(
            withIdentifier: StoryboardScene.Main.shakeViewController.identifier) as? ShakeViewController else {
                print("Instantiation Viewcontroller Errror")
                return nil
            }
        let dataModel = ShakeModel()
        let viewModel = ShakeViewModel()

        dataModel.apiService = apiService
        controller.shakeViewModel = viewModel
        viewModel.dataModel = dataModel
        viewModel.delegate = controller
        return controller
    }
}
