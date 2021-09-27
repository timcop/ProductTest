//
//  ContentView.swift
//  ProductTest
//
//  Created by Tim Copland on 22/09/21.
//

import SwiftUI

struct ContentView: View {

    var productsModel = ProductsModel()
    @State private var products = [Product]()
    @State private var searchText: String = ""
    var body: some View {
        NavigationView {
            VStack {
                Text("Home Screen").font(.largeTitle)
                HStack {
                    NavigationLink(destination: AddRecipeView()) {
                        Text("Add a recipe!").padding()            Spacer()

                    }
                    Spacer()
                    NavigationLink(destination: RecipesView()) {
                        Text("View Recipes").padding()
                    }
                }
                Spacer()
            }
        }
    }
}

                
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environmentObject(Recipe())
            ContentView()
                .environmentObject(Recipe())
        }
    }
}
