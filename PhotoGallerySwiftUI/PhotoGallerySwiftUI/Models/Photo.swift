//
//  Photo.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//

import Foundation

struct Photo: Identifiable, Codable {
    let id: String
    let download_url: String
    let author: String
}
