//
//  CartView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct CartView: View {
//    @ObservedObject var modelData = ModelData()
//    @State private var orderItems = []
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(cart.items) { product in
                            ProductListCell(product: product)
                        }
                        .onDelete(perform: cart.delete)
                    }
                    .listStyle(.plain)
                    
                    Button {
                        print("order placed")
                    } label: {
                        Text("$99.99 - Place Order")
//                        Text("$\(totalPrice, specifier: "%.2f") - Place Order")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color("brandColor"))
                            .multilineTextAlignment(.center)
                            .cornerRadius(16)
                    }
                    .padding(.bottom, 20)
                }
                if cart.items.isEmpty {
                    EmptyView(imageName: "emptycarticon", message: "There are no drinks in your cart!")
                }
            }
            .navigationTitle("Cart  🛒")
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(Cart())
    }
}
