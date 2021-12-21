//
//  Protocols.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import Foundation
import RxSwift

protocol NetworkDataProvider {
    func getAnswerData() -> Observable<Answer?>
}

protocol FlowCoordinator: AnyObject {
    // this variable must only be of 'weak' type
    var containerViewController: UIViewController? { get set }

    @discardableResult
    func createFlow() -> UIViewController
}

protocol SettingsRoutable {
    func dissmissSettingsController()
}

protocol ShakeRoutable {
    func showSettingsController()
}
