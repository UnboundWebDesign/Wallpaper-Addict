import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var colorSchemeViewModel: ColorSchemeViewModel

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchQuery)
                NavigationLink(destination: CategoriesView()) {
                    Text("View Categories")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
           
        }
        
    }
//    n
//    var body: some View {
//            NavigationView {
//                TabView {
//                    HomeView()
//                        .tabItem {
//                            Image(systemName: "house")
//                            Text("Home")
//                        }
//
//                        .tabItem {
//                            Image(systemName: "list.bullet")
//                            Text("Categories")
//                        }
//
//                }
//                .navigationTitle("Wallpaper App")
//                .toolbar {
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        Button(action: {
//                            colorSchemeViewModel.toggleColorScheme()
//                        }) {
//                            Image(systemName: colorSchemeViewModel.colorScheme == .light ? "moon.fill" : "sun.max.fill")
//                        }
//                    }
//                }
//            }
//        }
}
