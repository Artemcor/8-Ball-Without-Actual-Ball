//
//  ShakeModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 17.10.2021.
//

import Foundation
import RxSwift

class ShakeModel {
    private var hardcodedAnswers = [Answer]()
    private let apiService: NetworkDataProvider
    private let secureStorage: SecureStorage
    private let dbService: DBService
    private let bag = DisposeBag()

    // MARK: - SecureStarage methods

    func increaseShakeCounter() {
        let counter = secureStorage.retriveInformation(with: SecureStorageKey.shakeCounter.rawValue ) + 1
        secureStorage.saveInformation(counter, with: SecureStorageKey.shakeCounter.rawValue)
    }

    func loadSecureInformation() -> Int {
        return secureStorage.retriveInformation(with: SecureStorageKey.shakeCounter.rawValue)
    }

    // MARK: - Persistence methods

    private func loadAnswers() {
        dbService.loadAnswers(isLocal: true) { result in
            let answers = result.toAnswers()
            self.hardcodedAnswers.append(contentsOf: answers)
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
            dbService.saveAnswers(answers: hardcodedAnswers.toMangedLocalAnswers())
        userDefaults.setValue(false, forKey: L10n.firstime)
        userDefaults.synchronize()
        }
    }

    // MARK: - Fetch methods

    func fetchAnswer() -> Observable<PresentableAnswer> {
        let observable = apiService.getAnswerData().catch { [weak self] _ in
            let randomAnswer = self?.hardcodedAnswers.randomElement()
            return Observable.just(randomAnswer)
        }
        return observable.map { [weak self] result -> PresentableAnswer in
            let answer = result!
            self?.saveHistoryAnswer(answer: answer)
            return answer.toPresentable()
        }
    }

    func saveHistoryAnswer(answer: Answer) {
        let managedAnswer = answer.toManagedWithActualTime(isLocal: false)
        self.dbService.saveAnswers(answers: [managedAnswer])
    }

    // MARK: - Observer methods

    private func listenForLoadNotification() {
        NotificationCenter.default.addObserver(
            forName: Notification.Name.NSManagedObjectContextDidSave,
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
