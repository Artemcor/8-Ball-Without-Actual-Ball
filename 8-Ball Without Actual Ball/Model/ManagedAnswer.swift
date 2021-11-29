//
//  ManagedAnswer.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 16.10.2021.
//

import Foundation

struct ManagedAnswer: Decodable {
    let answer: String
    let type: String
    let date: Date
    let isLocal: Bool

}

extension ManagedAnswer {
    func toAnswer() -> Answer {
        return Answer(answer: self.answer, type: self.type, date: self.date)
    }
}
