//
//  LatestImagesView.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-06-05.
//
import SwiftUI

struct LatestImagesView: View {
    @StateObject private var viewModel = ImageViewModel()
    @State private var image: UIImage? = nil
    @State private var isImagePickerPresented = false
    @State private var searchText = ""

  

    var body: some View {
        VStack() {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
                    .padding()
            } 

            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
                    .padding()
            }

            HStack(spacing: 5) {
                TextField("Search Photos", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button("Search") {
                    viewModel.searchPhotos(query: searchText)
                }
                .padding()
            }

            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    if !viewModel.searchResults.isEmpty {
                        ForEach(viewModel.searchResults) { img in
                            if let url = URL(string: img.urls.small) {
                                AsyncImage(url: url)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300, height: 300)
                                    .padding()
                            }
                        }
                    } else {
                        ForEach(viewModel.latestImages) { img in
                            if let url = URL(string: img.urls.small) {
                                AsyncImage(url: url)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 300)
                                    .padding()
                                
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $image)
        }
        .padding()
        .onAppear {
            viewModel.fetchLatestImages()
        }
    }
}

struct LatestImagesView_Previews: PreviewProvider {
    static var previews: some View {
        LatestImagesView()
    }
}
