//
//  ContentView.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-05-31.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ImageViewModel()
    @State private var image: UIImage? = nil
    @State private var isImagePickerPresented = false
    
    var body: some View {
        TabView {
            LatestImagesView()
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("Latest Images")
                }

            CategoriesView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Categories")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
