//
//  AnswerModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import Foundation

class AnswerModel: Codable {
    let answerItem: APIAnswer

    enum CodingKeys: String, CodingKey {
        case answerItem = "magic"
    }
}

struct APIAnswer: Codable {
    let answer: String
    let type: String
}

extension AnswerModel {
    func toAnswer() -> Answer {
        return Answer(answer: self.answerItem.answer, type: self.answerItem.type)
    }
}
