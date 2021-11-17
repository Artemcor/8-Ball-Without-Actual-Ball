//
//  SettingsModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.11.2021.
//

import Foundation

class SettingsModel {
    private var hardcodedAnswers = [Answer]()

    private func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func dataFilePath() -> URL {
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }

    func saveAnswers(_ answer: Answer) {
        loadAnswers()
        hardcodedAnswers.append(answer)
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(hardcodedAnswers)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding list array: \(error.localizedDescription)")
        }
        NotificationCenter.default.post(name: Notification.Name( rawValue: "load answers"), object: nil)
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
}
