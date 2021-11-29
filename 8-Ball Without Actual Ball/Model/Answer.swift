//
//  Answer.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 15.11.2021.
//

import Foundation

struct Answer: Codable {
    let answer: String
    let type: String
    let date: Date

    init(answer: String, type: String, date: Date = Date()) {
        self.answer = answer.uppercased()
        self.type = type
        self.date = date
    }
}

extension Answer {
    func toPresentable() -> PresentableAnswer {
        return PresentableAnswer(answer: self.answer, type: self.type, date: self.date)
    }
}

extension Answer {
    func toManaged(isLocal: Bool) -> ManagedAnswer {
        return ManagedAnswer(answer: self.answer, type: self.type, date: self.date, isLocal: isLocal)
    }

    func toManagedWithActualTime(isLocal: Bool) -> ManagedAnswer {
        return ManagedAnswer(answer: self.answer, type: self.type, date: Date(), isLocal: isLocal)
    }
}
