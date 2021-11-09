//
//  ShakeAPIInteractor.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import Foundation

class ShakeAPIInteractor: NetworkDataProvider {
    
    func getAnswerData(completion: @escaping ((_ result: Answer?) -> ())) {
        guard let urlString = "https://8ball.delegator.com/magic/JSON/<question_string>".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        if let url = URL(string: urlString) {
            let task = URLSession.shared.dataTask(with: url){ data, response, error in
                guard let data = data else {
                    print("Fetch error: \(error!.localizedDescription)")
                    completion(nil)
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let itemModel = try decoder.decode(AnswerModel.self, from: data)
                    completion(itemModel.answerItem)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
}
