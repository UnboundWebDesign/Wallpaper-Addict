//
//  HomeVIew.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-05-30.
//


import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel = ImageViewModel()
    @State private var searchQuery = ""

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Search wallpapers", text: $searchQuery, onCommit: {
                        viewModel.searchImages(query: searchQuery)
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                    Button(action: {
                        viewModel.searchImages(query: searchQuery)
                    }) {
                        Text("Search")
                    }
                    .padding(.trailing)
                }
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                        ForEach(viewModel.latestImages) { image in
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
            }
            .navigationTitle("Latest Wallpapers")
            .onAppear {
                viewModel.fetchLatestImages()
            }
        }
    }
}
