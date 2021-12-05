//
//  ShakeViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 14.11.2021.
//

import Foundation

class ShakeViewModel {
     var answer: PresentableAnswer? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: timeInterval) {
                self.delegate?.configureTitles(with: self.answer)
                self.delegate?.isShakeAllowed = true
            }
        }
    }
    private var timeInterval: DispatchTime {
        let time = -delegate!.timeOfShake.timeIntervalSince(Date())
        if time > 3 {
            return DispatchTime.now()
        }
        return DispatchTime.now() + 3 - time
    }
    private let shakeModel: ShakeModel
    weak var delegate: ShakeViewModelDelegate?

    func shakeDetected() {
        delegate?.isShakeAllowed = false
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
