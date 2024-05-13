//
//  OrdersViewModel.swift
//  OrderingApp
//
//  Created by Rosa Long on 13/5/2024.
//

import Foundation

class OrdersViewModel : ObservableObject {
    @Published var orders: [Order] = []
    
    func addOrder(_ order: Order) {
        orders.append(order)
    }
}

struct Order: Identifiable {
    let id = UUID()
    let items: [CartItem]
    var itemTotal: Int {
        items.count
    }
    let date: Date
    let totalPrice: Double
}
