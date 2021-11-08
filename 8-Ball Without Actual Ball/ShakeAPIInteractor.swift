//
//  ShakeAPIInteractor.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import Foundation

class ShakeAPIInteractor: NetworkDataProvider {
    func getAnswerData() -> Answer? {
        var answerItem: Answer?
        guard let urlString = "https://8ball.delegator.com/magic/JSON/<question_string>".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return nil }
        if let url = URL(string: urlString) {
            let group = DispatchGroup()
            group.enter()
            let task = URLSession.shared.dataTask(with: url){ [self] data, response, error in
                guard let data = data else {
                    print("Fetch error: \(error!.localizedDescription)")
                    answerItem = nil
                    group.leave()
                    return
                }
                answerItem = self.parseJSON(data: data)
                group.leave()
            }
            task.resume()
            group.wait()
        }
        return answerItem
    }
    
    private func parseJSON(data: Data) -> Answer? {
        var answerItem: Answer?
        let decoder = JSONDecoder()
        do {
            let itemModel = try decoder.decode(AnswerModel.self, from: data)
            answerItem = itemModel.answerItem
        } catch {
            print("JSON error: \(error.localizedDescription)")
        }
        return answerItem
    }
}


