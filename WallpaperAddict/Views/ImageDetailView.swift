//
//  ImageDetailView.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-05-30.
//

import Foundation
import SwiftUI

struct ImageDetailView: View {
    let image: WallpaperImage

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: image.url))
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: {
                // Implement download functionality
            }) {
                Text("Download")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle(image.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
