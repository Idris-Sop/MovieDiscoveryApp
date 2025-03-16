//
//  MockAPIService.swift
//  MovieAppTests
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation
import Testing
@testable import MovieApp

class MockAPIService: APIService {
    
    var mockLoginResult: Result<LoginResponse, Error>?
    var mockMovieListResult: Result<MovieListResponse, Error>?
    var mockMovieDetailsResult: Result<MovieDetailResponse, Error>?
    
    func login(requestBody: (any Encodable)?, completion: @escaping (Result<LoginResponse, any Error>) -> Void) {
        if let result = self.mockLoginResult {
            completion(result)
        }
    }
    
    func fetchPopularMovies(requestBody: (any Encodable)?, completion: @escaping (Result<MovieListResponse, any Error>) -> Void) {
        if let result = self.mockMovieListResult{
            completion(result)
        }
    }
    
    func fetchMovieDetails(movieId: Int, requestBody: (any Encodable)?, completion: @escaping (Result<MovieDetailResponse, any Error>) -> Void) {
        if let result = self.mockMovieDetailsResult  {
            completion(result)
        }
    }
}
