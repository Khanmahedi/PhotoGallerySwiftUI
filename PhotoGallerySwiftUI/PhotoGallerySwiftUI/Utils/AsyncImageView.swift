//
//  AsyncImageView.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//

import SwiftUI

struct AsyncImageView: View {
    @StateObject private var loader = ImageLoader()
    let url: URL?
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else {
                ProgressView()
            }
        }
        .frame(height: 150)
        .clipped()
        .onAppear {
            if let url = url{
                loader.load(url: url)
            }
        }
        .onDisappear { loader.cancel() }
    }
}

