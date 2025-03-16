//
//  MockError.swift
//  MovieAppTests
//
//  Created by Idris Jovial SOP NWABO.
//

import Foundation

enum MockError {
    
    static func genreateError() -> Error {
        return NSError(domain: "MockError", code: 0, userInfo: nil)
    }
}
