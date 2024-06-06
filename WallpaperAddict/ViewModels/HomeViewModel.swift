//
//  HomeViewModel.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-06-05.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var photos: [UnsplashImage] = []
    @Published var searchQuery: String = ""
    @Published var latestImages: [UnsplashImage] = []
    @Published var errorMessage: String?
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchLatestPhotos()

//        $searchQuery
//            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
//            .removeDuplicates()
//            .sink { [weak self] query in
//                self?.searchPhotos(query: query)
//            }
//            .store(in: &cancellables)
    }

    func fetchLatestPhotos() {
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

//    func searchPhotos(query: String) {
//        UnsplashAPI.shared.searchPhotos(query: query)
//            .receive(on: DispatchQueue.main)
//                    .sink(receiveCompletion: { (completion: Subscribers.Completion<Error>) in
//                        switch completion {
//                        case .finished:
//                            break
//                        case .failure(let error):
//                            self.errorMessage = error.localizedDescription
//                        }
//                    }, receiveValue: { (images: [UnsplashImage]) in
//                        self.latestImages = images
//                    })
//                    .store(in: &cancellables)
//        guard !query.isEmpty else {
//            fetchLatestPhotos()
//            return
//        }
//
//    }
}
