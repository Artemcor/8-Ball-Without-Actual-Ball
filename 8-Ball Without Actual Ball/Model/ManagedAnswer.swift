//
//  ManagedAnswer.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import Foundation

class ManagedAnswer: Codable {
    var answer = ""
    var type = ""

    init(answer: String, type: String) {
        self.answer = answer
        self.type = type
    }

    convenience init() {
        self.init(answer: "", type: "")
    }
}

extension ManagedAnswer {
    func toAnswer() -> Answer {
        return Answer(answer: self.answer, type: self.type)
    }
}
