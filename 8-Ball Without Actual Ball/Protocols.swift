//
//  Protocols.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import Foundation

protocol NetworkDataProvider {
    func getAnswerData(completion: @escaping ((_ result: Answer?) -> ()))
}

protocol DataProvider {
    var hardcodedAnswers: [Answer] { get set }
    func saveAnswers()
}

protocol SettingViewControllerDelegate: AnyObject {
    func settingViewControllerDidCancel(_controller: SettingViewController)
    func settingViewController(_ controller: SettingViewController, didFinishAdding: Answer)
}


