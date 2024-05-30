//
//  CategoryImagesView.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-05-30.
//

import Foundation
import SwiftUI

struct CategoryImagesView: View {
    @ObservedObject var viewModel = ImageViewModel()
    let categoryId: String
    let categoryName: String

    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                ForEach(viewModel.categoryImages) { image in
                    NavigationLink(destination: ImageDetailView(image: image)) {
                        AsyncImage(url: URL(string: image.url))
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                    }
                }
            }
            .padding()
        }
        .navigationTitle(categoryName)
        .onAppear {
            viewModel.fetchImages(for: categoryId)
        }
    }
}
