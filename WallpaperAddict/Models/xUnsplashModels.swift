//
//  UnsplashModels.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-06-05.
//

import Foundation

struct UnsplashPhoto: Codable {
    let id: String
    let width: Int
    let height: Int
    let color: String?
    let blurHash: String?
    let description: String?
    let altDescription: String?
    let urls: Urls
    let links: Links
    let user: User
}

struct Urls: Codable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
}

struct Links: Codable {
    let html: String
}

struct User: Codable {
    let name: String
    let links: UserLinks
}

struct UserLinks: Codable {
    let html: String
}
