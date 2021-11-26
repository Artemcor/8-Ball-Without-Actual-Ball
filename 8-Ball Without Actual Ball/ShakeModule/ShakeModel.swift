//
//  ShakeModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 17.10.2021.
//

import Foundation

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
        let dbAnswers = dbService.loadLocalsAnswers()
        for dbAnswer in dbAnswers {
            let answer = Answer(answer: dbAnswer.answer, type: dbAnswer.type)
            hardcodedAnswers.append(answer)
        }
    }

    private func registerDefaults() {
        let dictionary = [L10n.firstime: true]
        UserDefaults.standard.register(defaults: dictionary)
    }

    private func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: L10n.firstime)
        if firstTime {
            hardcodedAnswers = [
                Answer(answer: L10n.changeYourMind, type: L10n.neutral),
                Answer(answer: L10n.justDoIt, type: L10n.affirmative),
                Answer(answer: L10n.dontEvenThinkAboutIt, type: L10n.contrary)
            ]
            dbService.saveLocalAnswers(answers: hardcodedAnswers)
        userDefaults.setValue(false, forKey: L10n.firstime)
        userDefaults.synchronize()
        }
    }

    // MARK: - Fetch methods

    func fetchAnswer(completion: @escaping (_ result: PresentableAnswer) -> Void) {
        apiService.getAnswerData { [weak self] result in
            guard let self = self else { return }
            guard let result = result else {
                let answer = self.hardcodedAnswers.randomElement()
                let presentableAnswer = answer!.toPresentable()
                self.saveHistoryAnswer(answer: answer!)
                completion(presentableAnswer)
                return
            }
            self.saveHistoryAnswer(answer: result)
            let presentableAnswer = result.toPresentable()
            completion(presentableAnswer)
        }
    }

    func saveHistoryAnswer(answer: Answer) {
        dbService.saveHistoryAnswers(answers: [answer])
    }

    // MARK: - Observer methods

    private func listenForLoadNotification() {
        NotificationCenter.default.addObserver(
            forName: Notification.Name( rawValue: L10n.loadAnswers),
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                self.loadAnswers()
            })
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
