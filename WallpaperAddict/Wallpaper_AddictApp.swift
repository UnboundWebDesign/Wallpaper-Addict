//
//  Wallpaper_AddictApp.swift
//  Wallpaper Addict
//
//  Created by Jason Shannon on 2024-05-30.
//
import SwiftUI

@main
struct WallpaperAppApp: App {
    @StateObject private var colorSchemeViewModel = ColorSchemeViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(colorSchemeViewModel)
                .preferredColorScheme(colorSchemeViewModel.colorScheme)
        }
    }
}
