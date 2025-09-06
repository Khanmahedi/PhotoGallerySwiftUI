//
//  API.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 6/9/25.
//

import Foundation


enum API {
    static var baseURL: String {
        Bundle.main.infoDictionary?["BASE_URL"] as? String ?? "https://picsum.photos"
    }
}
