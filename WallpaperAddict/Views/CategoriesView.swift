import SwiftUI

struct CategoriesView: View {
    var body: some View {
        NavigationView {
            List {
                Text("Category 1")
                Text("Category 2")
                Text("Category 3")
            }
            .navigationTitle("Categories")
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView()
    }
}
