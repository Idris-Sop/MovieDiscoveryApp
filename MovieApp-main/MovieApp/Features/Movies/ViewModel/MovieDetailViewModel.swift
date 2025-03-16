//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation

final class MovieDetailViewModel {

    private let movieRepository: MovieRepository
    
    private weak var delegate: MovieDetailViewDelegate?
    private let movieId: Int
    
    init(delegate: MovieDetailViewDelegate?, movieId: Int,
         movieRepository: MovieRepository = DependencyContainer.movieRepository) {
        self.delegate = delegate
        self.movieId = movieId
        self.movieRepository = movieRepository
    }
    
    func onLoad() {
        self.delegate?.showLoadingIndicator()
        self.movieRepository.getMovieDetail(for: movieId) { result in
            self.delegate?.hideLoadingIndicator()
            switch result {
                case .success(let movieDetailResponse):
                    self.delegate?.showMovieDetail(
                        MovieDetailUIModel(
                            title: movieDetailResponse.title,
                            releaseDate: movieDetailResponse.releaseDate.formatMovieReleaseDate(),
                            rating: movieDetailResponse.rating.formatMovieRating(),
                            overview: movieDetailResponse.overview,
                            imageUrl: movieDetailResponse.posterUrl
                        )
                    )
                case .failure(let error):
                    self.delegate?.showError(onRetry: {
                        self.onLoad()
                    })
            }
        }
    }
}
