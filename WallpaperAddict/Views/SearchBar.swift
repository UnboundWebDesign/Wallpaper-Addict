//
//  SearchBar.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-06-05.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String

        init(text: Binding<String>) {
            _text = text
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search Wallpapers"
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
}

