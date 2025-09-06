//
//  ShareImageLoader.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 6/9/25.
//

import Foundation
import UIKit
import Combine

class ShareImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?


    func load(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self) 
    }

    func cancel() {
        cancellable?.cancel()
    }
}

