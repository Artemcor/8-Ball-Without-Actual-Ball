//
//  Protocols.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import Foundation

protocol NetworkDataProvider {
    func getAnswerData(completion: @escaping ((_ result: Answer?) -> Void))
}

protocol ShakeViewModelDelegate: AnyObject {
    func configureTitles(with answer: PresentableAnswer?)
    var isShakeAllowed: Bool { get set }
    var timeOfShake: Date { get set }
}
