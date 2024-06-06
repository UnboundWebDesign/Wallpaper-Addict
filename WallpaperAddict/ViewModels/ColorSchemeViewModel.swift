//
//  ColorSchemeViewModel.swift
//  WallpaperAddict
//
//  Created by Jason Shannon on 2024-05-31.
//

import SwiftUI
import Combine

class ColorSchemeViewModel: ObservableObject {
    @Published var colorScheme: ColorScheme = .dark

    func toggleColorScheme() {
        colorScheme = colorScheme == .light ? .dark : .light
    }
}
