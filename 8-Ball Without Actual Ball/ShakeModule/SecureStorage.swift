//
//  SecureStorage.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 22.11.2021.
//

import Foundation
import SwiftKeychainWrapper

class SecureStorage {
    private let keychainWrapper: KeychainWrapper

    func retriveInformation(with key: String) -> Int {
        let retrivedString: Int? = keychainWrapper.integer(forKey: key)
        guard let retrivedString = retrivedString else { return 0 }
        return retrivedString
    }

    func saveInformation(_ information: Int, with key: String) {
        keychainWrapper.set(information, forKey: key)
    }

    init(keychainWrapper: KeychainWrapper = KeychainWrapper.standard) {
        self.keychainWrapper = keychainWrapper
    }
}

enum SecureStorageKey: String {
    case shakeCouner
}
