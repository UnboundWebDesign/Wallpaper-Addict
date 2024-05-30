//
//  Wallpaper_AddictApp.swift
//  Wallpaper Addict
//
//  Created by Jason Shannon on 2024-05-30.
//

import SwiftUI

@main
struct Wallpaper_AddictApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }

                CategoriesView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Categories")
                    }
                
                UploadImageView()
                                   .tabItem {
                                       Image(systemName: "square.and.arrow.up")
                                       Text("Upload")
                                   }
            }
        }
    }
}
