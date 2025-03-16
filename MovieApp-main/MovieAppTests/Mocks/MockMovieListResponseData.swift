//
//  MockMovieListResponseData.swift
//  MovieAppTests
//
//  Created by Idris Jovial SOP NWABO.
//

@testable import MovieApp

enum MockMovieListResponseData {
    
    static func generate() -> MovieListResponse {
        
        let result = Movie(
            id: 1,
            title: "Moana 2",
            overview: "Description",
            releaseDate: "2024-11-21",
            posterUrl: "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
            rating: 8.71
        )
        
        let result2 = Movie(
            id: 2,
            title: "Kraven the Hunter",
            overview: "Description",
            releaseDate: "2024-12-21",
            posterUrl: "/aLVkiINlIeCkcZIzb7XHzPYgO6L.jpg",
            rating: 8.74
        )
        
        return MovieListResponse(
            results: [
                result,
                result2
            ]
        )
    }
}
