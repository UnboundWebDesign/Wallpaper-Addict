//
//  CategoriesViewModel.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-06-05.
//

import Foundation

class CategoriesViewModel: ObservableObject {
    @Published var categories: [ImageCategory] = [
        ImageCategory(name: "Nature", query: "nature"),
        ImageCategory(name: "Technology", query: "technology"),
        ImageCategory(name: "People", query: "people"),
        ImageCategory(name: "Architecture", query: "architecture"),
        ImageCategory(name: "Animals", query: "animals"),
        ImageCategory(name: "Travel", query: "travel")
    ]
}
