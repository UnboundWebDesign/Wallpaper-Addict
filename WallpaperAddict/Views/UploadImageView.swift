//
//  UploadImageView.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-05-30.
//

import Foundation
import SwiftUI
import PhotosUI

struct UploadImageView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    @State private var imageTitle: String = ""
    @State private var imageDescription: String = ""
    @ObservedObject var viewModel = ImageUploadViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 300)
                        .padding()
                }

                PhotosPicker(selection: $selectedItem, matching: .images) {
                    Text("Upload an Image")
                }
                .onChange(of: selectedItem) { newItem in
                    Task {
                        if let data = try? await newItem?.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            selectedImage = image
                        }
                    }
                }

                TextField("Title", text: $imageTitle)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Description", text: $imageDescription)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    if let image = selectedImage {
                        viewModel.uploadImage(image: image, title: imageTitle, description: imageDescription)
                    }
                }) {
                    Text("Upload Image")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Spacer()
            }
            .navigationTitle("Upload Image")
        }
    }
}
