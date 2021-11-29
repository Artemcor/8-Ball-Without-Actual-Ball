//
//  PresentableAnswer.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 15.11.2021.
//

import Foundation

struct PresentableAnswer: Codable {
    var answer: String
    var type: String
    let date: Date

    init(answer: String, type: String, date: Date = Date()) {
        self.answer = answer
        self.type = type
        self.date = date
    }

    init() {
        self.init(answer: "", type: "")
    }
}

extension PresentableAnswer {
    func toAnswer() -> Answer {
        return Answer(answer: self.answer, type: self.type, date: self.date)
    }
}
