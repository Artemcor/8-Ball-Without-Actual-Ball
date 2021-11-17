//
//  Answer.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 15.11.2021.
//

import Foundation

struct Answer: Codable {
    var answer = ""
    var type = ""

    init(answer: String, type: String) {
        self.answer = answer.uppercased()
        self.type = type
    }
}

extension Answer {
    func toPresentable() -> PresentableAnswer {
        return PresentableAnswer(answer: self.answer, type: self.type)
    }
}
