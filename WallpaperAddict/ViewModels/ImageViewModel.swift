//
//  ImageViewModel.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-06-05.
//
import Foundation
import Combine

class ImageViewModel: ObservableObject {
    @Published var latestImages: [UnsplashImage] = []
    @Published var searchResults: [UnsplashImage] = []
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchLatestImages()
    }

    func fetchLatestImages() {
        UnsplashAPI.shared.fetchLatestImages()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { (images: [UnsplashImage]) in
                self.latestImages = images
            })
            .store(in: &cancellables)
    }
    
    func searchPhotos(query: String) {
        UnsplashAPI.shared.searchPhotos(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { (completion: Subscribers.Completion<Error>) in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { (images: [UnsplashImage]) in
                self.searchResults = images
            })
            .store(in: &cancellables)
    }
}
