//
//  Movie.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let overview: String
    let releaseDate: String
    let posterUrl: String?
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case releaseDate = "release_date"
        case posterUrl = "poster_path"
        case rating = "vote_average"
    }
}
