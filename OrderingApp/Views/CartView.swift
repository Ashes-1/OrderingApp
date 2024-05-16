//
//  CartView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    @EnvironmentObject var accountViewModel: AccountViewModel
    @State private var alert: AlertItem?

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        ForEach(cart.items) { item in
                            ProductListCell(product: item.product) // Each cart item displayed in cell
                        }
                        .onDelete(perform: cart.delete)
                    }
                    .listStyle(.plain)

                    Button { // Adds order to order history
                        let order = Order(items: cart.items, date: Date(), totalPrice: cart.totalPrice)
                        ordersViewModel.addOrder(order)
                        cart.placeOrder()
                        alert = AlertContext.orderPlaced
                    } label: {
                        Text("$\(cart.totalPrice, specifier: "%.2f") - Place Order")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color("brandColor"))
                            .multilineTextAlignment(.center)
                            .cornerRadius(16)
                    }
                    .alert(item: $alert) { alert in
                        Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissBtn)
                    }
                    .padding(.bottom, 20)
                }
                .onChange(of: accountViewModel.isLoggedIn) { isLoggedIn in
                    if !isLoggedIn { // If user isn't logged in it clears their order history
                        ordersViewModel.clearOrders()
                    } else {
                        ordersViewModel.loadUserOrders() // Load orders into the OrdersViewModel order array
                    }
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
            .environmentObject(OrdersViewModel())
            .environmentObject(AccountViewModel(ordersViewModel: OrdersViewModel()))
    }
}
