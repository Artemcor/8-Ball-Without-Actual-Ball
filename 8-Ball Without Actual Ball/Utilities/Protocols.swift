//
//  Protocols.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 08.11.2021.
//

import Foundation
import RxSwift

protocol NetworkDataProvider {
    func getAnswerData() -> Observable<Answer?>
}
