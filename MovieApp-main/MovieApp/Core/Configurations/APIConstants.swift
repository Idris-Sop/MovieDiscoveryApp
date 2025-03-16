//
//  APIConstants.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation

struct APIConstants {
    static var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
    static var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "baseURL") as? String ?? ""
    }
    static var imageBaseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "imageBaseURL") as? String ?? ""
    }
}

