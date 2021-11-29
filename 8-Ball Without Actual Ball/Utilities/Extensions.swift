//
//  Extensions.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 28.11.2021.
//

import Foundation

extension Array where Element == Answer {
    func toMangedLocalAnswers() -> [ManagedAnswer] {
        return self.map { $0.toManaged(isLocal: true) }
    }

    func toPresentable() -> [PresentableAnswer] {
        return self.map { $0.toPresentable() }
    }
}

extension Array where Element == DBManagedAnswer {
    func toMangedAnswers() -> [ManagedAnswer] {
        return self.map { $0.toMangedAnswer() }
    }
}

extension Array where Element == ManagedAnswer {
    func toAnswers() -> [Answer] {
        return self.map { $0.toAnswer() }
    }
}


