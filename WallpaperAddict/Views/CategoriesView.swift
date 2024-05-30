import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel = ImageViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.categories) { category in
                NavigationLink(destination: CategoryImagesView(categoryId: category.id, categoryName: category.name)) {
                    Text(category.name)
                }
            }
            .navigationTitle("Categories")
            .onAppear {
                viewModel.fetchCategories()
            }
        }
    }
}
