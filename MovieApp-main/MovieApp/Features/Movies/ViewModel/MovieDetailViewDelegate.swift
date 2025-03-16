//
//  MovieDetailViewDelegate.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO on 2025-03-16.
//

import Foundation

protocol MovieDetailViewDelegate: BaseViewDelegate {
    func showMovieDetail(_ movieDetail: MovieDetailUIModel)
}

struct MovieDetailUIModel {
    let title: String
    let releaseDate: String
    let rating: NSAttributedString
    let overview: String
    let imageUrl: String
}
