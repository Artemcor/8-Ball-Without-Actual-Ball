//
//  ShakeViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 14.11.2021.
//

import Foundation
import RxSwift

class ShakeViewModel {
    private let fetchedAnswerSubject = PublishSubject<PresentableAnswer>()
    var fetchedAnswer: Observable<PresentableAnswer> {
        return fetchedAnswerSubject.asObserver()
    }
    private let fetchedSecurityCounterSubject = PublishSubject<Int>()
    var fetchedSecurityCounter: Observable<Int> {
        return fetchedSecurityCounterSubject.asObserver()
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
    private let bag = DisposeBag()

    func shakeDetected(at time: Date) {
        timeOfShake = time
        shakeModel.fetchAnswer().subscribe(onNext: { [weak self] result in
            DispatchQueue.main.asyncAfter(deadline: self?.timeInterval ?? .now()) {
                self?.fetchedAnswerSubject.onNext(result)
            }
        }).disposed(by: bag)
        shakeModel.increaseShakeCounter()
        fetchShakeCounter()
    }

    func fetchShakeCounter() {
        fetchedSecurityCounterSubject.onNext(shakeModel.loadSecureInformation())
    }

    func settingsPressed() {
        shakeModel.showSettingsController()
    }

    // MARK: - Initialization

    init(model: ShakeModel) {
        shakeModel = model
    }
}
