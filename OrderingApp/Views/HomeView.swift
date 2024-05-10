//
//  HomeView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var modelData = ModelData()
    @State private var showDetail = false
    @State private var selectProduct: Product?
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Hot Drinks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                ) {
                    ForEach(modelData.products.filter { $0.category == "Hot" }) { product in
                        ProductListCell(product: product)
                            .onTapGesture {
                                selectProduct = product
                                showDetail = true
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
                                showDetail = true
                            }
                    }
                }
            }
            .navigationTitle("Drinks")
            .listStyle(.plain)
            .sheet(isPresented: $showDetail) {
                if let selectProduct = selectProduct {
                    ProductDetailView(product: selectProduct, isPresented: $showDetail, sizes: selectProduct.size, milkOptions: selectProduct.milk, addons: selectProduct.addons)
                }
            }
        }
    }
    
    func getProducts() {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
            .environmentObject(Cart())
    }
}
