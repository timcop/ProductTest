//
//  AddRecipeView.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import SwiftUI

class Recipe: ObservableObject {
    @Published var products: [Product] = []
    @Published var method: [Steps] = []
    
}

struct Steps {
    var step: String = ""
}

struct AddRecipeView: View {
    @ObservedObject var currentRecipe: Recipe = Recipe()
    var body: some View {
        VStack {
            List(self.currentRecipe.products) {item in
                Text(item.name)
            }
            Spacer()
            NavigationLink(destination: SearchProductsView(recProds: $currentRecipe.products)) {
                Text("Click me!")
                    .padding(.all)
            }
        }
    }
}


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
