//
//  APIService.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//

import Foundation
import Combine

class APIService {
    static let shared = APIService()
    
    func fetchPhotos() -> AnyPublisher<[Photo], Error> {
        guard let url = URL(string: "https://picsum.photos/v2/list?page=1&limit=30") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}


