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
            shouldAnimateLoadingStateHandler?(false)
            delegate?.configureTitles(with: answer)
        }
    }

    private let shakeModel: ShakeModel
    weak var delegate: ShakeViewModelDelegate?
    var shouldAnimateLoadingStateHandler: ((Bool) -> Void)?

    func shakeDetected() {
        shakeModel.fetchAnswer(completion: { result in
            self.answer = result
        })
        shakeModel.increaseShakeCounter()
    }

    func fetchShakeCounter() -> Int {
        return shakeModel.loadSecureInformation()
    }

    // MARK: - Initialization

    init(model: ShakeModel) {
        shakeModel = model
    }
}
