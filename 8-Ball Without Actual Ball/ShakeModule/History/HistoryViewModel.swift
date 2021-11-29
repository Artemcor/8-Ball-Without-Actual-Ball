//
//  HistoryViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 26.11.2021.
//

import Foundation

class HistoryViewModel {
    private let model: HistoryModel
    weak var delegate: HistoryViewModelDelegate?
    var historyAnswers = [PresentableAnswer]() {
        didSet {
            delegate?.answersRecieved()
        }
    }

    func fetchAnswers() {
        model.fetchAnswers(completion: { result in
            let presentableAnswers = result.toPresentable()
            self.historyAnswers = presentableAnswers
        })
    }

    init(model: HistoryModel) {
        self.model = model
    }
}
