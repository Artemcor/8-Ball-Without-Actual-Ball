//
//  ShakeModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 17.10.2021.
//

import Foundation
import UIKit

class ShakeModel {
    var hardcodedAnswers = [Answer]()
    private let apiService: NetworkDataProvider
    private let secureStorage: SecureStorage
    private let dbService: DBService

    // MARK: - SecureStarage methods

    func increaseShakeCounter() {
        let counter = secureStorage.retriveInformation(with: SecureStorageKey.shakeCouner.rawValue ) + 1
        secureStorage.saveInformation(counter, with: SecureStorageKey.shakeCouner.rawValue)
    }

    func loadSecureInformation() -> Int {
        return secureStorage.retriveInformation(with: SecureStorageKey.shakeCouner.rawValue)
    }

    // MARK: - Persistence methods

    private func loadAnswers() {
        let dbAnswers = dbService.loadAnswers()
        for dbAnswer in dbAnswers {
            let answer = Answer(answer: dbAnswer.answer, type: dbAnswer.type)
            hardcodedAnswers.append(answer)
        }
    }

    private func registerDefaults() {
        let dictionary = ["FirstTime": true]
        UserDefaults.standard.register(defaults: dictionary)
    }

    private func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        if firstTime {
            hardcodedAnswers = [
                Answer(answer: "Change your mind", type: "Neutral"),
                Answer(answer: "Just do it!", type: "Affirmative"),
                Answer(answer: "don't even think about it!", type: "Contrary")
            ]
            dbService.save(answers: hardcodedAnswers)
        userDefaults.setValue(false, forKey: "FirstTime")
        userDefaults.synchronize()
        }
    }

    private func listenForLoadNotification() {
        NotificationCenter.default.addObserver(
            forName: Notification.Name( rawValue: "load answers"),
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                self.loadAnswers()
            })
    }

    // MARK: - Fetch methods

    func fetchAnswer(completion: @escaping (_ result: PresentableAnswer) -> Void) {
        apiService.getAnswerData { [weak self] result in
            guard let self = self else { return }
            guard let result = result else {
                let answer = self.hardcodedAnswers.randomElement()
                let presentableAnswer = answer!.toPresentable()
                completion(presentableAnswer)
                return
            }
            let presentableAnswer = result.toPresentable()
            completion(presentableAnswer)
        }
    }

    // MARK: - Initialization

    init(apiService: NetworkDataProvider, secureStorage: SecureStorage, dbService: DBService) {
        self.apiService = apiService
        self.secureStorage = secureStorage
        self.dbService = dbService
        loadAnswers()
        registerDefaults()
        handleFirstTime()
        listenForLoadNotification()
    }
}
