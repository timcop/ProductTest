//
//  AddRecipeView.swift
//  ProductTest
//
//  Created by Tim Copland on 23/09/21.
//

import SwiftUI

enum Unit: String, CaseIterable, Identifiable {
    case each
    case g
    case kg
    case ml
    case l
    case handfull
    case bunch
    
    var id: String {self.rawValue}
}

struct Ingredient: Identifiable {
//    let unitOptions = ["each", "g", "kg", "ml", "L", "handfull", "bunch"]
    var id = UUID()
    var name:String = ""
    var unit: Unit = .each
    var quantity:String = ""
    var product: Product?
    
}
                
class Recipe: ObservableObject {
    @Published var products: [Product] = []
    @Published var method: [Steps] = []
    @Published var ingredients: [Ingredient] = []
}

struct Steps {
    var step: String = ""
}

struct AddRecipeView: View {
    @ObservedObject var currentRecipe: Recipe = Recipe()
//    @State var newIngredient:Ingredient = Ingredient()
    var body: some View {
    
        VStack {
            Text("Add Recipe").font(.largeTitle)
            NavigationLink(destination: AddIngredientView(ingredients: $currentRecipe.ingredients)) {
                Text("Add an ingredient")
                    .padding(.all)
            }
            List(currentRecipe.ingredients) { ing in
                VStack {
                    HStack {
                        Text(ing.name).font(.title3).bold().italic()
                        Spacer()
                    }
                    HStack {
                        Text("Quantity: " + ing.quantity).font(.body)
                        Text("Unit: " + ing.unit.rawValue).font(.body)
                        Spacer()
                    }
                    if let prod = ing.product {
                        Text(prod.name)
                    }
                }
                
            }
            List(self.currentRecipe.products) {item in
                Text(item.name)
            }
            Spacer()
        }
    }
}


struct AddRecipeView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecipeView()
    }
}
