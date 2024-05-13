//
//  OrdersViewModel.swift
//  OrderingApp
//
//  Created by Rosa Long on 13/5/2024.
//

import Foundation
import SwiftUI

class OrdersViewModel : ObservableObject {
    @Published var orders: [Order] = []
    @AppStorage("loggedIn") var isLoggedIn = false
    
    func addOrder(_ order: Order) {
        orders.append(order)
    }
    
    func clearOrders() {
        orders.removeAll()
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
