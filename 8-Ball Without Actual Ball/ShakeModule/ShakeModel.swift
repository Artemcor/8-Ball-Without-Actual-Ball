//
//  ShakeModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 17.10.2021.
//

import Foundation
import RxSwift

class ShakeModel {
    var hardcodedAnswers = [Answer]()
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
        return Observable.create { (observer) in
            self.apiService.getAnswerData()
                .observe(on: MainScheduler.instance)
                .catch({ _ in
                       let answer = self.hardcodedAnswers.randomElement()
                    return Observable.just(answer)
                }).subscribe(onNext: { [weak self] answer in
                    guard let answer = answer else { return }
                    self?.saveHistoryAnswer(answer: answer)
                    let presentableAnswer = answer.toPresentable()
                    observer.on(.next(presentableAnswer))
                }).disposed(by: self.bag)
            return Disposables.create()
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
