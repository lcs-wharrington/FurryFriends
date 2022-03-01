//
//  RemoteImageView.swift
//  FurryFriends
//
//  Created by William Robert Harrington on 2022-03-01.
//

import SwiftUI

struct RemoteImageView: View {
    
    // MARK: Stored properties
    let fromURL: URL
    
    // MARK: Computed properties
    var body: some View {
        
        // Retrieves and displays a remote image, showing a placeholder until the image has loaded
        AsyncImage(url: fromURL,
                   content: { downloadedImage in
            downloadedImage
                .resizable()
                .scaledToFit()
        },
                   placeholder: {
            ProgressView()
        })

    }
    
}

struct RemoteImageView_Previews: PreviewProvider {
    
    // Uses a website that provides a different 640x360 image each time the address is loaded
    static let example = URL(string: "https://picsum.photos/640/360")!
    
    static var previews: some View {
        RemoteImageView(fromURL: example)
    }
}
