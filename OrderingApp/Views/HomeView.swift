//
//  HomeView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var modelData = ModelData()
    @State private var selectProduct: Product?
    
    var body: some View {
        NavigationView {
            List { //divide two sections for category 'hot' or 'cold' drinks
                Section(header: Text("Hot Drinks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                ) {
                    ForEach(modelData.products.filter { $0.category == "Hot" }) { product in
                        ProductListCell(product: product)
                            .onTapGesture { //when tap on product it selects it
                                selectProduct = product
                            }
                    }
                }
                Section(header: Text("Cold Drinks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                ) {
                    ForEach(modelData.products.filter { $0.category == "Cold" }) { product in
                        ProductListCell(product: product)
                            .onTapGesture {
                                selectProduct = product
                            }
                    }
                }
            }
            .navigationTitle("Drinks")
            .listStyle(.plain)
            //sheet view shows details when product is selected
            .sheet(item: $selectProduct) { product in
                ProductDetailView(product: product, sizes: product.size, milkOptions: product.milk, addons: product.addons)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
            .environmentObject(Cart())
    }
}
