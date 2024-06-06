//
//  ImageDetailView.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-05-30.
//
import SwiftUI

struct ImageDetailView: View {
    let photo: UnsplashImage

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: photo.urls.full)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .padding()

//            Button(action: {
//                downloadImage()
//            }) {
//                Text("Download")
//                    .padding()
//                    .background(Color.blue)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
        }
//        .navigationTitle(photo.description)
    }

}
