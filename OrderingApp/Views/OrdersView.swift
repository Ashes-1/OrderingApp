//
//  OrdersView.swift
//  OrderingApp
//
//  Created by Rosa Long on 8/5/2024.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var ordersViewModel: OrdersViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ordersViewModel.orders) { order in
                    VStack {
                        //every order shown will have these details listed below
                        Text("Date: \(order.date, style: .date)")
                            .padding(.bottom)
                        if (order.itemTotal > 1) {
                            Text("\(order.itemTotal) items  ·  $\(order.totalPrice, specifier: "%.2f")")
                        }
                        else {
                            Text("\(order.itemTotal) item  ·  $\(order.totalPrice, specifier: "%.2f")")
                        }
                        Text("Completed")
                    }
                }
                if ordersViewModel.orders.isEmpty {
                    EmptyView(imageName: "", message: "You have no past orders.")
                }
            }
            .navigationTitle("Order History")
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
            .environmentObject(OrdersViewModel())
    }
}
