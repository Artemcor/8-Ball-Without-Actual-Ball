//
//  ShakeViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 14.11.2021.
//

import Foundation

class ShakeViewModel {
    private var answer: PresentableAnswer! {
        didSet {
            delegate?.answerItem = answer
            shouldAnimateLoadingStateHandler?(false)
            delegate?.configureTitles()
        }
    }
    var dataModel: ShakeAnswerModel!
    weak var delegate: ViewModelDelegate?
    var shouldAnimateLoadingStateHandler: ((Bool) -> Void)?

    func shakeDetected() {
        dataModel.fetchAnswer(completion: { result in
            self.answer = result
        })
    }

    func addHardcodedAnswer(_ presentableAnswer: PresentableAnswer) {
        let answer = toAnswer(presentableAnswer)
        dataModel.hardcodedAnswers.append(answer)
    }
}

extension ShakeViewModel {
    func toAnswer(_ presentableAnser: PresentableAnswer) -> Answer {
        return Answer(answer: presentableAnser.answer, type: presentableAnser.type)
    }
}
