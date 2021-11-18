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

protocol DataProvider {
    var hardcodedAnswers: [Answer] { get set }
    func saveAnswers()
}

protocol ViewModelDelegate: AnyObject {
    var answerItem: PresentableAnswer? { get set }
    func configureTitles()
}
