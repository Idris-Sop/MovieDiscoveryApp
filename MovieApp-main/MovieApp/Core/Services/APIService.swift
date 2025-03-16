//
//  APIService.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation

enum RestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
}

protocol APIService {
    func login(requestBody: Encodable?, completion: @escaping (Result<LoginResponse, Error>) -> Void)
    func fetchPopularMovies(requestBody: Encodable?, completion: @escaping (Result<MovieListResponse, Error>) -> Void)
    func fetchMovieDetails(movieId: Int, requestBody: Encodable?, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
}

class APIServiceImplementation: APIService {
    
    private let networkManager: WebServicesManager

    init(networkManager: WebServicesManager = DependencyContainer.webServicesManager) {
        self.networkManager = networkManager
    }
    
    func login(requestBody: Encodable?, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let path = "https://reqres.in/api/login"
        let headers: [String: String] = [:]
        guard let baseURL = URL(string: path) else {
            fatalError("Invalid Base URL: \(path)")
        }
        let fullURL = baseURL.appendingPathComponent(path)
        
        self.networkManager.performAPIRequest(request: self.createURLRequest(with: fullURL, method: .post, headers: headers, requestBody: requestBody)) { result in
            completion(result)
        }
    }
    
    func fetchPopularMovies(requestBody: Encodable?, completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        let path = "/movie/popular?api_key=\(APIConstants.apiKey)"
        let headers: [String: String] = [:]
        let baseURL = APIConstants.baseURL as String

        guard let urlString = baseURL.appending(path).urlEncoded else {
            fatalError("Invalid Base URL: \(baseURL)")
        }
        
        guard let fullURL = URL(string: urlString) else {
            fatalError("Invalid Base URL: \(baseURL)")
        }
        
        self.networkManager.performAPIRequest(request: self.createURLRequest(with: fullURL, method: .get, headers: headers, requestBody: requestBody)) { result in
            completion(result)
        }
    }
    
    func fetchMovieDetails(movieId: Int, requestBody: Encodable?, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void) {
        let path =  "/movie/\(movieId)?api_key=\(APIConstants.apiKey)"
        let headers: [String: String] = [:]
        let baseURL = APIConstants.baseURL as String
        
        guard let urlString = baseURL.appending(path).urlEncoded else {
            fatalError("Invalid Base URL: \(baseURL)")
        }
        
        guard let fullURL = URL(string: urlString) else {
            fatalError("Invalid Base URL: \(baseURL)")
        }
        
        self.networkManager.performAPIRequest(request: self.createURLRequest(with: fullURL, method: .get, headers: headers, requestBody: requestBody)) { result in
            completion(result)
        }
    }
}

extension APIServiceImplementation {
    private func createURLRequest(with completedURL: URL, method: RestMethod = .get, headers: [String: String] = [:], requestBody: Encodable? = nil) -> URLRequest {
        
        var urlRequest = URLRequest(url: completedURL)
        urlRequest.httpMethod = method.rawValue
        
        if let body = requestBody {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(body)
            } catch {
                fatalError("Failed to encode request")
            }
        }

        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }

        return urlRequest
    }
}
