//
//  ImageLoader.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?
    private static let cache = NSCache<NSURL, UIImage>()
    
    func load(url: URL) {
        // Check cache first
        if let cached = ImageLoader.cache.object(forKey: url as NSURL) {
            self.image = cached
            return
        }
        
        // Download & decode off main thread
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ -> UIImage? in
                // Resize image to cell size to reduce memory load
                if let uiImage = UIImage(data: data) {
                    let size = CGSize(width: 200, height: 200) // your cell size
                    let renderer = UIGraphicsImageRenderer(size: size)
                    return renderer.image { _ in
                        uiImage.draw(in: CGRect(origin: .zero, size: size))
                    }
                }
                return nil
            }
            .subscribe(on: DispatchQueue.global(qos: .userInitiated)) // decode off main thread
            .receive(on: DispatchQueue.main)
            .sink { _ in } receiveValue: { [weak self] image in
                if let image = image {
                    ImageLoader.cache.setObject(image, forKey: url as NSURL)
                    self?.image = image
                }
            }
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

