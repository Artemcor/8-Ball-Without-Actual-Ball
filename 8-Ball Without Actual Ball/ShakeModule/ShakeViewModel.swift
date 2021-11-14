//
//  ShakeViewModel.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 14.11.2021.
//

import Foundation

class ShakeViewModel {
    var dataModel: ShakeAnswerModel!

    func getAnswerData(completion: @escaping (_ result: Answer?) -> Void) {
        dataModel.fetchAnswer() { result in
            completion(result)
        }
    }
}
