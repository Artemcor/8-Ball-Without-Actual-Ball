//
//  PresentableAnswer.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 15.11.2021.
//

import Foundation

struct PresentableAnswer: Codable {
    var answer = ""
    var type = ""
}

extension PresentableAnswer {
    func toAnswer() -> Answer {
        return Answer(answer: self.answer, type: self.type)
    }
}