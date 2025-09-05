//
//  CGFloat+Scale.swift
//  PhotoGallerySwiftUI
//
//  Created by Md Mehedi Hasan on 5/9/25.
//

import Foundation
import SwiftUI

extension CGFloat {
    
    func scaleRespectToHeight(referenceHeight: CGFloat = 932) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        return self / referenceHeight * screenHeight
    }
    
    func scaleRespectToWidth(referenceWidth: CGFloat = 430) -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        return self / referenceWidth * screenWidth
    }
}
