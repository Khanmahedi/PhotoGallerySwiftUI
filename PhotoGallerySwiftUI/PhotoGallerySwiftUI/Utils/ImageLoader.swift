//
//  ImageLoader.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    private var cancellable: AnyCancellable?
    
    func load(url: URL) {
        if let cached = ImageCache.shared.get(forKey: url.absoluteString) {
            self.image = cached
            return
        }
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .handleEvents(receiveOutput: { img in
                if let img = img {
                    ImageCache.shared.set(img, forKey: url.absoluteString)
                }
            })
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}

class ImageCache {
    static let shared = ImageCache()
    private init() {}
    private var cache: [String: UIImage] = [:]
    
    func get(forKey key: String) -> UIImage? {
        cache[key]
    }
    
    func set(_ image: UIImage, forKey key: String) {
        cache[key] = image
    }
}

