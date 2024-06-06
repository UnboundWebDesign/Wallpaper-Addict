//
//  UnsplashService.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-06-05.
//
import Foundation
import Combine
import Alamofire
import UIKit

struct UnsplashImage: Identifiable, Decodable {
    let id: String
    let urls: ImageURLs
    let description: String?
    
    struct ImageURLs: Decodable {
        let raw: String
        let full: String
        let regular: String
        let small: String
        let thumb: String
    }
}

class UnsplashAPI {
    static let shared = UnsplashAPI()
    private let accessKey = "FtLl8GdVj19n86PV5voNjpqNYYezebKZr9aUx5oXgKE"
    private let baseURL = "https://api.unsplash.com"
    private let collectionID = "71584847"

    private init() {}

//    func fetchLatestImages() -> AnyPublisher<[UnsplashImage], Error> {
//            guard let url = URL(string: "\(baseURL)/photos?client_id=\(accessKey)") else {
//                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
//            }
//            
//            return URLSession.shared.dataTaskPublisher(for: url)
//                .map { $0.data }
//                .decode(type: [UnsplashImage].self, decoder: JSONDecoder())
//                .eraseToAnyPublisher()
//        }
//    
    func fetchLatestImages() -> AnyPublisher<[UnsplashImage], Error> {
        guard let url = URL(string: "\(baseURL)/collections/71584847/photos?client_id=\(accessKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [UnsplashImage].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
  
    func searchPhotos(query: String) -> AnyPublisher<[UnsplashImage], Error> {
            guard let url = URL(string: "\(baseURL)/search/photos?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&client_id=\(accessKey)") else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .map { $0.data }
                .decode(type: UnsplashSearchResponse.self, decoder: JSONDecoder())
                .map { $0.results }
                .eraseToAnyPublisher()
        }
    
    func downloadImage(from urlString: String) -> AnyPublisher<UIImage, Error> {
            guard let url = URL(string: urlString) else {
                return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
            }
            
            return URLSession.shared.dataTaskPublisher(for: url)
                .tryMap { data, response -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return data
                }
                .tryMap { data in
                    guard let image = UIImage(data: data) else {
                        throw URLError(.cannotDecodeContentData)
                    }
                    return image
                }
                .eraseToAnyPublisher()
        }
}
