//
//  LoginViewModel.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation
import Observation

@MainActor
@Observable
final class LoginViewModel {
    
    enum State {
        case initial
        case loading
        case error
    }
    
    var state = State.initial
    var email: String = ""
    var password: String = ""

    private let loginRepository: LoginRepository
    private let sensitiveStorageRepository: SensitiveStorageRepository
    private let loginCoordinator: LoginCoordinator

    init() {
        self.loginRepository = LoginRepositoryImplementation()
        self.loginCoordinator = LoginCoordinatorImplementation()
        self.sensitiveStorageRepository = SensitiveStorageRepositoryImplementation()
    }
    
    var enableLoginButton: Bool {
        isEmailValid() && isPasswordValid() && state != .loading
    }
    
    func submitLoginCredentials() {
        state = .loading
        let emailValue = email.trimmingCharacters(in: .whitespaces)
        let passwordValue = password.trimmingCharacters(in: .whitespaces)
        self.loginRepository.login(email: emailValue, password: passwordValue) { result in
            switch result {
                case .success(let response):
                    self.state = .initial
                    self.storeAccessToken(accessToken: response.token ?? "")
                    self.loginCoordinator.onSuccessfullyLoggedIn()
                case .failure(let error):
                    self.state = .error
            }
        }
    }
    
    func storeAccessToken(accessToken: String){
        sensitiveStorageRepository.storeAccessToken(accessToken)
    }
    
    func onLogin() {
        state = .loading
    }
    
    func onRetry() {
        state = .loading
    }
    
    private func isEmailValid() -> Bool {
        let emailRegex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isPasswordValid() -> Bool {
        let passwordValue = password.trimmingCharacters(in: .whitespaces)
        return passwordValue.count >= 4
    }
}
