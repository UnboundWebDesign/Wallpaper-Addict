import Foundation
import Combine

class ImageViewModel: ObservableObject {
    @Published var latestImages: [WallpaperImage] = []
    @Published var searchResults: [WallpaperImage] = []
    @Published var categories: [Category] = []
    @Published var categoryImages: [WallpaperImage] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadDefaultCategories()
        loadDefaultImages()
    }

    func loadDefaultCategories() {
        categories = [
            Category(id: "1", name: "Nature", description: "Beautiful nature wallpapers"),
            Category(id: "2", name: "Cities", description: "Stunning city landscapes"),
            Category(id: "3", name: "Abstract", description: "Abstract art wallpapers"),
            Category(id: "4", name: "Animals", description: "Cute and wild animal wallpapers"),
            Category(id: "5", name: "Textures", description: "Textured wallpapers")

        ]
    }

    func fetchLatestImages() {
        NetworkService.shared.fetchLatestImages()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { images in
                self.latestImages = images
            })
            .store(in: &cancellables)
    }

    func searchImages(query: String) {
        NetworkService.shared.searchImages(query: query)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { images in
                self.searchResults = images
            })
            .store(in: &cancellables)
    }

    func fetchCategories() {
        NetworkService.shared.fetchCategories()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { categories in
                self.categories += categories
            })
            .store(in: &cancellables)
    }

    func fetchImages(for categoryId: String) {
        NetworkService.shared.fetchImages(for: categoryId)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { images in
                self.categoryImages = images
            })
            .store(in: &cancellables)
    }
    
    func loadDefaultImages() {
        let defaultImages = [
            WallpaperImage(id: "1", url: "https://source.unsplash.com/random/800x600?nature", title: "Nature 1", description: "Beautiful nature wallpaper", categoryId: "1", createdAt: Date()),
            WallpaperImage(id: "2", url: "https://source.unsplash.com/random/800x600?nature,forest", title: "Nature 2", description: "Forest nature wallpaper", categoryId: "1", createdAt: Date()),
            WallpaperImage(id: "3", url: "https://source.unsplash.com/random/800x600?city", title: "City 1", description: "Beautiful city wallpaper", categoryId: "2", createdAt: Date()),
            WallpaperImage(id: "4", url: "https://source.unsplash.com/random/800x600?city,night", title: "City 2", description: "City at night wallpaper", categoryId: "2", createdAt: Date()),
            WallpaperImage(id: "5", url: "https://source.unsplash.com/random/800x600?abstract", title: "Abstract 1", description: "Abstract art wallpaper", categoryId: "3", createdAt: Date()),
            WallpaperImage(id: "6", url: "https://source.unsplash.com/random/800x600?abstract,pattern", title: "Abstract 2", description: "Pattern abstract wallpaper", categoryId: "3", createdAt: Date()),
            WallpaperImage(id: "7", url: "https://source.unsplash.com/random/800x600?animals", title: "Animal 1", description: "Cute animal wallpaper", categoryId: "4", createdAt: Date()),
            WallpaperImage(id: "8", url: "https://source.unsplash.com/random/800x600?animals,wild", title: "Animal 2", description: "Wild animal wallpaper", categoryId: "4", createdAt: Date()),
            WallpaperImage(id: "9", url: "https://source.unsplash.com/random/800x600?textures", title: "Textures", description: "Textured wallpaper", categoryId: "5", createdAt: Date())

        ]
        
        // Group images by category ID
        categoryImages = defaultImages
        latestImages = defaultImages
    }
}

