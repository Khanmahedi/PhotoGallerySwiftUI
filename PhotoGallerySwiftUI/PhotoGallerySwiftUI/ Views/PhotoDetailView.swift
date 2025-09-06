
//  PhotoDetailView.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//

import SwiftUI

struct PhotoDetailView: View {
    let photo: Photo
    @StateObject private var shareLoader = ShareImageLoader()
    
    @State private var scale: CGFloat = 1.0
    @State private var lastScale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastOffset: CGSize = .zero
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        GeometryReader { proxy in
            AsyncImage(url: URL(string: photo.download_url)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: proxy.size.width, height: proxy.size.height)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: proxy.size.width, maxHeight: proxy.size.height)
                        .scaleEffect(scale)
                        .offset(offset)
                        .gesture(
                            SimultaneousGesture(
                                MagnificationGesture()
                                    .onChanged { value in
                                        let newScale = lastScale * value
                                        scale = min(max(newScale, 1.0), 5.0)
                                    }
                                    .onEnded { _ in
                                        lastScale = scale
                                    },
                                DragGesture()
                                    .onChanged { value in
                                        offset = CGSize(width: lastOffset.width + value.translation.width,
                                                        height: lastOffset.height + value.translation.height)
                                    }
                                    .onEnded { _ in
                                        lastOffset = offset
                                    }
                            )
                        )
                        .gesture(
                            TapGesture(count: 2)
                                .onEnded {
                                    withAnimation {
                                        scale = 1.0
                                        lastScale = 1.0
                                        offset = .zero
                                        lastOffset = .zero
                                    }
                                }
                        )
                        .onAppear {
                            if let url = URL(string: photo.download_url) {
                                shareLoader.load(from: url)
                            }
                        }
                        .onDisappear {
                            shareLoader.cancel()
                        }
                case .failure(_):
                    Color.gray.frame(width: proxy.size.width, height: proxy.size.height)
                @unknown default:
                    EmptyView()
                }
            }
            .background(Color.black.ignoresSafeArea())
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(photo.author)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Menu {
                    Button("💾 Save as JPEG") {
                        saveImage()
                    }
                    Button("📤 Share") {
                        if let image = shareLoader.image {
                            shareImage(image: image)
                        }
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
    
    private func saveImage() {
        guard let image = shareLoader.image else {
            alertMessage = "No image to save"
            showAlert = true
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        alertMessage = "Saved to Photos"
        showAlert = true
    }
    
    private func shareImage(image: UIImage) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootVC = windowScene.windows.first?.rootViewController else { return }
        
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        rootVC.present(activityVC, animated: true)
    }
}


struct PhotoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoDetailView(photo: Photo(id: "0", download_url: "https://picsum.photos/400/400", author: "Author"))
    }
}


