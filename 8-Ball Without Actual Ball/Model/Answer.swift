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
}

extension Answer {
    func toPresentable() -> PresentableAnswer {
        return PresentableAnswer(answer: self.answer, type: self.type)
    }
}
