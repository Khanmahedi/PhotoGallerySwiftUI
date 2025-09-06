//
//  ContentView.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PhotoViewModel()
    
    let columns = [
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            Group {
                if !viewModel.photos.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 10.scaleRespectToHeight()) {
                            ForEach(viewModel.photos) { photo in
                                NavigationLink(destination: PhotoDetailView(photo: photo)) {
                                AsyncImageView(url: URL(string: photo.download_url) ?? nil)
                                }
                            }
                        }
                        .padding()
                    }
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    ProgressView("Loading photos...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .navigationTitle("Photo Gallery")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color.purple.opacity(0.8), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .foregroundColor(.white)
        }
        .onAppear {
            viewModel.loadPhotos()
        }
    }
}


#Preview {
    ContentView()
}
