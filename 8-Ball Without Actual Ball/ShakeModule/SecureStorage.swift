//
//  SecureStorage.swift
//  8-Ball Without Actual Ball
//
//  Created by Стожок Артём on 22.11.2021.
//

import Foundation
import SwiftKeychainWrapper

class SecureStorage {

    func retriveInformation() -> Int {
        let retrivedString: Int? = KeychainWrapper.standard.integer(forKey: "shakeCouner")
        guard retrivedString != nil else { return 0 }
        return retrivedString!
    }

    func saveInformation(_ information: Int) {
        KeychainWrapper.standard.set(information, forKey: "shakeCouner")
    }
}
