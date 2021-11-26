//
//  HistoryAnswer.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 26.11.2021.
//

import Foundation

struct HistoryAnswer {
    let answer: String
    let date: Date

    init(answer: String, date: Date) {
        self.answer = answer
        self.date = date
    }
}
