//
//  LoginRepository.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation

protocol LoginRepository {
    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void)
}

final class LoginRepositoryImplementation: LoginRepository {
    
    private var apiService: APIService {
        APIServiceImplementation()
    }

    func login(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let request = LoginRequest(email: email, password: password)

        self.apiService.login(requestBody: request) { result in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
