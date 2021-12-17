//
//  ShakeAPIInteractor.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import Foundation
import RxSwift
import RxCocoa

class ShakeAPIService: NetworkDataProvider {
    private enum Error: Swift.Error {
           case invalidResponse(URLResponse?)
           case invalidJSON(Swift.Error)
       }

    func getAnswerData() -> Observable<Answer?> {
        let urlString = L10n.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw Error.invalidResponse(result.response)
                }
                return result.data
            }.map { data in
                do {
                    let itemModel = try JSONDecoder().decode(AnswerModel.self, from: data)
                    let answer = itemModel.toAnswer()
                    return answer
                } catch let error {
                    throw Error.invalidJSON(error)
                }
            }
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
}
