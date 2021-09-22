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
            List(products) {prod in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(prod.name.capitalized)
                            .font(.headline).bold().italic()

                        HStack {
                            if (prod.priceDetails.isSpecial) {
                                Text("$\(prod.priceDetails.originalPrice, specifier: "%.2f")").strikethrough()
                                Text("$\(prod.priceDetails.salePrice, specifier: "%.2f")").foregroundColor(.red)
                            } else {
                                Text("$\(prod.priceDetails.originalPrice, specifier: "%.2f")")
                            }
                            
                        }
                    }
                    Spacer()
                    AsyncImageHack(url: URL(string: prod.img.imageURL)) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .interpolation(.none)
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        case .failure:
                            ProgressView()
                        @unknown default:
                            EmptyView()
                        }
                    }
                }.contentShape(Rectangle())
                .onTapGesture {
                    // NAVIGATE TO NEW VIEW FROM HERE
                    print(prod.name)
                    // SEND THE PRODUCT DETAIL 
                }
                
            }
            .navigationTitle("Products")
        }
        .searchable(text: $searchText)
        .onChange(of: searchText) { value in
            async {
                if !value.isEmpty {
                products = try! await productsModel.getProducts(searchTerm: value)
                } else {
                    products = []
                }
            }
        }
    }
}

struct AsyncImageHack<Content> : View where Content : View {

    let url: URL?
    @ViewBuilder let content: (AsyncImagePhase) -> Content

    @State private var currentUrl: URL?
    
    var body: some View {
        AsyncImage(url: currentUrl, content: content)
        .onAppear {
            if currentUrl == nil {
                DispatchQueue.main.async {
                    currentUrl = url
                }
            }
        }
    }
}
                
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
