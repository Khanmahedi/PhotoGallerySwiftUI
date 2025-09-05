//
//  PhotoViewModel.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//

import Foundation
import Combine

class PhotoViewModel : ObservableObject{
    @Published var photos: [Photo] = []
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadPhotos() {
          APIService.shared.fetchPhotos()
              .sink { completion in
                  switch completion {
                  case .failure(let error):
                      self.errorMessage = error.localizedDescription
                  case .finished:
                      break
                  }
              } receiveValue: { photos in
                  self.photos = photos
              }
              .store(in: &cancellables)
      }
}
