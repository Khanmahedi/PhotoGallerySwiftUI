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
    @State private var isLoaded: Bool = false
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .opacity(isLoaded ? 1 : 0)         
                    .animation(.easeIn(duration: 0.3), value: isLoaded)
                    .onAppear { isLoaded = true }
            } else {
                ProgressView()
            }
        }
        .frame(height: 150.scaleRespectToHeight())
        .clipped()
        .onAppear {
            if let url = url{
                loader.load(url: url)
            }
        }
        .onDisappear { loader.cancel() }
    }
}

