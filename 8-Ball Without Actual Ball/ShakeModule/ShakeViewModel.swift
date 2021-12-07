//
//  ShakeViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 14.11.2021.
//

import Foundation

class ShakeViewModel {
     private var answer: PresentableAnswer? {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: timeInterval) {
                self.configureTitlesWithRecivedAnswer?(self.answer)
            }
        }
    }
    private var timeInterval: DispatchTime {
        let time = -timeOfShake.timeIntervalSince(Date())
        if time > 3 {
            return DispatchTime.now()
        }
        return DispatchTime.now() + 3 - time
    }
    private let shakeModel: ShakeModel
    private var timeOfShake = Date()
    var configureTitlesWithRecivedAnswer: ((PresentableAnswer?) -> Void)?

    func shakeDetected(at time: Date) {
        timeOfShake = time
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
