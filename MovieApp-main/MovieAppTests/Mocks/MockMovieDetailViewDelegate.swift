//
//  MockMovieDetailViewDelegate.swift
//  MovieAppTests
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation
import Testing
@testable import MovieApp

final class MockMovieDetailViewDelegate: MovieDetailViewDelegate {
    var didShowLoadingIndicator = false
    var didHideLoadingIndicator = false
    var didShowError = false
    var didShowMovieDetail = false
    var capturedRetryClosure: (() -> Void)?
    var capturedMovieDetail: MovieDetailUIModel?

    func showLoadingIndicator() {
        didShowLoadingIndicator = true
    }

    func hideLoadingIndicator() {
        didHideLoadingIndicator = true
    }

    func showError(onRetry: @escaping () -> Void) {
        didShowError = true
        capturedRetryClosure = onRetry
    }

    func showMovieDetail(_ movieDetail: MovieDetailUIModel) {
        didShowMovieDetail = true
        capturedMovieDetail = movieDetail
    }

    func reset() {
        didShowLoadingIndicator = false
        didHideLoadingIndicator = false
        didShowError = false
        didShowMovieDetail = false
        capturedRetryClosure = nil
        capturedMovieDetail = nil
    }
}
