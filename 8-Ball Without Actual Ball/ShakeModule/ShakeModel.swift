//
//  ShakeModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 17.10.2021.
//

import Foundation
import UIKit

class ShakeModel: DataProvider {
    var hardcodedAnswers = [Answer]()
    private let apiService: NetworkDataProvider
    private let secureStorage: SecureStorage

    private func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }

    func saveAnswers() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(hardcodedAnswers)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
    }

    private func loadAnswers() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                hardcodedAnswers = try decoder.decode([Answer].self, from: data)
            } catch {
                print("Error decoding list array: \(error.localizedDescription)")
            }
        }
    }

    func increaseShakeCounter() {
        let counter = secureStorage.retriveInformation(with: SecureStorageKey.shakeCouner.rawValue ) + 1
        secureStorage.saveInformation(counter, with: SecureStorageKey.shakeCouner.rawValue)
    }

    func loadSecureInformation() -> Int {
        return secureStorage.retriveInformation(with: SecureStorageKey.shakeCouner.rawValue)
    }

    private func registerDefaults() {
        let dictionary = ["FirstTime": true]
        UserDefaults.standard.register(defaults: dictionary)
    }

    private func handleFirstTime() {
        let userDefaults = UserDefaults.standard
        let firstTime = userDefaults.bool(forKey: "FirstTime")
        if firstTime {
            hardcodedAnswers = [Answer(answer: "Change your mind", type: "Neutral"),
                                Answer(answer: "Just do it!", type: "Affirmative"),
                                Answer(answer: "don't even think about it!", type: "Contrary")]
        saveAnswers()
        userDefaults.setValue(false, forKey: "FirstTime")
        userDefaults.synchronize()
        }
    }

    private func listenForSaveNotification() {
        NotificationCenter.default.addObserver(
            forName: UIApplication.willTerminateNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                self.saveAnswers()
            })
        NotificationCenter.default.addObserver(
            forName: UIApplication.didEnterBackgroundNotification,
            object: nil,
            queue: .main,
            using: { [weak self] _ in
                guard let self = self else { return }
                self.saveAnswers()
            })
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

    init(apiService: NetworkDataProvider, secureStorage: SecureStorage) {
        self.apiService = apiService
        self.secureStorage = secureStorage
        loadAnswers()
        registerDefaults()
        handleFirstTime()
        listenForSaveNotification()
        listenForLoadNotification()
    }
}
