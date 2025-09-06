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
    
    let session: URLSession
     
    private init() {
        let config = URLSessionConfiguration.default
        config.urlCache = URLCache.shared
        config.requestCachePolicy = .returnCacheDataElseLoad
        self.session = URLSession(configuration: config)
    }
    
    func fetchPhotos() -> AnyPublisher<[Photo], Error> {
        // Construct URL dynamically based on BASE_URL
        let val = API.baseURL
        guard let url = URL(string: "\(API.baseURL)/v2/list?page=1&limit=30") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Photo].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}



