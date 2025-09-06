# PhotoGallerySwiftUI
## Overview
A SwiftUI iOS app that fetches and displays photos from the Picsum API.
- Photos are shown in a list.
- Tap a photo to view full-screen with pinch-to-zoom.
- Uses Combine for network calls and @Published for UI updates.

## Features
- **Grid View**: Display photos in a responsive LazyVGrid.  
- **Full-Screen Viewer**:
  - Pinch-to-zoom
  - Drag to move image
  - Double-tap to reset scale
- **Networking**: Uses `URLSession` and `Combine` to fetch photos.  
- **Image Caching**: `NSCache` stores images in memory for smooth 
scrolling and reduced network calls.  
- **Save & Share**: Save photos as JPEG to the gallery or share using the 
iOS share sheet.  
- **Custom Navigation Bar**: Styled with a title and menu options for 
save/share actions.  
- **Smooth Scrolling**: Background image decoding prevents janky scrolling 
when images load.


## Installation
## Installation

1. Clone the repository:  
```bash
git clone https://github.com/KhanMahedi/PhotoGallerySwiftUI.git



