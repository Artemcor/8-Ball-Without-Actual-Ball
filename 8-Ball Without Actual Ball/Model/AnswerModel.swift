//
//  AnswerModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import Foundation

class AnswerModel: Codable {
    var answerItem: Answer

    enum CodingKeys: String, CodingKey {
        case answerItem = "magic"
    }
}
