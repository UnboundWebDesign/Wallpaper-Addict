//
//  ImageUploadViewModel.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-05-30.
//

import Foundation
import Combine
import UIKit

class ImageUploadViewModel: ObservableObject {
    private var cancellables = Set<AnyCancellable>()

    func uploadImage(image: UIImage, title: String, description: String) {
        NetworkService.shared.uploadImage(image: image, title: title, description: description)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("Upload successful")
                case .failure(let error):
                    print("Upload failed with error: \(error)")
                }
            }, receiveValue: { _ in
                // Handle success
            })
            .store(in: &cancellables)
    }
}
