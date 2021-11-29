//
//  HistoryViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 26.11.2021.
//

import Foundation

class HistoryViewModel {
    private let model: HistoryModel
    var historyAnswers = [PresentableAnswer]()

    func fetchAnswers() {
        historyAnswers = model.fetchAnswers().toPresentable()
}

    init(model: HistoryModel) {
        self.model = model
    }
}
