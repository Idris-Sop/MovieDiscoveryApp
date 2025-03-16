//
//  MovieDetailViewModelTests.swift
//  MovieAppTests
//
//  Created by Idris Jovial SOP NWABO.
//

import XCTest
@testable import MovieApp

final class MovieDetailViewModelTests: XCTestCase {
    
    private var mockRepository: MockMovieRepository!
    private var mockMovieDetailViewDelegate: MockMovieDetailViewDelegate!
    private var serviceUnderTest: MovieDetailViewModel!

    override func setUpWithError() throws {
        super.setUp()
        self.mockRepository = MockMovieRepository()
        self.mockMovieDetailViewDelegate = MockMovieDetailViewDelegate()
        self.serviceUnderTest = MovieDetailViewModel(delegate: mockMovieDetailViewDelegate, movieId: 333, movieRepository: mockRepository)
    }

    override func tearDownWithError() throws {
        serviceUnderTest = nil
        mockRepository = nil
        mockMovieDetailViewDelegate = nil
        super.tearDown()
    }

    func testonLoadWithSuccess() {

        let mockMovie =  MovieDetailResponse(title: "Mock Movie", releaseDate: "2025-01-01", rating: 7.5, posterUrl: "/test.jpg", overview: "Description")
        
        mockRepository.mockMovieDetailsResult = .success(mockMovie)
        
        serviceUnderTest.onLoad()
    
        XCTAssertTrue(mockMovieDetailViewDelegate.didShowLoadingIndicator)
        XCTAssertTrue(mockMovieDetailViewDelegate.didHideLoadingIndicator)
        XCTAssertTrue(mockMovieDetailViewDelegate.didShowMovieDetail)
        XCTAssertFalse(mockMovieDetailViewDelegate.didShowError)
        
        XCTAssertEqual(mockMovieDetailViewDelegate.capturedMovieDetail?.title, "Mock Movie")
        XCTAssertEqual(mockMovieDetailViewDelegate.capturedMovieDetail?.overview, "Description")
        XCTAssertEqual(mockMovieDetailViewDelegate.capturedMovieDetail?.imageUrl, "/test.jpg")
    }
    
    func testonLoadWithFailure() {
        mockRepository.mockMovieDetailsResult = .failure(NSError(domain: "TestError", code: -1, userInfo: nil))
        serviceUnderTest.onLoad()

        XCTAssertTrue(mockMovieDetailViewDelegate.didShowLoadingIndicator)
        XCTAssertTrue(mockMovieDetailViewDelegate.didHideLoadingIndicator)
        XCTAssertTrue(mockMovieDetailViewDelegate.didShowError)
        XCTAssertFalse(mockMovieDetailViewDelegate.didShowMovieDetail)
        XCTAssertNotNil(mockMovieDetailViewDelegate.capturedRetryClosure)
    }

}
