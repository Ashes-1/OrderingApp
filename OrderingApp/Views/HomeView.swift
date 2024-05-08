//
//  HomeView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var modelData = ModelData()
    
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
                    }
                }
                Section(header: Text("Cold Drinks")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                ) {
                    ForEach(modelData.products.filter { $0.category == "Cold" }) { product in
                        ProductListCell(product: product)
                    }
                }
            }
            .navigationTitle("Drinks")
        }
    }
    
    func getProducts() {
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(ModelData())
    }
}
