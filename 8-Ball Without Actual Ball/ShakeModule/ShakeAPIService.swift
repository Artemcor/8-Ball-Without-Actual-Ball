//
//  ShakeAPIInteractor.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import Foundation

class ShakeAPIService: NetworkDataProvider {

    func getAnswerData(completion: @escaping ((_ result: Answer?) -> Void)) {
        guard let urlString = L10n.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data else {
                    print("Fetch error: \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let itemModel = try decoder.decode(AnswerModel.self, from: data)
                    let answer = self?.toAnswer(itemModel.answerItem)
                    completion(answer)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
}

extension ShakeAPIService {
    func toAnswer(_ managedAnswer: ManagedAnswer) -> Answer {
        return Answer(answer: managedAnswer.answer, type: managedAnswer.type)
    }
}
