//
//  APIServiceTests.swift
//  MovieAppTests
//
//  Created by Idris Jovial SOP NWABO.
//

import XCTest
@testable import MovieApp

final class APIServiceTests: XCTestCase {

    var sut: APIService!
    var mockServiceskManager: MockWebServicesManager!
    
    override func setUpWithError() throws {
        super.setUp()
        mockServiceskManager = MockWebServicesManager(service: .movieList)
        sut = APIServiceImplementation(networkManager: mockServiceskManager)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockServiceskManager = nil
        super.tearDown()
    }
    
    func testLoginWithSuccess() {
        mockServiceskManager = MockWebServicesManager(service: .login)
        let expectation = XCTestExpectation(description: "Wait for data to load")
    
        
        mockServiceskManager.mockLoginResult = .success(LoginResponse(token: "ABCD"))
        
        sut.login(requestBody: LoginRequest(email: "test@test.com", password: "12345")) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.token, "ABCD")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }
    }
    
    func testLoginWithFailure() {
        mockServiceskManager = MockWebServicesManager(service: .login)
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let error = NSError(domain: "NetworkError", code: 500, userInfo: nil)
        mockServiceskManager.mockMovieListResult = .failure(error)
        
        sut.login(requestBody: LoginRequest(email: "test@test.com", password: "12345")) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 500)
                expectation.fulfill()
            }
        }
    }
    
    func testFetchPopularMoviesWithSuccess() {
        mockServiceskManager = MockWebServicesManager(service: .movieList)
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let mockMovies =  [Movie(id: 1, title: "Mock Movie", overview: "Description", releaseDate: "2025-01-01", posterUrl: "/test.jpg", rating: 7.5)]
        
        mockServiceskManager.mockMovieListResult = .success(MovieListResponse(results: mockMovies))
        
        sut.fetchPopularMovies(requestBody: nil) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.results.count, 1)
                XCTAssertEqual(response.results.first?.title, "Mock Movie")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }
    }
    
    func testFetchPopularMoviesWithFailure() {
        mockServiceskManager = MockWebServicesManager(service: .movieList)
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let error = NSError(domain: "NetworkError", code: 500, userInfo: nil)
        mockServiceskManager.mockMovieListResult = .failure(error)
        
        sut.fetchPopularMovies(requestBody: nil) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 500)
                expectation.fulfill()
            }
        }
    }
    
    func testFetchMovieDetailsWithSuccess() {
        mockServiceskManager = MockWebServicesManager(service: .movieDetails)
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let mockMovie =  MovieDetailResponse(title: "Mock Movie", releaseDate: "2025-01-01", rating: 7.5, posterUrl: "/test.jpg", overview: "Description")
        
        mockServiceskManager.mockMovieDetailsResult = .success(mockMovie)
        
        sut.fetchMovieDetails(movieId: 1, requestBody: nil) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.title, "Mock Movie")
                XCTAssertEqual(response.rating, 7.5)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }
    }
    
    func testFetchMovieDetailsWithFailure() {
        mockServiceskManager = MockWebServicesManager(service: .movieDetails)
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let error = NSError(domain: "NetworkError", code: 500, userInfo: nil)
        mockServiceskManager.mockMovieListResult = .failure(error)
        
        sut.fetchMovieDetails(movieId: 1, requestBody: nil) { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 500)
                expectation.fulfill()
            }
        }
    }
}

class MockWebServicesManager: WebServicesManager {
    enum Service {
        case login
        case movieList
        case movieDetails
    }
    var mockLoginResult: Result<LoginResponse, Error>?
    var mockMovieListResult: Result<MovieListResponse, Error>?
    var mockMovieDetailsResult: Result<MovieDetailResponse, Error>?
    var service: Service = .movieList
    
    init(service: Service) {
        self.service = service
    }
    
    func performAPIRequest<T>(request: URLRequest, completion: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        switch self.service {
        case .login:
            if let result = self.mockLoginResult as? Result<T, Error> {
                completion(result)
            }
        case .movieList:
            if let result = self.mockMovieListResult as? Result<T, Error> {
                completion(result)
            }
        case .movieDetails:
            if let result = self.mockMovieDetailsResult as? Result<T, Error> {
                completion(result)
            }
        }
    }
}
