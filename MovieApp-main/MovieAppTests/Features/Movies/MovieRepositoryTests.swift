//
//  MovieRepositoryTests.swift
//  MovieAppTests
//
//  Created by Idris Jovial SOP NWABO.
//

import XCTest
@testable import MovieApp

final class MovieRepositoryTests: XCTestCase {
    
    private var sut: MovieRepository! = nil
    var mockAPIService: MockAPIService!

    override func setUpWithError() throws {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = MovieRepositoryImplementation(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func testGetMoviesWithSuccess() {
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let mockMovies =  [Movie(id: 1, title: "Mock Movie", overview: "Description", releaseDate: "2025-01-01", posterUrl: "/test.jpg", rating: 7.5)]
        
        mockAPIService.mockMovieListResult = .success(MovieListResponse(results: mockMovies))
        
        sut.getMovies { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.results.count, 1)
                XCTAssertEqual(response.results.first?.title, "Mock Movie")
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetMoviesWithFailure() {
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let error = NSError(domain: "NetworkError", code: 500, userInfo: nil)
        mockAPIService.mockMovieListResult = .failure(error)
        
        sut.getMovies { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but got success")
            case .failure(let error):
                XCTAssertEqual((error as NSError).code, 500)
                expectation.fulfill()
            }
        }
    }
    
    func testGetMovieDetailWithSuccess() {
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let mockMovie =  MovieDetailResponse(title: "Mock Movie", releaseDate: "2025-01-01", rating: 7.5, posterUrl: "/test.jpg", overview: "Description")
        
        mockAPIService.mockMovieDetailsResult = .success(mockMovie)
        
        sut.getMovieDetail(for: 1) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(response.title, "Mock Movie")
                XCTAssertEqual(response.rating, 7.5)
                expectation.fulfill()
            case .failure:
                XCTFail("Expected success, but got failure")
            }
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testGetMovieDetailWithFailure() {
        let expectation = XCTestExpectation(description: "Wait for data to load")
        
        let error = NSError(domain: "NetworkError", code: 500, userInfo: nil)
        mockAPIService.mockMovieListResult = .failure(error)
        
        sut.getMovieDetail(for: 1) { result in
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

