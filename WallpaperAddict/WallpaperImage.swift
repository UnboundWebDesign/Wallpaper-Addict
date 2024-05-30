//
//  Image.swift
//  Wallpaper Addict
//
//  Created by Jason Shannon on 2024-05-30.
//
import Foundation

struct WallpaperImage: Identifiable, Codable {
    let id: String
    let url: String
    let title: String
    let description: String
    let categoryId: String
    let createdAt: Date
}
