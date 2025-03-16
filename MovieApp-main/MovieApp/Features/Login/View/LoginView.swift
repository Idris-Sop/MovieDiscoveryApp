//
//  LoginView.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import SwiftUI

struct LoginView: View {
    
    enum FocusField: Hashable {
        case email
        case password
    }

    @State private var viewModel = LoginViewModel()
    @FocusState var focused: FocusField?
    
    var body: some View {
        switch viewModel.state {
            case .loading:
                ZStack {
                    loadedView
                        
                    ProgressView()
                        .progressViewStyle(.circular)
                        .tint(Color.yellow)
                        .scaleEffect(3)
                }.task {
                    viewModel.submitLoginCredentials()
                }
            case .error:
                ErrorView {
                    viewModel.onRetry()
                }
            case .initial:
                loadedView
        }
    }
    
    private var loadedView: some View {
        VStack(spacing: 8) {
            Text("Welcome")
                .font(.largeTitle)
                .fontWeight(.bold)
            Spacer()
            TextField("Email", text: $viewModel.email)
                .focused($focused, equals: .email)
                .onSubmit { focused = .password }
                .keyboardType(.emailAddress)
                .padding()
                .border(.secondary)
            SecureField("Password", text: $viewModel.password)
                .focused($focused, equals: .password)
                .padding()
                .border(.secondary)
            Spacer()
                        
            Button(action: {
                viewModel.onLogin()
            }) {
                Text("Login")
                    .padding(8)
                    .frame(maxWidth: .infinity)
            }
            .disabled(!viewModel.enableLoginButton)
            .buttonStyle(.borderedProminent)
         }
        .padding(16)
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle("Login")
    }
    
}
