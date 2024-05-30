import Foundation
import Combine
import SwiftUI

class NetworkService {
    static let shared = NetworkService()
    private let baseURL = "https://your-backend-url.com/api"
    
    private init() {}

    func fetchLatestImages() -> AnyPublisher<[WallpaperImage], Error> {
        let url = URL(string: "\(baseURL)/images/latest")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [WallpaperImage].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func searchImages(query: String) -> AnyPublisher<[WallpaperImage], Error> {
        let url = URL(string: "\(baseURL)/images/search?q=\(query)")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [WallpaperImage].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchCategories() -> AnyPublisher<[Category], Error> {
        let url = URL(string: "\(baseURL)/categories")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Category].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func fetchImages(for categoryId: String) -> AnyPublisher<[WallpaperImage], Error> {
        let url = URL(string: "\(baseURL)/categories/\(categoryId)/images")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [WallpaperImage].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func uploadImage(image: UIImage, title: String, description: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/images/upload")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let imageData = image.jpegData(compressionQuality: 0.8)!
        var body = Data()
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"title\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(title)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"description\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(description)\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(UUID().uuidString).jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { result -> Void in
                guard let httpResponse = result.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return ()
            }
            .eraseToAnyPublisher()
    }
}
