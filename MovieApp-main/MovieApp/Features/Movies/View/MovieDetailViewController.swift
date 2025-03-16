//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieImageContainterView: UIView!
    @IBOutlet weak var titleHeadingLabel: UILabel!
    @IBOutlet weak var titleValueLabel: UILabel!
    @IBOutlet weak var releaseDateHeadingLabel: UILabel!
    @IBOutlet weak var releaseDateValueLabel: UILabel!
    @IBOutlet weak var ratingHeadingLabel: UILabel!
    @IBOutlet weak var ratingValueLabel: UILabel!
    @IBOutlet weak var overviewHeadingLabel: UILabel!
    @IBOutlet weak var overviewValueLabel: UILabel!
    
    private enum Constants {
        static let movieImageViewTag = 1
    }
    
    var id: Int!
    
    private lazy var viewModel: MovieDetailViewModel = MovieDetailViewModel(delegate: self, movieId: id)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Movie Detail"
        viewModel.onLoad()
    }
}

extension MovieDetailViewController: MovieDetailViewDelegate {
  
    func showMovieDetail(_ movieDetail: MovieDetailUIModel) {
        titleValueLabel.text = movieDetail.title
        releaseDateValueLabel.text = movieDetail.releaseDate
        ratingValueLabel.attributedText = movieDetail.rating
        overviewValueLabel.text = movieDetail.overview
        movieImageContainterView.replaceAndAdd(
            view: MovieRemoteImageView(imagePath: movieDetail.imageUrl, contentMode: .fill),
            tag: Constants.movieImageViewTag
        )
    }
}
