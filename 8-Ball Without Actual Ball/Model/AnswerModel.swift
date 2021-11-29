//
//  AnswerModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import Foundation

class AnswerModel: Codable {
    var answerItem: APIAnswer

    enum CodingKeys: String, CodingKey {
        case answerItem = "magic"
    }
}

struct APIAnswer: Codable {
    var answer: String
    var type: String
}

extension AnswerModel {
    func toAnswer() -> Answer {
        return Answer(answer: self.answerItem.answer, type: self.answerItem.type)
    }
}
