//
//  SensitiveStorageRepository.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation

protocol SensitiveStorageRepository {
    func storeAccessToken(_ value: String)
    func isAccessTokenStored() -> Bool
}

final class SensitiveStorageRepositoryImplementation: SensitiveStorageRepository {
    
    private enum Constants {
        static let accessToken = "AccessToken"
    }
    
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    func storeAccessToken(_ value: String) {
        userDefaults.set(value, forKey: Constants.accessToken)
    }
    
    func isAccessTokenStored() -> Bool {
        return userDefaults.string(forKey: Constants.accessToken) != nil
    }
    
    func clearAccessToken() {
        userDefaults.removeObject(forKey: Constants.accessToken)
    }
}
