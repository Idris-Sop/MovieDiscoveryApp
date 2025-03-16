//
//  MovieRemoteImageView.swift
//  MovieApp
//
//  Created by Idris Jovial SOP NWABO.
//

import SwiftUI
import UIKit

struct MovieRemoteImageView: View {
    
    let imagePath: String
    let contentMode: ContentMode
    
    init(
        imagePath: String,
        contentMode: ContentMode = .fit) {
        self.imagePath = imagePath
        self.contentMode = contentMode
    }

    var body: some View {
        AsyncImage(url: URL(string: APIConstants.imageBaseURL + imagePath)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: contentMode)

        } placeholder: {
            Color.gray
        }
    }
}
