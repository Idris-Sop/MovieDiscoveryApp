//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

protocol MovieRepository {
    func getMovies(completion: @escaping (Result<MovieListResponse, Error>) -> Void)
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void)
}

final class MovieRepositoryImplementation: MovieRepository {
    
    private let apiService: APIService
    
    init(apiService: APIService = DependencyContainer.apiService) {
        self.apiService = apiService
    }
    
    func getMovies(completion: @escaping (Result<MovieListResponse, Error>) -> Void) {
        self.apiService.fetchPopularMovies(requestBody: nil) { result in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    func getMovieDetail(for movieId: Int, completion: @escaping (Result<MovieDetailResponse, Error>) -> Void) {
        self.apiService.fetchMovieDetails(movieId: movieId, requestBody: nil) { result in
            switch result {
                case .success(let response):
                    completion(.success(response))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
