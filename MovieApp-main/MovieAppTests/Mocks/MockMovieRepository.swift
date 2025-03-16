//
//  MockMovieRepository.swift
//  MovieAppTests
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation
import Testing
@testable import MovieApp

final class MockMovieRepository: MovieRepository {
    
    var mockMovieListResult: Result<MovieListResponse, Error>?
    var mockMovieDetailsResult: Result<MovieDetailResponse, Error>?
    
    func getMovies(completion: @escaping (Result<MovieListResponse, any Error>) -> Void) {
        if let result = self.mockMovieListResult {
            completion(result)
        }
    }
    
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<MovieDetailResponse, any Error>) -> Void) {
        if let result = self.mockMovieDetailsResult {
            completion(result)
        }
    }
}
