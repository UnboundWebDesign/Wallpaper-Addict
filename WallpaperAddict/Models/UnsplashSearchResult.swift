//
//  UnsplashSearchResult.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-06-05.
//

import Foundation

struct UnsplashSearchResponse: Decodable {
    let total: Int
    let total_pages: Int
    let results: [UnsplashImage]
}
